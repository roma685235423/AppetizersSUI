import SwiftUI

struct AccountView: View {
    
    @StateObject var viewModel = AccountViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("FirstName", text: $viewModel.user.firstName)
                    TextField("LastName", text: $viewModel.user.lastName )
                    TextField("Email", text: $viewModel.user.email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.none)
                        .autocorrectionDisabled(true)
                    DatePicker("Birthday", selection: $viewModel.user.birthDate, displayedComponents: .date)
                    Button("Save Changes") {
                        viewModel.saveChanges()
                    }
                } header: {
                    Text("Personal info ")
                }

                Section {
                    Toggle("Extra napkins",
                           isOn: $viewModel.user.extraNapkins)
                    Toggle("Frequent reflls",
                           isOn: $viewModel.user.frequentReflls)
                } header: {
                    Text("Requests ")
                }
                .tint(Color.brandPrimary)
            }
                .navigationTitle("🤣 Account")
        }
        .onAppear {
            viewModel.retrieveUserData()
        }
        .alert(viewModel.alertItem?.title ?? Text(""),
               isPresented: $viewModel.isShowingAlert) {
        } message: {
            viewModel.alertItem?.message
        }
    }
}

#Preview {
    AccountView()
}

 
