//
//  NetworkSession.swift
//  PayByBank
//
//  Created by Yunus TÜR on 13.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

/// Protocol to which network session handling classes must conform to.
protocol NetworkSessionProtocol {
    /// Create  a URLSessionDataTask. The caller is responsible for calling resume().
    /// - Parameters:
    ///   - request: `URLRequest` object.
    ///   - completionHandler: The completion handler for the data task.
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask?
    
    /// Create  a URLSessionDownloadTask. The caller is responsible for calling resume().
    /// - Parameters:
    ///   - request: `URLRequest` object.
    ///   - progressHandler: Optional `ProgressHandler` callback.
    ///   - completionHandler: The completion handler for the download task.
    func downloadTask(request: URLRequest, progressHandler: ProgressHandler?, completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask?
    
    /// Create  a URLSessionUploadTask. The caller is responsible for calling resume().
    /// - Parameters:
    ///   - request: `URLRequest` object.
    ///   - fileURL: The source file `URL`.
    ///   - progressHandler: Optional `ProgressHandler` callback.
    ///   - completion: he completion handler for the upload task.
    func uploadTask(with request: URLRequest, from fileURL: URL, progressHandler: ProgressHandler?, completion: @escaping (Data?, URLResponse?, Error?)-> Void) -> URLSessionUploadTask?
    
    /// Invalidate session calling with `finishTasksAndInvalidate` and `invalidateAndCancel` methods.
    /// - Warning: Session should be invalidated when not needed becasue URLSession strongly retains its delegate. For more information: [func invalidateandcancel()](https://developer.apple.com/documentation/foundation/urlsession/1411538-invalidateandcancel)
    func invalidateSession()
}

/// Class handling the creation of URLSessionTaks and responding to URSessionDelegate callbacks.
class NetworkSession: NSObject {
    
    /// The URLSession handing the URLSessionTaks.
    var session: URLSession!
    
    /// A typealias describing a progress and completion handle tuple.
    private typealias ProgressAndCompletionHandlers = (progress: ProgressHandler?, completion: ((URL?, URLResponse?, Error?) -> Void)?)
    
    /// Dictionary containing associations of `ProgressAndCompletionHandlers` to `URLSessionTask` instances.
    private var taskToHandlersMap: [URLSessionTask : ProgressAndCompletionHandlers] = [:]
    
    /// Convenience initializer.
    public override convenience init() {
        // Configure the default URLSessionConfiguration.
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForResource = 30
        if #available(iOS 11, *) {
            sessionConfiguration.waitsForConnectivity = true
        }
        
        // Create a `OperationQueue` instance for scheduling the delegate calls and completion handlers.
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 3
        queue.qualityOfService = .userInitiated
        
        // Call the designated initializer
        self.init(configuration: sessionConfiguration, delegateQueue: queue)
    }
    
    /// Designated initializer.
    /// - Parameters:
    ///   - configuration: `URLSessionConfiguration` instance.
    ///   - delegateQueue: `OperationQueue` instance for scheduling the delegate calls and completion handlers.
    public init(configuration: URLSessionConfiguration, delegateQueue: OperationQueue) {
        super.init()
        self.session = URLSession(configuration: configuration, delegate: self, delegateQueue: delegateQueue)
    }
    
    
    /// Associates a `URLSessionTask` instance with its `ProgressAndCompletionHandlers`
    /// - Parameters:
    ///   - handlers: `ProgressAndCompletionHandlers` tuple.
    ///   - task: `URLSessionTask` instance.
    private func set(handlers: ProgressAndCompletionHandlers?, for task: URLSessionTask) {
        taskToHandlersMap[task] = handlers
    }
    
    /// Fetches the `ProgressAndCompletionHandlers` for a given `URLSessionTask`.
    /// - Parameter task: `URLSessionTask` instance.
    /// - Returns: `ProgressAndCompletionHandlers` optional instance.
    private func getHandlers(for task: URLSessionTask) -> ProgressAndCompletionHandlers? {
        return taskToHandlersMap[task]
    }
    
    deinit {
        session = nil
    }
}

// MARK: - NetworkSessionProtocol
extension NetworkSession: NetworkSessionProtocol {
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask? {
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            completionHandler(data, response, error)
        }
        return dataTask
    }
    
    func downloadTask(request: URLRequest, progressHandler: ProgressHandler? = nil, completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask? {
        let downloadTask = session.downloadTask(with: request)
        // Set the associated progress and completion handlers for this task.
        set(handlers: (progressHandler, completionHandler), for: downloadTask)
        return downloadTask
    }
    
    func uploadTask(with request: URLRequest, from fileURL: URL, progressHandler: ProgressHandler? = nil, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask? {
        let uploadTask = session.uploadTask(with: request, fromFile: fileURL, completionHandler: { (data, urlResponse, error) in
            completion(data, urlResponse, error)
        })
        // Set the associated progress handler for this task.
        set(handlers: (progressHandler, nil), for: uploadTask)
        return uploadTask
    }
    
    func invalidateSession() {
        session.finishTasksAndInvalidate()
        session.invalidateAndCancel()
    }
}

// MARK: - URLSessionDelegate
extension NetworkSession: URLSessionDelegate {
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        guard let handlers = getHandlers(for: task) else {
            return
        }
        
        let progress = Float(totalBytesSent) / Float(totalBytesExpectedToSend)
        DispatchQueue.main.async {
            handlers.progress?(progress)
        }
        //  Remove the associated handlers.
        set(handlers: nil, for: task)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let downloadTask = task as? URLSessionDownloadTask,
              let handlers = getHandlers(for: downloadTask) else {
                  return
              }
        
        DispatchQueue.main.async {
            handlers.completion?(nil, downloadTask.response, downloadTask.error)
        }
        
        //  Remove the associated handlers.
        set(handlers: nil, for: task)
    }
}

// MARK: - URLSessionDownloadDelegate
extension NetworkSession: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let handlers = getHandlers(for: downloadTask) else {
            return
        }
        
        DispatchQueue.main.async {
            handlers.completion?(location, downloadTask.response, downloadTask.error)
        }
        
        //  Remove the associated handlers.
        set(handlers: nil, for: downloadTask)
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        guard let handlers = getHandlers(for: downloadTask) else {
            return
        }
        
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        DispatchQueue.main.async {
            handlers.progress?(progress)
        }
    }
}
