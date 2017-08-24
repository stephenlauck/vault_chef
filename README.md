# vault_chef

### Requires
[https://www.vagrantup.com/downloads.html](https://www.vagrantup.com/downloads.html)

[https://downloads.chef.io/chefdk](https://downloads.chef.io/chefdk)

[https://www.virtualbox.org/wiki/Downloads](https://www.virtualbox.org/wiki/Downloads)

### Run
`kitchen converge vault-cluster-.*-cent`

### Validate
`kitchen verify vault-cluster-.*-cent`

### Walkthrough

```
$ kitchen login vault-cluster-01-centos-73
Last login: Thu Aug 24 21:57:58 2017 from 10.0.2.2
```
```
[vagrant@vault-cluster-01-centos-73 ~]$ vault init
Unseal Key 1: OtD3hRbWrh1c+ekidybDTiQNf+N4/Jke1q1+nf8Nvgvy
Unseal Key 2: dHtDdUDd4YbRaL/kgdnSZOqXUoRjchXk40zErRPJ3Bv/
Unseal Key 3: NG3dEN39rCE1WhG3FpiShFZglJd2N7FmMqMW9Ei/yTSy
Unseal Key 4: 9od9KOG8/4UdKMPWWXONhwOlX2kSdFEHjg09hxcxApwk
Unseal Key 5: 6nWMWfzR8OH+EyQsE4RA1NWNkskqc2p3Pc7rwm14aIgY
Initial Root Token: 302762ef-9a69-72cd-abd7-26a0608ca0db

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
Unseal Nonce: 7d7b1c9e-f90a-1880-ce01-64b81ca553fb
```
```
[vagrant@vault-cluster-01-centos-73 ~]$ vault unseal
Key (will be hidden):
Sealed: true
Key Shares: 5
Key Threshold: 3
Unseal Progress: 2
Unseal Nonce: 7d7b1c9e-f90a-1880-ce01-64b81ca553fb
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
Cluster Name: vault-cluster-de2070f5
Cluster ID: c866e8c1-8e2c-8b48-3e42-f0cdb40057d0

High-Availability Enabled: true
	Mode: active
	Leader Cluster Address: https://10.0.10.10:8201
```
```
[vagrant@vault-cluster-01-centos-73 ~]$ vault auth
Token (will be hidden):
Successfully authenticated! You are now logged in.
token: 302762ef-9a69-72cd-abd7-26a0608ca0db
token_duration: 0
token_policies: [root]
```
```
[vagrant@vault-cluster-01-centos-73 ~]$ vault write secret/foo value=bar
Success! Data written to: secret/foo
```
```
[vagrant@vault-cluster-01-centos-73 ~]$ vault read secret/foo
Key             	Value
---             	-----
refresh_interval	768h0m0s
value           	bar

[vagrant@vault-cluster-01-centos-73 ~]$
```

### DNS
`dig +short @127.0.0.1 -p 8600 active.vault.service.consul. ANY`
