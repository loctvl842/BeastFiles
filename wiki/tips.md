## Make a directory readonly

```sh
chmod -R a-wx /path/to/directory
```

- `chmod`: This is the command for changing file permissions.
- `-R`: It stands for "recursive," which means it will apply the permission change to all files and subdirectories within the specified directory.
- `a-wx`: This part specifies the permission changes:
    - `a`: It stands for "all" or "everyone."
    - `-`: It indicates the removal of permissions.
    - `w`: It removes write permission.
    - `x`: It removes execute permission.
