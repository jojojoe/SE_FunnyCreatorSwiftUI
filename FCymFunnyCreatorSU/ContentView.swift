//
//  ContentView.swift
//  FCymFunnyCreatorSU
//
//  Created by JOJO on 2021/1/5.
//

import SwiftUI

struct ContentView: View {
    @State var isActive = false

    var body: some View {
        FCMainView()
            .environmentObject(FCSplashViewManager.default)
        
//        FCCreatorSaveView()

//        FCCreatorEmojiStickerEditView( contentIconList: CFResourceModelManager.default.creatorEmojiItemList)


//        FCEditQRcodePreview(qrImage: UIImage(named: "background_ic_5")!, contentImage: UIImage(named: "background_ic_4")!)
//
//        FCEditSaveView(resultImage: UIImage(named: "background_ic_5")!)

//        FCEditStickerAndBgView(events: UserEvents(), maskShapeName: "shape_big_1", bgImageName: "background_big_3", stickerName: "sticker_big_1")

//        ForEach(0..<CFResourceModelManager.default.shapeItemList.count) { index in
//            HStack {
//                FCShapeCell(rowItem: CFResourceModelManager.default.shapeItemList.first!, selectAction: {
//
//                }, isCurrentSelectIndex: .constant(0))
//                .frame(width: 65, height: 65, alignment: .center)
//            }
//            .frame(width: 315, height: 100, alignment: .center)
//
//        }






//        FCStoreView().environmentObject(CoinManager.default)
//        FCCameraTakeView()

//        SidebarView(selectionKeeper: 2)

//        NavigationView {
//            VStack {
//                NavigationLink(destination: FCCameraTakeView()
//                                , isActive: $isActive) {
//
//                    Button {
//                        request()
//                    } label: {
//                        Text("跳转")
//                    }
//                }
//            }
//        }

    }

//    func request() {
//        PrivacyAuthorizationManager.default.requestCameraPermission {
//
//            self.isActive = true
//        } deniedBlock: {
//
//        }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

//struct ContentView: View {
//    @State var imageData: Data?
//
//    var body: some View {
//        VStack {
//            testView
//                .frame(width: 300, height: 300)
//                .onTapGesture {
//                    convertViewToData(view: testView, size: .init(width: 300, height: 300)) {
//                        imageData = $0
//                    }
//                }
//            if let imageData = imageData, let uiImage = UIImage(data: imageData) {
//                Image(uiImage: uiImage)
//            }
//        }
////        .onAppear {
////
////        }
//    }
//
//    var testView: some View {
//        FCCreatorPreview(iconImage: UIImage(named: "emoji_sticker_ic_1")!)
//            .mask(Color(.black).frame(width: abs(300), height: abs(300), alignment: .center))
////        ZStack {
////            Color.blue
////            Circle()
////                .fill(Color.red)
////        }
//    }
//
//
//}
extension View {
    func convertViewToData<V>(view: V, size: CGSize, completion: @escaping (Data?) -> Void) where V: View {
        guard let rootVC = UIApplication.shared.windows.first?.rootViewController else {
            completion(nil)
            return
        }
        let imageVC = UIHostingController(rootView: view.edgesIgnoringSafeArea(.all))
        imageVC.view.frame = CGRect(origin: .zero, size: size)
        DispatchQueue.main.async {
            rootVC.view.insertSubview(imageVC.view, at: 0)
            let uiImage = imageVC.view.asImage(size: size)
            imageVC.view.removeFromSuperview()
            completion(uiImage.pngData())
        }
    }
}

extension UIView {
    func asImage(size: CGSize) -> UIImage {
//        let format = UIGraphicsImageRendererFormat()
//        format.scale = 1
//        return UIGraphicsImageRenderer(size: size, format: format).image { context in
//            layer.render(in: context.cgContext)
//        }
        ////////////
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        return UIGraphicsImageRenderer(size: self.layer.frame.size, format: format).image { context in
            self.drawHierarchy(in: self.layer.bounds, afterScreenUpdates: true)
//            layer.render(in: context.cgContext)

        }
    }
    
}





//struct ContentView: View {
//    @State private var uiImage: UIImage? = nil
//    @State private var rect1: CGRect = .zero
//    @State private var rect2: CGRect = .zero
//
//    var body: some View {
//        VStack {
//            HStack {
//                Text("Next")
//                    .onTapGesture {
//                        self.uiImage =  self.rect1.uiImage
//                    }
//            }.frame(height: 50)
//            HStack {
//                VStack {
//                    Text("LEFT")
//                    Text("VIEW")
//                }
//                .padding(20)
//                .background(Color.green)
//                .border(Color.blue, width: 5)
//                .getRect($rect1)
//                .onTapGesture {
//
//                }
//
//                VStack {
//                    Text("RIGHT")
//                    Text("VIEW")
//                }
//                .padding(40)
//                .background(Color.yellow)
//                .border(Color.green, width: 5)
//                .getRect($rect2)
//                .onTapGesture {
//                    self.uiImage =  self.rect2.uiImage
//                }
//            }
//
//            if uiImage != nil {
//                VStack {
//                    Text("Captured Image")
//                    Image(uiImage: self.uiImage!).padding(20).border(Color.black)
//                }.padding(20)
//            }
//        }
//    }
//}
