# Devops toolbox

Useful scripts to manage and automate k8s clusters, with vault secret cluster for storing secrets,
and an aws backend.

## vault-k8s-config

Configure a vault k8s auth backend. Can be called just after a k8s cluster has been created.
The requirements are as follows :

* The kubectl context set to the targeted k8s cluster, with the following rights:
  * Create service account
  * Create cluster role binding
  * Create service account token

* Vault access (through `$VAULT_TOKEN` and `$VAULT_ADDR`) and the following rights:
  * write access to `auth/kubernetes/$CLUSTER_NAME/config`
