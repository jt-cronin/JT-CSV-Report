
def categoryTotal(account, category, total = 0)
	@accounts[account][category].each {|amount| total += amount}
	total.round(2)
end


def categoryAverage(account, category)
	(categoryTotal(account, category) /@accounts[account][category].length).round(2)
end


def calcBalance(account, balance = 0)
	@accounts[account].each {|category, transaction| transaction.each {|amount| balance += amount} }
	balance.round(2)
end


def displayReg account
	puts "Account: #{account}.. Balance: $#{calcBalance(account)}"
	puts "Category".ljust(20) + "Total Spent".ljust(20) + "Average Transaction"
	@accounts[account].each do |category, transaction|
		puts category.to_s.ljust(20) + "$" +categoryTotal(account, category).to_s.ljust(20) + "$" + categoryAverage(account, category).to_s.ljust(20)
	end
	nil
end


def displayHTML account
	puts "Here is the display for HTML"
	puts
	puts "<h1>#{account}</h1>\n<p>$#{calcBalance(account)}</p>\n<hr>\n<table>"
	puts "\t<tr>\n\t\t<th>Category</th>\n\t\t<th>Total Spent</th>\n\t\t<th>Avg Transaction</th>\n\t</tr>"
	puts
	@accounts[account].each do |category, transaction|
		puts "\t<tr>\n\t\t<td>#{category.to_s}</td>\n\t\t<td>$#{categoryTotal(account, category).to_s}</td>\n\t\t<td>$#{categoryAverage(account, category).to_s}</td\n\t</tr>"
	end
	puts "</table>"
end



def displayCSV account
	puts "Here is the display for CSV"
	puts
	puts "#{account},#{calcBalance(account)}"
	puts "Category,Total Spent,Avg Transaction"
	@accounts[account].each do |category, transaction|
		puts "#{category},#{categoryTotal(account, category)},#{categoryAverage(account, category)}"
	end
end