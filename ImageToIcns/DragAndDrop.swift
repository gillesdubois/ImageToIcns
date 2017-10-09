//
//  DragAndDrop.swift
//  ImageToIcns
//
//  Created by Gilles Dubois on 08/10/2017.
//  Copyright © 2017 Gilles Dubois. All rights reserved.
//

import Cocoa
import os.log

class DragAndDrop: NSView {
    
    var filePath: String?
    var destPath: String?
    var defaultBackgroundColor: CGColor?
    
    let expectedExt = ["iconset"]  //file extensions allowed for Drag&Drop
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.wantsLayer = true
        
        defaultBackgroundColor = self.layer?.backgroundColor
        
        registerForDraggedTypes([NSPasteboard.PasteboardType.URL, NSPasteboard.PasteboardType.fileURL])
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        // Drawing code here.
    }
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        if checkExtension(sender) == true {
            self.layer?.backgroundColor = NSColor.systemGreen.cgColor
            return .copy
        } else {
            self.layer?.backgroundColor = NSColor.systemRed.cgColor
            return NSDragOperation()
        }
    }
    
    fileprivate func checkExtension(_ drag: NSDraggingInfo) -> Bool {
        guard let board = drag.draggingPasteboard().propertyList(forType: NSPasteboard.PasteboardType(rawValue: "NSFilenamesPboardType")) as? NSArray,
            let path = board[0] as? String
            else { return false }
        
        let suffix = URL(fileURLWithPath: path).pathExtension
        for ext in self.expectedExt {
            if ext.lowercased() == suffix {
                return true
            }
        }
        return false
    }
    
    override func draggingEnded(_ sender: NSDraggingInfo) {
        self.layer?.backgroundColor = defaultBackgroundColor
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        guard let pasteboard = sender.draggingPasteboard().propertyList(forType: NSPasteboard.PasteboardType(rawValue: "NSFilenamesPboardType")) as? NSArray,
            let path = pasteboard[0] as? String
            else { return false }
        
        //GET YOUR FILE PATH !!!
        self.filePath = path
        
        // show dir browser
        let controller = self.window?.contentViewController as! ImageToIcnsViewController;
        controller.sourcePath = path;
        controller.triggerConvertionActions()
        
        return true
    }
    
}
