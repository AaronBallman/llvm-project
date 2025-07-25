; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=arm64-apple-ios -o - %s | FileCheck %s

define <16 x i32> @no_existing_zext(<16 x i8> %a, <16 x i32> %op) {
; CHECK-LABEL: no_existing_zext:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    movi.16b v5, #10
; CHECK-NEXT:    cmhi.16b v0, v0, v5
; CHECK-NEXT:    sshll.8h v5, v0, #0
; CHECK-NEXT:    sshll2.8h v0, v0, #0
; CHECK-NEXT:    sshll2.4s v16, v0, #0
; CHECK-NEXT:    sshll.4s v6, v5, #0
; CHECK-NEXT:    sshll.4s v7, v0, #0
; CHECK-NEXT:    sshll2.4s v5, v5, #0
; CHECK-NEXT:    and.16b v4, v16, v4
; CHECK-NEXT:    and.16b v0, v6, v1
; CHECK-NEXT:    and.16b v1, v5, v2
; CHECK-NEXT:    and.16b v2, v7, v3
; CHECK-NEXT:    mov.16b v3, v4
; CHECK-NEXT:    ret
entry:
  %cmp = icmp ugt <16 x i8> %a, <i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10>
  %sel = select <16 x i1> %cmp, <16 x i32> %op, <16 x i32> zeroinitializer
  ret <16 x i32> %sel
}

define <16 x i32> @second_compare_operand_not_splat(<16 x i8> %a, <16 x i8> %b) {
; CHECK-LABEL: second_compare_operand_not_splat:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    cmgt.16b v1, v0, v1
; CHECK-NEXT:    ushll.8h v2, v0, #0
; CHECK-NEXT:    ushll2.8h v0, v0, #0
; CHECK-NEXT:    sshll.8h v3, v1, #0
; CHECK-NEXT:    sshll2.8h v1, v1, #0
; CHECK-NEXT:    ushll.4s v4, v2, #0
; CHECK-NEXT:    ushll.4s v5, v0, #0
; CHECK-NEXT:    ushll2.4s v2, v2, #0
; CHECK-NEXT:    ushll2.4s v6, v0, #0
; CHECK-NEXT:    sshll.4s v0, v3, #0
; CHECK-NEXT:    sshll.4s v7, v1, #0
; CHECK-NEXT:    sshll2.4s v16, v3, #0
; CHECK-NEXT:    sshll2.4s v1, v1, #0
; CHECK-NEXT:    and.16b v0, v0, v4
; CHECK-NEXT:    and.16b v3, v1, v6
; CHECK-NEXT:    and.16b v1, v16, v2
; CHECK-NEXT:    and.16b v2, v7, v5
; CHECK-NEXT:    ret
entry:
  %ext = zext <16 x i8> %a to <16 x i32>
  %cmp = icmp sgt <16 x i8> %a, %b
  %sel = select <16 x i1> %cmp, <16 x i32> %ext, <16 x i32> zeroinitializer
  ret <16 x i32> %sel
}

define <16 x i32> @same_zext_used_in_cmp_signed_pred_and_select(<16 x i8> %a) {
; CHECK-LABEL: same_zext_used_in_cmp_signed_pred_and_select:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    movi.16b v1, #10
; CHECK-NEXT:    ushll.8h v2, v0, #0
; CHECK-NEXT:    ushll.4s v4, v2, #0
; CHECK-NEXT:    ushll2.4s v2, v2, #0
; CHECK-NEXT:    cmgt.16b v1, v0, v1
; CHECK-NEXT:    ushll2.8h v0, v0, #0
; CHECK-NEXT:    sshll.8h v3, v1, #0
; CHECK-NEXT:    sshll2.8h v1, v1, #0
; CHECK-NEXT:    ushll.4s v5, v0, #0
; CHECK-NEXT:    ushll2.4s v6, v0, #0
; CHECK-NEXT:    sshll.4s v0, v3, #0
; CHECK-NEXT:    sshll.4s v7, v1, #0
; CHECK-NEXT:    sshll2.4s v16, v3, #0
; CHECK-NEXT:    sshll2.4s v1, v1, #0
; CHECK-NEXT:    and.16b v0, v0, v4
; CHECK-NEXT:    and.16b v3, v1, v6
; CHECK-NEXT:    and.16b v1, v16, v2
; CHECK-NEXT:    and.16b v2, v7, v5
; CHECK-NEXT:    ret
entry:
  %ext = zext <16 x i8> %a to <16 x i32>
  %cmp = icmp sgt <16 x i8> %a, <i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10>
  %sel = select <16 x i1> %cmp, <16 x i32> %ext, <16 x i32> zeroinitializer
  ret <16 x i32> %sel
}

define <8 x i64> @same_zext_used_in_cmp_unsigned_pred_and_select_v8i64(<8 x i8> %a) {
; CHECK-LABEL: same_zext_used_in_cmp_unsigned_pred_and_select_v8i64:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ushll.8h v0, v0, #0
; CHECK-NEXT:    mov w8, #10 ; =0xa
; CHECK-NEXT:    dup.2d v2, x8
; CHECK-NEXT:    ushll.4s v1, v0, #0
; CHECK-NEXT:    ushll2.4s v0, v0, #0
; CHECK-NEXT:    ushll.2d v3, v1, #0
; CHECK-NEXT:    ushll2.2d v4, v0, #0
; CHECK-NEXT:    ushll2.2d v1, v1, #0
; CHECK-NEXT:    ushll.2d v5, v0, #0
; CHECK-NEXT:    cmhi.2d v0, v3, v2
; CHECK-NEXT:    cmhi.2d v7, v1, v2
; CHECK-NEXT:    cmhi.2d v6, v5, v2
; CHECK-NEXT:    cmhi.2d v2, v4, v2
; CHECK-NEXT:    and.16b v0, v0, v3
; CHECK-NEXT:    and.16b v1, v7, v1
; CHECK-NEXT:    and.16b v3, v2, v4
; CHECK-NEXT:    and.16b v2, v6, v5
; CHECK-NEXT:    ret
  %ext = zext <8 x i8> %a to <8 x i64>
  %cmp = icmp ugt <8 x i8> %a, <i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10>
  %sel = select <8 x i1> %cmp, <8 x i64> %ext, <8 x i64> zeroinitializer
  ret <8 x i64> %sel
}


define <16 x i32> @same_zext_used_in_cmp_unsigned_pred_and_select_v16i32(<16 x i8> %a) {
; CHECK-LABEL: same_zext_used_in_cmp_unsigned_pred_and_select_v16i32:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ushll.8h v2, v0, #0
; CHECK-NEXT:    ushll2.8h v0, v0, #0
; CHECK-NEXT:    movi.4s v1, #10
; CHECK-NEXT:    ushll.4s v3, v2, #0
; CHECK-NEXT:    ushll2.4s v4, v0, #0
; CHECK-NEXT:    ushll2.4s v2, v2, #0
; CHECK-NEXT:    ushll.4s v5, v0, #0
; CHECK-NEXT:    cmhi.4s v0, v3, v1
; CHECK-NEXT:    cmhi.4s v7, v2, v1
; CHECK-NEXT:    cmhi.4s v6, v5, v1
; CHECK-NEXT:    cmhi.4s v1, v4, v1
; CHECK-NEXT:    and.16b v0, v0, v3
; CHECK-NEXT:    and.16b v3, v1, v4
; CHECK-NEXT:    and.16b v1, v7, v2
; CHECK-NEXT:    and.16b v2, v6, v5
; CHECK-NEXT:    ret
  %ext = zext <16 x i8> %a to <16 x i32>
  %cmp = icmp ugt <16 x i8> %a, <i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10>
  %sel = select <16 x i1> %cmp, <16 x i32> %ext, <16 x i32> zeroinitializer
  ret <16 x i32> %sel
}

define <8 x i32> @same_zext_used_in_cmp_unsigned_pred_and_select_v8i32(<8 x i8> %a) {
; CHECK-LABEL: same_zext_used_in_cmp_unsigned_pred_and_select_v8i32:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ushll.8h v0, v0, #0
; CHECK-NEXT:    movi.4s v1, #10
; CHECK-NEXT:    ushll2.4s v2, v0, #0
; CHECK-NEXT:    ushll.4s v0, v0, #0
; CHECK-NEXT:    cmhi.4s v3, v0, v1
; CHECK-NEXT:    cmhi.4s v1, v2, v1
; CHECK-NEXT:    and.16b v1, v1, v2
; CHECK-NEXT:    and.16b v0, v3, v0
; CHECK-NEXT:    ret
  %ext = zext <8 x i8> %a to <8 x i32>
  %cmp = icmp ugt <8 x i8> %a, <i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10>
  %sel = select <8 x i1> %cmp, <8 x i32> %ext, <8 x i32> zeroinitializer
  ret <8 x i32> %sel
}

define <8 x i32> @same_zext_used_in_cmp_unsigned_pred_and_select_v8i32_2(<8 x i16> %a) {
; CHECK-LABEL: same_zext_used_in_cmp_unsigned_pred_and_select_v8i32_2:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    movi.4s v1, #10
; CHECK-NEXT:    ushll2.4s v2, v0, #0
; CHECK-NEXT:    ushll.4s v0, v0, #0
; CHECK-NEXT:    cmhi.4s v3, v0, v1
; CHECK-NEXT:    cmhi.4s v1, v2, v1
; CHECK-NEXT:    and.16b v1, v1, v2
; CHECK-NEXT:    and.16b v0, v3, v0
; CHECK-NEXT:    ret
  %ext = zext <8 x i16> %a to <8 x i32>
  %cmp = icmp ugt <8 x i16> %a, <i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10>
  %sel = select <8 x i1> %cmp, <8 x i32> %ext, <8 x i32> zeroinitializer
  ret <8 x i32> %sel
}


define <8 x i32> @same_zext_used_in_cmp_unsigned_pred_and_select_v8i32_from_v8i15(<8 x i15> %a) {
; CHECK-LABEL: same_zext_used_in_cmp_unsigned_pred_and_select_v8i32_from_v8i15:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    bic.8h v0, #128, lsl #8
; CHECK-NEXT:    movi.4s v1, #10
; CHECK-NEXT:    ushll2.4s v2, v0, #0
; CHECK-NEXT:    ushll.4s v0, v0, #0
; CHECK-NEXT:    cmhi.4s v3, v0, v1
; CHECK-NEXT:    cmhi.4s v1, v2, v1
; CHECK-NEXT:    and.16b v1, v1, v2
; CHECK-NEXT:    and.16b v0, v3, v0
; CHECK-NEXT:    ret
  %ext = zext <8 x i15> %a to <8 x i32>
  %cmp = icmp ugt <8 x i15> %a, <i15 10, i15 10, i15 10, i15 10, i15 10, i15 10, i15 10, i15 10>
  %sel = select <8 x i1> %cmp, <8 x i32> %ext, <8 x i32> zeroinitializer
  ret <8 x i32> %sel
}

define <7 x i32> @same_zext_used_in_cmp_unsigned_pred_and_select_v7i32(<7 x i16> %a) {
; CHECK-LABEL: same_zext_used_in_cmp_unsigned_pred_and_select_v7i32:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    movi.8h v1, #10
; CHECK-NEXT:    ushll.4s v2, v0, #0
; CHECK-NEXT:    cmhi.8h v1, v0, v1
; CHECK-NEXT:    ushll2.4s v0, v0, #0
; CHECK-NEXT:    sshll.4s v3, v1, #0
; CHECK-NEXT:    sshll2.4s v1, v1, #0
; CHECK-NEXT:    and.16b v2, v3, v2
; CHECK-NEXT:    and.16b v0, v1, v0
; CHECK-NEXT:    mov.s w1, v2[1]
; CHECK-NEXT:    mov.s w2, v2[2]
; CHECK-NEXT:    mov.s w3, v2[3]
; CHECK-NEXT:    mov.s w5, v0[1]
; CHECK-NEXT:    mov.s w6, v0[2]
; CHECK-NEXT:    fmov w0, s2
; CHECK-NEXT:    fmov w4, s0
; CHECK-NEXT:    ret
  %ext = zext <7 x i16> %a to <7 x i32>
  %cmp = icmp ugt <7 x i16> %a, <i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10>
  %sel = select <7 x i1> %cmp, <7 x i32> %ext, <7 x i32> zeroinitializer
  ret <7 x i32> %sel
}

define <3 x i32> @same_zext_used_in_cmp_unsigned_pred_and_select_v3i16(<3 x i8> %a) {
; CHECK-LABEL: same_zext_used_in_cmp_unsigned_pred_and_select_v3i16:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    fmov s0, w0
; CHECK-NEXT:  Lloh0:
; CHECK-NEXT:    adrp x8, lCPI9_0@PAGE
; CHECK-NEXT:    movi.2d v3, #0x0000ff000000ff
; CHECK-NEXT:  Lloh1:
; CHECK-NEXT:    ldr d2, [x8, lCPI9_0@PAGEOFF]
; CHECK-NEXT:    mov.h v0[1], w1
; CHECK-NEXT:    mov.h v0[2], w2
; CHECK-NEXT:    ushll.4s v1, v0, #0
; CHECK-NEXT:    bic.4h v0, #255, lsl #8
; CHECK-NEXT:    cmhi.4h v0, v0, v2
; CHECK-NEXT:    and.16b v1, v1, v3
; CHECK-NEXT:    sshll.4s v0, v0, #0
; CHECK-NEXT:    and.16b v0, v1, v0
; CHECK-NEXT:    ret
; CHECK-NEXT:    .loh AdrpLdr Lloh0, Lloh1
  %ext = zext <3 x i8> %a to <3 x i32>
  %cmp = icmp ugt <3 x i8> %a, <i8 10, i8 10, i8 10>
  %sel = select <3 x i1> %cmp, <3 x i32> %ext, <3 x i32> zeroinitializer
  ret <3 x i32> %sel
}

define <4 x i32> @same_zext_used_in_cmp_unsigned_pred_and_select_v4i32(<4 x i16> %a) {
; CHECK-LABEL: same_zext_used_in_cmp_unsigned_pred_and_select_v4i32:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    movi.4s v1, #10
; CHECK-NEXT:    ushll.4s v0, v0, #0
; CHECK-NEXT:    cmhi.4s v1, v0, v1
; CHECK-NEXT:    and.16b v0, v1, v0
; CHECK-NEXT:    ret
  %ext = zext <4 x i16> %a to <4 x i32>
  %cmp = icmp ugt <4 x i16> %a, <i16 10, i16 10, i16 10, i16 10>
  %sel = select <4 x i1> %cmp, <4 x i32> %ext, <4 x i32> zeroinitializer
  ret <4 x i32> %sel
}

define <2 x i32> @same_zext_used_in_cmp_unsigned_pred_and_select_v2i32(<2 x i16> %a) {
; CHECK-LABEL: same_zext_used_in_cmp_unsigned_pred_and_select_v2i32:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    movi d1, #0x00ffff0000ffff
; CHECK-NEXT:    movi.2s v2, #10
; CHECK-NEXT:    and.8b v0, v0, v1
; CHECK-NEXT:    cmhi.2s v1, v0, v2
; CHECK-NEXT:    and.8b v0, v1, v0
; CHECK-NEXT:    ret
  %ext = zext <2 x i16> %a to <2 x i32>
  %cmp = icmp ugt <2 x i16> %a, <i16 10, i16 10>
  %sel = select <2 x i1> %cmp, <2 x i32> %ext, <2 x i32> zeroinitializer
  ret <2 x i32> %sel
}

define <8 x i32> @same_zext_used_in_cmp_eq_and_select_v8i32(<8 x i16> %a) {
; CHECK-LABEL: same_zext_used_in_cmp_eq_and_select_v8i32:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    movi.4s v1, #10
; CHECK-NEXT:    ushll2.4s v2, v0, #0
; CHECK-NEXT:    ushll.4s v0, v0, #0
; CHECK-NEXT:    cmeq.4s v3, v0, v1
; CHECK-NEXT:    cmeq.4s v1, v2, v1
; CHECK-NEXT:    and.16b v1, v1, v2
; CHECK-NEXT:    and.16b v0, v3, v0
; CHECK-NEXT:    ret
  %ext = zext <8 x i16> %a to <8 x i32>
  %cmp = icmp eq <8 x i16> %a, <i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10>
  %sel = select <8 x i1> %cmp, <8 x i32> %ext, <8 x i32> zeroinitializer
  ret <8 x i32> %sel
}

define <8 x i32> @same_zext_used_in_cmp_eq_and_select_v8i32_from_v8i13(<8 x i13> %a) {
; CHECK-LABEL: same_zext_used_in_cmp_eq_and_select_v8i32_from_v8i13:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    bic.8h v0, #224, lsl #8
; CHECK-NEXT:    movi.4s v1, #10
; CHECK-NEXT:    ushll2.4s v2, v0, #0
; CHECK-NEXT:    ushll.4s v0, v0, #0
; CHECK-NEXT:    cmeq.4s v3, v0, v1
; CHECK-NEXT:    cmeq.4s v1, v2, v1
; CHECK-NEXT:    and.16b v1, v1, v2
; CHECK-NEXT:    and.16b v0, v3, v0
; CHECK-NEXT:    ret
  %ext = zext <8 x i13> %a to <8 x i32>
  %cmp = icmp eq <8 x i13> %a, <i13 10, i13 10, i13 10, i13 10, i13 10, i13 10, i13 10, i13 10>
  %sel = select <8 x i1> %cmp, <8 x i32> %ext, <8 x i32> zeroinitializer
  ret <8 x i32> %sel
}

define <16 x i32> @same_zext_used_in_cmp_ne_and_select_v8i32(<16 x i8> %a) {
; CHECK-LABEL: same_zext_used_in_cmp_ne_and_select_v8i32:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ushll.8h v2, v0, #0
; CHECK-NEXT:    ushll2.8h v0, v0, #0
; CHECK-NEXT:    movi.4s v1, #10
; CHECK-NEXT:    ushll.4s v3, v2, #0
; CHECK-NEXT:    ushll2.4s v4, v0, #0
; CHECK-NEXT:    ushll2.4s v2, v2, #0
; CHECK-NEXT:    ushll.4s v5, v0, #0
; CHECK-NEXT:    cmeq.4s v0, v3, v1
; CHECK-NEXT:    cmeq.4s v7, v2, v1
; CHECK-NEXT:    cmeq.4s v6, v5, v1
; CHECK-NEXT:    cmeq.4s v1, v4, v1
; CHECK-NEXT:    bic.16b v0, v3, v0
; CHECK-NEXT:    bic.16b v3, v4, v1
; CHECK-NEXT:    bic.16b v1, v2, v7
; CHECK-NEXT:    bic.16b v2, v5, v6
; CHECK-NEXT:    ret
  %ext = zext <16 x i8> %a to <16 x i32>
  %cmp = icmp ne <16 x i8> %a, <i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10>
  %sel = select <16 x i1> %cmp, <16 x i32> %ext, <16 x i32> zeroinitializer
  ret <16 x i32> %sel
}

; A variation of @same_zext_used_in_cmp_unsigned_pred_and_select, with with
; multiple users of the compare.
define <16 x i32> @same_zext_used_in_cmp_unsigned_pred_and_select_other_use(<16 x i8> %a, <16 x i64> %v, ptr %ptr) {
; CHECK-LABEL: same_zext_used_in_cmp_unsigned_pred_and_select_other_use:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    movi.16b v16, #10
; CHECK-NEXT:    ushll.8h v19, v0, #0
; CHECK-NEXT:    ldr q22, [sp]
; CHECK-NEXT:    ushll.4s v24, v19, #0
; CHECK-NEXT:    ushll2.4s v19, v19, #0
; CHECK-NEXT:    cmhi.16b v16, v0, v16
; CHECK-NEXT:    ushll2.8h v0, v0, #0
; CHECK-NEXT:    sshll2.8h v17, v16, #0
; CHECK-NEXT:    sshll.8h v16, v16, #0
; CHECK-NEXT:    ushll.4s v25, v0, #0
; CHECK-NEXT:    ushll2.4s v0, v0, #0
; CHECK-NEXT:    sshll2.4s v18, v17, #0
; CHECK-NEXT:    sshll.4s v17, v17, #0
; CHECK-NEXT:    sshll2.4s v20, v16, #0
; CHECK-NEXT:    sshll.4s v16, v16, #0
; CHECK-NEXT:    sshll2.2d v21, v18, #0
; CHECK-NEXT:    sshll.2d v23, v18, #0
; CHECK-NEXT:    sshll2.2d v26, v17, #0
; CHECK-NEXT:    sshll2.2d v27, v20, #0
; CHECK-NEXT:    and.16b v21, v22, v21
; CHECK-NEXT:    sshll.2d v22, v17, #0
; CHECK-NEXT:    and.16b v7, v7, v23
; CHECK-NEXT:    sshll.2d v23, v20, #0
; CHECK-NEXT:    and.16b v6, v6, v26
; CHECK-NEXT:    sshll2.2d v26, v16, #0
; CHECK-NEXT:    and.16b v27, v4, v27
; CHECK-NEXT:    and.16b v4, v18, v0
; CHECK-NEXT:    and.16b v0, v16, v24
; CHECK-NEXT:    stp q7, q21, [x0, #96]
; CHECK-NEXT:    sshll.2d v21, v16, #0
; CHECK-NEXT:    and.16b v5, v5, v22
; CHECK-NEXT:    and.16b v7, v3, v23
; CHECK-NEXT:    and.16b v3, v20, v19
; CHECK-NEXT:    stp q5, q6, [x0, #64]
; CHECK-NEXT:    and.16b v6, v2, v26
; CHECK-NEXT:    and.16b v2, v17, v25
; CHECK-NEXT:    and.16b v5, v1, v21
; CHECK-NEXT:    mov.16b v1, v3
; CHECK-NEXT:    mov.16b v3, v4
; CHECK-NEXT:    stp q7, q27, [x0, #32]
; CHECK-NEXT:    stp q5, q6, [x0]
; CHECK-NEXT:    ret
entry:
  %ext = zext <16 x i8> %a to <16 x i32>
  %cmp = icmp ugt <16 x i8> %a, <i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10>
  %sel = select <16 x i1> %cmp, <16 x i32> %ext, <16 x i32> zeroinitializer
  %sel.2 = select <16 x i1> %cmp, <16 x i64> %v, <16 x i64> zeroinitializer
  store <16 x i64> %sel.2, ptr %ptr
  ret <16 x i32> %sel
}

define <16 x i32> @same_sext_used_in_cmp_signed_pred_and_select_v16i32(<16 x i8> %a) {
; CHECK-LABEL: same_sext_used_in_cmp_signed_pred_and_select_v16i32:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    sshll.8h v2, v0, #0
; CHECK-NEXT:    sshll2.8h v0, v0, #0
; CHECK-NEXT:    movi.4s v1, #10
; CHECK-NEXT:    sshll.4s v3, v2, #0
; CHECK-NEXT:    sshll2.4s v4, v0, #0
; CHECK-NEXT:    sshll2.4s v2, v2, #0
; CHECK-NEXT:    sshll.4s v5, v0, #0
; CHECK-NEXT:    cmgt.4s v0, v3, v1
; CHECK-NEXT:    cmgt.4s v7, v2, v1
; CHECK-NEXT:    cmgt.4s v6, v5, v1
; CHECK-NEXT:    cmgt.4s v1, v4, v1
; CHECK-NEXT:    and.16b v0, v0, v3
; CHECK-NEXT:    and.16b v3, v1, v4
; CHECK-NEXT:    and.16b v1, v7, v2
; CHECK-NEXT:    and.16b v2, v6, v5
; CHECK-NEXT:    ret
entry:
  %ext = sext <16 x i8> %a to <16 x i32>
  %cmp = icmp sgt <16 x i8> %a, <i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10>
  %sel = select <16 x i1> %cmp, <16 x i32> %ext, <16 x i32> zeroinitializer
  ret <16 x i32> %sel
}

define <8 x i32> @same_sext_used_in_cmp_eq_and_select_v8i32(<8 x i16> %a) {
; CHECK-LABEL: same_sext_used_in_cmp_eq_and_select_v8i32:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    movi.4s v1, #10
; CHECK-NEXT:    sshll2.4s v2, v0, #0
; CHECK-NEXT:    sshll.4s v0, v0, #0
; CHECK-NEXT:    cmeq.4s v3, v0, v1
; CHECK-NEXT:    cmeq.4s v1, v2, v1
; CHECK-NEXT:    and.16b v1, v1, v2
; CHECK-NEXT:    and.16b v0, v3, v0
; CHECK-NEXT:    ret
  %ext = sext <8 x i16> %a to <8 x i32>
  %cmp = icmp eq <8 x i16> %a, <i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10>
  %sel = select <8 x i1> %cmp, <8 x i32> %ext, <8 x i32> zeroinitializer
  ret <8 x i32> %sel
}

define <8 x i32> @same_sext_used_in_cmp_eq_and_select_v8i32_from_v8i13(<8 x i13> %a) {
; CHECK-LABEL: same_sext_used_in_cmp_eq_and_select_v8i32_from_v8i13:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ushll.4s v2, v0, #0
; CHECK-NEXT:    ushll2.4s v0, v0, #0
; CHECK-NEXT:    movi.4s v1, #10
; CHECK-NEXT:    shl.4s v0, v0, #19
; CHECK-NEXT:    shl.4s v2, v2, #19
; CHECK-NEXT:    sshr.4s v0, v0, #19
; CHECK-NEXT:    sshr.4s v2, v2, #19
; CHECK-NEXT:    cmeq.4s v3, v2, v1
; CHECK-NEXT:    cmeq.4s v1, v0, v1
; CHECK-NEXT:    and.16b v1, v1, v0
; CHECK-NEXT:    and.16b v0, v3, v2
; CHECK-NEXT:    ret
  %ext = sext <8 x i13> %a to <8 x i32>
  %cmp = icmp eq <8 x i13> %a, <i13 10, i13 10, i13 10, i13 10, i13 10, i13 10, i13 10, i13 10>
  %sel = select <8 x i1> %cmp, <8 x i32> %ext, <8 x i32> zeroinitializer
  ret <8 x i32> %sel
}

define <16 x i32> @same_sext_used_in_cmp_ne_and_select_v8i32(<16 x i8> %a) {
; CHECK-LABEL: same_sext_used_in_cmp_ne_and_select_v8i32:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    sshll.8h v2, v0, #0
; CHECK-NEXT:    sshll2.8h v0, v0, #0
; CHECK-NEXT:    movi.4s v1, #10
; CHECK-NEXT:    sshll.4s v3, v2, #0
; CHECK-NEXT:    sshll2.4s v4, v0, #0
; CHECK-NEXT:    sshll2.4s v2, v2, #0
; CHECK-NEXT:    sshll.4s v5, v0, #0
; CHECK-NEXT:    cmeq.4s v0, v3, v1
; CHECK-NEXT:    cmeq.4s v7, v2, v1
; CHECK-NEXT:    cmeq.4s v6, v5, v1
; CHECK-NEXT:    cmeq.4s v1, v4, v1
; CHECK-NEXT:    bic.16b v0, v3, v0
; CHECK-NEXT:    bic.16b v3, v4, v1
; CHECK-NEXT:    bic.16b v1, v2, v7
; CHECK-NEXT:    bic.16b v2, v5, v6
; CHECK-NEXT:    ret
  %ext = sext <16 x i8> %a to <16 x i32>
  %cmp = icmp ne <16 x i8> %a, <i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10>
  %sel = select <16 x i1> %cmp, <16 x i32> %ext, <16 x i32> zeroinitializer
  ret <16 x i32> %sel
}

define <8 x i32> @same_sext_used_in_cmp_signed_pred_and_select_v8i32(<8 x i16> %a) {
; CHECK-LABEL: same_sext_used_in_cmp_signed_pred_and_select_v8i32:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    movi.4s v1, #10
; CHECK-NEXT:    sshll2.4s v2, v0, #0
; CHECK-NEXT:    sshll.4s v0, v0, #0
; CHECK-NEXT:    cmgt.4s v3, v0, v1
; CHECK-NEXT:    cmgt.4s v1, v2, v1
; CHECK-NEXT:    and.16b v1, v1, v2
; CHECK-NEXT:    and.16b v0, v3, v0
; CHECK-NEXT:    ret
entry:
  %ext = sext <8 x i16> %a to <8 x i32>
  %cmp = icmp sgt <8 x i16> %a, <i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10>
  %sel = select <8 x i1> %cmp, <8 x i32> %ext, <8 x i32> zeroinitializer
  ret <8 x i32> %sel
}

define <8 x i32> @same_sext_used_in_cmp_unsigned_pred_and_select_v8i32_from_v8i15(<8 x i15> %a) {
; CHECK-LABEL: same_sext_used_in_cmp_unsigned_pred_and_select_v8i32_from_v8i15:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ushll.4s v2, v0, #0
; CHECK-NEXT:    ushll2.4s v0, v0, #0
; CHECK-NEXT:    movi.4s v1, #10
; CHECK-NEXT:    shl.4s v0, v0, #17
; CHECK-NEXT:    shl.4s v2, v2, #17
; CHECK-NEXT:    sshr.4s v0, v0, #17
; CHECK-NEXT:    sshr.4s v2, v2, #17
; CHECK-NEXT:    cmge.4s v3, v2, v1
; CHECK-NEXT:    cmge.4s v1, v0, v1
; CHECK-NEXT:    and.16b v1, v1, v0
; CHECK-NEXT:    and.16b v0, v3, v2
; CHECK-NEXT:    ret
  %ext = sext <8 x i15> %a to <8 x i32>
  %cmp = icmp sge <8 x i15> %a, <i15 10, i15 10, i15 10, i15 10, i15 10, i15 10, i15 10, i15 10>
  %sel = select <8 x i1> %cmp, <8 x i32> %ext, <8 x i32> zeroinitializer
  ret <8 x i32> %sel
}

define <16 x i32> @same_sext_used_in_cmp_unsigned_pred_and_select(<16 x i8> %a) {
; CHECK-LABEL: same_sext_used_in_cmp_unsigned_pred_and_select:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    movi.16b v1, #10
; CHECK-NEXT:    sshll.8h v2, v0, #0
; CHECK-NEXT:    ext.16b v4, v2, v2, #8
; CHECK-NEXT:    cmhi.16b v1, v0, v1
; CHECK-NEXT:    sshll2.8h v0, v0, #0
; CHECK-NEXT:    sshll.8h v3, v1, #0
; CHECK-NEXT:    sshll2.8h v1, v1, #0
; CHECK-NEXT:    ext.16b v5, v0, v0, #8
; CHECK-NEXT:    ext.16b v6, v3, v3, #8
; CHECK-NEXT:    ext.16b v7, v1, v1, #8
; CHECK-NEXT:    and.8b v2, v3, v2
; CHECK-NEXT:    and.8b v1, v1, v0
; CHECK-NEXT:    sshll.4s v0, v2, #0
; CHECK-NEXT:    and.8b v3, v7, v5
; CHECK-NEXT:    and.8b v4, v6, v4
; CHECK-NEXT:    sshll.4s v2, v1, #0
; CHECK-NEXT:    sshll.4s v3, v3, #0
; CHECK-NEXT:    sshll.4s v1, v4, #0
; CHECK-NEXT:    ret
entry:
  %ext = sext <16 x i8> %a to <16 x i32>
  %cmp = icmp ugt <16 x i8> %a, <i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10, i8 10>
  %sel = select <16 x i1> %cmp, <16 x i32> %ext, <16 x i32> zeroinitializer
  ret <16 x i32> %sel
}

define <16 x i32> @same_zext_used_in_cmp_signed_pred_and_select_can_convert_to_unsigned_pred(<16 x i8> %a) {
; CHECK-LABEL: same_zext_used_in_cmp_signed_pred_and_select_can_convert_to_unsigned_pred:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    cmge.16b v1, v0, #0
; CHECK-NEXT:    ushll.8h v2, v0, #0
; CHECK-NEXT:    ushll2.8h v0, v0, #0
; CHECK-NEXT:    sshll.8h v3, v1, #0
; CHECK-NEXT:    sshll2.8h v1, v1, #0
; CHECK-NEXT:    ushll.4s v4, v2, #0
; CHECK-NEXT:    ushll.4s v5, v0, #0
; CHECK-NEXT:    ushll2.4s v2, v2, #0
; CHECK-NEXT:    ushll2.4s v6, v0, #0
; CHECK-NEXT:    sshll.4s v0, v3, #0
; CHECK-NEXT:    sshll.4s v7, v1, #0
; CHECK-NEXT:    sshll2.4s v16, v3, #0
; CHECK-NEXT:    sshll2.4s v1, v1, #0
; CHECK-NEXT:    and.16b v0, v0, v4
; CHECK-NEXT:    and.16b v3, v1, v6
; CHECK-NEXT:    and.16b v1, v16, v2
; CHECK-NEXT:    and.16b v2, v7, v5
; CHECK-NEXT:    ret
entry:
  %ext = zext <16 x i8> %a to <16 x i32>
  %cmp = icmp sgt <16 x i8> %a,  <i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1>
  %sel = select <16 x i1> %cmp, <16 x i32> %ext, <16 x i32> zeroinitializer
  ret <16 x i32> %sel
}

define void @extension_in_loop_v16i8_to_v16i32(ptr %src, ptr %dst) {
; CHECK-LABEL: extension_in_loop_v16i8_to_v16i32:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:  Lloh2:
; CHECK-NEXT:    adrp x8, lCPI24_0@PAGE
; CHECK-NEXT:  Lloh3:
; CHECK-NEXT:    adrp x9, lCPI24_1@PAGE
; CHECK-NEXT:  Lloh4:
; CHECK-NEXT:    adrp x10, lCPI24_2@PAGE
; CHECK-NEXT:  Lloh5:
; CHECK-NEXT:    ldr q0, [x8, lCPI24_0@PAGEOFF]
; CHECK-NEXT:  Lloh6:
; CHECK-NEXT:    adrp x8, lCPI24_3@PAGE
; CHECK-NEXT:  Lloh7:
; CHECK-NEXT:    ldr q1, [x9, lCPI24_1@PAGEOFF]
; CHECK-NEXT:  Lloh8:
; CHECK-NEXT:    ldr q2, [x10, lCPI24_2@PAGEOFF]
; CHECK-NEXT:  Lloh9:
; CHECK-NEXT:    ldr q3, [x8, lCPI24_3@PAGEOFF]
; CHECK-NEXT:    mov x8, xzr
; CHECK-NEXT:  LBB24_1: ; %loop
; CHECK-NEXT:    ; =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldr q4, [x0, x8]
; CHECK-NEXT:    add x8, x8, #16
; CHECK-NEXT:    cmp x8, #128
; CHECK-NEXT:    cmge.16b v5, v4, #0
; CHECK-NEXT:    tbl.16b v7, { v4 }, v0
; CHECK-NEXT:    tbl.16b v16, { v4 }, v1
; CHECK-NEXT:    tbl.16b v18, { v4 }, v2
; CHECK-NEXT:    tbl.16b v4, { v4 }, v3
; CHECK-NEXT:    sshll2.8h v6, v5, #0
; CHECK-NEXT:    sshll.8h v5, v5, #0
; CHECK-NEXT:    sshll2.4s v17, v6, #0
; CHECK-NEXT:    sshll.4s v6, v6, #0
; CHECK-NEXT:    sshll2.4s v19, v5, #0
; CHECK-NEXT:    sshll.4s v5, v5, #0
; CHECK-NEXT:    and.16b v7, v17, v7
; CHECK-NEXT:    and.16b v6, v6, v16
; CHECK-NEXT:    and.16b v16, v19, v18
; CHECK-NEXT:    and.16b v4, v5, v4
; CHECK-NEXT:    stp q6, q7, [x1, #32]
; CHECK-NEXT:    stp q4, q16, [x1], #64
; CHECK-NEXT:    b.ne LBB24_1
; CHECK-NEXT:  ; %bb.2: ; %exit
; CHECK-NEXT:    ret
; CHECK-NEXT:    .loh AdrpLdr Lloh6, Lloh9
; CHECK-NEXT:    .loh AdrpLdr Lloh4, Lloh8
; CHECK-NEXT:    .loh AdrpLdr Lloh3, Lloh7
; CHECK-NEXT:    .loh AdrpAdrp Lloh2, Lloh6
; CHECK-NEXT:    .loh AdrpLdr Lloh2, Lloh5
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %src.gep = getelementptr i8, ptr %src, i64 %iv
  %load = load <16 x i8>, ptr %src.gep
  %cmp = icmp sgt <16 x i8> %load,  <i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1>
  %ext = zext <16 x i8> %load to <16 x i32>
  %sel = select <16 x i1> %cmp, <16 x i32> %ext, <16 x i32> zeroinitializer
  %dst.gep = getelementptr i32, ptr %dst, i64 %iv
  store <16 x i32> %sel, ptr %dst.gep
  %iv.next = add nuw i64 %iv, 16
  %ec = icmp eq i64 %iv.next, 128
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}

define void @extension_in_loop_as_shuffle_v16i8_to_v16i32(ptr %src, ptr %dst) {
; CHECK-LABEL: extension_in_loop_as_shuffle_v16i8_to_v16i32:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:  Lloh10:
; CHECK-NEXT:    adrp x8, lCPI25_0@PAGE
; CHECK-NEXT:  Lloh11:
; CHECK-NEXT:    adrp x9, lCPI25_1@PAGE
; CHECK-NEXT:  Lloh12:
; CHECK-NEXT:    adrp x10, lCPI25_2@PAGE
; CHECK-NEXT:  Lloh13:
; CHECK-NEXT:    ldr q0, [x8, lCPI25_0@PAGEOFF]
; CHECK-NEXT:  Lloh14:
; CHECK-NEXT:    adrp x8, lCPI25_3@PAGE
; CHECK-NEXT:  Lloh15:
; CHECK-NEXT:    ldr q1, [x9, lCPI25_1@PAGEOFF]
; CHECK-NEXT:  Lloh16:
; CHECK-NEXT:    ldr q2, [x10, lCPI25_2@PAGEOFF]
; CHECK-NEXT:  Lloh17:
; CHECK-NEXT:    ldr q3, [x8, lCPI25_3@PAGEOFF]
; CHECK-NEXT:    mov x8, xzr
; CHECK-NEXT:  LBB25_1: ; %loop
; CHECK-NEXT:    ; =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldr q4, [x0, x8]
; CHECK-NEXT:    add x8, x8, #16
; CHECK-NEXT:    cmp x8, #128
; CHECK-NEXT:    cmge.16b v5, v4, #0
; CHECK-NEXT:    tbl.16b v7, { v4 }, v0
; CHECK-NEXT:    tbl.16b v16, { v4 }, v1
; CHECK-NEXT:    tbl.16b v18, { v4 }, v2
; CHECK-NEXT:    tbl.16b v4, { v4 }, v3
; CHECK-NEXT:    sshll2.8h v6, v5, #0
; CHECK-NEXT:    sshll.8h v5, v5, #0
; CHECK-NEXT:    sshll2.4s v17, v6, #0
; CHECK-NEXT:    sshll.4s v6, v6, #0
; CHECK-NEXT:    sshll2.4s v19, v5, #0
; CHECK-NEXT:    sshll.4s v5, v5, #0
; CHECK-NEXT:    and.16b v7, v17, v7
; CHECK-NEXT:    and.16b v6, v6, v16
; CHECK-NEXT:    and.16b v16, v19, v18
; CHECK-NEXT:    and.16b v4, v5, v4
; CHECK-NEXT:    stp q6, q7, [x1, #32]
; CHECK-NEXT:    stp q4, q16, [x1], #64
; CHECK-NEXT:    b.ne LBB25_1
; CHECK-NEXT:  ; %bb.2: ; %exit
; CHECK-NEXT:    ret
; CHECK-NEXT:    .loh AdrpLdr Lloh14, Lloh17
; CHECK-NEXT:    .loh AdrpLdr Lloh12, Lloh16
; CHECK-NEXT:    .loh AdrpLdr Lloh11, Lloh15
; CHECK-NEXT:    .loh AdrpAdrp Lloh10, Lloh14
; CHECK-NEXT:    .loh AdrpLdr Lloh10, Lloh13
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %src.gep = getelementptr i8, ptr %src, i64 %iv
  %load = load <16 x i8>, ptr %src.gep
  %cmp = icmp sgt <16 x i8> %load,  <i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1>
  %ext.shuf = shufflevector <16 x i8> %load, <16 x i8> zeroinitializer, <64 x i32> <i32 16, i32 16, i32 16, i32 0, i32 16, i32 16, i32 16, i32 1, i32 16, i32 16, i32 16, i32 2, i32 16, i32 16, i32 16, i32 3, i32 16, i32 16, i32 16, i32 4, i32 16, i32 16, i32 16, i32 5, i32 16, i32 16, i32 16, i32 6, i32 16, i32 16, i32 16, i32 7, i32 16, i32 16, i32 16, i32 8, i32 16, i32 16, i32 16, i32 9, i32 16, i32 16, i32 16, i32 10, i32 16, i32 16, i32 16, i32 11, i32 16, i32 16, i32 16, i32 12, i32 16, i32 16, i32 16, i32 13, i32 16, i32 16, i32 16, i32 14, i32 16, i32 16, i32 16, i32 15>
  %ext = bitcast <64 x i8> %ext.shuf to <16 x i32>
  %sel = select <16 x i1> %cmp, <16 x i32> %ext, <16 x i32> zeroinitializer
  %dst.gep = getelementptr i32, ptr %dst, i64 %iv
  store <16 x i32> %sel, ptr %dst.gep
  %iv.next = add nuw i64 %iv, 16
  %ec = icmp eq i64 %iv.next, 128
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}

define void @shuffle_in_loop_is_no_extend_v16i8_to_v16i32(ptr %src, ptr %dst) {
; CHECK-LABEL: shuffle_in_loop_is_no_extend_v16i8_to_v16i32:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:  Lloh18:
; CHECK-NEXT:    adrp x8, lCPI26_0@PAGE
; CHECK-NEXT:  Lloh19:
; CHECK-NEXT:    adrp x9, lCPI26_1@PAGE
; CHECK-NEXT:  Lloh20:
; CHECK-NEXT:    adrp x10, lCPI26_2@PAGE
; CHECK-NEXT:  Lloh21:
; CHECK-NEXT:    ldr q0, [x8, lCPI26_0@PAGEOFF]
; CHECK-NEXT:  Lloh22:
; CHECK-NEXT:    adrp x8, lCPI26_3@PAGE
; CHECK-NEXT:  Lloh23:
; CHECK-NEXT:    ldr q1, [x9, lCPI26_1@PAGEOFF]
; CHECK-NEXT:  Lloh24:
; CHECK-NEXT:    ldr q2, [x10, lCPI26_2@PAGEOFF]
; CHECK-NEXT:  Lloh25:
; CHECK-NEXT:    ldr q3, [x8, lCPI26_3@PAGEOFF]
; CHECK-NEXT:    mov x8, xzr
; CHECK-NEXT:  LBB26_1: ; %loop
; CHECK-NEXT:    ; =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldr q4, [x0, x8]
; CHECK-NEXT:    add x8, x8, #16
; CHECK-NEXT:    cmp x8, #128
; CHECK-NEXT:    cmge.16b v5, v4, #0
; CHECK-NEXT:    tbl.16b v7, { v4 }, v0
; CHECK-NEXT:    tbl.16b v16, { v4 }, v1
; CHECK-NEXT:    tbl.16b v18, { v4 }, v2
; CHECK-NEXT:    tbl.16b v4, { v4 }, v3
; CHECK-NEXT:    sshll2.8h v6, v5, #0
; CHECK-NEXT:    sshll.8h v5, v5, #0
; CHECK-NEXT:    sshll2.4s v17, v6, #0
; CHECK-NEXT:    sshll.4s v6, v6, #0
; CHECK-NEXT:    sshll2.4s v19, v5, #0
; CHECK-NEXT:    sshll.4s v5, v5, #0
; CHECK-NEXT:    and.16b v7, v17, v7
; CHECK-NEXT:    and.16b v6, v6, v16
; CHECK-NEXT:    and.16b v16, v19, v18
; CHECK-NEXT:    and.16b v4, v5, v4
; CHECK-NEXT:    stp q6, q7, [x1, #32]
; CHECK-NEXT:    stp q4, q16, [x1], #64
; CHECK-NEXT:    b.ne LBB26_1
; CHECK-NEXT:  ; %bb.2: ; %exit
; CHECK-NEXT:    ret
; CHECK-NEXT:    .loh AdrpLdr Lloh22, Lloh25
; CHECK-NEXT:    .loh AdrpLdr Lloh20, Lloh24
; CHECK-NEXT:    .loh AdrpLdr Lloh19, Lloh23
; CHECK-NEXT:    .loh AdrpAdrp Lloh18, Lloh22
; CHECK-NEXT:    .loh AdrpLdr Lloh18, Lloh21
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %src.gep = getelementptr i8, ptr %src, i64 %iv
  %load = load <16 x i8>, ptr %src.gep
  %cmp = icmp sgt <16 x i8> %load,  <i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1>
  %ext.shuf = shufflevector <16 x i8> %load, <16 x i8> zeroinitializer, <64 x i32> <i32 1, i32 16, i32 16, i32 0, i32 16, i32 16, i32 16, i32 1, i32 16, i32 16, i32 16, i32 2, i32 16, i32 16, i32 16, i32 3, i32 16, i32 16, i32 16, i32 4, i32 16, i32 16, i32 16, i32 5, i32 16, i32 16, i32 16, i32 6, i32 16, i32 16, i32 16, i32 7, i32 16, i32 16, i32 16, i32 8, i32 16, i32 16, i32 16, i32 9, i32 16, i32 16, i32 16, i32 10, i32 16, i32 16, i32 16, i32 11, i32 16, i32 16, i32 16, i32 12, i32 16, i32 16, i32 16, i32 13, i32 16, i32 16, i32 16, i32 14, i32 16, i32 16, i32 16, i32 15>
  %ext = bitcast <64 x i8> %ext.shuf to <16 x i32>
  %sel = select <16 x i1> %cmp, <16 x i32> %ext, <16 x i32> zeroinitializer
  %dst.gep = getelementptr i32, ptr %dst, i64 %iv
  store <16 x i32> %sel, ptr %dst.gep
  %iv.next = add nuw i64 %iv, 16
  %ec = icmp eq i64 %iv.next, 128
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}
