Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D7CC00144
	for <intel-wired-lan@archiver.kernel.org>; Mon,  1 Aug 2022 20:48:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 168D08130F;
	Mon,  1 Aug 2022 20:48:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 168D08130F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1659386886;
	bh=DktPTGn/EzTHIAmqpnzlFO+jzERiB3Y0TydMZOwHhMg=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=D4rfyZS690RhLYP8iFW7NIiFutLXVi+afvdpz9snPucQ6/BZeT3m1gXloXKcFkobH
	 wKKTad1p+mn4KUwVQ5iY4+LbZHchFz+0EKyON9M1cB+Dfb0czVe5cHItjwLKcg8zty
	 H+ArYtzDtGSDFCut7qK9dZ0LrWScheN+gDQBuzNgDHaLxmh4NVXRpXEWwQLCEmpQcJ
	 GBqqO8blVqf61oe0tJYs22ZK7CufVDAVmUTFOzrAiOg5VLg8j52s+NM/C5S9btmLAR
	 xs6hWwJ9i/2gWBZoFjOveRCxHH5VZm4ZLAFwhC9B5rjEk0gBuP7qfikcfRLV0tPlcD
	 V3KRyRpdOS2eQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qcwR9AqnJogc; Mon,  1 Aug 2022 20:48:05 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 025658130B;
	Mon,  1 Aug 2022 20:48:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 025658130B
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id AF1C01BF337
 for <intel-wired-lan@lists.osuosl.org>; Mon,  1 Aug 2022 18:27:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8F229819FC
 for <intel-wired-lan@lists.osuosl.org>; Mon,  1 Aug 2022 18:27:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8F229819FC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F4JnASpsB3_m for <intel-wired-lan@lists.osuosl.org>;
 Mon,  1 Aug 2022 18:27:42 +0000 (UTC)
X-Greylist: delayed 00:05:01 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 767BA819B8
Received: from aurora.tech (ec2-13-52-33-44.us-west-1.compute.amazonaws.com
 [13.52.33.44]) by smtp1.osuosl.org (Postfix) with ESMTP id 767BA819B8
 for <intel-wired-lan@lists.osuosl.org>; Mon,  1 Aug 2022 18:27:42 +0000 (UTC)
Received: by aurora.tech (Postfix, from userid 1001)
 id 3D8A61640092; Mon,  1 Aug 2022 06:37:53 -0700 (PDT)
From: achaiken@aurora.tech
To: jesse.brandeburg@intel.com,
	richardcochran@gmail.com
Date: Mon,  1 Aug 2022 06:37:50 -0700
Message-Id: <20220801133750.7312-1-achaiken@aurora.tech>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 01 Aug 2022 20:48:03 +0000
Subject: [Intel-wired-lan] [PATCH] Use ixgbe_ptp_reset on linkup/linkdown
 for X550
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: spayne@aurora.tech, netdev@vger.kernel.org, achaiken@aurora.tech,
 intel-wired-lan@lists.osuosl.org, alison@she-devel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Steve Payne <spayne@aurora.tech>

For an unknown reason, when `ixgbe_ptp_start_cyclecounter` is called
from `ixgbe_watchdog_link_is_down` the PHC on the NIC jumps backward
by a seemingly inconsistent amount, which causes discontinuities in
time synchronization. Explicitly reset the NIC's PHC to
`CLOCK_REALTIME` whenever the NIC goes up or down by calling
`ixgbe_ptp_reset` instead of the bare `ixgbe_ptp_start_cyclecounter`.

Signed-off-by: Steve Payne <spayne@aurora.tech>
Signed-off-by: Alison Chaiken <achaiken@aurora.tech>

---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 750b02bb2fdc2..ab1ec076fa75f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7462,7 +7462,7 @@ static void ixgbe_watchdog_link_is_up(struct ixgbe_adapter *adapter)
 	adapter->last_rx_ptp_check = jiffies;
 
 	if (test_bit(__IXGBE_PTP_RUNNING, &adapter->state))
-		ixgbe_ptp_start_cyclecounter(adapter);
+		ixgbe_ptp_reset(adapter);
 
 	switch (link_speed) {
 	case IXGBE_LINK_SPEED_10GB_FULL:
@@ -7527,7 +7527,7 @@ static void ixgbe_watchdog_link_is_down(struct ixgbe_adapter *adapter)
 		adapter->flags2 |= IXGBE_FLAG2_SEARCH_FOR_SFP;
 
 	if (test_bit(__IXGBE_PTP_RUNNING, &adapter->state))
-		ixgbe_ptp_start_cyclecounter(adapter);
+		ixgbe_ptp_reset(adapter);
 
 	e_info(drv, "NIC Link is Down\n");
 	netif_carrier_off(netdev);
-- 
2.32.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
