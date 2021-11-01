//
//  YZDebugTools.h
//  YZDebugTools
//
//  Created by sunyazhou on 2021/11/1.
//

#ifndef YZDebugTools_h
#define YZDebugTools_h

#define WEAK_REF(obj) __weak __typeof__(obj) weak_##obj = obj
#define STRONG_REF(obj) __strong __typeof__(weak_##obj) obj = weak_##obj

#define WS WEAK_REF(self);

#define SS \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong __typeof__(weak_self) self = weak_self; \
_Pragma("clang diagnostic pop")

#endif /* YZDebugTools_h */
