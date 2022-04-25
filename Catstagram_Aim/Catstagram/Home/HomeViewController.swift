//
//  HomeViewController.swift
//  Catstagram
//
//  Created by 김영현 on 2022/04/05.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var arrayCat : [FeedModel] = []
    
    // 카메라, 앨범의 viewController
    let imagePickerViewController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        let feedNib = UINib(nibName: "FeedTableViewCell", bundle: nil)
        tableView.register(feedNib, forCellReuseIdentifier: "FeedTableViewCell")
        let storyNib = UINib(nibName: "StoryTableViewCell", bundle: nil)
        tableView.register(storyNib, forCellReuseIdentifier: "StoryTableViewCell")
        
        // Do any additional setup after loading the view.
        let input = FeedAPIInput(limit: 10, page: 10)
        FeedDataManager().feedDataManager(input, self)
        
        imagePickerViewController.delegate = self
    }
    
    @IBAction func buttonGoAlbum(_ sender: Any) {
        self.imagePickerViewController.sourceType = .photoLibrary
        self.present(imagePickerViewController, animated: true, completion: nil)
    }
    
    
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    // numberOfRowsInSection : 한 섹션에 몇 개의 cell을 넣을 것이냐
    // cellForRowAt : 어떠한 셀을 보여줄 것이냐
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCat.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoryTableViewCell", for: indexPath) as? StoryTableViewCell
                else {
                    return UITableViewCell()
                }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as? FeedTableViewCell
                else {
                    return UITableViewCell()
                }
            if let urlString = arrayCat[indexPath.row - 1].url {
                let url = URL(string: urlString)
                cell.imageViewFeed.kf.setImage(with: url)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 80
        } else {
        return 600
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? StoryTableViewCell else {
            return
        }
        
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCollectionViewCell", for: indexPath) as? StoryCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 60)
    }
}

extension HomeViewController {
    func sucessAPI(_ result : [FeedModel]) {
        arrayCat = result
        tableView.reloadData()
    }
}

extension HomeViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // image를 pick하는 것을 끝냈을 때 실행되는 method
    // 이때 pick image는 (info : _ )
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // firebase 와 연동해서 UI를 바꾼 후 image file을 서버로 연동하는 방식
            // 아래 방식은 이미 firebase와 연동하여 image를 string 값으로 바꿔놨다는 것을 전제로 함.
            let imageString = "https://firebasestorage.googleapis.com/v0/b/catstargram-d7fbf.appspot.com/o/Cat1?alt=media&token=e92d1af6-ceb3-4a0c-9ba9-acd5cf534a42"
            let input = FeedUploadInput(content: "저희 곰먐미는 아니구요 남의 곰먐미입니다..", postImgsUrl: [imageString])
            FeedUploadDataManager().posts(self, input)
            
            self.dismiss(animated: true, completion: nil)
        }
    }
}
