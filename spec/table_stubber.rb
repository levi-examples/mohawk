require 'securerandom'

class TableStubber
  include RSpec::Mocks::ExampleMethods, RAutomation::Adapter::MsUia

  attr_reader :table, :rows

  def initialize(table)
    @table = table
    @id = SecureRandom.base64
    @table.stub(:search_information).and_return(@id)
    @table.stub(:selected_rows).and_return []
    @rows = []
  end

  def self.stub(table)
    TableStubber.new(table)
  end

  def with_headers(*headers)
    UiaDll.stub(:table_headers).with(@id).and_return(headers.map(&:to_s))
    self
  end

  def and_row(*values)
    stub_cells_for(add_row, values)
    self
  end

  def should_singly_select_row(which)
    UiaDll.should_receive(:table_single_select).with(@id, which)
  end

  private
  def add_row
    row = double("table #{@id}, row #{rows.count}")
    row.stub(:row).and_return(rows.count)
    Row.stub(:new).with(table, :index => rows.count).and_return(row)
    rows << row
    table.stub(:row_count).and_return(rows.count)
    row
  end

  def stub_cells_for(row, values)
    cells = []
    values.each_with_index do |value, index|
      cell = double("Cell at #{row.row}, #{index}")
      Cell.stub(:new).with(row, :index => index).and_return(cell)
      cell.stub(:text).and_return(value)
      cells << cell
    end
    row.stub(:value).and_return(values.first)
    row.stub(:cells).and_return(cells)
  end
end