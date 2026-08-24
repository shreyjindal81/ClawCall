---
name: clawcall
description: Use when the user wants an AI agent to place a US phone call, call a business, handle hold or phone menus, confirm/reschedule/cancel/book/follow up/check an order, reach a real person, leave voicemail, or connect the user into a live call via ClawCall hosted MCP.
homepage: https://clawcall.dev
publisher: ClawCall
---

# ClawCall (hosted MCP)

ClawCall places real US phone calls for the signed-in user through the hosted MCP at `https://api.clawcall.dev/mcp` (OAuth 2.1).

Prefer the ClawCall MCP tools over the REST API when this plugin is installed.

## Before every call

1. Call `get_calling_guide` with topic `outbound` (required every time).
2. When writing Call instructions (`task`), also read topic `examples`.
3. Do not ask the user to confirm before placing a call once you have enough private details.

## Place a call

- Use `place_call` with US E.164 `to` (`+1` + 10 digits) and complete `task` Call instructions.
- Returns `call_id` immediately. Poll `get_call` until `lifecycle` is `finalized`, then `get_call_transcript` before reporting whether the user's goal succeeded.
- `outcome` is the phone network result, not task success.
- Use `bridge_number` only for live handoff, and put the handoff trigger in `task`.
- Do not run parallel calls that can book, buy, cancel, or commit.

## Guides

`get_calling_guide` topics: `outbound`, `examples`, `errors`, `profile`, `inbound`, `privacy`.

## Notes

- Hosted MCP uses OAuth — never ask for or invent an API key on this surface.
- Preserve any `action.url` on errors verbatim.
