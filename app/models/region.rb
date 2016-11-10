class Region < ApplicationRecord
    include ActiveModel::Validations

    class CountryCodeValidator < ActiveModel::EachValidator
        def validate_each(record, attribute, value)
            # `value` should be an alpha2 country code
            country = ISO3166::Country.new(value)
            record.errors.add attribute, "must be valid alpha 2 country code" unless country.valid?
        end
    end

    validates :name, presence: true
    validates :country_code, presence: true, length: { is: 2 }, country_code: true
end
