import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String, Double)]

final class TransactionViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        getTransaction()
    }
    
    func getTransaction() {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                    case .failure(let error):
                        print("Error fetching transaction: \(error.localizedDescription)")
                    case .finished:
                        print("Finished Fetching Transaction")
                }
            } receiveValue: { [weak self] result in
                self?.transactions = result
            }
            .store(in: &cancellable)
    }
    
    func groupTransactionByMonth() -> TransactionGroup {
        guard !transactions.isEmpty else { return [:] }
        let groupTransaction = TransactionGroup(grouping: transactions) { $0.month }
        return groupTransaction
    }
    
    func accumulateTransaction() -> TransactionPrefixSum {
        print("Accumulate Transaction!!!!!!!!")
        guard !transactions.isEmpty else { return [] }
        let today  = "2/23/2022".dateParse() // Date()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)
        
        var sum: Double = .zero
        sum = sum.roundTo2Digits()
        var accSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval?.start ?? Date(), to: today, by: 60 * 60 * 24) {
            let dailyExpenses = transactions.filter { $0.dateParsed == date && $0.isExpense }
            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.signAmount }
            sum += dailyTotal
            accSum.append((date.formatted(), sum))
        }
         return accSum
    }
}
