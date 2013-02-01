require 'spec_helper'

describe FoxySync::Sso do
  include_examples 'api_setup'
  include_examples 'user'


  let :sso do
    mock = double 'sso'
    mock.class.send :include, FoxySync::Sso
    mock
  end

  let :params do
    { 'fcsid' => 'abc123', 'timestamp' => Time.now.to_i.to_s }
  end


  it 'should give the correct URL when no user is given' do
    url = sso.sso_url params
    url.should match fc_sso_url
  end

  it 'should give the correct URL when a user is given' do
    cid = 3
    FoxySync::Api::Customer.any_instance.stub(:customer_id).and_return cid
    url = sso.sso_url params, user
    url.should match fc_sso_url cid
  end


  def fc_sso_url(cid = 0)
    /#{FoxySync.store_url}\/checkout\?fc_auth_token=[0-9a-z]+&fcsid=#{params['fcsid']}&fc_customer_id=#{cid}&timestamp=\d+/
  end

end