import SwiftUI

struct TransactionListView: View {
    @EnvironmentObject var transactionVM: TransactionViewModel
    
    var body: some View {
        VStack {
            List {
                // MARK: Transaction Group
                ForEach(Array(transactionVM.groupTransactionByMonth()), id: \.key) { month, transactions in
                    Section {
                        ForEach(transactions) { transaction in
                            TransactionView(tranaction: transaction)
                        }
                    } header: {
                        Text(month)
                    }
                    .listSectionSeparator(.hidden)

                }
            }
            .listStyle(.plain)
        }
        .navigationTitle(Text("Transactions"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static let transactionListView: TransactionViewModel = {
        let transactionListVM = TransactionViewModel()
        transactionListVM.transactions = transactionListPreviewData
        
        return transactionListVM
    }()
    
    static var previews: some View {
        NavigationView {
            TransactionListView()
                .environmentObject(transactionListView)
        }
    }
}
