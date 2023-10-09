## SSH

**Using SSH Key-based Authentication**:
```sh
ssh-keygen -t rsa -b 4096
```

## GPG

**Generate a GPG Key Pair:**
```sh
gpg --gen-key
```

**Export the Public Key:**
```sh
gpg --export -a "Your Name" > your_public_key.asc
```

**Import the Public Key on the Remote System:**
```sh
gpg --import your_public_key.asc
```
