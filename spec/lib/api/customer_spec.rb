require 'spec_helper'

describe FoxySync::Api::Customer do
  include_examples 'api_setup'
  include_examples 'base'


  let :user do
    u = double 'User'
    u.stub(:email).and_return 'user@example.com'
    u.stub(:encrypted_password).and_return '284c4782241751bb87a371b1130b3e5c81e12921'
    u.stub(:password_salt).and_return 'b33ebc79782c8251383f0e2f885aba6679ab9237'
    u
  end

  let(:subject) { described_class.new user }


  it 'should assign the user' do
    subject.user.should == user
  end

  it 'should tell the API to save the customer' do
    salt = user.password_salt
    hash = OpenSSL::HMAC.hexdigest 'sha256', salt, user.encrypted_password + salt
    params = {
      :customer_email => user.email,
      :customer_password_hash => hash,
      :customer_password_salt => salt
    }

    FoxySync::Api::Messenger.any_instance.should_receive(:customer_save).with(params)
    reply = subject.save
    # reply.should be_a FoxySync::Api::Response # why won't this work?!
  end

end