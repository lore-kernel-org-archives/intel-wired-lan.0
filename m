Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69D5C56205
	for <intel-wired-lan@archiver.kernel.org>; Thu,  6 Aug 2026 16:02:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9454B406D0;
	Thu,  6 Aug 2026 16:02:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tWDWUdSyqphe; Thu,  6 Aug 2026 16:02:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 86806406D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786032159;
	bh=Yg5XgpDj8AgqqB0BK6OhjlrRk5Vk4TngM7ime0NiK3E=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iggcVb8GiWru+dJHqWcpSg3TUPdf90eSIR3H53Sg/XjSR9c9E4MR5H3/DttBynhIp
	 rKzclryr8l4rMTROg48oZwv/87KQhKlYnXHF8Ioz7BNLOiUdA39aAXry4cpmBA9u33
	 rx7vmMjlR2G3k4K85VlpRCHYW+t7Fn3jL0P/w+1lMBVOEhfvu3mrkrViUi1lHzl9WQ
	 mo4QHoR+zDStGf1WBg3nV3HqhV/B+NDwEtI/8pCH08bw0WkzuoAzZdN6lhroh+PBs4
	 4TCtgGW1Qk5X0wu7htAJhfTUh5Ksi/hURzZ+ijFmI55CCkDHGI8zcKAB7/jLRIJG4M
	 L5wNVH9tVNO7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 86806406D5;
	Thu,  6 Aug 2026 16:02:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 30781218
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 15:36:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 224BC60806
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 15:36:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 665svJX4cRsJ for <intel-wired-lan@lists.osuosl.org>;
 Thu,  6 Aug 2026 15:36:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.167.208;
 helo=mail-oi1-f208.google.com;
 envelope-from=3bkp0agkbaiu178tjuun0jyyrm.pxxpun31n0lxw2nw2.lxv@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 14183605E0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 14183605E0
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com
 [209.85.167.208])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 14183605E0
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 15:36:37 +0000 (UTC)
Received: by mail-oi1-f208.google.com with SMTP id
 5614622812f47-4ab4dd46ddeso1175224b6e.3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 06 Aug 2026 08:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786030597; x=1786635397;
 h=content-type:to:from:subject:message-id:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Yg5XgpDj8AgqqB0BK6OhjlrRk5Vk4TngM7ime0NiK3E=;
 b=HR4ZEjWkmqaen0PmygSL8SioSuPqQdoXmZf5Icl7qBoaHJdES2aePe4Fmds//f/2d4
 K4F/ATnLjwnJ9D9Rtm9heyQiOqMzlqObBgEEOTi0v1M9xpx79AnvRbzvG/hCewZOwcES
 FvdAnNrBqRYVjyeWLjLMCSX7ttgr7Pw2a8StqlMbjWQk0vv3kk2g43/oEOLycQzGZGsO
 VBDNstp6F1wCjaU7v3u72vEzdEido/hEIDGXiUGpF1OyhxngLB4+CJ4hXuPsEtGDURcC
 G01rV61gQsb0sxWcc24umR07H8Q+fh3NXy5EpBjfzB7ksltR0BOFg3bqlTY7jNfX4Cvx
 utlw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqpL8YjdfZYHsN6yvH5zPxc9W/eCNMCM5MCZGcRbl06iex5rsiGtiw9JAv4AsC8dIe7DBB2uVuWW6NRyhjuAp4=@lists.osuosl.org
X-Gm-Message-State: AOJu0YwQhJZ8MuTaT96de/Ly1bH1FUmsquZiB7Sbs/25JD+8GcGDftJ4
 FrPlv+GnDdKZE31ot5PGrq48X31rZQedD51gBs1yDtU6LqMRph3msaLT1gTnGnlCtmicAc3Fy89
 Pq5SnpfOoaCWtURwjGfDQTB8vH71xPP/GJNsNdRrM8LGZb+oUKhv5NqbIdS4=
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1927:b0:497:d371:21c8 with SMTP id
 5614622812f47-4afae27b56emr10300335b6e.19.1786030596845; Thu, 06 Aug 2026
 08:36:36 -0700 (PDT)
Date: Thu, 06 Aug 2026 08:36:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a74aa04.01d0871a.3a0d52.0025.GAE@google.com>
From: syzbot <syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net, 
 edumazet@google.com, intel-wired-lan@lists.osuosl.org, kuba@kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
 przemyslaw.kitszel@intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 06 Aug 2026 16:02:38 +0000
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=syzkaller.appspotmail.com
Subject: [Intel-wired-lan] [syzbot] [intel-wired-lan?] UBSAN:
 shift-out-of-bounds in e100_eeprom_load
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
console output: https://syzkaller.appspot.com/x/log.txt?x=15087e32580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=e0abb1d45ac291ebebeb
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ed13b9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162c5bb9580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-848acc8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6fb497cc0c8d/vmlinux-848acc8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/663ccee34982/bzImage-848acc8f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com

e1000e 0000:00:02.0 eth1: removed PHC
e1000e 0000:00:02.0 eth1: NIC Link is Down
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in drivers/net/ethernet/intel/e100.c:768:21
shift exponent 65529 is too large for 32-bit type 'int'
CPU: 0 UID: 0 PID: 5934 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x30 lib/ubsan.c:233
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
RIP: 0033:0x7f60d819e019
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc13c52ae8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f60d8425fa0 RCX: 00007f60d819e019
RDX: 000000000000000c RSI: 0000200000000280 RDI: 0000000000000005
RBP: 00007f60d823500c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f60d8425fac R14: 00007f60d8425fa0 R15: 00007f60d8425fa0
 </TASK>
---[ end trace ]---


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
