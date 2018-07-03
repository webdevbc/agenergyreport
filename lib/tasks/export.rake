namespace :export do
  desc "Print steps in a way that can be copy/pasted into seeds.rb"
  task :seeds_format => :environment do
    Step.order(:id).all.each do |step|
      puts "Step.create(#{step.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
    end
  end
end
