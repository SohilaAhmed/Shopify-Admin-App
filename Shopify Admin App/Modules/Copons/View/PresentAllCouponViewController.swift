//
//  PresentAllCouponViewController.swift
//  Shopify Admin App
//
//  Created by Sohila on 10/03/2023.
//

import UIKit

class PresentAllCouponViewController: UIViewController {

    
    @IBOutlet weak var couponTable: UITableView!
    var presentAllCouponViewModel: PresentAllCouponViewModel!
    
    var allCoupon = [PriceRule]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presentAllCouponViewModel = PresentAllCouponViewModel()
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        presentAllCouponViewModel.bindAllCouponPriceRule = { [weak self] in

          //  print(self?.presentAllCouponViewModel.allCouponPriceRule.price_rules[0].title ?? "")
            self?.allCoupon = self?.presentAllCouponViewModel.allCouponPriceRule.price_rules ?? []
            DispatchQueue.main.async { [weak self] in
                self?.couponTable.reloadData()
            }
            
        }
        
        presentAllCouponViewModel.retrieveAllCoupon()
    }
    
    
    @IBAction func addCouponAction(_ sender: Any) {
        let couponVC = self.storyboard?.instantiateViewController(withIdentifier: "CouponsViewController") as! CouponsViewController
        couponVC.flagEditAdd = 0 
    
        self.navigationController?.pushViewController(couponVC, animated: true)
    }
    
    
    
  
}

extension PresentAllCouponViewController: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        return allCoupon.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "couponCell", for: indexPath) as! PresetAllCouponTableViewCell
        cell.contentView.layer.cornerRadius = 20
        cell.contentView.layer.masksToBounds = true

        cell.couponTitleLabel.text = "Coupon Title: \(allCoupon[indexPath.row].title ?? "")"
        cell.couponValueLabel.text = "Copuon Value: \(allCoupon[indexPath.row].value ?? "")"
        
        cell.editCouponButton = { [unowned self] in
            let couponVC = self.storyboard?.instantiateViewController(withIdentifier: "CouponsViewController") as! CouponsViewController
            
            couponVC.flagEditAdd = 1
            
            couponVC.priceRuleid = allCoupon[indexPath.row].id
            couponVC.priceRuleTitle = allCoupon[indexPath.row].title
            couponVC.priceRuleValue = allCoupon[indexPath.row].value
            couponVC.priceRuleValueType = allCoupon[indexPath.row].value_type
            
            self.navigationController?.pushViewController(couponVC, animated: true)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            showAlert(indexPath: indexPath)
        }
    }
    
    func showAlert(indexPath: IndexPath){
        // declare Alert
        let alert = UIAlertController(title: "Delete", message: "Are you sure about deletion?", preferredStyle: .alert)
        
        //AddAction
        alert.addAction(UIAlertAction(title: "OK", style: .default , handler: { [self] action in
           // print("ok clicked")

            //delete from server
            presentAllCouponViewModel.deleteCoupon(priceRuleId: allCoupon[indexPath.row].id ?? 0)
            //delete from array
            allCoupon.remove(at: indexPath.row)
            //delete from table
            couponTable.deleteRows(at: [indexPath], with: .fade)
            
            self.couponTable.reloadData()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel , handler: { action in
        //    print("Cancel clicked")
        }))
        

        //showAlert
        self.present(alert, animated: true) {
         //   print("alert done")
        }
    }
    
    

}
