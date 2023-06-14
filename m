Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2DCEB64D7
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Jun 2023 02:44:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C211A605BA;
	Wed, 14 Jun 2023 02:44:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C211A605BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1686710647;
	bh=4SJuYJ+MQ5UI2OKMYbo+qksczy8bt7s659NE59ZqAy4=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=BgWRQvmdPjqtbyEWc++SKwlFVKxI6Mjl1Eav/dwjCKGV7tbG8rKBJunk7X1TjaNSh
	 nRF3mUdM9X4lvkqIDQzieZX07eX2wuhqIUYW0ZvEXW8RUM5b0UY0+SuH0J3zc7u4dp
	 5jHmlvOgA3dspqVdaqdTZR5IpzxWb/xERoNtd36RApbG2bqUn1j+pXyRKrCsUSBhj/
	 qFbojT44hx9H391b5s6CyNEE1QQ/Z9BjGmD1xd/j9GTnTr9jNhoWkdgcqbwRl1tuXd
	 VR2Cn/8woMa+7iZ8Rcvponzg0FOPJ/Z+IkEP45vfCxHiCxGRTZh7CjtOkDnLcr5T+p
	 8PLL69GJIzTAA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PLt_8Ykq7V89; Wed, 14 Jun 2023 02:44:04 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F4EC605C9;
	Wed, 14 Jun 2023 02:44:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9F4EC605C9
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 9D97D1BF30A
 for <intel-wired-lan@osuosl.org>; Wed, 14 Jun 2023 02:44:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7784F404BF
 for <intel-wired-lan@osuosl.org>; Wed, 14 Jun 2023 02:44:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7784F404BF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bf1WRPFZbLYq for <intel-wired-lan@osuosl.org>;
 Wed, 14 Jun 2023 02:44:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E6F3B404A8
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E6F3B404A8
 for <intel-wired-lan@osuosl.org>; Wed, 14 Jun 2023 02:44:01 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="424386853"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; d="scan'208";a="424386853"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2023 19:44:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="781921942"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; d="scan'208";a="781921942"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.82])
 by fmsmga004.fm.intel.com with ESMTP; 13 Jun 2023 19:43:58 -0700
From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
To: intel-wired-lan@osuosl.org
Date: Wed, 14 Jun 2023 10:42:25 +0800
Message-Id: <20230614024225.13652-1-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686710641; x=1718246641;
 h=from:to:cc:subject:date:message-id;
 bh=HB8nZpKAHP3ZbjQWANks/7dvycH62BVR6eRqBmoq0Hc=;
 b=Y9hzI40T2kBlffpjgkHfD8HBbroR+6i530qfQYZ39RBiKB5lhI4nLuc3
 XbTMT7XJVw2PmJ+73ZyqW12dSoAWa/MWGQkrfswFv6fhLr1WE7rHExIdc
 LVuwm0LMt5aFXHw5/531CZaFPNhoASVHOZt/tAINpP8Q/r9e5IRNyuHRR
 nD7B7uZ5lWqbteW3rSX460yTON4u8XadMcvB/3+cRyewBJ1VgnAntNuSG
 VLWhH+SauCAoJUG/wC030cAxs5/KZXpVyQ/IllDNO2Q5bKGs2zQwzNluW
 F8zpCG6OGByrBW9kdRGXpAehKhCo2+Sj5AJ3bZJjtp4GtwIMxX/mY6Cnm
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Y9hzI40T
Subject: [Intel-wired-lan] [PATCH iwl-net-next v4] igc: Add
 TransmissionOverrun counter
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
Cc: vladimir.oltean@nxp.com, anthony.l.nguyen@intel.com,
 tee.min.tan@linux.intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Add TransmissionOverrun as per defined by IEEE 802.1Q Bridges.
TransmissionOverrun counter shall be incremented if the implementation
detects that a frame from a given queue is still being transmitted by
the MAC when that gate-close event for that queue occurs.

This counter is utilised by the Certification conformance test to
inform the user application whether any packets are currently being
transmitted on a particular queue during a gate-close event.

Intel Discrete I225/I226 have a mechanism to not transmit a packets if
the gate open time is insufficient for the packet transmission by setting
the Strict_End bit. Thus, it is expected for this counter to be always
zero at this moment.

Inspired from enetc_taprio_stats() and enetc_taprio_queue_stats(), now
driver also report the tx_overruns counter per traffic class.

User can get this counter by using below command:
1) tc -s qdisc show dev <interface> root
2) tc -s class show dev <interface>

Test Result (Before):
class mq :1 root
 Sent 1289 bytes 20 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
class mq :2 root
 Sent 124 bytes 2 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
class mq :3 root
 Sent 46028 bytes 86 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
class mq :4 root
 Sent 2596 bytes 14 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0

Test Result (After):
class taprio 100:1 root
 Sent 8491 bytes 38 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
 Transmit overruns: 0
class taprio 100:2 root
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
 Transmit overruns: 0
class taprio 100:3 root
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
 Transmit overruns: 0
class taprio 100:4 root
 Sent 994 bytes 11 pkt (dropped 0, overlimits 0 requeues 1)
 backlog 0b 0p requeues 1
 Transmit overruns: 0

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
---
V3 -> V4: Rework Vladimir's and Anthony's comments to remove the constant
counter from the driver's ring data structure and ethtool statistic
implementation.
V2 -> V3: Included new infra xstats to report back the counter to qdisc
V1 -> V2: Change per-queue stats. Driver still remains adding the
	  statistic independently.
---
 drivers/net/ethernet/intel/igc/igc_main.c | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index e6a44980d0aa4..8a9c61a997832 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6115,6 +6115,26 @@ static int igc_tsn_clear_schedule(struct igc_adapter *adapter)
 	return 0;
 }
 
+static void igc_taprio_stats(struct net_device *dev,
+			     struct tc_taprio_qopt_stats *stats)
+{
+	/* When Strict_End is enabled, the tx_overruns counter
+	 * will always be zero.
+	 */
+	stats->tx_overruns = 0;
+}
+
+static void igc_taprio_queue_stats(struct net_device *dev,
+				   struct tc_taprio_qopt_queue_stats  *queue_stats)
+{
+	struct tc_taprio_qopt_stats *stats = &queue_stats->stats;
+
+	/* When Strict_End is enabled, the tx_overruns counter
+	 * will always be zero.
+	 */
+	stats->tx_overruns = 0;
+}
+
 static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 				 struct tc_taprio_qopt_offload *qopt)
 {
@@ -6132,6 +6152,12 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 	case TAPRIO_CMD_DESTROY:
 		adapter->qbv_enable = false;
 		break;
+	case TAPRIO_CMD_STATS:
+		igc_taprio_stats(adapter->netdev, &qopt->stats);
+		return 0;
+	case TAPRIO_CMD_QUEUE_STATS:
+		igc_taprio_queue_stats(adapter->netdev, &qopt->queue_stats);
+		return 0;
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.17.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
