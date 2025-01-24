FROM node:16-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
RUN chmod +x /app/*
COPY . .
EXPOSE 3000
CMD ["npm", "start"]