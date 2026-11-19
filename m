Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6F1606A336
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 14:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=81X7E8pY;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=xPNoUUdM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 409E1405DA;
	Thu, 19 Nov 2026 14:04:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9X25eJ-NoHe7; Thu, 19 Nov 2026 14:04:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4F4ED4055A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795097071;
	b=CFE3TbhZjvmFv/qmQXG9WLRy+lM1WL6AkFc4ekhJsIa0Wp0J2ctod9yCic+gGfFGjbwW
	 suztsRhH38z3NILhiUM44K9/xMrMF0jrP3cDWfAecSgslkgoiJ/C192snRSydqEw/EzeB
	 EhiKy6BCMRKMa2fS6CYjNzK1UOWApu3fB+ZiiwAEI6DIt4VaqJTThZ31xNT5KKJZVbLmD
	 reFLoM6UHcpe1zfhCwmSfsTS2niMdOe91+SNh10weq9juM3viyC7FVgTDLCbqFi3/k3wr
	 G1sEgnVxxAZk6l/WskVqJxHo8ZK2RzRZlb2kocz4ODubCWQ+dFOuw8niE7Xhe+vtmbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795097071;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=vGRcRbB2ziFhxyWI2QvN4m+vvYLWQzf1owkGu4UysCg=;
	b=TzxczXSaHX0+DI8xe9RnFgUrAC3i6l2VP68IHahUg7aehKRagp4vS1g18yvmlJZcfBwu
	 cG4KthCFrhyWIbZCMYFAr1ExcaNDjayXIYTar6BhqGQGcZNnBS4MDOTbHQN2TjAqUSsLt
	 mOGnN9pQszuKEKIwMHgvIeW1sUTK9FUDmf8qCXxq1+ZqTm+Pa7fcXcgChrTS6OIxnZ4Bp
	 MXIU41CL2eqLkoRCw8QHEBdDxFf8C3u/dvbtA+Ut2dceTVwhlSXow7E4uwjvEnnqA6Os+
	 VqE8V+UnJMyzPuyjXNcWdpddxGtdBqaknkjmj47dk4XoD0sRQKhFaWKQr7OnXM4k/ug==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795097071;
	bh=vGRcRbB2ziFhxyWI2QvN4m+vvYLWQzf1owkGu4UysCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=81X7E8pYfRFtfJdNBCLbOIrw71iRr6NUz/wDpki/dU1wCCsPk98LLuhqMZ8yIcZV0
	 qxUPEOrA9hOuLRpHKaKFHFQE4hlF/VSQ8w9zcZbUwaU9ICq/UKY5657e9D/TmvTD5Y
	 aUC3Dx5q1Kp5ZyMQQ/Sni5vqlIjlbGnqG+BuoMQRRze5J1Jvn5k5GxvpBgEOB2IrvY
	 EaEhvj0PUn3jYSBw+3VPBwp/dm3i2Ftr7Woqn6l25TrNYpGsqvAcosTsPc1xQPUqtc
	 55FNbuHkcaeowsR9YV6UWGbl1hIm+rBlas572eHlJsgL7Or4PHyQ/ZAK5W0hbG/39h
	 cR6W6fupjVx1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4F4ED4055A;
	Thu, 19 Nov 2026 14:04:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9682622B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:04:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7CBF960D72
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:04:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SsYT6yh4bfU9 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 14:04:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2DF396066D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:102:465::210"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:102:465::210; helo=mout-b-210.mailbox.org;
 envelope-from=antonio@mandelbit.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mandelbit.com header.i=@mandelbit.com
 header.a=rsa-sha256 header.s=MBO0001 header.b=xPNoUUdM
Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org
 [IPv6:2001:67c:2050:102:465::210])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2DF396066D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:04:26 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4jVgFL6clVzFq3F;
 Thu, 19 Nov 2026 15:04:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1795097062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vGRcRbB2ziFhxyWI2QvN4m+vvYLWQzf1owkGu4UysCg=;
 b=xPNoUUdMtGpPd1ZBksgZS4Reu7at+KlhwHfvxUgIQM6UZ/UugnPFiIDLFzGvYxwfOLKuRh
 5TZRftTVIVXQIp0OWRz0rx3aMRGKKpns0vWCRp13Asj+bYBli3Cgp6KPcc8Mwafo0yZjGS
 ueCIGPB1X+FYu+w/LseiyY/CL0OD/anaoo1clluySZ+PiyYr7xDrJQ4kn3LUjJhtxb/acq
 XC6UL/KinioRcVgKw7QEqTsW3cX/yNi1h8TRDofTon7vnIC+rkSnNPSb0jPw7E/dPh1iU7
 PJGvxNvSDWINbHmVoga34xQ+Gg4NXKcqpyjVnP8hYczwKbF98Q8psvosywsxBw==
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
Subject: [PATCH net v3 4/4] igb: only allow runtime PM if the device can wake
 up
Date: Thu, 19 Nov 2026 15:04:10 +0100
Message-ID: <20261119140412.163202-5-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119140412.163202-1-antonio@mandelbit.com>
References: <20261119140412.163202-1-antonio@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jVgFL6clVzFq3F
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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

