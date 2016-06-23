=begin
SimplyRETS API

The SimplyRETS API is an exciting step towards making it easier for developers and real estate agents to build something awesome with real estate data!  The documentation below makes live requests to our API using the trial data. To get set up with the API using live MLS data, you must have RETS credentials from your MLS, which you can then use to create an app with SimplyRETS. For more information on that process, please see our [FAQ](https://simplyrets.com/faq), [Getting Started](https://simplyrets.com/blog/getting-set-up.html) page, or [contact us](https://simplyrets.com/\\#home-contact).  Below you'll find the API endpoints, query parameters, response bodies, and other information about using the SimplyRETS API. You can run queries by clicking the 'Try it Out' button at the bottom of each section.  ### Authentication The SimplyRETS API uses Basic Authentication. When you create an app, you'll get a set of API credentials to access your listings. If you're trying out the test data, you can use `simplyrets:simplyrets` for connecting to the API.  ### Media Types The SimplyRETS API uses the `Accept` header to allow clients to control media types (content versions). We maintain backwards compatibility with API clients by allowing them to specify a content version. We highly recommend setting and explicity media type when your application reaches production. Both the structure and content of our API response bodies is subject to change so we can add new features while respecting the stability of applications which have already been developed.  To always use the latest SimplyRETS content version, simply use `application/json` in your application `Accept` header.  If you want to pin your clients media type to a specific version, you can use the vendor-specific SimplyRETS media type, e.g. `application/vnd.simplyrets-v0.1+json\"`  To view all valid content-types for making an `OPTIONS`, make a request to the SimplyRETS api root  `curl -XOPTIONS -u simplyrets:simplyrets https://api.simplyrets.com/`  The default media types used in our API responses may change in the future. If you're building an application and care about the stability of the API, be sure to request a specific media type in the Accept header as shown in the examples below.  The wordpress plugin automatically sets the `Accept` header for the compatible SimplyRETS media types.  ### Pagination There a few pieces of useful information about each request stored in the HTTP Headers:  - `X-Total-Count` shows you the total amount of listings that match   your current query. - `Link` contains pre-built pagination links for accessing the next 'page' of listings that match your query. Read more about that [here](https://simplyrets.com/blog/api-pagination.html).

OpenAPI spec version: 1.0.0

Generated by: https://github.com/swagger-api/swagger-codegen.git

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

=end

require 'date'

module SimplyRetsClient
  # RETS MLS Office
  class Office
    # Associated contact details for the office. The availability of this information depends on your MLS rules and regulations  *Contact information is not available for all RETS Vendors.*
    attr_accessor :contact

    # Pimary office name
    attr_accessor :name

    # Primary office or brokerage name
    attr_accessor :serving_name

    # Office or brokerage MLS identifier  **Not available for all RETS vendors**
    attr_accessor :brokerid


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'contact' => :'contact',
        :'name' => :'name',
        :'serving_name' => :'servingName',
        :'brokerid' => :'brokerid'
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        :'contact' => :'ContactInformation',
        :'name' => :'String',
        :'serving_name' => :'String',
        :'brokerid' => :'String'
      }
    end

    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}){|(k,v), h| h[k.to_sym] = v}

      if attributes.has_key?(:'contact')
        self.contact = attributes[:'contact']
      end

      if attributes.has_key?(:'name')
        self.name = attributes[:'name']
      end

      if attributes.has_key?(:'servingName')
        self.serving_name = attributes[:'servingName']
      end

      if attributes.has_key?(:'brokerid')
        self.brokerid = attributes[:'brokerid']
      end

    end

    # Show invalid properties with the reasons. Usually used together with valid?
    # @return Array for valid properies with the reasons
    def list_invalid_properties
      invalid_properties = Array.new
      return invalid_properties
    end

    # Check to see if the all the properties in the model are valid
    # @return true if the model is valid
    def valid?
      return true
    end

    # Checks equality by comparing each attribute.
    # @param [Object] Object to be compared
    def ==(o)
      return true if self.equal?(o)
      self.class == o.class &&
          contact == o.contact &&
          name == o.name &&
          serving_name == o.serving_name &&
          brokerid == o.brokerid
    end

    # @see the `==` method
    # @param [Object] Object to be compared
    def eql?(o)
      self == o
    end

    # Calculates hash code according to all attributes.
    # @return [Fixnum] Hash code
    def hash
      [contact, name, serving_name, brokerid].hash
    end

    # Builds the object from hash
    # @param [Hash] attributes Model attributes in the form of hash
    # @return [Object] Returns the model itself
    def build_from_hash(attributes)
      return nil unless attributes.is_a?(Hash)
      self.class.swagger_types.each_pair do |key, type|
        if type =~ /^Array<(.*)>/i
          # check to ensure the input is an array given that the the attribute
          # is documented as an array but the input is not
          if attributes[self.class.attribute_map[key]].is_a?(Array)
            self.send("#{key}=", attributes[self.class.attribute_map[key]].map{ |v| _deserialize($1, v) } )
          end
        elsif !attributes[self.class.attribute_map[key]].nil?
          self.send("#{key}=", _deserialize(type, attributes[self.class.attribute_map[key]]))
        end # or else data not found in attributes(hash), not an issue as the data can be optional
      end

      self
    end

    # Deserializes the data based on type
    # @param string type Data type
    # @param string value Value to be deserialized
    # @return [Object] Deserialized data
    def _deserialize(type, value)
      case type.to_sym
      when :DateTime
        DateTime.parse(value)
      when :Date
        Date.parse(value)
      when :String
        value.to_s
      when :Integer
        value.to_i
      when :Float
        value.to_f
      when :BOOLEAN
        if value.to_s =~ /^(true|t|yes|y|1)$/i
          true
        else
          false
        end
      when :Object
        # generic object (usually a Hash), return directly
        value
      when /\AArray<(?<inner_type>.+)>\z/
        inner_type = Regexp.last_match[:inner_type]
        value.map { |v| _deserialize(inner_type, v) }
      when /\AHash<(?<k_type>.+), (?<v_type>.+)>\z/
        k_type = Regexp.last_match[:k_type]
        v_type = Regexp.last_match[:v_type]
        {}.tap do |hash|
          value.each do |k, v|
            hash[_deserialize(k_type, k)] = _deserialize(v_type, v)
          end
        end
      else # model
        temp_model = SimplyRetsClient.const_get(type).new
        temp_model.build_from_hash(value)
      end
    end

    # Returns the string representation of the object
    # @return [String] String presentation of the object
    def to_s
      to_hash.to_s
    end

    # to_body is an alias to to_hash (backward compatibility)
    # @return [Hash] Returns the object in the form of hash
    def to_body
      to_hash
    end

    # Returns the object in the form of hash
    # @return [Hash] Returns the object in the form of hash
    def to_hash
      hash = {}
      self.class.attribute_map.each_pair do |attr, param|
        value = self.send(attr)
        next if value.nil?
        hash[param] = _to_hash(value)
      end
      hash
    end

    # Outputs non-array value in the form of hash
    # For object, use to_hash. Otherwise, just return the value
    # @param [Object] value Any valid value
    # @return [Hash] Returns the value in the form of hash
    def _to_hash(value)
      if value.is_a?(Array)
        value.compact.map{ |v| _to_hash(v) }
      elsif value.is_a?(Hash)
        {}.tap do |hash|
          value.each { |k, v| hash[k] = _to_hash(v) }
        end
      elsif value.respond_to? :to_hash
        value.to_hash
      else
        value
      end
    end

  end

end
