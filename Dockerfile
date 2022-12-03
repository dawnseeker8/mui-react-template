# build environment
FROM node:18.8.0-alpine3.15 as build
WORKDIR /app
COPY package.json ./
COPY yarn.lock ./
RUN yarn install --frozon-lockfile
COPY . ./
RUN yarn build

# production environment
FROM nginx:stable-alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]