unless DataType.any?
  DataType.create( friendly_name: 'Text', name: 'String', help: 'Max of 255 characters' )
  DataType.create( friendly_name: 'Long plain text', name: 'Text', help: 'for entries that are or might be over 255 characters' )
  DataType.create( friendly_name: 'Whole number', name: 'Fixnum', help: 'numeric entry e.g. Age' )
  DataType.create( friendly_name: 'True or false', name: 'Boolean', help: 'simple yes or no' )
  DataType.create( friendly_name: 'Time and date', name: 'Datetime' )
  DataType.create( friendly_name: 'Markdown', name: 'Markdown' )
  DataType.create( friendly_name: 'File', name: 'File', help: 'attach a file' )
end

ValidationType.destroy_all
unless ValidationType.any?
  ValidationType.create( friendly_name: 'Is present', name: 'presence', help: 'Checks that the value is present (i.e. mandatory)', requires_value: false )
  ValidationType.create( friendly_name: 'Is unique', name: 'uniqueness', help: 'Checks that value has not been used for this property in this collection before', requires_value: false )
  ValidationType.create( friendly_name: 'Acceptance', name: 'acceptance', help: 'Checks that a \'true or false\' value is set to true.', requires_value: false )
  ValidationType.create( friendly_name: 'Confirmation', name: 'confirmation', help: 'Checks that two text fields have exactly the same content.', requires_value: false )
  ValidationType.create( friendly_name: 'Exclusion', name: 'exclusion', help: 'Checks that the value is EXCLUDED from the given set.', requires_value: true )
  ValidationType.create( friendly_name: 'Inclusion', name: 'inclusion', help: 'Checks that the value is INCLUDED from the given set.', requires_value: true )
  ValidationType.create( friendly_name: 'Format with', name: 'format_with', help: 'Checks the value by testing whether it DOES match a given regular expression', requires_value: true )
  ValidationType.create( friendly_name: 'Format without', name: 'format_without', help: 'Checks the value by testing whether it DOES NOT match a given regular expression', requires_value: true )
  ValidationType.create( friendly_name: 'Is a whole number', name: 'numericality', help: 'Checks that the value is a whole number', requires_value: false )
end

unless User.any?
  User.create( username: 'pmgroves', firstname: 'Paul', lastname: 'Groves', superuser: true )
end
