# Módulo IAM (Roles y Policies)

Este módulo de Terraform permite crear roles IAM reutilizables, configurar su política de confianza (trust policy), adjuntarles policies gestionadas o personalizadas, y generar un instance profile listo para asociar a instancias EC2 u otros servicios AWS.

---

## 📦 Recursos creados

* `aws_iam_role`: el rol principal IAM
* `aws_iam_role_policy_attachment`: lista de policies gestionadas o personalizadas asociadas al rol
* `aws_iam_policy`: (opcional) política IAM personalizada creada desde el entorno
* `aws_iam_instance_profile`: perfil asociado para uso en EC2 u otros servicios

---

## 📥 Variables de entrada

| Nombre                | Tipo           | Descripción                                                               | Requerido                   |
| --------------------- | -------------- | ------------------------------------------------------------------------- | --------------------------- |
| `role_name`           | `string`       | Nombre del rol IAM                                                        | ✅ Sí                        |
| `assume_role_policy`  | `string`       | Política de confianza en formato JSON para el rol (ej. EC2, Lambda, etc.) | ✅ Sí                        |
| `managed_policy_arns` | `list(string)` | Lista de ARNs de policies gestionadas a adjuntar al rol                   | ❌ No (por default es vacía) |
| `custom_policy_name`  | `string`       | (Opcional) Nombre de la política personalizada                            | ❌ No                        |
| `custom_policy_json`  | `string`       | (Opcional) Política personalizada en formato JSON                         | ❌ No                        |
| `env_name`            | `string`       | Nombre del entorno (dev, qa, prod)                                        | ✅ Sí                        |

---

## 📤 Salidas

| Nombre                  | Descripción                                 |
| ----------------------- | ------------------------------------------- |
| `role_name`             | Nombre del rol creado                       |
| `role_arn`              | ARN completo del rol                        |
| `instance_profile_name` | Nombre del instance profile asociado al rol |
| `custom_policy_arn`     | ARN de la policy personalizada (si se crea) |

---

## 🚀 Ejemplo de uso

```hcl
locals {
  s3_bucket_name = "${var.bucket_name}-${var.env_name}"

  ec2_s3_access_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = ["s3:ListBucket"],
        Resource = "arn:aws:s3:::${local.s3_bucket_name}"
      },
      {
        Effect = "Allow",
        Action = ["s3:GetObject", "s3:PutObject"],
        Resource = "arn:aws:s3:::${local.s3_bucket_name}/*"
      }
    ]
  })
}

module "iam_ec2_role" {
  source              = "../../modules/iam"
  role_name           = "ec2-role-${var.env_name}"
  env_name            = var.env_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  ]

  custom_policy_name = "access-s3-${var.env_name}"
  custom_policy_json = local.ec2_s3_access_policy
}
```

Puedes luego usar el instance profile así:

```hcl
module "ec2" {
  ...
  iam_instance_profile = module.iam_ec2_role.instance_profile_name
}
```

---

## 🔐 Uso común

* Asociar el rol a EC2 con permisos a S3, CloudWatch, etc.
* Crear roles para Lambda, ECS, Batch, etc.
* Reutilizar con diferentes entornos (`dev`, `qa`, `prod`) según `env_name`
* Crear y asociar policies personalizadas generadas desde los entornos

---

## 🧠 Notas

* El `assume_role_policy` debe estar en formato JSON y adaptado al servicio que asumirá el rol.
* Puedes adjuntar cualquier cantidad de policies mediante `managed_policy_arns`.
* Las policies personalizadas permiten permisos más finos, por ejemplo: acceso restringido a un bucket.
* El instance profile es obligatorio si deseas asociar el rol a una instancia EC2.

> "El control de acceso no se improvisa, se define."
