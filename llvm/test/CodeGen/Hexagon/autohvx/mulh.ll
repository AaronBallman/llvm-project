; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=hexagon -mattr=+hvxv60,+hvx-length128b,-packets < %s | FileCheck --check-prefix=V60 %s
; RUN: llc -mtriple=hexagon -mattr=+hvxv65,+hvx-length128b,-packets < %s | FileCheck --check-prefix=V65 %s
; RUN: llc -mtriple=hexagon -mattr=+hvxv69,+hvx-length128b,-packets < %s | FileCheck --check-prefix=V69 %s

define <64 x i16> @mulhs16(<64 x i16> %a0, <64 x i16> %a1) #0 {
; V60-LABEL: mulhs16:
; V60:       // %bb.0:
; V60-NEXT:    {
; V60-NEXT:     v1:0.w = vmpy(v1.h,v0.h)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     r7 = #124
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v1:0 = vshuff(v1,v0,r7)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v0.h = vpacko(v1.w,v0.w)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     jumpr r31
; V60-NEXT:    }
;
; V65-LABEL: mulhs16:
; V65:       // %bb.0:
; V65-NEXT:    {
; V65-NEXT:     v1:0.w = vmpy(v1.h,v0.h)
; V65-NEXT:    }
; V65-NEXT:    {
; V65-NEXT:     r7 = #124
; V65-NEXT:    }
; V65-NEXT:    {
; V65-NEXT:     v1:0 = vshuff(v1,v0,r7)
; V65-NEXT:    }
; V65-NEXT:    {
; V65-NEXT:     v0.h = vpacko(v1.w,v0.w)
; V65-NEXT:    }
; V65-NEXT:    {
; V65-NEXT:     jumpr r31
; V65-NEXT:    }
;
; V69-LABEL: mulhs16:
; V69:       // %bb.0:
; V69-NEXT:    {
; V69-NEXT:     v1:0.w = vmpy(v1.h,v0.h)
; V69-NEXT:    }
; V69-NEXT:    {
; V69-NEXT:     r7 = #124
; V69-NEXT:    }
; V69-NEXT:    {
; V69-NEXT:     v1:0 = vshuff(v1,v0,r7)
; V69-NEXT:    }
; V69-NEXT:    {
; V69-NEXT:     v0.h = vpacko(v1.w,v0.w)
; V69-NEXT:    }
; V69-NEXT:    {
; V69-NEXT:     jumpr r31
; V69-NEXT:    }
  %v0 = sext <64 x i16> %a0 to <64 x i32>
  %v1 = sext <64 x i16> %a1 to <64 x i32>
  %v2 = mul <64 x i32> %v0, %v1
  %v3 = lshr <64 x i32> %v2, <i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16>
  %v4 = trunc <64 x i32> %v3 to <64 x i16>
  ret <64 x i16> %v4
}

define <64 x i16> @mulhu16(<64 x i16> %a0, <64 x i16> %a1) #0 {
; V60-LABEL: mulhu16:
; V60:       // %bb.0:
; V60-NEXT:    {
; V60-NEXT:     v1:0.uw = vmpy(v1.uh,v0.uh)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     r7 = #124
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v1:0 = vshuff(v1,v0,r7)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v0.h = vpacko(v1.w,v0.w)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     jumpr r31
; V60-NEXT:    }
;
; V65-LABEL: mulhu16:
; V65:       // %bb.0:
; V65-NEXT:    {
; V65-NEXT:     v1:0.uw = vmpy(v1.uh,v0.uh)
; V65-NEXT:    }
; V65-NEXT:    {
; V65-NEXT:     r7 = #124
; V65-NEXT:    }
; V65-NEXT:    {
; V65-NEXT:     v1:0 = vshuff(v1,v0,r7)
; V65-NEXT:    }
; V65-NEXT:    {
; V65-NEXT:     v0.h = vpacko(v1.w,v0.w)
; V65-NEXT:    }
; V65-NEXT:    {
; V65-NEXT:     jumpr r31
; V65-NEXT:    }
;
; V69-LABEL: mulhu16:
; V69:       // %bb.0:
; V69-NEXT:    {
; V69-NEXT:     v0.uh = vmpy(v0.uh,v1.uh):>>16
; V69-NEXT:    }
; V69-NEXT:    {
; V69-NEXT:     jumpr r31
; V69-NEXT:    }
  %v0 = zext <64 x i16> %a0 to <64 x i32>
  %v1 = zext <64 x i16> %a1 to <64 x i32>
  %v2 = mul <64 x i32> %v0, %v1
  %v3 = lshr <64 x i32> %v2, <i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16>
  %v4 = trunc <64 x i32> %v3 to <64 x i16>
  ret <64 x i16> %v4
}

define <32 x i32> @mulhs32(<32 x i32> %a0, <32 x i32> %a1) #0 {
; V60-LABEL: mulhs32:
; V60:       // %bb.0:
; V60-NEXT:    {
; V60-NEXT:     r0 = #16
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v2.w = vmpye(v1.w,v0.uh)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v31.w = vasr(v0.w,r0)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v3.w = vasr(v1.w,r0)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v5:4.w = vmpy(v31.h,v1.uh)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v31:30.w = vmpy(v31.h,v3.h)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v7:6.w = vadd(v2.uh,v4.uh)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v29:28.w = vadd(v2.h,v4.h)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v29.w += vasr(v6.w,r0)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v0.w = vadd(v29.w,v30.w)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     jumpr r31
; V60-NEXT:    }
;
; V65-LABEL: mulhs32:
; V65:       // %bb.0:
; V65-NEXT:    {
; V65-NEXT:     v3:2 = vmpye(v0.w,v1.uh)
; V65-NEXT:    }
; V65-NEXT:    {
; V65-NEXT:     v3:2 += vmpyo(v0.w,v1.h)
; V65-NEXT:    }
; V65-NEXT:    {
; V65-NEXT:     v0 = v3
; V65-NEXT:    }
; V65-NEXT:    {
; V65-NEXT:     jumpr r31
; V65-NEXT:    }
;
; V69-LABEL: mulhs32:
; V69:       // %bb.0:
; V69-NEXT:    {
; V69-NEXT:     v3:2 = vmpye(v0.w,v1.uh)
; V69-NEXT:    }
; V69-NEXT:    {
; V69-NEXT:     v3:2 += vmpyo(v0.w,v1.h)
; V69-NEXT:    }
; V69-NEXT:    {
; V69-NEXT:     v0 = v3
; V69-NEXT:    }
; V69-NEXT:    {
; V69-NEXT:     jumpr r31
; V69-NEXT:    }
  %v0 = sext <32 x i32> %a0 to <32 x i64>
  %v1 = sext <32 x i32> %a1 to <32 x i64>
  %v2 = mul <32 x i64> %v0, %v1
  %v3 = lshr <32 x i64> %v2, <i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32>
  %v4 = trunc <32 x i64> %v3 to <32 x i32>
  ret <32 x i32> %v4
}

define <32 x i32> @mulhu32(<32 x i32> %a0, <32 x i32> %a1) #0 {
; V60-LABEL: mulhu32:
; V60:       // %bb.0:
; V60-NEXT:    {
; V60-NEXT:     r0 = ##33686018
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v3:2.uw = vmpy(v0.uh,v1.uh)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     r2 = #16
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v4 = vsplat(r0)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v2.uw = vlsr(v2.uw,r2)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v31 = vdelta(v1,v4)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v1:0.uw = vmpy(v0.uh,v31.uh)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v1:0.w = vadd(v1.uh,v0.uh)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v0.w = vadd(v0.w,v2.w)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v1.w += vasr(v0.w,r2)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v0.w = vadd(v3.w,v1.w)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     jumpr r31
; V60-NEXT:    }
;
; V65-LABEL: mulhu32:
; V65:       // %bb.0:
; V65-NEXT:    {
; V65-NEXT:     v2 = vxor(v2,v2)
; V65-NEXT:    }
; V65-NEXT:    {
; V65-NEXT:     v5:4 = vmpye(v0.w,v1.uh)
; V65-NEXT:    }
; V65-NEXT:    {
; V65-NEXT:     q0 = vcmp.gt(v2.w,v0.w)
; V65-NEXT:    }
; V65-NEXT:    {
; V65-NEXT:     q1 = vcmp.gt(v2.w,v1.w)
; V65-NEXT:    }
; V65-NEXT:    {
; V65-NEXT:     v5:4 += vmpyo(v0.w,v1.h)
; V65-NEXT:    }
; V65-NEXT:    {
; V65-NEXT:     v31 = vand(q0,v1)
; V65-NEXT:    }
; V65-NEXT:    {
; V65-NEXT:     if (q1) v31.w += v0.w
; V65-NEXT:    }
; V65-NEXT:    {
; V65-NEXT:     v0.w = vadd(v5.w,v31.w)
; V65-NEXT:    }
; V65-NEXT:    {
; V65-NEXT:     jumpr r31
; V65-NEXT:    }
;
; V69-LABEL: mulhu32:
; V69:       // %bb.0:
; V69-NEXT:    {
; V69-NEXT:     v2 = vxor(v2,v2)
; V69-NEXT:    }
; V69-NEXT:    {
; V69-NEXT:     v5:4 = vmpye(v0.w,v1.uh)
; V69-NEXT:    }
; V69-NEXT:    {
; V69-NEXT:     q0 = vcmp.gt(v2.w,v0.w)
; V69-NEXT:    }
; V69-NEXT:    {
; V69-NEXT:     q1 = vcmp.gt(v2.w,v1.w)
; V69-NEXT:    }
; V69-NEXT:    {
; V69-NEXT:     v5:4 += vmpyo(v0.w,v1.h)
; V69-NEXT:    }
; V69-NEXT:    {
; V69-NEXT:     v31 = vand(q0,v1)
; V69-NEXT:    }
; V69-NEXT:    {
; V69-NEXT:     if (q1) v31.w += v0.w
; V69-NEXT:    }
; V69-NEXT:    {
; V69-NEXT:     v0.w = vadd(v5.w,v31.w)
; V69-NEXT:    }
; V69-NEXT:    {
; V69-NEXT:     jumpr r31
; V69-NEXT:    }
  %v0 = zext <32 x i32> %a0 to <32 x i64>
  %v1 = zext <32 x i32> %a1 to <32 x i64>
  %v2 = mul <32 x i64> %v0, %v1
  %v3 = lshr <32 x i64> %v2, <i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32>
  %v4 = trunc <32 x i64> %v3 to <32 x i32>
  ret <32 x i32> %v4
}

attributes #0 = { nounwind memory(none) }
