# Módulo S3

Este módulo de Terraform crea un bucket S3 privado y seguro, con opción de versionado y control sobre la eliminación de objetos. Es compatible con entornos separados (`dev`, `qa`, `prod`) usando la variable `env_name` como sufijo en el nombre del bucket.

---

## 📂 Recursos creados

* `aws_s3_bucket` – Bucket principal en S3
* `aws_s3_bucket_versioning` – Configuración opcional de versionado
* `aws_s3_bucket_public_access_block` – Bloqueo completo de acceso público

---

## 📥 Variables de entrada

| Nombre              | Tipo     | Descripción                                                | Requerido                   |
| ------------------- | -------- | ---------------------------------------------------------- | --------------------------- |
| `bucket_name`       | `string` | Nombre base del bucket (se agregará el sufijo del entorno) | ✅ Sí                        |
| `env_name`          | `string` | Nombre del entorno (por ejemplo, dev, qa, prod)            | ✅ Sí                        |
| `enable_versioning` | `bool`   | Activa el versionado para mantener un historial de objetos | ❌ No (default: `true`)      |
| `force_destroy`     | `bool`   | Permite eliminar el bucket incluso si contiene objetos     | ❌ No (default: `false`)     |
| `region`            | `string` | Región donde se creará el bucket (ej. `us-east-2`)         | ❌ No (default: `us-east-1`) |

---

## 📤 Salidas

| Nombre        | Descripción                 |
| ------------- | --------------------------- |
| `bucket_name` | Nombre del bucket S3 creado |
| `bucket_arn`  | ARN del bucket S3           |

---

## 🚀 Ejemplo de uso

```hcl
provider "aws" {
  alias  = "s3"
  region = "us-east-2"
}

module "s3" {
  source            = "../../modules/s3"
  bucket_name       = "app-storage-crive"
  env_name          = var.env_name
  enable_versioning = true
  force_destroy     = false
  region            = "us-east-2"

  providers = {
    aws = aws.s3
  }
}
```

---

## 🧰 Notas

* El nombre final del bucket será algo como `app-storage-crive-dev`.
* Los nombres de buckets en S3 **son globales**, por lo que deben ser únicos a nivel mundial.
* Si recibes el error `BucketAlreadyExists`, cambia el nombre base (`bucket_name`) por algo único.
* Si `force_destroy` está en `false`, Terraform no podrá eliminar el bucket si contiene archivos.
* Si `enable_versioning` está activado, S3 mantendrá una copia de cada versión de los archivos subidos.
* El acceso público está bloqueado completamente por seguridad.
