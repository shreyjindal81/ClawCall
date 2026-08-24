# ClawCall

Make real AI-powered phone calls from any AI agent. ClawCall dials the number, has the conversation, and brings back a full transcript.

**10 free minutes or 10 calls. No setup. No API keys to configure.**

## Hosted remote MCP

Remote MCP URL: `https://api.clawcall.dev/mcp`

Auth: OAuth 2.1 (authorization code + PKCE). No API key on this surface.

Add it as a custom / remote MCP connector in Cursor, ChatGPT, Claude, Cowork, Codex, or any host that supports Streamable HTTP MCP, then sign in to ClawCall when prompted.

Cursor plugin (this repo): install from the Cursor Marketplace once listed, or import this repository as a team/local marketplace. The plugin ships `mcp.json` pointed at the hosted endpoint plus a calling skill.

Official MCP registry: `io.github.ClawCall-Dev/clawcall`

See [`mcp/README.md`](./mcp/README.md) for the hosted MCP surface.

## Install From ClawHub

```bash
openclaw skills install clawcall-dev
```

Published skill: https://clawhub.ai/clawcall-dev/clawcall-dev

Or manually, download the skill zip from ClawHub and add `SKILL.md` to your agent's skills directory.

## What users learn on install

When the skill is installed or first introduced, the agent should explain:

- ClawCall makes real outbound phone calls in the US and Canada
- The AI can handle appointments, reservations, order checks, callbacks, office follow-ups, voicemail/messages, phone menus, and hold queues
- The user can be patched in live when a call needs identity verification, negotiation, or a real-time decision
- Users can configure reusable voice, personality, greeting, and inbound reserved-number answering preferences
- Completed calls return the outcome first, with transcript details and a temporary recording URL available
- New users get 10 free minutes or 10 calls, whichever comes first

## What it does

- Calls US and Canada phone numbers over real phone lines
- AI agent handles the full conversation based on your task briefing
- Leaves voicemail or takes messages when the task asks for it
- Returns a complete transcript and recording
- Live handoff: the AI navigates phone trees and hold queues, then connects you in to speak directly
- Reusable voice/personality profile setup for outbound and inbound answering
- Automatic retry and callback when a call needs more information

## Examples

> "Call Dr. Rivera's office and confirm my appointment for Tuesday at 2:30"

> "Phone the restaurant at +15551234567 and make a reservation for 4 people Saturday at 7 PM"

> "Get me through to a real person at my insurance company - here's the number"

## Links

- [Published ClawHub Skill](https://clawhub.ai/clawcall-dev/clawcall-dev)
- [ClawCall Dashboard](https://clawcall.dev)
- [API Documentation](https://clawcall.dev/docs)
- [Official MCP registry](https://registry.modelcontextprotocol.io/)

## License

MIT
