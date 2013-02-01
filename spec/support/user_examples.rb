shared_examples 'user' do

  let :user do
    u = double 'User'
    u.stub(:email).and_return 'user@example.com'
    u.stub(:encrypted_password).and_return '284c4782241751bb87a371b1130b3e5c81e12921'
    u.stub(:password_salt).and_return 'b33ebc79782c8251383f0e2f885aba6679ab9237'
    u
  end

end