Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE36BC5CFCF
	for <intel-wired-lan@archiver.kernel.org>; Fri, 14 Aug 2026 14:32:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6FE9A40E93;
	Fri, 14 Aug 2026 14:32:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jCpLDrL7nN2X; Fri, 14 Aug 2026 14:32:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1DE6040F0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786717932;
	bh=9DBH7XKlPfrjHaUVL3AZlDDm3gDjRrjfpvNdyzQnvkU=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=bdVyLopxhSjncwMJT02E6zf/YV2NtAJhwgf+jkshbcw5RyqJ8dVCkrVaf7TkxAFov
	 giSzR85eHQPKGZ2iQJXI6aB9Lt3mtXvY4FegUPjcXgDC7sJxwvbSrtiiPK8ggbdGW6
	 wyhr6ioW6kea/HiHQnp/Wr9D1cHoaVlAf58gYuCHOQjEhGzaMaKZaxYOOIsdlx/aTo
	 hfBfXWnuM/ISjA/k6mID6ZkBBWWBOo24dCPwWopPAjRZeVVLHuYviIXM4PSfV0Hclf
	 qnY9C/69HvsFpQ476IyEZ9XalramwaGukplGWQsrp45tLD4A3mjGETZ0aG5oXZrnAm
	 3ONBcz1i1i8Og==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1DE6040F0A;
	Fri, 14 Aug 2026 14:32:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2935923F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Aug 2026 14:32:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0FABD400A4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Aug 2026 14:32:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dYywunal4MDN for <intel-wired-lan@lists.osuosl.org>;
 Fri, 14 Aug 2026 14:32:09 +0000 (UTC)
X-Greylist: delayed 910 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 14 Aug 2026 14:32:08 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 04095400A2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 04095400A2
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=103.117.158.91;
 helo=sender-pp-o91.zoho.in; envelope-from=kshitiz.bartariya@zohomail.in;
 receiver=<UNKNOWN> 
Received: from sender-pp-o91.zoho.in (sender-pp-o91.zoho.in [103.117.158.91])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 04095400A2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Aug 2026 14:32:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786716950; cv=none; d=zohomail.in; s=zohoarc; 
 b=DsyX1NpykwINFvpa0gxLI9NhnUBmDy9gS4DdSYaBcBI4jq9x9Oe6K0fMO7edmBjuD5MNUwofj7YnAdhjEg/fZYKoncdrDbc1rd9prRbZkwdOct+LmpnMSQV37K9iKMGIkVybkHHfgPf6VK8yfSmVtfv9LGXiN2TKmQD1L9esbMo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in;
 s=zohoarc; t=1786716950;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=9DBH7XKlPfrjHaUVL3AZlDDm3gDjRrjfpvNdyzQnvkU=; 
 b=YQ9QtpXUtVAiqr9OTTd2CszqDKiJr4t8ah/rv9F5u1E3MMSsohLprUgoeujBlZMBijYBrasEbPiITgu43uBSR6uE5y1h7ikWoCgpnF1cAF3M7tb3qhU9Y/1Qqkr8KCrWf6mAs7F4xZoPvSQDAeFLVA6489fzbyQD2GwCQTrs65A=
ARC-Authentication-Results: i=1; mx.zohomail.in;
 dkim=pass  header.i=zohomail.in;
 spf=pass  smtp.mailfrom=kshitiz.bartariya@zohomail.in;
 dmarc=pass header.from=<kshitiz.bartariya@zohomail.in>
Received: by mx.zoho.in with SMTPS id 17867169433445.956065004386005;
 Fri, 14 Aug 2026 19:45:43 +0530 (IST)
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 14 Aug 2026 19:44:36 +0530
Message-ID: <20260814141446.90544-1-kshitiz.bartariya@zohomail.in>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Subject: [Intel-wired-lan] [PATCH net-next v5] ixgbe: implement
 get_queue_stats_rx
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
From: Kshitiz Bartariya via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hook into the netdev_stat_ops interface to expose per RX queue
statistics through the netdev generic netlink API.

The following counters are filled:
 - bytes: maps directly to bytes
 - packets: maps directly to packets
 - alloc_fail: sum of alloc_rx_page_failed and alloc_rx_buff_failed
 - csum_bad: maps directly to csum_err, which is incremented for both
   IP header and L4 checksum errors in ixgbe_rx_checksum().

The new per-queue stats can be observed with:
  $ ynltool qstats show scope queue

Signed-off-by: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
---
v5:
 - Added READ_ONCE() and NULL check for accessing adapter->rx_ring[i]
 - Added u64_stats_fetch_begin before reading stats from rx_ring
 Suggested by Simon Horman

v4:
 - Changed comment format from // to /* */
 - Moved ixgbe_stat_ops declaration next to the ixgbe_netdev_ops
 Suggested by Jedrzej Jagielski.
https://lore.kernel.org/lkml/19ed3cf767d.36a9bda531830.5017017162150392549@zohomail.in/

v3:
 - Added bytes and packets stats counters
 - Implemented ixgbe_get_base_stats function
 As suggested by AI on 
 https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260603174857.78666-1-kshitiz.bartariya%40zohomail.in
 https://lore.kernel.org/lkml/20260612084605.19785-1-kshitiz.bartariya@zohomail.in/

v2:
 Amended commit message with command to get RX queue stats as 
 suggested by Jedrzej Jagielski.
 https://lore.kernel.org/lkml/20260603174857.78666-1-kshitiz.bartariya@zohomail.in/

v1: 
 https://lore.kernel.org/lkml/20260602100932.21838-1-kshitiz.bartariya@zohomail.in/

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 8873a8cc4a18..560177f135ff 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9760,6 +9760,45 @@ static void ixgbe_get_stats64(struct net_device *netdev,
 	stats->rx_missed_errors	= netdev->stats.rx_missed_errors;
 }
 
+static void ixgbe_get_queue_stats_rx(struct net_device *dev, int idx,
+				     struct netdev_queue_stats_rx *stats)
+{
+	struct ixgbe_adapter *adapter = ixgbe_from_netdev(dev);
+	struct ixgbe_ring *ring = READ_ONCE(adapter->rx_ring[idx]);
+	u64 bytes, packets, alloc_rx_page_failed, alloc_rx_buff_failed,
+		csum_err;
+	unsigned int start;
+
+	if (ring) {
+		do {
+			start = u64_stats_fetch_begin(&ring->syncp);
+			bytes = ring->stats.bytes;
+			packets = ring->stats.packets;
+			alloc_rx_page_failed =
+				ring->rx_stats.alloc_rx_page_failed;
+			alloc_rx_buff_failed =
+				ring->rx_stats.alloc_rx_buff_failed;
+			csum_err = ring->rx_stats.csum_err;
+		} while (u64_stats_fetch_retry(&ring->syncp, start));
+	}
+
+	stats->bytes = bytes;
+	stats->packets = packets;
+	stats->alloc_fail = alloc_rx_page_failed + alloc_rx_buff_failed;
+	stats->csum_bad = csum_err;
+}
+
+static void ixgbe_get_base_stats(struct net_device *dev,
+				 struct netdev_queue_stats_rx *rx,
+				 struct netdev_queue_stats_tx *tx)
+{
+	/* ixgbe has no inactive queues */
+	rx->bytes = 0;
+	rx->packets = 0;
+	rx->alloc_fail = 0;
+	rx->csum_bad = 0;
+}
+
 static int ixgbe_ndo_get_vf_stats(struct net_device *netdev, int vf,
 				  struct ifla_vf_stats *vf_stats)
 {
@@ -11117,6 +11156,11 @@ static const struct net_device_ops ixgbe_netdev_ops = {
 	.ndo_hwtstamp_set	= ixgbe_ptp_hwtstamp_set,
 };
 
+static const struct netdev_stat_ops ixgbe_stat_ops = {
+	.get_queue_stats_rx = ixgbe_get_queue_stats_rx,
+	.get_base_stats = ixgbe_get_base_stats,
+};
+
 static void ixgbe_disable_txr_hw(struct ixgbe_adapter *adapter,
 				 struct ixgbe_ring *tx_ring)
 {
@@ -11663,6 +11707,7 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	hw->phy.mdio.mdio_write = ixgbe_mdio_write;
 
 	netdev->netdev_ops = &ixgbe_netdev_ops;
+	netdev->stat_ops = &ixgbe_stat_ops;
 	ixgbe_set_ethtool_ops(netdev);
 	netdev->watchdog_timeo = 5 * HZ;
 	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
-- 
2.50.1 (Apple Git-155)

