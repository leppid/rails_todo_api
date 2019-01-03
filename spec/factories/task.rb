FactoryBot.define do
  factory :task do
    title { "Task1" }
    description { "this task need to do" }
    priority { "2" }
    duedate { "29/12/18" }
    done { false }
    user_id { 1 }
  end
end
