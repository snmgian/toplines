require 'spec_helper'

require 'models/task'

describe Task do

  describe '#pending?' do

    context 'when status == pending' do
      it "is true" do
        subject.status = Task::PENDING_STATUS

        subject.should be_pending
      end
    end

    context 'when status != pending' do
      it "is false" do
        subject.status = 1

        subject.should_not be_pending
      end
    end

  end
end
