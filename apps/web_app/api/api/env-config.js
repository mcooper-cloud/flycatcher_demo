const {
  ISSUER_BASE_URL,
  ALLOWED_AUDIENCES,
//  CONTAINER_NAME = 'api',
  CONTAINER_NAME = 'localhost',
  PORT = 5000,
} = process.env;

const appUrl = `http://${CONTAINER_NAME}:${PORT}`;

function checkUrl() {
  return (req, res, next) => {
    const host = req.headers.host;
    if (!appUrl.includes(host)) {
      return res.status(301).redirect(appUrl);
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
  APP_URL: appUrl,
  ISSUER_BASE_URL: removeTrailingSlashFromUrl(ISSUER_BASE_URL),
  ALLOWED_AUDIENCES: ALLOWED_AUDIENCES,
  PORT: PORT,
};
