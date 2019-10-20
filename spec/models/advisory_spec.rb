# frozen_string_literal: true

require 'rails_helper'

describe Advisory do
  describe 'validations' do
    it { should validate_presence_of(:identifier) }
    it { should validate_presence_of(:identifier) }
  end
end
