# ---- Build stage ----
FROM node:20-alpine AS build
WORKDIR /app

# Install deps first for layer caching
COPY package.json package-lock.json* ./
RUN npm install

# Build the static site
COPY . .
RUN npm run build

# ---- Runtime stage ----
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html

# SPA fallback: route everything to index.html
RUN printf 'server {\n\
  listen 80;\n\
  server_name _;\n\
  root /usr/share/nginx/html;\n\
  index index.html;\n\
  location / {\n\
    try_files $uri $uri/ /index.html;\n\
  }\n\
}\n' > /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
