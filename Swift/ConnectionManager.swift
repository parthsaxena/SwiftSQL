//
//  ConnectionManager.swift
//  Pinder
//
//  Created by Parth Saxena on 2/26/16.
//  Copyright © 2016 Parth Saxena. All rights reserved.
//

import UIKit

class ConnectionManager: NSObject {
    
    var QUERY_URL = "http://YOUR_SERVER_URL:2000/sql_query.php";
    var SIMPLE_QUERY_URL = "http://YOUR_SERVER_URL:2000/simple_query.php"
    var AUTH_URL = "http://YOUR_SERVER_URL:2000/sql_auth_user.php";
    var TEST_URL = "http://YOUR_SERVER_URL:2000/test_connection.php";
    
    static let sharedInstance = ConnectionManager()
    
    override init() {
        super.init()
    }
    
    // Basic function to authenticate users based on 'username' and 'password' strings.
    func authenticateUser(username: String, password: String, completion: (result: Bool) -> Void) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: AUTH_URL)!)
        request.HTTPMethod = "POST"
        let postString = "username=" + username + "&password=" + password
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            // Check if authenticated
            if let authOrNot = responseString {
                if (authOrNot == "true") {
                    completion(result: true)
                } else {
                    completion(result: false)
                }
            }
        }
        task.resume()
        
    }
    
    // This function is a little unncessary as you can just use the 'complexQuery()' function. However, if you feel the need to code your own function here, feel free to use this as an example.
    func retrievePosts(school: String, completion: (result: AnyObject) -> Void) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: QUERY_URL)!)
        request.HTTPMethod = "POST"
        let postString = "query=SELECT * FROM" // Change this query according to your application's needs.
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            // Create JSON with data recieved
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                completion(result: json)
            } catch {
                print("error serializing JSON: \(error)")
            }
            
        }
        task.resume()
    }
    
    // Advice: When the user runs the application immediately test the connection to your server. If this returns '0' then prompt the user to come back later.
    func testConnection(completion: (result: AnyObject) -> Void) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: TEST_URL)!)
        request.HTTPMethod = "GET"
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {
                print("error=\(error)")
                completion(result: "0")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
            if let res = responseString {
                completion(result: res)
            }
            
        }
        task.resume()
        
    }
    
    // Run a query to retrieve information.
    func complexQuery(query: String, completion: (result: AnyObject) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: QUERY_URL)!)
        request.HTTPMethod = "POST"
        let postString = "query=\(query)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            // Create JSON with data recieved
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                completion(result: json)
            } catch {
                print("error serializing JSON: \(error)")
            }
            
        }
        task.resume()
    }
    
    // Run a simple query to update/create information in the database. This function will return '1' if the query was successful or '0' if the query failed.
    func executeQuery(query: String, completion: (result: AnyObject) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: SIMPLE_QUERY_URL)!)
        request.HTTPMethod = "POST"
        let postString = "query=\(query)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            // Create JSON with data recieved
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            completion(result: responseString!)
            
        }
        task.resume()
    }
    
}
