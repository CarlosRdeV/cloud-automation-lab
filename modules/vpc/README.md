# Módulo VPC

Este módulo de Terraform crea una VPC básica en AWS junto con una subred pública, gateway de internet y una tabla de rutas asociada.

---

## 📂 Recursos creados

* `aws_vpc` – VPC con CIDR personalizado
* `aws_subnet` – Subred pública con zona de disponibilidad definida
* `aws_internet_gateway` – Gateway de internet asociado a la VPC
* `aws_route_table` – Tabla de rutas que permite salida a internet
* `aws_route_table_association` – Asociación de la tabla de rutas con la subred

---

## 📥 Variables de entrada

| Nombre              | Tipo     | Descripción                                          | Requerido |
| ------------------- | -------- | ---------------------------------------------------- | --------- |
| `vpc_cidr_block`    | `string` | Bloque CIDR para la VPC                              | ✅ Sí      |
| `subnet_cidr_block` | `string` | Bloque CIDR para la subred                           | ✅ Sí      |
| `availability_zone` | `string` | Zona de disponibilidad donde se desplegará la subred | ✅ Sí      |
| `vpc_name`          | `string` | Nombre base para la VPC                              | ✅ Sí      |
| `subnet_name`       | `string` | Nombre base para la subred                           | ✅ Sí      |
| `env_name`          | `string` | Nombre del entorno (por ejemplo, dev, qa, prod)      | ✅ Sí      |

---

## 📤 Salidas

| Nombre      | Descripción            |
| ----------- | ---------------------- |
| `vpc_id`    | ID de la VPC creada    |
| `subnet_id` | ID de la subred creada |

---

## 🚀 Ejemplo de uso

```hcl
module "vpc" {
  source              = "../../modules/vpc"
  vpc_cidr_block      = "10.0.0.0/16"
  subnet_cidr_block   = "10.0.1.0/24"
  availability_zone   = "us-east-1a"
  vpc_name            = "main-vpc"
  subnet_name         = "main-subnet"
  env_name            = var.env_name
}
```

---

## 🧰 Notas

* La subred creada puede ser usada por otros módulos (como EC2) para lanzar recursos en red pública.
* La tabla de rutas está configurada para permitir salida a internet (0.0.0.0/0).
* Los nombres de los recursos incluyen el entorno para evitar colisiones entre ambientes (ej: `main-vpc-dev`).
