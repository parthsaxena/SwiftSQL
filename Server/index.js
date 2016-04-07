var express = require('express');
var bodyParser = require('body-parser')
var mysql = require('mysql');

var PORT = 2000;

var app = express();
app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json())

var successQuery = "Successfully executed (1) query.";

var connection = mysql.createConnection({
    host: 'YOUR_HOST', // Host will usually be 'localhost'
    user: 'YOUR_USERNAME',
    password: 'YOUR_PASSWORD',
    database: 'YOUR_DATABASE'
});

connection.connect();

app.post('/sql_query.php', function(request, response) {
    console.log(request.body.query);
    queryDatabase(request.body.query, function(result) {
        if (result == "") {
            response.send("0");
            response.end();
        } else {
            response.send(result);
            response.end();
        }
    });
});

app.post('/simple_query.php', function(request, response) {
    console.log(request.body.query);
    queryDatabase(request.body.query, function(result) {
        if (result == "0") {
            response.send("0");
            response.end();
        } else {
            response.send("1");
            response.end();
        }
    });
});

app.post('/sql_auth_user.php', function(request, response) {
    console.log("username: " + request.body.username + " password: " + request.body.password);
    authenticateUser(request.body.username, request.body.password, function(result) {
        if (result == true) {
            response.send("true");
            response.end();
        } else {
            response.send("false");
            response.end();
        }
    });
});

app.get('/test_connection.php', function(request, response)  {
    response.write("1");
    response.end();
});

// For this authentication function make sure your table containing users in your database is named "users". If it is not, just update it in the variable 'authQuery'.
function authenticateUser(username, password, cb) {
    var authQuery = "SELECT * FROM users WHERE username='" + username + "' AND password='" + password + "'";
    connection.query(authQuery, function(error, rows, fields) {
        if (!error) {
            if (rows.length == 1) {
                console.log("User with username: " + username + ", password: " + password + " was authenticated.");
                cb(true);
            } else {
                console.log("User with username: " + username + ", password: " + password + " was not authenticated.");
                cb(false);
            }
        } else {
            console.log("Authentication query unexpectedly failed.");
        }
    });

}

function queryDatabase(query, cb) {
    connection.query(query, function(error, rows, fields) {
        if (!error) {
            //console.log('Query executed successfully: ', rows);
        } else {
            rows = '0';
            console.log('Query failed.');
        }
        cb(rows);
    });
}

app.listen(PORT, function() {
    console.log("Server running on port: " + 2000);
});
