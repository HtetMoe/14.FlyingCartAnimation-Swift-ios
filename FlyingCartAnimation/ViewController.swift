//
//  ViewController.swift
//  FlyingCartAnimation
//
//  Created by Htet Moe Phyu on 08/01/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var numberOfCartItemsLabel: UILabel!
    
    var counterItem = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberOfCartItemsLabel.layer.cornerRadius = numberOfCartItemsLabel.frame.size.height / 2
        numberOfCartItemsLabel.clipsToBounds      = true
        tableView.register(UINib(nibName: "ItemTableViewCell", bundle: nibBundle), forCellReuseIdentifier: "itemCell")
    
    }
    
    func animation(tempView : UIView)  {
        self.view.addSubview(tempView)
       
        UIView.animate(withDuration: 1.0,
                       animations: {
                        tempView.animationZoom(scaleX: 1.5, y: 1.5)
        }, completion: { _ in
            
            UIView.animate(withDuration: 0.5, animations: {
                tempView.animationZoom(scaleX: 0.2, y: 0.2)
                tempView.animationRoted(angle: CGFloat(Double.pi))
                
                tempView.frame.origin.x = self.cartButton.frame.origin.x
                tempView.frame.origin.y = self.cartButton.frame.origin.y
                
            }, completion: { _ in
                
                tempView.removeFromSuperview()
                UIView.animate(withDuration: 1.0, animations: {
                    self.counterItem += 1
                    self.numberOfCartItemsLabel.text = "\(self.counterItem)"
                    self.cartButton.animationZoom(scaleX: 1.4, y: 1.4)
                }, completion: {_ in
                    self.cartButton.animationZoom(scaleX: 1.0, y: 1.0)
                })
                
            })
            
        })
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell") as! ItemTableViewCell
        cell.itemImage.layer.borderColor = UIColor.black.cgColor
        cell.itemImage.layer.borderWidth = 0.3
        return cell
    }
}

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! ItemTableViewCell
        let imageViewPosition : CGPoint = cell.itemImage.convert(cell.itemImage.bounds.origin, to: self.view)
        let imgViewTemp = UIImageView(frame: CGRect(x: imageViewPosition.x, y: imageViewPosition.y, width: cell.itemImage.frame.size.width, height: cell.itemImage.frame.size.height))
        
        imgViewTemp.image = cell.itemImage.image
        animation(tempView: imgViewTemp)
    }
}

extension UIView{
    func animationZoom(scaleX: CGFloat, y: CGFloat) {
        self.transform = CGAffineTransform(scaleX: scaleX, y: y)
    }
    
    func animationRoted(angle : CGFloat) {
        self.transform = self.transform.rotated(by: angle)
    }
}
