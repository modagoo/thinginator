system("curl -XDELETE 'http://localhost:9200/things/'")

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
  ValidationType.create( friendly_name: 'Is present', name: 'presence', help: 'Check that the value is present (i.e. mandatory)', requires_value: false, data_type_ids: [DataType.find_by_name('String').id, DataType.find_by_name('Text').id, DataType.find_by_name('Fixnum').id, DataType.find_by_name('Boolean').id, DataType.find_by_name('Datetime').id, DataType.find_by_name('Date').id, DataType.find_by_name('Time').id, DataType.find_by_name('Markdown').id, DataType.find_by_name('File').id, DataType.find_by_name('List').id] )

  ValidationType.create( friendly_name: 'Is unique', name: 'uniqueness', help: 'Check that value has not been used for this property in this collection before', requires_value: false, data_type_ids: [DataType.find_by_name('String').id, DataType.find_by_name('Text').id, DataType.find_by_name('Fixnum').id, DataType.find_by_name('Datetime').id, DataType.find_by_name('Date').id, DataType.find_by_name('Time').id, DataType.find_by_name('Markdown').id])

  ValidationType.create( friendly_name: 'Acceptance', name: 'acceptance', help: 'Check that a \'true or false\' value is set to true.', requires_value: false, data_type_ids: [DataType.find_by_name('Boolean').id])

  # ValidationType.create( friendly_name: 'Confirmation', name: 'confirmation', help: 'Check that two text fields have exactly the same content.', requires_value: false )
  ValidationType.create( friendly_name: 'Exclusion', name: 'exclusion', help: 'Check that the value is EXCLUDED from the given set.', requires_value: true, data_type_ids: [DataType.find_by_name('String').id, DataType.find_by_name('Text').id] )

  ValidationType.create( friendly_name: 'Inclusion', name: 'inclusion', help: 'Check that the value is INCLUDED from the given set.', requires_value: true, data_type_ids: [DataType.find_by_name('String').id, DataType.find_by_name('Text').id] )

  ValidationType.create( friendly_name: 'Format with', name: 'format_with', help: 'Check the value by testing whether it DOES match a given regular expression', requires_value: true, data_type_ids: [DataType.find_by_name('String').id, DataType.find_by_name('Text').id] )

  ValidationType.create( friendly_name: 'Format without', name: 'format_without', help: 'Check the value by testing whether it DOES NOT match a given regular expression', requires_value: true, data_type_ids: [DataType.find_by_name('String').id, DataType.find_by_name('Text').id] )

  ValidationType.create( friendly_name: 'Is a whole number', name: 'numericality', help: 'Check that the value is a whole number', requires_value: false, data_type_ids: [DataType.find_by_name('Fixnum').id] )

  ValidationType.create( friendly_name: 'Maximum word count', name: 'max_word', help: 'Check that the value does not exceed given number of words', requires_value: true, data_type_ids: [DataType.find_by_name('Text').id] )
end

# User.delete_all
u = User.find_or_create_by( username: 'pmgroves', firstname: 'Paul', lastname: 'Groves', superuser: true )

List.destroy_all
l = List.create( name: 'Colours', user: u)
ListValue.create( value: 'Red', list: l)
ListValue.create( value: 'Blue', list: l)
ListValue.create( value: 'Green', list: l)
ListValue.create( value: 'Yellow', list: l)
ListValue.create( value: 'Orange', list: l)

l1 = List.create( name: 'Speed', user: u)
ListValue.create( value: 'Fast', list: l1)
ListValue.create( value: 'Medium', list: l1)
ListValue.create( value: 'Slow', list: l1)

Collection.destroy_all
Property.destroy_all
c = Collection.new( name: 'Bicycles', user: u )

c.properties << Property.new( name: 'Make', data_type: DataType.find_by_name('String'))
c.properties << Property.new( name: 'Description', data_type: DataType.find_by_name('Text'))
c.properties << Property.new( name: 'Size', data_type: DataType.find_by_name('Fixnum'))
c.properties << Property.new( name: 'In stock', data_type: DataType.find_by_name('Boolean'))
c.properties << Property.new( name: 'Release time and date', data_type: DataType.find_by_name('Datetime'))
c.properties << Property.new( name: 'Best time to ride', data_type: DataType.find_by_name('Time'))
c.properties << Property.new( name: 'Expires', data_type: DataType.find_by_name('Date'))
c.properties << Property.new( name: 'Web copy', data_type: DataType.find_by_name('Markdown'))
c.properties << Property.new( name: 'Tech spec', data_type: DataType.find_by_name('File'))
lst = Property.new( name: 'Colour', data_type: DataType.find_by_name('List'))
lst.data_lists << DataList.new(list: l, multiple: true)
lst1 = Property.new( name: 'Speed', data_type: DataType.find_by_name('List'))
lst1.data_lists << DataList.new(list: l1, multiple: false)
c.properties << lst
c.properties << lst1

c.save

Thing.destroy_all
Thing.create( user: u, collection: c, make: "Cannondale", description: "2010 SL Trail", size: 18 )
Thing.create( user: u, collection: c, make: "Trek", description: "2010 SL Trail", size: 18 )
Thing.create( user: u, collection: c, make: "Kona", description: "2010 SL Trail", size: 18 )
Thing.create( user: u, collection: c, make: "Specialized", description: "2010 SL Trail", size: 18 )
Thing.create( user: u, collection: c, make: "Felt", description: "2010 SL Trail", size: 18 )
Thing.create( user: u, collection: c, make: "Scott", description: "2010 SL Trail", size: 18 )
Thing.create( user: u, collection: c, make: "Cube", description: "2010 SL Trail", size: 18 )
Thing.create( user: u, collection: c, make: "Marin", description: "2010 SL Trail", size: 18 )
Thing.create( user: u, collection: c, make: "Mongoose", description: "2010 SL Trail", size: 18 )

10.times do
  Thing.create( user: u, collection: c, make: (10...50).map{ ('a'..'z').to_a[rand(26)] }.join, description: (10...50).map{ ('a'..'z').to_a[rand(26)] }.join, size: 18, )
end

c = Collection.first
c.save


Thing.all.each do |t|
  t.update_index
end
