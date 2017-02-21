module JobHelpers
  def disable_jobs(*_jobs)
    if _jobs.empty?
      # TODO: jobs = all_jobs?
    end

    before do
      _jobs.each { |j| allow_any_instance_of(j).to receive(:perform) }
    end
  end
end

RSpec.configure do |config|
  config.extend JobHelpers
end
