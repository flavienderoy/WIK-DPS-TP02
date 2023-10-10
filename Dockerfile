FROM node:20-alpine
COPY . /app
WORKDIR /app
RUN npm install 
RUN ["npm", "run" , "build"]

#Prod Container
FROM node:20-buster
COPY --from=0 /app/build/index.js /prod/index.js
RUN ["useradd", "-m", "-s", "/bin/sh", "runner"]
WORKDIR /prod
RUN chown -R runner:runner /prod
USER runner
EXPOSE 8080
CMD node index.js