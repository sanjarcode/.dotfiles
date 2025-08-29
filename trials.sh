#!/usr/bin/env sh

source ~/.dotfiles/.env.sh

agent-tars \
--provider anthropic \
--model claude-3-7-sonnet-latest \
--apiKey "$ANTHROPIC_API_KEY" \
--workspace ~/agent-tars-workspace
