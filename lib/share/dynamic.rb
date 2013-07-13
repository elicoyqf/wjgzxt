module Dynamic
  class << self
    def klass(table_name)
      tname = class_name_from_table(table_name)
      #see if it has already been defined
      const_missing(tname)
    rescue NameError
      define_klass(table_name)
    end

    def objeck(table_name)
      klass(table_name).new
    end

    private
    def class_name_from_table(table_name)
      ActiveSupport::Inflector.camelize(table_name)
    end

    def define_klass(table_name)
      tname     = class_name_from_table(table_name)
      class_def = <<-end_eval
         class #{tname} < ActiveRecord::Base
           set_table_name('#{table_name}')
         end
      end_eval
      eval(class_def, TOPLEVEL_BINDING)
      const_get(tname)
    end
  end
end