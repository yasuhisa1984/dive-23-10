# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'json'
require 'uri'
require 'net/http'

num_of_data = 5

questions = []
url = "https://api.stackexchange.com/2.2/questions?page=1&pagesize=#{num_of_data}&order=desc&sort=hot&site=ja.stackoverflow&filter=!-*f(6rc.(Xr5"
uri = URI.parse(url)
json = Net::HTTP.get(uri)
response = JSON.parse(json)
response['items'].each do |item|
  questions << { title: item['title'], content: item['body'], answers: item['answers'] }
end

#dummy user
email = ENV['SEED_USER_EMAIL']
name = Faker::LordOfTheRings.character
profile = Faker::Job.field
password = ENV['SEED_USER_PASSWORD']
#メール認証を使う場合、以下も必要
uid = SecureRandom.uuid
user = User.create!(
  email: email,
  name: name,
  profile: profile,
  #メール認証を使う場合、以下も必要
  uid: uid,
  confirmed_at: DateTime.now,
  password: password,
  password_confirmation: password,
)

questions.each do |question|
    title = question[:title]
    content = question[:content].gsub(/<pre><code>/, "\n```\n").gsub("</code></pre>", "```\n").gsub("\&lt;","<").gsub("\&gt;",">")
    user_id = user.id
    question_in_db = Question.create!(
        title: title,
        content: content,
        user_id: user_id,
    )
    unless question[:answers] == nil
      question[:answers].each do |answer|
        content = answer['body']
        user_id = user.id
        question_id = question_in_db.id
        Answer.create!(
          content: content,
          user_id: user_id,
          question_id: question_id,
        )
      end
    end
end
