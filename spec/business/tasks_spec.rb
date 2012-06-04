require 'spec_helper'

require 'business/tasks'


describe Toplines::Business::Tasks do

  subject { Toplines::Business::Tasks }

  describe '#create' do
    let(:user) { User.create }
    let(:description) { 'task description' }
    let(:points) { 5 }

    it "creates a task" do
      expect {
        subject.create(description, points, user)
      }.to change{Task.count}.by(1)
    end

    it "returns the created task" do
      task = subject.create(description, points, user)

      task.should be_a(Task)
      task.id.should be
    end

    it "creates a pending task" do
      task = subject.create(description, points, user)

      task.should be_pending
    end

    it "assings the info to the task" do

      task = subject.create(description, points, user)

      task.user.should be(user)
      task.description.should be(description)
      task.points.should be(points)
    end
  end

  describe '#reject' do
    let(:user) { User.create }

    it "rejects the task" do
      task = Task.create(:user => user)

      subject.reject(task)

      task.should be_rejected
    end
  end

  describe '#complete' do
    let(:user) { User.create }

    it "completes the task" do
      task = Task.create(:user => user)

      subject.complete(task)

      task.should be_completed
    end
  end
end
