# volsync-bucket

This terraform module is used to create:

1. a minio bucket + minio user + minio credentials
2. (optionally) an r2 bucket with an r2 api token
3. an item in 1password that contains the credentials and endpoints for minio and r2

It is designed to be used with volsync such that every application that is
backed up with volsync gets a local minio and remote r2 bucket. Credentials are
scoped per application.
