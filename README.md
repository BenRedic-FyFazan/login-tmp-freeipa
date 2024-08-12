# Freeipa
Repository holds config to deploy and manage a freeipa server.
I highly recommended to set a remote backend before deploying the terraform resources. 

## Usage
### Supplying variables
Variables can either be supplied as environment variables or as a .tfvars file.
Ensure that files containing sensitive variables are placed in the .gitignore file.

If using a .tfvars file, create a "secrets.auto.tfvars" file in the "terraform" directory, and fill out the variables as such:

```conf
do_token = "[YOUR DO ACCESS TOKEN]"
ssh_key_path = "[PATH TO YOUR SSH KEY]"
freeipa_admin_password = "[FREEIPA ADMIN PASSWORD]"
freeipa_directory_manager_password = "[FREEIPA DIRECTORY MANAGER PASSWORD]"
```

If you instead want to use environment variables, prefix the above variables with "TF_VAR_", for example:

```shell
export TF_VAR_do_token="[YOUR DO ACCESS TOKEN]"
```

### Deploying resources
```shell
cd ./terraform
terraform apply
```

### Configuring / executing ansible. 
Because the clouds.terraform ansible plugin is in use, this must be run from the terraform directory!

install dependencies:
```shell
ansible-galaxy install -r ../ansible/requirements.yml
```

Configure freeipa:
```shell
ansible-playbook ../ansible/main.yml -i ../ansible/inventory.yml
```