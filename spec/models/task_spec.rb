require 'spec_helper'

require 'models/task'


describe Task do

  describe '#completed?' do
    context 'when status == completed' do
      it "is true" do
        subject.status = Task::COMPLETED_STATUS

        subject.should be_completed
      end
    end

    context 'when status != completed' do
      it "is false" do
        subject.status = nil

        subject.should_not be_completed
      end
    end
  end

  describe '#pending?' do
    context 'when status == pending' do
      it "is true" do
        subject.status = Task::PENDING_STATUS

        subject.should be_pending
      end
    end

    context 'when status != pending' do
      it "is false" do
        subject.status = nil

        subject.should_not be_pending
      end
    end
  end

  describe '#rejected?' do
    context 'when status == rejected' do
      it "is true" do
        subject.status = Task::REJECTED_STATUS

        subject.should be_rejected
      end
    end

    context 'when status != rejected' do
      it "is false" do
        subject.status = nil

        subject.should_not be_rejected
      end
    end
  end
end
