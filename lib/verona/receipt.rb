require 'time'

module Verona
  class Receipt
    # The package name for the application
    attr_reader :package_name

    # The product identifier of the item that was purchased.
    attr_reader :product_id

    # The receipt's token
    attr_reader :token

    # The date and time this transaction occurred.
    attr_reader :purchase_date

    # The state of the purchase
    attr_reader :purchase_state

    # The consumption state of the purchase
    attr_reader :consumed

    # Developer payload
    attr_reader :developer_payload

    def initialize(attributes = {})
      @package_name = attributes[:package_name] if attributes[:package_name]
      @product_id = attributes[:product_id] if attributes[:product_id]
      @token = attributes[:token] if attributes[:token]
      @purchase_date = Time.at(attributes['purchaseTime'].to_i / 1000) if attributes['purchaseTime']
      @purchase_state = Integer(attributes['purchaseState']) if attributes['purchaseState']
      @consumed = Integer(attributes['consumptionState']) if attributes['consumptionState']
      @developer_payload = attributes['developerPayload'] if attributes['developerPayload']
    end

    def to_h
      {
        :package_name => @package_name,
        :product_id => @product_id,
        :purchase_date => @purchase_date.httpdate,
        :purchase_state => @purchase_state,
        :consumed => @consumed,
        :developer_payload => (@developer_payload rescue nil)
      }
    end

    def to_json
      self.to_h.to_json
    end

    class << self
      def verify(data, options = {})
        return verify!(data, options) rescue false
      end

      def verify!(data, options = {})
        client = Client.new
        client.verify!(data, options) rescue false
      end

      alias :validate :verify
      alias :validate! :verify!
    end
  end
end