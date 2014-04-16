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

#import <L8Framework/L8Export.h>

@class L8Value;

/**
 * @brief Information about the process: JavaScript exports.
 */
@protocol AMDProcess <L8Export>

/// The main module. (type Module)
@property (strong) L8Value *mainModule;

/**
 * Run a piece of code in the current context.
 *
 * @param code The code to run.
 * @param options Execution options: [filename]
 * @return The result object after evaluation.
 */
L8_EXPORT_AS(runInThisContext,
- (L8Value *)runInThisContext:(NSString *)code withOptions:(NSDictionary *)options
);

L8_EXPORT_AS(binding,
- (L8Value *)bindingForBuiltin:(NSString *)builtin
);

L8_EXPORT_AS(readFile,
- (NSString *)contentsOfFileAtPath:(NSString *)path
);
@end

/**
 * @brief Information about the process.
 */
@interface AMDProcess : NSObject <AMDProcess>

@end
