/*
 * Copyright (c) 2014 Jos Kuijpers. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
 * USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "SPRJSClass.h"

@class SPRSocket;

/**
 * @brief Bonjour networking: JavaScript exports.
 */
@protocol SPRBonjour <L8Export>

- (instancetype)init;

// publish
//: name, type, domain, port
L8_EXPORT_AS(publish,
- (BOOL)publishWithName:(NSString *)name
				   type:(NSString *)type
				   port:(uint16_t)port
			   inDomain:(NSString *)domain
);

// discover
//: type, domain => name (+ port?)
L8_EXPORT_AS(discover,
- (void)discoverPeersWithType:(NSString *)type
		   domain:(NSString *)domain
		   callback:(void (^)(NSString *name))callback
);

// resolve -> toSocket
//: name => addr + port
L8_EXPORT_AS(resolve,
- (SPRSocket *)resolvePeerWithName:(NSString *)name
);

@end

/**
 * @brief Bonjour networking.
 */
@interface SPRBonjour : NSObject <SPRBonjour, SPRJSClass>

@end
