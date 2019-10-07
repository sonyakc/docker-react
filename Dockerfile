# build phase - one temporary container
FROM node:alpine as builder 
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# run phase - another container
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

