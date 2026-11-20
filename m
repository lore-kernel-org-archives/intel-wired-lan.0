Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3842E606A6B7
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Nov 2026 21:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Y9Ez6qWV;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=Ce7ciqjf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DA30816EF;
	Fri, 20 Nov 2026 21:01:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i6_4uN_VumxS; Fri, 20 Nov 2026 21:01:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EFD14816A3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795208507;
	b=Rbe5WQvvnJ7i5ZwnqR/8+xnVWc/SyEYHQiNM9mZK8Au4wJ079Gi6U5INQmxrJWmZ9gmD
	 R3NIjnmdIYXMrVz03PptzejwzdR+RNyJTQRi+qTyeLNtRWcal5PqULNMMwo3jkYLmL85d
	 xbwN222RjlTGwmeNNTsyPmCP5lmj+AmvYNFrZ9BRut72GQHCxxXW2+pSt33uhre4xvrHS
	 6PrdemDTdtIlDR+/ZdPNP+APcEQAyyoAIto6kY8AsYtiX5Ak+YZATe9pFCS3+Ww1CKr4a
	 HWGKklwsMwzghFoZU6/ahYk7tQrHkQ8CZxxLgYbXm3SnrYPisy3WpSZ8D4QU8gGG/aQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795208507;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UjVL1Qc7n3db7V4lWVOqeGzt5DSdlZNSRU7y5NWVihM=;
	b=oJT0VZbusY2/+HxHcEAwnAoiwpQKuRgWjBtlXU5LOQHm36KeA9qcj5rKRVIZPnfpYH/5
	 tJfA9DoqmUhyP+66P14gU6fD5kXL9ZHNhmR37PfZPqeb/w1SZ9YGznoQyvy0IiUsEg7V+
	 1SwCQGg8c1VBiVqQVDmMyMkpgD3Fw9Zi5yjYcpGAnLPNmLck7YBdWguV+RikWYyezVWpm
	 xs2qq6bZ1wWU4CmSgQ5sMNPHgoZE/4+Rr8fq45YinvH944nW8IfL7Rp92kN6o7/dLdMht
	 nQ9NxIZlk1/WnHIvhqJyII+xouHkg7nXHWBdWr3KXxSYdZwMPVPANHLuM+3Moxt/mKA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795208507;
	bh=UjVL1Qc7n3db7V4lWVOqeGzt5DSdlZNSRU7y5NWVihM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Y9Ez6qWV++NMZBzCgJJzjC3vEXfaVMsGQfyeBm86b0Lxgf3UdaORrSgA3NiypqcDN
	 XtnWrppiz2O8T49US7qejARTN/7YEEqZVcuGO+lStK6ypw3yveoMjSLNc+XX7tm3t6
	 vX+hhX6Ow/+OQ+kn0PAHr3u4OWT67ou3juwi0qvnSrUW4WyjAhpqUsixjSexFfTO69
	 +OfAfzdiHLhHT0tZXAiyWTkU/6Zd6sudesFqk14rzGqTiMnQOh7WzOfs7glkHVhNbw
	 cr+ojyrvy7CVfy9O7819MDSeuIfzca1DKTjKHwtGrVqGdWubQQKJGqmR46gO5wh+d0
	 nh+l628TFdGow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EFD14816A3;
	Fri, 20 Nov 2026 21:01:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 59B94971
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 21:01:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4BE6540AB0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 21:01:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rxbdamx_wcwR for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Nov 2026 21:01:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C342340AE3
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=195.10.208.52
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.10.208.52;
 helo=mout-b-203.mailbox.org; envelope-from=antonio@mandelbit.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mandelbit.com header.i=@mandelbit.com
 header.a=rsa-sha256 header.s=MBO0001 header.b=Ce7ciqjf
Received: from mout-b-203.mailbox.org (mout-b-203.mailbox.org [195.10.208.52])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C342340AE3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 21:01:43 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA512) (No client certificate requested)
 by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4jWSSM0z9CzLmBH;
 Fri, 20 Nov 2026 22:01:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1795208499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=UjVL1Qc7n3db7V4lWVOqeGzt5DSdlZNSRU7y5NWVihM=;
 b=Ce7ciqjfyhjpC07H4D/uYPabi8vFezYqLbmI+zeBhbPCprnlMvVTyRvSCR+sUjxAZ0KUXe
 SWfg9XkyoSNyjCkQnPQnh8O4tCFwYklndgR68fld1FEx4P+oX76TQMfDzX/Lua/XkLMCdD
 H0w6PZY/smfhtqySM+ApI+KFZzta/m6LYsT6GtMbZ/3FBrOTTHZ9AslXCefIL1yITG9egf
 G1eoplXSHFAD2Z0vh5g5lzDIvBLdaVJhr9weoDdsP/2GbQASdEFm1LSe78fMXH6aRKbeNE
 toSvBUVwMG1xF7KGPXncwUjUFjP+W0NFmj1GtOGNr8rF93j/6/CdhoowFligtg==
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
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH net v4 0/4] igb: fix runtime PM resume issues
Date: Fri, 20 Nov 2026 22:01:28 +0100
Message-ID: <20261120210134.133238-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jWSSM0z9CzLmBH
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
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

igb can be runtime suspended when the link goes down (with
power/control set to auto). Resuming it calls functions that need RTNL
without holding it (patches 2 and 3), and devices that can't signal a
wake-up are suspended anyway, so their port stays down when the link
comes back (patch 4). Patch 1 fixes the XSK pool disable path when the
device has fewer rings than the stack has queues: a NULL dereference
with VFs (a single Tx queue on 82576), or after a fallback from MSI-X to
MSI on resume.

Tested with the 82576 emulated by QEMU, including, with test-only hooks,
a runtime resume and a simulated system sleep (the suspend/resume
callbacks called directly, as the test kernel has no CONFIG_SUSPEND)
with the device forced to come back with MSI and a single queue. Not
tested: real hardware and PME wake-up, a real system sleep, the MSI-X
allocation failure itself, the window before the work item runs, and
SR-IOV with runtime PM. Patch 1 was tested with a zero-copy AF_XDP socket
on queue 1: closing it after enabling a VF oopses in
igb_txrx_ring_disable() with stock igb and v3, not with v4, and the Rx
ring then no longer references the pool. Not run under KASAN.

igc has the same issues (see the notes); Joe Damato offered to test on
igc, so its fix will be sent separately.

Changes in v4:
- patch 1: also handle queues with an Rx but no Tx ring, as with VFs:
  tear down the Rx ring and skip only the Tx part (Sashiko); subject
  changed from "don't disable rings ..." to "don't touch rings ..."

Changes in v3:
- new patch 1
- patch 2: set the real queue counts on system sleep resume and from a
  work item on runtime resume, and drop packets for queues the device
  doesn't have until then (Janis, Sashiko)
- patch 3: link the NAPIs from the same work item

Changes in v2:
- patch 2 (v2 patch 1): keep setting the queue counts in __igb_open(),
  only skipping them on resume (Sashiko)
- mention the tested hardware in the commit messages

v3: https://lore.kernel.org/netdev/20261119140412.163202-1-antonio@mandelbit.com/
v2: https://lore.kernel.org/netdev/20261116153041.3002666-1-antonio@mandelbit.com/
v1: https://lore.kernel.org/netdev/20261113105835.3821433-1-antonio@mandelbit.com/

Antonio Quartulli (4):
  igb: don't touch rings that don't exist when disabling an XSK pool
  igb: fix RTNL assertion when resuming from runtime suspend
  igb: link queues to NAPIs under RTNL after runtime resume
  igb: only allow runtime PM if the device can wake up

 drivers/net/ethernet/intel/igb/igb.h      |  1 +
 drivers/net/ethernet/intel/igb/igb_main.c | 96 +++++++++++++++++------
 drivers/net/ethernet/intel/igb/igb_xsk.c  | 37 ++++++---
 3 files changed, 100 insertions(+), 34 deletions(-)

-- 
2.56.1

