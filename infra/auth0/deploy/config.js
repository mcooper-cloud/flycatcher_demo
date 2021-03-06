
const { deploy, dump } = require("auth0-deploy-cli");

const config = {
    AUTH0_DOMAIN: process.env.AUTH0_DOMAIN,
    AUTH0_CLIENT_SECRET: process.env.AUTH0_CLIENT_SECRET,
    AUTH0_CLIENT_ID: process.env.AUTH0_CLIENT_ID,
    AUTH0_EXPORT_IDENTIFIERS: false,
    AUTH0_ALLOW_DELETE: true,
    AUTH0_API_MAX_RETRIES: 10,
    AUTH0_KEYWORD_REPLACE_MAPPINGS: {
        "PROJECT_NAME": process.env.PROJECT_NAME,
        "ENVIRONMENT": process.env.ENVIRONMENT,
        "SYSTEM_NUMBER": process.env.SYSTEM_NUMBER,
        "AUTH0_SUBDOMAIN": process.env.AUTH0_SUBDOMAIN,
        "AUTH0_MGMT_API_ENDPOINT": process.env.AUTH0_MGMT_API_ENDPOINT,
        "AUTH0_CALLBACK_URL" : process.env.AUTH0_CALLBACK_URL,
        "AUTH0_LOGOUT_URL" : process.env.AUTH0_LOGOUT_URL,
        "AUTH0_AUDIENCE" : process.env.AUTH0_AUDIENCE
        "LOGO_URL" : process.env.LOGO_URL
    },
};


deploy({
    input_file: process.env.INPUT_PATH, // Input file for directory, change to .yaml for YAML
    base_path: 'a0deploy', // Allow to override basepath, if not take from input_file
    config: config, // Option to sent in json as object
})
.then(() => console.log('[+] Auth0 deploy was successful'))
.catch(err => console.log(`[-] Auth0 deploy Error: ${err}`));


/*

//############################################################################
//############################################################################
//
// REFERENCE
//
//############################################################################
//############################################################################

deploy({
    input_file: 'path/to/yaml/or/directory', // Input file for directory, change to .yaml for YAML
    base_path: basePath, // Allow to override basepath, if not take from input_file
    config_file: configFile, // Option to a config json
    config: configObj, // Option to sent in json as object
    env, // Allow env variable mappings from process.env
    secret // Optionally pass in auth0 client secret seperate from config
})
.then(() => console.log('[+] Auth0 deploy was successful'))
.catch(err => console.log(`[-] Auth0 deploy Error: ${err}`));

*/