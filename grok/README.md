# ClawCall for Grok Build

This plugin connects Grok Build to ClawCall's OAuth-protected hosted MCP server.

## Capabilities

- Place outbound calls to US phone numbers with complete call instructions.
- Navigate phone menus and hold queues.
- Bridge the user into a live call when a person is reached.
- Poll call status and retrieve outcomes, transcripts, and temporary recording URLs.
- List inbound and outbound call history, end active calls, and inspect plan or trial usage.
- Read ClawCall's hosted calling guide before placing a call.

## Authentication and permissions

The first connection opens ClawCall's OAuth 2.1 authorization flow. Users sign in to their ClawCall account and approve:

- `calls:read` for call status, transcripts, recordings, history, balance, and calling guides.
- `calls:write` for placing and ending calls.

No API key, local secret, environment variable, hook, or executable is bundled with this plugin.

## Network access

- `https://api.clawcall.dev/mcp` — Streamable HTTP MCP endpoint.
- `https://api.clawcall.dev/.well-known/*` and `https://api.clawcall.dev/{authorize,token,register,revoke}` — OAuth discovery, authorization, dynamic client registration, token, and revocation endpoints.

OAuth discovery, authorization, token exchange, and revocation are published through the stable `api.clawcall.dev` origin.

## Safety and scope

Phone calls have real-world effects. Grok should confirm consequential instructions and decision boundaries before calling. The connector currently supports US phone numbers only.

## Links

- [ClawCall](https://clawcall.dev)
- [Documentation](https://clawcall.dev/docs)
- [Privacy policy](https://clawcall.dev/privacy)
- [Terms of service](https://clawcall.dev/terms)

## License

MIT. See [LICENSE](LICENSE).
