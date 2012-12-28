#import <Cocoa/Cocoa.h>
#import <objc/runtime.h>

#import <getopt.h>
#import <fcntl.h>
#import <stdio.h>
#import <string.h>
#import <stdlib.h>
#import <unistd.h>
#import <errno.h>
#import <sys/stat.h>

/*
    gcc -Wmost -arch x86_64 -arch i386 -dead_strip -isysroot /Developer/SDKs/MacOSX10.6.sdk -Os "$TM_FILEPATH" -o "$TM_SUPPORT_PATH/bin/inspectClass" -framework Foundation
*/

enum {
	kClassMethods,
	kInstanceMethods
};

void DeconstructClass(Class aClass, unsigned methodType)
{
	unsigned int i, nmethods = 0;
	Class class = aClass;

	if (methodType == kClassMethods)
		class = object_getClass(aClass);

	Method *methods = class_copyMethodList(class, &nmethods);

	if (methods)
		for (i = 0; i < nmethods; i++)
			printf("%s\n", sel_getName(method_getName(methods[i])));

	class = class_getSuperclass(aClass);
	if (class != nil)
		DeconstructClass(class, methodType);
}

void usage ()
{
	fprintf(stderr, 
		"Usage: inspectClass -[ci] -n class_name\n"
		"-c, --classmethods 	list class methods\n"
		"-i, --instancemethods	list instance methods\n"
		"-i, --classname	name of class to inspect\n"
		"-f, --framework	name of framework to inspect\n"
		"\n"
		"");
}

int main (int argc, char* argv[])
{
	unsigned methodType = kInstanceMethods;

	NSAutoreleasePool *pool = [NSAutoreleasePool new];
	extern int optind;
	extern char *optarg;
	static struct option longopts[] = {	
		{ "classmethods",	no_argument,		0,		'c'	},
		{ "instancemethods",	no_argument,		0,		'i'	},
		{ "classname",		required_argument,	0,		'n'	},
		{ "framework", 		required_argument,	0,		'f'	},
		{ 0,			0,			0,		0	}
	};

	char const *token = NULL;
	char const *framework = NULL;
	char ch;

	int res = -1;

	while ((ch = getopt_long(argc, argv, "cin:f:", longopts, NULL)) != -1) {
		switch(ch) {
		case 'c':	methodType = kClassMethods;	break;
		case 'i':	methodType = kInstanceMethods;	break;
		case 'n':	token = optarg;	res = 0;	break;
		case 'f':	framework = optarg; 		break;
		default:	usage();			break;
		}
	}

	if (framework) {
		NSString *aString = [@"/System/Library/Frameworks/" 
			stringByAppendingString:
		[[NSString stringWithUTF8String:framework] stringByAppendingPathExtension:@"framework"]];
		//NSLog(@"%@", aString );
		NSBundle * b1 = [NSBundle bundleWithPath:aString];
		[b1 load];
	}

	if (res == 0) {
		Class aClass = NSClassFromString([NSString stringWithUTF8String:token]);
		if(aClass != nil)
			DeconstructClass(aClass, methodType);
	} else {
		usage();
	}

	[pool release];
	return res;
}

