FactoryGirl.define do
  factory :user do
    id       "1"
    email    "lehet@fo.com"
    password "Tikos655"
    password_confirmation "Tikos655"
  end

  factory :project do
    name        "Első projektem"
    description "8200 Veszprém, Kisvirág u. 26. - felújítási munkák"
    user_id     "1"
  end

  factory :item do
    name        "38-as N+F tégla"
    unit_id     "1"
  end

  factory :unit do
    name        "klts"
  end

  factory :plan do
    id          "1"
    item_id     "1"
    project_id  "1"
    quantity    "5.67"
  end
end