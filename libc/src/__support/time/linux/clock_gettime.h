//===--- clock_gettime linux implementation ---------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIBC_SRC___SUPPORT_TIME_LINUX_CLOCK_GETTIME_H
#define LLVM_LIBC_SRC___SUPPORT_TIME_LINUX_CLOCK_GETTIME_H

#include "hdr/types/clockid_t.h"
#include "hdr/types/struct_timespec.h"
#include "src/__support/OSUtil/syscall.h"
#include "src/__support/common.h"
#include "src/__support/error_or.h"
#include "src/__support/macros/config.h"
#include <sys/syscall.h>

namespace LIBC_NAMESPACE_DECL {
namespace internal {
LIBC_INLINE ErrorOr<int> clock_gettime(clockid_t clockid, timespec *ts) {
#if SYS_clock_gettime
  int ret = LIBC_NAMESPACE::syscall_impl<int>(SYS_clock_gettime,
                                              static_cast<long>(clockid),
                                              reinterpret_cast<long>(ts));
#elif defined(SYS_clock_gettime64)
  static_assert(
      sizeof(time_t) == sizeof(int64_t),
      "SYS_clock_gettime64 requires struct timespec with 64-bit members.");
  int ret = LIBC_NAMESPACE::syscall_impl<int>(SYS_clock_gettime64,
                                              static_cast<long>(clockid),
                                              reinterpret_cast<long>(ts));
#else
#error "SYS_clock_gettime and SYS_clock_gettime64 syscalls not available."
#endif
  if (ret < 0)
    return Error(-ret);
  return ret;
}

} // namespace internal
} // namespace LIBC_NAMESPACE_DECL

#endif // LLVM_LIBC_SRC___SUPPORT_TIME_LINUX_CLOCK_GETTIME_H
