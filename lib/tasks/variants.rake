
namespace :jangala do
  namespace :variants do
    desc "Create a default variant for every deal and product. The variant has no name and only one item in stock"
    task seed: :environment do
      [Product, Deal].each do |klass|
        klass.unscoped.all.each do |variable|
          if variable.variants.size == 0
            puts "Addind a default variant to #{variable.name} from Store #{variable.store.name}"
            variable.variants.create!(name: 'standard', stock: 1)
          end
        end
      end
    end
  end
end
