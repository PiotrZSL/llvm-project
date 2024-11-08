; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -O3                   -S < %s  | FileCheck %s
; RUN: opt -passes="default<O3>" -S < %s  | FileCheck %s

target triple = "x86_64--"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

; PR41813 - https://bugs.llvm.org/show_bug.cgi?id=41813

define <4 x float> @hadd_reverse_v4f32(<4 x float> %a, <4 x float> %b) #0 {
; CHECK-LABEL: @hadd_reverse_v4f32(
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <4 x float> [[A:%.*]], <4 x float> [[B:%.*]], <4 x i32> <i32 3, i32 1, i32 7, i32 5>
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <4 x float> [[A]], <4 x float> [[B]], <4 x i32> <i32 2, i32 0, i32 6, i32 4>
; CHECK-NEXT:    [[TMP3:%.*]] = fadd <4 x float> [[TMP1]], [[TMP2]]
; CHECK-NEXT:    ret <4 x float> [[TMP3]]
;
  %shuffle = shufflevector <4 x float> %a, <4 x float> %a, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  %shuffle1 = shufflevector <4 x float> %b, <4 x float> %b, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  %vecext = extractelement <4 x float> %shuffle, i32 0
  %vecext2 = extractelement <4 x float> %shuffle, i32 1
  %add = fadd float %vecext, %vecext2
  %vecinit = insertelement <4 x float> undef, float %add, i32 0
  %vecext3 = extractelement <4 x float> %shuffle, i32 2
  %vecext4 = extractelement <4 x float> %shuffle, i32 3
  %add5 = fadd float %vecext3, %vecext4
  %vecinit6 = insertelement <4 x float> %vecinit, float %add5, i32 1
  %vecext7 = extractelement <4 x float> %shuffle1, i32 0
  %vecext8 = extractelement <4 x float> %shuffle1, i32 1
  %add9 = fadd float %vecext7, %vecext8
  %vecinit10 = insertelement <4 x float> %vecinit6, float %add9, i32 2
  %vecext11 = extractelement <4 x float> %shuffle1, i32 2
  %vecext12 = extractelement <4 x float> %shuffle1, i32 3
  %add13 = fadd float %vecext11, %vecext12
  %vecinit14 = insertelement <4 x float> %vecinit10, float %add13, i32 3
  ret <4 x float> %vecinit14
}

define <4 x float> @reverse_hadd_v4f32(<4 x float> %a, <4 x float> %b) #0 {
; CHECK-LABEL: @reverse_hadd_v4f32(
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <4 x float> [[B:%.*]], <4 x float> [[A:%.*]], <4 x i32> <i32 2, i32 0, i32 6, i32 4>
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <4 x float> [[B]], <4 x float> [[A]], <4 x i32> <i32 3, i32 1, i32 7, i32 5>
; CHECK-NEXT:    [[TMP3:%.*]] = fadd <4 x float> [[TMP1]], [[TMP2]]
; CHECK-NEXT:    ret <4 x float> [[TMP3]]
;
  %vecext = extractelement <4 x float> %a, i32 0
  %vecext1 = extractelement <4 x float> %a, i32 1
  %add = fadd float %vecext, %vecext1
  %vecinit = insertelement <4 x float> undef, float %add, i32 0
  %vecext2 = extractelement <4 x float> %a, i32 2
  %vecext3 = extractelement <4 x float> %a, i32 3
  %add4 = fadd float %vecext2, %vecext3
  %vecinit5 = insertelement <4 x float> %vecinit, float %add4, i32 1
  %vecext6 = extractelement <4 x float> %b, i32 0
  %vecext7 = extractelement <4 x float> %b, i32 1
  %add8 = fadd float %vecext6, %vecext7
  %vecinit9 = insertelement <4 x float> %vecinit5, float %add8, i32 2
  %vecext10 = extractelement <4 x float> %b, i32 2
  %vecext11 = extractelement <4 x float> %b, i32 3
  %add12 = fadd float %vecext10, %vecext11
  %vecinit13 = insertelement <4 x float> %vecinit9, float %add12, i32 3
  %shuffle = shufflevector <4 x float> %vecinit13, <4 x float> %a, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  ret <4 x float> %shuffle
}

define <8 x float> @hadd_reverse_v8f32(<8 x float> %a, <8 x float> %b) #0 {
; CHECK-LABEL: @hadd_reverse_v8f32(
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <8 x float> [[A:%.*]], <8 x float> [[B:%.*]], <8 x i32> <i32 7, i32 5, i32 15, i32 13, i32 3, i32 1, i32 11, i32 9>
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <8 x float> [[A]], <8 x float> [[B]], <8 x i32> <i32 6, i32 4, i32 14, i32 12, i32 2, i32 0, i32 10, i32 8>
; CHECK-NEXT:    [[TMP3:%.*]] = fadd <8 x float> [[TMP1]], [[TMP2]]
; CHECK-NEXT:    ret <8 x float> [[TMP3]]
;
  %shuffle = shufflevector <8 x float> %a, <8 x float> %a, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  %shuffle1 = shufflevector <8 x float> %b, <8 x float> %b, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  %vecext = extractelement <8 x float> %shuffle, i32 0
  %vecext2 = extractelement <8 x float> %shuffle, i32 1
  %add = fadd float %vecext, %vecext2
  %vecinit = insertelement <8 x float> undef, float %add, i32 0
  %vecext3 = extractelement <8 x float> %shuffle, i32 2
  %vecext4 = extractelement <8 x float> %shuffle, i32 3
  %add5 = fadd float %vecext3, %vecext4
  %vecinit6 = insertelement <8 x float> %vecinit, float %add5, i32 1
  %vecext7 = extractelement <8 x float> %shuffle1, i32 0
  %vecext8 = extractelement <8 x float> %shuffle1, i32 1
  %add9 = fadd float %vecext7, %vecext8
  %vecinit10 = insertelement <8 x float> %vecinit6, float %add9, i32 2
  %vecext11 = extractelement <8 x float> %shuffle1, i32 2
  %vecext12 = extractelement <8 x float> %shuffle1, i32 3
  %add13 = fadd float %vecext11, %vecext12
  %vecinit14 = insertelement <8 x float> %vecinit10, float %add13, i32 3
  %vecext15 = extractelement <8 x float> %shuffle, i32 4
  %vecext16 = extractelement <8 x float> %shuffle, i32 5
  %add17 = fadd float %vecext15, %vecext16
  %vecinit18 = insertelement <8 x float> %vecinit14, float %add17, i32 4
  %vecext19 = extractelement <8 x float> %shuffle, i32 6
  %vecext20 = extractelement <8 x float> %shuffle, i32 7
  %add21 = fadd float %vecext19, %vecext20
  %vecinit22 = insertelement <8 x float> %vecinit18, float %add21, i32 5
  %vecext23 = extractelement <8 x float> %shuffle1, i32 4
  %vecext24 = extractelement <8 x float> %shuffle1, i32 5
  %add25 = fadd float %vecext23, %vecext24
  %vecinit26 = insertelement <8 x float> %vecinit22, float %add25, i32 6
  %vecext27 = extractelement <8 x float> %shuffle1, i32 6
  %vecext28 = extractelement <8 x float> %shuffle1, i32 7
  %add29 = fadd float %vecext27, %vecext28
  %vecinit30 = insertelement <8 x float> %vecinit26, float %add29, i32 7
  ret <8 x float> %vecinit30
}

define <8 x float> @reverse_hadd_v8f32(<8 x float> %a, <8 x float> %b) #0 {
; CHECK-LABEL: @reverse_hadd_v8f32(
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <8 x float> [[A:%.*]], <8 x float> [[B:%.*]], <8 x i32> <i32 14, i32 12, i32 6, i32 4, i32 10, i32 8, i32 2, i32 0>
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <8 x float> [[A]], <8 x float> [[B]], <8 x i32> <i32 15, i32 13, i32 7, i32 5, i32 11, i32 9, i32 3, i32 1>
; CHECK-NEXT:    [[TMP3:%.*]] = fadd <8 x float> [[TMP1]], [[TMP2]]
; CHECK-NEXT:    ret <8 x float> [[TMP3]]
;
  %vecext = extractelement <8 x float> %a, i32 0
  %vecext1 = extractelement <8 x float> %a, i32 1
  %add = fadd float %vecext, %vecext1
  %vecinit = insertelement <8 x float> undef, float %add, i32 0
  %vecext2 = extractelement <8 x float> %a, i32 2
  %vecext3 = extractelement <8 x float> %a, i32 3
  %add4 = fadd float %vecext2, %vecext3
  %vecinit5 = insertelement <8 x float> %vecinit, float %add4, i32 1
  %vecext6 = extractelement <8 x float> %b, i32 0
  %vecext7 = extractelement <8 x float> %b, i32 1
  %add8 = fadd float %vecext6, %vecext7
  %vecinit9 = insertelement <8 x float> %vecinit5, float %add8, i32 2
  %vecext10 = extractelement <8 x float> %b, i32 2
  %vecext11 = extractelement <8 x float> %b, i32 3
  %add12 = fadd float %vecext10, %vecext11
  %vecinit13 = insertelement <8 x float> %vecinit9, float %add12, i32 3
  %vecext14 = extractelement <8 x float> %a, i32 4
  %vecext15 = extractelement <8 x float> %a, i32 5
  %add16 = fadd float %vecext14, %vecext15
  %vecinit17 = insertelement <8 x float> %vecinit13, float %add16, i32 4
  %vecext18 = extractelement <8 x float> %a, i32 6
  %vecext19 = extractelement <8 x float> %a, i32 7
  %add20 = fadd float %vecext18, %vecext19
  %vecinit21 = insertelement <8 x float> %vecinit17, float %add20, i32 5
  %vecext22 = extractelement <8 x float> %b, i32 4
  %vecext23 = extractelement <8 x float> %b, i32 5
  %add24 = fadd float %vecext22, %vecext23
  %vecinit25 = insertelement <8 x float> %vecinit21, float %add24, i32 6
  %vecext26 = extractelement <8 x float> %b, i32 6
  %vecext27 = extractelement <8 x float> %b, i32 7
  %add28 = fadd float %vecext26, %vecext27
  %vecinit29 = insertelement <8 x float> %vecinit25, float %add28, i32 7
  %shuffle = shufflevector <8 x float> %vecinit29, <8 x float> %a, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  ret <8 x float> %shuffle
}

attributes #0 = { "min-legal-vector-width"="128" "target-cpu"="btver2" "target-features"="+avx,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3" }
