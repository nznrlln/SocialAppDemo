//
//  StoryScreenViewController.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 04.06.2023.
//

import UIKit

class StoryScreenViewController: UIViewController {

    private lazy var closeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.image = UIImage(systemName: "xmark.circle")
        imageView.tintColor = Palette.mainAccent
        imageView.isUserInteractionEnabled = true

        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
