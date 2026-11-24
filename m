Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553D2606A331
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Nov 2026 23:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=89rYDSYE;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=m0LXNtcq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 364CB80D17;
	Tue, 24 Nov 2026 23:57:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ImSHqlOd0NBL; Tue, 24 Nov 2026 23:57:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1892C80D02
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795564659;
	b=TgJXUtMRwvL4KhI/NvgkmHseivN6VPy90dzWIKwjwQSQdVjexdIrdHl7fUNHUOd+YrG8
	 Eqt6pOxic6cGlhjUioLMImW6FigLlfVwlrimnI8g3+giLikf5Gln1eJG97zwVrg4ywA1r
	 U1STozhnmKywAq1RAVS12w2yQiuOJU8A6ZmD+s0O9Z5uQGa7HbsCq5kJuS2C2ozqYupIk
	 RFQt7EwZPnmukchOGkyMVETPzFJemb48mQOwhtpSbDnV6Cs1wpCsYulaEEbnmRjsjYXbp
	 9vZJlNjt+O3x11PKS9wqEf+VRgHOcdEOV/L3wDTjw/Hv13pfvXk/mzM+OEsZOgWBNTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795564659;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xflsaRVWDw/j7j7UccdvzcudLLakoQDeNNfP3M0KnZA=;
	b=QwJ7G2kjQmnPWwF3JWR+W0I/dtLIobi3JFndvS0vAM/LRcDX29W2p/m03NT0x2utNNNS
	 DzwgbMkdE7PGejSD6DHS4duStJrOw+3iog4zlvF+G24E4TJBdHnndKlENwr8DI91Yagje
	 WniaIpgNm6ujQSUdH2KI0VP/2v5Pg+Rc389dGKaxUKKgkfWwE3iGlZhP/mU/jRJ1HrNXW
	 b4zOgeFtpfIKmfQjSmGBdnY8pe2Op4qAmjpg7CwuS2DVgSOS5XTLOjeiB5xvXz2k1evfL
	 /PYyyBbGqEj53RbRTbXr6mSom1Th9kCnCjJyotOs3+Jz7DSuFZ5BdaK9Yvnt9/LKRcg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795564659;
	bh=xflsaRVWDw/j7j7UccdvzcudLLakoQDeNNfP3M0KnZA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=89rYDSYEV+TEmLsIc50NJrmvXbf9MNLo/40/S0u9JeLHT6aVCPkPoMpRp/tHi29Fl
	 K0tfCrtXYTtW5mH8AqmskIcc/Cz1YszB+uIreeJ4CPbEM1iGXVxJNOMmrzaVblDfqg
	 8hrNSdCodY/Ai8eNktvCB2LaGXFCPW5mlTbYsUUNtOqztlfB3bT9NnF2bpUR4ITuwX
	 S+HGjoaMhcC6QlpN7kTUivzMIyqWGoy33QlGcM2sD0PxngtkWKt5eD3be60ROfCLmz
	 ttF4zDM3e/loX7WuTu7+i0MQNQE66rJ65zpB/f0pbF9i0hhvtWZ0/8XGkP82PJSOVG
	 /WVzt3TG9M+yA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1892C80D02;
	Tue, 24 Nov 2026 23:57:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 18ADA2F5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 23:57:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 09CA2405A1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 23:57:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fb2EHcAB2x_3 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Nov 2026 23:57:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 22C76404EC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:102:465::110"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:102:465::110; helo=mout-b-110.mailbox.org;
 envelope-from=antonio@mandelbit.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mandelbit.com header.i=@mandelbit.com
 header.a=rsa-sha256 header.s=MBO0001 header.b=m0LXNtcq
Received: from mout-b-110.mailbox.org (mout-b-110.mailbox.org
 [IPv6:2001:67c:2050:102:465::110])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 22C76404EC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 23:57:35 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4jZ09R5LgBzNlvx;
 Wed, 25 Nov 2026 00:57:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1795564651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xflsaRVWDw/j7j7UccdvzcudLLakoQDeNNfP3M0KnZA=;
 b=m0LXNtcq/2LbG2mD4m4VlkgfRKYFwbKS/LegkgV5FqAKEfNUnpXH6AYKH0aXmTdyE9b2+c
 gC1afL98daHcBi3pOUfh+7mqjbwj88WPe1LMzrhWLLeZKTGPwJx3fhhkHUktBAStTyMmjp
 J4mBpbHtO0hm7kJv1vSYwc43fP5nFs4FC6ur3FybafSu2uzX75vQBHLwPGpg79Dee3zK2a
 eb9PAHj6CN/3V+AlE3mqV1Ur6A9b9nR8wu7MKjx4feskHUoxBXG+lojxwUqxQeZPOgoPRB
 vQAq0RxWmF0yNes0CCba1hLUi2SV+0oDs+7IQht2dv8hzwi9Lw59H42sAK3pzw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=antonio@mandelbit.com
From: Antonio Quartulli <antonio@mandelbit.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Antonio Quartulli <antonio@mandelbit.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Janis Edvarts Lacis <janislacis06@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Joe Damato <joe@dama.to>,
 Sven Auhagen <sven.auhagen@voleatech.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH net v5 0/6] igb: fix runtime PM resume issues
Date: Wed, 25 Nov 2026 00:57:15 +0100
Message-ID: <20261124235723.1135808-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jZ09R5LgBzNlvx
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

igb can be runtime suspended when the link goes down (with
power/control set to auto). Resuming it calls functions that need RTNL
without holding it (patches 2 and 4), XDP and XSK changes race with a
resume (patch 5), and devices that can't signal a wake-up are suspended
anyway, so their port stays down when the link comes back (patch 6).

Patch 1 fixes the XSK pool disable path when the device has fewer rings
than the stack has queues: a NULL dereference with VFs (a single Tx
queue on 82576), or after a fallback from MSI-X to MSI on resume. Patch
3 keeps such queues while they still have an XSK pool, so that the pool
can still be disabled.

Tested with the 82576 emulated by QEMU, including, with test-only hooks,
a runtime resume and a simulated system sleep (the suspend/resume
callbacks called directly, as the test kernel has no CONFIG_SUSPEND)
with the device forced to come back with MSI and a single queue.
Patches 1 and 3 were tested with a zero-copy AF_XDP socket: closing it
after enabling a VF oopses (queue 1, stock igb and v3) or warns and
leaks (queue 2, v4), and warns after a resume forced to use MSI (v4);
patch 5 by closing a socket and attaching an XDP program while runtime
suspended. Not tested: real hardware and PME wake-up, a real system
sleep, the MSI-X allocation failure itself, the window before the work
item runs, SR-IOV with runtime PM, and a device that can wake up. Not
run under KASAN.

Sashiko also found two pre-existing issues in the XSK queue disable/
enable paths (the Tx NAPI isn't stopped when Rx and Tx don't share a
vector; a failed buffer reallocation leaves the queue half torn down);
they will be fixed separately.

igc has the same issues (see the notes); Joe Damato offered to test on
igc, so its fix will be sent separately.

Changes in v5:
- new patch 3: keep the stack's Rx queues that still have an XSK pool
  (Janis)
- patch 4: cancel the work item before a suspend (Sashiko)
- new patch 5: resume the device before changing XDP or XSK settings
  (Sashiko)
- patch 6: check pci_dev_run_wake() when scheduling the suspend
  (Sashiko)

Changes in v4:
- patch 1: also handle queues with an Rx but no Tx ring, as with VFs:
  tear down the Rx ring and skip only the Tx part (Sashiko); subject
  changed from "don't disable rings ..." to "don't touch rings ..."

Changes in v3:
- new patch 1
- patch 2: set the real queue counts on system sleep resume and from a
  work item on runtime resume, and drop packets for queues the device
  doesn't have until then (Janis, Sashiko)
- patch 3 (now 4): link the NAPIs from the same work item

Changes in v2:
- patch 2 (v2 patch 1): keep setting the queue counts in __igb_open(),
  only skipping them on resume (Sashiko)
- mention the tested hardware in the commit messages

v4: https://lore.kernel.org/netdev/20261120210134.133238-1-antonio@mandelbit.com/
v3: https://lore.kernel.org/netdev/20261119140412.163202-1-antonio@mandelbit.com/
v2: https://lore.kernel.org/netdev/20261116153041.3002666-1-antonio@mandelbit.com/
v1: https://lore.kernel.org/netdev/20261113105835.3821433-1-antonio@mandelbit.com/

Antonio Quartulli (6):
  igb: don't touch rings that don't exist when disabling an XSK pool
  igb: fix RTNL assertion when resuming from runtime suspend
  igb: keep the stack's Rx queues that still have an XSK pool
  igb: link queues to NAPIs under RTNL after runtime resume
  igb: resume the device before changing XDP or XSK settings
  igb: only allow runtime PM if the device can wake up

 drivers/net/ethernet/intel/igb/igb.h      |   1 +
 drivers/net/ethernet/intel/igb/igb_main.c | 144 +++++++++++++++++-----
 drivers/net/ethernet/intel/igb/igb_xsk.c  |  37 ++++--
 3 files changed, 143 insertions(+), 39 deletions(-)

-- 
2.56.1

