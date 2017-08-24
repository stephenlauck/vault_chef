# vault_chef

### Requires
[https://www.vagrantup.com/downloads.html](https://www.vagrantup.com/downloads.html)

[https://downloads.chef.io/chefdk](https://downloads.chef.io/chefdk)

[https://www.virtualbox.org/wiki/Downloads](https://www.virtualbox.org/wiki/Downloads)

### Install
`kitchen converge vault-cluster-.*-cent`

### Validate

### Walkthrough

```
[vagrant@vault-cluster-01-centos-73 ~]$ vault init
Unseal Key 1: NUhneuSQ3tv1K0CH1stPMl6219MoKzDpTfEVla5Idao9
Unseal Key 2: rUXglaCmoYIZJ0C7dT9nce+lcP1QgGEgu20iH37RBdjA
Unseal Key 3: Cx19F5rmIc1eOcVjggasZmEs0PIeqfFnoDt4JdbBG67Y
Unseal Key 4: tFttXfoyT+5/0QZAqvrVei6aRoKsox+cL9gLCfkoW7JV
Unseal Key 5: sxkHvhmNVfJJR+2okF+79ZJvbYmp68mlXKS7Rr0uo49D
Initial Root Token: 715cffca-1df7-01e3-abe9-b0f138092bb5

Vault initialized with 5 keys and a key threshold of 3. Please
securely distribute the above keys. When the vault is re-sealed,
restarted, or stopped, you must provide at least 3 of these keys
to unseal it again.

Vault does not store the master key. Without at least 3 keys,
your vault will remain permanently sealed.
```
```
[vagrant@vault-cluster-01-centos-73 ~]$ vault unseal
Key (will be hidden):
Sealed: true
Key Shares: 5
Key Threshold: 3
Unseal Progress: 1
Unseal Nonce: 11f6dda5-7693-2fe0-1e84-6f0d6e447184
```
```
[vagrant@vault-cluster-01-centos-73 ~]$ vault unseal
Key (will be hidden):
Sealed: true
Key Shares: 5
Key Threshold: 3
Unseal Progress: 2
Unseal Nonce: 11f6dda5-7693-2fe0-1e84-6f0d6e447184
```
```
[vagrant@vault-cluster-01-centos-73 ~]$ vault unseal
Key (will be hidden):
Sealed: false
Key Shares: 5
Key Threshold: 3
Unseal Progress: 0
Unseal Nonce:
```
```
[vagrant@vault-cluster-01-centos-73 ~]$ vault status
Sealed: false
Key Shares: 5
Key Threshold: 3
Unseal Progress: 0
Unseal Nonce:
Version: 0.8.1
Cluster Name: vault-cluster-7515a8a3
Cluster ID: f5c21eca-9c6e-cabb-b74c-2fde4d54839b

High-Availability Enabled: true
	Mode: active
	Leader Cluster Address: https://10.0.10.10:8201
```
```
[vagrant@vault-cluster-01-centos-73 ~]$ vault auth
Token (will be hidden):
Successfully authenticated! You are now logged in.
token: 715cffca-1df7-01e3-abe9-b0f138092bb5
token_duration: 0
token_policies: [root]
```
```
[vagrant@vault-cluster-01-centos-73 ~]$ vault write secret/foo value=bar
Success! Data written to: secret/foo
[vagrant@vault-cluster-01-centos-73 ~]$
```
