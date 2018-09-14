//
//  TakePhotoNavigator.swift
//  Vocal Voter
//
//  Created by Mobdev125 on 9/6/18.
//  Copyright © 2018 Mobdev125. All rights reserved.
//

import UIKit
import RxSwift

protocol TakePhotoNavigator {
    func close()
    func toTakePhoto()
    func didTakePhoto(_ image: UIImage)
    func toPickFromLibrary()
}

final class DefaultTakePhotoNavigator: TakePhotoNavigator {
    private let navigationController: UINavigationController
    private let imageSubject:PublishSubject<UIImage>
    private let isAvatar: Bool
    
    init(navigationController: UINavigationController,
         imageSubject: PublishSubject<UIImage>,
         isAvatar: Bool = true) {
        self.navigationController = navigationController
        self.imageSubject = imageSubject
        self.isAvatar = isAvatar
    }
    
    func close() {
        navigationController.dismiss(animated: true, completion: nil)
    }
    
    func toTakePhoto() {
        let takePhotoVc = TakePhotoViewController(nibName: "TakePhotoViewController", bundle: nil)
        takePhotoVc.viewModel = TakePhotoViewModel(navigator: self)
        takePhotoVc.isAvatar = isAvatar
        navigationController.pushViewController(takePhotoVc, animated: false)
    }
    
    func didTakePhoto(_ image: UIImage) {
        if isAvatar {
            let cropNavigator = DefaultCropAvatarPhotoNavigator(navigationController: navigationController)
            cropNavigator.toCropPhoto(image: image, imageSubject: imageSubject)
        }
        else {
            imageSubject.onNext(image)
            close()
        }
    }
    
    func toPickFromLibrary() {
        
    }
}
