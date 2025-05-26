package cl.duoc.comestible.repository;

import cl.duoc.comestible.model.Product;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductRepository extends JpaRepository<Product, Long> {}
