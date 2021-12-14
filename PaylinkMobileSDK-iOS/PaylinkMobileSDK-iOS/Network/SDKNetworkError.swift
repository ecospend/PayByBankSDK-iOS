//
//  SDKNetworkError.swift
//  SpeedyPaySDK
//
//  Created by Berk Akkerman on 13.12.2021.
//

import Foundation

public enum SDKNetworkError: Error {
    /// Unknown or not supported error
    case Unknown
    
    /// Authentication needed
    case Authentication
    
    /// Not connected to the internet
    case NotConnectedToInternet
    
    /// International data roaming turned off
    case InternationalRoamingOff
    
    /// Cannot reach the server
    case NotReachedServer
    
    /// Connection is lost
    case ConnectionLost
    
    /// Incorrect data returned from the server
    case IncorrectDataReturned
    
    /// Connection is insecure
    case InsecureConnection
    
    /// Operation is cancelled
    case Cancelled
    
    /// Multiple session detected
    case MultipleSession
    
    /// Timeout exceeded
    case Timeout
    
    /// Timeout exceeded
    case Authorization
    
    // TODO: Messages will be changed with localizable strings
    public var message: String {
        switch self {
        case .Authentication: return "Authentication failed"
        case .IncorrectDataReturned: return "Incorrect data returned"
        case .NotConnectedToInternet: return "Internet connection failed"
        case .NotReachedServer: return "Service is unreachable"
        case .ConnectionLost: return "Connection lost"
        case .InsecureConnection: return "Insecure connection detected"
        case .Cancelled: return "Request cancelled"
        case .Timeout: return "Request timeout"
        case .Authorization: return "Authorization failed"
        default: return "Unexpected error occured"
        }
    }
    
    internal init(error: NSError) {
        
        switch error.domain {
        case NSURLErrorDomain:
            
            switch error.code {
            case NSURLErrorCancelled:
                self = .Cancelled
            case NSURLErrorDNSLookupFailed,
                NSURLErrorCannotFindHost,
            NSURLErrorCannotConnectToHost:
                self = .NotReachedServer
            case NSURLErrorDataLengthExceedsMaximum:
                self = .IncorrectDataReturned
            case NSURLErrorNetworkConnectionLost:
                self = .ConnectionLost
            case NSURLErrorNotConnectedToInternet:
                self = .NotConnectedToInternet
            case NSURLErrorUserCancelledAuthentication,
            NSURLErrorUserAuthenticationRequired:
                self = .Authentication
            case NSURLErrorDataLengthExceedsMaximum,
                NSURLErrorUnsupportedURL,
                NSURLErrorBadURL,
                NSURLErrorResourceUnavailable,
                NSURLErrorRedirectToNonExistentLocation,
                NSURLErrorBadServerResponse,
                NSURLErrorZeroByteResource,
                NSURLErrorCannotDecodeRawData,
                NSURLErrorCannotDecodeContentData,
                NSURLErrorCannotParseResponse,
                NSURLErrorFileDoesNotExist,
            NSURLErrorFileIsDirectory:
                self = .IncorrectDataReturned
            case NSURLErrorInternationalRoamingOff:
                self = .InternationalRoamingOff
            case NSURLErrorUnknown,
                NSURLErrorHTTPTooManyRedirects,
                NSURLErrorHTTPTooManyRedirects,
                NSURLErrorCallIsActive,
                NSURLErrorDataNotAllowed,
                NSURLErrorRequestBodyStreamExhausted,
                NSURLErrorNoPermissionsToReadFile,
                NSURLErrorSecureConnectionFailed,
                NSURLErrorServerCertificateHasBadDate,
                NSURLErrorServerCertificateUntrusted,
                NSURLErrorServerCertificateHasUnknownRoot,
                NSURLErrorServerCertificateNotYetValid,
                NSURLErrorClientCertificateRejected,
                NSURLErrorClientCertificateRequired,
                NSURLErrorCannotLoadFromNetwork,
                NSURLErrorCannotCreateFile,
                NSURLErrorCannotOpenFile,
                NSURLErrorCannotCloseFile,
                NSURLErrorCannotWriteToFile,
                NSURLErrorCannotRemoveFile,
                NSURLErrorCannotMoveFile,
                NSURLErrorDownloadDecodingFailedMidStream,
            NSURLErrorDownloadDecodingFailedToComplete:
                self = .Unknown
            case NSURLErrorTimedOut:
                self = .Timeout
            default:
                self = .Unknown
            }
        case String(kCFErrorDomainCFNetwork):
            switch error.code {
            case Int(CFNetworkErrors.cfurlErrorServerCertificateNotYetValid.rawValue),
                Int(CFNetworkErrors.cfurlErrorServerCertificateUntrusted.rawValue),
                Int(CFNetworkErrors.cfurlErrorServerCertificateHasBadDate.rawValue),
                Int(CFNetworkErrors.cfurlErrorServerCertificateHasUnknownRoot.rawValue),
                Int(CFNetworkErrors.cfurlErrorClientCertificateRejected.rawValue),
                Int(CFNetworkErrors.cfurlErrorClientCertificateRequired.rawValue),
                Int(CFNetworkErrors.cfErrorHTTPSProxyConnectionFailure.rawValue),
                Int(CFNetworkErrors.cfurlErrorSecureConnectionFailed.rawValue),
                Int(CFNetworkErrors.cfurlErrorCannotLoadFromNetwork.rawValue),
                Int(CFNetworkErrors.cfurlErrorCancelled.rawValue):
                self = .InsecureConnection
            case Int(CFNetworkErrors.cfurlErrorNotConnectedToInternet.rawValue):
                self = .NotConnectedToInternet
            case Int(CFNetworkErrors.cfurlErrorTimedOut.rawValue):
                self = .Timeout
            default:
                self = .Unknown
            }
        default:
            self = .Unknown
        }
    }
}
