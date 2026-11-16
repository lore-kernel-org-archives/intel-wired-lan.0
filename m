Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58010606A32A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Nov 2026 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=LYb2/L2X;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=np/GTuzu
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B64B4069A;
	Mon, 16 Nov 2026 15:31:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b9cLF9dU0H9Z; Mon, 16 Nov 2026 15:30:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4CB25406D7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794843059;
	b=ndmnqvXnbHE2PNvoe0+QP8t+ZjH0R3o/uDHtn36MzE7hoS2JhlQQ6F0ABoRmy83Uy7Vb
	 ogjGHWqkK9IeYgpW4xBMDr20QCrMK8wUZIkj73RII7jV0+XM6++uRWU4ogdfOmotbOmAC
	 ER4P2i+owO6GZKQqDixKTrFNfaKOEA8HpqVzSDa5DzZsP/bxBur6ROMjErwifj8i20Q9s
	 QrjBKJ/Y7ZbkdjUEwMeph3jfy0EGAZ27hufqTDH6XJuR3GoUsxBFV8X0t+BTC+RASAO9q
	 0wbX91ZwAzpILeZVfyVE0TD5GMzE/FYO9k2qQP7aTSgdASw1Vtnnajzif9OPELQtMQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794843059;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=32NJq9EvkJ4412Q5l3aqJH/r1Tghp1UTAcFKtTsA+rA=;
	b=B3kfkwBRt7OKQrFm+RwfZT5LlL8xo9Rd9tcYcs2v0Vr006ZjwlfxZTvIV0fj+gebSqfx
	 nPxGVkhWFPp1GudNudOxPF4/jvbgsRHhDnxTP98IW7L8NNaQSMTqnmxniWQtgpX1yQZHH
	 ORaXOEkZhe+zc1XA4a3ZSRy2JwLHzXSsDN5E0yWlIRbjn2Qc7DSj4xLlMX1RqYcxyUH+P
	 IKU6AOsC+ybMN10HmzIK7YCS+1T3lOtsqCwvpwnmBQ93aLMTf5Xp2TXhnzI1y+YGUeSC2
	 lSbL11/kjSjYBcE2XHo3OL5WSCc6P34BI1ELsgLxP+YZdMMBLXu+l+nrG2ahMt3NYWA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794843059;
	bh=32NJq9EvkJ4412Q5l3aqJH/r1Tghp1UTAcFKtTsA+rA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LYb2/L2Xkt/3uGD2nJ9GmOCmp81Rf/1cr342bN2TjWZjWDl7VrE3EVtjSIm+84BOW
	 IX3Ghn4BzoO8HYGGVIeH9OZOtOb3vXmdaE9X4YRFyJPcXMIKflNl8mfzXXmuwebOYu
	 uVLdCmP6XY3zu8YJDXDrY1Cifq40KSB6rpXK+YSUyvEEfZYK9zHZsAx5KLLi2eg3By
	 LARwKvhkaaYjny96aUxOocrRVjZp+qcL7zI2XqKP4dUh6LQ5tKRMpM+OqMEq2E6aqF
	 4LI2xcvAGZ9a16+szWHqZ3omv0rPxupz7blVkmKJz5TXVfP+DUx7OkOpFx0co7V1Lv
	 mWqhb/oKs4BrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4CB25406D7;
	Mon, 16 Nov 2026 15:30:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 370762FE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 15:30:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 28F9A80EE0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 15:30:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EBSLbHuByuYJ for <intel-wired-lan@lists.osuosl.org>;
 Mon, 16 Nov 2026 15:30:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F27F380A8C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=195.10.208.51
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.10.208.51;
 helo=mout-b-206.mailbox.org; envelope-from=antonio@mandelbit.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mandelbit.com header.i=@mandelbit.com
 header.a=rsa-sha256 header.s=MBO0001 header.b=np/GTuzu
Received: from mout-b-206.mailbox.org (mout-b-206.mailbox.org [195.10.208.51])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F27F380A8C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 15:30:55 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4jSsJW5x0VzQm;
 Mon, 16 Nov 2026 16:30:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794843051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=32NJq9EvkJ4412Q5l3aqJH/r1Tghp1UTAcFKtTsA+rA=;
 b=np/GTuzuFjpeRDolIiAp3KNxgTZBJfYfUlQsjv9SOH8WUqpiKwT1o/0cxG+nSsn/t7+hvH
 2bfHm/ivbFFOTTi7WogQlj3LxV1isvhJfuVKr/9qxUMOCDXm5LprFGxfyCd+wAXJmRDOnq
 2uDnODFHsWHSquYixYqfkHbKJ8Vv7kovkaTr5SNFkBA+bpMOWLDthq27FL6EKdv537sDXT
 N0l0Yrz7MjerKJVK8Te7eDtbD9UQ3VadhTF53MoQn2I3HvN8vdvvQyOAr3EwkiFzlIrB+e
 tuWduSkkU7/yJOvu0jGMGpQ7ciPqHHB9svJsHeXJm5Ro9HJDDd3Lb/AP/R1p/g==
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
Subject: [PATCH net v2 3/3] igb: only allow runtime PM if the device can wake
 up
Date: Mon, 16 Nov 2026 16:30:39 +0100
Message-ID: <20261116153041.3002666-4-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116153041.3002666-1-antonio@mandelbit.com>
References: <20261116153041.3002666-1-antonio@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jSsJW5x0VzQm
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

Tested with the 82576 emulated by QEMU.

Fixes: 749ab2cd1270 ("igb: add basic runtime PM support")
Cc: stable@vger.kernel.org
Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
v2: no code changes; mention the tested hardware.

Note: igc may have the same issue: igc_probe() also allows runtime PM
regardless of pci_dev_run_wake(). We didn't have igc hardware to test a
fix with, so no igc patch is sent for now.

 drivers/net/ethernet/intel/igb/igb_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 894eedb..9046611 100644
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

