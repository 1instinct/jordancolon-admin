#
# Place all seeds in /seeds/ folder.
#
Dir[File.dirname(__FILE__) + '/seeds/*.rb'].sort.each do |file|
  puts "Seeds #{file} ..."
  require file
end


Spree::Core::Engine.load_seed if defined?(Spree::Core)
Spree::Auth::Engine.load_seed if defined?(Spree::Auth)
