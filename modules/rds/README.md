# Módulo: rds

Este módulo crea una instancia de base de datos RDS (MySQL) en AWS, incluyendo el grupo de subredes asociado. Está diseñado para integrarse con subredes privadas, grupos de seguridad y variables de entorno.

---

## 🚀 Recursos que crea

* `aws_db_instance`: Instancia de RDS
* `aws_db_subnet_group`: Grupo de subredes para RDS

---

## 📥 Variables de entrada

| Variable             | Tipo           | Descripción                                                            | Obligatoria | Valor por defecto |
| -------------------- | -------------- | ---------------------------------------------------------------------- | ----------- | ----------------- |
| `engine`             | `string`       | Motor de base de datos (ej. `mysql`)                                   | ✅ Sí        | N/A               |
| `engine_version`     | `string`       | Versión del motor de base de datos (ej. `8.0`)                         | ✅ Sí        | N/A               |
| `instance_class`     | `string`       | Tipo de instancia RDS (ej. `db.t3.micro`)                              | ✅ Sí        | N/A               |
| `db_name`            | `string`       | Nombre de la base de datos (no el nombre del recurso, sino el interno) | ✅ Sí        | N/A               |
| `username`           | `string`       | Usuario administrador                                                  | ✅ Sí        | N/A               |
| `password`           | `string`       | Contraseña del usuario administrador                                   | ✅ Sí        | N/A               |
| `allocated_storage`  | `number`       | Almacenamiento en GB                                                   | ❌ No        | `20`              |
| `subnet_ids`         | `list(string)` | Lista de IDs de subredes privadas                                      | ✅ Sí        | N/A               |
| `security_group_ids` | `list(string)` | IDs de los grupos de seguridad permitidos                              | ✅ Sí        | N/A               |
| `env_name`           | `string`       | Nombre del entorno (`dev`, `qa`, `prod`, etc.)                         | ✅ Sí        | N/A               |

---

## 📤 Outputs

| Nombre                 | Descripción                              |
| ---------------------- | ---------------------------------------- |
| `db_instance_endpoint` | Endpoint de conexión de la base de datos |
| `db_instance_port`     | Puerto de conexión                       |
| `db_instance_name`     | Nombre de la base de datos creada        |
| `db_instance_arn`      | ARN completo de la instancia RDS         |

---

## 🧪 Ejemplo de uso

```hcl
module "rds" {
  source              = "../../modules/rds"

  engine              = "mysql"
  engine_version      = "8.0"
  instance_class      = "db.t3.micro"
  db_name             = "basedatos"
  username            = local.mysql_credentials.username
  password            = local.mysql_credentials.password
  allocated_storage   = 20
  subnet_ids          = module.vpc.subnet_ids
  security_group_ids  = [module.security_group.security_group_id]
  env_name            = var.env_name
}
```

---

## ✅ Buenas prácticas

* Se recomienda usar Secrets Manager para almacenar el `username` y `password`.
* Asegúrate de que las subredes usadas estén en diferentes zonas de disponibilidad (AZs).
* Para ambientes productivos, considera habilitar backup y monitoreo avanzado.

---

## 📌 Requisitos

* AWS VPC y subredes creadas (idealmente privadas)
* Terraform >= 1.3
* Tener permisos para crear RDS y Secrets (si aplica)

---

## 🛡️ Seguridad

* No almacenes credenciales en texto plano en el código.
* Limita el acceso al grupo de seguridad de RDS solo a lo necesario (por ejemplo, EC2 internas).

---

¡Listo para dejar de usar bases de datos de juguete y pasar a producción como se debe! 🎯
