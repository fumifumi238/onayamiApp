require 'rails_helper'

RSpec.describe Micropost, type: :model do


   it "does not allow inappropriate words" do
     user = User.create(
       name:  "Tester",
       email:      "joetester@example.com",
       password:   "dottle-nouveau-pavilion-tights-furze",
     )

     new_micropost = user.microposts.build(
       content: "これは不適切な言葉のテストです",
     )

     new_micropost.valid?
     expect(new_micropost.errors[:contain_blacklist_words]).to include(": 不適切な言葉が含まれています。")
   end

end
