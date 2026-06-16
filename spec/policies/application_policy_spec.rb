require 'rails_helper'

RSpec.describe ApplicationPolicy, type: :policy do
  subject { described_class.new(user, record) }

  let(:user) { create(:user) }
  let(:record) { double('record') }

  describe 'default policy actions' do
    it 'denies index by default' do
      expect(subject.index?).to be false
    end

    it 'denies show by default' do
      expect(subject.show?).to be false
    end

    it 'denies create by default' do
      expect(subject.create?).to be false
    end

    it 'denies new by default' do
      expect(subject.new?).to be false
    end

    it 'denies update by default' do
      expect(subject.update?).to be false
    end

    it 'denies edit by default' do
      expect(subject.edit?).to be false
    end

    it 'denies destroy by default' do
      expect(subject.destroy?).to be false
    end
  end

  describe 'Scope' do
    it 'raises an error if resolve is not defined in a subclass' do
      scope = ApplicationPolicy::Scope.new(user, User.all)
      expect { scope.resolve }.to raise_error(NoMethodError)
    end
  end
end
