require "CSV"
require 'pry'




@accounts = {}


CSV.foreach("accounts.txt", {headers: true, return_headers: false}) do |row|
		@accounts[row["Account"].chomp.to_sym] ={}
	end

CSV.foreach("accounts.txt", {headers: true, return_headers: false}) do |row|
		@accounts[row["Account"].chomp.to_sym][row["Category"].chomp.to_sym] = []
	end


CSV.foreach("accounts.txt", {headers: true, return_headers: false}) do |row|
	account = row["Account"].chomp.to_sym
	category = row["Category"].chomp.to_sym
	outflow = -row["Outflow"][1..-1].to_f
	inflow = row["Inflow"][1..-1].to_f
	
	if inflow == 0 
		then @accounts[account][category] << outflow  
	else@accounts[account][category] << inflow
		
	end
end

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


def displayAccount account
	puts "Account: #{account}.. Balance: $#{calcBalance(account)}"
	puts "Category".ljust(20) + "Total Spent".ljust(20) + "Average Transaction"
	@accounts[account].each do |category, transaction|
		puts category.to_s.ljust(20) + "$" +categoryTotal(account, category).to_s.ljust(20) + "$" + categoryAverage(account, category).to_s.ljust(20)
	end
	nil
end

@accounts.each do |account, accountdata|
	displayAccount account
	puts
end




