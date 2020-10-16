Rails.configuration.stripe = {
    :publishable_key => "pk_test_51HcZxRCVG7ifO8tZAvb2d53D5odJMxu21bOa7sALsOiZqQb69gGIxhu6jYxH9LmiKc53pVtsjd8FQRFSpddh81Gv00tUzdIMua",
    :secret_key      => "sk_test_51HcZxRCVG7ifO8tZLtkd9dNDrvkVNOgmMFYI3UoTmriZoDNEJBDfpHebkVQK1kLHQVDMdzmmdAgHXigto9x0jpwI008ZUxyOQ5"

}
Stripe.api_key = Rails.configuration.stripe[:secret_key]