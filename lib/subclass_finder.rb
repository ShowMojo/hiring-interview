class SubclassFinder
  def self.find_subclasses_for(parent_class, namespace:)
    namespace_items = namespace.constants(false).map { |name| namespace.const_get(name, false) }
    namespace_items.flat_map do |item|
      next [] unless item.is_a?(Module)
      next [item] if item < parent_class

      find_subclasses_for(parent_class, namespace: item)
    end
  end
end
