# WARNING Experimental : forget about it for now

# require 'pp'

# def default_attr_reader=(value)
#   puts __method__
# end

# def attr_readeronly(*attributes_syms)
#   attributes_syms.each do |sym|
#     define_method(sym, instance_method(:default_attr_reader=))
#     self.class_eval("attr_reader :#{sym.id2name}")
#   end
# end