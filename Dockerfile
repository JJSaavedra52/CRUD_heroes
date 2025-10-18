# Specify the Dart SDK base image version using dart:<version> (ex: dart:2.12)
#dart:3.17
FROM plugfox/flutter:stable-web AS build
LABEL authors="JUANCHOPE"

# Resolve app dependencies.
WORKDIR /app
COPY pubspec.* ./
RUN flutter pub get

# Copy app source code and AOT compile it.
COPY . .
# Build the Flutter app
RUN flutter create --platforms web .
RUN flutter build web

# Use a minimal web server image to serve the built app
FROM nginx:alpine AS runtime

# Copy the built app from the previous stage
COPY --from=build /app/build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Run the web server
CMD ["nginx", "-g", "daemon off;"]