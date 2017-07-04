//
//  ViewController.swift
//  BookCollector
//
//  Created by Ravi Kumar Venuturupalli on 7/4/17.
//  Copyright © 2017 Ravi Kumar Venuturupalli. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var books : [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }

    override func viewWillAppear(_ animated: Bool) {
         let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
        books = try context.fetch(Book.fetchRequest())
        tableView.reloadData()
        } catch {
        
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let book = books[indexPath.row]
        cell.textLabel?.text = book.title
        cell.imageView?.image = UIImage(data: book.image! as Data)
        return cell
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = books[indexPath.row]
        performSegue(withIdentifier: "gameSegue", sender: book)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! BookViewController
        nextVC.book = sender as? Book
    }
}

