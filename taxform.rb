# frozen_string_literal: true

module TAXFORM

  def getPagIBIG(monthly_income)
    if monthly_income <= 1500
      piFund = monthly_income * 0.01
      if piFund > 100
        return 100
      else
        return piFund
      end
    else
      piFund = monthly_income * 0.02
      if piFund > 100
        return 100
      else
        return piFund
      end
    end
  end
  def getSSS(monthly_income)
    case monthly_income
    when 0...4250
      return 4000 * 0.045
    when 4250...4750
      return 4500 * 0.045
    when 4750...5250
      return  5000 * 0.045
    when 5250...5750
      return 5500 * 0.045
    when 5750...6250
      return 6000 * 0.045
    when 6250...6750
      return 6500 * 0.045
    when 6750...7250
      return 7000 * 0.045
    when 7250...7750
      return 7500 * 0.045
    when 7750...8250
      return 8000 * 0.045
    when 8250...8750
      return 8500 * 0.045
    when 8750...9250
      return 9000 * 0.045
    when 9250...9750
      return 9500 * 0.045
    when 9750...10250
      return 10000 * 0.045
    when 10250...10750
      return 10500 * 0.045
    when 10750...11250
      return 11000 * 0.045
    when 11250...11750
      return 115000 * 0.045
    when 11750...12250
      return 12000 * 0.045
    when 12250...12750
      return 12500 * 0.045
    when 12750...13250
      return 13000 * 0.045
    when 13250...13750
      return 13500 * 0.045
    when 13750...14250
      return 14000 * 0.045
    when 14250...14750
      return 14500 * 0.045
    when 14750...15250
      return 15000 * 0.045
    when 15250...15750
      return 15500 * 0.045
    when 15750...16250
      return 16000 * 0.045
    when 16250...16750
      return 16500 * 0.045
    when 16750...17250
      return 17000 * 0.045
    when 17250...17750
      return 17500 * 0.045
    when 17750...18250
      return 18000 * 0.045
    when 18250...18750
      return 18500 * 0.045
    when 18750...19250
      return 19000 * 0.045
    when 19250...19750
      return 19500 * 0.045
    when 19750...20250
      return 20000 * 0.045
    when 20250...20750
      return 20500 * 0.045
    when 20750...21250
      return 21000 * 0.045
    when 21250...21750
      return 21500 * 0.045
    when 21750...22250
      return 22000 * 0.045
    when 22250...22750
      return 22500 * 0.045
    when 22750...23250
      return 23000 * 0.045
    when 23250...23750
      return 23500 * 0.045
    when 23750...24250
      return 24000 * 0.045
    when 24250...24750
      return 24500 * 0.045
    when 24750...25250
      return 25000 * 0.045
    when 25250...25750
      return 25500 * 0.045
    when 25750...26250
      return 26000 * 0.045
    when 26250...26750
      return 26500 * 0.045
    when 26750...27250
      return 27000 * 0.045
    when 27250...27750
      return 27500 * 0.045
    when 27750...28250
      return 28000 * 0.045
    when 28250...28750
      return 28500 * 0.045
    when 28750...29250
      return 29000 * 0.045
    when 29250...29750
      return 29500 * 0.045
    else
      return 30000 * 0.045
    end
  end

  def getPhilHealth(monthly_income)
    # contribution is set at 4.5%
    case monthly_income
    when 0..10000
      return 10000 * 0.045 / 2
    when 10000...90000
      return monthly_income * 0.045 / 2
    else
      return 4050
    end
  end

  def getTotalContributions(sss, philhealth, pagibig)
    return sss + philhealth + pagibig
  end
  def getIncomeTax(total_contributions, monthly_income)
    taxable_income = monthly_income - total_contributions
    case taxable_income
    when 0...20832
      return 0
    when 20833...33332
      return (taxable_income - 20833) * 0.15
    when 33333...66666
      return (taxable_income - 33333) * 0.20 + 1875
    when 66667...166666
      return (taxable_income - 66667) * 0.25 + 8541.80
    when 166667...666666
      return (taxable_income - 166667) * 0.30 + 33541.80
    else
      return (taxable_income - 666667) * 0.35 + 183541.80
    end
  end

  def getNetPayTax(monthly_income, income_tax)
    return monthly_income - income_tax
  end
  def getTotalDeductions(total_contributions, income_tax)
    return total_contributions + income_tax
  end
  def getNetPayDeduct(monthly_income, total_deductions)
    return monthly_income - total_deductions
  end
end
