package cl.duoc.comestible.repository;

import cl.duoc.comestible.model.Receipt;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReceiptRepository extends JpaRepository<Receipt, Long> {}
