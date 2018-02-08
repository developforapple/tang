//
//  Constant.swift
//  Laidian
//
//  Created by Jay on 2018/1/31.
//  Copyright © 2018年 来电科技. All rights reserved.
//

import Foundation
import UIKit

/// 当前屏幕
let Screen_Scale = UIScreen.main.scale
let Screen_Width = UIScreen.main.bounds.width
let Screen_Height = UIScreen.main.bounds.height

/// 设备屏幕
let Device_Scale = UIScreen.main.nativeScale
let Device_Width = UIScreen.main.nativeBounds.width / Device_Scale
let Device_Height = UIScreen.main.nativeBounds.height / Device_Scale

/// 状态栏高度
let StatusBar_Height = UIApplication.shared.statusBarFrame.height

let IS_Phone_UI = UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiom.phone
let IS_Pad_UI   = UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiom.pad

let IS_3_5_INCH_SCREEN = IS_Phone_UI && Int(Device_Width)==320 && Int(Device_Height)==480
let IS_4_0_INCH_SCREEN = IS_Phone_UI && Int(Device_Width)==320 && Int(Device_Height)==568
let IS_4_7_INCH_SCREEN = IS_Phone_UI && Int(Device_Width)==375 && Int(Device_Height)==667
let IS_5_5_INCH_SCREEN = IS_Phone_UI && Int(Device_Width)==414 && Int(Device_Height)==736
let IS_5_8_INCH_SCREEN = IS_Phone_UI && Int(Device_Width)==375 && Int(Device_Height)==812

let Device_SysVersionStr = UIDevice.current.systemVersion
let Device_SysVersion   = Double(Device_SysVersionStr)!
let Device_SysName      = UIDevice.current.systemName
let Device_Model        = UIDevice.current.model

let IS_iPhone   = Device_Model.contains("iPhone")
let IS_iPad     = Device_Model.contains("iPad")
let IS_iPod     = Device_Model.contains("iPod")

let IS_iOS7     = Device_SysVersion >= 7.0 && Device_SysVersion <= 8.0
let IS_iOS8     = Device_SysVersion >= 8.0 && Device_SysVersion <= 9.0
let IS_iOS9     = Device_SysVersion >= 9.0 && Device_SysVersion <= 10.0
let IS_iOS10    = Device_SysVersion >= 10.0 && Device_SysVersion <= 11.0
let IS_iOS11    = Device_SysVersion >= 11.0 && Device_SysVersion <= 12.0
let IS_iOS12    = Device_SysVersion >= 12.0 && Device_SysVersion <= 13.0

let AppBundleID     = Bundle.main.bundleIdentifier!
let AppNamespace    = Bundle.main.object(forInfoDictionaryKey: kCFBundleExecutableKey as String) as! String
let AppDisplayName  = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
let AppVersion      = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
let AppBuildVersion = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
let AppVersionMajor = Int(AppVersion.components(separatedBy: ".").first!)
let AppVersionMinor = Int(AppVersion.components(separatedBy: ".")[1])
let AppVersionPatch = Int(AppVersion.components(separatedBy: ".").last!)

let AppSandboxPath      = NSHomeDirectory()
let AppDocumentsPath    = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
let AppLibraryPath      = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)
let AppCachesPath       = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
let AppTmpPath          = NSTemporaryDirectory()
