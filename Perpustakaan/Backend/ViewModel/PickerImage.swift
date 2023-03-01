//
//  PickerImage.swift
//  Perpustakaan
//
//  Created by Adimas Surya Perdana Putra on 12/05/22.
//

import SwiftUI

struct PickerImage: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Saving.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Saving.username, ascending: true),
                                    NSSortDescriptor(keyPath: \Saving.image, ascending: true),
                                    NSSortDescriptor(keyPath: \Saving.favo, ascending: false),
                                    NSSortDescriptor(keyPath: \Saving.descriptions, ascending: true)
                                                    ]) var savings: FetchedResults<Saving>
    @State var imagev : Data = .init(count: 0)
    @State var show = false
    
    var body: some View {
        NavigationView{
            List(savings, id: \.self){ save in
                VStack{
                    Image(uiImage: UIImage(data: save.image ?? self.imagev)!)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width - 34, height: 210)
                        .cornerRadius(15)
                    
                    HStack{
                        Text("\(save.descriptions ?? "")")
                        Spacer()
                        Button(action:{
                            save.favo.toggle()
                            try? self.moc.save()
                        }){
                            Image(systemName: save.favo ? "bookmark.fill": "bookmark")
                        }
                    }
                    Text("\(save.username ?? "")")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                }
            }.navigationTitle("Request Buku")
                .navigationBarItems(trailing: Button(action:{
                    self.show.toggle()
                }){
                    Image(systemName: "plus")
                }
                )
        }
        .sheet(isPresented: self.$show){
            SenderPhotoReq().environment(\.managedObjectContext, self.moc)
        }
    }
}

struct PickerImage_Previews: PreviewProvider {
   
    static var previews: some View {
        PickerImage()
    }
}
