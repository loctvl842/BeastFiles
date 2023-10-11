## Dump data

```sh
pg_dump -h remote_host -U postgres -d mydb -f dump_file.sql
```

## List roles (users and groups)

Access the database and run this command:

```sh
SELECT rolname FROM pg_roles;
```

## Create new role

```sh
CREATE ROLE role_name;
```
