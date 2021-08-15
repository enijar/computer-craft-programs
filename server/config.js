const PORT = 1337
const SUBDOMAIN = 'enijar'
const REGION = 'eu'

module.exports = {
  host: {
    port: PORT,
    subdomain: SUBDOMAIN,
    region: REGION,
    url: `http://${SUBDOMAIN}.${REGION}.ngrok.io`,
  }
}
