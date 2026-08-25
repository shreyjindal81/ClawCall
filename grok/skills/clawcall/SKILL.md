---
name: clawcall
description: >-
  Use when the user wants Grok to place a US phone call, call a business, handle
  hold or phone menus, confirm/reschedule/cancel/book/follow up, reach a real
  person, leave voicemail, or bridge the user into a live call via ClawCall.
homepage: https://clawcall.dev
---

# ClawCall

ClawCall places real US phone calls for the signed-in user through the hosted MCP
at `https://api.clawcall.dev/mcp` (OAuth 2.1).

## Before every call

1. Call `get_calling_guide` with topic `outbound` (required every time).
2. When writing Call instructions (`task`), also read topic `examples`.
3. Confirm consequential goals and decision boundaries with the user before
   placing a call that can book, buy, cancel, pay, or otherwise commit.

## Place a call

- Use `place_call` with US E.164 `to` (`+1` + 10 digits) and complete `task`
  Call instructions (who you represent, goal, known facts, questions,
  alternatives, what not to promise, voicemail behavior, what to report).
- Returns `call_id` immediately. Poll `get_call` until `lifecycle` is
  `finalized`, then `get_call_transcript` before reporting whether the user's
  goal succeeded.
- `outcome` is the phone network result, not task success.
- Use `bridge_number` only for live handoff, and put the handoff trigger in
  `task`.
- Do not run parallel calls that can book, buy, cancel, or commit.

## Guides

`get_calling_guide` topics: `outbound`, `examples`, `errors`, `profile`,
`inbound`, `privacy`.

## Notes

- Hosted MCP uses OAuth — never ask for or invent an API key.
- Preserve any `action.url` on errors verbatim.
- US numbers only.
