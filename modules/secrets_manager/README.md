# 📦 Módulo: secrets\_manager

Este módulo crea un secreto en AWS Secrets Manager, útil para almacenar de forma segura credenciales o configuraciones sensibles, como el usuario y contraseña de una base de datos.

---

## 🚀 Recursos creados

* `aws_secretsmanager_secret`: Define el secreto.
* `aws_secretsmanager_secret_version`: Contiene la versión y el valor (clave/valor) del secreto.

---

## 🛠️ Variables

| Nombre          | Descripción                                      | Tipo   | Requerido |
| --------------- | ------------------------------------------------ | ------ | --------- |
| `secret_name`   | Nombre base del secreto                          | string | ✅ Sí      |
| `env_name`      | Nombre del entorno (dev, qa, prod)               | string | ✅ Sí      |
| `description`   | Descripción del secreto                          | string | ✅ Sí      |
| `secret_string` | Valor del secreto como string codificado en JSON | string | ✅ Sí      |

---

## 📤 Outputs

| Nombre       | Descripción            |
| ------------ | ---------------------- |
| `secret_id`  | ID del secreto creado  |
| `secret_arn` | ARN del secreto creado |

---

## 💡 Ejemplo de uso

```hcl
module "db_secret" {
  source      = "../../modules/secrets_manager"
  secret_name = "mysql-credentials"
  env_name    = var.env_name
  description = "Credenciales de acceso para RDS MySQL en ${var.env_name}"

  secret_string = jsonencode({
    username = "admin"
    password = "SuperClaveSegura123"
  })
}

# Lectura del secreto desde otro módulo o recurso

data "aws_secretsmanager_secret_version" "mysql_credentials" {
  secret_id = "${module.db_secret.secret_name}-${var.env_name}"
}

locals {
  mysql_credentials = jsondecode(data.aws_secretsmanager_secret_version.mysql_credentials.secret_string)
}
```

---

## 🔒 Recomendaciones

* Nunca hardcodees los secretos directamente en los módulos.
* Usa `jsonencode` para definir múltiples claves (usuario, contraseña, etc.).
* Usa `jsondecode` para leer el secreto y convertirlo en un `map` usable en Terraform.

---

## ✅ Resultado en consola de AWS

* El secreto se mostrará bajo el nombre `mysql-credentials-dev` (o `-qa`, `-prod` según entorno).
* Contendrá un JSON como:

```json
{
  "username": "admin",
  "password": "SuperClaveSegura123"
}
```
