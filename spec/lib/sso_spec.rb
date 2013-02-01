require 'spec_helper'

describe FoxySync::Sso do

  let :sso do
    mock = double 'sso'
    mock.class.send :include, FoxySync::Sso
    mock
  end

end