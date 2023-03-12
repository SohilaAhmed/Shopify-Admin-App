//
//  DisplayCollectionsVC.swift
//  Product
//
//  Created by Zienab on 11/03/2023.
//

import UIKit
import Kingfisher

class DisplayCollectionsVC: UIViewController {
    
    
    @IBOutlet weak var smartCollectionView: UICollectionView!
    
    @IBOutlet weak var customCollectionTable: UITableView!
    
    var displayCollectionsViewModel: DisplayCollectionsViewModel!
    
    var smartCollections: [SmartCollection] = [SmartCollection]()
    var customCollectionResult = [NewCustomCollection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayCollectionsViewModel = DisplayCollectionsViewModel()
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        //get all smart collections
        displayCollectionsViewModel.bindResultToDisplayBrands = { [weak self] in
            self?.smartCollections = self?.displayCollectionsViewModel.allBrands.smart_collections ?? []
            DispatchQueue.main.async {
                self?.smartCollectionView.reloadData()
            }
            
        }
        displayCollectionsViewModel.getAllBrands()
        
        //get all custom collection
        displayCollectionsViewModel.bindCustomCollection = { [weak self] in
            self?.customCollectionResult = self?.displayCollectionsViewModel.allCustomCollection.custom_collections ?? []
            DispatchQueue.main.async {
                self?.customCollectionTable.reloadData()
            }
            
        }
        displayCollectionsViewModel.getAllCustomCollection()
        
    }
    
    @IBAction func addNewSmartCollection(_ sender: Any) {
        let smartCollectionVC = self.storyboard?.instantiateViewController(withIdentifier: "SmartCollectionViewController") as! SmartCollectionViewController

        smartCollectionVC.flagEditAdd = 0

        self.navigationController?.pushViewController(smartCollectionVC, animated: true)
    }
    
    @IBAction func addNewCustomCollection(_ sender: Any) {
        let customCollectionVC = self.storyboard?.instantiateViewController(withIdentifier: "CustomCollectionVC") as! CustomCollectionVC

        customCollectionVC.flagEditAdd = 0

        self.navigationController?.pushViewController(customCollectionVC, animated: true)
        
    }
    
    
    
}

extension DisplayCollectionsVC : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return smartCollections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandItem", for: indexPath) as! SmartCollectionsCell
        
        cell.brandName.text = smartCollections[indexPath.row].title
        cell.brandImage.kf.setImage(with: URL(string: smartCollections[indexPath.row].image.src))
        
        cell.editSmartCollectioButton = { [unowned self] in
            //navigate to edit view
            let smartCollectionVC = self.storyboard?.instantiateViewController(withIdentifier: "SmartCollectionViewController") as! SmartCollectionViewController
            
            smartCollectionVC.flagEditAdd = 1
            smartCollectionVC.smartCollectionId = smartCollections[indexPath.row].id
            smartCollectionVC.smartCollectionTitle = smartCollections[indexPath.row].title
            smartCollectionVC.smartCollectionImg = smartCollections[indexPath.row].image.src
            
            
            self.navigationController?.pushViewController(smartCollectionVC, animated: true)
        }
        cell.deleteSmartCollectioButton = { [unowned self] in
            // remove from collection, server, array
            showAlertDeleteSmartCollection(indexPath: indexPath)
        }
        
        return cell
    }
    
    func showAlertDeleteSmartCollection(indexPath: IndexPath){
        // declare Alert
        let alert = UIAlertController(title: "Delete", message: "Are you sure about deletion?", preferredStyle: .alert)
        
        //AddAction
        alert.addAction(UIAlertAction(title: "OK", style: .default , handler: { [self] action in
           // print("ok clicked")

            //delete from server
            displayCollectionsViewModel.deleteFromSmartCollection(smartCollectionId: smartCollections[indexPath.row].id )
            //delete from array
            smartCollections.remove(at: indexPath.row)
            //delete from table
            smartCollectionView.deleteItems(at: [indexPath])
            
            self.smartCollectionView.reloadData()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel , handler: { action in
           // print("Cancel clicked")
        }))
        

        //showAlert
        self.present(alert, animated: true) {
         //   print("alert done")
        }
    }
    
    
}




extension DisplayCollectionsVC : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width/2.1, height: self.view.frame.height * 0.25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 2, bottom: 1, right: 2)
    }
}


extension DisplayCollectionsVC: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customCollectionResult.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCollectionCell", for: indexPath) as! CustomCollectionCell
        cell.contentView.layer.cornerRadius = 20
        cell.contentView.layer.masksToBounds = true
        
        cell.customCollectionName.text = customCollectionResult[indexPath.row].title
        
        
        cell.editCustomCollectioButton = { [unowned self] in
            let customCollectionVC = self.storyboard?.instantiateViewController(withIdentifier: "CustomCollectionVC") as! CustomCollectionVC

            customCollectionVC.flagEditAdd = 1

            customCollectionVC.customCollectionId = customCollectionResult[indexPath.row].id
            customCollectionVC.customCollectionTitle = customCollectionResult[indexPath.row].title 

            self.navigationController?.pushViewController(customCollectionVC, animated: true)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            showAlertDeleteCustom(indexPath: indexPath)
        }
    }
    
    func showAlertDeleteCustom(indexPath: IndexPath){
        // declare Alert
        let alert = UIAlertController(title: "Delete", message: "Are you sure about deletion?", preferredStyle: .alert)
        
        //AddAction
        alert.addAction(UIAlertAction(title: "OK", style: .default , handler: { [weak self] action in
         //   print("ok clicked")
//
            //delete from server
            self?.displayCollectionsViewModel.deleteFromCustomCollection(customCollectionId: self?.customCollectionResult[indexPath.row].id ?? 0 )
//            //delete from array
            self?.customCollectionResult.remove(at: indexPath.row)
//            //delete from table
            self?.customCollectionTable.deleteRows(at: [indexPath], with: .fade)
//
            self?.customCollectionTable.reloadData()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel , handler: { action in
       //     print("Cancel clicked")
        }))
        

        //showAlert
        self.present(alert, animated: true) {
        //    print("alert done")
        }
    }
    
}
