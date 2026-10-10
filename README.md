# Red compartida

Este repositorio crea la red AWS que comparten los proyectos de infraestructura de Jenkins/Vault y del microservicio. Ambos consultan su estado Terraform para obtener la VPC y las subredes privadas, sin crear una red independiente.

La red está en `us-east-1`: una VPC `10.0.0.0/16`, dos subredes privadas y dos públicas repartidas entre `us-east-1a` y `us-east-1b`. Cada subred privada sale a Internet mediante un NAT de su zona; ambas acceden a S3 mediante un endpoint gateway. Las subredes públicas tienen una ruta al Internet Gateway. Ninguna subred asigna IP pública automáticamente.

## Organización

- **`modules/red_base/`**: crea la VPC y las cuatro subredes.
- **`modules/salida_internet/`**: crea el Internet Gateway, los dos NAT con sus IP elásticas y las rutas públicas.
- **`modules/acceso_privado/`**: crea las rutas privadas hacia los NAT y el endpoint S3.
- **`.github/workflows/`**: contiene el pipeline de validación y despliegue; **`.github/recursos-autorizados.json`** delimita los recursos admitidos por el plan.

En la raíz, **`main.tf`** conecta los tres módulos. **`outputs.tf`** publica la VPC y las subredes privadas que consumen los otros proyectos; **`moved.tf`** conserva las referencias de recursos reorganizados. Los demás archivos definen variables, proveedor y versiones.

**`backend.tf`** guarda el estado de red en el bucket creado por `infra-estado-terraform`, bajo `red-compartida/terraform.tfstate`, con cifrado y bloqueo. El estado no se guarda en Git. Los dos NAT y sus IP elásticas generan costos mientras existan.

## Workflow de GitHub Actions

`.github/workflows/terraform.yml` declara **2 jobs y 14 pasos**: `checks` (5) → `deploy` (9); no define stages. Se activa con push a `main`, pull requests hacia `main` o ejecución manual (`workflow_dispatch`). `deploy` espera a que termine correctamente `checks` y solo se ejecuta manualmente sobre `main` con `AWS_DEPLOY_ENABLED=true`. Publicar código no aplica infraestructura. Las ejecuciones se serializan sin cancelar la anterior.

| Job `checks`: paso | Función |
|---|---|
| 1. Checkout | Obtiene el código del repositorio. |
| 2. Setup Terraform | Instala Terraform 1.15.9. |
| 3. `terraform fmt -check -recursive -diff` | Comprueba el formato de la raíz y los módulos sin modificar archivos. |
| 4. `terraform init -backend=false -lockfile=readonly` | Inicializa módulos y proveedores sin configurar el backend ni modificar el lockfile. |
| 5. `terraform validate` | Valida la configuración Terraform. |

| Job `deploy`: paso | Función |
|---|---|
| 1. Checkout | Obtiene el código que se va a desplegar. |
| 2. Setup Terraform | Instala Terraform 1.15.9. |
| 3. Configurar credenciales AWS | Asume el rol de red mediante OIDC con credenciales temporales. |
| 4. Inicializar y validar | Conecta con el backend S3 sin modificar el lockfile y valida la configuración. |
| 5. Planificar y comprobar alcance | Guarda `infra.tfplan` y `plan.log`; exige cubrir la lista de recursos autorizados y solo admite creaciones o recursos sin cambios. |
| 6. Guardar plan privado para revisión | Incluso ante fallo, intenta guardar el plan y su log disponibles como artefacto durante 1 día. |
| 7. Comprobar main antes de aplicar | Verifica que `main` todavía apunta al commit de la ejecución. |
| 8. Aplicar el mismo plan guardado | Aplica automáticamente `infra.tfplan`, registra `apply.log` y añade el resultado al resumen si termina correctamente. |
| 9. Guardar diagnóstico privado de apply | Incluso ante fallo, intenta guardar `apply.log` y `errored.tfstate` disponibles como artefacto durante 1 día. |

Los conteos incluyen los pasos con `if: always()`, que intentan conservar evidencias aunque falle un paso anterior. La ejecución manual inicia el flujo completo; no constituye una aprobación separada del plan. El estado de red se guarda en el backend S3 descrito arriba, con bloqueo; los artefactos de diagnóstico no sustituyen ese backend.

## Evidencias

La [ejecución 38025806539](https://github.com/slManuel/infra-red-compartida/actions/runs/38025806539) terminó correctamente: **21 recursos creados, 0 cambios y 0 eliminaciones**. Las capturas reales de Actions y de la consola AWS están en [imágenes/](imágenes/).

| Captura | Qué muestra |
|---|---|
| [01 — Workflow, plan y apply](imágenes/01-github-workflow-plan-apply-21-recursos.jpg) | Jobs exitosos y resultado de las 21 creaciones. |
| [02 — VPC](imágenes/02-aws-vpc-disponible-cidr-dns.jpg) | VPC disponible, CIDR y DNS habilitado. |
| [03 — Subredes](imágenes/03-aws-cuatro-subredes-disponibles.jpg) | Las cuatro subredes disponibles y sus rangos. |
| [04 — Internet Gateway](imágenes/04-aws-internet-gateway-conectado.jpg) | Gateway conectado a la VPC del proyecto. |
| [05 — NAT](imágenes/05-aws-dos-nat-publicos-disponibles.jpg) | Los dos NAT públicos disponibles. |
| [06 — Rutas privadas A](imágenes/06-aws-rutas-privadas-a-nat-s3.jpg) | Rutas activas hacia su NAT y el endpoint S3. |
| [07 — Rutas privadas B](imágenes/07-aws-rutas-privadas-b-nat-s3.jpg) | Rutas activas hacia su NAT y el endpoint S3. |
| [08 — Rutas públicas](imágenes/08-aws-rutas-publicas-internet-gateway.jpg) | Ruta activa hacia el Internet Gateway. |
| [09 — Endpoint S3](imágenes/09-aws-endpoint-s3-dos-tablas-privadas.jpg) | Endpoint gateway disponible y asociado a las dos tablas privadas. |

Estas evidencias acreditan el despliegue de la red y la configuración mostrada; no son una prueba de tráfico desde aplicaciones.
