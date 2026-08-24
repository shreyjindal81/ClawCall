# ClawCall MCP

Hosted remote MCP for ClawCall — AI-powered US phone calling.

## Endpoint

```text
https://api.clawcall.dev/mcp
```

- Transport: Streamable HTTP (MCP `2026-07-28`, legacy negotiation supported)
- Auth: OAuth 2.1 (authorization code + PKCE). No API key on this surface.
- Clients: Cursor, ChatGPT, Claude, Cowork, Codex, and other remote MCP hosts

Add the URL as a custom / remote MCP connector and sign in to ClawCall when prompted.

Official registry name: `io.github.ClawCall-Dev/clawcall`

## Workflow

1. Call `get_calling_guide` with topic `outbound` before every `place_call`.
2. `place_call` returns `call_id` immediately.
3. Poll `get_call` until `lifecycle` is `finalized`, then read `get_call_transcript`.
4. `outcome` is the phone network result, not task success.

Product site: https://clawcall.dev  
Docs: https://clawcall.dev/docs
