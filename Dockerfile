FROM node:22-alpine AS build
WORKDIR /app
COPY site/package.json site/package-lock.json ./
RUN npm ci
COPY site/ ./
RUN npm run build

# unprivileged variant: runs as UID 101, pid/cache under /tmp — required
# because the pod securityContext enforces runAsNonRoot
FROM nginxinc/nginx-unprivileged:alpine
COPY site/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 8080
