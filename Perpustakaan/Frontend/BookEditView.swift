//
//  BookEditView.swift
//  Perpustakaan
//
//  Created by Adimas Surya Perdana Putra on 07/05/22.
//

import SwiftUI
 
enum Mode {
  case new
  case edit
}
 
enum Action {
  case delete
  case done
  case cancel
}
 
struct BookEditView: View {
  @Environment(\.managedObjectContext) var saveImage
  @Environment(\.presentationMode) private var presentationMode
  @State var presentActionSheet = false
  @State var shouldShowImagePicker = false
  @State var image: UIImage?
    
 
   
  @ObservedObject var viewModel = BookViewModel()
  var mode: Mode = .new
  var completionHandler: ((Result<Action, Error>) -> Void)?
   
   
  var cancelButton: some View {
      Button(action: {
          self.handleCancelTapped()
          
      }) {
      Text("Batal")
    }
  }
   
  var saveButton: some View {
    Button(action: { self.handleDoneTapped()
        print("ini fotoo: \(String(describing: image))")
        
    }) {
      Text(mode == .new ? "Selesai" : "Simpan")
        
    }
    .disabled(!viewModel.modified)
  }
    func getSpeechz(value: String) -> String{

        return String(value)
    }
    
    func grandSpeechz() -> String {
        var judul : String = ""
        
        judul = viewModel.book.judul_buku
        
        return getSpeechz(value: judul)
        
    }
   
    
  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Judul Buku")) {
          TextField("Judul Buku", text: $viewModel.book.judul_buku)
                .disableAutocorrection(true)
        }
          
          Section(header: Text("Deskripsi Buku")) {
              TextEditor(text: $viewModel.book.deskripsi)
                    .disableAutocorrection(true)
          }
          
          Section(header: Text("Jumlah Halaman")) {
            TextField("Jumlah Halaman", value: $viewModel.book.halaman, formatter: NumberFormatter())
                  .disableAutocorrection(true)
          }
         
        Section(header: Text("Pengarang")) {
          TextField("Pengarang", text: $viewModel.book.pengarang)
                .disableAutocorrection(true)
        }
 
        Section(header: Text("Foto Buku")) {
            TextField("Image", text: $viewModel.book.foto)
                .disableAutocorrection(true)
        }
          
          if mode == .new {
              Section(header: Text("Tambahkan Foto")) {
                  VStack {
                      ZStack(alignment: .top) {
                          Rectangle()
                              .foregroundColor(Color.white)
                              .edgesIgnoringSafeArea(.top)
                              .frame(height: 100)
                           
                          Button {
                              shouldShowImagePicker.toggle()
                          } label: {
                              VStack {
                                  if let image = self.image {
                                      Image(uiImage: image)
                                          .resizable()
                                          .scaledToFill()
                                          .frame(width: 143, height: 143)
                                          .cornerRadius(10)
                                  } else {
                                      Image(systemName: "photo")
                                          .font(.system(size: 80))
                                          .padding()
                                          .foregroundColor(Color(.label))
                                  }
                              }
//                              .overlay(RoundedRectangle(cornerRadius: 80)
//                                          .stroke(Color.black, lineWidth: 3)
//                              )
                          }
                      }//end Zstack
                  }
              }
              
            }
           
        if mode == .edit {
          Section {
            Button("Hapus Buku") { self.presentActionSheet.toggle() }
              .foregroundColor(.red)
          }
        }
      }
      .navigationTitle(mode == .new ? "Tambah Buku" : viewModel.book.judul_buku)
      .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
      .navigationBarItems(
        leading: cancelButton,
        trailing: saveButton
      )
      .actionSheet(isPresented: $presentActionSheet) {
        ActionSheet(title: Text("Apakah kamu yakin?"),
                    buttons: [
                      .destructive(Text("Hapus Buku"),
                                   action: { self.handleDeleteTapped() }),
                      .cancel()
                    ])
      }
        
    }
  }
   
  func handleCancelTapped() {
    self.dismiss()
  }
   
    func handleDoneTapped() {
        self.viewModel.handleDoneTapped()
    self.dismiss()
  }
   
  func handleDeleteTapped() {
    viewModel.handleDeleteTapped()
    self.dismiss()
    self.completionHandler?(.success(.delete))
  }
   
  func dismiss() {
    self.presentationMode.wrappedValue.dismiss()
  }
}
 
struct BookEditView_Previews: PreviewProvider {
  static var previews: some View {
      let book = Book(judul_buku: "", deskripsi: "", pengarang: "", halaman: 0, foto: "", status: true)
    let bookViewModel = BookViewModel(book: book)
    return BookEditView(viewModel: bookViewModel, mode: .edit)
  }
}
