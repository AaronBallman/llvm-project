; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn -mcpu=gfx1200 -mattr=-real-true16 < %s | FileCheck %s --check-prefix=GFX12

define amdgpu_ps void @test_wmma_f32_16x16x16_f16_negA(<8 x half> %A, <8 x half> %B, <8 x float> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_f32_16x16x16_f16_negA:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_f32_16x16x16_f16 v[8:15], v[0:3], v[4:7], v[8:15] neg_lo:[1,0,0] neg_hi:[1,0,0]
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[16:17], v[8:11], off
; GFX12-NEXT:    global_store_b128 v[16:17], v[12:15], off offset:16
; GFX12-NEXT:    s_endpgm
bb:
  %fneg.A = fneg <8 x half> %A
  %res = call <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.f16.v8f16.v8f32(<8 x half> %fneg.A, <8 x half> %B, <8 x float> %C)
  store <8 x float> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_f32_16x16x16_f16_negB(<8 x half> %A, <8 x half> %B, <8 x float> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_f32_16x16x16_f16_negB:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_f32_16x16x16_f16 v[8:15], v[0:3], v[4:7], v[8:15] neg_lo:[0,1,0] neg_hi:[0,1,0]
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[16:17], v[8:11], off
; GFX12-NEXT:    global_store_b128 v[16:17], v[12:15], off offset:16
; GFX12-NEXT:    s_endpgm
bb:
  %fneg.B = fneg <8 x half> %B
  %res = call <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.f16.v8f16.v8f32(<8 x half> %A, <8 x half> %fneg.B, <8 x float> %C)
  store <8 x float> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_f32_16x16x16_f16_negC(<8 x half> %A, <8 x half> %B, <8 x float> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_f32_16x16x16_f16_negC:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_f32_16x16x16_f16 v[8:15], v[0:3], v[4:7], v[8:15] neg_lo:[0,0,1]
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[16:17], v[8:11], off
; GFX12-NEXT:    global_store_b128 v[16:17], v[12:15], off offset:16
; GFX12-NEXT:    s_endpgm
bb:
  %fneg.C = fneg <8 x float> %C
  %res = call <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.f16.v8f16.v8f32(<8 x half> %A, <8 x half> %B, <8 x float> %fneg.C)
  store <8 x float> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_f32_16x16x16_f16_absC(<8 x half> %A, <8 x half> %B, <8 x float> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_f32_16x16x16_f16_absC:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_f32_16x16x16_f16 v[8:15], v[0:3], v[4:7], v[8:15] neg_hi:[0,0,1]
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[16:17], v[8:11], off
; GFX12-NEXT:    global_store_b128 v[16:17], v[12:15], off offset:16
; GFX12-NEXT:    s_endpgm
bb:
  %fabs.C = call <8 x float> @llvm.fabs.v8f32(<8 x float> %C)
  %res = call <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.f16.v8f16.v8f32(<8 x half> %A, <8 x half> %B, <8 x float> %fabs.C)
  store <8 x float> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_f32_16x16x16_bf16_negC(<8 x i16> %A, <8 x i16> %B, <8 x float> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_f32_16x16x16_bf16_negC:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_f32_16x16x16_bf16 v[8:15], v[0:3], v[4:7], v[8:15] neg_lo:[0,0,1]
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[16:17], v[8:11], off
; GFX12-NEXT:    global_store_b128 v[16:17], v[12:15], off offset:16
; GFX12-NEXT:    s_endpgm
bb:
  %fneg.C = fneg <8 x float> %C
  %res = call <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.bf16.v8i16.v8f32(<8 x i16> %A, <8 x i16> %B, <8 x float> %fneg.C)
  store <8 x float> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_f32_16x16x16_bf16_absC(<8 x i16> %A, <8 x i16> %B, <8 x float> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_f32_16x16x16_bf16_absC:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_f32_16x16x16_bf16 v[8:15], v[0:3], v[4:7], v[8:15] neg_hi:[0,0,1]
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[16:17], v[8:11], off
; GFX12-NEXT:    global_store_b128 v[16:17], v[12:15], off offset:16
; GFX12-NEXT:    s_endpgm
bb:
  %fabs.C = call <8 x float> @llvm.fabs.v8f32(<8 x float> %C)
  %res = call <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.bf16.v8i16.v8f32(<8 x i16> %A, <8 x i16> %B, <8 x float> %fabs.C)
  store <8 x float> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_f16_16x16x16_f16_negA(<8 x half> %A, <8 x half> %B, <8 x half> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_f16_16x16x16_f16_negA:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_f16_16x16x16_f16 v[8:11], v[0:3], v[4:7], v[8:11] neg_lo:[1,0,0] neg_hi:[1,0,0]
; GFX12-NEXT:    global_store_b128 v[12:13], v[8:11], off
; GFX12-NEXT:    s_endpgm
bb:
  %fneg.A = fneg <8 x half> %A
  %res = call <8 x half> @llvm.amdgcn.wmma.f16.16x16x16.f16.v8f16.v8f16(<8 x half> %fneg.A, <8 x half> %B, <8 x half> %C, i1 0)
  store <8 x half> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_f16_16x16x16_f16_negB(<8 x half> %A, <8 x half> %B, <8 x half> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_f16_16x16x16_f16_negB:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_f16_16x16x16_f16 v[8:11], v[0:3], v[4:7], v[8:11] neg_lo:[0,1,0] neg_hi:[0,1,0]
; GFX12-NEXT:    global_store_b128 v[12:13], v[8:11], off
; GFX12-NEXT:    s_endpgm
bb:
  %fneg.B = fneg <8 x half> %B
  %res = call <8 x half> @llvm.amdgcn.wmma.f16.16x16x16.f16.v8f16.v8f16(<8 x half> %A, <8 x half> %fneg.B, <8 x half> %C, i1 0)
  store <8 x half> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_f16_16x16x16_f16_negC(<8 x half> %A, <8 x half> %B, <8 x half> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_f16_16x16x16_f16_negC:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_f16_16x16x16_f16 v[8:11], v[0:3], v[4:7], v[8:11] neg_lo:[0,0,1]
; GFX12-NEXT:    global_store_b128 v[12:13], v[8:11], off
; GFX12-NEXT:    s_endpgm
bb:
  %fneg.C = fneg <8 x half> %C
  %res = call <8 x half> @llvm.amdgcn.wmma.f16.16x16x16.f16.v8f16.v8f16(<8 x half> %A, <8 x half> %B, <8 x half> %fneg.C, i1 0)
  store <8 x half> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_f16_16x16x16_f16_absC(<8 x half> %A, <8 x half> %B, <8 x half> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_f16_16x16x16_f16_absC:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_f16_16x16x16_f16 v[8:11], v[0:3], v[4:7], v[8:11] neg_hi:[0,0,1]
; GFX12-NEXT:    global_store_b128 v[12:13], v[8:11], off
; GFX12-NEXT:    s_endpgm
bb:
  %fabs.C = call <8 x half> @llvm.fabs.v8f16(<8 x half> %C)
  %res = call <8 x half> @llvm.amdgcn.wmma.f16.16x16x16.f16.v8f16.v8f16(<8 x half> %A, <8 x half> %B, <8 x half> %fabs.C, i1 0)
  store <8 x half> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_f32_16x16x16_fp8_fp8_negC(<2 x i32> %A, <2 x i32> %B, <8 x float> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_f32_16x16x16_fp8_fp8_negC:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_f32_16x16x16_fp8_fp8 v[4:11], v[0:1], v[2:3], v[4:11] neg_lo:[0,0,1]
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[12:13], v[4:7], off
; GFX12-NEXT:    global_store_b128 v[12:13], v[8:11], off offset:16
; GFX12-NEXT:    s_endpgm
bb:
  %fneg.C = fneg <8 x float> %C
  %res = call <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.fp8.fp8.v2i32.v8f32(<2 x i32> %A, <2 x i32> %B, <8 x float> %fneg.C)
  store <8 x float> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_f32_16x16x16_fp8_fp8_absC(<2 x i32> %A, <2 x i32> %B, <8 x float> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_f32_16x16x16_fp8_fp8_absC:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_f32_16x16x16_fp8_fp8 v[4:11], v[0:1], v[2:3], v[4:11] neg_hi:[0,0,1]
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[12:13], v[4:7], off
; GFX12-NEXT:    global_store_b128 v[12:13], v[8:11], off offset:16
; GFX12-NEXT:    s_endpgm
bb:
  %fabs.C = call <8 x float> @llvm.fabs.v8f32(<8 x float> %C)
  %res = call <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.fp8.fp8.v2i32.v8f32(<2 x i32> %A, <2 x i32> %B, <8 x float> %fabs.C)
  store <8 x float> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_f32_16x16x16_bf8_fp8_negC(<2 x i32> %A, <2 x i32> %B, <8 x float> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_f32_16x16x16_bf8_fp8_negC:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_f32_16x16x16_bf8_fp8 v[4:11], v[0:1], v[2:3], v[4:11] neg_lo:[0,0,1]
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[12:13], v[4:7], off
; GFX12-NEXT:    global_store_b128 v[12:13], v[8:11], off offset:16
; GFX12-NEXT:    s_endpgm
bb:
  %fneg.C = fneg <8 x float> %C
  %res = call <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.bf8.fp8.v2i32.v8f32(<2 x i32> %A, <2 x i32> %B, <8 x float> %fneg.C)
  store <8 x float> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_f32_16x16x16_bf8_fp8_absC(<2 x i32> %A, <2 x i32> %B, <8 x float> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_f32_16x16x16_bf8_fp8_absC:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_f32_16x16x16_bf8_fp8 v[4:11], v[0:1], v[2:3], v[4:11] neg_hi:[0,0,1]
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[12:13], v[4:7], off
; GFX12-NEXT:    global_store_b128 v[12:13], v[8:11], off offset:16
; GFX12-NEXT:    s_endpgm
bb:
  %fabs.C = call <8 x float> @llvm.fabs.v8f32(<8 x float> %C)
  %res = call <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.bf8.fp8.v2i32.v8f32(<2 x i32> %A, <2 x i32> %B, <8 x float> %fabs.C)
  store <8 x float> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_f32_16x16x16_fp8_bf8_negC(<2 x i32> %A, <2 x i32> %B, <8 x float> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_f32_16x16x16_fp8_bf8_negC:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_f32_16x16x16_fp8_bf8 v[4:11], v[0:1], v[2:3], v[4:11] neg_lo:[0,0,1]
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[12:13], v[4:7], off
; GFX12-NEXT:    global_store_b128 v[12:13], v[8:11], off offset:16
; GFX12-NEXT:    s_endpgm
bb:
  %fneg.C = fneg <8 x float> %C
  %res = call <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.fp8.bf8.v2i32.v8f32(<2 x i32> %A, <2 x i32> %B, <8 x float> %fneg.C)
  store <8 x float> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_f32_16x16x16_fp8_bf8_absC(<2 x i32> %A, <2 x i32> %B, <8 x float> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_f32_16x16x16_fp8_bf8_absC:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_f32_16x16x16_fp8_bf8 v[4:11], v[0:1], v[2:3], v[4:11] neg_hi:[0,0,1]
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[12:13], v[4:7], off
; GFX12-NEXT:    global_store_b128 v[12:13], v[8:11], off offset:16
; GFX12-NEXT:    s_endpgm
bb:
  %fabs.C = call <8 x float> @llvm.fabs.v8f32(<8 x float> %C)
  %res = call <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.fp8.bf8.v2i32.v8f32(<2 x i32> %A, <2 x i32> %B, <8 x float> %fabs.C)
  store <8 x float> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_f32_16x16x16_bf8_bf8_negC(<2 x i32> %A, <2 x i32> %B, <8 x float> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_f32_16x16x16_bf8_bf8_negC:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_f32_16x16x16_bf8_bf8 v[4:11], v[0:1], v[2:3], v[4:11] neg_lo:[0,0,1]
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[12:13], v[4:7], off
; GFX12-NEXT:    global_store_b128 v[12:13], v[8:11], off offset:16
; GFX12-NEXT:    s_endpgm
bb:
  %fneg.C = fneg <8 x float> %C
  %res = call <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.bf8.bf8.v2i32.v8f32(<2 x i32> %A, <2 x i32> %B, <8 x float> %fneg.C)
  store <8 x float> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_f32_16x16x16_bf8_bf8_absC(<2 x i32> %A, <2 x i32> %B, <8 x float> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_f32_16x16x16_bf8_bf8_absC:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_f32_16x16x16_bf8_bf8 v[4:11], v[0:1], v[2:3], v[4:11] neg_hi:[0,0,1]
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[12:13], v[4:7], off
; GFX12-NEXT:    global_store_b128 v[12:13], v[8:11], off offset:16
; GFX12-NEXT:    s_endpgm
bb:
  %fabs.C = call <8 x float> @llvm.fabs.v8f32(<8 x float> %C)
  %res = call <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.bf8.bf8.v2i32.v8f32(<2 x i32> %A, <2 x i32> %B, <8 x float> %fabs.C)
  store <8 x float> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_swmmac_f32_16x16x32_f16_negA(<8 x half> %A, <16 x half> %B, <8 x float> %C, i16 %Index, ptr addrspace(1) %out) {
; GFX12-LABEL: test_swmmac_f32_16x16x32_f16_negA:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_swmmac_f32_16x16x32_f16 v[12:19], v[0:3], v[4:11], v20 neg_lo:[1,0,0] neg_hi:[1,0,0]
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[21:22], v[12:15], off
; GFX12-NEXT:    global_store_b128 v[21:22], v[16:19], off offset:16
; GFX12-NEXT:    s_endpgm
bb:
  %fneg.A = fneg <8 x half> %A
  %res = call <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.f16.v8f16.v16f16.v8f32.i16(<8 x half> %fneg.A, <16 x half> %B, <8 x float> %C, i16 %Index)
  store <8 x float> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_swmmac_f32_16x16x32_f16_negB(<8 x half> %A, <16 x half> %B, <8 x float> %C, i16 %Index, ptr addrspace(1) %out) {
; GFX12-LABEL: test_swmmac_f32_16x16x32_f16_negB:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_swmmac_f32_16x16x32_f16 v[12:19], v[0:3], v[4:11], v20 neg_lo:[0,1,0] neg_hi:[0,1,0]
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[21:22], v[12:15], off
; GFX12-NEXT:    global_store_b128 v[21:22], v[16:19], off offset:16
; GFX12-NEXT:    s_endpgm
bb:
  %fneg.B = fneg <16 x half> %B
  %res = call <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.f16.v8f16.v16f16.v8f32.i16(<8 x half> %A, <16 x half> %fneg.B, <8 x float> %C, i16 %Index)
  store <8 x float> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_swmmac_f16_16x16x32_f16_negA(<8 x half> %A, <16 x half> %B, <8 x half> %C, i16 %Index, ptr addrspace(1) %out) {
; GFX12-LABEL: test_swmmac_f16_16x16x32_f16_negA:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_swmmac_f16_16x16x32_f16 v[12:15], v[0:3], v[4:11], v16 neg_lo:[1,0,0] neg_hi:[1,0,0]
; GFX12-NEXT:    global_store_b128 v[17:18], v[12:15], off
; GFX12-NEXT:    s_endpgm
bb:
  %fneg.A = fneg <8 x half> %A
  %res = call <8 x half> @llvm.amdgcn.swmmac.f16.16x16x32.f16.v8f16.v16f16.v8f16.i16(<8 x half> %fneg.A, <16 x half> %B, <8 x half> %C, i16 %Index)
  store <8 x half> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_swmmac_f16_16x16x32_f16_negB(<8 x half> %A, <16 x half> %B, <8 x half> %C, i16 %Index, ptr addrspace(1) %out) {
; GFX12-LABEL: test_swmmac_f16_16x16x32_f16_negB:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_swmmac_f16_16x16x32_f16 v[12:15], v[0:3], v[4:11], v16 neg_lo:[0,1,0] neg_hi:[0,1,0]
; GFX12-NEXT:    global_store_b128 v[17:18], v[12:15], off
; GFX12-NEXT:    s_endpgm
bb:
  %fneg.B = fneg <16 x half> %B
  %res = call <8 x half> @llvm.amdgcn.swmmac.f16.16x16x32.f16.v8f16.v16f16.v8f16.i16(<8 x half> %A, <16 x half> %fneg.B, <8 x half> %C, i16 %Index)
  store <8 x half> %res, ptr addrspace(1) %out
  ret void
}

; both neg and abs patterns (wmma matrix C f32 or f16 )

define amdgpu_ps void @test_wmma_f32_16x16x16_f16_negabsC(<8 x half> %A, <8 x half> %B, <8 x float> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_f32_16x16x16_f16_negabsC:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_f32_16x16x16_f16 v[8:15], v[0:3], v[4:7], v[8:15] neg_lo:[0,0,1] neg_hi:[0,0,1]
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[16:17], v[8:11], off
; GFX12-NEXT:    global_store_b128 v[16:17], v[12:15], off offset:16
; GFX12-NEXT:    s_endpgm
bb:
  %fabs.C = call <8 x float> @llvm.fabs.v8f32(<8 x float> %C)
  %fneg.fabs.C = fneg <8 x float> %fabs.C
  %res = call <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.f16.v8f16.v8f32(<8 x half> %A, <8 x half> %B, <8 x float> %fneg.fabs.C)
  store <8 x float> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_f16_16x16x16_f16_negabsC(<8 x half> %A, <8 x half> %B, <8 x half> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_f16_16x16x16_f16_negabsC:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_f16_16x16x16_f16 v[8:11], v[0:3], v[4:7], v[8:11] neg_lo:[0,0,1] neg_hi:[0,0,1]
; GFX12-NEXT:    global_store_b128 v[12:13], v[8:11], off
; GFX12-NEXT:    s_endpgm
bb:
  %fabs.C = call <8 x half> @llvm.fabs.v8f16(<8 x half> %C)
  %fneg.fabs.C = fneg <8 x half> %fabs.C
  %res = call <8 x half> @llvm.amdgcn.wmma.f16.16x16x16.f16.v8f16.v8f16(<8 x half> %A, <8 x half> %B, <8 x half> %fneg.fabs.C, i1 0)
  store <8 x half> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_f32_16x16x16_f16_neg_partial_fabsA(<8 x half> %A, <8 x half> %B, <8 x float> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_f32_16x16x16_f16_neg_partial_fabsA:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_and_b32_e32 v11, 0x7fffffff, v11
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX12-NEXT:    v_wmma_f32_16x16x16_f16 v[8:15], v[0:3], v[4:7], v[8:15] neg_lo:[0,0,1]
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[16:17], v[8:11], off
; GFX12-NEXT:    global_store_b128 v[16:17], v[12:15], off offset:16
; GFX12-NEXT:    s_endpgm
bb:
  %el3 = extractelement <8 x float> %C, i32 3
  %el3.fabs = call float @llvm.fabs.f32(float %el3)
  %partial.fabs.C = insertelement <8 x float> %C, float %el3.fabs, i32 3
  %fneg.partial.fabs.C = fneg <8 x float> %partial.fabs.C
  %res = call <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.f16.v8f16.v8f32(<8 x half> %A, <8 x half> %B, <8 x float> %fneg.partial.fabs.C)
  store <8 x float> %res, ptr addrspace(1) %out
  ret void
}

; A or B matrix modifier and constant in C

define amdgpu_ps void @test_wmma_f32_16x16x16_f16_negA_constantC(<8 x half> %A, <8 x half> %B, <8 x float> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_f32_16x16x16_f16_negA_constantC:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_f32_16x16x16_f16 v[10:17], v[0:3], v[4:7], 1.0 neg_lo:[1,0,0] neg_hi:[1,0,0]
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v[8:9], v[10:13], off
; GFX12-NEXT:    global_store_b128 v[8:9], v[14:17], off offset:16
; GFX12-NEXT:    s_endpgm
bb:
  %fneg.A = fneg <8 x half> %A
  %res = call <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.f16.v8f16.v8f32(<8 x half> %fneg.A, <8 x half> %B, <8 x float> <float 1.0, float 1.0, float 1.0, float 1.0, float 1.0, float 1.0, float 1.0, float 1.0>)
  store <8 x float> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_f16_16x16x16_f16_negB_constantC(<8 x half> %A, <8 x half> %B, <8 x half> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_f16_16x16x16_f16_negB_constantC:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_f16_16x16x16_f16 v[10:13], v[0:3], v[4:7], 1.0 neg_lo:[0,1,0] neg_hi:[0,1,0]
; GFX12-NEXT:    global_store_b128 v[8:9], v[10:13], off
; GFX12-NEXT:    s_endpgm
bb:
  %fneg.B = fneg <8 x half> %B
  %res = call <8 x half> @llvm.amdgcn.wmma.f16.16x16x16.f16.v8f16.v8f16(<8 x half> %A, <8 x half> %fneg.B, <8 x half> <half 1.0, half 1.0, half 1.0, half 1.0, half 1.0, half 1.0, half 1.0, half 1.0>, i1 0)
  store <8 x half> %res, ptr addrspace(1) %out
  ret void
}

; pack f16 elements with v_perm_b32 since they don't come from same b32

define amdgpu_ps void @test_wmma_f16_16x16x16_f16_negC_pack(<8 x half> %A, <8 x half> %B, ptr %Caddr, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_f16_16x16x16_f16_negC_pack:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    flat_load_b128 v[12:15], v[8:9]
; GFX12-NEXT:    flat_load_b128 v[16:19], v[8:9] offset:16
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x101
; GFX12-NEXT:    v_and_b32_e32 v8, 0xffff, v12
; GFX12-NEXT:    v_and_b32_e32 v9, 0xffff, v14
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    v_and_b32_e32 v14, 0xffff, v16
; GFX12-NEXT:    v_and_b32_e32 v16, 0xffff, v18
; GFX12-NEXT:    v_lshl_or_b32 v12, v13, 16, v8
; GFX12-NEXT:    v_lshl_or_b32 v13, v15, 16, v9
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
; GFX12-NEXT:    v_lshl_or_b32 v14, v17, 16, v14
; GFX12-NEXT:    v_lshl_or_b32 v15, v19, 16, v16
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX12-NEXT:    v_wmma_f16_16x16x16_f16 v[12:15], v[0:3], v[4:7], v[12:15] neg_lo:[0,0,1]
; GFX12-NEXT:    global_store_b128 v[10:11], v[12:15], off
; GFX12-NEXT:    s_endpgm
bb:
  %C = load <16 x half>, ptr %Caddr
  %C_shuffle = shufflevector <16 x half> %C, <16 x half> poison, <8 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14>
  %fneg.C_shuffle = fneg <8 x half> %C_shuffle
  %res = call <8 x half> @llvm.amdgcn.wmma.f16.16x16x16.f16.v8f16.v8f16(<8 x half> %A, <8 x half> %B, <8 x half> %fneg.C_shuffle , i1 0)
  store <8 x half> %res, ptr addrspace(1) %out
  ret void
}

declare <8 x half> @llvm.fabs.v8f16(<8 x half>)
declare <8 x float> @llvm.fabs.v8f32(<8 x float>)
declare float @llvm.fabs.f32(float)

declare <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.f16.v8f16.v8f32(<8 x half>, <8 x half>, <8 x float>)
declare <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.bf16.v8i16.v8f32(<8 x i16>, <8 x i16>, <8 x float>)
declare <8 x half> @llvm.amdgcn.wmma.f16.16x16x16.f16.v8f16.v8f16(<8 x half>, <8 x half>, <8 x half>, i1 immarg)
declare <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.fp8.fp8.v2i32.v8f32(<2 x i32>, <2 x i32>, <8 x float>)
declare <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.fp8.bf8.v2i32.v8f32(<2 x i32>, <2 x i32>, <8 x float>)
declare <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.bf8.fp8.v2i32.v8f32(<2 x i32>, <2 x i32>, <8 x float>)
declare <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.bf8.bf8.v2i32.v8f32(<2 x i32>, <2 x i32>, <8 x float>)
declare <8 x float> @llvm.amdgcn.swmmac.f32.16x16x32.f16.v8f16.v16f16.v8f32.i16(<8 x half>, <16 x half>, <8 x float>, i16)
declare <8 x half> @llvm.amdgcn.swmmac.f16.16x16x32.f16.v8f16.v16f16.v8f16.i16(<8 x half>, <16 x half>, <8 x half>, i16)
