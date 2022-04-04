//
//  DetailsViewController.swift
//  VM Directory
//
//  Created by Prasad on 02/04/22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var imageViewProfileImage: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelJobTitle: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelFavColor: UILabel!
    
    var detailsViewModel: DetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar(title: ScreenTitle.details.rawValue,
                           isBackButtonEnabled: true)
        
        imageViewProfileImage.makeCircle()
        imageViewProfileImage.imageFromServerURL(urlString: detailsViewModel.getAvatar())
        labelName.text = detailsViewModel.getPersonName()
        labelName.applyBrandColor()
        labelJobTitle.text = detailsViewModel.getJobTitle()
        labelEmail.text = detailsViewModel.getEmail()
        labelFavColor.text = detailsViewModel.getFavouriteColor().uppercased()
    }
}
