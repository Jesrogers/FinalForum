module CkeHelpers
  def fill_in_ckeditor(locator, options)
    content = options.fetch(:with).to_json
    page.execute_script <<-SCRIPT
            CKEDITOR.instances['#{locator}'].setData(#{content});
            document.querySelector('textarea##{locator}').textContent = #{content};
    SCRIPT
  end

  def get_ckeditor_text(locator)
    page.execute_script <<-SCRIPT
          return CKEDITOR.instances['#{locator}'].editable().getText();
    SCRIPT
  end
end

RSpec.configure do |config|
  config.include CkeHelpers, type: :system
end
