require "CSV"
require 'pry'
require_relative 'functions.rb'

input, *type = ARGV
input = input.to_sym
type = type.first.to_s
type = type.to_sym


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

@name = input

if @accounts.has_key?(@name)
	puts "Welcome, let me pull up your account"
	puts
else
	abort "Sorry, we do not recognize #{@name} as an account" 
end

case type
	when :CSV
		displayCSV @name
	when :HTML
		displayHTML @name
	else
		displayReg @name
	end

	






