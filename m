Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA72606A326
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=AS9XKw+t;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=v6VIYYlx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C215A60602;
	Thu, 19 Nov 2026 14:04:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pmgBU76rt6kt; Thu, 19 Nov 2026 14:04:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C20706066D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795097066;
	b=suYFOa/3bs8XyN4pu6QZRbPVTQIPaikQPsOpy01ZKtlAGwDeDW0KM0LH08+zubijW6ik
	 N8nEHCGZEixPViB43m4VQtRGTJEfcHsPrFsnjZFG7iXGLt4ei5he7hyZhV9clajdf8nLJ
	 e9Vs9BF37ANdwOzZHfo9joXoa7HBY6kU5j6oz/lGmYXDhSP1lhtG+l4U7VeA9jk48GiQS
	 lvOjbTvGFOoZQCkYQAo6AuCmYfqvMFiA5bBbcsXOvjdN155vuJpdhlaKyPirPpJAYuWrX
	 NdRSlFvXY2WNqsdUWm7ppicsK43nrktGJtuSXf5/G4oarCmCzqGzkvnKK4MKAtM8hQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795097066;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=e6oXbuZroz8JuDwbf/JEPi4sUfj0w3WvHzrO0wj5gvg=;
	b=YYcWNJclvoXV9e/7yUWMOPqj+5nRDThmn/wV3JUcSweRiThnDweN9KPjq4Q0RJnUuFFL
	 4EqOMw8S8qXon8OlT+iJsZvKD5An20HffcC28N6wYE5FhQ++A5B3+lo7HBi+zmzStc7Kw
	 QwX+KEiCfsqKB33sKBW0RW8Ftxog6J0JFycMr6CExC4ZzOncTNmfoy3TPH1WlR9xuOyVM
	 C4Oyai4dPO0m7pnFUbhVy9clrFXpAsRkeEdDQbls9wqv14z+OtmQAisLRewp5wKuRfzJ6
	 hFE6nAj2o5kKjGC/FyLXBCNojFqkGAS8QRBXHtGRA4I/Ze2pFp1aGEkwZySt/KRfIOQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795097066;
	bh=e6oXbuZroz8JuDwbf/JEPi4sUfj0w3WvHzrO0wj5gvg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AS9XKw+tviDVDU9K5BlhXKnaCeTkiblCEkJbQotEOaVzJugyS+15CLJGrmRfbbttW
	 cv/jp28FpmL4Lf7fvJxxcMc19NP2k9piy0sxsxRlr+S9ngfG3SoB9os4ITJoJXAOg8
	 vcInEdbhhIAmDkPSZyj5hFI4ooi+GprQYILT3wPJyRV0bNBmfKQJTSEyCfrdF5oSkL
	 1MuEe6zsgVYKUyugUWRnACGVDJyz8Fii0p9ezF2vN3DHehEsw1/U6mSnzgsVtQdoEZ
	 woCkTxwxzZPfIugnqO4InWFowT+bkDuymUPae8hNI4PBBrRUuZYvY8GH4JQN665cnJ
	 4OAQOxAa08rfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C20706066D;
	Thu, 19 Nov 2026 14:04:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7022C22B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:04:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5F5C5405B7
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:04:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YwJmSY9yXtFD for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 14:04:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2BB0340555
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=195.10.208.47
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.10.208.47;
 helo=mout-b-107.mailbox.org; envelope-from=antonio@mandelbit.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mandelbit.com header.i=@mandelbit.com
 header.a=rsa-sha256 header.s=MBO0001 header.b=v6VIYYlx
Received: from mout-b-107.mailbox.org (mout-b-107.mailbox.org [195.10.208.47])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2BB0340555
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:04:22 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4jVgFG4tGmz3xTD;
 Thu, 19 Nov 2026 15:04:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1795097058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=e6oXbuZroz8JuDwbf/JEPi4sUfj0w3WvHzrO0wj5gvg=;
 b=v6VIYYlxbXPZEfVMDV8/vAIwMqcOnpgLz3zLMoYTB996BZ1u3qCv4uLsdVvkybFcIgoK+y
 6zquKS72T1skKTK5QPxvPGZD1PuKs2TFyXz3hZl8Ag+GRqJEhNbfxpVvQkhs31+yIFKdKj
 2zVytGqlgb4pXBpTCNdfFbmlPev2nFEnwPGTpWF1w97njok9VfFbVG5QDIoptxiyviEhGb
 nE/pjwsvFaT/nd0ePCsbOWDPTKGiS+FtPedGJ/e+M3GL36koOjtAMouBU7Fyt3JHuZy9ET
 ika4xwQqFSxls5WdFIa687wcbQFMFldaoivvqWKJ4fQpxnkTFpT4h8YR/L9mNQ==
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
Subject: [PATCH net v3 0/4] igb: fix runtime PM resume issues
Date: Thu, 19 Nov 2026 15:04:06 +0100
Message-ID: <20261119140412.163202-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jVgFG4tGmz3xTD
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

igb can be runtime suspended when the link goes down (with
power/control set to auto). Resuming it calls functions that need RTNL
without holding it (patches 2 and 3), and devices that can't signal a
wake-up are suspended anyway, so their port stays down when the link
comes back (patch 4). Patch 1 fixes a NULL dereference in the XSK pool
disable path when the stack has more queues than the device, which can
happen after a fallback from MSI-X to MSI on resume.

Tested with the 82576 emulated by QEMU, including, with test-only hooks,
a runtime resume and a simulated system sleep (the suspend/resume
callbacks called directly, as the test kernel has no CONFIG_SUSPEND)
with the device forced to come back with MSI and a single queue. Not
tested: real hardware and PME wake-up, a real system sleep, the MSI-X
allocation failure itself, the window before the work item runs, and
SR-IOV.

igc has the same issues (see the notes); Joe Damato offered to test on
igc, so its fix will be sent separately.

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

v2: https://lore.kernel.org/netdev/20261116153041.3002666-1-antonio@mandelbit.com/
v1: https://lore.kernel.org/netdev/20261113105835.3821433-1-antonio@mandelbit.com/

Antonio Quartulli (4):
  igb: don't disable rings that don't exist when disabling an XSK pool
  igb: fix RTNL assertion when resuming from runtime suspend
  igb: link queues to NAPIs under RTNL after runtime resume
  igb: only allow runtime PM if the device can wake up

 drivers/net/ethernet/intel/igb/igb.h      |  1 +
 drivers/net/ethernet/intel/igb/igb_main.c | 96 +++++++++++++++++------
 drivers/net/ethernet/intel/igb/igb_xsk.c  |  7 +-
 3 files changed, 80 insertions(+), 24 deletions(-)

-- 
2.56.1

