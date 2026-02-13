;; Reward Points Contract

(define-map points { user: principal } { points: uint })

;; Add reward points
(define-public (add-reward (amount uint))
  (let ((current (default-to u0 (get points (map-get? points { user: tx-sender })))))
    (map-set points { user: tx-sender } { points: (+ current amount) })
    (ok "Reward added")
  )
)

;; Redeem reward points
(define-public (redeem (amount uint))
  (let ((current (default-to u0 (get points (map-get? points { user: tx-sender })))))
    (if (>= current amount)
        (begin
          (map-set points { user: tx-sender } { points: (- current amount) })
          (ok "Reward redeemed")
        )
        (err u101)
    )
  )
)

;; Check points
(define-read-only (get-points (user principal))
  (default-to u0 (get points (map-get? points { user }))))
