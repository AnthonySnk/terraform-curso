- [Documentacion de AWS provider Terraform](#documentacion-de-aws-provider-terraform)
- [AWS instance with terraform](#aws-instance-with-terraform)
  - [Instalación de terraform](#instalación-de-terraform)
  - [Verificar la instalación](#verificar-la-instalación)
  - [Configurar la cuenta de aws](#configurar-la-cuenta-de-aws)
  - [Comandos de terraform](#comandos-de-terraform)
- [Enviar parametros](#enviar-parametros)
- [Destruccion sin preguntar nada](#destruccion-sin-preguntar-nada)
- [Creacion sin preguntar nada](#creacion-sin-preguntar-nada)
- [Variables](#variables)
- [Evitar destruccion](#evitar-destruccion)
- [Destruir una Infraestructura](#destruir-una-infraestructura)
- [Outputs](#outputs)
- [Archivos de estados de Terraform](#archivos-de-estados-de-terraform)
- [Archivos de Backends](#archivos-de-backends)
- [Modulos](#modulos)
- [Módulos remotos](#módulos-remotos)
  - [Pasos](#pasos)
  - [Implementacion](#implementacion)
- [Credenciales](#credenciales)
- [Otra Opcion](#otra-opcion)
- [Varibles de entorno](#varibles-de-entorno)
- [Construccion de packer](#construccion-de-packer)
- [Backend](#backend)
- [Terraform para planear un recurso especifico](#terraform-para-planear-un-recurso-especifico)
- [Atachar recursos aun no existentes](#atachar-recursos-aun-no-existentes)
- [Key Pair](#key-pair)
- [User data](#user-data)
# Documentacion de AWS provider Terraform
  ```
  https://registry.terraform.io/providers/hashicorp/aws/latest/docs
  ```
# AWS instance with terraform
## Instalación de terraform
Terraform tiene un binario para cada sistema operativo, en el siguiente link estan las instrucciones para descargalo e instalarlo en cada uno, en este documento se muestran las instrucciones para instalar en Mac o linux.
- https://learn.hashicorp.com/terraform/getting-started/install.html
```sh
$ curl -o /tmp/packer.zip https://releases.hashicorp.com/terraform/0.12.6/terraform_0.12.6_darwin_amd64.zip

$ unzip /tmp/packer.zip -d /usr/local/bin

## En el siguiente link se encuentra la url de los binarios para los demas sistemas operativos https://www.terraform.io/downloads.html
```

## Verificar la instalación 
```sh
$ terraform version
Terraform v0.12.6
```

## Configurar la cuenta de aws
Configurar las credenciales de AWS. Esto no es indispensable pero si se omite será necesario setear las variables dentro de los archivos de configuración de terraform.
```sh
$ export AWS_ACCESS_KEY_ID=""
$ export AWS_SECRET_ACCESS_KEY=""
```

## Comandos de terraform
Para poder ejecutar los comandos de terraform es necesario estar dentro de la carpeta donde se encuentran los archivos de definicion.
Este comando es util para dar un formato uniforme a todos los archivos de terraform.

```sh
$ terraform fmt
```

Este comando es util para validar la sintaxis de los archivos de definición de terraform.

```sh
$ terraform validate
```

Este comando es necesario para descargar los plugins necesarios para el provider.
```sh
$ terraform init
```

Con este comando es posible ver los recursos que se crearan con la definición.
```sh
$ terraform plan
```

Finalmente cuando estamos seguros de lo que vamos a crear procedemos a aplicar. Esto creara la infraestructura que definimos que en este caso es una instance en AWS.
```sh
$ terraform apply
```

Terraform tambien nos permite destruir la infraestructura creada.
```sh
$ terraform destroy
```
# Enviar parametros
Para enviar el archivo donde se contienen las variables enviamos como parametro el archivo
```
terraform plan -var-file - dev.tfvars
```
Si deseamos que terraform no preguntate nada agregamos el parametro
```
--auto-approve
```
# Destruccion sin preguntar nada
```terraform destroy --force```
# Creacion sin preguntar nada
```terraform apply --auto-aprove```
# Variables
Cuando no queremos enviar por parametros el archivo donde se encuentran las variables tenemos que agregar la extencion, RECOMENDABLE CUANDO ESTAS VARIABLES NO CAMBIAN 

```
auto.tfvars
```
```prod.auto.tfvars```

# Evitar destruccion
``` 
# ...
  lifecycle {
    prevent_destroy = true # no destruir cuando se aplique terraform destroy
  }
  timeouts {
    create = "60m"
    delete = "2h"
  }
  ```

# Destruir una Infraestructura
Cuando se desea eliminar los recursos que hemos creado
```
terraform destroy
```
Este tambien podemos enviarles los parametros:
```
terraform destroy -var-file - dev.tfvars --auto-approve
```

# Outputs
Para conocer los elementos creados 

```
output "instance_ip" {
    value = <instance_type>.<instance_name>.<property>
}
```
# Archivos de estados de Terraform
El directorio .terraform es creado cuando ejecutamos por primera vez ```terraform init```.

El archivo ```terraform.tfstate``` es creado cuando ejecutamos por primera vez terraform apply y guarda el estado,
cuando el archivo ya existe y atualizamos la infraestructura con ```terraform apply``` o ```terraform destroy``` el archivo guardara el ultimo estado sustituyendo al anterior.

El archivo ```terraform.tfstate.backup``` es creado cuando tenemos un primer estado ```terraform.tfstate``` y aplicamos una modificacion con apply o destroy entonces el estado de ```terraform.tfstate``` se convierte en ```terraform.tfstate.backup```.
Ahora cada vez que apliques los cambios de la configuracion estos pasaran a estar en el estado ```terraform.tfstate``` y el anterior estado estara en ```terraform.tfstate.backup```

# Archivos de Backends
Terraform permite almacenar el estado de manera remota a través de Backends. Podemos almacenarlo en diferentes servicios de storage en la nube como S3 o Azure.

Entre sus muchas ventajas que trae el trabajar con backends son:
- Es más fácil trabajar en equipo.
- Facilita la integración continua.
- Mayor disponibilidad.

# Modulos
Así como en lenguajes de programación contamos con librerías, en Terraform podemos separar nuestro código y reutilizarlo a través de módulos. Dentro de nuestro módulo vamos a añadir el archivo de configuración y el de definición de variables.

Los modulos son usados de una manera como librerias.
para crear un modulo se necesita crear un carpeta con un nombre cualquiera
luego crear otro main en la raiz instanciando ese mismo modulo de la siguiente manera
```
provider "aws" {
  shared_credentials_file = "/Users/tfsvr/.aws/credentials"
  region                  = "us-east-1"
}


module "app-with-modules" {
  source        = "./modulos/instance"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  tags          = var.tags
  sg_name       = var.sg_name
  ingress_rules = var.ingress_rules
}

```
En la carpeta de modulos debe contener su propio ```main.tf``` ademas de su archivo de variable y output propio.

Para hacer el output del modulo se debe crear en la raiz de todas las carpeta en el mismo nivel donde el main que invoca al modulo se encuentra

```
output "module-intance-ip" {
  value = module.app-with-modules.instance_ip
}
```
# Módulos remotos

Los módulos locales son útiles, pero tienen la limitante de que solamente se encuentran en tu máquina. Para mejorar el trabajo remoto y reutilización de módulos podemos usar el control de versiones de preferencia, ya sea GitHub o BitBucket.
## Pasos
  - Crear un repositorio en github
  - versionamos solo la carpeta de modulos
  - iniciamos el git
  - agregamos el repositorio
  - realizamos el commit
  - hacemos el push
  
## Implementacion
  En el archivo donde se hace referencia al modulo es ves de hacer refencia a un modulo local, se hara referencia al github
  ```
    module "app-with-modules" {
    source        = "github.com/...."
    ami_id        = var.ami_id
    instance_type = var.instance_type
    tags          = var.tags
    sg_name       = var.sg_name
    ingress_rules = var.ingress_rules
  }
  ```
# Credenciales
Debemos crear una carpeta con .AWS donde se va crear un archivo con el nombre de ```credentials```, el contenido debe ser

```
[default]
aws_access_key_id= [Access key ID]
aws_secret_access_key= [Secret access key]
```
# Otra Opcion
Otra Opción es que instalen el CLI de AWS y con
```aws configure```

Tambien me gustaria agregar que la configuracion tambien puede ser por perfil (podemos tener diferentes perfiles con diferente autentificacion) un perfil para dev o prod con su propia autentificacion y para configurar podriamos por ejemplo usar:

para desarrollo
```aws configure --development```

para produccion
```aws configure --production```

pero si solo usamos aws configure, es lo mismo que
```aws configure --default```

# Varibles de entorno

Para crear las variables de entorno en Windows con Powershell se ejecuta:
```
$env:AWS_ACCESS_KEY_ID="clave"
$env:AWS_SECRET_ACCESS_KEY="clave"
```
Para revisar las varibles de entorno disponibles en el sistema windows usando Powershell, se ejecuta:

```
Get-ChildItem Env:
```
# Construccion de packer

Para crear los creado con packer
```packer build file.js```
# Backend
Nos sirve para almacenar los estados en un bucket
backend.tf
El ```force_destroy= true``` nos sirve para el bucket se elimine cuando se ejecute el detroy
```
backend "s3"{
    bucket = "bucket-NAME"
    key = "Nombre-del-file-en-s3"
    region ="us-east-1"
    force_destroy= true
}
```
Se debe correr el ```terraform init```
# Terraform para planear un recurso especifico
Deseamos saber el plan de un recurso usaremos un parametro ```target```

Ejemplo
```
terraform plan --target aws_security_group.allow_shh_anywhere
terraform plan --target <recurso>.<nombreRecurso>
```
# Atachar recursos aun no existentes
Deseamos atachar un recurso que aun no sabemos el Id
Atachando algo que se esta creando con terraform
```
vpc_security_group_ids = [ aws_security_group.allow_shh_anywhere.id ]
vpc_security_group_ids = [ <recurso>.<nombreRecurso>.<atributo>]
```
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group

Atributos de un Security Group
```https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group#attributes-reference```

```id``` - The ID of the security group
```arn``` - The ARN of the security group
```vpc_id``` - The VPC ID.
```owner_id``` - The owner ID.
```name``` - The name of the security group
```description``` - The description of the security group
```ingress``` - The ingress rules. See above for more.
```egress``` - The egress rules. See above for more.

# Key Pair
Si deseamos crear un Key-Pair conTerraform  podemos revisar la sintaxis
ademas si queres atacaharla.
```https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair```

Atachandola
```
key_name = aws_key_pair.key-pair-terraform.name
# para poder usar una key-pair creada por Terraform
```
# User data
Para poder ingresar el user data utilizaremos
```
file("user-data.txt")
```
Ejemplo
```
user_data = file("user-data.txt")
```