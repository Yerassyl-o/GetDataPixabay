//
//  MainPageViewController.swift
//  GetDataPixabay
//
//  Created by Yerassyl Orazbekov on 30.11.2021.
//

import UIKit

class MainPageViewController: UIViewController {
    let apiConverter = ApiConverterHelper()
    var dataSourseImage: [ImageStruct] = []
    var dataSourseVideo: [VideoStruct] = []

    var searchText = " "
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        setUpSearchbar()
        resgisterCustomCell()
        setupToHideKeyboardOnTapOnView()
        settings()
    }
}

extension MainPageViewController {
    func settings() {
        activityIndicator.isHidden = true
        segmentControl.addTarget(self, action: #selector(segmentControlValueChanged), for: .valueChanged)
    }
    
    func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setUpSearchbar() {
        searchBar.delegate = self
        searchBar.returnKeyType = .search
    }
    
    func getimage() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        self.dataSourseImage.removeAll()
        
        DispatchQueue.global(qos: .utility).async { [self] in
            guard let url = URL(string: self.apiConverter.getUrlAdress(photoName: self.searchText)) else { return }
            URLSession.shared.dataTask(with: url) { data, responce, error in
                guard let data = data else { return }
                do {
                    let jsonFile = try JSONDecoder().decode(GetImagesStruct.self, from: data)
                    self.dataSourseImage = jsonFile.hits

                } catch let error {
                    print(error)
                }
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.collectionView.reloadData()
                }
            }.resume()
        }
    }
    
    func getVideo() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        self.dataSourseVideo.removeAll()
        
        DispatchQueue.global(qos: .utility).async { [self] in
            guard let url = URL(string: self.apiConverter.getUrlVideo(photoName: self.searchText)) else { return }
            URLSession.shared.dataTask(with: url) { data, responce, error in
                guard let data = data else { return }
                do {
                    let jsonFile = try JSONDecoder().decode(GetVideosStruct.self, from: data)
                    self.dataSourseVideo = jsonFile.hits
                } catch let error {
                    print(error)
                }
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.collectionView.reloadData()
                }
            }.resume()
        }
    }
    
    func setupToHideKeyboardOnTapOnView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func segmentControlValueChanged() {
        searchBar.text = ""
        collectionView.reloadData()
    }
}

extension MainPageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmentControl.selectedSegmentIndex == 0 {
            return dataSourseImage.count
        } else {
            return dataSourseVideo.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCellCollectionViewCell", for: indexPath) as! ContentCellCollectionViewCell
        if segmentControl.selectedSegmentIndex == 0 {
            cell.contentImage.load(url: dataSourseImage[indexPath.row].previewURL, activityIndicator: cell.activityIndicator)
        } else {
            let urlPhoto = apiConverter.creatVideoPictureLink(photoID: dataSourseVideo[indexPath.row].picture_id)
            cell.contentImage.load(url: urlPhoto, activityIndicator: cell.activityIndicator)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = self.collectionView.frame.width
        return CGSize(width: (collectionViewWidth - 20)/2, height: 130)
    }

    func resgisterCustomCell(){
        let customCellNib = UINib(nibName: "ContentCellCollectionViewCell", bundle: .main)
        collectionView.register(customCellNib, forCellWithReuseIdentifier: "ContentCellCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if segmentControl.selectedSegmentIndex == 0 {
            if let viewController = storyboard?.instantiateViewController(identifier: "ShowDetailPhotoViewController") as? ShowDetailPhotoViewController {
                self.present(viewController, animated: true)
                let imageData = dataSourseImage[indexPath.row]
                viewController.imageView.load(url: dataSourseImage[indexPath.row].webformatURL, activityIndicator: viewController.activityIndicator)
                viewController.downloads.text = "\(imageData.downloads)"
                viewController.likes.text = "\(imageData.likes)"
                viewController.views.text = "\(imageData.views)"
            }
        } else {
            if let viewController = storyboard?.instantiateViewController(identifier: "ShowVideoViewController") as? ShowVideoViewController {
                viewController.websiteURL = dataSourseVideo[indexPath.row].videos.medium.url
                self.present(viewController, animated: true)
            }
        }
    }
}

extension MainPageViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchText = searchBar.text ?? " "
        if segmentControl.selectedSegmentIndex == 0 {
            getimage()
        } else {
            getVideo()
        }
    }
}

extension MainPageViewController: UICollectionViewDelegateFlowLayout {}


