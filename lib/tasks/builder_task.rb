namespace :build do

  desc "compiles the font from svg icons in stuff/icons"
  task :fonts do
    sh "fontcustom compile stuff/icons -n gwcicons -o fonts"
  end

  desc "compiles compass scss files and sprites"
  task :css do
    sh "compass compile"
  end

  desc "minifies vendor javascript libs"
  require 'rake/minify'
  Rake::Minify.new(:js) do
    dir("stuff/js/") do
      group("js/extra.min.js") do
        add("resize-stop/jquery.resizeStop.js")
        add("plax/js/plax.js")
        add("sly/dist/sly.js")
        add("espy/dist/jquery.espy.min.js")
      end
    end
  end

end

desc "compiles all"
task :build do
  Rake::Task['build:fonts'].invoke
  Rake::Task['build:js'].invoke
  Rake::Task['build:css'].invoke
end
