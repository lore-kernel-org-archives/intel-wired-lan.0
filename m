Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2043EC5CFC1
	for <intel-wired-lan@archiver.kernel.org>; Tue, 11 Aug 2026 23:12:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC467608CB;
	Tue, 11 Aug 2026 23:12:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T17ouCPl8N9N; Tue, 11 Aug 2026 23:12:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1A96E608BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786489952;
	bh=1LqL5TggMkhC4wrO4V0tjN9INYAr5s6XDVGPuhKjlpQ=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NXpQc74HUpZxXVFAuIMg68btHhXDMFTyKXQKBid/LR//5GNasveZzOlG0ppc5J3S/
	 OPGfiMCWG9Be6UidRQIJeJhB5FVt3/iRwmN5WzxsBuhz7ptU6IsmRkLGkcG0qbgN+j
	 FczJmrsDq6L4sFG1L/ObvkMxceI9DSxAqStEtFno5fa7MIl0Sned03ie9ulFDwrLdk
	 SElO33e3lBYXIvwpnMUhNhmTfwz5uqtr3Ir6fvSEXL65N8q59wqM9gGoIAHCewlIdn
	 wCF9IA/mnGVYuPzYJwFxAZTfZdQt9P8UoIW9GL4Y3GDQNeLT+nmgf1fd39Tb0xntYi
	 gp9zefFuij/QQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A96E608BB;
	Tue, 11 Aug 2026 23:12:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9BAF7259
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Aug 2026 20:32:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 815A440251
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Aug 2026 20:32:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rs8JF6l8lYLV for <intel-wired-lan@lists.osuosl.org>;
 Tue, 11 Aug 2026 20:32:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.167.197;
 helo=mail-oi1-f197.google.com;
 envelope-from=32oz7agkbadeflmxnyyrenccvq.tbbtyrhfrepbagrag.pbz@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 764304020D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 764304020D
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 764304020D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Aug 2026 20:32:27 +0000 (UTC)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-4a416619e8dso402103b6e.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Aug 2026 13:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786480346; x=1787085146;
 h=content-type:to:from:subject:message-id:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1LqL5TggMkhC4wrO4V0tjN9INYAr5s6XDVGPuhKjlpQ=;
 b=HbuXmf6hRqkgWr/KQdhD57QiLj0wbGKMFUP/WC0odRz1QRjAaKKdUzthym2RTNuLRc
 pLwUVorH85V0haSIMaKLU44s6W17QClWdrcwKY4C7XVbw/bZFaTq3r5r7DzLU/bU1LH9
 zqO3jaL45+QlnDrJyRh7JzIi3dU47dVEgQ6Y2p9jqQhZxP7db3zarfpTNePVqhgZ0c72
 osx4bxI8lXg6jvdTyLXpFhkvWnNVC7JZ5Nqiv0T2WaMtQ/cTRZqFNdKRk9QT/6q00/GE
 CQvJREofGk+wJsTQrVDttvx5vugkHj4NqZ1zWBVQYSbciiahBYtovvJDP0gektdCwJHx
 x3fA==
X-Gm-Message-State: AOJu0YzgQ2h86GWxcYp69jYG2mhB2peSDP2iGGyGyKrUtELx94vdLnqX
 uQfDA7QUGHOCCkiDEAjSeWvweMhP4sSzFzLZhXP9XQ8QCF7auGeutdeHi6MdCnwyqpNFNx+RIJa
 MMrv7viHCeLldskDVbRYkZ24bsEFLpD0vHpg0/q9N8ZRgB4l0nVgQu3065F4=
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1c0b:b0:4a4:989:bb1f with SMTP id
 5614622812f47-4b20900d6bamr2225175b6e.9.1786480346381; Tue, 11 Aug 2026
 13:32:26 -0700 (PDT)
Date: Tue, 11 Aug 2026 13:32:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7b86da.3668565d.e8814.0004.GAE@google.com>
From: syzbot <syzbot+list9a0236217be7a8ef1662@syzkaller.appspotmail.com>
To: intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 11 Aug 2026 23:12:31 +0000
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=syzkaller.appspotmail.com
Subject: [Intel-wired-lan] [syzbot] Monthly intel-wired-lan report (Aug 2026)
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

Hello intel-wired-lan maintainers/developers,

This is a 31-day syzbot report for the intel-wired-lan subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/intel-wired-lan

During the period, 3 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 2 have already been fixed.
There is also 1 low-priority issue.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 9       Yes   BUG: unable to handle kernel paging request in e1000_get_variants_82571
                  https://syzkaller.appspot.com/bug?extid=0ddf1022b4d5c391c09b
<2> 8       No    kernel panic: UBSAN: panic_on_warn set ... (3)
                  https://syzkaller.appspot.com/bug?extid=167d8196c0bada4210fa
<3> 3       No    BUG: unable to handle kernel paging request in e1000_get_cfg_done_82571
                  https://syzkaller.appspot.com/bug?extid=8ce4dba751e79facdc38

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
