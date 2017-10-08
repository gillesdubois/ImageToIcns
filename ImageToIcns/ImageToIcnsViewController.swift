//
//  ImageToIcnsViewController
//  ImageToIcns
//
//  Created by Gilles Dubois on 08/10/2017.
//  Copyright © 2017 Gilles Dubois. All rights reserved.
//

import Cocoa

class ImageToIcnsViewController: NSViewController {
    
    var destFolder: URL?
    var sourcePath: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func triggerConvertionActions(){
        // Pop up a file browser
        guard let window = view.window else { return }
        
        let panel = NSOpenPanel()
        panel.canChooseFiles = false
        panel.canChooseDirectories = true
        panel.allowsMultipleSelection = false
        
        panel.beginSheetModal(for: window) { (result) in
            if result == NSApplication.ModalResponse.OK {
                self.destFolder = panel.urls[0]
                
                // Process image
                print ("Destination folder : \(self.destFolder?.path ?? "none")")
                
                // Transform source to icns
                
            }
        }

    }

}

