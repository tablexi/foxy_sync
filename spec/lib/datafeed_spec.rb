require 'spec_helper'

describe FoxySync::Datafeed do

  let(:datafeed) do
    mock = double('datafeed')
    mock.class.send :include, FoxySync::datafeed
    mock
  end

end