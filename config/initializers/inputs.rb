require_dependency Rails.root.join('app/inputs/pagedown_input')

Dir.glob("app/inputs/**/*.rb") do |f|
  require_dependency Rails.root.join(f)
end
