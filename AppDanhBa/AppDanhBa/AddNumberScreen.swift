//
//  AddNumberScreen.swift
//  AppDanhBa
//
//  Created by Thiện Tùng on 1/23/20.
//  Copyright © 2020 tung. All rights reserved.
//

import UIKit

import Photos
class AddNumberScreen: UIViewController {
    
    let imageChoose: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "background4")
        view.contentMode = .scaleAspectFit
        
        return view
    } ()
    
    let addPhoto:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Thêm ảnh", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        
        return button
    } ()

    let hoTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Họ"
        
        return textField
    } ()
    
    let tenTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Tên"
        
        return textField
    } ()
    
    let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Số điện thoại"
        
        return textField
    } ()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Thêm", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        
        return button
    } ()
    
    var imagePicker: UIImagePickerController!
    
    var nameImage: String = ""
    
    var passData: ((item) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        title = "Liên hệ mới"
        
        setupLayout()
        addPhoto.addTarget(self, action: #selector(selectPhoto), for: .touchUpInside)
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        addButton.addTarget(self, action: #selector(back), for: .touchUpInside)

    }
    
    func setupLayout(){
        //image
        view.addSubview(imageChoose)
        imageChoose.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        imageChoose.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        imageChoose.widthAnchor.constraint(equalToConstant: 185).isActive = true
        imageChoose.heightAnchor.constraint(equalTo: imageChoose.widthAnchor, multiplier: 1).isActive = true
        imageChoose.layer.cornerRadius = 185/2
        imageChoose.clipsToBounds = true
        //addButton
        view.addSubview(addPhoto)
        addPhoto.topAnchor.constraint(equalTo: imageChoose.bottomAnchor, constant: 12).isActive = true
        addPhoto.centerXAnchor.constraint(equalTo: imageChoose.centerXAnchor, constant: 0).isActive = true
        //Ho
        view.addSubview(hoTextField)
        hoTextField.topAnchor.constraint(equalTo: addPhoto.bottomAnchor, constant: 24).isActive = true
        hoTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        hoTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        hoTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        hoTextField.layer.borderWidth = 0
        hoTextField.layer.borderColor = UIColor.black.cgColor
        hoTextField.backgroundColor = .white
        //Ten
        view.addSubview(tenTextField)
        tenTextField.topAnchor.constraint(equalTo: hoTextField.bottomAnchor, constant: 1).isActive = true
        tenTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        tenTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        tenTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tenTextField.layer.borderWidth = 0
        tenTextField.layer.borderColor = UIColor.black.cgColor
        tenTextField.backgroundColor = .white
        //Congty
        view.addSubview(phoneNumberTextField)
        phoneNumberTextField.topAnchor.constraint(equalTo: tenTextField.bottomAnchor, constant: 1).isActive = true
        phoneNumberTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        phoneNumberTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        phoneNumberTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        phoneNumberTextField.layer.borderWidth = 0
        phoneNumberTextField.layer.borderColor = UIColor.black.cgColor
        phoneNumberTextField.backgroundColor = .white
        //Button
        view.addSubview(addButton)
        addButton.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 80).isActive = true
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
        
    }
    
    @objc func selectPhoto(){
        let alert = UIAlertController(title: "Thêm ảnh", message: "Chọn ảnh từ", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Huỷ", style: .cancel, handler: nil)
        let camera = UIAlertAction(title: "Camera", style: .default) { (_) in
            self.fromCamera()
        }
        let library = UIAlertAction(title: "Thư viện", style: .default) { (_) in
            self.fromLibrary()
        }
        alert.addAction(camera)
        alert.addAction(library)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func confirm(message: String, viewController: UIViewController?, success: @escaping () -> Void){
        let alert = UIAlertController(title: "My App", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        
        viewController?.present(alert, animated: true, completion: nil)
    }
    
    func setting(){
        let message = "App cần truy cập máy ảnh và thư viện của bạn. Ảnh của bạn sẽ không được chia sẻ khi chưa được phép của bạn."
        confirm(message: message, viewController: self) {
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.openURL(settingsUrl)
                } else {
                    UIApplication.shared.openURL(settingsUrl)
                }
            }
        }
    }
    
    private func fromLibrary(){
        func choosePhoto(){
            
            DispatchQueue.main.async {
                self.imagePicker.allowsEditing = false
                self.imagePicker.sourceType = .photoLibrary
                self.imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
                self.imagePicker.modalPresentationStyle = .popover
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }
        
        // khai báo biến để lấy quyền truy cập
        let status = PHPhotoLibrary.authorizationStatus()
        if (status == PHAuthorizationStatus.authorized) {
            // quyền truy cập đã được cấp
            choosePhoto()
        }else if (status == PHAuthorizationStatus.denied) {
            // quyền truy cập bị từ chối
            setting()
        }else if (status == PHAuthorizationStatus.notDetermined) {
            // quyền truy cập chưa được xác nhận
            PHPhotoLibrary.requestAuthorization({ (newStatus) in
                if (newStatus == PHAuthorizationStatus.authorized) {
                    choosePhoto()
                }else {
                    print("Không được cho phép truy cập vào thư viện ảnh")
                    self.setting()
                }
            })
        }else if (status == PHAuthorizationStatus.restricted) {
            // Truy cập bị hạn chế, thông thường sẽ không xảy ra
            print("Restricted access")
            setting()
        }
    }
    
    private func fromCamera(){
        func takePhoto(){
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.imagePicker.allowsEditing = false
                self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
                self.imagePicker.cameraCaptureMode = .photo
                self.imagePicker.cameraDevice = .front
                self.imagePicker.modalPresentationStyle = .fullScreen
                DispatchQueue.main.async {
                    self.present(self.imagePicker, animated: true,completion: nil)
                }
            }else{
                print("abc")
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Thông báo", message: "Không tìm thấy máy ảnh", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        //Camera
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if response {
                takePhoto()
            } else {
                print("camera denied")
                self.setting()
            }
        }
    }

    @objc func back() {
        passData?(item(name: hoTextField.text! + " " + tenTextField.text!, phoneNumber: phoneNumberTextField.text!, avt: imageChoose.image!))
        
        navigationController?.popViewController(animated: true)
    }

}

extension AddNumberScreen: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("error \(info)")
            return
        }
        if let asset = info[UIImagePickerController.InfoKey.phAsset] as? PHAsset {
            let assetResources = PHAssetResource.assetResources(for: asset)

            nameImage = assetResources.first!.originalFilename
        }
        imageChoose.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
}
