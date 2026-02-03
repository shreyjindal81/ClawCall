# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

AI-powered phone agent using Deepgram Voice Agent API (STT + LLM + TTS) and Telnyx for telephony. Single-file Python application that bridges phone calls to an AI voice agent.

## Commands

```bash
# Run server only (receive inbound calls)
python telnyx_voice_agent.py --server-only --ngrok

# Make outbound call
python telnyx_voice_agent.py --to "+1234567890" --ngrok

# With custom agent persona
python telnyx_voice_agent.py --server-only --ngrok --prompt "You are..." --greeting "Hello!"

# Debug mode (verbose logging)
python telnyx_voice_agent.py --server-only --ngrok --debug

# Custom ngrok domain (paid plan)
python telnyx_voice_agent.py --server-only --ngrok --ngrok-domain your-domain.ngrok-free.dev
```

## Architecture

The system bridges async FastAPI with the synchronous Deepgram SDK using thread-safe queues:

```
Phone ←→ Telnyx (mulaw 8kHz) ←→ FastAPI ←→ Deepgram Thread (linear16 16kHz) ←→ Deepgram Voice Agent
```

**Threading model**: FastAPI runs async; Deepgram SDK is sync and runs in a dedicated thread. Communication happens via `queue.Queue`:
- `input_queue`: Telnyx audio → Deepgram
- `output_queue`: Deepgram audio → Telnyx

**Audio conversion**: Telnyx uses mulaw 8kHz (PCMU), Deepgram uses linear16 16kHz. Conversion via `audioop` (or `audioop-lts` for Python 3.13+).

**Barge-in**: When user interrupts, Deepgram sends `UserStartedSpeaking`. Handler clears output queue and sends `{"event": "clear"}` to Telnyx to stop playback immediately.

## Key Components in telnyx_voice_agent.py

- `CallSession`: Per-call state including thread-safe queues and threading events
- `deepgram_worker()`: Runs Deepgram connection in dedicated thread, handles message routing
- `SessionManager`: Creates/tracks/cleanup call sessions
- `CallManager`: Telnyx API wrapper for outbound calls and hangup
- `@app.websocket("/telnyx")`: Main WebSocket handler bridging Telnyx ↔ Deepgram
- `TOOL_HANDLERS`: Dict mapping function names to handlers (e.g., `get_secret`, `hangup`)

## Adding Custom Tools

1. Add handler to `TOOL_HANDLERS` dict
2. Add `AgentV1Function` definition in `create_agent_settings()`

## Environment Variables

Required: `TELNYX_API_KEY`, `TELNYX_CONNECTION_ID`, `TELNYX_PHONE_NUMBER`, `DEEPGRAM_API_KEY`

Optional: `NGROK_AUTH_TOKEN` (for `--ngrok`), `PUBLIC_WS_URL` (if not using ngrok), `SERVER_HOST`, `SERVER_PORT`
