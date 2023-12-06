//
//  RegisterView.swift
//  EcoPlay_ios_front
//
//  Created by Zeddin Dhia on 26/11/2023.
//

import SwiftUI
import UIKit

struct RegisterView: View {
  
    @Binding var showSignup: Bool
    @ObservedObject var viewModel: RegisterViewModel
    @ObservedObject var loginViewModel: LoginViewModel = LoginViewModel()
    @State private var image = UIImage()
    @State private var showSheet = false
    init(viewModel: RegisterViewModel, showSignup: Binding<Bool>) {
         self.viewModel = viewModel
         self._showSignup = showSignup
     }
    var body: some View {
        ZStack {
           
            Image("eco_play_background") // Make sure to replace "eco_play_background" with your actual image name
                .resizable()
                .edgesIgnoringSafeArea(.all)
          
            VStack {
                if(self.image.size == .zero){
                Button(action: {
                    showSheet = true
                    print("image \(self.image)")
                }, label: {
                    
                        Image(systemName: "photo")

                    
                        
            
                }).padding()
                    .foregroundColor(.white)
                    .background(Color(hex: "#44F1A6"))
                    .cornerRadius(50)
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                
                }else{
                    Image(uiImage: self.image)
                        .resizable()
                        .cornerRadius(50)
                        .frame(width: 80, height: 80)
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .onTapGesture {
                           showSheet = true
                         }
                }
                
                
                            
                
                HStack{
                    CustomTF(sfIcon: "person.fill", hint: "First Name ", value: $viewModel.firstName)
                    CustomTF(sfIcon: "person.fill", hint: "Last Name ", value: $viewModel.lastName)
                    
                }.padding(.horizontal, 40)
                    .padding(.top,30)
                CustomTF(sfIcon: "envelope.fill", hint: "Email ", value: $viewModel.email).padding(.horizontal, 40).padding(.top, 20)
                CustomTF(sfIcon: "phone.fill", hint: "Phone Number ", value: $viewModel.phoneNumber).padding(.horizontal, 40).padding(.top, 20)
                CustomTF(sfIcon: "lock.fill", hint: "Password ",isPassword: true, value: $viewModel.password).padding(.horizontal, 40).padding(.top, 20)
                CustomTF(sfIcon: "lock.fill", hint: "Confirm Password ",isPassword: true, value: $viewModel.confirmPassword).padding(.horizontal, 40).padding(.top, 20)
                
              
                
                Button("Register") {
                    viewModel.registerUser()
                    
                    print(viewModel.showSignup)
                }
                
                .fontWeight(.bold)
                .frame(maxWidth: 120)
                .frame(maxHeight: 30)
                .padding()
                .foregroundColor(.white)
                .background(Color(hex: "#44F1A6"))
                .cornerRadius(70)
                .padding(.horizontal, 40)
                .padding(.top, 20)
                NavigationLink(destination: LoginView(viewModel: loginViewModel, showSignup: $viewModel.showSignup), isActive: $viewModel.showSignIn) {
                    
                         EmptyView()
                     }
                .alert(isPresented: $viewModel.showingAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text(viewModel.errorMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
              
                
                Spacer()
                
              HStack {
                    Text("Already have an account ?")
                    Button("Sign In!") {
                        // Sign up action
                        showSignup = false
                    }
                    .foregroundColor(.blue)
                }
                .padding(.bottom, 20)
            }
            .padding(.top, 100)
            .sheet(isPresented: $showSheet) {
                ImagePicker( selectedImage: self.$image,viewModel: self.viewModel)
                  }
        }
    }
}


struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImage: UIImage
      var viewModel: RegisterViewModel
    init(selectedImage: Binding<UIImage>, viewModel: RegisterViewModel) {
          self._selectedImage = selectedImage
          self.viewModel = viewModel
      }
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {

        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator

        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        var parent: ImagePicker
       // var viewModel: RegisterViewModel
        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
                parent.viewModel.avatar = image
            }

            parent.presentationMode.wrappedValue.dismiss()
        }

    }
}
struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/*
func postComment(challengeId: String, userId: String, title: String, description: String, image: UIImage?,     completion: @escaping (Result<Comment, Error>) -> Void
) {
            let url = URL(string: "\(baseURLString)\(commentsPath)/\(challengeId)")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"

            let boundary = "Boundary-\(UUID().uuidString)"
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

            var body = Data()

            // Add text parameters
                body.append(convertFormField(named: "userId", value: userId, using: boundary))
                body.append(convertFormField(named: "title", value: title, using: boundary))
                body.append(convertFormField(named: "description", value: description, using: boundary))

            // Add image data
            if let imageData = image?.jpegData(compressionQuality: 1) {
                body.append(convertFileData(fieldName: "image",
                                            fileName: "\(Date().timeIntervalSince1970).jpg",
                                            mimeType: "image/jpg",
                                            fileData: imageData,
                                            using: boundary))
            }

            body.append("--\(boundary)--\r\n".data(using: .utf8)!)
            request.httpBody = body

            // Perform request
        URLSession.shared.dataTask(with: request) { data, response, error in
               DispatchQueue.main.async {
                   if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                       // Log the status code and the response for debugging
                       print("Status Code: \(httpResponse.statusCode)")
                       if let responseData = data, let responseString = String(data: responseData, encoding: .utf8) {
                           print("Response: \(responseString)")
                       }
                       let errorMessage = "Server responded with status code: \(httpResponse.statusCode)"
                       completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                       return
                   }

                   if let error = error {
                       completion(.failure(error))
                       return
                   }

                   guard let data = data, !data.isEmpty else {
                       let noDataError = NSError(domain: "", code: -1003, userInfo: [NSLocalizedDescriptionKey: "No data received from server."])
                       completion(.failure(noDataError))
                       return
                   }

                   do {
                       let newComment = try JSONDecoder().decode(Comment.self, from: data)
                       completion(.success(newComment))
                   } catch let decodingError {
                       print("Decoding error: \(decodingError)")
                       // Handle the decoding error here, and provide a user-friendly error message if needed
                       completion(.failure(decodingError))
                   }

               }
           }.resume()
    }*/
