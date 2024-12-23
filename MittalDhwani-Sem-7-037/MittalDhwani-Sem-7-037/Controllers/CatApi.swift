//
//  CatApi.swift
//  MittalDhwani-Sem-7-037
//
//  Created by Manthan Mittal on 23/12/2024.
//

import UIKit
import CoreData

class CatApi: UIViewController {
    
    var catArr:[CatModel]=[]

    @IBOutlet weak var apitbl: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        callApi()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()

    }
    
    @IBAction func viewbtn(_ sender: Any) {
        performSegue(withIdentifier: "GoToNext", sender: self)
    }
    
    func addtocd(catobject:CatModel){
        guard let delegte = UIApplication.shared.delegate as? AppDelegate
        else {return}
        
        let managedcontext = delegte.persistentContainer.viewContext
        
        guard let catEntity=NSEntityDescription.entity(forEntityName: "Cats", in: managedcontext) else{
            return
        }
        
        let cat=NSManagedObject(entity: catEntity, insertInto: managedcontext)
        
        cat.setValue(catobject.id, forKey: "id")
        cat.setValue(catobject.url, forKey: "url")
        cat.setValue(catobject.width, forKey: "width")
        cat.setValue(catobject.height, forKey: "height")
        
        do {
            try managedcontext.save()
            debugPrint("Data saved")
        } catch let err as NSError {
            debugPrint("could not save to CoreData. Error: \(err)")
        }
    }
    
    func reloadTable(){
        DispatchQueue.main.async {
            self.apitbl.reloadData()
        }
    }
    
    func callApi(){
        ApiManager().fetchCats{ result in
            switch result {
                
            case.success(let data):
                self.catArr.append(contentsOf: data)
                print(self.catArr)
                self.reloadTable()
               
            case.failure(let failure):
                debugPrint("something went wrong in calling API")
              
            }
        }
    }


}

extension CatApi: UITableViewDelegate, UITableViewDataSource {
   
    func setupTable() {
        apitbl.dataSource = self
        apitbl.delegate = self
        apitbl.register(UINib(nibName: "CatCell", bundle: nil), forCellReuseIdentifier: "CatCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "CatCell", for: indexPath) as! CatCell
        cell.lid.text = catArr[indexPath.row].id
        cell.lurl.text = catArr[indexPath.row].url
        cell.lwidth.text = String(catArr[indexPath.row].width)
        cell.lheight.text = String(catArr[indexPath.row].height)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cat = catArr[indexPath.row]
        addtocd(catobject: CatModel(id: cat.id, url: cat.url, width: cat.width, height: cat.height))
    }
}
