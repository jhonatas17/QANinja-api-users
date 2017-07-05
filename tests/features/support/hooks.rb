

Before('@new_user') do

   name = Faker::Superhero.name
       @request = {
       name: name,
       email: Faker::Internet.free_email(name),
       password: '123#casa'
     } 
    

   HTTParty.post(
      'https://ninjarest.herokuapp.com/users',
      :body=> @request.to_json,
      :headers=> {'Content-Type' => 'application/json'}
  )

   result = HTTParty.get(
      'https://ninjarest.herokuapp.com/users',
       query: { email: @request[:email] }
  )

     @user = result.parsed_response.first
    @user_id = @user['id']

end   