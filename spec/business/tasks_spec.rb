require 'spec_helper'

require 'business/tasks'


describe Toplines::Business::Tasks do

  subject { Toplines::Business::Tasks }

  describe '#create' do
    let(:user) { User.create }

    it "creates a task" do
      expect {
        subject.create(user)
      }.to change{Task.count}.by(1)
    end

    it "returns the created task" do
      task = subject.create(user)

      task.should be_a(Task)
      task.id.should be
    end

    it "creates a pending task" do
      task = subject.create(user)

      task.should be_pending
    end
  end
end
