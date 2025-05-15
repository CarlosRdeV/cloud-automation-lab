# 📦 Módulo `rds`

Este módulo crea una instancia de **Amazon RDS** con configuración para entornos como `dev`, `qa`, `prod`. Utiliza MySQL como motor de base de datos por defecto.

---

## 🚀 Recursos creados

- `aws_db_instance`: instancia MySQL con configuración básica
- `aws_db_subnet_group`: grupo de subredes privadas para RDS

---

## 🎯 Variables

| Variable             | Descripción                                     | Requerido | Ejemplo                   |
|----------------------|-------------------------------------------------|-----------|----------------------------|
| `engine`             | Motor de base de datos                          | ✅        | `"mysql"`                 |
| `engine_version`     | Versión del motor                               | ✅        | `"8.0"`                   |
| `instance_class`     | Clase de instancia                              | ✅        | `"db.t3.micro"`           |
| `db_name`            | Nombre de la base de datos                      | ✅        | `"basedatos"`             |
| `username`           | Usuario administrador                           | ✅        | `"admin"`                 |
| `password`           | Contraseña del administrador                    | ✅        | `"SuperClave123"`         |
| `allocated_storage`  | Almacenamiento (GB)                             | ❌        | `20` (por defecto)        |
| `subnet_ids`         | Lista de subnets privadas                       | ✅        | `["subnet-xxx", ...]`     |
| `security_group_ids` | Lista de grupos de seguridad                    | ✅        | `["sg-xxx", ...]`         |
| `env_name`           | Nombre del entorno                              | ✅        | `"dev"`                   |

---

## 🔐 Notas

- Se crea un grupo de subredes para que la base esté en **mínimo 2 zonas de disponibilidad**, como requiere RDS.
- `skip_final_snapshot` está en `true`, lo que elimina la base sin snapshot final (para pruebas).
- `publicly_accessible` está en `false` por seguridad (solo acceso desde red privada/VPC).

---

## 📤 Outputs

| Output         | Descripción                            |
|----------------|----------------------------------------|
| `endpoint`     | Endpoint de conexión al RDS            |
| `port`         | Puerto (por defecto 3306 para MySQL)   |
| `db_instance_id` | Identificador de la instancia RDS     |

---

## 🧪 Ejemplo de uso

```hcl
module "rds" {
  source              = "../../modules/rds"
  engine              = "mysql"
  engine_version      = "8.0"
  instance_class      = "db.t3.micro"
  db_name             = "basedatos"
  username            = "admin"
  password            = "SuperClaveSegura123"
  allocated_storage   = 20
  subnet_ids          = module.vpc.subnet_ids
  security_group_ids  = [module.security_group.security_group_id]
  env_name            = var.env_name
}
