const express = require("express");
const cors = require("cors");
const { createServer } = require("http");

const { auth, requiredScopes } = require("express-oauth2-bearer");

const {
	checkUrl,
	AUTH0_DOMAIN,
	AUTH0_AUDIENCE,
	WEB_API_PORT,
	WEB_APP_PORT,
	APP_URL, // Public URL for this app
//	ISSUER_BASE_URL, // Auth0 Tenant Url
	ALLOWED_AUDIENCES, // Auth0 API Audience List
	PORT,
} = require("./env-config");

ISSUER_BASE_URL = AUTH0_DOMAIN

const app = express();

//
// Used to normalize URL
//
app.use(checkUrl());

app.use(cors());

const expenses = [
	{
		date: new Date(),
		description: "Pizza for a Coding Dojo session.",
		value: 102,
	},
	{
		date: new Date(),
		description: "Coffee for a Coding Dojo session.",
		value: 42,
	},
];

/*****************************************************************************
/*****************************************************************************
**
**  This method is here to allow a successful response on root requests.
**  This stops content security policy from preventing the user to make
**  requests via the browsers console.
**
******************************************************************************
*****************************************************************************/

app.get("/", (req, res) => {
	res.status(200).end("OK");
});

/****************************************************************************/
/****************************************************************************/

app.get("/total", (req, res) => {
	const total = expenses.reduce((accum, expense) => accum + expense.value, 0);
	res.send({ total, count: expenses.length });
});

//
// Auth0 middleware
//
app.use(auth());


app.get("/reports", requiredScopes('read:reports'), (req, res) => {
	res.send(expenses);
});

createServer(app).listen(PORT, () => {
	console.log(`API: ${APP_URL}`);
});
