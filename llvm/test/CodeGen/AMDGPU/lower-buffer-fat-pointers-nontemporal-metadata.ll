; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn-amd-amdhsa -global-isel=0 -mcpu=gfx900 < %s | FileCheck --check-prefixes=GFX9,GFX9-SDAG %s
; RUN: llc -mtriple=amdgcn-amd-amdhsa -global-isel=1 -mcpu=gfx900 < %s | FileCheck --check-prefixes=GFX9,GFX9-GISEL %s
; RUN: llc -mtriple=amdgcn-amd-amdhsa -global-isel=0 -mcpu=gfx942 < %s | FileCheck --check-prefixes=GFX942,GFX942-SDAG %s
; RUN: llc -mtriple=amdgcn-amd-amdhsa -global-isel=1 -mcpu=gfx942 < %s | FileCheck --check-prefixes=GFX942,GFX942-GISEL %s
; RUN: llc -mtriple=amdgcn-amd-amdhsa -global-isel=0 -mcpu=gfx1010 < %s | FileCheck --check-prefixes=GFX10,GFX10-SDAG %s
; RUN: llc -mtriple=amdgcn-amd-amdhsa -global-isel=1 -mcpu=gfx1010 < %s | FileCheck --check-prefixes=GFX10,GFX10-GISEL %s
; RUN: llc -mtriple=amdgcn-amd-amdhsa -global-isel=0 -mcpu=gfx1100 < %s | FileCheck --check-prefixes=GFX11,GFX11-SDAG %s
; RUN: llc -mtriple=amdgcn-amd-amdhsa -global-isel=1 -mcpu=gfx1100 < %s | FileCheck --check-prefixes=GFX11,GFX11-GISEL %s
; RUN: llc -mtriple=amdgcn-amd-amdhsa -global-isel=0 -mcpu=gfx1200 < %s | FileCheck --check-prefixes=GFX12,GFX12-SDAG %s
; RUN: llc -mtriple=amdgcn-amd-amdhsa -global-isel=1 -mcpu=gfx1200 < %s | FileCheck --check-prefixes=GFX12,GFX12-GISEL %s

define amdgpu_kernel void @buffer_nontemporal_load_store(ptr addrspace(7) %in, ptr addrspace(7) %out) {
; GFX9-SDAG-LABEL: buffer_nontemporal_load_store:
; GFX9-SDAG:       ; %bb.0: ; %entry
; GFX9-SDAG-NEXT:    s_load_dwordx4 s[0:3], s[8:9], 0x0
; GFX9-SDAG-NEXT:    s_load_dword s11, s[8:9], 0x10
; GFX9-SDAG-NEXT:    s_mov_b32 s10, 0
; GFX9-SDAG-NEXT:    s_mov_b32 s5, s10
; GFX9-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-SDAG-NEXT:    s_mov_b32 s4, s3
; GFX9-SDAG-NEXT:    s_or_b64 s[6:7], s[4:5], s[10:11]
; GFX9-SDAG-NEXT:    s_mov_b32 s11, s2
; GFX9-SDAG-NEXT:    s_mov_b32 s2, s1
; GFX9-SDAG-NEXT:    s_mov_b32 s3, s10
; GFX9-SDAG-NEXT:    s_or_b64 s[4:5], s[2:3], s[10:11]
; GFX9-SDAG-NEXT:    v_mov_b32_e32 v0, s0
; GFX9-SDAG-NEXT:    buffer_load_dword v0, v0, s[4:7], 0 offen glc slc
; GFX9-SDAG-NEXT:    s_load_dword s11, s[8:9], 0x30
; GFX9-SDAG-NEXT:    s_load_dwordx4 s[0:3], s[8:9], 0x20
; GFX9-SDAG-NEXT:    s_mov_b32 s5, s10
; GFX9-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-SDAG-NEXT:    s_mov_b32 s4, s3
; GFX9-SDAG-NEXT:    s_or_b64 s[6:7], s[4:5], s[10:11]
; GFX9-SDAG-NEXT:    s_mov_b32 s11, s2
; GFX9-SDAG-NEXT:    s_mov_b32 s2, s1
; GFX9-SDAG-NEXT:    s_mov_b32 s3, s10
; GFX9-SDAG-NEXT:    s_or_b64 s[4:5], s[2:3], s[10:11]
; GFX9-SDAG-NEXT:    v_mov_b32_e32 v1, s0
; GFX9-SDAG-NEXT:    s_waitcnt vmcnt(0)
; GFX9-SDAG-NEXT:    buffer_store_dword v0, v1, s[4:7], 0 offen glc slc
; GFX9-SDAG-NEXT:    s_endpgm
;
; GFX9-GISEL-LABEL: buffer_nontemporal_load_store:
; GFX9-GISEL:       ; %bb.0: ; %entry
; GFX9-GISEL-NEXT:    s_load_dwordx4 s[0:3], s[8:9], 0x0
; GFX9-GISEL-NEXT:    s_load_dword s7, s[8:9], 0x10
; GFX9-GISEL-NEXT:    s_mov_b32 s11, 0
; GFX9-GISEL-NEXT:    s_mov_b32 s4, s11
; GFX9-GISEL-NEXT:    s_mov_b32 s6, s11
; GFX9-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-GISEL-NEXT:    s_mov_b32 s10, s1
; GFX9-GISEL-NEXT:    s_mov_b32 s5, s2
; GFX9-GISEL-NEXT:    s_or_b64 s[4:5], s[10:11], s[4:5]
; GFX9-GISEL-NEXT:    s_mov_b32 s10, s3
; GFX9-GISEL-NEXT:    s_or_b64 s[6:7], s[10:11], s[6:7]
; GFX9-GISEL-NEXT:    v_mov_b32_e32 v0, s0
; GFX9-GISEL-NEXT:    buffer_load_dword v0, v0, s[4:7], 0 offen glc slc
; GFX9-GISEL-NEXT:    s_load_dwordx4 s[0:3], s[8:9], 0x20
; GFX9-GISEL-NEXT:    s_load_dword s7, s[8:9], 0x30
; GFX9-GISEL-NEXT:    s_mov_b32 s4, s11
; GFX9-GISEL-NEXT:    s_mov_b32 s6, s11
; GFX9-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-GISEL-NEXT:    s_mov_b32 s10, s1
; GFX9-GISEL-NEXT:    s_mov_b32 s5, s2
; GFX9-GISEL-NEXT:    s_or_b64 s[4:5], s[10:11], s[4:5]
; GFX9-GISEL-NEXT:    s_mov_b32 s10, s3
; GFX9-GISEL-NEXT:    s_or_b64 s[6:7], s[10:11], s[6:7]
; GFX9-GISEL-NEXT:    v_mov_b32_e32 v1, s0
; GFX9-GISEL-NEXT:    s_waitcnt vmcnt(0)
; GFX9-GISEL-NEXT:    buffer_store_dword v0, v1, s[4:7], 0 offen glc slc
; GFX9-GISEL-NEXT:    s_endpgm
;
; GFX942-SDAG-LABEL: buffer_nontemporal_load_store:
; GFX942-SDAG:       ; %bb.0: ; %entry
; GFX942-SDAG-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x0
; GFX942-SDAG-NEXT:    s_load_dword s13, s[4:5], 0x10
; GFX942-SDAG-NEXT:    s_mov_b32 s12, 0
; GFX942-SDAG-NEXT:    s_mov_b32 s7, s12
; GFX942-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX942-SDAG-NEXT:    s_mov_b32 s6, s3
; GFX942-SDAG-NEXT:    s_or_b64 s[10:11], s[6:7], s[12:13]
; GFX942-SDAG-NEXT:    s_mov_b32 s13, s2
; GFX942-SDAG-NEXT:    s_mov_b32 s2, s1
; GFX942-SDAG-NEXT:    s_mov_b32 s3, s12
; GFX942-SDAG-NEXT:    s_or_b64 s[8:9], s[2:3], s[12:13]
; GFX942-SDAG-NEXT:    v_mov_b32_e32 v0, s0
; GFX942-SDAG-NEXT:    buffer_load_dword v0, v0, s[8:11], 0 offen nt
; GFX942-SDAG-NEXT:    s_load_dword s13, s[4:5], 0x30
; GFX942-SDAG-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x20
; GFX942-SDAG-NEXT:    s_mov_b32 s5, s12
; GFX942-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX942-SDAG-NEXT:    s_mov_b32 s4, s3
; GFX942-SDAG-NEXT:    s_or_b64 s[6:7], s[4:5], s[12:13]
; GFX942-SDAG-NEXT:    s_mov_b32 s13, s2
; GFX942-SDAG-NEXT:    s_mov_b32 s2, s1
; GFX942-SDAG-NEXT:    s_mov_b32 s3, s12
; GFX942-SDAG-NEXT:    s_or_b64 s[4:5], s[2:3], s[12:13]
; GFX942-SDAG-NEXT:    v_mov_b32_e32 v1, s0
; GFX942-SDAG-NEXT:    s_waitcnt vmcnt(0)
; GFX942-SDAG-NEXT:    buffer_store_dword v0, v1, s[4:7], 0 offen nt
; GFX942-SDAG-NEXT:    s_endpgm
;
; GFX942-GISEL-LABEL: buffer_nontemporal_load_store:
; GFX942-GISEL:       ; %bb.0: ; %entry
; GFX942-GISEL-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x0
; GFX942-GISEL-NEXT:    s_load_dword s11, s[4:5], 0x10
; GFX942-GISEL-NEXT:    s_mov_b32 s7, 0
; GFX942-GISEL-NEXT:    s_mov_b32 s8, s7
; GFX942-GISEL-NEXT:    s_mov_b32 s10, s7
; GFX942-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX942-GISEL-NEXT:    s_mov_b32 s6, s1
; GFX942-GISEL-NEXT:    s_mov_b32 s9, s2
; GFX942-GISEL-NEXT:    s_or_b64 s[8:9], s[6:7], s[8:9]
; GFX942-GISEL-NEXT:    s_mov_b32 s6, s3
; GFX942-GISEL-NEXT:    s_or_b64 s[10:11], s[6:7], s[10:11]
; GFX942-GISEL-NEXT:    v_mov_b32_e32 v0, s0
; GFX942-GISEL-NEXT:    buffer_load_dword v0, v0, s[8:11], 0 offen nt
; GFX942-GISEL-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x20
; GFX942-GISEL-NEXT:    s_load_dword s9, s[4:5], 0x30
; GFX942-GISEL-NEXT:    s_mov_b32 s4, s7
; GFX942-GISEL-NEXT:    s_mov_b32 s8, s7
; GFX942-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX942-GISEL-NEXT:    s_mov_b32 s6, s1
; GFX942-GISEL-NEXT:    s_mov_b32 s5, s2
; GFX942-GISEL-NEXT:    s_or_b64 s[4:5], s[6:7], s[4:5]
; GFX942-GISEL-NEXT:    s_mov_b32 s6, s3
; GFX942-GISEL-NEXT:    s_or_b64 s[6:7], s[6:7], s[8:9]
; GFX942-GISEL-NEXT:    v_mov_b32_e32 v1, s0
; GFX942-GISEL-NEXT:    s_waitcnt vmcnt(0)
; GFX942-GISEL-NEXT:    buffer_store_dword v0, v1, s[4:7], 0 offen nt
; GFX942-GISEL-NEXT:    s_endpgm
;
; GFX10-SDAG-LABEL: buffer_nontemporal_load_store:
; GFX10-SDAG:       ; %bb.0: ; %entry
; GFX10-SDAG-NEXT:    s_clause 0x1
; GFX10-SDAG-NEXT:    s_load_dwordx4 s[0:3], s[8:9], 0x0
; GFX10-SDAG-NEXT:    s_load_dword s11, s[8:9], 0x10
; GFX10-SDAG-NEXT:    s_mov_b32 s10, 0
; GFX10-SDAG-NEXT:    s_mov_b32 s5, s10
; GFX10-SDAG-NEXT:    s_mov_b32 s13, s10
; GFX10-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-SDAG-NEXT:    s_mov_b32 s4, s3
; GFX10-SDAG-NEXT:    v_mov_b32_e32 v0, s0
; GFX10-SDAG-NEXT:    s_mov_b32 s12, s1
; GFX10-SDAG-NEXT:    s_or_b64 s[6:7], s[4:5], s[10:11]
; GFX10-SDAG-NEXT:    s_mov_b32 s11, s2
; GFX10-SDAG-NEXT:    s_or_b64 s[4:5], s[12:13], s[10:11]
; GFX10-SDAG-NEXT:    buffer_load_dword v0, v0, s[4:7], 0 offen slc
; GFX10-SDAG-NEXT:    s_clause 0x1
; GFX10-SDAG-NEXT:    s_load_dword s11, s[8:9], 0x30
; GFX10-SDAG-NEXT:    s_load_dwordx4 s[0:3], s[8:9], 0x20
; GFX10-SDAG-NEXT:    s_waitcnt_depctr 0xffe3
; GFX10-SDAG-NEXT:    s_mov_b32 s5, s10
; GFX10-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-SDAG-NEXT:    s_mov_b32 s4, s3
; GFX10-SDAG-NEXT:    v_mov_b32_e32 v1, s0
; GFX10-SDAG-NEXT:    s_or_b64 s[6:7], s[4:5], s[10:11]
; GFX10-SDAG-NEXT:    s_mov_b32 s11, s2
; GFX10-SDAG-NEXT:    s_mov_b32 s2, s1
; GFX10-SDAG-NEXT:    s_mov_b32 s3, s10
; GFX10-SDAG-NEXT:    s_or_b64 s[4:5], s[2:3], s[10:11]
; GFX10-SDAG-NEXT:    s_waitcnt vmcnt(0)
; GFX10-SDAG-NEXT:    buffer_store_dword v0, v1, s[4:7], 0 offen glc slc
; GFX10-SDAG-NEXT:    s_endpgm
;
; GFX10-GISEL-LABEL: buffer_nontemporal_load_store:
; GFX10-GISEL:       ; %bb.0: ; %entry
; GFX10-GISEL-NEXT:    s_clause 0x1
; GFX10-GISEL-NEXT:    s_load_dwordx4 s[0:3], s[8:9], 0x0
; GFX10-GISEL-NEXT:    s_load_dword s5, s[8:9], 0x10
; GFX10-GISEL-NEXT:    s_mov_b32 s7, 0
; GFX10-GISEL-NEXT:    s_mov_b32 s10, s7
; GFX10-GISEL-NEXT:    s_mov_b32 s4, s7
; GFX10-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-GISEL-NEXT:    s_mov_b32 s6, s1
; GFX10-GISEL-NEXT:    s_mov_b32 s11, s2
; GFX10-GISEL-NEXT:    v_mov_b32_e32 v0, s0
; GFX10-GISEL-NEXT:    s_or_b64 s[0:1], s[6:7], s[10:11]
; GFX10-GISEL-NEXT:    s_mov_b32 s6, s3
; GFX10-GISEL-NEXT:    s_or_b64 s[2:3], s[6:7], s[4:5]
; GFX10-GISEL-NEXT:    buffer_load_dword v0, v0, s[0:3], 0 offen slc
; GFX10-GISEL-NEXT:    s_clause 0x1
; GFX10-GISEL-NEXT:    s_waitcnt_depctr 0xffe3
; GFX10-GISEL-NEXT:    s_load_dwordx4 s[0:3], s[8:9], 0x20
; GFX10-GISEL-NEXT:    s_load_dword s11, s[8:9], 0x30
; GFX10-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-GISEL-NEXT:    s_mov_b32 s6, s1
; GFX10-GISEL-NEXT:    s_mov_b32 s5, s2
; GFX10-GISEL-NEXT:    v_mov_b32_e32 v1, s0
; GFX10-GISEL-NEXT:    s_or_b64 s[4:5], s[6:7], s[4:5]
; GFX10-GISEL-NEXT:    s_mov_b32 s6, s3
; GFX10-GISEL-NEXT:    s_or_b64 s[6:7], s[6:7], s[10:11]
; GFX10-GISEL-NEXT:    s_waitcnt vmcnt(0)
; GFX10-GISEL-NEXT:    buffer_store_dword v0, v1, s[4:7], 0 offen glc slc
; GFX10-GISEL-NEXT:    s_endpgm
;
; GFX11-SDAG-LABEL: buffer_nontemporal_load_store:
; GFX11-SDAG:       ; %bb.0: ; %entry
; GFX11-SDAG-NEXT:    s_clause 0x1
; GFX11-SDAG-NEXT:    s_load_b128 s[0:3], s[4:5], 0x0
; GFX11-SDAG-NEXT:    s_load_b32 s13, s[4:5], 0x10
; GFX11-SDAG-NEXT:    s_mov_b32 s12, 0
; GFX11-SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX11-SDAG-NEXT:    s_mov_b32 s7, s12
; GFX11-SDAG-NEXT:    s_mov_b32 s9, s12
; GFX11-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-SDAG-NEXT:    s_mov_b32 s6, s3
; GFX11-SDAG-NEXT:    v_mov_b32_e32 v0, s0
; GFX11-SDAG-NEXT:    s_mov_b32 s8, s1
; GFX11-SDAG-NEXT:    s_or_b64 s[10:11], s[6:7], s[12:13]
; GFX11-SDAG-NEXT:    s_mov_b32 s13, s2
; GFX11-SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX11-SDAG-NEXT:    s_or_b64 s[8:9], s[8:9], s[12:13]
; GFX11-SDAG-NEXT:    buffer_load_b32 v0, v0, s[8:11], 0 offen slc dlc
; GFX11-SDAG-NEXT:    s_clause 0x1
; GFX11-SDAG-NEXT:    s_load_b32 s13, s[4:5], 0x30
; GFX11-SDAG-NEXT:    s_load_b128 s[0:3], s[4:5], 0x20
; GFX11-SDAG-NEXT:    s_mov_b32 s5, s12
; GFX11-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-SDAG-NEXT:    s_mov_b32 s4, s3
; GFX11-SDAG-NEXT:    v_mov_b32_e32 v1, s0
; GFX11-SDAG-NEXT:    s_or_b64 s[6:7], s[4:5], s[12:13]
; GFX11-SDAG-NEXT:    s_mov_b32 s13, s2
; GFX11-SDAG-NEXT:    s_mov_b32 s2, s1
; GFX11-SDAG-NEXT:    s_mov_b32 s3, s12
; GFX11-SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX11-SDAG-NEXT:    s_or_b64 s[4:5], s[2:3], s[12:13]
; GFX11-SDAG-NEXT:    s_waitcnt vmcnt(0)
; GFX11-SDAG-NEXT:    buffer_store_b32 v0, v1, s[4:7], 0 offen glc slc dlc
; GFX11-SDAG-NEXT:    s_endpgm
;
; GFX11-GISEL-LABEL: buffer_nontemporal_load_store:
; GFX11-GISEL:       ; %bb.0: ; %entry
; GFX11-GISEL-NEXT:    s_clause 0x1
; GFX11-GISEL-NEXT:    s_load_b128 s[0:3], s[4:5], 0x0
; GFX11-GISEL-NEXT:    s_load_b32 s7, s[4:5], 0x10
; GFX11-GISEL-NEXT:    s_mov_b32 s9, 0
; GFX11-GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX11-GISEL-NEXT:    s_mov_b32 s10, s9
; GFX11-GISEL-NEXT:    s_mov_b32 s6, s9
; GFX11-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-GISEL-NEXT:    s_mov_b32 s8, s1
; GFX11-GISEL-NEXT:    s_mov_b32 s11, s2
; GFX11-GISEL-NEXT:    v_mov_b32_e32 v0, s0
; GFX11-GISEL-NEXT:    s_or_b64 s[0:1], s[8:9], s[10:11]
; GFX11-GISEL-NEXT:    s_mov_b32 s8, s3
; GFX11-GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX11-GISEL-NEXT:    s_or_b64 s[2:3], s[8:9], s[6:7]
; GFX11-GISEL-NEXT:    buffer_load_b32 v0, v0, s[0:3], 0 offen slc dlc
; GFX11-GISEL-NEXT:    s_clause 0x1
; GFX11-GISEL-NEXT:    s_load_b128 s[0:3], s[4:5], 0x20
; GFX11-GISEL-NEXT:    s_load_b32 s7, s[4:5], 0x30
; GFX11-GISEL-NEXT:    s_mov_b32 s4, s9
; GFX11-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-GISEL-NEXT:    s_mov_b32 s8, s1
; GFX11-GISEL-NEXT:    s_mov_b32 s5, s2
; GFX11-GISEL-NEXT:    v_mov_b32_e32 v1, s0
; GFX11-GISEL-NEXT:    s_or_b64 s[4:5], s[8:9], s[4:5]
; GFX11-GISEL-NEXT:    s_mov_b32 s8, s3
; GFX11-GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX11-GISEL-NEXT:    s_or_b64 s[6:7], s[8:9], s[6:7]
; GFX11-GISEL-NEXT:    s_waitcnt vmcnt(0)
; GFX11-GISEL-NEXT:    buffer_store_b32 v0, v1, s[4:7], 0 offen glc slc dlc
; GFX11-GISEL-NEXT:    s_endpgm
;
; GFX12-SDAG-LABEL: buffer_nontemporal_load_store:
; GFX12-SDAG:       ; %bb.0: ; %entry
; GFX12-SDAG-NEXT:    s_clause 0x1
; GFX12-SDAG-NEXT:    s_load_b128 s[0:3], s[4:5], 0x0
; GFX12-SDAG-NEXT:    s_load_b32 s13, s[4:5], 0x10
; GFX12-SDAG-NEXT:    s_mov_b32 s12, 0
; GFX12-SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX12-SDAG-NEXT:    s_mov_b32 s7, s12
; GFX12-SDAG-NEXT:    s_mov_b32 s9, s12
; GFX12-SDAG-NEXT:    s_wait_kmcnt 0x0
; GFX12-SDAG-NEXT:    s_mov_b32 s6, s3
; GFX12-SDAG-NEXT:    v_mov_b32_e32 v0, s0
; GFX12-SDAG-NEXT:    s_mov_b32 s8, s1
; GFX12-SDAG-NEXT:    s_or_b64 s[10:11], s[6:7], s[12:13]
; GFX12-SDAG-NEXT:    s_mov_b32 s13, s2
; GFX12-SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX12-SDAG-NEXT:    s_or_b64 s[8:9], s[8:9], s[12:13]
; GFX12-SDAG-NEXT:    buffer_load_b32 v0, v0, s[8:11], null offen th:TH_LOAD_NT
; GFX12-SDAG-NEXT:    s_clause 0x1
; GFX12-SDAG-NEXT:    s_load_b32 s13, s[4:5], 0x30
; GFX12-SDAG-NEXT:    s_load_b128 s[0:3], s[4:5], 0x20
; GFX12-SDAG-NEXT:    s_mov_b32 s5, s12
; GFX12-SDAG-NEXT:    s_wait_kmcnt 0x0
; GFX12-SDAG-NEXT:    s_mov_b32 s4, s3
; GFX12-SDAG-NEXT:    v_mov_b32_e32 v1, s0
; GFX12-SDAG-NEXT:    s_or_b64 s[6:7], s[4:5], s[12:13]
; GFX12-SDAG-NEXT:    s_mov_b32 s13, s2
; GFX12-SDAG-NEXT:    s_mov_b32 s2, s1
; GFX12-SDAG-NEXT:    s_mov_b32 s3, s12
; GFX12-SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX12-SDAG-NEXT:    s_or_b64 s[4:5], s[2:3], s[12:13]
; GFX12-SDAG-NEXT:    s_wait_loadcnt 0x0
; GFX12-SDAG-NEXT:    buffer_store_b32 v0, v1, s[4:7], null offen th:TH_STORE_NT
; GFX12-SDAG-NEXT:    s_endpgm
;
; GFX12-GISEL-LABEL: buffer_nontemporal_load_store:
; GFX12-GISEL:       ; %bb.0: ; %entry
; GFX12-GISEL-NEXT:    s_clause 0x1
; GFX12-GISEL-NEXT:    s_load_b128 s[0:3], s[4:5], 0x0
; GFX12-GISEL-NEXT:    s_load_b32 s7, s[4:5], 0x10
; GFX12-GISEL-NEXT:    s_mov_b32 s9, 0
; GFX12-GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX12-GISEL-NEXT:    s_mov_b32 s10, s9
; GFX12-GISEL-NEXT:    s_mov_b32 s6, s9
; GFX12-GISEL-NEXT:    s_wait_kmcnt 0x0
; GFX12-GISEL-NEXT:    s_mov_b32 s8, s1
; GFX12-GISEL-NEXT:    s_mov_b32 s11, s2
; GFX12-GISEL-NEXT:    v_mov_b32_e32 v0, s0
; GFX12-GISEL-NEXT:    s_or_b64 s[0:1], s[8:9], s[10:11]
; GFX12-GISEL-NEXT:    s_mov_b32 s8, s3
; GFX12-GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX12-GISEL-NEXT:    s_or_b64 s[2:3], s[8:9], s[6:7]
; GFX12-GISEL-NEXT:    buffer_load_b32 v0, v0, s[0:3], null offen th:TH_LOAD_NT
; GFX12-GISEL-NEXT:    s_clause 0x1
; GFX12-GISEL-NEXT:    s_load_b128 s[0:3], s[4:5], 0x20
; GFX12-GISEL-NEXT:    s_load_b32 s7, s[4:5], 0x30
; GFX12-GISEL-NEXT:    s_mov_b32 s4, s9
; GFX12-GISEL-NEXT:    s_wait_kmcnt 0x0
; GFX12-GISEL-NEXT:    s_mov_b32 s8, s1
; GFX12-GISEL-NEXT:    s_mov_b32 s5, s2
; GFX12-GISEL-NEXT:    v_mov_b32_e32 v1, s0
; GFX12-GISEL-NEXT:    s_or_b64 s[4:5], s[8:9], s[4:5]
; GFX12-GISEL-NEXT:    s_mov_b32 s8, s3
; GFX12-GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX12-GISEL-NEXT:    s_or_b64 s[6:7], s[8:9], s[6:7]
; GFX12-GISEL-NEXT:    s_wait_loadcnt 0x0
; GFX12-GISEL-NEXT:    buffer_store_b32 v0, v1, s[4:7], null offen th:TH_STORE_NT
; GFX12-GISEL-NEXT:    s_endpgm
entry:
  %val = load i32, ptr addrspace(7) %in, !nontemporal !0
  store i32 %val, ptr addrspace(7) %out, !nontemporal !0
  ret void
}

define amdgpu_kernel void @buffer_nontemporal_and_volatile_load_store(ptr addrspace(7) %in, ptr addrspace(7) %out) {
; GFX9-SDAG-LABEL: buffer_nontemporal_and_volatile_load_store:
; GFX9-SDAG:       ; %bb.0: ; %entry
; GFX9-SDAG-NEXT:    s_load_dwordx4 s[0:3], s[8:9], 0x0
; GFX9-SDAG-NEXT:    s_load_dword s11, s[8:9], 0x10
; GFX9-SDAG-NEXT:    s_mov_b32 s10, 0
; GFX9-SDAG-NEXT:    s_mov_b32 s5, s10
; GFX9-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-SDAG-NEXT:    s_mov_b32 s4, s3
; GFX9-SDAG-NEXT:    s_or_b64 s[6:7], s[4:5], s[10:11]
; GFX9-SDAG-NEXT:    s_mov_b32 s11, s2
; GFX9-SDAG-NEXT:    s_mov_b32 s2, s1
; GFX9-SDAG-NEXT:    s_mov_b32 s3, s10
; GFX9-SDAG-NEXT:    s_or_b64 s[4:5], s[2:3], s[10:11]
; GFX9-SDAG-NEXT:    v_mov_b32_e32 v0, s0
; GFX9-SDAG-NEXT:    buffer_load_dword v0, v0, s[4:7], 0 offen glc
; GFX9-SDAG-NEXT:    s_load_dword s11, s[8:9], 0x30
; GFX9-SDAG-NEXT:    s_load_dwordx4 s[0:3], s[8:9], 0x20
; GFX9-SDAG-NEXT:    s_mov_b32 s5, s10
; GFX9-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-SDAG-NEXT:    s_mov_b32 s4, s3
; GFX9-SDAG-NEXT:    s_or_b64 s[6:7], s[4:5], s[10:11]
; GFX9-SDAG-NEXT:    s_mov_b32 s11, s2
; GFX9-SDAG-NEXT:    s_mov_b32 s2, s1
; GFX9-SDAG-NEXT:    s_mov_b32 s3, s10
; GFX9-SDAG-NEXT:    s_or_b64 s[4:5], s[2:3], s[10:11]
; GFX9-SDAG-NEXT:    v_mov_b32_e32 v1, s0
; GFX9-SDAG-NEXT:    s_waitcnt vmcnt(0)
; GFX9-SDAG-NEXT:    buffer_store_dword v0, v1, s[4:7], 0 offen
; GFX9-SDAG-NEXT:    s_endpgm
;
; GFX9-GISEL-LABEL: buffer_nontemporal_and_volatile_load_store:
; GFX9-GISEL:       ; %bb.0: ; %entry
; GFX9-GISEL-NEXT:    s_load_dwordx4 s[0:3], s[8:9], 0x0
; GFX9-GISEL-NEXT:    s_load_dword s7, s[8:9], 0x10
; GFX9-GISEL-NEXT:    s_mov_b32 s11, 0
; GFX9-GISEL-NEXT:    s_mov_b32 s4, s11
; GFX9-GISEL-NEXT:    s_mov_b32 s6, s11
; GFX9-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-GISEL-NEXT:    s_mov_b32 s10, s1
; GFX9-GISEL-NEXT:    s_mov_b32 s5, s2
; GFX9-GISEL-NEXT:    s_or_b64 s[4:5], s[10:11], s[4:5]
; GFX9-GISEL-NEXT:    s_mov_b32 s10, s3
; GFX9-GISEL-NEXT:    s_or_b64 s[6:7], s[10:11], s[6:7]
; GFX9-GISEL-NEXT:    v_mov_b32_e32 v0, s0
; GFX9-GISEL-NEXT:    buffer_load_dword v0, v0, s[4:7], 0 offen glc
; GFX9-GISEL-NEXT:    s_load_dwordx4 s[0:3], s[8:9], 0x20
; GFX9-GISEL-NEXT:    s_load_dword s7, s[8:9], 0x30
; GFX9-GISEL-NEXT:    s_mov_b32 s4, s11
; GFX9-GISEL-NEXT:    s_mov_b32 s6, s11
; GFX9-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-GISEL-NEXT:    s_mov_b32 s10, s1
; GFX9-GISEL-NEXT:    s_mov_b32 s5, s2
; GFX9-GISEL-NEXT:    s_or_b64 s[4:5], s[10:11], s[4:5]
; GFX9-GISEL-NEXT:    s_mov_b32 s10, s3
; GFX9-GISEL-NEXT:    s_or_b64 s[6:7], s[10:11], s[6:7]
; GFX9-GISEL-NEXT:    v_mov_b32_e32 v1, s0
; GFX9-GISEL-NEXT:    s_waitcnt vmcnt(0)
; GFX9-GISEL-NEXT:    buffer_store_dword v0, v1, s[4:7], 0 offen
; GFX9-GISEL-NEXT:    s_endpgm
;
; GFX942-SDAG-LABEL: buffer_nontemporal_and_volatile_load_store:
; GFX942-SDAG:       ; %bb.0: ; %entry
; GFX942-SDAG-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x0
; GFX942-SDAG-NEXT:    s_load_dword s13, s[4:5], 0x10
; GFX942-SDAG-NEXT:    s_mov_b32 s12, 0
; GFX942-SDAG-NEXT:    s_mov_b32 s7, s12
; GFX942-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX942-SDAG-NEXT:    s_mov_b32 s6, s3
; GFX942-SDAG-NEXT:    s_or_b64 s[10:11], s[6:7], s[12:13]
; GFX942-SDAG-NEXT:    s_mov_b32 s13, s2
; GFX942-SDAG-NEXT:    s_mov_b32 s2, s1
; GFX942-SDAG-NEXT:    s_mov_b32 s3, s12
; GFX942-SDAG-NEXT:    s_or_b64 s[8:9], s[2:3], s[12:13]
; GFX942-SDAG-NEXT:    v_mov_b32_e32 v0, s0
; GFX942-SDAG-NEXT:    buffer_load_dword v0, v0, s[8:11], 0 offen sc0 sc1
; GFX942-SDAG-NEXT:    s_load_dword s13, s[4:5], 0x30
; GFX942-SDAG-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x20
; GFX942-SDAG-NEXT:    s_mov_b32 s5, s12
; GFX942-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX942-SDAG-NEXT:    s_mov_b32 s4, s3
; GFX942-SDAG-NEXT:    s_or_b64 s[6:7], s[4:5], s[12:13]
; GFX942-SDAG-NEXT:    s_mov_b32 s13, s2
; GFX942-SDAG-NEXT:    s_mov_b32 s2, s1
; GFX942-SDAG-NEXT:    s_mov_b32 s3, s12
; GFX942-SDAG-NEXT:    s_or_b64 s[4:5], s[2:3], s[12:13]
; GFX942-SDAG-NEXT:    v_mov_b32_e32 v1, s0
; GFX942-SDAG-NEXT:    s_waitcnt vmcnt(0)
; GFX942-SDAG-NEXT:    buffer_store_dword v0, v1, s[4:7], 0 offen sc0 sc1
; GFX942-SDAG-NEXT:    s_endpgm
;
; GFX942-GISEL-LABEL: buffer_nontemporal_and_volatile_load_store:
; GFX942-GISEL:       ; %bb.0: ; %entry
; GFX942-GISEL-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x0
; GFX942-GISEL-NEXT:    s_load_dword s11, s[4:5], 0x10
; GFX942-GISEL-NEXT:    s_mov_b32 s7, 0
; GFX942-GISEL-NEXT:    s_mov_b32 s8, s7
; GFX942-GISEL-NEXT:    s_mov_b32 s10, s7
; GFX942-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX942-GISEL-NEXT:    s_mov_b32 s6, s1
; GFX942-GISEL-NEXT:    s_mov_b32 s9, s2
; GFX942-GISEL-NEXT:    s_or_b64 s[8:9], s[6:7], s[8:9]
; GFX942-GISEL-NEXT:    s_mov_b32 s6, s3
; GFX942-GISEL-NEXT:    s_or_b64 s[10:11], s[6:7], s[10:11]
; GFX942-GISEL-NEXT:    v_mov_b32_e32 v0, s0
; GFX942-GISEL-NEXT:    buffer_load_dword v0, v0, s[8:11], 0 offen sc0 sc1
; GFX942-GISEL-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x20
; GFX942-GISEL-NEXT:    s_load_dword s9, s[4:5], 0x30
; GFX942-GISEL-NEXT:    s_mov_b32 s4, s7
; GFX942-GISEL-NEXT:    s_mov_b32 s8, s7
; GFX942-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX942-GISEL-NEXT:    s_mov_b32 s6, s1
; GFX942-GISEL-NEXT:    s_mov_b32 s5, s2
; GFX942-GISEL-NEXT:    s_or_b64 s[4:5], s[6:7], s[4:5]
; GFX942-GISEL-NEXT:    s_mov_b32 s6, s3
; GFX942-GISEL-NEXT:    s_or_b64 s[6:7], s[6:7], s[8:9]
; GFX942-GISEL-NEXT:    v_mov_b32_e32 v1, s0
; GFX942-GISEL-NEXT:    s_waitcnt vmcnt(0)
; GFX942-GISEL-NEXT:    buffer_store_dword v0, v1, s[4:7], 0 offen sc0 sc1
; GFX942-GISEL-NEXT:    s_endpgm
;
; GFX10-SDAG-LABEL: buffer_nontemporal_and_volatile_load_store:
; GFX10-SDAG:       ; %bb.0: ; %entry
; GFX10-SDAG-NEXT:    s_clause 0x1
; GFX10-SDAG-NEXT:    s_load_dwordx4 s[0:3], s[8:9], 0x0
; GFX10-SDAG-NEXT:    s_load_dword s11, s[8:9], 0x10
; GFX10-SDAG-NEXT:    s_mov_b32 s10, 0
; GFX10-SDAG-NEXT:    s_mov_b32 s5, s10
; GFX10-SDAG-NEXT:    s_mov_b32 s13, s10
; GFX10-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-SDAG-NEXT:    s_mov_b32 s4, s3
; GFX10-SDAG-NEXT:    v_mov_b32_e32 v0, s0
; GFX10-SDAG-NEXT:    s_mov_b32 s12, s1
; GFX10-SDAG-NEXT:    s_or_b64 s[6:7], s[4:5], s[10:11]
; GFX10-SDAG-NEXT:    s_mov_b32 s11, s2
; GFX10-SDAG-NEXT:    s_or_b64 s[4:5], s[12:13], s[10:11]
; GFX10-SDAG-NEXT:    buffer_load_dword v0, v0, s[4:7], 0 offen glc dlc
; GFX10-SDAG-NEXT:    s_clause 0x1
; GFX10-SDAG-NEXT:    s_load_dword s11, s[8:9], 0x30
; GFX10-SDAG-NEXT:    s_load_dwordx4 s[0:3], s[8:9], 0x20
; GFX10-SDAG-NEXT:    s_waitcnt_depctr 0xffe3
; GFX10-SDAG-NEXT:    s_mov_b32 s5, s10
; GFX10-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-SDAG-NEXT:    s_mov_b32 s4, s3
; GFX10-SDAG-NEXT:    v_mov_b32_e32 v1, s0
; GFX10-SDAG-NEXT:    s_or_b64 s[6:7], s[4:5], s[10:11]
; GFX10-SDAG-NEXT:    s_mov_b32 s11, s2
; GFX10-SDAG-NEXT:    s_mov_b32 s2, s1
; GFX10-SDAG-NEXT:    s_mov_b32 s3, s10
; GFX10-SDAG-NEXT:    s_or_b64 s[4:5], s[2:3], s[10:11]
; GFX10-SDAG-NEXT:    s_waitcnt vmcnt(0)
; GFX10-SDAG-NEXT:    buffer_store_dword v0, v1, s[4:7], 0 offen
; GFX10-SDAG-NEXT:    s_endpgm
;
; GFX10-GISEL-LABEL: buffer_nontemporal_and_volatile_load_store:
; GFX10-GISEL:       ; %bb.0: ; %entry
; GFX10-GISEL-NEXT:    s_clause 0x1
; GFX10-GISEL-NEXT:    s_load_dwordx4 s[0:3], s[8:9], 0x0
; GFX10-GISEL-NEXT:    s_load_dword s5, s[8:9], 0x10
; GFX10-GISEL-NEXT:    s_mov_b32 s7, 0
; GFX10-GISEL-NEXT:    s_mov_b32 s10, s7
; GFX10-GISEL-NEXT:    s_mov_b32 s4, s7
; GFX10-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-GISEL-NEXT:    s_mov_b32 s6, s1
; GFX10-GISEL-NEXT:    s_mov_b32 s11, s2
; GFX10-GISEL-NEXT:    v_mov_b32_e32 v0, s0
; GFX10-GISEL-NEXT:    s_or_b64 s[0:1], s[6:7], s[10:11]
; GFX10-GISEL-NEXT:    s_mov_b32 s6, s3
; GFX10-GISEL-NEXT:    s_or_b64 s[2:3], s[6:7], s[4:5]
; GFX10-GISEL-NEXT:    buffer_load_dword v0, v0, s[0:3], 0 offen glc dlc
; GFX10-GISEL-NEXT:    s_clause 0x1
; GFX10-GISEL-NEXT:    s_waitcnt_depctr 0xffe3
; GFX10-GISEL-NEXT:    s_load_dwordx4 s[0:3], s[8:9], 0x20
; GFX10-GISEL-NEXT:    s_load_dword s11, s[8:9], 0x30
; GFX10-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-GISEL-NEXT:    s_mov_b32 s6, s1
; GFX10-GISEL-NEXT:    s_mov_b32 s5, s2
; GFX10-GISEL-NEXT:    v_mov_b32_e32 v1, s0
; GFX10-GISEL-NEXT:    s_or_b64 s[4:5], s[6:7], s[4:5]
; GFX10-GISEL-NEXT:    s_mov_b32 s6, s3
; GFX10-GISEL-NEXT:    s_or_b64 s[6:7], s[6:7], s[10:11]
; GFX10-GISEL-NEXT:    s_waitcnt vmcnt(0)
; GFX10-GISEL-NEXT:    buffer_store_dword v0, v1, s[4:7], 0 offen
; GFX10-GISEL-NEXT:    s_endpgm
;
; GFX11-SDAG-LABEL: buffer_nontemporal_and_volatile_load_store:
; GFX11-SDAG:       ; %bb.0: ; %entry
; GFX11-SDAG-NEXT:    s_clause 0x1
; GFX11-SDAG-NEXT:    s_load_b128 s[0:3], s[4:5], 0x0
; GFX11-SDAG-NEXT:    s_load_b32 s13, s[4:5], 0x10
; GFX11-SDAG-NEXT:    s_mov_b32 s12, 0
; GFX11-SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX11-SDAG-NEXT:    s_mov_b32 s7, s12
; GFX11-SDAG-NEXT:    s_mov_b32 s9, s12
; GFX11-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-SDAG-NEXT:    s_mov_b32 s6, s3
; GFX11-SDAG-NEXT:    v_mov_b32_e32 v0, s0
; GFX11-SDAG-NEXT:    s_mov_b32 s8, s1
; GFX11-SDAG-NEXT:    s_or_b64 s[10:11], s[6:7], s[12:13]
; GFX11-SDAG-NEXT:    s_mov_b32 s13, s2
; GFX11-SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX11-SDAG-NEXT:    s_or_b64 s[8:9], s[8:9], s[12:13]
; GFX11-SDAG-NEXT:    buffer_load_b32 v0, v0, s[8:11], 0 offen glc dlc
; GFX11-SDAG-NEXT:    s_clause 0x1
; GFX11-SDAG-NEXT:    s_load_b32 s13, s[4:5], 0x30
; GFX11-SDAG-NEXT:    s_load_b128 s[0:3], s[4:5], 0x20
; GFX11-SDAG-NEXT:    s_mov_b32 s5, s12
; GFX11-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-SDAG-NEXT:    s_mov_b32 s4, s3
; GFX11-SDAG-NEXT:    v_mov_b32_e32 v1, s0
; GFX11-SDAG-NEXT:    s_or_b64 s[6:7], s[4:5], s[12:13]
; GFX11-SDAG-NEXT:    s_mov_b32 s13, s2
; GFX11-SDAG-NEXT:    s_mov_b32 s2, s1
; GFX11-SDAG-NEXT:    s_mov_b32 s3, s12
; GFX11-SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX11-SDAG-NEXT:    s_or_b64 s[4:5], s[2:3], s[12:13]
; GFX11-SDAG-NEXT:    s_waitcnt vmcnt(0)
; GFX11-SDAG-NEXT:    buffer_store_b32 v0, v1, s[4:7], 0 offen dlc
; GFX11-SDAG-NEXT:    s_endpgm
;
; GFX11-GISEL-LABEL: buffer_nontemporal_and_volatile_load_store:
; GFX11-GISEL:       ; %bb.0: ; %entry
; GFX11-GISEL-NEXT:    s_clause 0x1
; GFX11-GISEL-NEXT:    s_load_b128 s[0:3], s[4:5], 0x0
; GFX11-GISEL-NEXT:    s_load_b32 s7, s[4:5], 0x10
; GFX11-GISEL-NEXT:    s_mov_b32 s9, 0
; GFX11-GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX11-GISEL-NEXT:    s_mov_b32 s10, s9
; GFX11-GISEL-NEXT:    s_mov_b32 s6, s9
; GFX11-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-GISEL-NEXT:    s_mov_b32 s8, s1
; GFX11-GISEL-NEXT:    s_mov_b32 s11, s2
; GFX11-GISEL-NEXT:    v_mov_b32_e32 v0, s0
; GFX11-GISEL-NEXT:    s_or_b64 s[0:1], s[8:9], s[10:11]
; GFX11-GISEL-NEXT:    s_mov_b32 s8, s3
; GFX11-GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX11-GISEL-NEXT:    s_or_b64 s[2:3], s[8:9], s[6:7]
; GFX11-GISEL-NEXT:    buffer_load_b32 v0, v0, s[0:3], 0 offen glc dlc
; GFX11-GISEL-NEXT:    s_clause 0x1
; GFX11-GISEL-NEXT:    s_load_b128 s[0:3], s[4:5], 0x20
; GFX11-GISEL-NEXT:    s_load_b32 s7, s[4:5], 0x30
; GFX11-GISEL-NEXT:    s_mov_b32 s4, s9
; GFX11-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-GISEL-NEXT:    s_mov_b32 s8, s1
; GFX11-GISEL-NEXT:    s_mov_b32 s5, s2
; GFX11-GISEL-NEXT:    v_mov_b32_e32 v1, s0
; GFX11-GISEL-NEXT:    s_or_b64 s[4:5], s[8:9], s[4:5]
; GFX11-GISEL-NEXT:    s_mov_b32 s8, s3
; GFX11-GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX11-GISEL-NEXT:    s_or_b64 s[6:7], s[8:9], s[6:7]
; GFX11-GISEL-NEXT:    s_waitcnt vmcnt(0)
; GFX11-GISEL-NEXT:    buffer_store_b32 v0, v1, s[4:7], 0 offen dlc
; GFX11-GISEL-NEXT:    s_endpgm
;
; GFX12-SDAG-LABEL: buffer_nontemporal_and_volatile_load_store:
; GFX12-SDAG:       ; %bb.0: ; %entry
; GFX12-SDAG-NEXT:    s_clause 0x1
; GFX12-SDAG-NEXT:    s_load_b128 s[0:3], s[4:5], 0x0
; GFX12-SDAG-NEXT:    s_load_b32 s13, s[4:5], 0x10
; GFX12-SDAG-NEXT:    s_mov_b32 s12, 0
; GFX12-SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX12-SDAG-NEXT:    s_mov_b32 s7, s12
; GFX12-SDAG-NEXT:    s_mov_b32 s9, s12
; GFX12-SDAG-NEXT:    s_wait_kmcnt 0x0
; GFX12-SDAG-NEXT:    s_mov_b32 s6, s3
; GFX12-SDAG-NEXT:    v_mov_b32_e32 v0, s0
; GFX12-SDAG-NEXT:    s_mov_b32 s8, s1
; GFX12-SDAG-NEXT:    s_or_b64 s[10:11], s[6:7], s[12:13]
; GFX12-SDAG-NEXT:    s_mov_b32 s13, s2
; GFX12-SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX12-SDAG-NEXT:    s_or_b64 s[8:9], s[8:9], s[12:13]
; GFX12-SDAG-NEXT:    buffer_load_b32 v0, v0, s[8:11], null offen th:TH_LOAD_NT scope:SCOPE_SYS
; GFX12-SDAG-NEXT:    s_clause 0x1
; GFX12-SDAG-NEXT:    s_load_b32 s13, s[4:5], 0x30
; GFX12-SDAG-NEXT:    s_load_b128 s[0:3], s[4:5], 0x20
; GFX12-SDAG-NEXT:    s_mov_b32 s5, s12
; GFX12-SDAG-NEXT:    s_wait_kmcnt 0x0
; GFX12-SDAG-NEXT:    s_mov_b32 s4, s3
; GFX12-SDAG-NEXT:    v_mov_b32_e32 v1, s0
; GFX12-SDAG-NEXT:    s_or_b64 s[6:7], s[4:5], s[12:13]
; GFX12-SDAG-NEXT:    s_mov_b32 s13, s2
; GFX12-SDAG-NEXT:    s_mov_b32 s2, s1
; GFX12-SDAG-NEXT:    s_mov_b32 s3, s12
; GFX12-SDAG-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX12-SDAG-NEXT:    s_or_b64 s[4:5], s[2:3], s[12:13]
; GFX12-SDAG-NEXT:    s_wait_loadcnt 0x0
; GFX12-SDAG-NEXT:    buffer_store_b32 v0, v1, s[4:7], null offen th:TH_STORE_NT scope:SCOPE_SYS
; GFX12-SDAG-NEXT:    s_endpgm
;
; GFX12-GISEL-LABEL: buffer_nontemporal_and_volatile_load_store:
; GFX12-GISEL:       ; %bb.0: ; %entry
; GFX12-GISEL-NEXT:    s_clause 0x1
; GFX12-GISEL-NEXT:    s_load_b128 s[0:3], s[4:5], 0x0
; GFX12-GISEL-NEXT:    s_load_b32 s7, s[4:5], 0x10
; GFX12-GISEL-NEXT:    s_mov_b32 s9, 0
; GFX12-GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX12-GISEL-NEXT:    s_mov_b32 s10, s9
; GFX12-GISEL-NEXT:    s_mov_b32 s6, s9
; GFX12-GISEL-NEXT:    s_wait_kmcnt 0x0
; GFX12-GISEL-NEXT:    s_mov_b32 s8, s1
; GFX12-GISEL-NEXT:    s_mov_b32 s11, s2
; GFX12-GISEL-NEXT:    v_mov_b32_e32 v0, s0
; GFX12-GISEL-NEXT:    s_or_b64 s[0:1], s[8:9], s[10:11]
; GFX12-GISEL-NEXT:    s_mov_b32 s8, s3
; GFX12-GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX12-GISEL-NEXT:    s_or_b64 s[2:3], s[8:9], s[6:7]
; GFX12-GISEL-NEXT:    buffer_load_b32 v0, v0, s[0:3], null offen th:TH_LOAD_NT scope:SCOPE_SYS
; GFX12-GISEL-NEXT:    s_clause 0x1
; GFX12-GISEL-NEXT:    s_load_b128 s[0:3], s[4:5], 0x20
; GFX12-GISEL-NEXT:    s_load_b32 s7, s[4:5], 0x30
; GFX12-GISEL-NEXT:    s_mov_b32 s4, s9
; GFX12-GISEL-NEXT:    s_wait_kmcnt 0x0
; GFX12-GISEL-NEXT:    s_mov_b32 s8, s1
; GFX12-GISEL-NEXT:    s_mov_b32 s5, s2
; GFX12-GISEL-NEXT:    v_mov_b32_e32 v1, s0
; GFX12-GISEL-NEXT:    s_or_b64 s[4:5], s[8:9], s[4:5]
; GFX12-GISEL-NEXT:    s_mov_b32 s8, s3
; GFX12-GISEL-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX12-GISEL-NEXT:    s_or_b64 s[6:7], s[8:9], s[6:7]
; GFX12-GISEL-NEXT:    s_wait_loadcnt 0x0
; GFX12-GISEL-NEXT:    buffer_store_b32 v0, v1, s[4:7], null offen th:TH_STORE_NT scope:SCOPE_SYS
; GFX12-GISEL-NEXT:    s_endpgm
entry:
  %val = load volatile i32, ptr addrspace(7) %in, !nontemporal !0
  store volatile i32 %val, ptr addrspace(7) %out, !nontemporal !0
  ret void
}

!0 = !{i32 1}
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; GFX10: {{.*}}
; GFX11: {{.*}}
; GFX12: {{.*}}
; GFX9: {{.*}}
; GFX942: {{.*}}
