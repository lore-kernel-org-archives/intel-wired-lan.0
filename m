Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED89C624DB
	for <intel-wired-lan@archiver.kernel.org>; Sun,  6 Sep 2026 02:33:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED18580DCF;
	Sun,  6 Sep 2026 02:33:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BnBZZS1H8im7; Sun,  6 Sep 2026 02:33:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1720780E94
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788662030;
	b=TzKx8s5MyviM5qwvu+SeY5nDcyrflfHxqn+T5K73pH9vsph5n2Cj6PZJal/mzibHBdSU
	 UMpKxyT5MmCWuCJ/nV/vPGf9T8gw6QZRpe6cX8+ZItJoACz+kDmOW9fK6pcyFpDA9KaVa
	 tTVIVsK+/gAA9X9GBtiU4dehP3/jkHbaynQeOOjETDaMDk7lmOavhhHKbIYqNjFvknFmN
	 699VIWJ5ZrLMRfffqmXep9cV1VO1Oooz7+zCy9iNSjNM0s59JWUiYxs3EOFJlmIrXAgM4
	 ehTMRoFu9LokxZ4G/fMfKc8NQFdC5EURiNomvIkl86leXV0+WGYBAGOtc0AT3crMFsw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788662030;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 X-Zone-Loop:X-Originating-IP:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Authenticated-Id:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=e/Kfiw3qaXMLZ0W+h5i+dWrr+6v+H5PFs6MwMeazqFo=;
	b=DTKhEpjPzMjAjrsK5w8JXTHedl7h58j2H/E1//dbzJKl1fo+wqGCnb8Ft2b98678Va2e
	 I4iFlLhRh+PPRh6PsPED1ikZn8f/NK4J1QmNaUXAeq2vwYgoXNFvf/yd5zggqu1tST5U5
	 5WLY3GKJiGOww7tZPofh35Kun04W0I8bEhWp5MwAV8h1K8t/BzvAk8h/YeAfqeAMQ0x/o
	 rpdVXhWo3gpJptkHW3esti0qIijBgmts/cyOhtlKqQNUEnzpaYR/WgPtn5N7rFjkPK1H3
	 mVcQoEjPoigCGkZP47958+WEs+g+ePVqNq2ea90kYkkFmWjCBzre7gn+Wj7R+8lfMQw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=wii.dev;
	dkim=pass header.d=wii.dev header.i=@wii.dev header.a=rsa-sha256 header.s=x header.b=Vvkmx+dy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788662030;
	bh=e/Kfiw3qaXMLZ0W+h5i+dWrr+6v+H5PFs6MwMeazqFo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pLgsbaAWCogpkaBXGTmMc60WaUz+acWz0VbthD4ieV2XPZla7QGPHF7MlTCjfJ+/R
	 xhlmey9RLrVR5dFIwOIAZP44xmT+jI89lZIj5HC21mEwrrLaiOCIKNmC2TGhwcwbK+
	 BGPVEvtVCA8Ks/gKhVHu8NO1f/Cm36o7WeM8U3wpDvoEzlPqsUfFP2Y1E2XLTziyp9
	 9xZ76u5NctO/Dcr1uG5c4PR/eeBpy6DJ1fHJUUMDgWbdbTnA51USOMwWZSHOIVGe4X
	 IMHhsfH2bEOQGS2zUv+4EIfbla9EmI4qkdJjrB3Du7bSgL+EiYldJzvOOC96Tk3XPl
	 oidgE+A+ETLjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1720780E94;
	Sun,  6 Sep 2026 02:33:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EFE1A1134
 for <intel-wired-lan@lists.osuosl.org>; Sun,  6 Sep 2026 02:33:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CCE2880E94
 for <intel-wired-lan@lists.osuosl.org>; Sun,  6 Sep 2026 02:33:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wKuHdpFtVsn9 for <intel-wired-lan@lists.osuosl.org>;
 Sun,  6 Sep 2026 02:33:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 80E2880DCF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=136.175.108.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788662027;
 b=e/soyY3nPoQ90ahgKlLQc8qzx68lpe/OZJKzjCaI92RyjUA+UWM1eglLMcFv1POjHpT5
 fa36zWNIHJXIfvftmBhhHo3hZDJnIni7AmhIiO6HHTdejnoDJtUVnTsRg8AXrCZnd8xEz
 MmX21A4WKTI36WzqmIwFhK5fEr7dx8BiGKHZZCxAonRZrPswTri8x/bSQQPal13ICE+8v
 4rDYnRSZGEU8kVfdErC8WMhtz+KdZA4QOAZcN7g4y7t7bzd+Ewgd8HqERWVgHBOk9BGVo
 tNPG2hYwZoyFaSTtkoVU693IH4qIDbP5mp8KSYNZ2MKrt/ss2Lp5diiy38g5ctdDIrg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788662027;
 h=Received-SPF:Received:X-Zone-Loop:X-Originating-IP:DKIM-Signature:
 From:To:Cc:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:X-Authenticated-Id;
 bh=e/Kfiw3qaXMLZ0W+h5i+dWrr+6v+H5PFs6MwMeazqFo=;
 b=jFNjtzJf9F5CR/NwFuhLamXXqp4+kMPNxWwOTnIQkR6PqiSvhjT1wn1S4ta2XZB0AvBx
 vgik8st68niBLfzoNnUnsZz3U5rlwU7Z21zPEzBCdq8v2/WZXLRR3Liryh8S448tvatkk
 FvHw52c5XYA+pSkMx8/NBI5Hj4bJHuYmFUl+E6WIhvRopM111D44QsNE9ToX6pUDwJRqQ
 gQvVRJUenknFzIW2jFM/qcTKY08/rlswRPj/r061jetgGvPWwVJimi1KpDBfLlQH3Ft68
 huKYIiO3p6pF3DunYTT9UJFn+rEqtMEQgckaTsELY+/TCKqCYt2HAwzuzlz4HsJIHRw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=wii.dev; 
 dkim=pass header.d=wii.dev header.i=@wii.dev header.a=rsa-sha256 header.s=x
 header.b=Vvkmx+dy; 
 arc=none smtp.remote-ip=136.175.108.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.175.108.15;
 helo=mail-108-mta15.mxroute.com; envelope-from=ripatel@wii.dev;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=wii.dev
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=wii.dev header.i=@wii.dev header.a=rsa-sha256 header.s=x
 header.b=Vvkmx+dy
Received: from mail-108-mta15.mxroute.com (mail-108-mta15.mxroute.com
 [136.175.108.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 80E2880DCF
 for <intel-wired-lan@lists.osuosl.org>; Sun,  6 Sep 2026 02:33:45 +0000 (UTC)
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta15.mxroute.com (ZoneMTA) with ESMTPSA id 1a07490829f0002cd7.003
 for <intel-wired-lan@lists.osuosl.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 06 Sep 2026 02:33:42 +0000
X-Zone-Loop: 8c92b4127451424c7c13656f851079e622dff507acac
X-Originating-IP: [136.175.111.3]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wii.dev;
 s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:
 From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=e/Kfiw3qaXMLZ0W+h5i+dWrr+6v+H5PFs6MwMeazqFo=; b=V
 vkmx+dyuTLamP4NC3lKOipgo6M4GKxgx0f4Dw94vA4r6AsJcZjuYUgAPv4bFzV9kyV2ktwvvLozvR
 YoRoV16IJsPIERhQeJ5CjATAdNkjUj0a8UExR1+P2RyeXBlrAK0vkH5qxP9RXya3y5GFHY7grJhQQ
 uaXnH4fC7U9tNjk0NpWp01VqENF7edkRhsiqXjx8vqnWj3L1YxlhlifM6IFAif21XDNXUdh5o5tf0
 sZXD+b44yfsy0GGEKTsg1jP5Dvvcfw4CMr2HYlugFNh5kG2DtnlquxP2qm5DSct58edpH4QBob3iQ
 059mRTGkL5yr3fBAQ+wFsN/t93SMrceuQ==;
From: Richard Patel <ripatel@wii.dev>
To: intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew@lunn.ch>, Steve Douthit <stephend@silicom-usa.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Richard Patel <ripatel@wii.dev>
Subject: [PATCH iwl-net v2] ixgbe: fix MDIO bus lifetime
Date: Sun,  6 Sep 2026 02:33:19 +0000
Message-ID: <20260906023319.1978945-1-ripatel@wii.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: ripatel@wii.dev
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

Switch to devm_mdiobus_register(), drop custom unregister calls.
This is safe because the bus is already devm-allocated, so unregister
always happens before free.

Assisted-by: LLM
Fixes: 8fa10ef01260 ("ixgbe: register a mdiobus")
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Richard Patel <ripatel@wii.dev>
---
v1 -> v2: use devm_mdiobus_register() instead of another
          mdiobus_unregister() call
v1: https://lore.kernel.org/netdev/20260826042945.2344686-1-ripatel@wii.dev/

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 9 ++-------
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 2 +-
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index f91856498eb2..96f60269fca6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8471,6 +8471,7 @@ static void ixgbe_sfp_detection_subtask(struct ixgbe_adapter *adapter)
 		e_dev_err("Reload the driver after installing a "
 			  "supported module.\n");
 		unregister_netdev(adapter->netdev);
+		adapter->mii_bus = NULL;
 	}
 }
 
@@ -8693,11 +8694,8 @@ static void ixgbe_service_task(struct work_struct *work)
 	}
 	if (ixgbe_check_fw_error(adapter)) {
 		if (!test_bit(__IXGBE_DOWN, &adapter->state)) {
-			if (adapter->mii_bus) {
-				mdiobus_unregister(adapter->mii_bus);
-				adapter->mii_bus = NULL;
-			}
 			unregister_netdev(adapter->netdev);
+			adapter->mii_bus = NULL;
 		}
 		ixgbe_service_event_complete(adapter);
 		return;
@@ -12104,9 +12102,6 @@ static void ixgbe_remove(struct pci_dev *pdev)
 	if (adapter->hw.mac.type == ixgbe_mac_e610)
 		ixgbe_disable_link_status_events(adapter);
 
-	if (adapter->mii_bus)
-		mdiobus_unregister(adapter->mii_bus);
-
 #ifdef CONFIG_IXGBE_DCA
 	if (adapter->flags & IXGBE_FLAG_DCA_ENABLED) {
 		adapter->flags &= ~IXGBE_FLAG_DCA_ENABLED;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index ab733e73927d..74631cb2ddbc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -1086,7 +1086,7 @@ int ixgbe_mii_bus_init(struct ixgbe_hw *hw)
 	hw->phy.mdio.mode_support = MDIO_SUPPORTS_C45 | MDIO_SUPPORTS_C22;
 
 	adapter->mii_bus = bus;
-	return mdiobus_register(bus);
+	return devm_mdiobus_register(dev, bus);
 }
 
 /**
-- 
2.52.0

