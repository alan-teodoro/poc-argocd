# poc-argocd

## Adding Redis Databases via ApplicationSet

To deploy a new `RedisEnterpriseDatabase`:

1. Create a new overlay directory under `charts/redis-database/overlays/<name>` and add a `values.yaml` file.
   Set the secret reference using `databaseSecretName: <name>-secret`.
2. Update `argocd/redis-db-appset.yaml` by adding a new element under
   `generators.list.elements` with the database `name` and path to the overlay's
   `values.yaml`.
3. Apply the modified ApplicationSet manifest to Argo CD.

The referenced secret must exist. Use the `redis-secret-appset` to create it per database.

## Managing Database Credentials

Secrets are also managed through an ApplicationSet. The chart's default values
define the `username` and `password` shared by all databases. To add credentials
for a new database:

1. Edit `argocd/redis-secret-appset.yaml` and append the database name under
   `generators.list.elements`.
2. Apply the updated ApplicationSet manifest to Argo CD.

The ApplicationSet will create one secret per database named `<db>-secret`
using the shared credentials.
