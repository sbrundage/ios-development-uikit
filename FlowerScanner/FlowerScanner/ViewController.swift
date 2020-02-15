//
//  ViewController.swift
//  FlowerScanner
//
//  Created by Stephen Brundage on 1/22/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController {
    
    @IBOutlet weak var cameraImageView: UIImageView!
    @IBOutlet weak var flowerDetailsLabel: UILabel!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            guard let convertedCIImage = CIImage(image: userPickedImage) else {
                fatalError("Could not convert to CIImage")
            }
            
            detect(image: convertedCIImage)
            cameraImageView.image = userPickedImage
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }

    @IBAction func cameraButtonTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func detect(image: CIImage) {
        guard let model =  try? VNCoreMLModel(for: FlowerClassifier().model) else { fatalError("Could not import model") }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            let classification = request.results?.first as? VNClassificationObservation
            if let classification = classification?.identifier {
                self.navigationItem.title = classification.capitalized
                NetworkManager().requestFlowerDetails(flowerName: classification) { (extract) in
                    if extract != nil {
                        self.updateLabelWithFlowerDetails(extract!)
                    }
                }
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
    
    private func updateLabelWithFlowerDetails(_ details: String) {
        flowerDetailsLabel.text = details
    }
    
}

extension ViewController: UIImagePickerControllerDelegate {
    
}

extension ViewController: UINavigationControllerDelegate {
    
}

