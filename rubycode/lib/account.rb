class Account
	attr_accessor :balance

	attr_reader :cleared_balance
	protected :cleared_balance

	def initialzie(balance)
		@balance = balance
	end

	def greater_balance_than?(other)
		@cleared_balance > other.cleared_balance
	end
end