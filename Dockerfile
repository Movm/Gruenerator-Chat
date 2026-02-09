# Gruenerator Chat — Standalone Dockerfile
# Multi-stage build for Next.js standalone output

# =============================================================================
# Stage 1: Builder
# =============================================================================
FROM node:22-alpine AS builder

WORKDIR /app

COPY package.json package-lock.json* ./
RUN npm ci

COPY . .

ENV NEXT_TELEMETRY_DISABLED=1
ENV NODE_ENV=production
RUN npm run build

# =============================================================================
# Stage 2: Production
# =============================================================================
FROM node:22-alpine AS runner
WORKDIR /app

ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/agents ./agents

USER nextjs

HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD node -e "require('http').get('http://localhost:3210/api/health', (r) => { process.exit(r.statusCode === 200 ? 0 : 1) })"

EXPOSE 3210

ENV PORT=3210
ENV HOSTNAME="0.0.0.0"

CMD ["node", "server.js"]
