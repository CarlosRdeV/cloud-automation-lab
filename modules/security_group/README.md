# Módulo Security Group

Este módulo de Terraform crea un grupo de seguridad en AWS con reglas de entrada para SSH (puerto 22) y HTTP (puerto 80), y salida habilitada a cualquier dirección.

---

## 📂 Recursos creados

* `aws_security_group` – Grupo de seguridad personalizado con etiquetas dinámicas por entorno.

---

## 📥 Variables de entrada

| Nombre        | Tipo     | Descripción                                        | Requerido |
| ------------- | -------- | -------------------------------------------------- | --------- |
| `sg_name`     | `string` | Nombre base del grupo de seguridad                 | ✅ Sí      |
| `description` | `string` | Descripción del grupo de seguridad                 | ✅ Sí      |
| `vpc_id`      | `string` | ID de la VPC donde se creará el grupo de seguridad | ✅ Sí      |
| `env_name`    | `string` | Nombre del entorno (por ejemplo, dev, qa, prod)    | ✅ Sí      |

---

## 📤 Salidas

| Nombre              | Descripción                      |
| ------------------- | -------------------------------- |
| `security_group_id` | ID del grupo de seguridad creado |

---

## 🚀 Ejemplo de uso

```hcl
module "security_group" {
  source      = "../../modules/security_group"
  sg_name     = "allow-ssh-http"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = module.vpc.vpc_id
  env_name    = var.env_name
}
```

---

## 🧰 Notas

* El grupo de seguridad permite tráfico entrante por los puertos 22 (SSH) y 80 (HTTP) desde cualquier IP (`0.0.0.0/0`).
* La etiqueta del recurso se adapta automáticamente al entorno (por ejemplo: `allow-ssh-http-dev`, `allow-ssh-http-qa`).
