Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE2E606A33A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Nov 2026 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=PukmMD/6;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=gE+671EV
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 55E23607F3;
	Mon, 16 Nov 2026 15:30:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aR5DZQ0hhLbD; Mon, 16 Nov 2026 15:30:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8EFB5607EB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794843058;
	b=Kag3b7MhXyc+1XgBetgsW1tuNJn9dJ0xUF+9OPWZ3T0K5ArlJH+Moz8vJr0xwD2gY2XD
	 z7SnRfB4p8tP6Kg8SKu7yidwIxnvCJrEa32bN2bJOOZjNQ5NzNeln2DjlQIwuhp6ef56O
	 YHplhSe7cBNmRA/9dJvrUxVZ1hPC7rMh0CFGZA0xktEzs2xJLnXXmKgKv2zDmKYoe/xo+
	 yZ7cYPUSZVgGJaH6Vq5KXlU+47nwSc64+/MR7b/+mGStCn6uoSV6iHIa+9fe2AEfucjjG
	 uJ4hjiadUxY29XwNcW7YnmWEV3vBt9lVzeKg7UNfxayDuHqlCiwygsefMX2SL5jg73Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794843058;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CDG2+kMw+A8LdS/UvHCT6L9ztc9obDz1MKuAv6+QT7s=;
	b=cfEbMRe2+50llrKDv2M96oaBHXNYjrIfuUf9NWL7nke9ZJxVDmpQZV4wq+GWHEfxxZGI
	 Owub4XKeEQpg3D1kUSe7ZQAGadhb41Ze+/dHbU3fJjFciqfXQiLJTtIkS9d/RTfWf6fOF
	 z2aq7azp6FR8YA78pjM2AfLZ6uCNFhDsyzlB7hg7MES/6prw6DepNklIbuAGGb0OuFnim
	 /NMTLWGNJBH3d2dlPkzLcwlyJ8nCn2sea4ApRqBrUmt1mHqynjjVCIcWWkGuge/apVKJD
	 v62pZfu8MmVuX747rWth1FozbBTZ7BuE+kWRTsi1hSeSAlnjnrNWcJ/CnGEk6BiZCjQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794843058;
	bh=CDG2+kMw+A8LdS/UvHCT6L9ztc9obDz1MKuAv6+QT7s=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PukmMD/6VuxJ7a2Qrmx8pR4OU+4t4EwumXVSugHopVd+SRz7hTDpqxngY9yYW44RU
	 qivxhAU8EfjVGih7+OPEPHYCAvjUp8Q4MlIC1N4PkukpNwsQ2bTin0QhpnvFL816oF
	 d3bnwNxQJ9QOdYn5bAFF0pgvXa87K+hnyjvvOu4DUd/JuIWk43BQ+icO4hyGiG21Hh
	 AkAnEzJTzUfEUUgyGxvzyJ3iqHA48GzYuC7RfxK1D/JKTWaKTT52ysS4XH80n2wxqL
	 Vf6Qrtn3YxrS7Fp3NTLmtXkvrO8y27nGY0FBvTFZbeg0tCQmAuQwn3QR1yNkWcvuaV
	 LAKvjaGAJy5ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8EFB5607EB;
	Mon, 16 Nov 2026 15:30:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AFC7A28C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 15:30:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9A922406D7
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 15:30:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UqaNicHeTnOl for <intel-wired-lan@lists.osuosl.org>;
 Mon, 16 Nov 2026 15:30:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2814F40694
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:102:465::112"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:102:465::112; helo=mout-b-112.mailbox.org;
 envelope-from=antonio@mandelbit.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mandelbit.com header.i=@mandelbit.com
 header.a=rsa-sha256 header.s=MBO0001 header.b=gE+671EV
Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org
 [IPv6:2001:67c:2050:102:465::112])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2814F40694
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 15:30:52 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4jSsJT00SYz5wlN;
 Mon, 16 Nov 2026 16:30:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794843049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=CDG2+kMw+A8LdS/UvHCT6L9ztc9obDz1MKuAv6+QT7s=;
 b=gE+671EVtghWrZBCjDOxY/ecGHlbCPQ+wGkzJCOHk0bxqQr3m8U0XyXkjtfc09TD1uM1Rp
 RYACVf22Ge9rcyGI9BH+ET6qllSddgxUOz7F6hzk5tfCFc9eDUXIGtMC3utQjUWvo4bI43
 GGepx+n9U+/FbvTTb8jHA15vrbO4xlohzIlDO+w0ZPStbcRVBt1cSXH+cMVzEnNt1X62yW
 UXRM3Fg93Lvl0i3p1g0PT0FlO7+3K3CpDNUtPnOAzGEnxKOUCdbwgTi4Fd5IrOVpbVWiaM
 IwjFsG4JtTXvX/w1NyyN6ETvKtINRrLYv5aOta0YEvRTVIBWd8ERMtIzjD4N+A==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=antonio@mandelbit.com
From: Antonio Quartulli <antonio@mandelbit.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Antonio Quartulli <antonio@mandelbit.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Kurt Kanzenbach <kurt@linutronix.de>, Joe Damato <joe@dama.to>,
 "Yan, Zheng" <zheng.z.yan@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/3] igb: fix runtime PM resume issues
Date: Mon, 16 Nov 2026 16:30:36 +0100
Message-ID: <20261116153041.3002666-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jSsJT00SYz5wlN
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

igb can be runtime suspended when the link goes down (with
power/control set to auto). Resuming it calls functions that need RTNL
without holding it (patches 1 and 2), and devices that can't signal a
wake-up are suspended anyway, so their port stays down when the link
comes back (patch 3).

Tested with the 82576 emulated by QEMU.

Changes in v2:
- patch 1: keep setting the queue counts in __igb_open(), only skipping
  them on runtime resume (Sashiko)
- mention the tested hardware in the commit messages

v1: https://lore.kernel.org/netdev/20261113105835.3821433-1-antonio@mandelbit.com/

Antonio Quartulli (3):
  igb: fix RTNL assertion when resuming from runtime suspend
  igb: link queues to NAPIs under RTNL after runtime resume
  igb: only allow runtime PM if the device can wake up

 drivers/net/ethernet/intel/igb/igb.h      |  1 +
 drivers/net/ethernet/intel/igb/igb_main.c | 69 ++++++++++++++++++-----
 2 files changed, 57 insertions(+), 13 deletions(-)

-- 
2.56.0

