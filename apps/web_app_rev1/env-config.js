const {
  AUTH0_DOMAIN,
  WEB_APP_PORT,
  AUTH0_CLIENT_ID,
  AUTH0_CLIENT_SECRET,
  AUTH0_ISSUER_BASE_URL
} = process.env;

/*
const {
  ISSUER_BASE_URL,
  API_URL,
  CLIENT_ID,
  CLIENT_SECRET,
  SESSION_SECRET = "e6de1374433dde92a5bae567b56b01de32ad0d4f0115b7675f5b985720210f4c",
  VERCEL_URL,
  VERCEL_GITHUB_REPO,
  VERCEL_GITHUB_ORG,
  PORT = 7000,
} = process.env;
*/

function session_secret(length) {
   var result           = '';
   var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
   var charactersLength = characters.length;
   for ( var i = 0; i < length; i++ ) {
      result += characters.charAt(Math.floor(Math.random() * charactersLength));
   }
   return result;
}

//const APP_URL =`http://localhost:${PORT}`
const APP_URL =`http://localhost:${WEB_APP_PORT}`

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
  if (!url || !url.endsWith("/")) return url;

  return url.substring(0, url.length - 1);
}

/*
console.log("\n----------------------------------");
console.log("Envronment Settings:");
console.log(`CLIENT_ID: ${AUTH0_CLIENT_ID}`);
if (AUTH0_CLIENT_SECRET) console.log(`CLIENT_SECRET: Has Value`);
else console.log(`CLIENT_SECRET: Not Set`);
console.log(`APP_URL: ${APP_URL}`);
console.log(`SESSION_SECRET: ${SESSION_SECRET}`);
console.log("----------------------------------\n");
*/

module.exports = {
  checkUrl,
  APP_URL: APP_URL,
  CLIENT_ID: AUTH0_CLIENT_ID,
  CLIENT_SECRET: AUTH0_CLIENT_SECRET,
  SESSION_SECRET: session_secret(64),
  PORT: WEB_APP_PORT,
  ISSUER_BASE_URL: AUTH0_ISSUER_BASE_URL
};
