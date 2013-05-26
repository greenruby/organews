require_relative '../../lib/greeby/builder'

namespace :generate do

  desc "generate a new letter html file"
  task :letter do
    builder = Greeby::Builder.new
    builder.make_letter('grn.yml')
    builder.make_archives('grn.yml')
  end

  desc "updates static website"
  task :web do
    builder = Greeby::Builder.new
    builder.make_web
  end

end