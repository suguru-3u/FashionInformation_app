FactoryBot.define do
  factory :post do
    title { 'test' }
    post_body { 'test@gamil.com' }
    post_image_id { '' }
    solution { false }
  end
end
