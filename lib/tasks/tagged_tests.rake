require 'rake'

namespace :coulda do
  desc "Execute tagged tests only" 
  task :tagged_tests, :tag do |task, tag|
    ARGV << "tags=#{tag["tag"]}"

    $LOAD_PATH.unshift("test")

    require 'test/unit'

    test_files = Dir.glob(File.join('test', '**', '*_test.rb'))
    test_files.each do |file|
      require file
    end
  end
end
