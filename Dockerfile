# เลือก base image Node.js
FROM node:18-alpine

# ตั้ง working directory
WORKDIR /app

# คัดลอก package.json และ package-lock.json
COPY package*.json ./

# ติดตั้ง dependencies
RUN npm install

# คัดลอกไฟล์โปรเจกต์ทั้งหมด
COPY . .

# เปิด port ที่แอปใช้
EXPOSE 3000

# คำสั่งรันแอป (เปลี่ยนได้)
CMD ["npm", "start"]
