class Region < ApplicationRecord
    include ActiveModel::Validations

    class CountryCodeValidator < ActiveModel::EachValidator
        def validate_each(record, attribute, value)
            # `value` should be an alpha2 country code
            country = ISO3166::Country.new(value)
            # Double check for country not being nil, and also being a valid country code
            record.errors.add attribute, "must be valid alpha 2 country code" unless country.present? and country.valid?
        end
    end

    validates :name, presence: true
    validates :country_code, presence: true, length: { is: 2 }, country_code: true
    before_save :downcase_country_code

    def country
      ISO3166::Country.new(country_code)
    end

    private
        def downcase_country_code
            self.country_code = self.country_code.downcase
        end
end
