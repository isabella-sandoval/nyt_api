require 'rails_helper'

RSpec.describe Search, type: :model do
  subject { Search.new(title: "Becoming", author: "Michelle Obama")}
  before { subject.save }


  describe 'title' do
    it 'must be present' do
      subject.title = nil
      expect(subject).to_not be_valid
    end 
  end

  describe 'author' do
    it 'must be present' do
      subject.author = nil
      expect(subject).to_not be_valid
    end 
  end

end
