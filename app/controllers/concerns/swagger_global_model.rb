class SwaggerGlobalModel  # Notice, this is just a plain ruby object.
  include Swagger::Blocks

  swagger_schema :common_response_model do
    key :required, [:response_code, :response_message]
    property :response_code do
      key :type, :integer
      key :format, :int32
    end
    property :response_message do
      key :type, :string
    end
  end

end
