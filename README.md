# Devops toolbox

Useful scripts to manage and automate k8s clusters, with vault secret cluster for storing secrets,
and an aws backend.

Generally the following configuration is required with rights depending on the action:

* `VAULT_TOKEN` and `VAULT_ADDR` for vault
* `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` for aws (or regular aws cli credentials at
`~/.aws`)
* A kubectl context

## create_cluster

Create a k8s cluster using kops, and possibly create a corresponding vault k8s backend.

Needs:

* kops group for aws
* vault-k8s-config rights

## delete_cluster

Use kops to delete an existing cluster. Needs kops group and vault auth disabling.

## vault-k8s-config

Configure a vault k8s auth backend. Can be called just after a k8s cluster has been created.
The requirements are as follows :

* The kubectl context set to the targeted k8s cluster, with the following rights:
  * Create service account
  * Create cluster role binding
  * Create service account token

* Vault access (through `$VAULT_TOKEN` and `$VAULT_ADDR`) and the following rights:
  * write access to `auth/kubernetes/$CLUSTER_NAME/config`

## vault-aws-config


Configure a vault aws secrets backend (for generating aws credentials).

* Vault access with write on secrets/
* Aws
  * Create a user, policy, attach policy to user

## redirect_subdomain

Add a dns CNAME dns record for given subdomain and target, and print the previous record if any
for later restoration.

For security we suggest using two hosted zone, one for a subpart of the domain for regular user
(e.g. env.my-project.com) and one for root subdomain, used in production.

* aws route 53 change record sets on the hosted zone controlling the subdomain.

## setup_kops

Setup kops in aws by creating kops groups and kops state store bucket.

Additionaly policies should be created later on to restrict access to the production clusters.

* Aws big access (admin / root, or see needed privileges in script)
