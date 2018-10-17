module Private
  module Deposits
    class ZenbitexController < ::Private::Deposits::BaseController
      include ::Deposits::CtrlCoinable
    end
  end
end
