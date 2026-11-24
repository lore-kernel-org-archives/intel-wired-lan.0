Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA03606A6A9
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Nov 2026 23:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=xOWb4dzL;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=RclqWh0z
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1DB05405B9;
	Tue, 24 Nov 2026 23:57:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IVT6ZeRhqtOL; Tue, 24 Nov 2026 23:57:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4774F405C5
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795564667;
	b=V6OaDxsNFtqqUq8KZAyYJMnOC5Njd3eqXMhh4a8Eegq0FNWZzY5UAbUp8eWe2JcRH+/B
	 QJIWOYIiCPF6x9vJ7/cE0bd4C+jHcJSjtt65Dp1Padf+qRkje3Wiq0SQq/S6dMHfyUcft
	 gkifFQLpi4/raf+OewB6JkUDRf2+lpkQgz3Zbvdm1CLeey5ZbwTTJ3cYd6txxlRXEwkYn
	 iNQBfmcP3J5oCyb2s/Q4mNICdEmrDhK1Q0wrh5V/k7NrW5hYdZowgNxxTZHEfehWQ/Kp3
	 yyUkAbLEPCOGqhFt70dTLs3RPY/pK+tJeTf54uPr3uUjJN4LU3C2HHJqGcCOZAXkGDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795564667;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=zCpEUkgnC6nNW718VYsVFX4l9kDyJsq5iPDHI4it1XI=;
	b=ElB4cWlFjlucYl6lNY7h7GwUFhchiIsc6tQ+npUoKFqk7xlK0/kIcBqB+cBJYkYi4jqk
	 kV/dtVsT1HoqACbGXpemCtklDZEviiVX/9SOgaDX6CsDOnB08POLNGHBz2iIG5EMyp82M
	 dlxOG3xrJ237HvIk9A0x0XDcNxPI3zl5lDAvB7nhim0zrwYf0Y9zxNKBSMd0QO0uW3pxw
	 gbRBCW89QBo7kvLddA6SCAe3esY/ihwXCmio9MlqFKlr2qo30s2alhhK2isiYVxTYVvhl
	 jFSlu/SkKyJJ7JWk1XHtYTUzj4iNCTM4n5hdamDQ4ArBx2F6k3jv7sw6MzeQtZIMfGg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795564667;
	bh=zCpEUkgnC6nNW718VYsVFX4l9kDyJsq5iPDHI4it1XI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xOWb4dzLKiSk+uBX7JNVbbZJpGdaaWbLrIC3rVV3LOlxYSW1q7sprizMN6QRnWMhf
	 dlRPts7vIKO3MoM/Bwwoo0NeS5iz5B96Pa6haYd95D8ugqSIdJkRcu7TBWEa5tsLc4
	 F3bs9wn0h0/rPu3dAu4yIZCvvKP3DcUF5JfRX5hybpPyYOSgMPpeHe3i7vih37iH00
	 yh8+vBdlZnktIitWmZcxH4y94GIqj6vPi4yOeA5vJMv+0WLVDGWHiLQoD5Ihp7QmHB
	 1EjBXYdIaLXezLTRfsLoY6ohg3QMlRQQJJqK/yddaOwLv3DDP3LEnbRz+CFCXVq4sU
	 kfzgYuzDAwFqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4774F405C5;
	Tue, 24 Nov 2026 23:57:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A249F2F5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 23:57:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 883D180D07
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 23:57:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IPcsYc8-qRNc for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Nov 2026 23:57:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6478F80D09
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=195.10.208.46
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.10.208.46;
 helo=mout-b-106.mailbox.org; envelope-from=antonio@mandelbit.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mandelbit.com header.i=@mandelbit.com
 header.a=rsa-sha256 header.s=MBO0001 header.b=RclqWh0z
Received: from mout-b-106.mailbox.org (mout-b-106.mailbox.org [195.10.208.46])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6478F80D09
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 23:57:42 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4jZ09Z1pQ0zNmCY;
 Wed, 25 Nov 2026 00:57:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1795564658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zCpEUkgnC6nNW718VYsVFX4l9kDyJsq5iPDHI4it1XI=;
 b=RclqWh0zW4yQcc6GrRBXcV9uuCLN0ckFv4ZxT0YoXpcuqJlJWSGbIK6KLgk+uYkkNd0UgF
 xAGL/od2acr9mpURA3z2IXVhAy6Qv0rbpyWqj4dMeMJz1B7nOl9ElXnE7LxuQXxdoUGDgw
 GqHTIYCt8AaXki0f92mpy388pRppX5Ewg/140NJZbj3/WTrwAYE19ydIUr7i3DLhssX3S/
 CPi7ODZNgMYrSkMQuHatkpwUpZ/Iszr5eBtz9Wk11lrEllMWqPuNEMbKSQ0xG1vbMELCyM
 2ONQiJAs81XbhUVSLe+mll8JeqgTcnUxciVOMiVVP5pXqIousqqGw+ogm5HjnA==
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
Subject: [PATCH net v5 6/6] igb: only allow runtime PM if the device can wake
 up
Date: Wed, 25 Nov 2026 00:57:21 +0100
Message-ID: <20261124235723.1135808-7-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124235723.1135808-1-antonio@mandelbit.com>
References: <20261124235723.1135808-1-antonio@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jZ09Z1pQ0zNmCY
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

igb lets the device be runtime suspended even if it can't signal a
wake-up from D3. Such a device doesn't notice the link coming back, so
the port stays down until it is resumed from user space.

Only schedule a runtime suspend if pci_dev_run_wake() is true. Devices
that can't wake up no longer runtime suspend, even with power/control
set to auto. Checking it when scheduling the suspend, rather than at
probe and remove as e1000e and r8169 do, keeps the runtime PM usage
count balanced if the result changes while the driver is bound.

Tested with the 82576 emulated by QEMU.

Fixes: 749ab2cd1270 ("igb: add basic runtime PM support")
Cc: stable@vger.kernel.org
Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
v5: check pci_dev_run_wake() when scheduling the suspend rather than
at probe and remove, which keeps the usage count balanced (Sashiko)
v4: no changes
v3: no changes
v2: no code changes; mention the tested hardware

Note: igc has the same issue: igc_probe() also allows runtime PM
regardless of pci_dev_run_wake().

 drivers/net/ethernet/intel/igb/igb_main.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 80ae03d..853bdf4 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -5625,6 +5625,15 @@ static void igb_watchdog(struct timer_list *t)
 	schedule_work(&adapter->watchdog_task);
 }
 
+/* A device that can't wake up wouldn't notice the link coming back while
+ * runtime suspended
+ */
+static void igb_schedule_runtime_suspend(struct igb_adapter *adapter)
+{
+	if (pci_dev_run_wake(adapter->pdev))
+		pm_schedule_suspend(&adapter->pdev->dev, MSEC_PER_SEC * 5);
+}
+
 static void igb_watchdog_task(struct work_struct *work)
 {
 	struct igb_adapter *adapter = container_of(work,
@@ -5777,8 +5786,7 @@ no_wait:
 					return;
 				}
 			}
-			pm_schedule_suspend(netdev->dev.parent,
-					    MSEC_PER_SEC * 5);
+			igb_schedule_runtime_suspend(adapter);
 
 		/* also check for alternate media here */
 		} else if (!netif_carrier_ok(netdev) &&
@@ -9741,7 +9749,7 @@ static int igb_runtime_idle(struct device *dev)
 	struct igb_adapter *adapter = netdev_priv(netdev);
 
 	if (!igb_has_link(adapter))
-		pm_schedule_suspend(dev, MSEC_PER_SEC * 5);
+		igb_schedule_runtime_suspend(adapter);
 
 	return -EBUSY;
 }
-- 
2.56.1

