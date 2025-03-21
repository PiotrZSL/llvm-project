; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -S --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mattr=+v < %s | FileCheck %s

define void @test() {
; CHECK-LABEL: define void @test(
; CHECK-SAME: ) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[TMP0:%.*]] = call <4 x i16> @llvm.experimental.vp.strided.load.v4i16.p0.i64(ptr align 2 null, i64 6, <4 x i1> splat (i1 true), i32 4)
; CHECK-NEXT:    [[TMP1:%.*]] = load i16, ptr null, align 2
; CHECK-NEXT:    [[TMP2:%.*]] = xor <4 x i16> [[TMP0]], zeroinitializer
; CHECK-NEXT:    [[TMP3:%.*]] = call i16 @llvm.vector.reduce.smax.v4i16(<4 x i16> [[TMP2]])
; CHECK-NEXT:    [[TMP4:%.*]] = call i16 @llvm.smax.i16(i16 [[TMP1]], i16 [[TMP3]])
; CHECK-NEXT:    [[TMP5:%.*]] = call i16 @llvm.smax.i16(i16 [[TMP4]], i16 0)
; CHECK-NEXT:    [[TMP6:%.*]] = tail call i16 @llvm.smax.i16(i16 [[TMP5]], i16 0)
; CHECK-NEXT:    ret void
;
entry:
  %0 = load i16, ptr null, align 2
  %1 = xor i16 %0, 0
  %2 = tail call i16 @llvm.smax.i16(i16 %1, i16 %0)
  %3 = tail call i16 @llvm.smax.i16(i16 0, i16 %2)
  %4 = load i16, ptr getelementptr inbounds (i8, ptr null, i64 6), align 2
  %5 = xor i16 %4, 0
  %6 = tail call i16 @llvm.smax.i16(i16 %5, i16 %0)
  %7 = tail call i16 @llvm.smax.i16(i16 %3, i16 %6)
  %8 = load i16, ptr getelementptr (i8, ptr null, i64 12), align 2
  %9 = xor i16 %8, 0
  %10 = tail call i16 @llvm.smax.i16(i16 %9, i16 %0)
  %11 = tail call i16 @llvm.smax.i16(i16 %7, i16 %10)
  %12 = load i16, ptr getelementptr (i8, ptr null, i64 18), align 2
  %13 = xor i16 %12, 0
  %14 = tail call i16 @llvm.smax.i16(i16 %13, i16 %0)
  %15 = tail call i16 @llvm.smax.i16(i16 %11, i16 %14)
  %16 = tail call i16 @llvm.smax.i16(i16 %15, i16 0)
  ret void
}

