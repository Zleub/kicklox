namespace :messages do
    desc "Archives records older than 3 months"
    task :prune => :environment do
      puts "Archiving things older than 3 months"

      keepIds = Message
        .where("created_at > ?", 3.months.ago)
        .where.not(parent: nil)
        .distinct.pluck(:parent_id)

      archived = Message
        .where("created_at < ?", 3.months.ago)
        .where.not(id: keepIds)

      archived = archived.select { |e| !keepIds.include?(e.parent_id) }

      archived.each do |n| 
        ArchivedMessage.new(n.attributes).save 
      end

      archived.reverse.each do |n| 
        n.delete
      end

      puts "#{archived.length} records archived."
    end
  end