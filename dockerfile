# Dockerfile
FROM node:18

# Tạo thư mục làm việc
WORKDIR /usr/src/app

# Sao chép package.json và cài đặt các gói
COPY package*.json ./
RUN npm install

# Sao chép mã nguồn vào container
COPY . .

# Mở cổng ứng dụng
EXPOSE 3000

# Chạy ứng dụng
CMD [ "npm", "start" ]

