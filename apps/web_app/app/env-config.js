const {
  ISSUER_BASE_URL,
  API_URL,
  CLIENT_ID,
  CLIENT_SECRET,
  PORT = 7000,
  AUDIENCE = "https://longclaw-api"
} = process.env;

function session_secret(length) {
   var result           = '';
   var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
   var charactersLength = characters.length;
   for ( var i = 0; i < length; i++ ) {
      result += characters.charAt(Math.floor(Math.random() * charactersLength));
   }
   return result;
}

const appUrl = `http://localhost:${PORT}`;

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
  if (!url || !url.endsWith("/")) return url;
  return url.substring(0, url.length - 1);
}

module.exports = {
  checkUrl,
  APP_URL: appUrl,
  API_URL: removeTrailingSlashFromUrl(API_URL),
  ISSUER_BASE_URL: removeTrailingSlashFromUrl(ISSUER_BASE_URL),
  CLIENT_ID: CLIENT_ID,
  CLIENT_SECRET: CLIENT_SECRET,
  SESSION_SECRET: session_secret(64),
  PORT: PORT,
};