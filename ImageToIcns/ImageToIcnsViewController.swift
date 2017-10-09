//
//  ImageToIcnsViewController
//  ImageToIcns
//
//  Created by Gilles Dubois on 08/10/2017.
//  Copyright © 2017 Gilles Dubois. All rights reserved.
//

import Cocoa

class ImageToIcnsViewController: NSViewController {
    
    var destFolder: URL!
    var sourcePath: String!
    var fileName: String! = "output_file"

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
                print ("Source folder : \(self.sourcePath ?? "none")")
                
                // Transform source to icns
                let task = Process()

                // Create a Task instance
                
                let output = "\(self.destFolder!.path)/\(self.fileName!).icns"
                
                print ("Destination folder : \(output)")
                
                // Set the task parameters
                task.launchPath = "/usr/bin/iconutil"
                task.arguments = ["-c", "icns", "\(self.sourcePath!)", "--output", "\(output)"]
                
                // Create a Pipe and make the task
                // put all the output there
                let pipe = Pipe()
                task.standardOutput = pipe
                
                // Launch the task
                task.launch()

                // Trigger notification
                self.showNotification()
  
                
            }
        }

    }
    
    private func showNotification() -> Void {
        let notification = NSUserNotification()
        notification.title = "Success !"
        notification.informativeText = "Your iconset has been transformed to icns"
        notification.soundName = NSUserNotificationDefaultSoundName
        NSUserNotificationCenter.default.deliver(notification)
    }

}

