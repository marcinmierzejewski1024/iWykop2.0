//
//  ContentView.swift
//  iWykop2.0
//
//  Created by Marcin Mierzejewski on 27/01/2023.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State var cancellable: AnyCancellable?

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding().onAppear {
            do {
                cancellable = try ApiV3Service(creditentialProvider: ApiV3CreditentialsProvider(), dataTaskProvider: DataTaskPublisherProvider()).authorizeApp().sink { completion in
                    switch completion {
                    case .finished:
                        print("succes")
                    case .failure(let err):
                        print("failure \(err)")
                    }
                } receiveValue: { response in
                    print("value \(response)")
                }
            } catch {
                print(error)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
