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

#import "AMKFile.h"

#define AMK_RSS_DEFAULT_FRAME_DELAY 8

@class AMKImage;

/**
 * @brief A sprite set. Also the representation of .rss files
 */
@interface AMKSpriteSet : AMKFile

/// Size of each frame image
@property (readonly) NSSize frameSize;

/// Rectangle forming the base, used for touch, talk and obstruction
@property (readonly) NSRect base;

/// An array of directions of class AMKSpriteSetDirection
@property (readonly) NSArray *directions;

/// An array of NSImages
@property (readonly) NSArray *images;

/**
 * Create an image containing the initial setup of the map.
 * Useful for testing purposes.
 *
 * @return An AMKImage
 */
- (AMKImage *)overviewRender;

@end

/**
 * @brief A direction within a sprite set. Contains animation frames.
 */
@interface AMKSpriteSetDirection : NSObject

/// Custom name of the direction
@property (copy) NSString *name;

/// Array of frames of class AMKSpriteSetFrame.
@property (strong) NSArray *frames;

@end

/**
 * @brief A frame within the direction of a sprite set. Contains image-references.
 */
@interface AMKSpriteSetFrame : NSObject

/// Index of the image used in this frame
@property (assign) unsigned int index;

/// Animation delay to the next frame. Delay in Frames
@property (assign) unsigned int animationDelay;

@end
