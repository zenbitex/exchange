module Admin
  module Withdraws
    class ZenbitexController < ::Admin::Withdraws::BaseController
      load_and_authorize_resource :class => '::Withdraws::Zenbitex'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24 * 3)
        @one_zenbitex = @zenbitex.with_aasm_state(:almost_done).order("id DESC")
        @all_zenbitex = @zenbitex.without_aasm_state(:almost_done).where('created_at > ?', start_at).order("id DESC")
      end

      def show
      end

      def update
        @zenbitex.process!
        redirect_to :back, notice: t('.notice')
      end

      def destroy
        @zenbitex.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
