//
//  ViewController.swift
//  CollectionViewProject
//
//  Created by lpiem on 09/03/2022.
//

import UIKit

class ViewController: UICollectionViewController {
    enum Section {
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            let jsonData: Data = readLocalFile(forName: "landmarkData")!
            let landmarks: [Landmark] = try JSONDecoder().decode([Landmark].self, from: jsonData)
        } catch {
            print(error)
        }
        
       
    }

    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    
    
}

