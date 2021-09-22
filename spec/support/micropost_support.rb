module MicropostSupport
 def create_micropost(micropost)
    visit new_micropost_path
 end
end

 RSpec.configure do |config|
 config.include MicropostSupport
 end
