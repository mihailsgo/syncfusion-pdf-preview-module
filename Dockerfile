# Step 1: Use a Node base image to build the application
FROM node:18 as build

# Step 2: Set the working directory
WORKDIR /app

# Step 3: Copy package.json and package-lock.json
COPY package*.json ./

# Step 4: Install dependencies
RUN npm install

# Step 5: Copy the rest of the application
COPY . .

# Step 6: Build the application
RUN npm run build

# Step 7: Use an Nginx image to serve the build
FROM nginx:alpine

# Step 8: Copy the build output to Nginx's html directory
COPY --from=build /app/build /usr/share/nginx/html

# Step 9: Expose port 8087
EXPOSE 8087

# Step 10: Start Nginx
CMD ["nginx", "-g", "daemon off;"]