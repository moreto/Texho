# Texho API deployment

## Vercel project settings

Configure the linked Vercel project with:

- **Root Directory:** `api`
- **Framework Preset:** Other
- **Build Command:** `npm run build`
- **Install Command:** `npm ci`
- **Output Directory:** leave empty
- **Node.js Version:** 22.x

The serverless entry point is `api/index.ts`. It exports the Express app without
opening a listening socket. `vercel.json` routes requests to that function so
the existing `/api` and `/v1/...` endpoints remain available.

## Environment variables

Add these variables in the Vercel project's **Settings → Environment Variables**.
Set them for each environment that should be deployed (Production, Preview, and,
if needed, Development):

| Variable | Required | Purpose |
| --- | --- | --- |
| `PGHOST` | Yes | PostgreSQL host |
| `PGPORT` | No | PostgreSQL port; defaults to `5432` |
| `PGDATABASE` | Yes | PostgreSQL database |
| `PGUSER` | Yes | PostgreSQL user |
| `PGPASSWORD` | Yes | PostgreSQL password |
| `PGSSL` | No | Set to `false` only for a database that does not use TLS; otherwise TLS is enabled |
| `PGSSL_REJECT_UNAUTHORIZED` | No | Defaults to `true`. Set to `false` only when a trusted database presents a self-signed/untrusted certificate; TLS remains encrypted but the server certificate is not verified |
| `PGPOOL_MAX` | No | Maximum connections per function instance; defaults to `3` |
| `JWT_SIGNING_KEY` | Yes | Secret used to sign and verify API tokens |
| `ACCESS_TOKEN_ID` | Yes | Shared API access token; must match the value used by the App |
| `DATA_ENCRYPTION_KEY` | Yes | Base64-encoded key used by the API to encrypt/decrypt credentials |
| `OTP_EMAIL_USER` | Needed for OTP email | Gmail account used to send one-time codes |
| `OTP_EMAIL_PASSWORD` | Needed for OTP email | Gmail app password |

Never commit `.env`; use `.env.example` as the local template. Vercel injects
configured variables into deployed functions. After changing environment
variables, create a new deployment for the change to take effect.
Use a strong `JWT_SIGNING_KEY`; changing the current signing key invalidates
existing login tokens. `ACCESS_TOKEN_ID` must continue to match the value used
by the App. `DATA_ENCRYPTION_KEY` must be the same 32-byte base64 key used to
encrypt existing credentials; changing it without re-encrypting stored data
will prevent the API from decrypting those credentials. Revoke and rotate
credentials that were ever stored in tracked source files. SQL, parameters,
response payloads, and request URLs are not logged in production.

## Local development and build

Copy `.env.example` to `.env`, fill in local credentials, then run:

```sh
npm ci
npm run dev
```

If the database reports `self-signed certificate in certificate chain`, keep
`PGSSL=true` and set `PGSSL_REJECT_UNAUTHORIZED=false` in the local `.env`.
This keeps the connection encrypted but skips server certificate validation;
prefer configuring the database's CA certificate instead, and do not use this
setting in production unless the database certificate chain is trusted by
another means.

To verify the production TypeScript build:

```sh
npm run build
```

When the Git repository is connected and automatic deployments are enabled in
Vercel, pushing to the configured production branch triggers a production
deployment; pushes to other branches create Preview deployments.
