//
//  SceneDelegate.swift
//  notion-mind
//
//  Created by 차상진 on 3/5/25.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    
    let loginViewModel = LoginViewModel()

    


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        
//        if let urlContext = connectionOptions.urlContexts.first {
//               let sendingAppID = urlContext.options.sourceApplication
//               let url = urlContext.url
//               print("URL을 보낸 앱: \(sendingAppID ?? "Unknown")")
//               print("실행된 URL: \(url)")
//           }
        
        
        
        //UserDefaults 전부 삭제
//        for key in UserDefaults.standard.dictionaryRepresentation().keys {
//            UserDefaults.standard.removeObject(forKey: key.description)
//        }
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        
        let isLoggedIn = SaveDataManager.getData(type: Bool.self, key: .isLogin) ?? false
        /*AuthManager.shared.isLoggedIn()*/
        
        
               let rootViewController: UIViewController
               if isLoggedIn {
                   rootViewController = MainViewController()
               } else {
                   rootViewController = LoginViewController(viewModel: loginViewModel)
               }

        window.rootViewController = rootViewController
        self.window = window
        window.makeKeyAndVisible()
        
    }
    
    
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let urlContext = URLContexts.first else { return }
        
        
        let url = urlContext.url
        guard let components = URLComponents(string: url.absoluteString) else { return }
//        let host = components.host ?? "host 없음"
        let items = components.queryItems ?? []
        
        for i in items {
            
            let queryName = i.name
            guard let value = i.value else { continue }
            switch queryName {
            case "scuess":
                if value == "true" {
                    loginViewModel.authSuccess.accept(true)
                } else {
                    loginViewModel.authSuccess.accept(false)
                }
                
            case "bot_id":
                //로컬에 이 값을 저장
                SaveDataManager.setData(value: value, key: .botId)
                
            default:
                break
            } // switch
            
        
            
        }
        
         
    }
    
 


    
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

