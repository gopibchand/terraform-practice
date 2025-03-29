This folder is for terraform work spaces

Here we created a module for re-use

terraform by default look for terraform.tfvars only, if you are providing values externally to module. if you user var.tfvars or diff name with extension as .tfvars terraform wont recognize.

if you want to call/use diff var file use CMD terraform apply -var-file=dev.tfvars

once we apply it, it will create a state file at terraform.state.d/dev/dev.state or terraform.state.d/prod/prod.state (depends on workspace we select) for now i added dummy files
