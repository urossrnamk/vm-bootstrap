## Bootstrap idempotency test

The complete bootstrap was executed a second time on an already
configured host.

All steps completed successfully.

Existing Docker containers were preserved:

- Traefik: `28e7ad6cba36`
- Demo: `95e562496218`
- Home: `dda09476fe26`

No containers were recreated.