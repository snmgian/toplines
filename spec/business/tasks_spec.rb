require 'spec_helper'

require 'business/tasks'


describe Business::Tasks do

  describe '.create' do
    let(:user) { Models::User.create }
    let(:description) { 'task description' }
    let(:points) { 5 }

    it "creates a task" do
      expect {
        subject.create(description, points, user)
      }.to change{Models::Task.count}.by(1)
    end

    it "returns the created task" do
      task = subject.create(description, points, user)

      task.should be_a(Models::Task)
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

  describe '.complete' do
    it "completes the task" do
      task = Models::Task.create

      subject.complete(task)

      task.should be_completed
    end
  end

  describe '.down' do
    let(:task) { Models::Task.create(:points => 5) }
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

  describe '.get' do
    let(:task) { Models::Task.create }

    it "returns the task" do
      returned = subject.get(task.id)

      task.should == returned
    end

    it "raises TaskNotFoundError when there is no task" do
      expect {
        subject.get(0)
      }.should raise_error(Business::TaskNotFoundError)
    end
  end

  describe '.reject' do
    it "rejects the task" do
      task = Models::Task.create

      subject.reject(task)

      task.should be_rejected
    end
  end

  describe '.top' do

    let(:t2) { Models::Task.create(:points => 2) }
    let(:t5) { Models::Task.new(:points => 5) }
    let(:t8) { Models::Task.create(:points => 8) }

    describe 'ordering' do
      before do
        t5.save
        t8.save
        t2.save
      end

      it "returns the top tasks ordered by points" do
        top = subject.top

        top.should == [t8, t5, t2]
      end
    end

    describe 'limiting' do
      context 'when less than 10 tasks' do
        let(:tasks_count) { 4 }
        before do
          tasks_count.times do
            Models::Task.create
          end
        end

        it "should return all the tasks" do
          top = subject.top

          top.should have(tasks_count).items
        end
      end

      context 'when more than 10 tasks' do
        let(:tasks_count) { 14 }
        before do
          tasks_count.times do
            Models::Task.create
          end
        end

        it "should return all the tasks" do
          top = subject.top

          top.should have(10).items
        end
      end
    end
  end

  describe '.up' do
    let(:task) { Models::Task.create(:points => 5) }
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
end
