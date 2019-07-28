# frozen_string_literal: true

FactoryBot.define do
  skip_create

  factory :location, class: BaseSource::Location do
    start_node do
      %w[alpha beta gamma delta theta lambda tau psi omega].sample
    end
    end_node do
      %w[alpha beta gamma delta theta lambda tau psi omega].sample
    end
    start_time do
      FFaker::Time.datetime.to_time.utc.strftime('%Y-%m-%dT%H:%M:%S').to_s
    end
    end_time do
      FFaker::Time.datetime.to_time.utc.strftime('%Y-%m-%dT%H:%M:%S').to_s
    end
  end
end
