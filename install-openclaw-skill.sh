#!/bin/bash
# Install Telnyx Voice Agent skill for OpenClaw
# Usage: ./install-openclaw-skill.sh

set -e

SKILL_NAME="telnyx-voice-agent"
SKILL_DIR="${HOME}/.openclaw/workspace/skills/${SKILL_NAME}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing ${SKILL_NAME} skill for OpenClaw..."

# Create skill directory
mkdir -p "$SKILL_DIR"

# Copy skill files
cp "${SCRIPT_DIR}/telnyx_voice_agent.py" "$SKILL_DIR/"
cp "${SCRIPT_DIR}/requirements.txt" "$SKILL_DIR/"

# Create SKILL.md
cat > "$SKILL_DIR/SKILL.md" << 'EOF'
---
name: telnyx-voice-agent
description: Make AI-powered outbound phone calls using Telnyx telephony and Deepgram Voice Agent API. Supports multiple TTS voices (ElevenLabs, Deepgram) and LLM models.
metadata: {"openclaw": {"emoji": "📞", "requires": {"bins": ["python3"], "env": ["TELNYX_API_KEY", "TELNYX_CONNECTION_ID", "TELNYX_PHONE_NUMBER", "DEEPGRAM_API_KEY"]}, "os": ["darwin", "linux"]}}
---

# Telnyx Voice Agent

Make AI-powered outbound phone calls with customizable personas, voices, and behaviors.

## Prerequisites

Install Python dependencies (one-time):
```bash
pip install -r {baseDir}/requirements.txt
```

## Usage

When the user wants to make a phone call, collect:
- **phone_number** (required): E.164 format (e.g., +15551234567)
- **prompt** (optional): Custom system prompt for the AI agent persona
- **greeting** (optional): What the agent says when the call connects
- **voice** (optional): TTS voice - format: `provider/voice-id`
  - ElevenLabs: rachel, adam, bella, josh, elli, sam
  - Deepgram: aura-2-thalia-en, aura-2-orion-en, etc.
- **model** (optional): LLM model (default: claude-3-5-haiku-latest)

## Commands

### Make an outbound call:
```bash
python3 {baseDir}/telnyx_voice_agent.py --to "<phone_number>" --ngrok
```

### With custom persona:
```bash
python3 {baseDir}/telnyx_voice_agent.py --to "<phone_number>" --ngrok --prompt "<persona>" --greeting "<greeting>"
```

### With specific voice:
```bash
python3 {baseDir}/telnyx_voice_agent.py --to "<phone_number>" --ngrok --voice "elevenlabs/rachel"
```

### Full example:
```bash
python3 {baseDir}/telnyx_voice_agent.py \
  --to "+15551234567" \
  --ngrok \
  --prompt "You are a friendly sales representative from Acme Corp" \
  --greeting "Hi! This is Sarah from Acme Corp, how can I help you today?" \
  --voice "elevenlabs/rachel" \
  --model "claude-3-5-haiku-latest"
```

## Available Voices

**ElevenLabs** (high quality):
- elevenlabs/rachel - Female, American (default)
- elevenlabs/adam - Male, American
- elevenlabs/bella - Female, American
- elevenlabs/josh - Male, American

**Deepgram** (low latency):
- deepgram/aura-2-thalia-en - Female, American
- deepgram/aura-2-orion-en - Male, American
- deepgram/aura-2-athena-en - Female, British

## Notes

- The call runs until the other party hangs up or the agent triggers hangup
- ngrok tunnel is automatically managed (no manual setup needed)
- Environment variables must be configured in OpenClaw settings
EOF

echo ""
echo "✅ ${SKILL_NAME} skill installed to: $SKILL_DIR"
echo ""
echo "📦 Installed files:"
ls -la "$SKILL_DIR"
echo ""
echo "⚠️  Before using, configure these environment variables in OpenClaw:"
echo "   - TELNYX_API_KEY"
echo "   - TELNYX_CONNECTION_ID"
echo "   - TELNYX_PHONE_NUMBER"
echo "   - DEEPGRAM_API_KEY"
echo ""
echo "📚 Install Python dependencies with:"
echo "   pip install -r $SKILL_DIR/requirements.txt"
echo ""
echo "🎉 Done! Try asking OpenClaw: \"Call +15551234567\""
