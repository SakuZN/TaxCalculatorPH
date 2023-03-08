require 'gtk3'
require 'pango'
require_relative 'taxform'
class TaxCalculator < Gtk::Application
  include TAXFORM
  def initialize
    super("com.example.TaxCalculator", :flags_none)
    signal_connect "activate" do |application|
      # Create a top-level window with a grid
      window = Gtk::ApplicationWindow.new(application)
      window.set_title("Tax Calculator")
      window.set_size_request(500, 400)
      window.set_position(:center)

      #custom font
      font_desc = Pango::FontDescription.new("Sans 14")
      grid = Gtk::Grid.new
      grid.set_row_spacing(10)
      grid.set_column_spacing(10)
      grid.set_column_homogeneous(true)

      # Add a label and text field for monthly income
      label_income = Gtk::Label.new("Monthly Income")
      @entry_income = Gtk::Entry.new
      label_income.override_font(font_desc)

      #attach label and entry to top middle of grid
      grid.attach(label_income, 1, 0, 1, 1)
      grid.attach(@entry_income, 2, 0, 1, 1)

      # Add a button to calculate taxes
      button_calculate = Gtk::Button.new(:label => "Calculate")
      button_calculate.override_font(font_desc)
      button_calculate.signal_connect('clicked') do
        #if empty or invalid characters display error message
        if @entry_income.text.empty? || @entry_income.text.to_i == 0
          dialog = Gtk::MessageDialog.new(:parent => window, :flags => :destroy_with_parent,
                                          :type => :error, :buttons_type => :close,
                                          :message => "Please enter a valid monthly income.")
          dialog.run
          dialog.destroy
        else
          #get monthly income
          calculate_taxes
        end
      end
      grid.attach(button_calculate, 3, 0, 1, 1)

      # Tax Computation section
      tax_label = Gtk::Label.new("Tax Computation")
      grid.attach(tax_label, 0, 2, 1, 1)

      income_tax_label = Gtk::Label.new("Income Tax")
      grid.attach(income_tax_label, 0, 3, 1, 1)

      @income_tax_entry = Gtk::Entry.new
      @income_tax_entry.set_editable(false)
      grid.attach(@income_tax_entry, 1, 3, 1, 1)

      net_pay_label = Gtk::Label.new("Net Pay (after Income Tax)")
      grid.attach(net_pay_label, 0, 4, 1, 1)

      @net_pay_entry = Gtk::Entry.new
      @net_pay_entry.set_editable(false)
      grid.attach(@net_pay_entry, 1, 4, 1, 1)

      # Add Monthly Contributions section
      label_monthly_contributions = Gtk::Label.new('Monthly Contributions:')
      grid.attach(label_monthly_contributions, 3, 1, 1, 1)

      label_sss = Gtk::Label.new('SSS:')
      grid.attach(label_sss, 3, 2, 1, 1)

      @entry_sss = Gtk::Entry.new
      @entry_sss.set_width_chars(10)
      @entry_sss.editable = false
      grid.attach(@entry_sss, 4, 2, 1, 1)

      label_philhealth = Gtk::Label.new('Philhealth:')
      grid.attach(label_philhealth, 3, 3, 1, 1)

      @entry_philhealth = Gtk::Entry.new
      @entry_philhealth.set_width_chars(10)
      @entry_philhealth.editable = false
      grid.attach(@entry_philhealth, 4, 3, 1, 1)

      label_pag_ibig = Gtk::Label.new('Pag-IBIG:')
      grid.attach(label_pag_ibig, 3, 4, 1, 1)

      @entry_pag_ibig = Gtk::Entry.new
      @entry_pag_ibig.set_width_chars(10)
      @entry_pag_ibig.editable = false
      grid.attach(@entry_pag_ibig, 4, 4, 1, 1)

      label_total_contribution = Gtk::Label.new('Total Contribution:')
      grid.attach(label_total_contribution, 3, 5, 1, 1)

      @entry_total_contribution = Gtk::Entry.new
      @entry_total_contribution.set_width_chars(10)
      @entry_total_contribution.editable = false
      grid.attach(@entry_total_contribution, 4, 5, 1, 1)

      # Add Total Deduction and Net pay after deductions
      label_total_deduction = Gtk::Label.new('Total Deduction:')
      grid.attach(label_total_deduction, 1, 6, 1, 1)

      @entry_total_deduction = Gtk::Entry.new
      @entry_total_deduction.set_width_chars(10)
      @entry_total_deduction.editable = false
      grid.attach(@entry_total_deduction, 2, 6, 1, 1)

      label_net_pay = Gtk::Label.new('Net Pay after Deductions:')
      grid.attach(label_net_pay, 1, 8, 1, 1)

      @entry_net_pay = Gtk::Entry.new
      @entry_net_pay.set_width_chars(10)
      @entry_net_pay.editable = false
      grid.attach(@entry_net_pay, 2, 8, 1, 1)

      # override font of all labels
      labels = grid.children.select { |child| child.is_a? Gtk::Label }
      labels.each do |label|
        label.override_font(font_desc)
        label.override_background_color(:normal, Gdk::RGBA.new(0.8, 0.8, 1.0, 0.8))
      end
      # Show the window and add the grid to it
      window.add(grid)
      window.signal_connect('destroy') { Gtk.main_quit }
      window.show_all
    end
  end

  def calculate_taxes
    monthly_income = @entry_income.text.gsub(/[^0-9\.]/, '').to_f
    @entry_income.text = "\u20B1 " + @entry_income.text.to_f.to_s
    pag_ibig = getPagIBIG(monthly_income).to_f.round(2)
    sss = getSSS(monthly_income).to_f.round(2)
    philhealth = getPhilHealth(monthly_income).to_f.round(2)
    total = getTotalContributions(sss, philhealth, pag_ibig).to_f.round(2)

    @entry_sss.text = "\u20B1 " + sss.to_s
    @entry_philhealth.text = "\u20B1 " + philhealth.to_s
    @entry_pag_ibig.text = "\u20B1 " + pag_ibig.to_s
    @entry_total_contribution.text = "\u20B1 " + total.to_s

  end
end

# Start the application
app = TaxCalculator.new
puts app.run