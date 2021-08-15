const path = require('path')
const { exec } = require('child_process')
const express = require('express')
const config = require('./config')

const app = express()

app.use(express.static(path.resolve(__dirname, '..', 'src')))

app.listen(config.host.port, () => {
  exec(`ngrok http -region=${config.host.region} -subdomain=${config.host.subdomain} ${config.host.port}`)
  console.log(`Remote connect: ${config.host.url}`)
})
