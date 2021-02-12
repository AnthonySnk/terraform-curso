project_name = "vcc-api"
environment = "produccion"

vpc_cidr_block = "192.168.0.0/16"

region = "us-east-1"
vpc_azs = ["us-east-1a","us-east-1b","us-east-1c"]

vpc_public_subnet_cidrs = [
	"192.168.10.0/24",
	"192.168.20.0/24",
	"192.168.30.0/24",
]

vpc_private_subnet_cidrs = [
	"192.168.11.0/24",
	"192.168.21.0/24",
	"192.168.31.0/24",
]
