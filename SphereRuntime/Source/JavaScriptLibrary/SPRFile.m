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

#import "SPRFile.h"
#import "NSString+SRKUtilities.h"
#import "SPRFileSystem.h"
#import "NSString+SPRHashing.h"

@implementation SPRFile {
	NSMutableDictionary *_storage;
}

@synthesize path=_path;

- (instancetype)init
{
	NSArray *arguments = [L8Context currentArguments];

	if(arguments.count < 1)
		return nil;

	return [self initWithPath:[(L8Value *)arguments[0] toString]];
}

- (instancetype)initWithPath:(NSString *)path
{
	self = [super init];
	if(self) {
		_path = [path copy];

		// TODO: use some resource manager to find the correct path
		if(![self loadFileAtPath:_path])
			return nil;
	}
	return self;
}

- (BOOL)loadFileAtPath:(NSString *)path
{
	NSString *fileContents;
	NSError *error = NULL;
	NSArray *fileLines;
	NSCharacterSet *lineSplitSet;

	if(![[NSFileManager defaultManager] fileExistsAtPath:path]) {
		_storage = [[NSMutableDictionary alloc] init];
		return YES;
	}

	fileContents = [NSString stringWithContentsOfFile:path
											 encoding:NSUTF8StringEncoding
												error:&error];
	if(!fileContents) {
		NSLog(@"Failed to open file: %@",error);
		return NO;
	}

	// Split the lines
	lineSplitSet = [NSCharacterSet newlineCharacterSet];
	fileLines = [fileContents componentsSeparatedByCharactersInSet:lineSplitSet];

	// Create some storage
	_storage = [NSMutableDictionary dictionary];

	// For each line, find the key-value pair and store it
	for(NSString *line in fileLines) {
		NSString *tline, *key, *value;
		NSRange loc;

		tline = [line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		if(tline.length == 0 || [tline hasPrefix:@"#"])
			continue;

		loc = [tline rangeOfString:@"="];
		if(loc.location == NSNotFound)
			continue;

		key = [[tline substringToIndex:loc.location] srk_stringByTrimmingWhitespace];
		value = [[tline substringFromIndex:loc.location+1] srk_stringByTrimmingWhitespace];

		if(key.length == 0 || value.length == 0)
			continue;

		_storage[key] = value;
	}

	return YES;
}

- (BOOL)saveFileToPath:(NSString *)path
{
	NSString *fileContents;
	NSError *error = NULL;

	fileContents = [self stringForContents];

	/*if(![[NSFileManager defaultManager] fileExistsAtPath:path]) {
		return [[NSFileManager defaultManager] createFileAtPath:path
													   contents:_data
													 attributes:nil];
	}*/

	if(![fileContents writeToFile:path
					   atomically:YES
						 encoding:NSUTF8StringEncoding
							error:&error]) {
		NSLog(@"Failed to write file: %@",error);
		return NO;
	}

	return YES;
}

- (NSString *)stringForContents
{
	NSMutableString *fileContents;

	fileContents = [NSMutableString string];

	[_storage enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSObject *obj, BOOL *stop) {
		[fileContents appendFormat:@"%@=%@\n",key,obj];
	}];

	return fileContents;
}

- (size_t)size
{
	return _storage.count;
}

- (NSString *)readKey:(NSString *)key withDefault:(NSString *)def
{
	NSString *val = _storage[key];
	return (val == nil)?def:val;
}

- (void)writeKey:(NSString *)key value:(NSString *)value
{
	_storage[key] = value;
}

- (NSArray *)keys
{
	return [_storage allKeys];
}

- (BOOL)hasKey:(NSString *)key
{
	return _storage[key] != nil;
}

- (void)flush
{
	[self saveFileToPath:_path];
}

- (void)close
{
	[self flush];
}

- (NSString *)md5hash
{
	return [[self stringForContents] md5];
}

- (NSString *)sha1hash
{
	return [[self stringForContents] sha1];
}

- (NSString *)sha256hash
{
	return [[self stringForContents] sha256];
}

- (BOOL)renameTo:(NSString *)newName
{
	if([SPRFileSystem renameItemAtPath:_path
								toPath:newName]) {
		_path = newName;
		return YES;
	}

	return NO;
}

- (BOOL)remove
{
	return [SPRFileSystem removeItemAtPath:_path];
}

@end