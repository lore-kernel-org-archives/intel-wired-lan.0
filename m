Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA4FC5AD7B
	for <intel-wired-lan@archiver.kernel.org>; Mon, 10 Aug 2026 15:22:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C9FB80E86;
	Mon, 10 Aug 2026 15:22:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CpJ-RBxUBV16; Mon, 10 Aug 2026 15:22:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0C5F480E73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786375328;
	bh=MHcrVMejL/6U7ZutYrRKD6/LsQCEvCJ8P9YiT8P97/A=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ghWyFKWqIQNfj1p+M4NsLis460zIMAxpe6TepLtdc5ubH0MmXhugU1GUrPcXaqgM7
	 jmu7JQgFP+cWlbgp7sneFvxVv9OzgHeyO3lwNUNuHiVXDkf559zdHi2CqLmigtJ4XQ
	 WHuWKrGHTFd87BCB0IBVR0pBwP7FFiGZud1zXUqfEWp5PXKuNyPEMpe06OOnKABVvt
	 WOraBLamF4NSV/i7wOZ33K05quhRHHe/N3Zz+CN3zGnwLoGAWlDFtvEJE/g0vYJO+A
	 PIFngAwip5zxkTSgX0d+gmUF+HQroAzUQwF5JEGPNOrRwVUukWTYYB6t+DwfnRCCe5
	 ql2epe2k/zV3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C5F480E73;
	Mon, 10 Aug 2026 15:22:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B611282
 for <intel-wired-lan@lists.osuosl.org>; Sun,  9 Aug 2026 00:10:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 490B86061D
 for <intel-wired-lan@lists.osuosl.org>; Sun,  9 Aug 2026 00:10:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K_Sde5lTaHAH for <intel-wired-lan@lists.osuosl.org>;
 Sun,  9 Aug 2026 00:10:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.167.208;
 helo=mail-oi1-f208.google.com;
 envelope-from=3esv3agkbad8tz0lbmmfsbqqje.hpphmfvtfsdpoufou.dpn@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2F87F605DE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F87F605DE
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com
 [209.85.167.208])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2F87F605DE
 for <intel-wired-lan@lists.osuosl.org>; Sun,  9 Aug 2026 00:10:34 +0000 (UTC)
Received: by mail-oi1-f208.google.com with SMTP id
 5614622812f47-4b1bc2e44e0so676086b6e.0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 08 Aug 2026 17:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786234234; x=1786839034;
 h=content-type:to:from:subject:message-id:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MHcrVMejL/6U7ZutYrRKD6/LsQCEvCJ8P9YiT8P97/A=;
 b=pe7NF1Xzgs0bl4zM+i+1U8KqnhWCdcnOSGdY8nsenMvYfKrX3JFJwjFiG/aihZVhYs
 FLyGZbiKoROfi6Y/HY0TMX4A/kLnyNosP++zdGMUzKj1KkAI6f9LyuxpxUc98jd10fd9
 EyciBL1sB36fUjbT2+63C6DSP0yA8JHu8nO8hkPcAjHIIyj7x8l68Wfp0yfSTjkeb7Bf
 IRPnnO7geOweeGQVrXxahO8Fl7y7gJSSo00L+gLfbJyAwVTpJarjvlMal9D+EURp3NHZ
 RX6FONzZXdYLx5xTyAXKXClSvSxyl6UysvEux8QG4ChyfJbk2tkBgahpGQWVoN0DsLDb
 kd9Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpdJbD8Uc6QYV9IJl8Mw39NrIQMT79797giV0oQCSmbgDkd6ANo0WIR2+m3p2u0ea0SRLCyLoUeDe8318NYx08=@lists.osuosl.org
X-Gm-Message-State: AOJu0YxvxtrWMsrdz1JttmCYcTwkxoJTRL0Com4Kcojn+bmfBfviUK8t
 dJIcRHk32ME5qLyYYjLXxuCXRks3QjpDk3J2LhLFUwm5/8SewQ7bAA6cguqoahgP16FIf4I2qU9
 NDWnZ7LbTLEDobwGLlH2wNQCx0SBX/13VWbUo52lr15k9oimHDF8paWHIIuk=
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2445:b0:497:da47:df4d with SMTP id
 5614622812f47-4afadfcf73bmr17367700b6e.16.1786234234039; Sat, 08 Aug 2026
 17:10:34 -0700 (PDT)
Date: Sat, 08 Aug 2026 17:10:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a77c57a.01d0871a.3a0d52.007a.GAE@google.com>
From: syzbot <syzbot+167d8196c0bada4210fa@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net, 
 edumazet@google.com, intel-wired-lan@lists.osuosl.org, kuba@kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
 przemyslaw.kitszel@intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 10 Aug 2026 15:22:06 +0000
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=syzkaller.appspotmail.com
Subject: [Intel-wired-lan] [syzbot] [intel-wired-lan?] kernel panic: UBSAN:
 panic_on_warn set ... (3)
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
console output: https://syzkaller.appspot.com/x/log.txt?x=16a24bb9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=167d8196c0bada4210fa
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-848acc8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6fb497cc0c8d/vmlinux-848acc8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/663ccee34982/bzImage-848acc8f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+167d8196c0bada4210fa@syzkaller.appspotmail.com

Kernel panic - not syncing: UBSAN: panic_on_warn set ...
CPU: 3 UID: 0 PID: 14356 Comm: syz.5.433 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 vpanic+0x552/0x970 kernel/panic.c:651
 panic+0xd1/0xe0 kernel/panic.c:788
 check_panic_on_warn kernel/panic.c:525 [inline]
 check_panic_on_warn.cold+0x19/0x34 kernel/panic.c:520
 __ubsan_handle_shift_out_of_bounds+0x279/0x2a0 lib/ubsan.c:494
 e100_eeprom_load.cold+0x55/0x9e drivers/net/ethernet/intel/e100.c:768
 e100_probe+0xd07/0x1ab0 drivers/net/ethernet/intel/e100.c:2921
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
RIP: 0033:0x7f53bab9e019
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f53bba7f028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f53bae26090 RCX: 00007f53bab9e019
RDX: 000000000000000c RSI: 0000200000000280 RDI: 0000000000000006
RBP: 00007f53bac3500c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f53bae26128 R14: 00007f53bae26090 R15: 00007fffaac44238
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


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
