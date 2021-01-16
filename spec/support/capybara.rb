require 'capybara/rspec'
require 'selenium-webdriver'

module CapybaraSupport
  Capybara.javascript_driver = :selenium_chrome_headless
  Capybara.default_driver    = :selenium_chrome_headless
  Capybara.register_driver :selenium_chrome_headless do |app|
    url = 'http://chrome:4444/wd/hub'
    caps = ::Selenium::WebDriver::Remote::Capabilities.chrome(
      'goog:chromeOptions' => {
        'args' => [
          'no-sandbox',
          'headless',
          'disable-gpu',
          'window-size=1680,1050'
        ]
      }
    )
    Capybara::Selenium::Driver.new(app, browser: :chrome, url: url, desired_capabilities: caps)
  end
end
