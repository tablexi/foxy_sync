require 'spec_helper'

describe FoxySync::Datafeed do

  let :datafeed do
    mock = double 'datafeed'
    mock.class.send :include, FoxySync::Datafeed
    mock
  end

end