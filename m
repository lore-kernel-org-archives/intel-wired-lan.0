Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B67C5AC80
	for <intel-wired-lan@archiver.kernel.org>; Thu,  6 Aug 2026 16:02:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BBCAE80E93;
	Thu,  6 Aug 2026 16:02:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zakNKUPRS77k; Thu,  6 Aug 2026 16:02:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 235E280E91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786032161;
	bh=4ltjwKw9xsNgldC8Auz2dE7yQ7zTtgu0hAxcZDOb6FA=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zVEEu6jaP9H6xl12vc1Of+VzggjjXhhSD9BU8J+EceU+O1mBqQj8ovda/bTEL/Cbm
	 EPWzyk9kVHFOErFfOUuguD/57WPyzwxYnp1ppyWQ1LnEbprp+IbP/sMlhNUHjwyRvn
	 uhrClwlPHe4BPy4RRQhHXRcp/nG89zE6dOEMbAHKgnPiJpVvCBqzRPqv38o9C4Q/ob
	 Rn6WYrOdXqW4XAwHAmZB7aXetRV94MBusafCwBF+5Z3SFq+vx6Nvz3ZdnHEoNL3Lf4
	 xwFwbkFZ32LKNxtfnXB4Q/CUhKtLcj4tH1TN2CbHmpgLfTHH1gvCAenpCv06St/HnD
	 LmvBgdQVi+Eiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 235E280E91;
	Thu,  6 Aug 2026 16:02:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 549FB218
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 15:36:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 52946605E0
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 15:36:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EUPd5ctCdmPg for <intel-wired-lan@lists.osuosl.org>;
 Thu,  6 Aug 2026 15:36:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.161.79;
 helo=mail-oo1-f79.google.com;
 envelope-from=3bap0agkbaiy289ukvvo1kzzsn.qyyqvo42o1myx3ox3.myw@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4099B60802
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4099B60802
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com
 [209.85.161.79])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4099B60802
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 15:36:38 +0000 (UTC)
Received: by mail-oo1-f79.google.com with SMTP id
 006d021491bc7-6ae41d2af58so1721121eaf.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 06 Aug 2026 08:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786030597; x=1786635397;
 h=content-type:to:from:subject:message-id:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4ltjwKw9xsNgldC8Auz2dE7yQ7zTtgu0hAxcZDOb6FA=;
 b=hrYCmszufENvetxEg0AEyg63x5vgBgdZLu78Cv3qL28b10tiQkzUr00RCvs0eZslyi
 65jJBWI3KcrX0fLrfYAXYsBh+kK3RidTuehe8tWo9+4LGy216rYS8RNTepf59flOaKth
 6Nm6zCs9auxOPGTJ7+/kKOnykyRYwYQ56KvJxJyKa48wDMJyY6dI8EW2SV4p5VAmQ9aG
 l4flZDVG+Em10ljp128u+pCVIMK+tNoMJixafjRoXh3iEDqEFnmUvHbXhHb6cCYi42yx
 DJpU6pDcLZg7sPi7eI9H7f0rkXVMD930fLrEhJ/B5b8+RyNwoSMab3beiusxOyJ/T6EK
 JwMA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpdK0h7jJtN39x9DCSbYQ+bdgbp/ap8DmtNRfbphGfZ3xFa0XlEdYUm4/OPgEgVVjfP4qMCuNBWGLpBqd2KPxU=@lists.osuosl.org
X-Gm-Message-State: AOJu0YxDepgEK0UIvxugptQGnaKbACwRg0HbNEIBFinUvSzAjuaVnIpo
 SOJzOLSnoh0Uxu03U6TOtLCfl4ziK25Cc8k421WhP2uMm0hOH9716V56WkSg86MMEPHEL4gAcHB
 YpcxkGzx+/wTgGK34+i3ViuxK5XVjNw3LUSsxluyZOP0wraZFC2KRC1s7nug=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1792:b0:6a3:a335:1ccd with SMTP id
 006d021491bc7-6ae96c7e7c5mr7984217eaf.8.1786030597180; Thu, 06 Aug 2026
 08:36:37 -0700 (PDT)
Date: Thu, 06 Aug 2026 08:36:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a74aa05.01d0871a.3a0d52.0026.GAE@google.com>
From: syzbot <syzbot+0ddf1022b4d5c391c09b@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net, 
 edumazet@google.com, intel-wired-lan@lists.osuosl.org, kuba@kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
 przemyslaw.kitszel@intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 06 Aug 2026 16:02:38 +0000
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=syzkaller.appspotmail.com
Subject: [Intel-wired-lan] [syzbot] [intel-wired-lan?] BUG: unable to handle
 kernel paging request in e1000_get_variants_82571
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
console output: https://syzkaller.appspot.com/x/log.txt?x=15ae93b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=0ddf1022b4d5c391c09b
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178b7649580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117c6cc6580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/32c9dc084aaa/disk-848acc8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b7604244b0a9/vmlinux-848acc8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4cd321f6fe47/bzImage-848acc8f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0ddf1022b4d5c391c09b@syzkaller.appspotmail.com

e1000e 0000:00:03.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
e1000e 0000:00:03.0 0000:00:03.0 (uninitialized): Failed to initialize MSI interrupts.  Falling back to legacy interrupts.
BUG: unable to handle page fault for address: ffffc900035b4b58
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 13fe5c067 P4D 13fe5c067 PUD 1cae3067 PMD 22725067 PTE 0
Oops: Oops: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Workqueue: sync_wq local_pci_probe_callback
RIP: 0010:readl arch/x86/include/asm/io.h:59 [inline]
RIP: 0010:__er32 drivers/net/ethernet/intel/e1000e/e1000.h:604 [inline]
RIP: 0010:e1000_init_mac_params_82571 drivers/net/ethernet/intel/e1000e/82571.c:278 [inline]
RIP: 0010:e1000_get_variants_82571+0xe08/0x1c30 drivers/net/ethernet/intel/e1000e/82571.c:320
Code: f6 ff ff e8 da 1f 0f fb 4c 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 f7 0b 00 00 49 8b 87 00 07 00 00 <8b> a8 58 5b 00 00 89 e8 31 ff 83 e0 02 89 c6 89 44 24 10 e8 10 1a
RSP: 0018:ffffc900000f7a00 EFLAGS: 00010246
RAX: ffffc900035af000 RBX: ffff88807ed91694 RCX: ffffffff86fb44f8
RDX: 1ffff1100fdb22b8 RSI: ffffffff86fb4506 RDI: ffff88801eaa2540
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff9200001ef45
R13: ffff88807ed915c0 R14: ffff88807ed915b8 R15: ffff88807ed90ec0
FS:  0000000000000000(0000) GS:ffff888123dd8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc900035b4b58 CR3: 0000000073af9000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 e1000_probe+0x1123/0x36b0 drivers/net/ethernet/intel/e1000e/netdev.c:7494
 local_pci_probe+0xdd/0x1b0 drivers/pci/pci-driver.c:332
 local_pci_probe_callback+0x35/0x80 drivers/pci/pci-driver.c:361
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
CR2: ffffc900035b4b58
---[ end trace 0000000000000000 ]---
RIP: 0010:readl arch/x86/include/asm/io.h:59 [inline]
RIP: 0010:__er32 drivers/net/ethernet/intel/e1000e/e1000.h:604 [inline]
RIP: 0010:e1000_init_mac_params_82571 drivers/net/ethernet/intel/e1000e/82571.c:278 [inline]
RIP: 0010:e1000_get_variants_82571+0xe08/0x1c30 drivers/net/ethernet/intel/e1000e/82571.c:320
Code: f6 ff ff e8 da 1f 0f fb 4c 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 f7 0b 00 00 49 8b 87 00 07 00 00 <8b> a8 58 5b 00 00 89 e8 31 ff 83 e0 02 89 c6 89 44 24 10 e8 10 1a
RSP: 0018:ffffc900000f7a00 EFLAGS: 00010246
RAX: ffffc900035af000 RBX: ffff88807ed91694 RCX: ffffffff86fb44f8
RDX: 1ffff1100fdb22b8 RSI: ffffffff86fb4506 RDI: ffff88801eaa2540
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff9200001ef45
R13: ffff88807ed915c0 R14: ffff88807ed915b8 R15: ffff88807ed90ec0
FS:  0000000000000000(0000) GS:ffff888123dd8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc900035b4b58 CR3: 0000000073af9000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	f6 ff                	idiv   %bh
   2:	ff                   	ljmp   (bad)
   3:	e8 da 1f 0f fb       	call   0xfb0f1fe2
   8:	4c 89 ea             	mov    %r13,%rdx
   b:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  12:	fc ff df
  15:	48 c1 ea 03          	shr    $0x3,%rdx
  19:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  1d:	0f 85 f7 0b 00 00    	jne    0xc1a
  23:	49 8b 87 00 07 00 00 	mov    0x700(%r15),%rax
* 2a:	8b a8 58 5b 00 00    	mov    0x5b58(%rax),%ebp <-- trapping instruction
  30:	89 e8                	mov    %ebp,%eax
  32:	31 ff                	xor    %edi,%edi
  34:	83 e0 02             	and    $0x2,%eax
  37:	89 c6                	mov    %eax,%esi
  39:	89 44 24 10          	mov    %eax,0x10(%rsp)
  3d:	e8                   	.byte 0xe8
  3e:	10 1a                	adc    %bl,(%rdx)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
