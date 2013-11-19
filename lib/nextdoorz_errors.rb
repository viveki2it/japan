# -*- encoding : utf-8 -*-
# This module is a collection of classes that represent different kinds of errors that can happen in Nextdoorz app
module NextdoorzErrors

  # Base class for all custom error types. Use it to check if error was generated in application
  class NextdoorzError < StandardError
  end


  # This is the base class for error that can be shown to user. It contains data that can help to determine,
  # what to do when error happens.
  class RenderedError < NextdoorzError
    attr_accessor :redirection_method_name

    def redirection_method_name
      @redirection_method_name || default_redirection_method_name
    end

    def default_redirection_method_name
      'root_url'
    end

    attr_accessor :state

    def state
      @state || default_state
    end

    def default_state
      500
    end
  end

  # This is base class for internal errors. When such error happens, user gets a page with 500 error.
  class NonRenderedError < NextdoorzError
  end

  # This is base class for all errors kind of "not found"
  class Error404 < RenderedError
    def default_state
      404
    end
  end

  class StaticPageMissing < Error404
  end

  class AlreadyFollowing < RenderedError
    def default_state
      400
    end
  end

  class MalformedUrl < RenderedError
    def default_state
      404
    end
  end
end
