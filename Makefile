first_admin:
	ansible-playbook ${TACO_HOME}/taco.yml -e tflayer=00-first-admin -e deploy_env=root -e deploy_region=eu-west-1 -e tfaction=apply

append_first_admin_name_to_taco_vars:
	terraform output -state=target/taco/00-first-admin/root.eu-west-1.tfstate for_taco >> ./terraform/all-layers.yml

organization:
	ansible-playbook ${TACO_HOME}/taco.yml -e tflayer=00-organization -e deploy_env=root -e deploy_region=eu-west-1 -e tfaction=apply

append_organization_to_taco_vars:
	terraform output -state=target/taco/00-organization/root.eu-west-1.tfstate accounts_id_for_taco >> ./terraform/all-layers.yml

tfbackend:
	ansible-playbook ${TACO_HOME}/taco.yml -e tflayer=00-tfbackend -e deploy_env=sec -e deploy_region=eu-west-1 -e tfaction=apply

append_backend_conf_to_taco_vars:
	terraform output -state=target/taco/00-tfbackend/sec.eu-west-1.tfstate backend_config_map >> ./terraform/all-layers.yml

move_first_admin_backend:
	ansible-playbook ${TACO_HOME}/taco.yml -e tflayer=00-first-admin -e deploy_env=root -e deploy_region=eu-west-1 -e tfaction=plan -e local_state_to_s3=true

move_organization_backend:
	ansible-playbook ${TACO_HOME}/taco.yml -e tflayer=00-organization -e deploy_env=root -e deploy_region=eu-west-1 -e tfaction=plan -e local_state_to_s3=true

move_tfbackend_backend:
	ansible-playbook ${TACO_HOME}/taco.yml -e tflayer=00-tfbackend -e deploy_env=sec -e deploy_region=eu-west-1 -e tfaction=plan -e local_state_to_s3=true

config:
	ansible-playbook ${TACO_HOME}/taco.yml -e tflayer=00-config -e deploy_env=sec -e deploy_region=eu-west-1 -e tfaction=apply

# Accesses
accesses-common:
	ansible-playbook ${TACO_HOME}/taco.yml -e tflayer=02-accesses-common -e deploy_env=root -e deploy_region=eu-west-3 -e tfaction=apply

accesses-keepers: accesses-common
	ansible-playbook ${TACO_HOME}/taco.yml -e tflayer=01-accesses-keepers -e deploy_env=root -e deploy_region=eu-west-3 -e tfaction=apply

accesses-builders:
	ansible-playbook ${TACO_HOME}/taco.yml -vv -e tflayer=02-accesses-builders -e deploy_env=root -e deploy_region=eu-west-3 -e tfaction=apply

accesses-settlers:
	ansible-playbook ${TACO_HOME}/taco.yml -vv -e tflayer=02-accesses-settlers -e deploy_env=root -e deploy_region=eu-west-3 -e tfaction=apply

accesses-watchers:
	ansible-playbook ${TACO_HOME}/taco.yml -vv -e tflayer=02-accesses-watchers -e deploy_env=root -e deploy_region=eu-west-3 -e tfaction=apply