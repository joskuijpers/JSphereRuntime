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

#import "AMDAppDelegate.h"

#import "AMDGraphicsView.h"
#import "AMDGraphicsEngine.h"

#import "AMDJSClass.h"
#import "AMDConsole.h"
#import "AMDEngine.h"

void load_bundle_script(L8Context *context, NSString *name);

@implementation AMDAppDelegate {
	L8Context *_javaScriptContext;
	AMDGraphicsEngine *_graphicsEngine;
	AMDEngine *_engine;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	_graphicsEngine = [[AMDGraphicsEngine alloc] init];
	_graphicsView.engine = _graphicsEngine;
	[_graphicsEngine didCreateContext];

	_javaScriptContext = [[L8Context alloc] init];

	[_javaScriptContext executeBlockInContext:^(L8Context *context) {
		L8Value *ret;
		NSString *mainPath;

		_engine = [[AMDEngine alloc] init];

		// Install the globals
		context[@"console"] = [[AMDConsole alloc] init];
		context[@"engine"] = _engine;
		context[@"global"] = context.globalObject;

		mainPath = [[NSBundle mainBundle] pathForResource:@"andromeda"
														 ofType:@"js"];

		@try {
			ret = [context evaluateScript:[NSString stringWithContentsOfFile:mainPath
																	encoding:NSUTF8StringEncoding
																	   error:NULL]
								 withName:[mainPath lastPathComponent]];
			assert([ret isFunction]);

			// Execute Andromeda
			[ret callWithArguments:@[_engine]];
		} @catch(id exc) {
			fprintf(stderr,"[EXC ] %s\n",[[exc description] UTF8String]);
		}
	}];
}

@end

@interface L8Exception (Ext)
- (NSString *)toString;
@end

@implementation L8Exception (Ext)

- (NSString *)toString
{
	return [self description];
}

@end
