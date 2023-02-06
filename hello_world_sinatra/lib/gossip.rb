class Gossip
    attr_accessor :author, :content
  
      def initialize(author, content)
          @author = author
          @content = content
      end
  
      def save
        CSV.open("./db/gossip.csv", "ab") do |csv|
          csv << [@author, @content]
        end
      end
  
      def self.all
        all_gossips = []
        CSV.read("./db/gossip.csv").each do |csv_line|
          all_gossips << Gossip.new(csv_line[0], csv_line[1])
        end
        return all_gossips
      end
  
  
      def self.find(id)
        all_gossips = self.all
        id = id.to_i
        return all_gossips[id]
      end 
      
      def self.update (id, author, content)
        id =id.to_i
        all_gossips = self.all
        all_gossips[id].author = author
        all_gossips[id].content = content
      
        CSV.open("./db/gossip.csv", "wb") do |csv|
          all_gossips.each do |gossip|
            csv << [gossip.author, gossip.content]
        end
      end
    end  
end

