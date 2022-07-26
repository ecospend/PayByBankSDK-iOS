//
//  APIDocuments.swift
//  Example
//
//  Created by Yunus TÜR on 19.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

struct APIDocuments {
    
    struct Authentication {
        static let base = "https://docs.ecospend.com/api/intro/#section/Authentication"
    }
    
    struct Paylink {
        static let base = "https://docs.ecospend.com/api/paylink/V2/#tag/Paylink-API"
        static let create = "\(base)/paths/~1api~1v2.0~1paylinks/post"
        static let get = "\(base)/paths/~1api~1v2.0~1paylinks~1%7BpaylinkId%7D/get"
        static let deactivate = "\(base)/paths/~1api~1v2.0~1paylinks~1%7BpaylinkId%7D/delete"
    }
    
    struct FrPayment {
        static let base = "https://docs.ecospend.com/api/paylink/V2/#tag/FrPayments-API"
        static let create = "\(base)/paths/~1api~1v2.0~1fr-payments/post"
        static let get = "\(base)/paths/~1api~1v2.0~1fr-payments~1%7BfrPaymentId%7D/get"
        static let deactivate = "\(base)/paths/~1api~1v2.0~1fr-payments~1%7BfrPaymentId%7D/delete"
    }
    
    struct BulkPayment {
        static let base = "https://docs.ecospend.com/api/paylink/V2/#tag/Bulk-Paymentlink-API"
        static let create = "\(base)/paths/~1api~1v2.0~1bulk-payment-paylinks/post"
        static let get = "\(base)/paths/~1api~1v2.0~1bulk-payment-paylinks~1%7BpaylinkId%7D/get"
        static let deactivate = "\(base)/paths/~1api~1v2.0~1bulk-payment-paylinks~1%7BpaylinkId%7D/delete"
    }
    
    struct VRPlink {
        static let base = "https://docs.ecospend.com/api/paylink/V2/#tag/Vrplink-API"
        static let create = "\(base)/paths/~1api~1v2.0~1vrplinks/post"
        static let get = "\(base)/paths/~1api~1v2.0~1vrplinks~1%7BvrplinkId%7D/get"
        static let deactivate = "\(base)/paths/~1api~1v2.0~1vrplinks~1%7BvrplinkId%7D/delete"
        static let listRecords = "\(base)/paths/~1api~1v2.0~1vrplinks~1%7BvrplinkId%7D~1vrps/get"
    }
    
    struct Datalink {
        static let base = "https://docs.ecospend.com/api/ais/V2/#tag/Datalink-API"
        static let create = "\(base)/paths/~1api~1v2.0~1datalink/post"
        static let get = "\(base)/paths/~1api~1v2.0~1datalink~1%7Bunique_id%7D/get"
        static let delete = "\(base)/paths/~1api~1v2.0~1datalink~1%7Bunique_id%7D/delete"
        static let getOfConsent = "\(base)/paths/~1api~1v2.0~1datalink~1consent~1%7Bconsent_id%7D/get"
    }
    
    struct Payment {
        static let base = "https://docs.ecospend.com/api/pis/V2/#tag/Payments-API"
        static let create = "\(base)/paths/~1api~1v2.0~1payments/post"
        static let list = "\(base)/paths/~1api~1v2.0~1payments/get"
        static let get = "\(base)/paths/~1api~1v2.0~1payments~1%7Bid%7D/get"
        static let checkURL = "\(base)/paths/~1api~1v2.0~1payments~1%7Bid%7D~1url-consumed/get"
        static let createRefund = "\(base)/paths/~1api~1v2.0~1payments~1%7Bid%7D~1refund/post"
    }
}
