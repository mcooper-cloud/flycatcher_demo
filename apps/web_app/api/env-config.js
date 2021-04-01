const {
  ISSUER_BASE_URL,
  AUTH0_DOMAIN,
  AUTH0_AUDIENCE,
  WEB_API_PORT,
  WEB_APP_PORT,
} = process.env;

const APP_URL = `http://localhost:${WEB_API_PORT}`;

function checkUrl() {
  return (req, res, next) => {
    const host = req.headers.host;
    if (!APP_URL.includes(host)) {
      return res.status(301).redirect(APP_URL);
    }
    return next();
  };
}

function removeTrailingSlashFromUrl(url) {
  if (!url.endsWith("/")) return url;
  return url.substring(0, url.length - 1);
}

module.exports = {
  checkUrl,
  APP_URL: APP_URL,
  ISSUER_BASE_URL: removeTrailingSlashFromUrl(AUTH0_DOMAIN),
  ALLOWED_AUDIENCES: AUTH0_AUDIENCE,
  PORT: WEB_API_PORT,
};
