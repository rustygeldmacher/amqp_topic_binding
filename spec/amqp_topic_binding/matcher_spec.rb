require 'spec_helper'

describe AmqpTopicBinding::Matcher do
  describe 'matches?' do
    context 'pattern without wild cards' do
      subject { AmqpTopicBinding::Matcher.new('foo.bar.baz') }
      it { is_expected.to match_routing_key('foo.bar.baz') }
      it { is_expected.not_to match_routing_key('foo.bar') }
      it { is_expected.not_to match_routing_key('foo') }
    end

    context 'pattern with one asterisk' do
      subject { AmqpTopicBinding::Matcher.new('foo.*.baz') }
      it { is_expected.to match_routing_key('foo.bar.baz') }
      it { is_expected.not_to match_routing_key('foo.bar.baz.qux') }
    end

    context 'pattern is just one asterisk' do
      subject { AmqpTopicBinding::Matcher.new('*') }
      it { is_expected.to match_routing_key('foo') }
      it { is_expected.not_to match_routing_key('foo.bar') }
    end

    context 'pattern with multiple asterisks' do
      subject { AmqpTopicBinding::Matcher.new('*.bar.*') }
      it { is_expected.to match_routing_key('foo.bar.baz') }
      it { is_expected.not_to match_routing_key('foo.barge.baz') }
      it { is_expected.not_to match_routing_key('foo.bar.baz.qux') }
      it { is_expected.not_to match_routing_key('qux.foo.bar.baz') }
    end

    context 'pattern with a hash' do
      subject { AmqpTopicBinding::Matcher.new('foo.bar.#') }
      it { is_expected.to match_routing_key('foo.bar.baz') }
      it { is_expected.to match_routing_key('foo.bar.baz.qux') }
      it { is_expected.not_to match_routing_key('foo.bar') }
      it { is_expected.not_to match_routing_key('foo') }
    end

    context 'pattern is just one hash' do
      subject { AmqpTopicBinding::Matcher.new('#') }
      it { is_expected.to match_routing_key('foo') }
      it { is_expected.to match_routing_key('foo.bar') }
      it { is_expected.to match_routing_key('foo.bar.baz.qux') }
    end

    context 'routing key is empty' do
      subject { AmqpTopicBinding::Matcher.new('*') }
      it { is_expected.not_to match_routing_key(nil) }
      it { is_expected.not_to match_routing_key('') }
    end
  end

  matcher :match_routing_key do |routing_key|
    match { |binding_matcher| binding_matcher.matches?(routing_key) }
  end
end
