# Stage 1: Build the React app
FROM node:14 AS build
WORKDIR /app

# Install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the source code and build the app
COPY . ./
RUN npm run build

# Stage 2: Serve the app with a lightweight web server
FROM node:14-alpine
WORKDIR /app

# Install serve globally
RUN npm install -g serve

# Copy the build output to the current directory
COPY --from=build /app/build ./build

# Expose port 3000
EXPOSE 3000

# Use serve to serve the static files
CMD ["serve", "-s", "build", "-l", "3000"]