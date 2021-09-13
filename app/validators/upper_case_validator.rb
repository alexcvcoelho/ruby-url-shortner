class UpperCaseValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || 'Use Upper case') unless upper_case?(value)
  end

  def upper_case?(value)
    value =~ /\A[A-Z]/
  end
end
