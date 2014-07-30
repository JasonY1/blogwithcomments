FactoryGirl.define do
  factory :user do   #let(:user) { FactoryGirl.create(:user) }
    name      "Example User"
    email     "user@example.com"
    password  "foofoo"
    password_confirmation "foofoo"
  end
end