//
//  SenderPhotoReq.swift
//  Perpustakaan
//
//  Created by Adimas Surya Perdana Putra on 12/05/22.
//

import SwiftUI

struct SenderPhotoReq: View {
//    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.managedObjectContext) var moc
    @State var name = ""
    @State var descriptions = ""
    @State var image : Data = .init(count: 0)
    @State var show = false
    var body: some View {
        NavigationView{
            Form {
                if self.image.count != 0 {
                    Button(action: {
                        self.show.toggle()
                    }){
                        Image(uiImage: UIImage(data: self.image)!)
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 100, height: 100, alignment: .center)
                            .cornerRadius(6)
                    }
                }else{
                    Button {
                        self.show.toggle()
                    } label: {
                        Image(systemName: "photo.fill")
                            .font(.system(size: 55))
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.center)
                    }

                  
                }
                
                Section(header: Text("Nama Buku")){
                    TextField("Nama Buku", text: self.$name)
                        .disableAutocorrection(true)
                }
                Section(header: Text("Deskripsi")){
                    TextField("description", text: self.$descriptions)
                        .disableAutocorrection(true)
                }
            }.navigationBarTitle("Input Data Buku", displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    self.dismiss()
                }, label: {
                    Text("Batal")
                }),
                                    trailing: Button(action: {
                    let send = Saving(context: self.moc)
                    send.username = self.name
                    send.descriptions = self.descriptions
                    send.image = self.image
                }, label: {
                    Text("Simpan")
                }))
        
        }.sheet(isPresented: self.$show) {
            ImagePicker(show: self.$show, image: self.$image)
        }
    }
    func dismiss() {
//      self.presentationMode.wrappedValue.dismiss()
    }
}
