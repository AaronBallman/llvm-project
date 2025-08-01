; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -global-isel=0 -mtriple=amdgcn -mcpu=gfx1200 < %s | FileCheck -check-prefix=GFX12 %s
; RUN: llc -global-isel=1 -mtriple=amdgcn -mcpu=gfx1200 < %s | FileCheck -check-prefix=GFX12 %s

define amdgpu_ps void @intrinsic_store_system_scope(i32 %val, <4 x i32> inreg %rsrc, i32 %vindex, i32 %voffset, i32 inreg %soffset) {
; GFX12-LABEL: intrinsic_store_system_scope:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    buffer_store_b32 v0, v[1:2], s[0:3], s4 idxen offen scope:SCOPE_SYS
; GFX12-NEXT:    s_endpgm
  call void @llvm.amdgcn.struct.buffer.store.i32(i32 %val, <4 x i32> %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 24)
  ret void
}

define amdgpu_ps void @generic_store_volatile(i32 %val, ptr addrspace(1) %out) {
; GFX12-LABEL: generic_store_volatile:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    global_store_b32 v[1:2], v0, off scope:SCOPE_SYS
; GFX12-NEXT:    s_wait_storecnt 0x0
; GFX12-NEXT:    s_endpgm
  store volatile i32 %val, ptr addrspace(1) %out
  ret void
}
