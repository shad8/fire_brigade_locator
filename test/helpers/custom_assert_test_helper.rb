def assert_collections_equal(collection_a, collection_b)
  assert_equal collection_a.to_set, collection_b.to_set
end