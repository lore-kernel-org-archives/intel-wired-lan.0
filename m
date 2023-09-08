Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4E3EE57EB
	for <intel-wired-lan@archiver.kernel.org>; Fri,  8 Sep 2023 11:31:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA72D81F46;
	Fri,  8 Sep 2023 11:31:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AA72D81F46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1694172692;
	bh=tBtrxuLbpFwpIbp5WCa71hRqp4MmNl0gdj9EJoDvL50=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=Aw59HTL0XxW7xFpHzYtuhaLiX9KFkEXBQO24a/0yQ6SsXgGDAMQ+nr+rZ4082JgZX
	 dh+0QeywXvCnzoQeLesWslgy6BWuITgIT2VARbs2sfZjTDrvhuHF/cDR9ln0vKKjuR
	 lHirKCPknuVe+Lza6bZQR6DGhpexBLXzHjGRgoiEvhGQjVU93jueEp8E9cN0X+it7Z
	 S4ZbBY5IxLu77UPY5gu01L1KrluojJqWAqt77ZcJDr2hJWEAG0iJaKhMgEEmQRqXuw
	 1jCs2l62iOg3p+en1jpjE9UmqsKqVj5jdf9RNrPN/nkZxbklGCQGIgaSYO6egNXA/Y
	 zrz5fkhstzmmA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m1VCcfY5jJ3b; Fri,  8 Sep 2023 11:31:32 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9EA481F24;
	Fri,  8 Sep 2023 11:31:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B9EA481F24
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 219971BF327
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 Sep 2023 11:31:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EBC5B41751
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 Sep 2023 11:31:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EBC5B41751
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z-C4YztmuMGK for <intel-wired-lan@lists.osuosl.org>;
 Fri,  8 Sep 2023 11:31:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 979DA41748
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 Sep 2023 11:31:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 979DA41748
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="381440161"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; d="scan'208";a="381440161"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2023 04:31:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="719137937"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; d="scan'208";a="719137937"
Received: from gklab-018-208.igk.intel.com ([10.102.18.208])
 by orsmga006.jf.intel.com with ESMTP; 08 Sep 2023 04:31:09 -0700
From: Kamil Maziarz <kamil.maziarz@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Fri,  8 Sep 2023 13:31:01 +0200
Message-Id: <20230908113101.153591-1-kamil.maziarz@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694172688; x=1725708688;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Pun97aLnomRpnyAxb8k9ViMikOUUKWVAtUMFIy+Shec=;
 b=OFO+a5/o15bF5xq25LmXKfeGr11oElzOG8MMmp1EGNrJEkzMaL4bLnaM
 OuJjZ0r57c0ibLlVaAbEJs9rj63nfsVJActMeSSBbiiWV1yAQdgMvMPyy
 xBnqEgtGnwbNtWni2Sg2207L0aIdfrzZJJhMg2O6lDDQ0ptC8Cu/1ByXp
 3MayFKAISLRwmnpMDZMQG1I2G5kYU448+ii5KQQOcVWXrCEZhvAr6NJSp
 Dx0C5MQlQt04fDmkcKOlIqtt91ICorV1mZiDaxypKSERcYpajhOIyl+rx
 ZXX2nAESX+KJerVgCl68/jnpjK5yx23CD6AFgsH5AsV/Z9PIZTRpJQwhh
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=OFO+a5/o
Subject: [Intel-wired-lan] [PATCH iwl-net v1] ice: don't stop netdev tx
 queues when setting up XSK socket
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
Cc: Kamil Maziarz <kamil.maziarz@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Avoid stopping netdev  tx queues during XSK setup by removing
netif_tx_stop_queue() and netif_tx_start_queue(). These changes
prevent unnecessary stopping and starting of netdev transmit queues
during the setup of XDP socket. Without this change, after stopping
the XDP traffic flow tracker and then stopping the XDP prog - NETDEV
WATCHDOG transmit queue timed out appears.

Signed-off-by: Kamil Maziarz <kamil.maziarz@intel.com>
Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index a7fe2b4ce655..cd56ceae8aef 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -179,7 +179,6 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 			return -EBUSY;
 		usleep_range(1000, 2000);
 	}
-	netif_tx_stop_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
 
 	ice_fill_txq_meta(vsi, tx_ring, &txq_meta);
 	err = ice_vsi_stop_tx_ring(vsi, ICE_NO_RESET, 0, tx_ring, &txq_meta);
@@ -268,7 +267,6 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 	ice_qvec_toggle_napi(vsi, q_vector, true);
 	ice_qvec_ena_irq(vsi, q_vector);
 
-	netif_tx_start_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
 free_buf:
 	kfree(qg_buf);
 	return err;
-- 
2.31.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
