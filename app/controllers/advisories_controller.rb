# typed: true
# frozen_string_literal: true

class AdvisoriesController < ApplicationController
  def index
    @advisories = Advisory.order(updated_at: :desc).limit(20)

    render :index
  end
end
