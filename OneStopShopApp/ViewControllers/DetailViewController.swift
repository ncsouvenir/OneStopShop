//
//  DetailViewController.swift
//  OneStopShopApp
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {

    var jobCenter: JobCenter!
    var contentComponents = [ContentComponents]()
    lazy var starView: UIImageView = {
        let star = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        star.image = #imageLiteral(resourceName: "001-favorite")
        star.backgroundColor = .clear
        star.alpha = 0
        return star
    }()
    init(jobCenter: JobCenter) {
        super.init(nibName: nil, bundle: nil)
        self.jobCenter = jobCenter
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        setStarConstrain()
        self.tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: "DetailCell")
       self.contentComponents = ContentFactory.getContentComponents(jobCenter: jobCenter)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
    }

    private func setStarConstrain() {
        view.addSubview(starView)
        starView.translatesAutoresizingMaskIntoConstraints = false
        starView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        starView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: (UIScreen.main.bounds.width / 2) - 35).isActive = true
        starView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        starView.widthAnchor.constraint(equalToConstant: 35).isActive = true
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentComponents.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailTableViewCell
        let content = contentComponents[indexPath.row]
        switch indexPath.row {
        case 0 :
            cell.leftTextLabel.text = "Name"
            cell.rightTextLabel.text = content.detail
        case 1:
            cell.leftTextLabel.text = "Address"
            cell.rightTextLabel.text = content.detail
        case 2:
            cell.leftTextLabel.text = "Phone Number"
            cell.rightTextLabel.text = content.detail
        case 3:
            cell.leftTextLabel.text = "City"
            cell.rightTextLabel.text = content.detail
        default:
            print("error")
        }
        return cell
    }
    
    
    func configureNavBar() {
       let index = PersistantManager.manager.getFavotites().index(where: {self.jobCenter.phoneNumber == $0.phoneNumber})
        if index == nil {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "002-star"), style: .plain, target: self, action:  #selector(favoriteButtonPressed))
        } else {
         self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "001-star-1"), style: .plain, target: self, action:  #selector(favoriteButtonPressed))
        }
    }
    
    @objc func favoriteButtonPressed() {
        switch navigationItem.rightBarButtonItem!.image! {
        case #imageLiteral(resourceName: "002-star"):
            PersistantManager.manager.addFavorite(newJob: self.jobCenter)
            animateStar()
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "001-star-1"), style: .plain, target: self, action:  #selector(favoriteButtonPressed))
        default:
            showAlert(title: "Already favorited", message: "This resource center is already favorited")
        }
    }
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    func animateStar() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.delegate = self
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.toValue = starView.alpha = 1
        //animation.fromValue = self.starView.layer.position
        animation.toValue = CGPoint(x: UIScreen.main.bounds.width - 100, y: UIScreen.main.bounds.height)
        animation.duration = 1
        animation.repeatCount = 1
      starView.layer.add(animation, forKey: nil)
    }
    

    
}

extension DetailViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        starView.alpha = 0
    }
}


