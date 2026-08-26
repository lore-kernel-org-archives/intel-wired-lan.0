Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C45EC61DBD
	for <intel-wired-lan@archiver.kernel.org>; Wed, 26 Aug 2026 15:18:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5CC74403E1;
	Wed, 26 Aug 2026 15:18:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1yeoUhX-Nivf; Wed, 26 Aug 2026 15:18:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787757503;
	bh=khyyse4THAMrfiJRYpQVeWwsft6Ni//0zfK96H9UO4U=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XwT7SjCg+I+8rfhLxD2so8cJf8eEyriAIvzJEuL/m1Kq5gi4i1b6bnKvllywN45Hq
	 JfZJ3hP9TDufONhFa38tez9CE9s900um4sfatoVIlMiX1AmU7V3d8bG0IO/C3V28sx
	 VODebnB9ObDzwi80K1XAsLghZdKXlAZX3myVO4Wc0vAAcf6JEAC+z79xsYvfbUnJ64
	 d5zJWqZVDsc4CMP3rMMzYbWLoVn/FgCO+zrHJXhuyfSlRislRq+LsmMJdQN1Ld0/1F
	 7HiiVUa/VXeAbVtr35rO/a8vfU5/soX58KgXQpQfwFIxDHqMcGWddFQtj1NDcw/YGE
	 lun8AckUwQ3Pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE941402D4;
	Wed, 26 Aug 2026 15:18:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 78E01105
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 04:35:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7326A40566
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 04:35:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iIEssMSEm2Xj for <intel-wired-lan@lists.osuosl.org>;
 Wed, 26 Aug 2026 04:35:15 +0000 (UTC)
X-Greylist: delayed 303 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 26 Aug 2026 04:35:14 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=wii.dev
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=wii.dev header.i=@wii.dev header.a=rsa-sha256 header.s=x
 header.b=aaxr33zF
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.175.108.104;
 helo=mail-108-mta104.mxroute.com; envelope-from=ripatel@wii.dev;
 receiver=<UNKNOWN> 
Received: from mail-108-mta104.mxroute.com (mail-108-mta104.mxroute.com
 [136.175.108.104])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6263240575
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 04:35:13 +0000 (UTC)
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta104.mxroute.com (ZoneMTA) with ESMTPSA id
 1a03c5522b30001089.003 for <intel-wired-lan@lists.osuosl.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 26 Aug 2026 04:30:07 +0000
X-Zone-Loop: 78b2b3492b358bc7d272f63e9e5bda114b33b6c81c7b
X-Originating-IP: [136.175.111.3]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wii.dev;
 s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:
 From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=khyyse4THAMrfiJRYpQVeWwsft6Ni//0zfK96H9UO4U=; b=a
 axr33zFtWtUmm0quhnZC5lWoMk1ZKi+1Jb5ygeGzljxLms8lvAsXMSFohnb2xUicarLvgnr3xhMwQ
 WsU+KvOxvLlNK43Q++XrEGVa0Zp44oenQIlrouboUde0GyCwvzpVWJv4mVrQtVgOl4Ow2CIhOXjHd
 b8dp31F0iq2RnfP7L8qgan8U0lxYmqugcbFTOUzkY9R3wII+zAEJpgAtnGyu23C5yiZJvTwRvoEiz
 Fkttx2pEBxpcIC2ljtlJwzr0/FGd2cU1I8Jm7tAh+Tp8p9K6MfXxQqh6X8ZlA2t1kCAGJWvjH42UC
 16L794EWpYUlh5fmIge8EOqBP1IJXx35w==;
From: Richard Patel <ripatel@wii.dev>
To: intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Steve Douthit <stephend@silicom-usa.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Richard Patel <ripatel@wii.dev>
Subject: [PATCH] ixgbe: fix MDIO bus leak when rejecting SFP module
Date: Wed, 26 Aug 2026 04:29:45 +0000
Message-ID: <20260826042945.2344686-1-ripatel@wii.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: ripatel@wii.dev
X-Mailman-Approved-At: Wed, 26 Aug 2026 15:18:21 +0000
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

Plugging in an unsupported SFP module caused ixgbe NICs to get
wedged permanently.

ixgbe unregisters the netdev when rejecting an SFP transceiver as
unsupported.

  ixgbe 0000:3b:00.0: failed to initialize because an unsupported SFP+ module type was detected.
  ixgbe 0000:3b:00.0: Reload the driver after installing a supported module.
  ixgbe 0000:3b:00.0: removed PHC on enp59s0

This code path failed to unregister an MDIO bus owned by that
netdev, so when unregister_netdev() tries to tear it down
(via device_del() -> devres_release_all() -> mdiobus_free()),
it trips over the leaked registration.

  ixgbe-mdio-0000:3b:00.0: not in UNREGISTERED state
  WARNING: drivers/net/phy/mdio_bus_provider.c:711 at mdiobus_free+0x3d/0x50, CPU#21: kworker/u128:0/12

This prevents ixgbe from reloading, even after PCIe remove/rescan:

  sysfs: cannot create duplicate filename '/class/mdio_bus/ixgbe-mdio-0000:3b:00.0'

Call mdiobus_unregister() before unregistering the netdev,
like ixgbe_service_task() does after a firmware error.

Fixes: 8fa10ef01260 ("ixgbe: register a mdiobus")
Signed-off-by: Richard Patel <ripatel@wii.dev>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index f91856498eb2..fca57749218b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8470,6 +8470,10 @@ static void ixgbe_sfp_detection_subtask(struct ixgbe_adapter *adapter)
 			  "SFP+ module type was detected.\n");
 		e_dev_err("Reload the driver after installing a "
 			  "supported module.\n");
+		if (adapter->mii_bus) {
+			mdiobus_unregister(adapter->mii_bus);
+			adapter->mii_bus = NULL;
+		}
 		unregister_netdev(adapter->netdev);
 	}
 }
-- 
2.52.0

