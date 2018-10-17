module Private::Withdraws
  class ZenbitexController < ::Private::Withdraws::BaseController
    include ::Withdraws::Withdrawable
  end
end
