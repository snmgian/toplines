require 'business/tasks'


describe Toplines::Business::Tasks do

  subject { Toplines::Business::Tasks }

  describe "#create" do
    it "should create a task" do
      subject.create.should be_true
    end
  end
end
