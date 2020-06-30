# SwiftSQL 
A framework to facilitate SQL connections in Swift using a host server to route requests.

## Installation
Transfer `ConnectionManager.swift` in the `Swift` folder to your Xcode project. Change the `QUERY_URL`, `SIMPLE_QUERY_URL`, `AUTH_URL`, and `TEST_URL` variables according to your server configuration. 

Similarly, Change the values of `host`, `user`, `password`, and `database` in `index.js` in the `Server` folder.

Make sure [Node.js](https://nodejs.org) is installed on your server. Run `npm install` to install dependencies and `node index.js` to start the server.

## Usage
There are some built-in template functions in the framework, but the process of implementing your own methods is straightforward. These template functions include a standard `authenticateUser` function, `testConnection` function, `complexQuery` function, `executeQuery` function, and a `retrievePosts` function to retrieve data of some sort.

To run any of these functions:
```
ConnectionManager.sharedInstance.function() {
  (result: AnyObject) in
    // code
}
```

#### Example
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

## Credits
[Parth Saxena](http://parthsaxena.com)



