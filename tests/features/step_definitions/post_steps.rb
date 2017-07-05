#encoding: utf-8

Dado(/^que eu tenho um novo usuário$/) do
  name = Faker::Superhero.name
  @request = {
      name: name,
      email: Faker::Internet.free_email(name),
      password: '123#casa'
    } 
  @request = JSON.parse(@request.to_json) ## Parse de JSON PARA Hash do Ruby para usar as chaves como string
end

Dado(/^esse usuário ja está cadastrado$/) do
 @result = HTTParty.post(
      'https://ninjarest.herokuapp.com/users',
      :body=> @request.to_json,
      :headers=> {'Content-Type' => 'application/json'}
  )
end

Dado(/^esse usuário não possui "([^"]*)"$/) do |key|
    @request.delete(key)  
end

Quando(/^faço o cadastro$/) do
  @result = HTTParty.post(
      'https://ninjarest.herokuapp.com/users',
      :body=> @request.to_json,
      :headers=> {'Content-Type' => 'application/json'}
  )
end

Então(/^vejo este usuário cadastro no sistema$/) do
  result = HTTParty.get(
      'https://ninjarest.herokuapp.com/users',
      query: { email: @request['email'] }
  )

  expect(result.parsed_response.first['id'].size).to eql 24
# expect(result.parsed_response.first['id']).not_to be_empty
  expect(result.parsed_response.first['name']).to eql @request['name']
  expect(result.parsed_response.first['email']).to eql @request['email']
  expect(result.parsed_response.first['password']).to eql @request['password']


end