FROM node:20-alpine as builder

ENV NODE_ENV build


USER node
WORKDIR /home/node

COPY package.json ./
COPY yarn.lock ./
RUN yarn install

COPY --chown=node:node . .
RUN npm run build

# ---

FROM node:20-alpine as final

EXPOSE 3000

ENV NODE_ENV production

USER node
WORKDIR /home/node

COPY --from=builder --chown=node:node /home/node/package*.json ./
COPY --from=builder --chown=node:node /home/node/node_modules/ ./node_modules/
COPY --from=builder --chown=node:node /home/node/dist/ ./dist/

CMD ["node", "dist/main.js"]