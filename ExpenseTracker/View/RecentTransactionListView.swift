import SwiftUI

struct RecentTransactionListView: View {
    @EnvironmentObject var transactionListVM: TransactionViewModel
    
    
    var body: some View {
        VStack {
            HStack {
                // MARK: Header Title
                Text("Recent Transaction")
                    .bold()
                
                Spacer()
                
                // MARK: Header Link
                NavigationLink {
                    TransactionListView()
                } label: {
                    HStack(spacing: 4) {
                        Text("See All")
                            Image(systemName: "chevron.right")
                    }
                    .foregroundColor(Color.icon)
                }

            }
            .padding(.top)
            
            // MARK: Recent Transaction List
            ForEach(Array(transactionListVM.transactions.prefix(6).enumerated()), id: \.element) { index, transaction in
                TransactionView(tranaction: transaction)
                Divider()
                    .opacity(index == 5 ? 0 : 1)
            }
            
        }
        .padding()
        .background(Color.systemBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
        .padding()
    }
}

struct RecentTransactionListView_Previews: PreviewProvider {
    static let transactionListView: TransactionViewModel = {
        let transactionListVM = TransactionViewModel()
        transactionListVM.transactions = transactionListPreviewData
        
        return transactionListVM
    }()
    
    static var previews: some View {
        NavigationView {
            RecentTransactionListView()
                .environmentObject(transactionListView)
        }
    }
}
