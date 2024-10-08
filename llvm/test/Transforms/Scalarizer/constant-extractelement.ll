; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt %s -passes='function(scalarizer<load-store>,dce)' -S | FileCheck --check-prefixes=ALL %s

target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"

; Test that constant extracts are nicely scalarized
define i32 @f1(ptr %src, i32 %index) {
; ALL-LABEL: @f1(
; ALL-NEXT:    [[SRC_I3:%.*]] = getelementptr i32, ptr [[SRC:%.*]], i32 3
; ALL-NEXT:    [[VAL0_I3:%.*]] = load i32, ptr [[SRC_I3]], align 4
; ALL-NEXT:    [[VAL1_I3:%.*]] = shl i32 4, [[VAL0_I3]]
; ALL-NEXT:    ret i32 [[VAL1_I3]]
;
  %val0 = load <4 x i32> , ptr %src
  %val1 = shl <4 x i32> <i32 1, i32 2, i32 3, i32 4>, %val0
  %val2 = extractelement <4 x i32> %val1, i32 3
  ret i32 %val2
}
