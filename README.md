# Hermes Web UI

**Access your self-hosted AI agent from any browser — same capabilities as the terminal, zero friction.**

[![CLI build](https://github.com/nesquena/hermes-webui/actions/workflows/cli.yml/badge.svg)](https://github.com/nesquena/hermes-webui/actions)
[![Docs build](https://github.com/nesquena/hermes-webui/actions/workflows/docs.yml/badge.svg)](https://github.com/nesquena/hermes-webui/actions)

Hermes WebUI puts a full web interface on [Hermes Agent](https://hermes-agent.nousresearch.com/) — the autonomous agent that remembers who you are, what you worked on, and gets smarter the longer it runs. No build step. No framework. No bundler. One command to run.

---

## What you get

**Full CLI parity in a browser tab:**

- Streaming AI responses — tokens appear as they're generated
- Inline tool call cards — expand/collapse, see args and results
- Session management — pin, archive, search, tag, group by date
- File browser with syntax-highlighted preview — edit, create, delete files
- Scheduled cron jobs — create, pause, resume, view run history
- Skills editor — browse, search, create and edit reusable agent procedures
- Voice input via Web Speech API
- 6 built-in themes + custom theme support

**Everything that works in the terminal works here** — because it all goes through the same Hermes agent.

---

## Quick start

```
# One command. That's it.
HERMES_WEBUI_PASSWORD=yourpassword hermes-agent venv/bin/python server.py
```

Then open `http://localhost:8787` in your browser.

> **Requires:** [Hermes Agent](https://github.com/nesquena/hermes-agent) running locally, or set `HERMES_WEBUI_AGENT_DIR` to point to its directory.

For a public URL (HTTPS, no SSH tunnel needed):

```
# Cloudflare quick tunnel — URL changes on restart
cloudflared tunnel --url http://localhost:8787
```

For a **stable public URL**, use a [named Cloudflare tunnel](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/get-started/create-forever tunnels/) or deploy as a Docker container.

---

## Screenshots

Full three-panel layout — sessions + tools left, chat center, workspace right:

<img width="1417" height="867" src="https://github.com/user-attachments/assets/51adff98-53ee-4800-8508-78b6c34dd3dc" />

---

## Why Hermes + WebUI

Most AI tools reset every session. You re-explain yourself every time. You don't know what they worked on last week.

Hermes is different:

- **Persistent memory** — learns your environment, your preferences, your conventions. Doesn't forget.
- **Self-hosted scheduling** — fires cron jobs while you're offline, delivers results to Telegram, Discord, Slack, email, Signal, and more
- **10+ messaging platforms** — same agent reachable from your phone
- **Self-improving skills** — Hermes writes and saves its own skills from experience
- **Provider-agnostic** — OpenAI, Anthropic, Google, DeepSeek, Nous Portal, OpenRouter, MiniMax, and more
- **Your hardware, your data** — self-hosted, nothing leaves your server

And now it's available in a browser tab, with full session history, file browsing, and scheduled job management.

---

## Comparison

| | Claude Code | Codex CLI | OpenCode | Hermes |
|---|---|---|---|---|
| Persistent memory (auto) | Partial | Partial | Partial | **Yes** |
| Scheduled jobs (self-hosted) | No | No | No | **Yes** |
| Messaging app access | Partial | No | No | **Yes (10+)** |
| Web UI (self-hosted) | No | No | Yes | **Yes** |
| Self-improving skills | No | No | No | **Yes** |
| Python / ML ecosystem | No | No | No | **Yes** |
| Provider-agnostic | No (Claude only) | Yes | Yes | **Yes** |
| Open source | No | Yes | Yes | **Yes** |

---

## All features

### Chat and agent
- Streaming SSE responses — tokens render in real-time as they're generated
- Multi-provider model support — dropdown populated from your configured API keys
- Queue outgoing messages while a response is in progress
- Inline edit any past user message and regenerate from that point
- Retry last assistant response with one click
- Cancel running tasks from the activity bar
- Tool call cards — name, args, result snippet; expand/collapse all toggle
- Subagent delegation cards — child agent activity shown with distinct styling
- Mermaid diagram rendering inline (flowcharts, sequence diagrams, gantts)
- Thinking/reasoning display — collapsible gold-themed cards for extended thinking
- Approval card for dangerous shell commands (allow once / session / always / deny)
- SSE auto-reconnect on network blips
- File attachments persist across page reloads
- Message timestamps; code block copy button
- Syntax highlighting via Prism.js (Python, JS, bash, JSON, SQL, and more)
- Context usage indicator — token count and cost fill bar in composer footer

### Sessions
- Create, rename, duplicate, delete, search by title and message content
- Pin/star sessions to top (gold indicator)
- Archive sessions without deleting
- Session projects — named groups with colors
- Session tags — `#tag` in titles creates colored chips and click-to-filter
- Grouped by Today / Yesterday / Earlier (collapsible)
- Download as Markdown, JSON export, JSON import
- CLI session bridge — CLI sessions from `hermes-agent`'s SQLite store appear with a gold "cli" badge
- Token/cost display per conversation

### Workspace file browser
- Directory tree — single-click toggle expand/collapse, double-click navigate
- Breadcrumb navigation
- Preview text, code, Markdown (rendered), and images inline
- Edit, create, delete, rename files; create folders
- Git detection — branch name and dirty file count badge
- Drag-resizable right panel
- Syntax highlighted code preview

### Voice input
- Microphone button in composer (Web Speech API)
- Live interim transcription; auto-stops after ~2s silence
- Works in Chrome, Edge, Safari

### Profiles
- Profile picker in topbar — gateway status dots, model info, skill count
- Create, switch, delete profiles from the sidebar
- Seamless switching — no server restart required

### Themes
- 6 built-in: Dark (default), Light, Slate, Solarized Dark, Monokai, Nord
- Switch instantly via Settings or `/theme` command
- Custom themes via CSS — dead simple, see [THEMES.md](THEMES.md)

### Security
- Optional password auth — off by default (zero friction on localhost)
- Enable with `HERMES_WEBUI_PASSWORD` env var or Settings panel
- HMAC-signed HTTP-only cookie, 24h TTL
- Security headers on all responses
- 20MB POST body limit

---

## Running with Docker

```bash
# With password auth
HERMES_WEBUI_PASSWORD=secret docker compose up

# Without auth (localhost only)
docker compose up
```

Open `http://localhost:8787`.

---

## Configuration reference

| Env var | Default | Description |
|---|---|---|
| `HERMES_WEBUI_PORT` | `8787` | Port to listen on |
| `HERMES_WEBUI_HOST` | `127.0.0.1` | Host to bind to |
| `HERMES_WEBUI_PASSWORD` | _(none)_ | Enable password auth |
| `HERMES_WEBUI_AGENT_DIR` | _(auto-discovered)_ | Path to Hermes Agent |
| `HERMES_WEBUI_STATE_DIR` | `~/.hermes/webui-mvp/` | Where sessions, workspaces, settings live |
| `HERMES_WEBUI_DEFAULT_WORKSPACE` | _(auto-detected)_ | Default workspace directory |
| `HERMES_WEBUI_DEFAULT_MODEL` | _(from agent config)_ | Default model in dropdown |
| `HERMES_HOME` | `~/.hermes` | Hermes config root |

---

## Architecture

```
server.py               HTTP routing + auth middleware
api/
  auth.py               Password auth, signed cookies
  config.py             Discovery, globals, model detection
  models.py             Session CRUD + CLI bridge
  routes.py             All GET + POST route handlers
  streaming.py          SSE engine, agent runner, cancel support
  workspace.py          File ops, git detection
static/
  index.html            HTML template
  *.js                  Vanilla JS — no framework, no build step
  style.css             All CSS incl. mobile responsive
tests/
  test_sprint*.py       22 test files, 430+ tests
```

State is stored outside the repo. Point `HERMES_WEBUI_STATE_DIR` at any directory you control.

---

## Docs

- [HERMES.md](HERMES.md) — why Hermes, mental model, full comparison
- [ARCHITECTURE.md](ARCHITECTURE.md) — API endpoints, system design, implementation notes
- [THEMES.md](THEMES.md) — theme system and custom theme guide
- [TESTING.md](TESTING.md) — manual browser test plan
- [CHANGELOG.md](CHANGELOG.md) — release notes
- [ROADMAP.md](ROADMAP.md) — feature roadmap

---

## Repo

```
git@github.com:nesquena/hermes-webui.git
```
