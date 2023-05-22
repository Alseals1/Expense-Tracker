//
//  PreviewData.swift
//  ExpenseTracker
//
//  Created by Alandis Seals on 5/2/23.
//

import Foundation
import SwiftUI

var tranactionPreviewData = Transaction(id: 1, date: "01/24/2023", institution: "Desjarins", account: "Visa Desjarins", merchant: "Apple", amount: 11.49, type: "debit", categoryId: 801, category: "Software", isPending: false, isTransfer: false, isExpense: false, isEdited: false)

var transactionListPreviewData = [Transaction](repeating: tranactionPreviewData, count: 10)
