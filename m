Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C71C5DF7A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 17 Aug 2026 15:27:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49F3F6078D;
	Mon, 17 Aug 2026 15:27:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g4Y2CNPUBzsE; Mon, 17 Aug 2026 15:27:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 445256078F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786980442;
	bh=bWBxWeN+PrBCWKECGhpw+SwY5KcGyzTXh/pPfmx183o=;
	h=Date:In-Reply-To:From:To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=Yxk7q4CgVFFpP+6hU7bFs38uWGookPpsOvbbQcA2wmNEAMpcCPBmuuoX6wf72HpdD
	 SDTz2Z216HC+abTZWeQ9jeuzxs6q2KosnL42vzUc8I6z0951mPvQ2Lrg3Sc99T91/H
	 GvjquzqkFSkAKAm+yoSZjvMrlpNJrTFvN0POOM36qK2AQO/yiK6Dg+RGV8Uq92ZreC
	 B4OOA/lj3ER1Hz2cjSwDlMNaqEnm1984MAORt+kd2GPbRq8hQg5OSB4PTC6Zeo0Gi6
	 L0E3fMbUZGXPZdQYNVZnQpmElhJzonNEJhZheYUQ4u6siWhOZ3lTcdEBXZSKWBOEMX
	 v/NpUKuiQo/Aw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 445256078F;
	Mon, 17 Aug 2026 15:27:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 84B03336
 for <intel-wired-lan@lists.osuosl.org>; Sun, 16 Aug 2026 07:29:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6B23D400FE
 for <intel-wired-lan@lists.osuosl.org>; Sun, 16 Aug 2026 07:29:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QEcLUcvCcw2r for <intel-wired-lan@lists.osuosl.org>;
 Sun, 16 Aug 2026 07:29:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.167.207;
 helo=mail-oi1-f207.google.com;
 envelope-from=302abagkbaaiu01mcnngtcrrkf.iqqingwugteqpvgpv.eqo@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 630C84006B
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=syzkaller.appspotmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 630C84006B
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com
 [209.85.167.207])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 630C84006B
 for <intel-wired-lan@lists.osuosl.org>; Sun, 16 Aug 2026 07:29:24 +0000 (UTC)
Received: by mail-oi1-f207.google.com with SMTP id
 5614622812f47-4b26d8d2498so828191b6e.2
 for <intel-wired-lan@lists.osuosl.org>; Sun, 16 Aug 2026 00:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786865363; x=1787470163;
 h=content-type:to:from:subject:message-id:in-reply-to:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bWBxWeN+PrBCWKECGhpw+SwY5KcGyzTXh/pPfmx183o=;
 b=Xpf7GbNlmlaDvWhfmSOYNiMnC196MqSExZRh2Etm0ceWFrvqp5yJlJcbpMUZOjWi4k
 07GDGi1oFyIN29O7Udc0w1o/aIy62yQX45kCzGESjLCMIf1/FpW6sNyMSwcyiGO1yQR7
 KYUUv/cdnSSQE9ZLvExXpyurF67SVrL9Qe9k+oAtpXbn7sP/Fw/iH/m1vwRb555aJ6EH
 HNlAXqRODBEKJXeJ5+sxIqeFE6U0Mmx6IK28cLqywgELIMWyxycUDM2xg4Qk0CpqKZkJ
 9uHQcBuInDUVF6siZvIIxWCdLQ2j5OHMXKK6/zHqhF481R18Ax9HJqte6HPt18lhz3Ib
 B/yg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro0vcoa5wWe2Nzc9Lt3wpB8eVeJ10xCyxDMooV/7waP8RZFX8pAYGlTQxPqjnyU3TcCkdyAk2UmTmj6kM3sZpA=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yzxxr4oaO7b21QAWJQ8I6WigRY0tMlxzMwf9M4bTJGORFUNC3nE
 8D5gGdsQHnlXIigqTT8Iohp8CoXmCryEwdZMVxIbzz7/NZhsuVV8pm5WIOQXHmufh7ewgk9i8eS
 qoZHNGoAEknoo2XP/T7r4lkR8btEr6LNEHrDeRvfr28YU9GPEdkf5oto04Kc=
MIME-Version: 1.0
X-Received: by 2002:a05:6808:f07:b0:495:da3c:1aa with SMTP id
 5614622812f47-4b241e16cbfmr16800896b6e.16.1786865363281; Sun, 16 Aug 2026
 00:29:23 -0700 (PDT)
Date: Sun, 16 Aug 2026 00:29:23 -0700
In-Reply-To: <6a74aa44.01d0871a.3a0d52.0029.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8166d3.f7a79266.2f965f.000f.GAE@google.com>
From: syzbot <syzbot+8ce4dba751e79facdc38@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, andrew@lunn.ch, anthony.l.nguyen@intel.com, 
 davem@davemloft.net, edumazet@google.com, intel-wired-lan-owner@osuosl.org, 
 intel-wired-lan@lists.osuosl.org, kuba@kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
 przemyslaw.kitszel@intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 17 Aug 2026 15:27:18 +0000
Subject: Re: [Intel-wired-lan] [syzbot] [intel-wired-lan?] BUG: unable to
 handle kernel paging request in e1000_get_cfg_done_82571
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    3eb40771c00a Merge tag 'soc-fixes-7.2-3' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1553c6c6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d67342c314f228d
dashboard link: https://syzkaller.appspot.com/bug?extid=8ce4dba751e79facdc38
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c39279580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17167279580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-3eb40771.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/08eda747d304/vmlinux-3eb40771.xz
kernel image: https://storage.googleapis.com/syzbot-assets/24378ecbcb01/bzImage-3eb40771.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8ce4dba751e79facdc38@syzkaller.appspotmail.com

e1000e 0000:00:03.0: The NVM Checksum Is Not Valid
BUG: unable to handle page fault for address: ffffc9000374c0b0
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 1c000067 P4D 1c000067 PUD 1d6a8067 PMD 2645e067 PTE 0
Oops: Oops: 0000 [#1] SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 5948 Comm: syz.3.20 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:readl arch/x86/include/asm/io.h:59 [inline]
RIP: 0010:__er32 drivers/net/ethernet/intel/e1000e/e1000.h:604 [inline]
RIP: 0010:e1000_get_cfg_done_82571+0x68/0x150 drivers/net/ethernet/intel/e1000e/82571.c:850
Code: 00 00 ba 02 00 00 00 e8 c6 6e c5 04 31 ff 89 ee e8 3d 77 10 fb 85 ed 74 4e e8 c4 7c 10 fb 41 80 7d 00 00 75 5e 49 8b 44 24 08 <8b> 98 10 10 00 00 81 e3 00 00 04 00 31 ff 89 de e8 13 77 10 fb 85
RSP: 0018:ffffc90003737850 EFLAGS: 00010246
RAX: ffffc9000374b0a0 RBX: ffff88802c8d15b8 RCX: ffffffff86ffdd0d
RDX: ffff888024450000 RSI: ffffffff86f9f6bc RDI: ffff88802c8d15b8
RBP: 0000000000000064 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88802c8d15b8
R13: ffffed100591a2b8 R14: ffff88802c8d15c0 R15: 1ffff920006e6f25
FS:  00007f474f1f86c0(0000) GS:ffff8880d5cde000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000374c0b0 CR3: 000000002793c000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 e1000e_phy_hw_reset_generic+0x1f2/0x260 drivers/net/ethernet/intel/e1000e/phy.c:2167
 e1000_phy_hw_reset drivers/net/ethernet/intel/e1000e/e1000.h:542 [inline]
 e1000_probe+0x2446/0x36b0 drivers/net/ethernet/intel/e1000e/netdev.c:7725
 local_pci_probe+0xdd/0x1b0 drivers/pci/pci-driver.c:332
 pci_call_probe+0x176/0x800 drivers/pci/pci-driver.c:394
 __pci_device_probe drivers/pci/pci-driver.c:455 [inline]
 pci_device_probe+0x1cd/0x370 drivers/pci/pci-driver.c:489
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x20e/0x450 drivers/base/dd.c:868
 device_driver_attach+0xd1/0x220 drivers/base/dd.c:1203
 bind_store+0xf4/0x190 drivers/base/bus.c:267
 drv_attr_store+0x74/0xb0 drivers/base/bus.c:125
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f474e39e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f474f1f8028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f474e625fa0 RCX: 00007f474e39e0d9
RDX: 000000000000000d RSI: 0000200000000240 RDI: 0000000000000005
RBP: 00007f474e435024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f474e626038 R14: 00007f474e625fa0 R15: 00007fff59364b48
 </TASK>
Modules linked in:
CR2: ffffc9000374c0b0
---[ end trace 0000000000000000 ]---
RIP: 0010:readl arch/x86/include/asm/io.h:59 [inline]
RIP: 0010:__er32 drivers/net/ethernet/intel/e1000e/e1000.h:604 [inline]
RIP: 0010:e1000_get_cfg_done_82571+0x68/0x150 drivers/net/ethernet/intel/e1000e/82571.c:850
Code: 00 00 ba 02 00 00 00 e8 c6 6e c5 04 31 ff 89 ee e8 3d 77 10 fb 85 ed 74 4e e8 c4 7c 10 fb 41 80 7d 00 00 75 5e 49 8b 44 24 08 <8b> 98 10 10 00 00 81 e3 00 00 04 00 31 ff 89 de e8 13 77 10 fb 85
RSP: 0018:ffffc90003737850 EFLAGS: 00010246
RAX: ffffc9000374b0a0 RBX: ffff88802c8d15b8 RCX: ffffffff86ffdd0d
RDX: ffff888024450000 RSI: ffffffff86f9f6bc RDI: ffff88802c8d15b8
RBP: 0000000000000064 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88802c8d15b8
R13: ffffed100591a2b8 R14: ffff88802c8d15c0 R15: 1ffff920006e6f25
FS:  00007f474f1f86c0(0000) GS:ffff8880d5cde000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000374c0b0 CR3: 000000002793c000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	ba 02 00 00 00       	mov    $0x2,%edx
   7:	e8 c6 6e c5 04       	call   0x4c56ed2
   c:	31 ff                	xor    %edi,%edi
   e:	89 ee                	mov    %ebp,%esi
  10:	e8 3d 77 10 fb       	call   0xfb107752
  15:	85 ed                	test   %ebp,%ebp
  17:	74 4e                	je     0x67
  19:	e8 c4 7c 10 fb       	call   0xfb107ce2
  1e:	41 80 7d 00 00       	cmpb   $0x0,0x0(%r13)
  23:	75 5e                	jne    0x83
  25:	49 8b 44 24 08       	mov    0x8(%r12),%rax
* 2a:	8b 98 10 10 00 00    	mov    0x1010(%rax),%ebx <-- trapping instruction
  30:	81 e3 00 00 04 00    	and    $0x40000,%ebx
  36:	31 ff                	xor    %edi,%edi
  38:	89 de                	mov    %ebx,%esi
  3a:	e8 13 77 10 fb       	call   0xfb107752
  3f:	85                   	.byte 0x85


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
