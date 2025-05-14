# cloud-automation-lab

Este repositorio contiene una infraestructura modularizada en Terraform diseñada para implementarse en entornos separados (`dev`, `qa`, `prod`). Cada módulo se encuentra documentado y preparado para su reutilización, facilitando la escalabilidad y el mantenimiento.

---

## 🧱 Estructura del proyecto

```
cloud-automation-lab/
├── modules/
│   ├── ec2/
│   ├── security_group/
│   ├── vpc/
│   ├── s3/
│   └── iam/
├── environments/
│   ├── dev/
│   ├── qa/
│   └── prod/
└── README.md
```

---

## 📦 Módulos disponibles

### 🔹 `vpc`

Crea una VPC con subred, gateway de internet y tabla de rutas.
[Ver documentación](./modules/vpc/README.md)

### 🔹 `security_group`

Crea un grupo de seguridad con reglas para SSH (puerto 22) y HTTP (puerto 80).
[Ver documentación](./modules/security_group/README.md)

### 🔹 `ec2`

Lanza una instancia EC2 con NGINX instalado y mensaje de bienvenida personalizado.
[Ver documentación](./modules/ec2/README.md)

### 🔹 `s3`

Crea un bucket S3 privado con bloqueo de acceso público, versionado opcional, reglas de ciclo de vida configurables, región configurable y etiquetas por entorno.
[Ver documentación](./modules/s3/README.md)

### 🔹 `iam`

Crea roles IAM con políticas de confianza, policies gestionadas y/o personalizadas, y un instance profile para EC2.
[Ver documentación](./modules/iam/README.md)

---

## 🚀 Envío por entornos

Cada entorno (`dev`, `qa`, `prod`) está definido en su propia carpeta y puede tener configuraciones distintas.

Ejemplo para desplegar `dev`:

```bash
cd environments/dev
terraform init
terraform apply
```

---

## 🧰 Requisitos

* Terraform >= 1.3
* Cuenta de AWS con acceso programático
* Clave pública registrada en EC2 (`key_name`)
* Para el módulo `s3`, definir un nombre de bucket único globalmente y especificar la región (`region`)

---

## 📌 Notas finales

* Todos los recursos usan `env_name` como sufijo para evitar colisiones entre entornos.
* La infraestructura es fácilmente extensible con nuevos módulos como RDS, Load Balancers, IAM, etc.
* Cada módulo está completamente documentado y puede reutilizarse en diferentes proyectos.
* El módulo `s3` requiere que el nombre del bucket sea único globalmente. Usa prefijos como tu nombre, proyecto o empresa para evitar errores (`BucketAlreadyExists`).
* El módulo `s3` también requiere definir una región compatible (por ejemplo, `us-east-2`) desde el entorno que lo consuma.
* El módulo `s3` incluye reglas de ciclo de vida configurables mediante variables, permitiendo eliminar versiones antiguas y objetos después de ciertos días si `enable_lifecycle = true`.
* El módulo `iam` permite crear roles reutilizables para EC2 (o cualquier servicio AWS), y ahora soporta:

  * ✅ Políticas gestionadas (`managed_policy_arns`)
  * ✅ Políticas personalizadas (`custom_policy_json`) para casos como acceso a un bucket S3 por entorno
  * ✅ Asociación automática a EC2 mediante `iam_instance_profile`

---

## 👨‍💻 Autor

Este proyecto fue creado con fines de aprendizaje, automatización y dominio absoluto de Terraform ☁️

> “DevOps no es una herramienta. Es un ritual.”
