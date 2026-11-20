Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D0360A2603
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Nov 2026 21:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=t2kpVcpI;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=H2YdIHHe
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D39E181755;
	Fri, 20 Nov 2026 21:01:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SuA6Upm-T8KY; Fri, 20 Nov 2026 21:01:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E00B681750
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795208513;
	b=cvAJ1008fFEPs9fxXUC4au50r3LXlVRnzdJ3msuEqAjOync9l6fQwmBR6LG6hmIlt6aZ
	 16ziJ7WX4Gp7ze+1SdkwbU3KI7v/epdFHeHVcaDPbhEQWVkDdMCfB7RgKw919xMkUtsUV
	 2CGpAt1PfPU8x4LgKo+esyRBjKFWcXgQaQRv3LlWUD0WTq7BfAT2igiT7n7ILBm9z6lob
	 gHgvRlhhgQbcMsVwQGPa0ooYkNbfY0RTUu8WO9Nze+1V0zfgRBuGVuFpkYF/Nu9asVsR+
	 /hrwfZRbVKPRNWS7G+GnZggu6dqg6AFO58wjfIsRDBf9ECl0Fmh2sUhflqfMqmq9j0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795208513;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=n34JAgo+BYEXBsBH3HriYNhCx1OSAseNztdfnC7EmCA=;
	b=bnlYn9nuWcfjpllyBtZpPK+I8aq14nvL+GF8co0dnvusu5YAGIU5pVQ/aymrS5hsnj1c
	 qAPx/kOZVeQWi3XWOgKonqOtN5ye2xW4fMYsJxPiaBetqPO55CGFCNU7Q+OZc0AXwbE+3
	 iZIzyAR5tNBA4OxK/MnV1Aj0qCWPaYE2jOHCpVdRIbWTKEBMtNqPLgGm14ciZ5tdNc04t
	 p4Aj7Ebul4YkOzMWdzA/pfDAdLfTDpaNiGaTJc4gEjG0DQHfQaNfUxoUqg1I24Q/hABmC
	 Mjf6DKWWz3fTXv0z0MeEc/zidSZVfCA1WpRuhwg0uSaeYjzAVnVZfLfwEBF54mGS5oQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795208512;
	bh=n34JAgo+BYEXBsBH3HriYNhCx1OSAseNztdfnC7EmCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t2kpVcpIV6XM+l9EeMJEJNUWDCgiCmPgxSSuK9E6QV48ZwT7IYpuljhaw8l8t9jxn
	 ZO9AG3py+vgnUCWhHwtvKzKZISloazsaUO5TiT9Lc/dFN+5lrbHXJTi/e+vlQRdEeI
	 i1iyTOs4ZY/qrsel92OsB+W66h7eFAFa+kKwneWCE3l07QlvEwyYLOF2qC6jlW65Lk
	 Sv7oHqH4TUnYt8Uxe8Rewqb2KJx75e7xGf+txOzpp6O8hOQ56J7d+ZINiwfv5bAyVk
	 jdMv9gk0DR+B0P0vFoIR4Bs2nWIdN3NyzoGRYnFDBmZdTAl/UB3HmDfxO0VljhYFUx
	 HEgmvWEzlPN/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E00B681750;
	Fri, 20 Nov 2026 21:01:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C1470971
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 21:01:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A4C0140AF9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 21:01:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QmVVQtLcFnOC for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Nov 2026 21:01:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4BEFF40AB0
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:102:465::107"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:102:465::107; helo=mout-b-107.mailbox.org;
 envelope-from=antonio@mandelbit.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mandelbit.com header.i=@mandelbit.com
 header.a=rsa-sha256 header.s=MBO0001 header.b=H2YdIHHe
Received: from mout-b-107.mailbox.org (mout-b-107.mailbox.org
 [IPv6:2001:67c:2050:102:465::107])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4BEFF40AB0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 21:01:48 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4jWSST2lTlz3wjt;
 Fri, 20 Nov 2026 22:01:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1795208505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n34JAgo+BYEXBsBH3HriYNhCx1OSAseNztdfnC7EmCA=;
 b=H2YdIHHeSCyc4bQ+GvtyAWBTBiXFnjJVPo1L8cQw/bC4eWfX5sTS2rst213vmMT7ANXl+K
 UqLWCTWBQbXL1+QCYmiBEZOB6UUOfsHWWX13/NPvY8WqdhN5LHtv3U4Jyog5pmnBy/ZAZp
 TBBmdJ+REW9dSmU2skOBgoz8XPnoBWvmrdvMvlYWHwEJzGqBCA0C5BT6TvxCKjjmMRICay
 NZn+MTVAJsW4xDI6taVRZ1mfekmKFADaGpIBoueISzy+gLWetSOHiNLHJQIpW+ehooigDN
 PQKzja6RbokrD8xGDUqAATOJhzEGGjwmTBcSQR69HE+9Fcv8xw3XNk65ARnZKg==
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
 Janis Edvarts Lacis <janislacis06@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH net v4 4/4] igb: only allow runtime PM if the device can wake
 up
Date: Fri, 20 Nov 2026 22:01:32 +0100
Message-ID: <20261120210134.133238-5-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120210134.133238-1-antonio@mandelbit.com>
References: <20261120210134.133238-1-antonio@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jWSST2lTlz3wjt
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

igb lets the device be runtime suspended even if it can't signal a
wake-up from D3. Such a device doesn't notice the link coming back, so
the port stays down until it is resumed from user space.

Allow runtime PM only if pci_dev_run_wake() is true, as e1000e and
r8169 do. Devices that can't wake up no longer runtime suspend, even
with power/control set to auto.

Tested with the 82576 emulated by QEMU.

Fixes: 749ab2cd1270 ("igb: add basic runtime PM support")
Cc: stable@vger.kernel.org
Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
v4: no changes
v3: no changes
v2: no code changes; mention the tested hardware

Note: igc has the same issue: igc_probe() also allows runtime PM
regardless of pci_dev_run_wake().

 drivers/net/ethernet/intel/igb/igb_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 6196d7a..72eeaf3 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3654,7 +3654,11 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
 
-	pm_runtime_put_noidle(&pdev->dev);
+	/* A device that can't wake up wouldn't notice the link coming back
+	 * while runtime suspended
+	 */
+	if (pci_dev_run_wake(pdev))
+		pm_runtime_put_noidle(&pdev->dev);
 	return 0;
 
 err_register:
@@ -3876,7 +3880,8 @@ static void igb_remove(struct pci_dev *pdev)
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
 
-	pm_runtime_get_noresume(&pdev->dev);
+	if (pci_dev_run_wake(pdev))
+		pm_runtime_get_noresume(&pdev->dev);
 #ifdef CONFIG_IGB_HWMON
 	igb_sysfs_exit(adapter);
 #endif
-- 
2.56.1

