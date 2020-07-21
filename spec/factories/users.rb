FactoryBot.define do
  factory :user do
  end

  factory :user_tanaka, class: 'User' do
    name { '田中　太郎' }
    email { 'taro.tanaka@example.com' }
    self_introduction { 'こんにちは' }
    password { 'password' }
    img_name { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/example.jpg')) }
  end

  factory :user_yamada, class: 'User' do
    name { '山田 花子' }
    email { 'hanako.yamada@example.com' }
    self_introduction { 'こんにちは' }
    password { 'password' }
    img_name { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/example.jpg')) }
  end
end
