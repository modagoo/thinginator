module Utilities

  def sync_iser_list
    l = List.find_or_create_by(name: "ISER staff and students")
    l.user = User.find_by(username: "pmgroves")
    l.save
    Square::Person.find_all.each do |person|
      l.list_values.find_or_create_by(value: person.fullname)
      p "Synced #{person.fullname}"
    end
  end

  def rebuild_thing_index
    system("curl -XDELETE 'http://localhost:9200/things/'")
    Thing.all.each do |t|
      t.update_index
    end
  end

end
