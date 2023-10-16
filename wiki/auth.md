## SSH

**Using SSH Key-based Authentication**:
```sh
ssh-keygen -t rsa -b 4096
```

**If you are provided with a private key, save it to file `private_key`**

**Set Permission for the Private Key:**
```sh
chmod 600 /path/to/your/private-key
```

**SSH Connection:**
```sh
ssh -i /path/to/your/private-key user@remote-host
```

**Accept Host Key (First Connection):**
Type `yes` in order to accept the host key, the host key will be added to the `known_hosts` file.

However, we can also add the host key manually, with this syntax:
```sh
remote-hostname-or-IP key-type key-data
```

For example:
```sh
example.com ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8HUNkqfpvM4GqBF1eV2VXd8MYR0QwFbRlSgMa4g6Z6zDj02eVOQHFl4ru2H8xKzF7A6lkJ6+COFIqKNCgU4e9Y3F2OLAsbZKiLXQxDLi7fd/xI7r2NQgkXesSWjJEqsbH7Nq0TuhvUcC6xhC1v6Zp2O8XFUtw9M1yLHzPfGJ0lV3/rbT5jMbWz9hG8N2/uqBeTcy4pb6s3MafgimBCf4qH4QKl7zJQddDbHhxes+RuOeA3QrVTXY3Qr9ae3IJSgIUp02qFfNRHbyq0TCTwOr4GQv9c2xJ4jguHFUrVoBNlDH+R5xwFBaVwVzBpzhZ2AfPLh/RUdLcXrw9
```
