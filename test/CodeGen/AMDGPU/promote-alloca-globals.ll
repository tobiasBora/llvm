; RUN: opt -S -mtriple=amdgcn-unknown-unknown -amdgpu-promote-alloca < %s | FileCheck -check-prefix=IR %s
; RUN: llc -march=amdgcn -mcpu=tonga < %s | FileCheck -check-prefix=ASM %s


@global_array= internal unnamed_addr addrspace(3) global [1500 x [10 x i32]] undef, align 4

; IR-LABEL: define void @promote_alloca_size_256(i32 addrspace(1)* nocapture %out, i32 addrspace(1)* nocapture %in) {
; IR: alloca [10 x i32]
; ASM-LABEL: {{^}}promote_alloca_size_256:
; ASM: ; LDSByteSize: 60000 bytes/workgroup (compile time only)

define void @promote_alloca_size_256(i32 addrspace(1)* nocapture %out, i32 addrspace(1)* nocapture %in) {
entry:
  %stack = alloca [10 x i32], align 4
  %tmp = load i32, i32 addrspace(1)* %in, align 4
  %arrayidx1 = getelementptr inbounds [10 x i32], [10 x i32]* %stack, i32 0, i32 %tmp
  store i32 4, i32* %arrayidx1, align 4
  %arrayidx2 = getelementptr inbounds i32, i32 addrspace(1)* %in, i32 1
  %tmp1 = load i32, i32 addrspace(1)* %arrayidx2, align 4
  %arrayidx3 = getelementptr inbounds [10 x i32], [10 x i32]* %stack, i32 0, i32 %tmp1
  store i32 5, i32* %arrayidx3, align 4
  %arrayidx10 = getelementptr inbounds [10 x i32], [10 x i32]* %stack, i32 0, i32 0
  %tmp2 = load i32, i32* %arrayidx10, align 4
  store i32 %tmp2, i32 addrspace(1)* %out, align 4
  %arrayidx12 = getelementptr inbounds [10 x i32], [10 x i32]* %stack, i32 0, i32 1
  %tmp3 = load i32, i32* %arrayidx12
  %arrayidx13 = getelementptr inbounds i32, i32 addrspace(1)* %out, i32 1
  store i32 %tmp3, i32 addrspace(1)* %arrayidx13
  %v = getelementptr inbounds [1500 x [10 x i32]], [1500 x [10 x i32]] addrspace(3)* @global_array, i32 0, i32 0, i32 0
  store i32 %tmp3, i32 addrspace(3)* %v
  ret void
}
