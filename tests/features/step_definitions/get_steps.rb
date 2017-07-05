#encoding: utf-8

Quando(/^faço uma consulta$/) do
   @result =  HTTParty.get('https://ninjarest.herokuapp.com/users')
end

Então(/^o código de resposta deve ser "([^"]*)"$/) do |status_code| 
   expect(@result.response.code).to eql status_code
end

Então(/^o sistema retorna uma lista de usuários cadastrados$/) do
  res = @result.parsed_response
  expect(res).not_to be_empty

  res.each do |u|
   #   puts u['email'].class
     expect(u).to have_key('id')
     expect(u).to have_key('name')
     expect(u).to have_key('email')
     expect(u).to have_key('password')
  end    
end

Dado(/^que eu tenho um usuário cadastrado$/) do
  list  = HTTParty.get('https://ninjarest.herokuapp.com/users')
  @user = list.parsed_response.sample
  @user_id = @user['id']
end

Quando(/^faço a consulta desse usuário$/) do
  @result = HTTParty.get("https://ninjarest.herokuapp.com/users/#{@user_id}")
end

Quando(/^faço a consulta desse usuário por email$/) do
    @result = HTTParty.get(
    'https://ninjarest.herokuapp.com/users',
    query: { email: @user['email'] }
  )
end

Então(/^o sistema retorna os dados desse usuário$/) do
  #puts @user
  #puts @result.parsed_response.first
  expect(@result.parsed_response.first).to eql @user
end  

Dado(/^que o usuário não esta cadastrado$/) do
  @user_id = Faker::Crypto.md5
end

Então(/^vejo a mensagem "([^"]*)"$/) do |msg|
  expect(@result.parsed_response['message']).to eql msg
end


