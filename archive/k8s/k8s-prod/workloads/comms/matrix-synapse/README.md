# create database manually

until crunch postgres supports settings the locale you have to manually change it.

1. Ensure the matrix-synapse deployments are offline. You can't do this while they are trying to connect to the DB
2. Exec into the master pod of your pg cluster in k8s and run the following:

  ``` sh
  psql
  DROP DATABASE "synapse";
  CREATE DATABASE "synapse" with template=template0 owner="synapse" encoding=UTF8 locale='C';
  GRANT ALL PRIVILEGES ON DATABASE "synapse" to "synapse";
  ```

  Obviously, replace the user/role/db name with the appropriate information. You can get those values by running \l to get the db name and \du to get the user/role name.
