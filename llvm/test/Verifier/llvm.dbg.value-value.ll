; RUN: llvm-as -disable-output <%s 2>&1 | FileCheck %s
; CHECK: invalid #dbg record address/value
; CHECK-NEXT: #dbg_value({{.*}})
; CHECK-NEXT: !""
; CHECK: warning: ignoring invalid debug info

define void @foo(i32 %a) {
entry:
  %s = alloca i32
  call void @llvm.dbg.value(metadata !"", i64 0, metadata !DILocalVariable(scope: !1), metadata !DIExpression()), !dbg !DILocation(scope: !1)
  ret void
}

declare void @llvm.dbg.value(metadata, i64, metadata, metadata)

!llvm.module.flags = !{!0}
!0 = !{i32 2, !"Debug Info Version", i32 3}
!1 = distinct !DISubprogram()
