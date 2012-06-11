require 'spec_helper'

require 'business/tasks'


describe Toplines::Business::Tasks do

  subject { Toplines::Business::Tasks }

  describe '.create' do
    let(:user) { Toplines::Models::User.create }
    let(:description) { 'task description' }
    let(:points) { 5 }

    it "creates a task" do
      expect {
        subject.create(description, points, user)
      }.to change{Toplines::Models::Task.count}.by(1)
    end

    it "returns the created task" do
      task = subject.create(description, points, user)

      task.should be_a(Toplines::Models::Task)
      task.id.should be
    end

    it "creates a pending task" do
      task = subject.create(description, points, user)

      task.should be_pending
    end

    it "assings the info to the task" do

      task = subject.create(description, points, user)

      task.user.should == user
      task.description.should == description
      task.points.should == points
    end
  end

  describe '.reject' do
    it "rejects the task" do
      task = Toplines::Models::Task.create

      subject.reject(task)

      task.should be_rejected
    end
  end

  describe '.complete' do
    it "completes the task" do
      task = Toplines::Models::Task.create

      subject.complete(task)

      task.should be_completed
    end
  end

  describe '.down' do
    let(:task) { Toplines::Models::Task.create(:points => 5) }
    it "decrements task's points by 1" do
      expect {
        subject.down(task)
      }.to change{task.points}.by(-1)
    end

    context 'with points' do
      it "decrements task's points by the given ones" do
        points = 4
        expect {
          subject.down(task, points)
        }.to change{task.points}.by(0 - points)
      end
    end
  end

  describe '.up' do
    let(:task) { Toplines::Models::Task.create(:points => 5) }
    it "increments task's points by 1" do
      expect {
        subject.up(task)
      }.to change{task.points}.by(1)
    end

    context 'with points' do
      it "increments task's points by the given ones" do
        points = 4
        expect {
          subject.up(task, points)
        }.to change{task.points}.by(points)
      end
    end
  end

  describe '.get' do
    let(:task) { Toplines::Models::Task.create }

    it "returns the task" do
      returned = subject.get(task.id)

      task.should == returned
    end

    it "raises TaskNotFoundError when there is no task" do
      expect {
        subject.get(0)
      }.should raise_error(Toplines::Business::TaskNotFoundError)
    end
  end
end
