module DuePayments

  module Core
    def self.silence_stream(*streams)
      on_hold = streams.collect{ |stream| stream.dup }
      streams.each do |stream|
        stream.reopen(RUBY_PLATFORM =~ /mswin/ ? 'NUL:' : '/dev/null')
        stream.sync = true
      end
      yield
    ensure
      streams.each_with_index do |stream, i|
        stream.reopen(on_hold[i])
      end
    end

    def self.silence_stdout
      silence_stream(STDOUT) { yield }
    end
  end

end