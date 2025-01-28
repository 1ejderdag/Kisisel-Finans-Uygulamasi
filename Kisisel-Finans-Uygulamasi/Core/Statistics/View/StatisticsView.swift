import SwiftUI
import Charts

struct StatisticsView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    @Environment(\.dismiss) var dismiss
    
    var expensesByCategory: [(category: ExpenseCategories, amount: Float)] {
        var categoryTotals: [ExpenseCategories: Float] = [:]
        
        for expense in homeViewModel.expenses {
            if let categoryEnum = ExpenseCategories(rawValue: expense.category) {
                categoryTotals[categoryEnum, default: 0] += expense.amount
            }
        }
        
        return categoryTotals.map { ($0.key, $0.value) }
            .sorted { $0.amount > $1.amount }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Kategori Analizi")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    if !expensesByCategory.isEmpty {
                        Chart {
                            ForEach(expensesByCategory, id: \.category) { item in
                                SectorMark(
                                    angle: .value("Tutar", item.amount),
                                    innerRadius: .ratio(0.618),
                                    angularInset: 1.5
                                )
                                .cornerRadius(5)
                                .foregroundStyle(by: .value("Kategori", item.category.title))
                            }
                        }
                        .frame(height: 300)
                        .padding()
                        
                        LazyVStack(alignment: .leading, spacing: 15) {
                            ForEach(expensesByCategory, id: \.category) { item in
                                HStack {
                                    Image(systemName: item.category.iconName)
                                        .foregroundStyle(Color(.systemBlue))
                                    
                                    Text(item.category.title)
                                        .font(.subheadline)
                                    
                                    Spacer()
                                    
                                    Text("₺\(String(format: "%.2f", item.amount))")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                }
                                .padding(.horizontal)
                            }
                        }
                    } else {
                        Text("Henüz harcama verisi bulunmamaktadır.")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                            .padding()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.black)
                    }
                }
            }
        }
    }
} 
