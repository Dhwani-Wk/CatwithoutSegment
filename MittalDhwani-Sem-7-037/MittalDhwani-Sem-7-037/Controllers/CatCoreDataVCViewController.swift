//
//  CatCoreDataVCViewController.swift
//  MittalDhwani-Sem-7-037
//
//  Created by Manthan Mittal on 23/12/2024.
//

import UIKit
import CoreData

class CatCoreDataVCViewController: UIViewController {

    @IBOutlet weak var coretable: UITableView!
    
    var saveCats:[CatModel]=[]
    
    var selectedcat:CatModel!
    
    override func viewWillAppear(_ animated: Bool) {
        readcd()
        coretable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    func reloadTable(){
        DispatchQueue.main.async {
            self.coretable.reloadData()
        }
    }
    

}

extension CatCoreDataVCViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTable() {
        coretable.delegate = self
        coretable.dataSource = self
        coretable.register(UINib(nibName: "CatCell", bundle: nil), forCellReuseIdentifier: "CatCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return saveCats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "CatCell", for: indexPath) as! CatCell
        cell.lid.text = saveCats[indexPath.row].id
        cell.lurl.text = saveCats[indexPath.row].url
        cell.lwidth.text = String(saveCats[indexPath.row].width)
        cell.lheight.text = String(saveCats[indexPath.row].height)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete=UIContextualAction(style: .destructive, title: "delete"){action,source,completion in
            self.saveCats.remove(at: indexPath.row)
            
            let catToDelete = self.saveCats[indexPath.row]
            self.deleteFromCD(cats: catToDelete)
         
            
            self.reloadTable()
        }
        let configure=UISwipeActionsConfiguration(actions: [delete])
        configure.performsFirstActionWithFullSwipe=false
        return configure
    }
    
    func readcd(){
        guard let delegate=UIApplication.shared.delegate as? AppDelegate else
        {return }
        
        let managecontext=delegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cats")
        
        do{
            let res = try managecontext.fetch(fetchRequest)
            debugPrint("fetch from CD sucessfully")
            saveCats=[]

            
            for data in res as! [NSManagedObject]{
                
                let cid=data.value(forKey: "id") as! String
                let curl=data.value(forKey: "url") as! String
                let cwidth=data.value(forKey: "width") as! Int
                let cheight=data.value(forKey: "height") as! Int
                saveCats.append(CatModel(id: cid, url: curl, width: Int(cwidth), height: Int(cheight)))
            }
            
        }
        catch let err as NSError {
            debugPrint("could not save to CoreData. Error: \(err)")
        }
        
    }
    
    func deleteFromCD(cats: CatModel) {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cats")
        
        // Correct predicate format for the id
        fetchRequest.predicate = NSPredicate(format: "id = %@", cats.id)

        do {
            let fetchRes = try managedContext.fetch(fetchRequest)

            // Check if fetchRes is not empty before trying to access its first element
            if fetchRes.isEmpty {
                print("No matching cat found to delete.")
                return
            }

            // Proceed with deletion if object is found
            let objToDelete = fetchRes[0] as! NSManagedObject
            managedContext.delete(objToDelete)
            
            try managedContext.save()
            print("Cat deleted successfully")
        } catch let err as NSError {
            print("Something went wrong while deleting \(err)")
        }
    }

}
