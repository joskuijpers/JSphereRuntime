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

#import "SPRInput.h"
#import "SPRKeyboard.h"
#import "SPRGamepad.h"
#import "SPRMouse.h"

@implementation SPRInput

@synthesize Mouse=_mouse, Keyboard=_keyboard;
@synthesize gamepads=_gamepads;

+ (void)installIntoContext:(L8Context *)context
{
	SPRInput *input;

	input = [[SPRInput alloc] initWithContext:context];
	context[@"Input"] = input;

	[input.Mouse installInstanceIntoContext:context];
	[input.Keyboard installInstanceIntoContext:context];

	[[SPRGamepad class] installIntoContext:context];
}

- (instancetype)initWithContext:(L8Context *)context
{
    self = [super init];
    if (self) {
		_mouse = [[SPRMouse alloc] init];
		_keyboard = [[SPRKeyboard alloc] init];

		_gamepads = (NSArray<SPRGamepad> *)@[];
    }
    return self;
}

@end

@implementation SPRInputConfig

@synthesize menu=_menu, up=_up, down=_down, left=_left, right=_right;
@synthesize a=_a, b=_b, x=_x, y=_y;

- (instancetype)initWithConfiguration:(NSDictionary *)configuration
{
	self = [super init];
	if(self) {
	}
	return self;
}

- (void)save
{

}

@end