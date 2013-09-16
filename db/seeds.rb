if DataType.all.empty?
  DataType.create( friendly_name: 'Short Text', name: 'String', help: 'Max of 255 characters' )
  DataType.create( friendly_name: 'Long Text', name: 'Text', help: 'for entries that are or might be over 255 characters' )
  DataType.create( friendly_name: 'Number', name: 'Fixnum', help: 'numeric entry e.g. Age' )
  DataType.create( friendly_name: 'True or false', name: 'Boolean', help: 'simple yes or no' )
  DataType.create( friendly_name: 'Time and date', name: 'Datetime' )
  DataType.create( friendly_name: 'File', name: 'File', help: 'attach a file' )
end

ValidationType.destroy_all
if ValidationType.all.empty?
  ValidationType.create( friendly_name: 'Is present', name: 'presence', help: 'Checks that the value is present (i.e. mandatory)', requires_value: false )
  ValidationType.create( friendly_name: 'Is unique', name: 'uniqueness', help: 'Checks that value has not been used for this property in this collection before', requires_value: false )
  ValidationType.create( friendly_name: 'Acceptance', name: 'acceptance', help: 'Checks that a \'true or false\' value is set to true.', requires_value: false )
  ValidationType.create( friendly_name: 'Confirmation', name: 'confirmation', help: 'Checks that two text fields have exactly the same content.', requires_value: false )
  ValidationType.create( friendly_name: 'Exclusion', name: 'exclusion', help: 'Checks that the value is EXCLUDED from the given set.', requires_value: true )
  ValidationType.create( friendly_name: 'Inclusion', name: 'inclusion', help: 'Checks that the value is INCLUDED from the given set.', requires_value: true )
  ValidationType.create( friendly_name: 'Format with', name: 'format', help: 'Checks the value by testing whether it matches a given regular expression', requires_value: true )
  ValidationType.create( friendly_name: 'Is a number', name: 'numericality', help: 'Checks that the value is a number', requires_value: false )
end
