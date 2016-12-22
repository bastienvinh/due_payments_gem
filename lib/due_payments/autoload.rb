# This file contains the logic all the class in this gem
LIB_DUE_PAYMENT_ROOT ||= File.realpath("#{File.dirname(__FILE__)}/..")

# To not append severale times in the load path
unless $LOAD_PATH.include?(LIB_DUE_PAYMENT_ROOT)
  # Make sure that our lib on load path
  $LOAD_PATH << LIB_DUE_PAYMENT_ROOT
end

# To remove tricky problems about first included or not
require 'due_payments/due_payments_base'
require 'due_payments/identifier_module'

# load all the files on utils
Dir.glob("#{LIB_DUE_PAYMENT_ROOT}/due_payments/core/*.rb").each do |filename|
  filename["#{LIB_DUE_PAYMENT_ROOT}/"] = ""
  require "#{filename.gsub(/.rb$/, "")}"
end

# load all the files on core
Dir.glob("#{LIB_DUE_PAYMENT_ROOT}/due_payments/utils/*.rb").each do |filename|
  filename["#{LIB_DUE_PAYMENT_ROOT}/"] = ""
  require "#{filename.gsub(/.rb$/, "")}"
end

# load all the root
Dir.glob("#{LIB_DUE_PAYMENT_ROOT}/due_payments/*.rb").each do |filename|
  filename["#{LIB_DUE_PAYMENT_ROOT}/"] = ""
  require "#{filename.gsub(/.rb$/, "")}"
end