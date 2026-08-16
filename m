Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF057C5DF7E
	for <intel-wired-lan@archiver.kernel.org>; Mon, 17 Aug 2026 15:27:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 904AF407E0;
	Mon, 17 Aug 2026 15:27:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fGX5AM-7pvm7; Mon, 17 Aug 2026 15:27:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AB20C407C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786980441;
	bh=cBRmoa4xNRriE2jAWeNu1aQAmPk6Z79J1aOpYsKvHD8=;
	h=Date:In-Reply-To:From:To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=FJ6kNCTAzVU54oJBRenZRcDhdplf2FH9nyVZEnKyaG6WxrAmL7ffdOtSKDqqeW70f
	 lM6s2ZRdrO8G6sNFCjTOAzcrta5GsQYNcjVVJvz4xgooWcSqaq/7owg/JHZvSKzbh3
	 0Dy1xOYVPdRQ7Lsaxw3WSuywj9hojAIbgk76RxfoBFGbbsgaPc53N7nY2fYC7BTBiO
	 vQiwLNVx9jFMNlaUpA0KNEyl2EPZSAGBdeIw+CPl+v1+lBA12ZyYc45rWaR+dFRlwB
	 xhPtEX97/eA2s5qtDjkipBcvikJiVuJ3noHkQgAo58Ht/m17RbuiPyGfHMhT5clCJP
	 IzV4cC03DS6/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB20C407C2;
	Mon, 17 Aug 2026 15:27:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E81C194
 for <intel-wired-lan@lists.osuosl.org>; Sun, 16 Aug 2026 06:41:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 51F2940549
 for <intel-wired-lan@lists.osuosl.org>; Sun, 16 Aug 2026 06:41:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wiMUtwZ6uApF for <intel-wired-lan@lists.osuosl.org>;
 Sun, 16 Aug 2026 06:41:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.210.80;
 helo=mail-ot1-f80.google.com;
 envelope-from=3n1ubagkbalyouvgwhhanwllez.ckkchaqoanykjpajp.yki@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 45ECE4050A
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=syzkaller.appspotmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 45ECE4050A
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com
 [209.85.210.80])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 45ECE4050A
 for <intel-wired-lan@lists.osuosl.org>; Sun, 16 Aug 2026 06:41:36 +0000 (UTC)
Received: by mail-ot1-f80.google.com with SMTP id
 46e09a7af769-7ec6685adabso3557883a34.0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Aug 2026 23:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786862495; x=1787467295;
 h=content-type:to:from:subject:message-id:in-reply-to:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cBRmoa4xNRriE2jAWeNu1aQAmPk6Z79J1aOpYsKvHD8=;
 b=WcEkAPPvLO4ynklokyxaWFlk+oVUnVt+vuvjlItssiLcff4QCneuUgnCNeTU15XiGw
 OA3izXVJfUKAp+bfFzot1CS6DEb5Kfof7bQvR7DEERUx63EMPOZoh/m4EQgcuDZMymz3
 8SQFS3rF+bwaMpukBPJ9mTs5F1rzDSvcjde0XIZH8R5JgL6hPvRmuvXf+O7cMCk6Us6T
 SDD4u0KqjyV1Kf5zw3ImXKlRhSHtGst+5J5jm1V/j5C8nf/8mOfg9qnoWWfBNz/Gz1tQ
 krFhDZRJk1+H2OvjfnsBOxPUEHHaZ1MCYhvEKNV7q2Y9jSRLjn5GW5B+w1TBuDsGBYXI
 njIQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrVCBOMgVEIVrZ0+Dv8k6vSUxXYySYuxUzFvXu8Up2w0dWm6JtM8oCuzBfMiqjbtwjeAZ8b1rUBvfQRROx9zTk=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yx0tEdmOnKdHasZ3Saaq5+pYUZY21LwTswP/a1404LZu0yzaHeQ
 INVLvWmnSceFyeVST9E4fCtuTbfhCoDFtpzrAVbPNbn4GZTNwxpfY31Es3pje6fljocEHkHAaMF
 FehCRjllluqRQi74+H9+W4mu9/ywMwijI0anay6MZTILDr5CpkVJOFSQevKI=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:823:b0:6ae:8823:273f with SMTP id
 006d021491bc7-6b0d6751422mr15103132eaf.18.1786862495159; Sat, 15 Aug 2026
 23:41:35 -0700 (PDT)
Date: Sat, 15 Aug 2026 23:41:35 -0700
In-Reply-To: <6a74aa44.01d0871a.3a0d52.0029.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a815b9f.f7a79266.2f965f.000c.GAE@google.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=11ea7279580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d67342c314f228d
dashboard link: https://syzkaller.appspot.com/bug?extid=8ce4dba751e79facdc38
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14141949580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-3eb40771.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/08eda747d304/vmlinux-3eb40771.xz
kernel image: https://storage.googleapis.com/syzbot-assets/24378ecbcb01/bzImage-3eb40771.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8ce4dba751e79facdc38@syzkaller.appspotmail.com

e1000e 0000:00:03.0 0000:00:03.0 (uninitialized): Failed to initialize MSI interrupts.  Falling back to legacy interrupts.
e1000e 0000:00:03.0: The NVM Checksum Is Not Valid
BUG: unable to handle page fault for address: ffffc900031fd0b0
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 1c000067 P4D 1c000067 PUD 1d6a8067 PMD 25f44067 PTE 0
Oops: Oops: 0000 [#1] SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 5912 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:readl arch/x86/include/asm/io.h:59 [inline]
RIP: 0010:__er32 drivers/net/ethernet/intel/e1000e/e1000.h:604 [inline]
RIP: 0010:e1000_get_cfg_done_82571+0x68/0x150 drivers/net/ethernet/intel/e1000e/82571.c:850
Code: 00 00 ba 02 00 00 00 e8 c6 6e c5 04 31 ff 89 ee e8 3d 77 10 fb 85 ed 74 4e e8 c4 7c 10 fb 41 80 7d 00 00 75 5e 49 8b 44 24 08 <8b> 98 10 10 00 00 81 e3 00 00 04 00 31 ff 89 de e8 13 77 10 fb 85
RSP: 0018:ffffc900059c7850 EFLAGS: 00010246
RAX: ffffc900031fc0a0 RBX: ffff8880364795b8 RCX: ffffffff86ffdd0d
RDX: ffff8880304eca80 RSI: ffffffff86f9f6bc RDI: ffff8880364795b8
RBP: 0000000000000064 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880364795b8
R13: ffffed1006c8f2b8 R14: ffff8880364795c0 R15: 1ffff92000b38f25
FS:  00007f253b3456c0(0000) GS:ffff8880d5cde000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc900031fd0b0 CR3: 000000002ac2b000 CR4: 0000000000352ef0
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
RIP: 0033:0x7f253a39e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f253b345028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f253a625fa0 RCX: 00007f253a39e0d9
RDX: 000000000000000d RSI: 0000200000000240 RDI: 0000000000000005
RBP: 00007f253a435024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f253a626038 R14: 00007f253a625fa0 R15: 00007fff99ad0258
 </TASK>
Modules linked in:
CR2: ffffc900031fd0b0
---[ end trace 0000000000000000 ]---
RIP: 0010:readl arch/x86/include/asm/io.h:59 [inline]
RIP: 0010:__er32 drivers/net/ethernet/intel/e1000e/e1000.h:604 [inline]
RIP: 0010:e1000_get_cfg_done_82571+0x68/0x150 drivers/net/ethernet/intel/e1000e/82571.c:850
Code: 00 00 ba 02 00 00 00 e8 c6 6e c5 04 31 ff 89 ee e8 3d 77 10 fb 85 ed 74 4e e8 c4 7c 10 fb 41 80 7d 00 00 75 5e 49 8b 44 24 08 <8b> 98 10 10 00 00 81 e3 00 00 04 00 31 ff 89 de e8 13 77 10 fb 85
RSP: 0018:ffffc900059c7850 EFLAGS: 00010246
RAX: ffffc900031fc0a0 RBX: ffff8880364795b8 RCX: ffffffff86ffdd0d
RDX: ffff8880304eca80 RSI: ffffffff86f9f6bc RDI: ffff8880364795b8
RBP: 0000000000000064 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880364795b8
R13: ffffed1006c8f2b8 R14: ffff8880364795c0 R15: 1ffff92000b38f25
FS:  00007f253b3456c0(0000) GS:ffff8880d5cde000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc900031fd0b0 CR3: 000000002ac2b000 CR4: 0000000000352ef0
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
