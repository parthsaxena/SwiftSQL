# SwiftSQL
An extremely easy and expandable framework for SQL connections in Swift. 

## About
**Please note that a server is required for this.**
Let me explain how requests are routed in this application. The client will first make a **Post** HTTP request with the query as a parameter to our NodeJS server. The server then executes the query and returns the *response* **OR** returns whether the query ran successful or not. In the Swift file, there are two standard functions which will make queries to the server. One which serves for queries like: **"SELECT * FROM ..."**. In this case, the server would respond with the data in JSON format. The other function is for queries which serve to update or create information in the database. In this case, the server would respond with a **"1"** for a successful query or a **"0"** for a failed query. 

## Installation
Pull this repository and transfer the file *ConnectionManager.swift* in the *Swift* folder to your Xcode project. In the Swift file change the `QUERY_URL`, `SIMPLE_QUERY_URL`, `AUTH_URL`, and `TEST_URL` variables according to your server.

Next, make sure you have NodeJS installed on your server. Once you are sure, navigate to the *Server*  folder and run: 
`node server.js`. If for some reason you recieve an error, try running `npm install`. Please contact me if this doesn't work. 
## Usage
I have included some built-in example functions in the Swift file. These include a standard `authenticateUser` function, `testConnection` function, `complexQuery` function, `executeQuery` function, and a `retrievePosts` function as a template to code your own function. The `testConnection` function simply tests the connection to the server. The `authenticateUser` simply authenticates a user based on the *username* and *password* strings. The `complexQuery` function allows you to run a query and retrieve the data in JSON format. The `executeQuery` function allows you to run a query and see whether it was executed successfully or not.

To run one of these functions use this code: 
```
ConnectionManager.sharedInstance.function() {
  (result: AnyObject) in
    // code
}
```

Here is an example of executing a complex query in which I parse through the JSON data recieved: 
```
ConnectionManager.sharedInstance.complexQuery("SELECT * FROM posts WHERE posted_by='parthsaxena'") {
    (result: AnyObject) in
    if let posts = result as? [[String: AnyObject]] {
      print("Retrieved (\(posts.count)) posts.")
      for post in posts {
        self.posts.append(post)
      }
      self.tableView.reloadData()
    }
}
```

## Created By
This framework was completely developed by Parth Saxena. 

[My Website: http://parthsaxena.com](http://parthsaxena.com)

[My Email: me@parthsaxena.com](mailto:me@parthsaxena.com)

# License
MIT License

Copyright (c) [2016] [Parth Saxena]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.



