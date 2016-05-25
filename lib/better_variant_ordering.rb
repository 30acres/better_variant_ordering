require "better_variant_ordering/version"

module BetterVariantOrdering
  def self.reorder_variants_by_size(p)
    # binding.pry
    p_variants = p.variants.sort! { |a,b| a.title.to_i <=> b.title.to_i }
    p_variants.each_with_index do |v,index|
      v.position = index + 1
      v.save!
    end
    p.save!
  end


  def self.compress_variants(p)
    # binding.pry
    p_variants = p.variants.sort! { |a,b| a.title.to_i <=> b.title.to_i }
    v_first = p_variants.first.title
    v_last = p_variants.last.title
    new_variant_title = "#{v_first} - #{v_last}"
    if p.product_type == 'Custom Ring' and !p.variants.first.option1.include?('ram')
      puts new_variant_title
      puts 'Titled!'
      p_variants.each_with_index do |v,index|
        puts "Varianted #{index}"
        if v.position == 1
          unless v.option1.include?('-')
            v.option1 = new_variant_title
            # binding.pry
            # v.save!
          end
        else
          ##
        end
      end
      # p.variants = [p_variants.first]
      p.variants = [p_variants.first]
      puts p
      p.save!
      puts "UPDATED"
    else
      puts "SKIPPING"
      # binding.pry
    end
  end
end
