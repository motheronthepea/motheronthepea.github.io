# OVH Request DNS Access Token

This is a helper tool to request an access token for managing the DNS using
the API of OVH.

We need this to let Terraform update DNS records.

## Run

First you need to request an Application Key via https://eu.api.ovh.com/createApp/.

Or search for the Application Key via

- [`GET /me/api/application`](https://api.ovh.com/console/#/me/api/application#GET)
- [`GET /me/api/application/{applicationId}`](https://api.ovh.com/console/#/me/api/application/{applicationId}#GET)

With that Application Key execute the following command:

```bash
./req_auth_token.sh <application-key> dns_access_rules.json
```

Click on the validation URL you receive in the response to validate the Consumer Key.

## Revoke

To revoke credentials for an application:

- Browse to https://api.ovh.com/console
- Call [`GET /me/api/application`](https://api.ovh.com/console/#/me/api/application#GET)
  to retrieve the list of `applicationId`s.
- Call [`GET /me/api/credential`](https://api.ovh.com/console/#/me/api/credential#GET)
  to retrieve the list of `credentialId`s for an `applicationId`.
- Call [`DELETE /me/api/credential/{credentialId}`](https://api.ovh.com/console/#/me/api/credential/{credentialId}#DELETE)
  to delete the credential.
