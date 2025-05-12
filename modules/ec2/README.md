# Módulo EC2

Este módulo de Terraform aprovisiona una instancia EC2 con NGINX instalado y un mensaje de bienvenida personalizado que incluye el nombre del entorno.

---

## 📂 Recursos creados

* `aws_instance` – Instancia EC2 que ejecuta NGINX con un script simple en `user_data`

---

## 📥 Variables de entrada

| Nombre               | Tipo     | Descripción                                      | Requerido |
| -------------------- | -------- | ------------------------------------------------ | --------- |
| `ami`                | `string` | ID de la AMI a utilizar para lanzar la instancia | ✅ Sí      |
| `instance_type`      | `string` | Tipo de instancia EC2                            | ✅ Sí      |
| `subnet_id`          | `string` | ID de la subred donde se desplegará la instancia | ✅ Sí      |
| `security_group_ids` | `list`   | Lista de IDs de grupos de seguridad a asociar    | ✅ Sí      |
| `key_name`           | `string` | Nombre del par de llaves SSH                     | ✅ Sí      |
| `env_name`           | `string` | Nombre del entorno (por ejemplo, dev, qa, prod)  | ✅ Sí      |

---

## 📤 Salidas

| Nombre               | Descripción                              |
| -------------------- | ---------------------------------------- |
| `instance_id`        | ID de la instancia EC2                   |
| `instance_public_ip` | Dirección IP pública de la instancia EC2 |

---

## 🚀 Ejemplo de uso

```hcl
module "ec2" {
  source             = "../../modules/ec2"
  ami                = "ami-04505e74c0741db8d"
  instance_type      = var.instance_type
  subnet_id          = module.vpc.subnet_id
  security_group_ids = [module.security_group.security_group_id]
  key_name           = var.key_name
  env_name           = var.env_name
}
```

---

## 🧰 Notas

* La instancia instala NGINX y muestra un mensaje de bienvenida en `/var/www/html/index.html` con el nombre del entorno.
* Asegúrate de que la AMI seleccionada sea compatible con `apt-get` (por ejemplo, basada en Ubuntu o Debian).
