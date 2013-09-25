DataType.destroy_all
unless DataType.any?
  DataType.create( friendly_name: 'Text', name: 'String', help: 'Max of 255 characters' )
  DataType.create( friendly_name: 'Long plain text', name: 'Text', help: 'for entries that are or might be over 255 characters' )
  DataType.create( friendly_name: 'Whole number', name: 'Fixnum', help: 'numeric entry e.g. Age' )
  DataType.create( friendly_name: 'True or false', name: 'Boolean', help: 'simple yes or no' )
  DataType.create( friendly_name: 'Time and date', name: 'Datetime' )
  DataType.create( friendly_name: 'Date', name: 'Date', help: 'only date, no time' )
  DataType.create( friendly_name: 'Time', name: 'Time', help: 'only time, no date' )
  DataType.create( friendly_name: 'Markdown', name: 'Markdown' )
  DataType.create( friendly_name: 'File', name: 'File', help: 'attach a file' )
  DataType.create( friendly_name: 'List', name: 'List', help: 'select from a predefined list of choices' )
end

ValidationType.destroy_all
unless ValidationType.any?
  ValidationType.create( friendly_name: 'Is present', name: 'presence', help: 'Checks that the value is present (i.e. mandatory)', requires_value: false )
  ValidationType.create( friendly_name: 'Is unique', name: 'uniqueness', help: 'Checks that value has not been used for this property in this collection before', requires_value: false )
  ValidationType.create( friendly_name: 'Acceptance', name: 'acceptance', help: 'Checks that a \'true or false\' value is set to true.', requires_value: false )
  # ValidationType.create( friendly_name: 'Confirmation', name: 'confirmation', help: 'Checks that two text fields have exactly the same content.', requires_value: false )
  ValidationType.create( friendly_name: 'Exclusion', name: 'exclusion', help: 'Checks that the value is EXCLUDED from the given set.', requires_value: true )
  ValidationType.create( friendly_name: 'Inclusion', name: 'inclusion', help: 'Checks that the value is INCLUDED from the given set.', requires_value: true )
  ValidationType.create( friendly_name: 'Format with', name: 'format_with', help: 'Checks the value by testing whether it DOES match a given regular expression', requires_value: true )
  ValidationType.create( friendly_name: 'Format without', name: 'format_without', help: 'Checks the value by testing whether it DOES NOT match a given regular expression', requires_value: true )
  ValidationType.create( friendly_name: 'Is a whole number', name: 'numericality', help: 'Checks that the value is a whole number', requires_value: false )
end

# User.delete_all
u = User.find_or_create_by_username( username: 'pmgroves', firstname: 'Paul', lastname: 'Groves', superuser: true )

List.destroy_all
l = List.create( name: 'Colours', user: u)
ListValue.create( value: 'Red', list: l)
ListValue.create( value: 'Blue', list: l)
ListValue.create( value: 'Green', list: l)
ListValue.create( value: 'Yellow', list: l)
ListValue.create( value: 'Orange', list: l)

Collection.destroy_all
Property.destroy_all
c = Collection.new( name: 'Bicycles', user: u )

c.properties << Property.new( name: 'Make', data_type: DataType.find_by_name('String'))
c.properties << Property.new( name: 'Description', data_type: DataType.find_by_name('Text'))
c.properties << Property.new( name: 'Size', data_type: DataType.find_by_name('Fixnum'))
c.properties << Property.new( name: 'In stock', data_type: DataType.find_by_name('Boolean'))
c.properties << Property.new( name: 'Release date', data_type: DataType.find_by_name('Datetime'))
c.properties << Property.new( name: 'Web copy', data_type: DataType.find_by_name('Markdown'))
c.properties << Property.new( name: 'Tech spec', data_type: DataType.find_by_name('File'))
lst = Property.new( name: 'Colour', data_type: DataType.find_by_name('List'))
lst.data_lists << DataList.new(list: l, multiple: true)
c.properties << lst

c.save


Thing.destroy_all
Thing.create( user: u, collection: c, make: "Cannondale", description: "2010 SL Trail", size: 18, )
Thing.create( user: u, collection: c, make: "Trek", description: "2010 SL Trail", size: 18, )
Thing.create( user: u, collection: c, make: "Kona", description: "2010 SL Trail", size: 18, )
Thing.create( user: u, collection: c, make: "Specialized", description: "2010 SL Trail", size: 18, )
Thing.create( user: u, collection: c, make: "Felt", description: "2010 SL Trail", size: 18, )
Thing.create( user: u, collection: c, make: "Scott", description: "2010 SL Trail", size: 18, )
Thing.create( user: u, collection: c, make: "Cube", description: "2010 SL Trail", size: 18, )
Thing.create( user: u, collection: c, make: "Marin", description: "2010 SL Trail", size: 18, )
Thing.create( user: u, collection: c, make: "Mongoose", description: "2010 SL Trail", size: 18, )
