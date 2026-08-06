Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B42C56208
	for <intel-wired-lan@archiver.kernel.org>; Thu,  6 Aug 2026 16:02:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C3834072E;
	Thu,  6 Aug 2026 16:02:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id avcYEGoeDL8X; Thu,  6 Aug 2026 16:02:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AD765406D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786032161;
	bh=zvyn7tSuYfZbgeHgBXNE98REvGw/upXdVARtrfoFp/k=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fy7YCCcPjVkna7LjKdPHPlTrk1ftvs4aVS86ycvwMEEf5mraJV/gdHzKww/f0vnp8
	 dJqC4BAmXspAcQu7lykUjCI/E0CGVSxDUdc6DkYLF/rhXdb/ju6RdEIUrBBU2vjh6q
	 YxHZuzMvdCSh8LoMaT44iSXb7SxlQ7am9oObWQG9ulFZRjW774xHMVNW1WiTiJCcVR
	 Xl18AkoX0eLb+W0VWHUZBrV8a3adAJIWADsMLwSCmbmU0h6P93MK9I0pYCNryrj4SE
	 xS6V6BlSlzjGsh9GyvsFDX+deSKVTgb0+WlwIk4d432FPSo0Jg50Pmr0kKNsrAo5/t
	 1+VCdywT2NTKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD765406D5;
	Thu,  6 Aug 2026 16:02:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0898C218
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 15:37:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EE343402A4
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 15:37:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hVyili1SpMDy for <intel-wired-lan@lists.osuosl.org>;
 Thu,  6 Aug 2026 15:37:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.167.208;
 helo=mail-oi1-f208.google.com;
 envelope-from=3rkp0agkbamu39avlwwp2l00to.rzzrwp53p2nzy4py4.nzx@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D7BB240125
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D7BB240125
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com
 [209.85.167.208])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D7BB240125
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 15:37:41 +0000 (UTC)
Received: by mail-oi1-f208.google.com with SMTP id
 5614622812f47-4af9bf0f53bso2492514b6e.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 06 Aug 2026 08:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786030661; x=1786635461;
 h=content-type:to:from:subject:message-id:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zvyn7tSuYfZbgeHgBXNE98REvGw/upXdVARtrfoFp/k=;
 b=GOfLhiFTP8shqP59am3rxFzJ3GVzBuC1AB0rUkBBgXItphKnKMAP3yCBSVXM/4XjPd
 iJhT6Np7L9w7+fM3DYjKkvQM3pdmsJPiqvlorUiOJcIsUPLw8ZS2+Py9tgDdY7t6JN4i
 TBsfZttY7g9LON3DxyEAyxUznOMy5WeF3dad6EQQPwgRlcxY9e19gF46eOoD2wPSpgxv
 xXZL1isMPdtAIW3RZamfmUtkP+cShtgIK6dSTcmhlp13QFm0iG8HGrla4Aw3TiBLw5f/
 zXkqnS4LvZpHiTc/41idAiEAp+wTbT/6CwRWCqDgHV9k3Ca3EzpEz34jpLH0IR++2Ibd
 pIZw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq/oYhSbrplP7lwgtl+l0EZwpL8L6ZEcANK0qpd5wCNbc8qV12PwVKKk+E1kq+22tBOKtSIflYycWUeSupz8xQ=@lists.osuosl.org
X-Gm-Message-State: AOJu0YzS/VFmpo3L7I1rR/OG1v3uAg26/tgXzhijRd9FqPe2/U1hORZo
 AXrZKZ7bPwyyV4Sjrx7tOSrDMLsqlExtg5L0SV+Ej7YX/MX0moIhNEgchq9SjANBERjcA4X4E10
 ogjT9RAvM9hrj+bW0tEd4K+XKc8BHJDzlx1lzfNZ0y8MMEEQR11m2c4MW9Qw=
MIME-Version: 1.0
X-Received: by 2002:a05:6808:6f98:b0:4a4:82b:2a36 with SMTP id
 5614622812f47-4b133472ff2mr1090783b6e.11.1786030660811; Thu, 06 Aug 2026
 08:37:40 -0700 (PDT)
Date: Thu, 06 Aug 2026 08:37:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a74aa44.01d0871a.3a0d52.0029.GAE@google.com>
From: syzbot <syzbot+8ce4dba751e79facdc38@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net, 
 edumazet@google.com, intel-wired-lan@lists.osuosl.org, kuba@kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
 przemyslaw.kitszel@intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 06 Aug 2026 16:02:38 +0000
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=syzkaller.appspotmail.com
Subject: [Intel-wired-lan] [syzbot] [intel-wired-lan?] BUG: unable to handle
 kernel paging request in e1000_get_cfg_done_82571
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hello,

syzbot found the following issue on:

HEAD commit:    848acc8ffe1b Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=159d33b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c05be6c9b0d36cb9
dashboard link: https://syzkaller.appspot.com/bug?extid=8ce4dba751e79facdc38
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-848acc8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2425c07b5d46/vmlinux-848acc8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cf278dd14da3/bzImage-848acc8f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8ce4dba751e79facdc38@syzkaller.appspotmail.com

e1000e 0000:00:03.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
e1000e 0000:00:03.0 0000:00:03.0 (uninitialized): Failed to initialize MSI interrupts.  Falling back to legacy interrupts.
e1000e 0000:00:03.0: The NVM Checksum Is Not Valid
BUG: unable to handle page fault for address: ffffc900014c70b0
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 1b000067 P4D 1b000067 PUD 1c2b9067 PMD 313cf067 PTE 0
Oops: Oops: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5316 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:readl arch/x86/include/asm/io.h:59 [inline]
RIP: 0010:__er32 drivers/net/ethernet/intel/e1000e/e1000.h:604 [inline]
RIP: 0010:e1000_get_cfg_done_82571+0x42/0x130 drivers/net/ethernet/intel/e1000e/82571.c:850
Code: fc ff df e8 a0 97 f9 fa 4c 8d 73 08 bd 9d ff ff ff 4d 89 f4 49 c1 ec 03 43 80 3c 3c 00 74 08 4c 89 f7 e8 21 ca 68 fb 49 8b 06 <44> 8b a8 10 10 00 00 44 89 ee 81 e6 00 00 04 00 31 ff e8 a7 9b f9
RSP: 0018:ffffc9000e0bf828 EFLAGS: 00010246
RAX: ffffc900014c60a0 RBX: ffff888012ea95b8 RCX: 0000000000100000
RDX: ffffc9000f08a000 RSI: 000000000007b7ca RDI: 000000000007b7cb
RBP: 00000000ffffff9d R08: ffffffff9057c237 R09: 1ffffffff20af846
R10: dffffc0000000000 R11: ffffffff86cd8b00 R12: 1ffff110025d52b8
R13: ffff888012ea8ec0 R14: ffff888012ea95c0 R15: dffffc0000000000
FS:  00007f43c9d9e6c0(0000) GS:ffff88808c540000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc900014c70b0 CR3: 0000000045878000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 e1000_phy_hw_reset drivers/net/ethernet/intel/e1000e/e1000.h:542 [inline]
 e1000_probe+0x1fb5/0x2b20 drivers/net/ethernet/intel/e1000e/netdev.c:7725
 local_pci_probe drivers/pci/pci-driver.c:332 [inline]
 pci_call_probe drivers/pci/pci-driver.c:394 [inline]
 __pci_device_probe drivers/pci/pci-driver.c:455 [inline]
 pci_device_probe+0x431/0xc90 drivers/pci/pci-driver.c:489
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 device_driver_attach+0xe0/0x1d0 drivers/base/dd.c:1203
 bind_store+0x1d0/0x220 drivers/base/bus.c:267
 kernfs_fop_write_iter+0x3a4/0x540 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f43c8f9e019
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f43c9d9dfe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f43c9225fa0 RCX: 00007f43c8f9e019
RDX: 000000000000000d RSI: 0000200000000240 RDI: 0000000000000005
RBP: 00007f43c903500c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f43c9226038 R14: 00007f43c9225fa0 R15: 00007ffc48486068
 </TASK>
Modules linked in:
CR2: ffffc900014c70b0
---[ end trace 0000000000000000 ]---
RIP: 0010:readl arch/x86/include/asm/io.h:59 [inline]
RIP: 0010:__er32 drivers/net/ethernet/intel/e1000e/e1000.h:604 [inline]
RIP: 0010:e1000_get_cfg_done_82571+0x42/0x130 drivers/net/ethernet/intel/e1000e/82571.c:850
Code: fc ff df e8 a0 97 f9 fa 4c 8d 73 08 bd 9d ff ff ff 4d 89 f4 49 c1 ec 03 43 80 3c 3c 00 74 08 4c 89 f7 e8 21 ca 68 fb 49 8b 06 <44> 8b a8 10 10 00 00 44 89 ee 81 e6 00 00 04 00 31 ff e8 a7 9b f9
RSP: 0018:ffffc9000e0bf828 EFLAGS: 00010246
RAX: ffffc900014c60a0 RBX: ffff888012ea95b8 RCX: 0000000000100000
RDX: ffffc9000f08a000 RSI: 000000000007b7ca RDI: 000000000007b7cb
RBP: 00000000ffffff9d R08: ffffffff9057c237 R09: 1ffffffff20af846
R10: dffffc0000000000 R11: ffffffff86cd8b00 R12: 1ffff110025d52b8
R13: ffff888012ea8ec0 R14: ffff888012ea95c0 R15: dffffc0000000000
FS:  00007f43c9d9e6c0(0000) GS:ffff88808c540000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc900014c70b0 CR3: 0000000045878000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess), 3 bytes skipped:
   0:	e8 a0 97 f9 fa       	call   0xfaf997a5
   5:	4c 8d 73 08          	lea    0x8(%rbx),%r14
   9:	bd 9d ff ff ff       	mov    $0xffffff9d,%ebp
   e:	4d 89 f4             	mov    %r14,%r12
  11:	49 c1 ec 03          	shr    $0x3,%r12
  15:	43 80 3c 3c 00       	cmpb   $0x0,(%r12,%r15,1)
  1a:	74 08                	je     0x24
  1c:	4c 89 f7             	mov    %r14,%rdi
  1f:	e8 21 ca 68 fb       	call   0xfb68ca45
  24:	49 8b 06             	mov    (%r14),%rax
* 27:	44 8b a8 10 10 00 00 	mov    0x1010(%rax),%r13d <-- trapping instruction
  2e:	44 89 ee             	mov    %r13d,%esi
  31:	81 e6 00 00 04 00    	and    $0x40000,%esi
  37:	31 ff                	xor    %edi,%edi
  39:	e8                   	.byte 0xe8
  3a:	a7                   	cmpsl  %es:(%rdi),%ds:(%rsi)
  3b:	9b                   	fwait
  3c:	f9                   	stc


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
