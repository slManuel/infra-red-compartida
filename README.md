# Red compartida

VPC 10.0.0.0/16 en us-east-1, con dos subredes privadas y dos públicas repartidas entre us-east-1a/us-east-1b. No se asignan IP públicas automáticamente. Cada subred privada usa un NAT público en su propia AZ; ambas tablas privadas usan un endpoint gateway S3. Los dos NAT/EIP generan costos mientras existan.

## Módulos por responsabilidad

- red_base: VPC y cuatro subredes.
- salida_internet: Internet Gateway, tabla/ruta/asociaciones públicas, dos EIP y dos NAT zonales.
- acceso_privado: tablas/rutas/asociaciones privadas y endpoint S3.

main.tf conecta los módulos sin ciclos. Recursos explícitos, sin for/for_each. moved.tf conserva las direcciones de raíz y la organización intermedia module.red mediante cadenas moved. La configuración de los 21 recursos se conserva. Outputs públicos: vpc_id, private_subnet_ids y private_subnet_ids_by_az.

## Despliegue

Terraform 1.15.9 en GitHub Actions; provider AWS 6.68.0 fijado y lock versionado. Configurar aws_account_id para ejecución local; el workflow usa 022907376152. Backend S3: bucket tfstate-prueba-cuscatlan-oct2026-jose-manuel-solis, key red-compartida/terraform.tfstate, región us-east-1, cifrado y use_lockfile=true. El estado no se versiona.

Push a main y workflow_dispatch ejecutan checks, autenticación OIDC con prueba-devops-github-actions-red, init/validate/plan y apply automático del mismo archivo. PR solo ejecuta checks, sin AWS. Acciones fijadas por SHA; sin claves AWS persistentes. El job serializa despliegues, verifica main y rechaza recursos ajenos a .github/recursos-autorizados.json o acciones distintas de create/no-op. Es una compuerta de despliegue inicial, que debe revisarse antes de futuras actualizaciones.

Plan y diagnósticos se conservan un día como artefactos privados; pueden contener datos sensibles. S3 conserva el estado versionado y su lock. Un fallo parcial normal conserva en S3 los recursos ya registrados; revisar antes de repetir. Si falla guardar estado remoto, errored.tfstate se conserva como diagnóstico privado y debe recuperarse antes de continuar.

El rol de red no permite destruir infraestructura; la retirada requiere una revisión y autorización separadas. No ejecutar destroy con permisos ampliados sin revisar los recursos.

## Validación

terraform fmt -check -recursive; terraform init -backend=false -lockfile=readonly; terraform validate. Validación offline realizada sin AWS: 21 cuerpos de recursos equivalentes tras normalizar referencias, 0 errores y 0 avisos. Verificar el plan y el apply reales en Actions; validación local no demuestra despliegue.

[Refactorización Terraform](https://developer.hashicorp.com/terraform/language/modules/develop/refactoring) · [Backend S3](https://developer.hashicorp.com/terraform/language/backend/s3).


## Logs de Terraform — 9 de octubre de 2026

Los pasos de plan y apply muestran ahora el texto legible de Terraform en directo con `-no-color` y `tee`, y conservan `plan.log` y `apply.log` como artefactos privados de un día. Antes la redirección o captura completa ocultaba el progreso; algunos fallos solo mostraban exit 1. Bash captura `PIPESTATUS` inmediatamente: prevalece el código original de Terraform; si Terraform termina bien y tee falla, el paso también falla. Ensayos locales confirmaron stdout/stderr visibles y códigos 0 y 37 conservados.

En Actions abrir el job deploy y el paso Planificar o Aplicar: aparecen refrescos, Creating/Still creating, errores del proveedor y código real. Las comprobaciones de alcance siguen leyendo el plan JSON en memoria sin imprimirlo. No se imprimen estados Terraform, credenciales ni tokens; se revisaron los recursos y outputs actuales, que contienen infraestructura e identificadores, sin valores secretos. Antes de incorporar recursos con secretos se debe revisar nuevamente la salida. Los respaldos de estado y planes binarios continúan en artefactos privados.

El recorrido sigue siendo validar → planificar → comprobar alcance → aplicar el mismo plan guardado → verificar AWS. Esta mejora conserva OIDC, backend, triggers y mecanismo automático vigente. La publicación usa `[skip ci]` para evitar despliegues adicionales durante el apply activo; no cambia el comportamiento de las ejecuciones futuras.
