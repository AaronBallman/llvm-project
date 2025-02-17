; RUN: opt -S  -dxil-intrinsic-expansion  -mtriple=dxil-pc-shadermodel6.3-library %s | FileCheck %s --check-prefixes=CHECK,EXPCHECK
; RUN: opt -S  -dxil-intrinsic-expansion -dxil-op-lower  -mtriple=dxil-pc-shadermodel6.3-library %s | FileCheck %s --check-prefixes=CHECK,DOPCHECK

; Make sure dxil operation function calls for log10 are generated.

define noundef float @log10_float(float noundef %a) #0 {
entry:
; DOPCHECK: call float @dx.op.unary.f32(i32 23, float %{{.*}}) #[[#ATTR:]]
; EXPCHECK: call float @llvm.log2.f32(float %a)
; CHECK: fmul float 0x3FD3441340000000, %{{.*}}
  %elt.log10 = call float @llvm.log10.f32(float %a)
  ret float %elt.log10
}

define noundef half @log10_half(half noundef %a) #0 {
entry:
; DOPCHECK: call half @dx.op.unary.f16(i32 23, half %{{.*}}) #[[#ATTR]]
; EXPCHECK: call half @llvm.log2.f16(half %a)
; CHECK: fmul half 0xH34D1, %{{.*}}
  %elt.log10 = call half @llvm.log10.f16(half %a)
  ret half %elt.log10
}

; DOPCHECK: attributes #[[#ATTR]] = {{{.*}} memory(none) {{.*}}}

declare half @llvm.log10.f16(half)
declare float @llvm.log10.f32(float)
