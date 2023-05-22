import SwiftUI
import SwiftUIFontIcon

struct TransactionView: View {
    var tranaction: Transaction
    
    var body: some View {
        HStack(spacing: 20) {
            //MARK: Transaction Category Icon
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.icon.opacity(0.3))
                .frame(width: 44, height: 44)
                .overlay {
                    FontIcon.text(.awesome5Solid(code: tranaction.icon), fontsize: 24, color: .icon)
                }
            
            VStack(alignment: .leading, spacing: 6) {
                // MARK: Transaction Merchant
                Text(tranaction.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                //MARK: Transaction Category
                Text(tranaction.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                
                //MARK: Transaction Date
                Text(tranaction.dateParsed, format: .dateTime.year().month().day())
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            Spacer()
            
            //MARK: Transaction Amount
            Text(tranaction.signAmount, format: .currency(code: "USD"))
                .bold()
                .foregroundColor(tranaction.type == TransactionType.credit.rawValue ? Color.text : .primary)
        }.padding([.top, .bottom], 8)
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView(tranaction: tranactionPreviewData)
        
    }
}
