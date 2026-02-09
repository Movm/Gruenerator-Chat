# Grünerator Chat

AI-powered chat interface for the German Green Party (Bündnis 90/Die Grünen).

> **Note:** This repository is an automated mirror of the chat module from the
> [Grünerator monorepo](https://github.com/netzbegruenung/gruenerator).
> Please open issues and pull requests there.

## Features

- Multi-agent AI chat with specialized assistants (speech writer, PR, citizen services, etc.)
- Real-time streaming responses via AI SDK
- Keycloak OIDC authentication with multiple identity providers
- Dark/light theme support
- File upload and attachment support
- Chat history with sidebar navigation

## Getting Started

```bash
# Install dependencies
npm install

# Copy and configure environment variables
cp .env.example .env

# Start development server
npm run dev
```

The app runs on [http://localhost:3210](http://localhost:3210).

## Docker

```bash
docker build -t gruenerator-chat .
docker run -p 3210:3210 --env-file .env gruenerator-chat
```

## Deploy with Coolify

This repo includes a `.coolify.yml` and a Dockerfile with a built-in health check,
so it works out of the box with [Coolify](https://coolify.io):

1. Add this repository as a new resource in Coolify
2. Coolify auto-detects the Dockerfile and builds the image
3. Configure the required environment variables in the Coolify UI (see `.env.example`)
4. Deploy — Coolify will wait for the health check at `/api/health` before marking the service as ready

## Environment Variables

See [`.env.example`](.env.example) for all available configuration options.

## License

This project is licensed under the [GNU General Public License v3.0](LICENSE).
