package cl.duoc.comestible.service;

import cl.duoc.comestible.model.*;
import cl.duoc.comestible.repository.ProductRepository;
import cl.duoc.comestible.repository.ReceiptRepository;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Service
public class PurchaseService {

    private final ProductRepository productRepo;
    private final ReceiptRepository receiptRepo;

    public PurchaseService(ProductRepository productRepo, ReceiptRepository receiptRepo) {
        this.productRepo = productRepo;
        this.receiptRepo = receiptRepo;
    }

    public Receipt buy(List<CartItemDTO> items) {
        Receipt receipt = new Receipt();
        List<ReceiptLine> lines = new ArrayList<>();
        BigDecimal total = BigDecimal.ZERO;

        for (CartItemDTO item : items) {
            Product product = productRepo.findById(item.getProductId())
                .orElseThrow(() -> new RuntimeException("Producto no encontrado"));
            BigDecimal lineTotal = product.getPrice().multiply(BigDecimal.valueOf(item.getQuantity()));
            ReceiptLine line = new ReceiptLine();
            line.setProductName(product.getName());
            line.setUnitPrice(product.getPrice());
            line.setQuantity(item.getQuantity());
            line.setLineTotal(lineTotal);
            lines.add(line);
            total = total.add(lineTotal);
        }

        receipt.setLines(lines);
        receipt.setTotal(total);
        return receiptRepo.save(receipt);
    }
}
