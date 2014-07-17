AWS + New Relic test
====

## Usage

- Install Vagrant plugins

```
vagrant plugin install vagrant-aws
vagrant plugin install dotenv
```

- Write ```.env``` file

```
# default provider
VAGRANT_DEFAULT_PROVIDER="aws"

# credentials
AWS_SSH_USERNAME="ec2-user"
AWS_SSH_KEY="path to your vagrant.pem"
AWS_ACCESS_KEY_ID="your access key id"
AWS_SECRET_ACCESS_KEY="your secret"
AWS_KEYPAIR_NAME="vagrant"
AWS_SECURITY_GROUP="vagrant"
```


