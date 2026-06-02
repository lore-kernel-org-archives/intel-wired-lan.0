Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C49CD6E61
	for <intel-wired-lan@archiver.kernel.org>; Tue,  2 Jun 2026 10:10:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B78181F1B;
	Tue,  2 Jun 2026 10:10:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Oldq1zion9n2; Tue,  2 Jun 2026 10:10:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A1A5381F1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1780395046;
	bh=MR0Lsgq+PHZRBwFD+0O5DuR2QLpLWp2we9s5q3tK/G8=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=bAKGuGIyFtzON3idIXvezwuaV/uKQk/+yyK/bZx9EuabF8FMxvM839+2W130wsxYK
	 Rq+2WekT1WbZmbj3od/1veJXNvFHsoQyL22eva5ycWZnj1DV2JCD3aZaBrIGtOQ0Vd
	 NYlTL2l+syYNfgynWmyMHJJsD9/q364xcKaH3dMQwUo3N4LmVMjfo0YCed9ht32brO
	 LoGRKf5r8bd9qKqCMnk03SU93QXo6u5i1KMzs5lJthvlxh5IbwelR4Axgfi2KFoJ2P
	 L9s1Zu7umAKLjdtILA3CLbo6Sk/sXO/Cj0quAGlxkiCoTxVZ4eM/8XOS61cq9ovkWq
	 UeOPII4xHAnXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A1A5381F1D;
	Tue,  2 Jun 2026 10:10:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D23BF4
 for <intel-wired-lan@lists.osuosl.org>; Tue,  2 Jun 2026 10:10:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1F04040188
 for <intel-wired-lan@lists.osuosl.org>; Tue,  2 Jun 2026 10:10:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8DEIUFtfZhck for <intel-wired-lan@lists.osuosl.org>;
 Tue,  2 Jun 2026 10:10:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=103.117.158.93;
 helo=sender-pp-o93.zoho.in; envelope-from=kshitiz.bartariya@zohomail.in;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4BCA940184
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4BCA940184
Received: from sender-pp-o93.zoho.in (sender-pp-o93.zoho.in [103.117.158.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4BCA940184
 for <intel-wired-lan@lists.osuosl.org>; Tue,  2 Jun 2026 10:10:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780394986; cv=none; d=zohomail.in; s=zohoarc; 
 b=MUy3vAfdYE8/oKhAoPXB20T8Wp3vAJFoOrQY90RUMfAtgm6QhP3LX28qsT3EIJ4DCLBKlLtfq1lEFqZW5X5NNz5vZWWSb8yrMjqLNwrh82FhkvXoRrYXyU0XlKydJCKEKQPqTsD6rwwupdVcs13Nl85nXDkNFgsX8TCbmWt6aro=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in;
 s=zohoarc; t=1780394986;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=MR0Lsgq+PHZRBwFD+0O5DuR2QLpLWp2we9s5q3tK/G8=; 
 b=f81NkU5bMuN5Far+phTq4Dbf+pQxWpbTCH1bEBvBN8FhuR1LzisWfHQs4czzwHoBP2ATzXFhRylswX+skFPjxSWkAm9ma6NbaNItEuMZ8bUIdaH0EvW7p5r8ut+YYfQ2ty0ZYjuhe83sCd1jlN+DLx9bcQJbdQtFbVpWP/W7aRU=
ARC-Authentication-Results: i=1; mx.zohomail.in;
 dkim=pass  header.i=zohomail.in;
 spf=pass  smtp.mailfrom=kshitiz.bartariya@zohomail.in;
 dmarc=pass header.from=<kshitiz.bartariya@zohomail.in>
Received: by mx.zoho.in with SMTPS id 1780394978142936.8750900178738;
 Tue, 2 Jun 2026 15:39:38 +0530 (IST)
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, aleksandr.loktionov@intel.com,
 jacob.e.keller@intel.com
Cc: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue,  2 Jun 2026 15:39:26 +0530
Message-ID: <20260602100932.21838-1-kshitiz.bartariya@zohomail.in>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1780394986; 
 s=zoho; d=zohomail.in; i=kshitiz.bartariya@zohomail.in;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=MR0Lsgq+PHZRBwFD+0O5DuR2QLpLWp2we9s5q3tK/G8=;
 b=gu7wyZxO32BKCCtl7ZC8jt03EON9frmf+0KqjDUz6AzgL2Rk5U7VvWhi0WcWJK3L
 UNP4P3f7JBoecN3c0SlFeJ06Jx+pH6G6Y5zSykjDr5jhf00qwRapj+eiVS6dKQfdqrA
 7fZcf0ENFOXQSTneY3nVDUptH5i5xGu5WD1cyxJI=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=zohomail.in
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.in header.i=kshitiz.bartariya@zohomail.in
 header.a=rsa-sha256 header.s=zoho header.b=gu7wyZxO
Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: implement
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

 - alloc_fail: sum of alloc_rx_page_failed and alloc_rx_buff_failed

 - csum_bad: maps directly to csum_err, which is incremented for both
   IP header and L4 checksum errors in ixgbe_rx_checksum().

Signed-off-by: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
---
This patch was previously discussed for the net tree:
Link: https://lore.kernel.org/lkml/20260526074744.36315-1-kshitiz.bartariya@zohomail.in/

Sending to net-next as suggested by Jacob Keller and Aleksandr Loktionov.


 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index bc16e4c93fd4..05d4b8aff1fc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9759,6 +9759,21 @@ static void ixgbe_get_stats64(struct net_device *netdev,
 	stats->rx_missed_errors	= netdev->stats.rx_missed_errors;
 }
 
+static void ixgbe_get_queue_stats_rx(struct net_device *dev, int idx,
+				     struct netdev_queue_stats_rx *stats)
+{
+	struct ixgbe_adapter *adapter = ixgbe_from_netdev(dev);
+	struct ixgbe_ring *ring = adapter->rx_ring[idx];
+
+	stats->alloc_fail = ring->rx_stats.alloc_rx_page_failed +
+			    ring->rx_stats.alloc_rx_buff_failed;
+	stats->csum_bad = ring->rx_stats.csum_err;
+}
+
+static const struct netdev_stat_ops ixgbe_stat_ops = {
+	.get_queue_stats_rx	= ixgbe_get_queue_stats_rx,
+};
+
 static int ixgbe_ndo_get_vf_stats(struct net_device *netdev, int vf,
 				  struct ifla_vf_stats *vf_stats)
 {
@@ -11662,6 +11677,7 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	hw->phy.mdio.mdio_write = ixgbe_mdio_write;
 
 	netdev->netdev_ops = &ixgbe_netdev_ops;
+	netdev->stat_ops   = &ixgbe_stat_ops;
 	ixgbe_set_ethtool_ops(netdev);
 	netdev->watchdog_timeo = 5 * HZ;
 	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
-- 
2.50.1 (Apple Git-155)

