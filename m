Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4DC606A880
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Nov 2026 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=AjwHsCZj;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=ClZB++I9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 518E3409EE;
	Fri, 13 Nov 2026 17:00:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kRmLWAtEf_sQ; Fri, 13 Nov 2026 17:00:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 511E8409AF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794589246;
	b=h1AHE73FCyd1nspIPRldoWdRADhzuKyRyltC1E3aWuizYZk33dRUJKYUhmVt3jPEDYHS
	 VM9mMFg5VED76r13bQdakR8+q5zfuKFHSNSkkFSDR8k9lFqG81eqR8FvvNaYZKlktvKKQ
	 GdPG5vTjZlWM8pvZOgeuDYOUEbACrc62/zv544cyYfhSwKr/25YnRRKp9CVdoZro/4eyv
	 Sk9SxmBQ5koTSFMEH9gBmFi1qsjVIyLxKCEkvtrT27DCAfQchMQezBPHH+Gehq5KHJjQJ
	 Yyq8BVir2Oynn0q7KH1ISJ5IN9Pxcyfy209jCIvRXF4hEkAl7bktAICzcA3o/AammbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794589246;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=glKruA5muTr4k5zyDKpMfaKEQatBb9MU3FU/gWAzl6U=;
	b=ADWrb7PoxpR3VlIt+lfEbIbf6EUOJ3Ey0sbtl0LXAdIewCho0Dd6/4WKJThr9TB7auYR
	 V3WhEnxPKKlUC/gi6ujGUr0d1OEq5Mp5LFJ1Dp1hojMYOsTqe7kJOtUNkcGQj2RoifEs8
	 f/CkUplgKC7nXs3HXg1K5Aq31C9c+CJUtYS92w+XO1+EcPIHbCzFmShZ61qBDTmWf2hJc
	 vzXjG58Es/rqOw5qDGwwyLJYyiNTIoleuJyV1gqFqremI4ow/w0/86l6glV1xecylUw77
	 izzAbKji0/kisD1j6NbdUnmJPjkl1tZdxYZPD9z6yqyV3vcQtQoXjdK9Qs/INcPlbxQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=none header.from=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=ClZB++I9;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794589246;
	bh=glKruA5muTr4k5zyDKpMfaKEQatBb9MU3FU/gWAzl6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AjwHsCZjA8F1fuXPvBSCaaoszWPOc2k/xUG8sCDwhHYa64c+NFtG29WSXP3rWmKr5
	 qCBhm7FhYKUpuQhQoQBv7xkG+Qf36HqqBjPyie37jzbAGWsQv9iwSlN3LPUt44em6X
	 HyfTD3PtT6nbD5qVbSczDPN4WbQ0fXZxQ/3twvNX/uP2SvWvfXbCD79jOj5M4dXWb1
	 JrXNWlSKqWFUvqP3U1SCQcqfaSzSNEWTZ18cvgFtld7Bj7CC1XuPIOyeENo1v4Iyji
	 hKEnI8anePoS+UKocdo44YM+mGgT36Gv7gJXORrgNIF5CI3MgZTkbAbOzMqWcH8WP5
	 jAw+c0N8pFsLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 511E8409AF;
	Fri, 13 Nov 2026 17:00:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A6A22FE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 11:08:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0073240DDF
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 11:08:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id boYMeXN6O2o9 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Nov 2026 11:08:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 73ED840D9C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:102:465::110"
X-Greylist: delayed 572 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 13 Nov 2026 11:08:24 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mandelbit.com header.i=@mandelbit.com
 header.a=rsa-sha256 header.s=MBO0001 header.b=ClZB++I9
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:102:465::110; helo=mout-b-110.mailbox.org;
 envelope-from=antonio@mandelbit.com; receiver=<UNKNOWN> 
Received: from mout-b-110.mailbox.org (mout-b-110.mailbox.org
 [IPv6:2001:67c:2050:102:465::110])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 73ED840D9C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 11:08:22 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4jQvQ0026wzNmD9;
 Fri, 13 Nov 2026 11:58:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794567528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=glKruA5muTr4k5zyDKpMfaKEQatBb9MU3FU/gWAzl6U=;
 b=ClZB++I9/DL5q3UOhzm5ne4XL5kAB3pQHYGawyeMbkNlt/W4/XOlaDtsslcXdTfo1q+v2Q
 CvZoFJF5COMcKf+InnoKOhb8SjDv+Eeuc7p0keMxQGoctyUTOeLcgAjPKcFyH0+TvHLR4i
 B3OMkA7T5MpQM+S39Geys+tiFmoyKvoCehIKW859vmdOSp7ovCJHNmllMEPJOx3t25g6Yz
 uwPZ587vMzM8m2BBb5Ux79Jjj5/6vAfFDXhLH6R0y+JeusamCp/9b+rQi6r7wpvE/47I1M
 AkHCkaJBAruEXgAGqEGp9wkJnAlMGNbP4lJ8cvk8fWXa+fior//AXn1shxZnkg==
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
 Paolo Abeni <pabeni@redhat.com>, "Yan, Zheng" <zheng.z.yan@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH net 3/3] igb: only allow runtime PM if the device can wake up
Date: Fri, 13 Nov 2026 11:58:33 +0100
Message-ID: <20261113105835.3821433-3-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113105835.3821433-1-antonio@mandelbit.com>
References: <20261113105835.3821433-1-antonio@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jQvQ0026wzNmD9
X-Mailman-Approved-At: Fri, 13 Nov 2026 17:00:43 +0000
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

igb lets the device be runtime suspended even if it can't signal a
wake-up from D3. Such a device doesn't notice the link coming back, so
the port stays down until it is resumed from user space.

Allow runtime PM only if pci_dev_run_wake() is true, as e1000e and
r8169 do. Devices that can't wake up no longer runtime suspend, even
with power/control set to auto.

Fixes: 749ab2cd1270 ("igb: add basic runtime PM support")
Cc: stable@vger.kernel.org
Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
Note: igc may have the same issue: igc_probe() also allows runtime PM
regardless of pci_dev_run_wake(). We didn't have igc hardware to test a
fix with, so no igc patch is sent for now.

 drivers/net/ethernet/intel/igb/igb_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 4d97399..59f59da 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3677,7 +3677,11 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
 
-	pm_runtime_put_noidle(&pdev->dev);
+	/* A device that can't wake up wouldn't notice the link coming back
+	 * while runtime suspended
+	 */
+	if (pci_dev_run_wake(pdev))
+		pm_runtime_put_noidle(&pdev->dev);
 	return 0;
 
 err_register:
@@ -3900,7 +3904,8 @@ static void igb_remove(struct pci_dev *pdev)
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
 
-	pm_runtime_get_noresume(&pdev->dev);
+	if (pci_dev_run_wake(pdev))
+		pm_runtime_get_noresume(&pdev->dev);
 #ifdef CONFIG_IGB_HWMON
 	igb_sysfs_exit(adapter);
 #endif
-- 
2.56.0

