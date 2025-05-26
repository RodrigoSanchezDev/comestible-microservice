package cl.duoc.comestible.controller;

import cl.duoc.comestible.model.CartItemDTO;
import cl.duoc.comestible.model.Receipt;
import cl.duoc.comestible.service.PurchaseService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/purchase")
public class PurchaseController {

    private final PurchaseService service;

    public PurchaseController(PurchaseService service) {
        this.service = service;
    }

    @PostMapping
    public ResponseEntity<Receipt> buy(@RequestBody List<CartItemDTO> cart) {
        return ResponseEntity.ok(service.buy(cart));
    }
}
