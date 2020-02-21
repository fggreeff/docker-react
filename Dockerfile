# Multi-step docker process 
# Step 1 - (builder)
FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm install 

COPY . . 
RUN npm run build 

# Step 2 - (run)
# only copy over bare min (build dicrectory) and serve up with nginx
FROM nginx 
COPY --from=builder /app/build /usr/share/nginx/html
