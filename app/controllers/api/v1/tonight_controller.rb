module Api
  module V1
    class TonightController < ApplicationController

      def show
        @tonight = Tonight.find
      end

    end
  end
end
