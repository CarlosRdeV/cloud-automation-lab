# Módulo: Application Load Balancer (ALB)

Este módulo de Terraform implementa un Application Load Balancer (ALB) en AWS. Proporciona un punto de entrada para distribuir tráfico HTTP a instancias EC2 registradas en un Target Group.

---

## 🚀 Recursos creados

* `aws_lb`: Load Balancer de tipo "application"
* `aws_lb_target_group`: Grupo de destino para enrutar tráfico a instancias EC2
* `aws_lb_listener`: Escucha en el puerto 80 y enruta a los targets

---

## 📥 Inputs

| Variable             | Tipo           | Descripción                                  |
| -------------------- | -------------- | -------------------------------------------- |
| `env_name`           | `string`       | Nombre del entorno (dev, qa, prod)           |
| `vpc_id`             | `string`       | ID de la VPC donde desplegar el ALB          |
| `subnet_ids`         | `list(string)` | Lista de subnets donde desplegar el ALB      |
| `security_group_ids` | `list(string)` | Lista de security groups para asociar al ALB |

---

## 📤 Outputs

| Nombre             | Descripción                            |
| ------------------ | -------------------------------------- |
| `alb_dns_name`     | DNS del ALB para acceder vía navegador |
| `target_group_arn` | ARN del target group (usado para EC2)  |

---

## 🧠 Uso Ejemplo

```hcl
module "alb" {
  source             = "../../modules/alb"
  env_name           = var.env_name
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.subnet_ids
  security_group_ids = [module.security_group.security_group_id]
}

resource "aws_lb_target_group_attachment" "ec2_attachment" {
  target_group_arn = module.alb.target_group_arn
  target_id        = module.ec2.instance_id
  port             = 80
}
```

---

## 📝 Notas

* Actualmente solo escucha en el puerto 80 (HTTP).
* No soporta HTTPS (puerto 443) ni certificados en esta versión.
* Se recomienda usar el ALB con subnets en múltiples zonas de disponibilidad.

---

## 📦 Mejoras futuras

* Soporte para listeners HTTPS con certificados ACM
* Configuración de reglas de enrutamiento
* Health checks personalizados

---

Este módulo es parte del proyecto `cloud-automation-lab` y sigue el mismo estándar modularizado por entorno.
