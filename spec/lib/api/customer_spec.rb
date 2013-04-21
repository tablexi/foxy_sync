require 'spec_helper'

describe FoxySync::Api::Customer do
  include_examples 'api setup'
  include_examples 'api base'
  include_examples 'user'


  subject { described_class.new user }


  it 'should assign the user' do
    expect(subject.user).to eq user
  end

  it 'should tell the API to save the customer' do
    params = {
      :customer_email => user.email,
      :customer_password_hash => user.encrypted_password,
      :customer_password_salt => user.password_salt
    }

    FoxySync::Api::Messenger.any_instance.should_receive(:customer_save).with(params)
    subject.save
  end


  describe 'determining if FoxyCart knows the user' do
    it 'should say the user was found' do
      expect(subject.found?).to be_true
    end

    it 'should say the user was not found' do
      subject.api_response.node.at_xpath('.//message').content = 'customer not found'
      expect(subject.found?).to be_false
    end
  end

end