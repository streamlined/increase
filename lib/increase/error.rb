module Increase
  class Error < StandardError
    ClientError           = Class.new(self)
    ServerError           = Class.new(self)

    BadRequest            = Class.new(ClientError)
    Unauthorized          = Class.new(ClientError)
    Forbidden             = Class.new(ClientError)
    Conflict              = Class.new(ClientError)
    RequestEntityTooLarge = Class.new(ClientError)
    NotFound              = Class.new(ClientError)
    NotAcceptable         = Class.new(ClientError)
    UnprocessableEntity   = Class.new(ClientError)
    TooManyRequests       = Class.new(ClientError)

    InternalServerError   = Class.new(ServerError)
    BadGateway            = Class.new(ServerError)
    ServiceUnavailable    = Class.new(ServerError)
    GatewayTimeout        = Class.new(ServerError)

    attr_reader :status
    attr_reader :detail
    attr_reader :type
    attr_reader :title

    def initialize(
      status: 500,
      detail: "Something went wrong with communication with Increase API.",
      type: "API error",
      title: "Something went wrong with communication with Increase API."
    )
      super
      @status = status
      @detail = detail
      @type = type
      @title = title
    end

    def self.from_response(status, body, _headers)
      parsed_error = parse_error(body)
      status = parsed_error.dig(:status)
      detail = parsed_error.dig(:detail)
      type = parsed_error.dig(:type)
      title = parsed_error.dig(:title)
      error = error_class(status)&.new(
        status: status,
        detail: detail,
        type: type,
        title: title
      )
      error ||= ClientError.new(
        status: status,
        detail: detail,
        type: type,
        title: title
      )
      error
    end

    def self.parse_error(body)
      {
        detail: body.dig("detail"),
        status: body.dig("status"),
        title: body.dig("title"),
        type: body.dig("type")
      }
    end

    def self.error_class(status)
      ERRORS[status]
    end
  end

  ERRORS = {
    400 => Error::BadRequest, # invalid_parameters_error, malformed_request_error
    401 => Error::Unauthorized, # invalid_api_key_error
    403 => Error::Forbidden, # private_feature_error, insufficient_permissions_error, environment_mismatch_error
    404 => Error::NotFound, # object_not_found_error, api_method_not_found_error
    406 => Error::NotAcceptable,
    409 => Error::Conflict, # invalid_operation_error, idempotency_conflict_error
    413 => Error::RequestEntityTooLarge,
    422 => Error::UnprocessableEntity, # idempotency_unprocessable_error
    429 => Error::TooManyRequests, # rate_limited_error
    500 => Error::InternalServerError, # internal_server_error
    502 => Error::BadGateway,
    503 => Error::ServiceUnavailable,
    504 => Error::GatewayTimeout
  }.freeze
end
