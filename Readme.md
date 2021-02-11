- [Documentacion de AWS provider Terraform](#documentacion-de-aws-provider-terraform)
- [AWS instance with terraform](#aws-instance-with-terraform)
  - [Instalación de terraform](#instalación-de-terraform)
  - [Verificar la instalación](#verificar-la-instalación)
  - [Configurar la cuenta de aws](#configurar-la-cuenta-de-aws)
  - [Comandos de terraform](#comandos-de-terraform)
    - [fmt](#fmt)
    - [validate](#validate)
    - [init](#init)
    - [plan](#plan)
    - [apply](#apply)
    - [destroy](#destroy)
    - [graph](#graph)
    - [import](#import)
    - [refresh](#refresh)
    - [show](#show)
    - [comandos para el state](#comandos-para-el-state)
    - [taint y untaint](#taint-y-untaint)
    - [workspace](#workspace)
    - [Interpolation Syntax con WorkSpaces](#interpolation-syntax-con-workspaces)
- [Enviar parametros](#enviar-parametros)
- [Destruccion sin preguntar nada](#destruccion-sin-preguntar-nada)
- [Creacion sin preguntar nada](#creacion-sin-preguntar-nada)
- [Variables](#variables)
- [Evitar destruccion](#evitar-destruccion)
- [Destruir una Infraestructura](#destruir-una-infraestructura)
- [Outputs](#outputs)
- [Archivos de estados de Terraform](#archivos-de-estados-de-terraform)
- [Archivos de Backends](#archivos-de-backends)
  - [Estados remotos con s3](#estados-remotos-con-s3)
  - [Estados lock](#estados-lock)
    - [El bloqueo se hace con DynamoDB](#el-bloqueo-se-hace-con-dynamodb)
    - [Desbloqueo de LOCKID](#desbloqueo-de-lockid)
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
- [Data Source - AMI](#data-source---ami)
- [Data source VPC](#data-source-vpc)
- [AWS_lauch_configuration](#aws_lauch_configuration)
- [Obtener el ID de una EC2](#obtener-el-id-de-una-ec2)
- [lifeCycle](#lifecycle)
- [Balanceador de carga](#balanceador-de-carga)
- [aws_autoscaling_group - Balanceador de carga](#aws_autoscaling_group---balanceador-de-carga)
  - [health_check_type](#health_check_type)
  - [health_check_grace_period](#health_check_grace_period)
- [VPC](#vpc)
  - [aws_subnet_ids](#aws_subnet_ids)
- [Terraform Console](#terraform-console)
- [Interpolation Syntax](#interpolation-syntax)
  - [built-in-functions](#built-in-functions)
  - [string multilineas](#string-multilineas)
- [Templates en Terraform](#templates-en-terraform)
- [Terraform OUTPUT](#terraform-output)
  - [Acceder a outputs de otro proyecto](#acceder-a-outputs-de-otro-proyecto)
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
### fmt
```
$ terraform fmt
```
### validate
Este comando es util para validar la sintaxis de los archivos de definición de terraform.

```
$ terraform validate
```
### init

Este comando es necesario para descargar los plugins necesarios para el provider.
```
$ terraform init
```
### plan
Con este comando es posible ver los recursos que se crearan con la definición.
```
$ terraform plan
```
### apply
Finalmente cuando estamos seguros de lo que vamos a crear procedemos a aplicar. Esto creara la infraestructura que definimos que en este caso es una instance en AWS.
```
terraform apply
```
### destroy
Terraform tambien nos permite destruir la infraestructura creada.
```
$ terraform destroy
```
### graph
Terraform graph nos ayuda creando de una forma visual la infraestrutura
Ejmplo que lo devovlera en JSON para poder visualizar en otra plataform
```
terraform graph
```
Nos dibuja el grafico
```terraform graph | dot -Tsvg > graph.svg```

NOTA debemos instalar ```GraphViz```
### import
Recursos que han sido creado a mano, pueden ser importados por terraform, no muy factibles cuanod se tiene una infraestructura muy grande
https://www.terraform.io/docs/cli/commands/import.html

```terraform import aws_eip.eip <id_de_eip>```

### refresh
actualiza los estados locales contra los recursos reales
https://www.terraform.io/docs/cli/commands/refresh.html
### show
Nos permite inspeccionar los datos de los recursos
### comandos para el state
  - state list
  - state mv
  - state pull
  - state push
  - state replace-provider
  - state rm (Remover uno o mas items del estado)
  ```terraform state rm 'module.foo'```
  - state show
### taint y untaint
Marca un recursos con taint significa que ese recurso es invalido o tiene un marca-manchado y sera volvera a crearlo.
El terraform taintcomando marca manualmente un recurso administrado por Terraform como contaminado, lo que obliga a ser destruido y recreado en la siguiente aplicación.

El comando terraform untaint desmarca manualmente un recurso administrado por Terraform como contaminado, restaurándolo como la instancia principal en el estado. Esto revierte una alteración de terraformación manual o el resultado de que los aprovisionadores fallan en un recurso.

```terraform untaint [options] name```

### workspace
Para crear espacios de trabajo diferentes

### Interpolation Syntax con WorkSpaces
```
resource "aws_instance" "web" {
  subnet = "${var.env == "production" ? var.prod_subnet : var.dev_subnet}"
}
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

## Estados remotos con s3
Para poder trabajar en equipo con los estadados de la infraestructura en s3

https://www.terraform.io/docs/language/settings/backends/s3.html

```
terraform {
  backend "s3" {
    bucket = "terrafrom-states-snk"
    key    = "terraform/web_interface.tfstate"
    region = "us-east-1"
  }
}
```

## Estados lock 
En caso de que se este trabajando en equipo y guardando el estado de forma remota esto podria solucionar problemas, haciendo un bloqueo mientras un usuario esta escribiendo o realizando algunas modificaciones, y nadie mas podra trabajar hasta que este usuario libere ese lock

https://www.terraform.io/docs/language/state/locking.html

### El bloqueo se hace con DynamoDB

https://www.terraform.io/docs/language/settings/backends/s3.html#dynamodb-state-locking

https://medium.com/@jessgreb01/how-to-terraform-locking-state-in-s3-2dc9a5665cb6

- creamos una tabla
- Debemos tener acceso a la tabla con un user
  
 ``` 
 terraform {
  backend "s3" {
    bucket = "terrafrom-states-snk"
    key    = "terraform/web_interface.tfstate"
    region = "us-east-1"
    dynamodb_table = "TerraformLock"
  }
}
```
### Desbloqueo de LOCKID
En caso de que nuestro apply no haya terminado por X motivo podemos forzar un desbloqueo con el Id
https://www.terraform.io/docs/cli/commands/force-unlock.html

En consola digitar ```terraform force-unlock LOCK_ID```
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


creamos unos input en el modulo los cuales son las varibales que se usaran y cuando llamemos al modulo pasamos esas varibles en ese archivo.
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
tambien podesmos utilizar los --target para eliminar recursos especificos
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

# Data Source - AMI
Nos permiten acceder a data de AWS  existentes.
https://www.terraform.io/docs/language/data-sources/index.html
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance

```
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

```

El filter.values lo podes sacar simulando crear una ec2 desde la consola, luego recogemos el id, nos ridigimos al menu de ami, lo pegamos buscamos este valor en las amis publicas y copiamos el nombre excetuando los ultimos numero de esta ya que son la version de la ami.

# Data source VPC

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc
```
data "aws_vpc" "selected" {
  id = var.vpc_id
}
```
# AWS_lauch_configuration
Nos permitira que un Scaling Group cree una serie de instancias de forma automatica y esto le indicara como seran configuradas esas maquinas.

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration

```
resource "aws_launch_configuration" "as_conf" {
  name_prefix   = "web_config-${var.project_name}"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name
  security_group = [
    aws_security_group.allow_shh_anywhere.id,
    aws_security_group.allow_http_anywhere.id
  ]
  user_data = file("user-data.txt")
}
```
# Obtener el ID de una EC2

```instance_id=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)```

# lifeCycle
Nos permitira que cuando se modifique el recurso podamos asignar un comportamiento.
Sirve para en caso de alguna entindad necesite de otra y no podamos modificar el otro recurso sin crear otro.
https://www.terraform.io/docs/language/meta-arguments/lifecycle.html


# Balanceador de carga

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elb

```
# Create a new load balancer
resource "aws_elb" "web" {
  name = "${var.project_name}-elb-web"
  #   availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
  subnets = ["subnet-07e64336", "subnet-0260f35d"]
  listener {
    instance_port     = 80 # escuchaando
    instance_protocol = "http"
    lb_port           = 80 # redireccionar
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 5
    timeout             = 2
    target              = "HTTP:80/"
    interval            = 30
  }
  security_groups = [
    aws_security_group.allow_http_anywhere.id
  ]
  tags = {
    Name = "${var.project_name}-terraform-elb"
  }
}
```

# aws_autoscaling_group - Balanceador de carga

Podemos atachar el balanceador de carga al autoscaling
```
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group
```

```
load_balancers = [ aws_elb.web.name ]
load_balancers = [ aws_elb.<nombreAsignado>.name ]
```

##  health_check_type 
Sirve para poder checkerar el ELB o EC2
```health_check_type    = "ELB"```
## health_check_grace_period
Nos sirve para poder asiganar un tiempo desde que se inicia la maquina para comenzar a dar checkeos.

```health_check_grace_period = 10 # despues de encendida 10s comenzara el checkeo```
 
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group#health_check_grace_period

# VPC

```https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc```

## aws_subnet_ids

```https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids```
```
data "aws_vpc" "selected" {
  default = true
}
data "aws_subnet_ids" "selected" {
  vpc_id = data.aws_vpc.selected.id
}

```

# Terraform Console

Terraform nos provee una consola para poder hacer uso de ella y experimentar o debugear con las variables
```terraform console```

Obeter datos de los data sources sin necesidad de correr 

```var.project_name```
```data.aws_subnet_ids.selected.id```

# Interpolation Syntax
https://www.terraform.io/docs/configuration-0-11/interpolation.html
  ## built-in-functions
  Permiten transformar varibales
   https://www.terraform.io/docs/configuration-0-11/interpolation.html#built-in-functions

  - codifiar variables
  ```base64encode("hola")```  
 
## string multilineas
  ```
  <<EOT
  hello
  world
  EOT
```

# Templates en Terraform 
Terraform tiene sus plugin para poder iniciar lso template asique se debe ejecutar el ```terraform init```.

Ejemplo

template.tf
```
data "template_file" "user_data" {
  template = file("template.txt")
  vars = {
      test_var = "Test-values"
      project_name = var.project_name
    }
}
```

output.tf
```
output "template_rendered" {
  value = data.template_file.user_data.rendered
}
```

template.txt
```
Estas son las variables para el proyecto: ${project_name}
var 1: valor1
var 2: valor2
var 3: valor3
test varible value = ${test_var}
Nombre del proyecto = ${project_name}
```
# Terraform OUTPUT

Terraform tiene un comamndo para poder ver nuestros output
  ```terraform output``
  ```terraform output <nombreOutput>```
## Acceder a outputs de otro proyecto
Para acceder a output de otros poyectos
https://www.terraform.io/docs/language/state/remote-state-data.html

```
data "terraform_remote_state" "project1" {
  backend = "s3"
  config = {
    bucket = "terrafrom-states-snk"
    key    = "terraform/project1.tfstate"
    region = "us-east-1"
  }
}
```
podemos abrir la consola de terraform y escribir lo sigueinte para poder conocer la ip estatica que nuestro output del projecto 1 tiene

```
data.terraform_remote_state.project1.outputs.web_public_EIP
```
