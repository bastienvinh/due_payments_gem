require 'active_record'

LIB_ROOT = File.realpath("#{File.dirname(__FILE__)}/../lib/due_payments")

require "#{LIB_ROOT}/landlord"

Landlord = DuePayments::Landlord;

Landlord.create( :firstname => "Ginai", :lastname => "Kevin", :address => "7 th Heaven Street London", :zip_code => "LD4 7GH", :email => "hsorse@worse.com" )
Landlord.create( :firstname => "Miragda", :lastname => "Miranda", :address => "677, On Street main", :zip_code => "DD4 9GF", :email => "sinddy@yopmail.com" )
Landlord.create( :firstname => "Movement", :lastname => "ShipsPoloto", :address => "42 th Minaris", :zip_code => "CBF 7GH", :email => "gustave@worse.com" )
Landlord.create( :firstname => "Carry", :lastname => "Michelle", :address => "9 th madendon", :zip_code => "LD1 456", :email => "gmiaidas@gul.com" )

puts "Data seeded ..."