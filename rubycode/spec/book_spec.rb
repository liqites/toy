RSpec.describe BookInStock do
  describe "puts " do
    it "test puts" do
      b = BookInStock.new("sdsd",1.00)
      puts b
      expect(1).to eq(1)
    end

    it "read csv" do 
    	csv_reader = CsvReader.new
    	csv_reader.read_in_csv_data("/Users/liqi/projects/personal/toy/rubycode/data/data.csv")
    	puts csv_reader.total_value_in_stock
    	expect(1).to eq(1)
    end
  end
end
