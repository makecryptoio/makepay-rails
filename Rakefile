task default: :validate

task :validate do
  sh "node scripts/validate.mjs"
  Dir["{app,lib}/**/*.rb"].each do |file|
    sh "ruby -c #{file}"
  end
  sh "gem build makepay-rails.gemspec"
end
