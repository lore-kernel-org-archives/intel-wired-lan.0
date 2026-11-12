Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B9A606A32E
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Nov 2026 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=M+Otpyym;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GBrdkn3q
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF4D8606A5;
	Thu, 12 Nov 2026 12:46:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VSg6jolfUlgj; Thu, 12 Nov 2026 12:46:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6689160761
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794487595;
	b=f4/x0GMnmA9Sle9ZCzboFqLVhwd/J7/i83b7dyyWvLoihYzEHXq4V8wDFn5cxoAhQrHt
	 wFp9y7wSvXeRT9o0YHJUjjuIkYflKWDvWBzkHgrHaJ5n8+vSOVSnbR/814nNijSG6OOxp
	 Dq3g/kuDESswAAlEbNJs06UuSxlXcTI2/WJhK6hurv2C8bmLRVBbCjs/Wmx+LaFllkfW0
	 qkMtqAdlQe/+Xh9MOkqsGKwKjYV1/P7pQGgc7FdUJXFI0cY+JQ2DbOglKFBbVtlpUjVvT
	 o1KFZ+IcFXOSySOBGxjvzv6DOHL0/cPm1Q6klQ2rPrUlV4PkinaziI9WNX09NXD7h/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794487595;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lvLLqSbWjNi10HfFWs+v4L1AZLtgdP2gGI9+4z32Seo=;
	b=k/N1qx3GYjKHDVrPn8hT1Quv39qJvDRmgaIvcyffBVfLfHcfjQZWagGjR6lKEa3QrDr+
	 K3saCbWY7OhLs948SJCk+t3/pPmu2k5csBYpfqzhIE02l9AeZvqz31E5iIFPxpx6I6gp4
	 IGF2WiZjepmEfzSTAEJN4uMjijTlAiKUAlnmyaTCAbH7Yt2/WyqotcrNzMP3GY1LUQqXf
	 Smx4ykfvCO7DL7umXTsmUWVEKl2fynAOdJ+r5Zd5vhUb3weVnH1Q0YH2lGRweFNqVBABA
	 rDkm1LWHLdqbaHHYnqC6UzRcr/JSyj9i2snsmsFnL5nO4IDyGZ1wdTvcmE20WOiz0Fg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794487595;
	bh=lvLLqSbWjNi10HfFWs+v4L1AZLtgdP2gGI9+4z32Seo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M+OtpyymNLN9yjsH5U1+u7RCHdf4oiKRt+T8sF+rvVkFqgnhm1mn7jCBWgsqyxFwf
	 EUPxFnqu11cLrNRMHl14OF0r3XyWFC1viuZEttbrhfUTJu0FcyHeqcgD0IQa52vrHJ
	 Eo+SrImrkgr9sTNH/1QHA7/8xz18FmD96j5bKr/DJAvDywEzGlke+llHIMWcDPQuLw
	 FFYbcEGD1JFfG1QaeJOxEEwOKVpLIa1UPLxs3+sxPT+Z/8rEHCLtPMnFITZIonmM2I
	 NO7kgAQUxnZ7a+EuBwdsgY29u4Jxf/Rof8CguJaDiD4HAVo91RmDcFTTkD6Kq/UGP7
	 j4qfpwWiykjXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6689160761;
	Thu, 12 Nov 2026 12:46:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F2929335
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 12:46:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DA0258143F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 12:46:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c7yfZkhDa9mk for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Nov 2026 12:46:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E8A5A811CA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=przemyslaw.korba@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=GBrdkn3q
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E8A5A811CA
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 12:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794487592; x=1826023592;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wNzMTVOkzaHo5bM5KRn7eE6YdBWn6ZWPrBInrl6cXyo=;
 b=GBrdkn3qnh/RNbCg4Lx+Gm+xCgyZuRFocQMLBWsAT7Q//f1qEXzMeA6I
 UiFGIPvQ0w09/AeBLUDEcwO0AjLEZlYqLmGE/jJE3LazN0LPYdGGFO6ss
 GYqGnUB8VQSTkw/Ie8KvmPi/DalooKvZwNPSKCGKxzsoSvdWIjkn1hSKB
 PGmR94/tpU12W+D73kiW6a2nzgnwSEKw00z4yLYaNNMK+NrN7NCk/zCx9
 i4GVcCyBjXcNMpXG2svrKyd4bjgzrNyGtNKYelxiYMpG+v884+98FHVIe
 D883MuImvUGsZW90/YR3JDimDnm7KK+vaC+mN63zyDdt8eQgo8t1dlgL+ Q==;
X-CSE-ConnectionGUID: dcpghH7bRv6ILMP22GKmuA==
X-CSE-MsgGUID: Odcwl6elQD6dubMixWvXnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3172844"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3172844"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 04:46:32 -0800
X-CSE-ConnectionGUID: OhiecdL5SYGumZCXQZf+dA==
X-CSE-MsgGUID: AO0smrKFRsWWmnrvB39/Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8833299"
Received: from gklab-003-014.igk.intel.com ([10.91.173.44])
 by orviesa009.jf.intel.com with ESMTP; 12 Nov 2026 04:46:29 -0800
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 aleksandr.loktionov@intel.com, arkadiusz.kubalewski@intel.com,
 konstantin.ilichev@intel.com, sreedevi.joshi@intel.com,
 namangulati@google.com, Przemyslaw Korba <przemyslaw.korba@intel.com>
Subject: [PATCH iwl-next v3 2/2] idpf: add direct Tx timestamp readout
Date: Thu, 12 Nov 2026 13:34:54 +0100
Message-ID: <20261112123503.234508-5-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261112123503.234508-1-przemyslaw.korba@intel.com>
References: <20261112123503.234508-1-przemyslaw.korba@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently IDPF supports only mailbox access to PHC operations and
Tx timestamping, however the driver shall also be able to handle direct
access. The difference is that PHC/timestamps actions are performed
directly, through BAR registers, instead of sending a virtchnl message to
CP. Registers offsets are negotiated with the CP during the capabilities
negotiation.

In the direct mode the latches are collected by a timer that runs at a
fixed 100 us period for as long as the Tx timestamping is enabled. The
Tx path only hands out a latch index, and the Tx completion path does
not touch the latches at all, so no register access is added to either
of them.

Hand out a latch only while the Tx timestamping is enabled on the
netdev, which is checked under the latches lock. When the user turns it
off or the vport is stopped, stop the timer and flush the latches that
are still waiting, as nothing would collect them anymore. Start the
timer again when the vport is opened with the Tx timestamping enabled.

The latch readiness bits are write-1-to-clear and are not cleared by
reading the timestamp registers, so clear the bit of every latch the
timer consumes. Otherwise a bit set once stays set forever and every
subsequent packet reusing that index is reported with a stale timestamp.
Clear it for a latch given up on as well, as the hardware may report it
after the deadline has passed. Cross-check the per-latch valid bit too,
to never report a latch the device has not written. All of the clearing
is done by the collecting timer, so that the Tx path is left without any
register access.

Give up on a timestamp request after 500 ms. A packet dropped inside the
device never latches a timestamp, and without a deadline it would leak
both the skb and the latch index. Count such requests as lost in the HW
timestamping statistics.

Co-developed-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
Reviewed-by: Naman Gulati <namangulati@google.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        |   6 +
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |   8 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   2 +
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 403 +++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_ptp.h    |  52 ++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  23 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  12 +-
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  86 +++-
 include/linux/net/intel/virtchnl2.h           |   6 +-
 9 files changed, 547 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 77729921b0a3..7978ca56d1d5 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -270,12 +270,16 @@ enum idpf_vport_flags {
  * @discarded: Number of Tx skbs discarded due to cached PHC
  *	       being too old to correctly extend timestamp
  * @flushed: Number of Tx skbs flushed due to interface closed
+ * @expired: Number of Tx skbs dropped because the hardware has not latched
+ *	     the timestamp in time, e.g. when the packet was dropped by the
+ *	     device after it has been transmitted by the driver
  */
 struct idpf_tstamp_stats {
 	struct u64_stats_sync stats_sync;
 	u64_stats_t packets;
 	u64_stats_t discarded;
 	u64_stats_t flushed;
+	u64_stats_t expired;
 };
 
 struct idpf_port_stats {
@@ -383,6 +387,7 @@ struct idpf_q_vec_rsrc {
  * @tx_tstamp_caps: Capabilities negotiated for Tx timestamping
  * @tstamp_config: The Tx tstamp config
  * @tstamp_task: Tx timestamping task
+ * @tx_tstamp_timer: timer that collects the Tx timestamps in the direct mode
  * @tstamp_stats: Tx timestamping statistics
  */
 struct idpf_vport {
@@ -419,6 +424,7 @@ struct idpf_vport {
 	struct idpf_ptp_vport_tx_tstamp_caps *tx_tstamp_caps;
 	struct kernel_hwtstamp_config tstamp_config;
 	struct work_struct tstamp_task;
+	struct hrtimer tx_tstamp_timer;
 	struct idpf_tstamp_stats tstamp_stats;
 };
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 95c45f12b0f9..96d5c372f7cb 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -1739,8 +1739,9 @@ static int idpf_get_ts_info(struct net_device *netdev,
  * @ts_stats: HW timestamping stats structure
  *
  * Collect HW timestamping statistics including successfully timestamped
- * packets, discarded due to illegal values, flushed during releasing PTP and
- * skipped due to lack of the free index.
+ * packets, discarded due to illegal values, flushed during releasing PTP,
+ * expired because the hardware never latched a timestamp and skipped due to
+ * lack of the free index.
  */
 static void idpf_get_ts_stats(struct net_device *netdev,
 			      struct ethtool_ts_stats *ts_stats)
@@ -1755,7 +1756,8 @@ static void idpf_get_ts_stats(struct net_device *netdev,
 	do {
 		start = u64_stats_fetch_begin(&vport->tstamp_stats.stats_sync);
 		ts_stats->pkts = u64_stats_read(&vport->tstamp_stats.packets);
-		ts_stats->lost = u64_stats_read(&vport->tstamp_stats.flushed);
+		ts_stats->lost = u64_stats_read(&vport->tstamp_stats.flushed) +
+				 u64_stats_read(&vport->tstamp_stats.expired);
 		ts_stats->err = u64_stats_read(&vport->tstamp_stats.discarded);
 	} while (u64_stats_fetch_retry(&vport->tstamp_stats.stats_sync, start));
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 237f9ae9f1ca..10ee15108073 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -845,6 +845,7 @@ static void idpf_vport_stop(struct idpf_vport *vport, bool rtnl)
 
 	idpf_send_disable_vport_msg(adapter, vport_id);
 	idpf_send_disable_queues_msg(vport);
+	idpf_ptp_tx_tstamp_stop(vport);
 	idpf_send_map_unmap_queue_vector_msg(adapter, rsrc, vport_id, false);
 	/* Normally we ask for queues in create_vport, but if the number of
 	 * initially requested queues have changed, for example via ethtool
@@ -1450,6 +1451,7 @@ static int idpf_vport_open(struct idpf_vport *vport, bool rtnl)
 		goto disable_vport;
 	}
 
+	idpf_ptp_tx_tstamp_start(vport);
 	idpf_up_complete(vport);
 
 	if (rtnl)
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
index df2da430ff28..5d745a53d686 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
@@ -4,6 +4,16 @@
 #include "idpf.h"
 #include "idpf_ptp.h"
 
+/* Period of the Tx timestamp collection. Way below the jiffy granularity, as
+ * a timestamp reported late skews the PTP error bounds.
+ */
+#define IDPF_PTP_TX_TSTAMP_PERIOD_NS		(100 * NSEC_PER_USEC)
+
+/* Time after which a Tx timestamp that the hardware has never latched is
+ * given up on, e.g. when the packet was dropped inside the device.
+ */
+#define IDPF_PTP_TX_TSTAMP_TIMEOUT		msecs_to_jiffies(500)
+
 /**
  * idpf_ptp_get_access - Determine the access type of the PTP features
  * @adapter: Driver specific private structure
@@ -820,6 +830,55 @@ u64 idpf_ptp_extend_ts(struct idpf_vport *vport, u64 in_tstamp)
 						 lower_32_bits(in_tstamp));
 }
 
+/**
+ * idpf_ptp_clear_tx_tstamp_ready - Clear the readiness bits of Tx latches
+ * @caps: Tx timestamp capabilities of the vport
+ * @map: bitmap of the latch indexes to clear
+ *
+ * The readiness bits are write-1-to-clear and are not cleared by reading the
+ * latch registers, so a bit left behind would make the next user of the same
+ * index report the timestamp of the previous packet. Only the bits set in
+ * @map are written, as the remaining ones may belong to latches that are
+ * still waiting to be read.
+ */
+void idpf_ptp_clear_tx_tstamp_ready(struct idpf_ptp_vport_tx_tstamp_caps *caps,
+				    u64 map)
+{
+	u32 map_l = lower_32_bits(map);
+	u32 map_h = upper_32_bits(map);
+
+	/* Flush the posted writes, the bits have to be cleared in the
+	 * hardware before the indexes are handed out again.
+	 */
+	if (map_l) {
+		writel(map_l, caps->readiness_addr_l);
+		readl(caps->readiness_addr_l);
+	}
+
+	if (map_h) {
+		writel(map_h, caps->readiness_addr_h);
+		readl(caps->readiness_addr_h);
+	}
+}
+
+/**
+ * idpf_ptp_read_tx_tstamp_readiness - Read the Tx timestamp readiness bitmap
+ * @caps: Tx timestamp capabilities of the vport
+ *
+ * Return: bitmap of the latch indexes for which the hardware has reported
+ * a timestamp.
+ */
+static u64
+idpf_ptp_read_tx_tstamp_readiness(struct idpf_ptp_vport_tx_tstamp_caps *caps)
+{
+	u32 readiness_l, readiness_h;
+
+	readiness_l = readl(caps->readiness_addr_l);
+	readiness_h = readl(caps->readiness_addr_h);
+
+	return ((u64)readiness_h << 32) | readiness_l;
+}
+
 /**
  * idpf_ptp_request_ts - Request an available Tx timestamp index
  * @tx_q: Transmit queue on which the Tx timestamp is requested
@@ -835,15 +894,30 @@ u64 idpf_ptp_extend_ts(struct idpf_vport *vport, u64 in_tstamp)
 int idpf_ptp_request_ts(struct idpf_tx_queue *tx_q, struct sk_buff *skb,
 			u32 *idx)
 {
+	struct idpf_ptp_vport_tx_tstamp_caps *tstamp_caps;
 	struct idpf_ptp_tx_tstamp *ptp_tx_tstamp;
+	struct idpf_vport *vport;
 	struct list_head *head;
 
-	/* Get the index from the free latches list */
-	spin_lock(&tx_q->cached_tstamp_caps->latches_lock);
+	tstamp_caps = tx_q->cached_tstamp_caps;
+	vport = idpf_netdev_to_vport(tx_q->netdev);
+
+	spin_lock(&tstamp_caps->latches_lock);
 
-	head = &tx_q->cached_tstamp_caps->latches_free;
+	/* Disabling the Tx timestamping flushes the latches under this lock,
+	 * so one taken here is always collected or flushed.
+	 */
+	if (READ_ONCE(vport->tstamp_config.tx_type) != HWTSTAMP_TX_ON) {
+		spin_unlock(&tstamp_caps->latches_lock);
+
+		return -EPERM;
+	}
+
+	/* Get the index from the free latches list */
+	head = &tstamp_caps->latches_free;
 	if (list_empty(head)) {
-		spin_unlock(&tx_q->cached_tstamp_caps->latches_lock);
+		spin_unlock(&tstamp_caps->latches_lock);
+
 		return -ENOBUFS;
 	}
 
@@ -851,19 +925,296 @@ int idpf_ptp_request_ts(struct idpf_tx_queue *tx_q, struct sk_buff *skb,
 					 list_member);
 	list_del(&ptp_tx_tstamp->list_member);
 
+	ptp_tx_tstamp->deadline = jiffies + IDPF_PTP_TX_TSTAMP_TIMEOUT;
 	ptp_tx_tstamp->skb = skb_get(skb);
 	skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 
 	/* Move the element to the used latches list */
-	list_add(&ptp_tx_tstamp->list_member,
-		 &tx_q->cached_tstamp_caps->latches_in_use);
-	spin_unlock(&tx_q->cached_tstamp_caps->latches_lock);
+	list_add(&ptp_tx_tstamp->list_member, &tstamp_caps->latches_in_use);
 
 	*idx = ptp_tx_tstamp->idx;
 
+	spin_unlock(&tstamp_caps->latches_lock);
+
 	return 0;
 }
 
+/**
+ * idpf_ptp_read_tx_tstamp - Read and extract timestamp from latch registers
+ * @tstamp_caps: Tx timestamp capabilities of the vport
+ * @tx_tstamp: Tx timestamp structure with latch register addresses
+ *
+ * Read the timestamp from the latch registers, whose layout the IDPF
+ * specification defines as:
+ *   low  bit[0]   : valid flag
+ *   low  bit[31:1]: timestamp bits [30:0]
+ *   high bit[7:0] : timestamp bits [38:31]
+ * Together they form a 39-bit timestamp, which is then shifted right by
+ * tstamp_ns_lo_bit to remove sub-nanosecond precision bits.
+ *
+ * The caller has already found the latch index set in the readiness bitmap,
+ * which is preferred over the per-latch valid flag because it covers every
+ * latch in a single pair of reads. The valid flag is still checked here, as
+ * the hardware may overwrite a latch whose readiness bit has been left set.
+ *
+ * @latches_lock must be held across the readiness check, this call and the
+ * subsequent clearing of the readiness bit, to keep the index from being
+ * recycled in between.
+ *
+ * Return: extracted timestamp value in nanoseconds, 0 if the latch does not
+ * hold a valid timestamp.
+ */
+static u64
+idpf_ptp_read_tx_tstamp(struct idpf_ptp_vport_tx_tstamp_caps *tstamp_caps,
+			struct idpf_ptp_tx_tstamp *tx_tstamp)
+{
+	u32 tstamp_l, tstamp_h;
+	u64 tstamp;
+
+	lockdep_assert_held(&tstamp_caps->latches_lock);
+
+	tstamp_l = readl(tx_tstamp->tx_latch_reg_addr_l);
+	tstamp_h = readl(tx_tstamp->tx_latch_reg_addr_h);
+
+	if (unlikely(!(tstamp_l & IDPF_PTP_TX_TSTAMP_L_VALID_M)))
+		return 0;
+
+	tstamp = FIELD_GET(IDPF_PTP_TX_TSTAMP_L_TSTAMP_M, tstamp_l);
+	tstamp |= FIELD_PREP(IDPF_PTP_TX_TSTAMP_H_POS_M,
+			     FIELD_GET(IDPF_PTP_TX_TSTAMP_H_TSTAMP_M, tstamp_h));
+
+	return tstamp >> tstamp_caps->tstamp_ns_lo_bit;
+}
+
+/**
+ * idpf_ptp_report_tx_tstamp - Report timestamp to stack and update stats
+ * @vport: Virtual port structure
+ * @skb: Socket buffer to report timestamp for
+ * @tstamp: Raw timestamp value to extend and report
+ *
+ * Extend the 39-bit hardware timestamp to 64-bit, report to stack via
+ * skb_tstamp_tx(), and update packet statistics.
+ */
+static void idpf_ptp_report_tx_tstamp(struct idpf_vport *vport,
+				      struct sk_buff *skb, u64 tstamp)
+{
+	struct skb_shared_hwtstamps shhwtstamps;
+	u64 extended_tstamp;
+
+	extended_tstamp = idpf_ptp_extend_ts(vport, tstamp);
+	if (!extended_tstamp)
+		goto consume;
+
+	shhwtstamps = (struct skb_shared_hwtstamps){
+		.hwtstamp	= ns_to_ktime(extended_tstamp),
+	};
+
+	skb_tstamp_tx(skb, &shhwtstamps);
+
+	u64_stats_update_begin(&vport->tstamp_stats.stats_sync);
+	u64_stats_inc(&vport->tstamp_stats.packets);
+	u64_stats_update_end(&vport->tstamp_stats.stats_sync);
+
+consume:
+	consume_skb(skb);
+}
+
+/**
+ * idpf_ptp_get_tx_tstamp_direct - Read timestamps directly from HW registers
+ * @vport: Virtual port structure
+ *
+ * Collect the latches for which the hardware has reported a timestamp, as
+ * well as the ones that have not been reported before their deadline, and
+ * hand them over to the stack. A packet dropped inside the device never
+ * latches a timestamp, so without the deadline its latch would never be
+ * reclaimed.
+ *
+ * The latches are detached from the in-use list before the lock is dropped,
+ * so that their skbs can be reported without the index being recycled in the
+ * meantime.
+ */
+static void idpf_ptp_get_tx_tstamp_direct(struct idpf_vport *vport)
+{
+	struct idpf_ptp_vport_tx_tstamp_caps *tstamp_caps;
+	struct idpf_ptp_tx_tstamp *ptp_tx_tstamp, *tmp;
+	u64 readiness_bitmap, clear_map = 0;
+	LIST_HEAD(done);
+
+	tstamp_caps = vport->tx_tstamp_caps;
+
+	spin_lock(&tstamp_caps->latches_lock);
+
+	if (list_empty(&tstamp_caps->latches_in_use)) {
+		spin_unlock(&tstamp_caps->latches_lock);
+		return;
+	}
+
+	readiness_bitmap = idpf_ptp_read_tx_tstamp_readiness(tstamp_caps);
+
+	list_for_each_entry_safe(ptp_tx_tstamp, tmp,
+				 &tstamp_caps->latches_in_use, list_member) {
+		u32 idx = ptp_tx_tstamp->idx;
+
+		ptp_tx_tstamp->tstamp = 0;
+
+		if (readiness_bitmap & BIT_ULL(idx)) {
+			ptp_tx_tstamp->tstamp =
+				idpf_ptp_read_tx_tstamp(tstamp_caps,
+							ptp_tx_tstamp);
+			/* Keep the bit set if the latch holds no valid
+			 * timestamp yet, so that it is read again.
+			 */
+			if (ptp_tx_tstamp->tstamp)
+				clear_map |= BIT_ULL(idx);
+		}
+
+		/* A latch with no timestamp is kept in use until its deadline
+		 * passes, as the hardware may still be about to report it.
+		 * Once it does, drop its readiness bit as well, so that the
+		 * next user of the index is not given a stale timestamp if
+		 * the hardware reports one after the latch has been reclaimed.
+		 */
+		if (!ptp_tx_tstamp->tstamp) {
+			if (time_is_after_jiffies(ptp_tx_tstamp->deadline))
+				continue;
+
+			clear_map |= BIT_ULL(idx);
+		}
+
+		list_move(&ptp_tx_tstamp->list_member, &done);
+	}
+
+	/* The indexes are not recycled before the splice below, so the bits
+	 * of every latch read above can be dropped in a single write.
+	 */
+	idpf_ptp_clear_tx_tstamp_ready(tstamp_caps, clear_map);
+
+	spin_unlock(&tstamp_caps->latches_lock);
+
+	list_for_each_entry(ptp_tx_tstamp, &done, list_member) {
+		if (ptp_tx_tstamp->tstamp) {
+			idpf_ptp_report_tx_tstamp(vport, ptp_tx_tstamp->skb,
+						  ptp_tx_tstamp->tstamp);
+		} else {
+			u64_stats_update_begin(&vport->tstamp_stats.stats_sync);
+			u64_stats_inc(&vport->tstamp_stats.expired);
+			u64_stats_update_end(&vport->tstamp_stats.stats_sync);
+
+			net_warn_ratelimited("%s: Tx timestamp for latch %u never arrived\n",
+					     vport->netdev->name,
+					     ptp_tx_tstamp->idx);
+
+			dev_kfree_skb_any(ptp_tx_tstamp->skb);
+		}
+
+		ptp_tx_tstamp->skb = NULL;
+	}
+
+	spin_lock(&tstamp_caps->latches_lock);
+	list_splice(&done, &tstamp_caps->latches_free);
+	spin_unlock(&tstamp_caps->latches_lock);
+}
+
+/**
+ * idpf_ptp_tx_tstamp_timer_cb - Periodically collect the Tx timestamps
+ * @timer: Tx timestamp collection timer
+ *
+ * Return: HRTIMER_RESTART to keep collecting at a fixed period.
+ */
+static enum hrtimer_restart idpf_ptp_tx_tstamp_timer_cb(struct hrtimer *timer)
+{
+	struct idpf_vport *vport;
+
+	vport = container_of(timer, struct idpf_vport, tx_tstamp_timer);
+
+	idpf_ptp_get_tx_tstamp_direct(vport);
+	hrtimer_forward_now(timer, IDPF_PTP_TX_TSTAMP_PERIOD_NS);
+
+	return HRTIMER_RESTART;
+}
+
+/**
+ * idpf_ptp_tx_tstamp_timer_init - Set up the Tx timestamp collection timer
+ * @vport: Virtual port structure
+ */
+void idpf_ptp_tx_tstamp_timer_init(struct idpf_vport *vport)
+{
+	hrtimer_setup(&vport->tx_tstamp_timer, idpf_ptp_tx_tstamp_timer_cb,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
+}
+
+/**
+ * idpf_ptp_tx_tstamp_start - Start collecting the Tx timestamps
+ * @vport: Virtual port structure
+ *
+ * In the direct mode nothing in the Tx path reads the latches, so the
+ * collection is driven by a timer that runs for as long as the Tx
+ * timestamping is enabled and the vport is up.
+ */
+void idpf_ptp_tx_tstamp_start(struct idpf_vport *vport)
+{
+	if (!idpf_ptp_is_vport_tx_tstamp_ena(vport) ||
+	    vport->tx_tstamp_caps->access != IDPF_PTP_DIRECT)
+		return;
+
+	/* The callback re-arms itself, so it must be finished before the timer
+	 * is started again, e.g. when only the Rx filter is being changed.
+	 */
+	if (READ_ONCE(vport->tstamp_config.tx_type) == HWTSTAMP_TX_ON) {
+		hrtimer_cancel(&vport->tx_tstamp_timer);
+		hrtimer_start(&vport->tx_tstamp_timer,
+			      IDPF_PTP_TX_TSTAMP_PERIOD_NS,
+			      HRTIMER_MODE_REL_SOFT);
+	}
+}
+
+/**
+ * idpf_ptp_tx_tstamp_stop - Stop collecting the Tx timestamps
+ * @vport: Virtual port structure
+ *
+ * Stop the collection timer and flush the latches that are still waiting for
+ * a timestamp, as nothing would collect them anymore. No new latch is handed
+ * out afterwards, either because the Tx timestamping has been disabled, which
+ * idpf_ptp_request_ts() checks under the latches lock, or because the Tx path
+ * is stopped.
+ */
+void idpf_ptp_tx_tstamp_stop(struct idpf_vport *vport)
+{
+	struct idpf_ptp_vport_tx_tstamp_caps *tstamp_caps;
+	struct idpf_ptp_tx_tstamp *ptp_tx_tstamp, *tmp;
+	u64 clear_map = 0;
+
+	if (!idpf_ptp_is_vport_tx_tstamp_ena(vport) ||
+	    vport->tx_tstamp_caps->access != IDPF_PTP_DIRECT)
+		return;
+
+	tstamp_caps = vport->tx_tstamp_caps;
+
+	hrtimer_cancel(&vport->tx_tstamp_timer);
+
+	spin_lock_bh(&tstamp_caps->latches_lock);
+
+	u64_stats_update_begin(&vport->tstamp_stats.stats_sync);
+	list_for_each_entry_safe(ptp_tx_tstamp, tmp,
+				 &tstamp_caps->latches_in_use, list_member) {
+		u64_stats_inc(&vport->tstamp_stats.flushed);
+
+		clear_map |= BIT_ULL(ptp_tx_tstamp->idx);
+
+		if (ptp_tx_tstamp->skb)
+			consume_skb(ptp_tx_tstamp->skb);
+
+		ptp_tx_tstamp->skb = NULL;
+		list_move(&ptp_tx_tstamp->list_member,
+			  &tstamp_caps->latches_free);
+	}
+	u64_stats_update_end(&vport->tstamp_stats.stats_sync);
+
+	idpf_ptp_clear_tx_tstamp_ready(tstamp_caps, clear_map);
+
+	spin_unlock_bh(&tstamp_caps->latches_lock);
+}
+
 /**
  * idpf_ptp_set_rx_tstamp - Enable or disable Rx timestamping
  * @vport: Virtual port structure
@@ -923,12 +1274,21 @@ int idpf_ptp_set_timestamp_mode(struct idpf_vport *vport,
 	case HWTSTAMP_TX_ON:
 		if (!idpf_ptp_is_vport_tx_tstamp_ena(vport))
 			return -EINVAL;
+
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	vport->tstamp_config.tx_type = config->tx_type;
+	/* Publish the new mode first, so that the Tx path stops handing out
+	 * latches, then flush the ones that are still waiting.
+	 */
+	WRITE_ONCE(vport->tstamp_config.tx_type, config->tx_type);
+	if (config->tx_type == HWTSTAMP_TX_ON)
+		idpf_ptp_tx_tstamp_start(vport);
+	else
+		idpf_ptp_tx_tstamp_stop(vport);
+
 	idpf_ptp_set_rx_tstamp(vport, config->rx_filter);
 	*config = vport->tstamp_config;
 
@@ -1035,8 +1395,19 @@ static void idpf_ptp_release_vport_tstamp(struct idpf_vport *vport)
 {
 	struct idpf_ptp_tx_tstamp *ptp_tx_tstamp, *tmp;
 	struct list_head *head;
+	u64 clear_map = 0;
 
-	cancel_work_sync(&vport->tstamp_task);
+	switch (vport->tx_tstamp_caps->access) {
+	case IDPF_PTP_MAILBOX:
+		cancel_work_sync(&vport->tstamp_task);
+		break;
+	case IDPF_PTP_DIRECT:
+		hrtimer_cancel(&vport->tx_tstamp_timer);
+		break;
+	case IDPF_PTP_NONE:
+	default:
+		break;
+	}
 
 	/* Remove list with free latches */
 	spin_lock_bh(&vport->tx_tstamp_caps->latches_lock);
@@ -1053,6 +1424,10 @@ static void idpf_ptp_release_vport_tstamp(struct idpf_vport *vport)
 	list_for_each_entry_safe(ptp_tx_tstamp, tmp, head, list_member) {
 		u64_stats_inc(&vport->tstamp_stats.flushed);
 
+		/* The index is only range-checked in the direct mode */
+		if (vport->tx_tstamp_caps->access == IDPF_PTP_DIRECT)
+			clear_map |= BIT_ULL(ptp_tx_tstamp->idx);
+
 		list_del(&ptp_tx_tstamp->list_member);
 		if (ptp_tx_tstamp->skb)
 			consume_skb(ptp_tx_tstamp->skb);
@@ -1061,6 +1436,10 @@ static void idpf_ptp_release_vport_tstamp(struct idpf_vport *vport)
 	}
 	u64_stats_update_end(&vport->tstamp_stats.stats_sync);
 
+	if (vport->tx_tstamp_caps->access == IDPF_PTP_DIRECT)
+		idpf_ptp_clear_tx_tstamp_ready(vport->tx_tstamp_caps,
+					       clear_map);
+
 	spin_unlock_bh(&vport->tx_tstamp_caps->latches_lock);
 
 	kfree(vport->tx_tstamp_caps);
@@ -1098,10 +1477,8 @@ bool idpf_ptp_get_txq_tstamp_capability(struct idpf_tx_queue *txq)
 {
 	if (!txq || !txq->cached_tstamp_caps)
 		return false;
-	else if (txq->cached_tstamp_caps->access)
-		return true;
-	else
-		return false;
+
+	return txq->cached_tstamp_caps->access != IDPF_PTP_NONE;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.h b/drivers/net/ethernet/intel/idpf/idpf_ptp.h
index 0a2f08b17033..3b4ecf63e176 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.h
@@ -6,6 +6,17 @@
 
 #include <linux/ptp_clock_kernel.h>
 
+/* Layout of the Tx timestamp latch registers, mandated by the IDPF
+ * specification. Only the register offsets are negotiated with the Control
+ * Plane, the field placement within them is fixed:
+ * Low register:  bit[0] = valid, bit[31:1] = timestamp bits [30:0]
+ * High register: bit[7:0] = timestamp bits [38:31]
+ */
+#define IDPF_PTP_TX_TSTAMP_L_VALID_M	BIT(0)
+#define IDPF_PTP_TX_TSTAMP_L_TSTAMP_M	GENMASK(31, 1)
+#define IDPF_PTP_TX_TSTAMP_H_TSTAMP_M	GENMASK(7, 0)
+#define IDPF_PTP_TX_TSTAMP_H_POS_M	GENMASK_ULL(38, 31)
+
 /**
  * struct idpf_ptp_cmd_mask - PTP command masks
  * @exec_cmd: mask to trigger command execution
@@ -122,40 +133,48 @@ struct idpf_ptp_tx_tstamp_status {
 /**
  * struct idpf_ptp_tx_tstamp - Parameters for Tx timestamping
  * @list_member: the list member structure
- * @tx_latch_reg_offset_l: Tx tstamp latch low register offset
- * @tx_latch_reg_offset_h: Tx tstamp latch high register offset
+ * @tx_latch_reg_addr_l: Tx tstamp latch low register address
+ * @tx_latch_reg_addr_h: Tx tstamp latch high register address
  * @skb: the pointer to the SKB for this timestamp request
  * @tstamp: the Tx tstamp value
+ * @deadline: time after which the latch is reclaimed even if the hardware has
+ *	      not reported the timestamp
  * @idx: the index of the Tx tstamp
  */
 struct idpf_ptp_tx_tstamp {
 	struct list_head list_member;
-	u32 tx_latch_reg_offset_l;
-	u32 tx_latch_reg_offset_h;
+	void __iomem *tx_latch_reg_addr_l;
+	void __iomem *tx_latch_reg_addr_h;
 	struct sk_buff *skb;
 	u64 tstamp;
+	unsigned long deadline;
 	u32 idx;
 };
 
 /**
  * struct idpf_ptp_vport_tx_tstamp_caps - Tx timestamp capabilities
- * @vport_id: the vport id
  * @num_entries: the number of negotiated Tx timestamp entries
  * @tstamp_ns_lo_bit: first bit for nanosecond part of the timestamp
- * @latches_lock: the lock to the lists of free/used timestamp indexes
- * @status_lock: the lock to the status tracker
- * @access: indicates an access to Tx timestamp
+ * @access: the type of the supported access to Tx timestamp
+ * @latches_lock: the lock to the lists of free/used timestamp indexes. Taken
+ *		  from the Tx path and from the timestamp collection timer, so
+ *		  process context users must disable bottom halves
+ * @status_lock: the lock to the status tracker. Mailbox access only, also
+ *		 taken from the NAPI completion path
+ * @readiness_addr_l: Tx tstamp readiness bitmap low register address
+ * @readiness_addr_h: Tx tstamp readiness bitmap high register address
  * @latches_free: the list of the free Tx timestamps latches
  * @latches_in_use: the list of the used Tx timestamps latches
  * @tx_tstamp_status: Tx tstamp status tracker
  */
 struct idpf_ptp_vport_tx_tstamp_caps {
-	u32 vport_id;
 	u16 num_entries;
 	u16 tstamp_ns_lo_bit;
+	enum idpf_ptp_access access;
 	spinlock_t latches_lock;
 	spinlock_t status_lock;
-	bool access:1;
+	void __iomem *readiness_addr_l;
+	void __iomem *readiness_addr_h;
 	struct list_head latches_free;
 	struct list_head latches_in_use;
 	struct idpf_ptp_tx_tstamp_status tx_tstamp_status[];
@@ -302,12 +321,18 @@ int idpf_ptp_adj_dev_clk_fine_mb(struct idpf_adapter *adapter, u64 incval);
 int idpf_ptp_adj_dev_clk_time_mb(struct idpf_adapter *adapter, s64 delta);
 int idpf_ptp_get_vport_tstamps_caps(struct idpf_vport *vport);
 int idpf_ptp_get_tx_tstamp_mb(struct idpf_vport *vport);
+void
+idpf_ptp_clear_tx_tstamp_ready(struct idpf_ptp_vport_tx_tstamp_caps *caps,
+			       u64 map);
 int idpf_ptp_set_timestamp_mode(struct idpf_vport *vport,
 				struct kernel_hwtstamp_config *config);
 u64 idpf_ptp_extend_ts(struct idpf_vport *vport, u64 in_tstamp);
 u64 idpf_ptp_tstamp_extend_32b_to_64b(u64 cached_phc_time, u32 in_timestamp);
 int idpf_ptp_request_ts(struct idpf_tx_queue *tx_q, struct sk_buff *skb,
 			u32 *idx);
+void idpf_ptp_tx_tstamp_timer_init(struct idpf_vport *vport);
+void idpf_ptp_tx_tstamp_start(struct idpf_vport *vport);
+void idpf_ptp_tx_tstamp_stop(struct idpf_vport *vport);
 void idpf_tstamp_task(struct work_struct *work);
 #else /* CONFIG_PTP_1588_CLOCK */
 static inline int idpf_ptp_init(struct idpf_adapter *adapter)
@@ -400,6 +425,13 @@ static inline int idpf_ptp_request_ts(struct idpf_tx_queue *tx_q,
 	return -EOPNOTSUPP;
 }
 
+static inline void idpf_ptp_tx_tstamp_timer_init(struct idpf_vport *vport) { }
+
+static inline void idpf_ptp_tx_tstamp_start(struct idpf_vport *vport) { }
+
+static inline void idpf_ptp_tx_tstamp_stop(struct idpf_vport *vport) { }
+
 static inline void idpf_tstamp_task(struct work_struct *work) { }
+
 #endif /* CONFIG_PTP_1588_CLOCK */
 #endif /* _IDPF_PTP_H */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 8239c1e59620..d687b7c240e4 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1459,9 +1459,13 @@ static int idpf_vport_init_fast_path_txqs(struct idpf_vport *vport,
 					  struct idpf_q_vec_rsrc *rsrc)
 {
 	struct idpf_ptp_vport_tx_tstamp_caps *caps = vport->tx_tstamp_caps;
-	struct work_struct *tstamp_task = &vport->tstamp_task;
+	struct work_struct *tstamp_task = NULL;
 	int k = 0;
 
+	if (vport->adapter->ptp &&
+	    vport->adapter->ptp->tx_tstamp_access != IDPF_PTP_NONE)
+		tstamp_task = &vport->tstamp_task;
+
 	vport->txqs = kzalloc_objs(*vport->txqs, rsrc->num_txq);
 	if (!vport->txqs)
 		return -ENOMEM;
@@ -2030,7 +2034,8 @@ int idpf_vport_queues_alloc(struct idpf_vport *vport,
  * @skb: socket buffer to provide Tx timestamp value
  *
  * Schedule a work to read Tx timestamp value generated once the packet is
- * transmitted.
+ * transmitted. In the direct access mode the timestamps are collected by a
+ * periodic timer instead, so that no register access is needed here.
  */
 static void idpf_tx_read_tstamp(struct idpf_tx_queue *txq, struct sk_buff *skb)
 {
@@ -2038,7 +2043,10 @@ static void idpf_tx_read_tstamp(struct idpf_tx_queue *txq, struct sk_buff *skb)
 	struct idpf_ptp_tx_tstamp_status *tx_tstamp_status;
 
 	tx_tstamp_caps = txq->cached_tstamp_caps;
-	spin_lock_bh(&tx_tstamp_caps->status_lock);
+	if (!tx_tstamp_caps || tx_tstamp_caps->access != IDPF_PTP_MAILBOX)
+		return;
+
+	spin_lock(&tx_tstamp_caps->status_lock);
 
 	for (u32 i = 0; i < tx_tstamp_caps->num_entries; i++) {
 		tx_tstamp_status = &tx_tstamp_caps->tx_tstamp_status[i];
@@ -2055,7 +2063,7 @@ static void idpf_tx_read_tstamp(struct idpf_tx_queue *txq, struct sk_buff *skb)
 		break;
 	}
 
-	spin_unlock_bh(&tx_tstamp_caps->status_lock);
+	spin_unlock(&tx_tstamp_caps->status_lock);
 }
 
 #define idpf_tx_splitq_clean_bump_ntc(txq, ntc, desc, buf)	\
@@ -2981,6 +2989,13 @@ static int idpf_tx_tstamp(struct idpf_tx_queue *tx_q, struct sk_buff *skb,
 	if (likely(!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)))
 		return -1;
 
+	/* Cheap check to skip the latches lock, the authoritative one is done
+	 * under it by idpf_ptp_request_ts().
+	 */
+	if (READ_ONCE(idpf_netdev_to_vport(tx_q->netdev)->tstamp_config.tx_type) !=
+	    HWTSTAMP_TX_ON)
+		return -1;
+
 	if (!idpf_ptp_get_txq_tstamp_capability(tx_q))
 		return -1;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 1a77bcbe48d8..04236f0ff20e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3364,7 +3364,17 @@ int idpf_vport_init(struct idpf_vport *vport, struct idpf_vport_max_q *max_q)
 		return 0;
 	}
 
-	INIT_WORK(&vport->tstamp_task, idpf_tstamp_task);
+	switch (vport->adapter->ptp->tx_tstamp_access) {
+	case IDPF_PTP_MAILBOX:
+		INIT_WORK(&vport->tstamp_task, idpf_tstamp_task);
+		break;
+	case IDPF_PTP_DIRECT:
+		idpf_ptp_tx_tstamp_timer_init(vport);
+		break;
+	case IDPF_PTP_NONE:
+	default:
+		break;
+	}
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
index ef71df2d51ef..5cf441708ed3 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
@@ -48,6 +48,7 @@ int idpf_ptp_get_caps(struct idpf_adapter *adapter)
 				    VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME_MB |
 				    VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK |
 				    VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK_MB |
+				    VIRTCHNL2_CAP_PTP_TX_TSTAMPS |
 				    VIRTCHNL2_CAP_PTP_TX_TSTAMPS_MB)
 	};
 	struct libie_ctlq_xn_send_params xn_params = {
@@ -405,22 +406,24 @@ int idpf_ptp_adj_dev_clk_fine_mb(struct idpf_adapter *adapter, u64 incval)
  */
 int idpf_ptp_get_vport_tstamps_caps(struct idpf_vport *vport)
 {
+	struct libie_mmio_info *mmio = &vport->adapter->ctlq_ctx.mmio_info;
 	struct virtchnl2_ptp_get_vport_tx_tstamp_caps send_tx_tstamp_caps;
 	struct virtchnl2_ptp_get_vport_tx_tstamp_caps *rcv_tx_tstamp_caps;
 	struct virtchnl2_ptp_tx_tstamp_latch_caps tx_tstamp_latch_caps;
+	enum idpf_ptp_access tstamp_access, get_dev_clk_access;
 	struct idpf_ptp_vport_tx_tstamp_caps *tstamp_caps;
 	struct idpf_ptp_tx_tstamp *ptp_tx_tstamp, *tmp;
 	struct libie_ctlq_xn_send_params xn_params = {
 		.chnl_opcode = VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP_CAPS,
 		.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
 	};
-	enum idpf_ptp_access tstamp_access, get_dev_clk_access;
 	struct idpf_ptp *ptp = vport->adapter->ptp;
 	struct list_head *head;
+	u64 clear_map = 0;
 	size_t reply_sz;
 	u16 num_latches;
+	u32 size, temp;
 	int err = 0;
-	u32 size;
 
 	if (!ptp)
 		return -EOPNOTSUPP;
@@ -458,7 +461,7 @@ int idpf_ptp_get_vport_tstamps_caps(struct idpf_vport *vport)
 		goto get_tstamp_caps_out;
 	}
 
-	tstamp_caps->access = true;
+	tstamp_caps->access = tstamp_access;
 	tstamp_caps->num_entries = num_latches;
 
 	INIT_LIST_HEAD(&tstamp_caps->latches_in_use);
@@ -469,9 +472,22 @@ int idpf_ptp_get_vport_tstamps_caps(struct idpf_vport *vport)
 
 	tstamp_caps->tstamp_ns_lo_bit = rcv_tx_tstamp_caps->tstamp_ns_lo_bit;
 
-	for (u16 i = 0; i < tstamp_caps->num_entries; i++) {
-		__le32 offset_l, offset_h;
+	if (tstamp_access == IDPF_PTP_DIRECT) {
+		temp = le32_to_cpu(rcv_tx_tstamp_caps->readiness_offset_l);
+		tstamp_caps->readiness_addr_l =
+			libie_pci_get_mmio_addr(mmio, temp);
+		temp = le32_to_cpu(rcv_tx_tstamp_caps->readiness_offset_h);
+		tstamp_caps->readiness_addr_h =
+			libie_pci_get_mmio_addr(mmio, temp);
+
+		if (!tstamp_caps->readiness_addr_l ||
+		    !tstamp_caps->readiness_addr_h) {
+			err = -EINVAL;
+			goto err_free_tstamp_caps;
+		}
+	}
 
+	for (u16 i = 0; i < num_latches; i++) {
 		ptp_tx_tstamp = kzalloc_obj(*ptp_tx_tstamp);
 		if (!ptp_tx_tstamp) {
 			err = -ENOMEM;
@@ -483,25 +499,59 @@ int idpf_ptp_get_vport_tstamps_caps(struct idpf_vport *vport)
 		if (tstamp_access != IDPF_PTP_DIRECT)
 			goto skip_offsets;
 
-		offset_l = tx_tstamp_latch_caps.tx_latch_reg_offset_l;
-		offset_h = tx_tstamp_latch_caps.tx_latch_reg_offset_h;
-		ptp_tx_tstamp->tx_latch_reg_offset_l = le32_to_cpu(offset_l);
-		ptp_tx_tstamp->tx_latch_reg_offset_h = le32_to_cpu(offset_h);
+		temp = le32_to_cpu(tx_tstamp_latch_caps.tx_latch_reg_offset_l);
+		ptp_tx_tstamp->tx_latch_reg_addr_l =
+			libie_pci_get_mmio_addr(mmio, temp);
+		temp = le32_to_cpu(tx_tstamp_latch_caps.tx_latch_reg_offset_h);
+		ptp_tx_tstamp->tx_latch_reg_addr_h =
+			libie_pci_get_mmio_addr(mmio, temp);
+
+		if (!ptp_tx_tstamp->tx_latch_reg_addr_l ||
+		    !ptp_tx_tstamp->tx_latch_reg_addr_h) {
+			err = -EINVAL;
+			goto err_free_ptp_tx_tstamp;
+		}
 
 skip_offsets:
+		/* Direct mode uses a 64-bit readiness bitmap, so an index
+		 * outside of its range means the Control Plane sent a
+		 * malformed message and nothing it reported can be trusted.
+		 */
+		if (tstamp_access == IDPF_PTP_DIRECT &&
+		    tx_tstamp_latch_caps.index >= BITS_PER_TYPE(u64)) {
+			pci_err(vport->adapter->pdev,
+				"Tx timestamp latch index %u out of the readiness bitmap range\n",
+				tx_tstamp_latch_caps.index);
+			err = -EINVAL;
+			goto err_free_ptp_tx_tstamp;
+		}
+
 		ptp_tx_tstamp->idx = tx_tstamp_latch_caps.index;
 
+		/* The readiness bits are write-1-to-clear, so collect the ones
+		 * that a previous owner of the latch may have left set. The
+		 * index is only range-checked in the direct mode.
+		 */
+		if (tstamp_access == IDPF_PTP_DIRECT)
+			clear_map |= BIT_ULL(ptp_tx_tstamp->idx);
+
 		list_add(&ptp_tx_tstamp->list_member,
 			 &tstamp_caps->latches_free);
 
 		tstamp_caps->tx_tstamp_status[i].state = IDPF_PTP_FREE;
 	}
 
+	/* No traffic is flowing yet, so a single write drops every stale bit */
+	if (tstamp_access == IDPF_PTP_DIRECT)
+		idpf_ptp_clear_tx_tstamp_ready(tstamp_caps, clear_map);
+
 	vport->tx_tstamp_caps = tstamp_caps;
 	libie_ctlq_release_rx_buf(&xn_params.recv_mem);
 
 	return 0;
 
+err_free_ptp_tx_tstamp:
+	kfree(ptp_tx_tstamp);
 err_free_ptp_tx_stamp_list:
 	head = &tstamp_caps->latches_free;
 	list_for_each_entry_safe(ptp_tx_tstamp, tmp, head, list_member) {
@@ -509,6 +559,7 @@ int idpf_ptp_get_vport_tstamps_caps(struct idpf_vport *vport)
 		kfree(ptp_tx_tstamp);
 	}
 
+err_free_tstamp_caps:
 	kfree(tstamp_caps);
 get_tstamp_caps_out:
 	libie_ctlq_release_rx_buf(&xn_params.recv_mem);
@@ -521,8 +572,8 @@ int idpf_ptp_get_vport_tstamps_caps(struct idpf_vport *vport)
  *				    the skb compatibility.
  * @caps: Tx timestamp capabilities that monitor the latch status
  * @skb: skb for which the tstamp value is returned through virtchnl message
- * @current_state: Current state of the Tx timestamp latch
- * @expected_state: Expected state of the Tx timestamp latch
+ * @state_before: Current state of the Tx timestamp latch
+ * @state_after: Expected state of the Tx timestamp latch
  *
  * Find a proper skb tracker for which the Tx timestamp is received and change
  * the state to expected value.
@@ -532,24 +583,23 @@ int idpf_ptp_get_vport_tstamps_caps(struct idpf_vport *vport)
 static bool
 idpf_ptp_update_tstamp_tracker(struct idpf_ptp_vport_tx_tstamp_caps *caps,
 			       struct sk_buff *skb,
-			       enum idpf_ptp_tx_tstamp_state current_state,
-			       enum idpf_ptp_tx_tstamp_state expected_state)
+			       enum idpf_ptp_tx_tstamp_state state_before,
+			       enum idpf_ptp_tx_tstamp_state state_after)
 {
 	bool updated = false;
 
-	spin_lock(&caps->status_lock);
+	spin_lock_bh(&caps->status_lock);
 	for (u16 i = 0; i < caps->num_entries; i++) {
 		struct idpf_ptp_tx_tstamp_status *status;
 
 		status = &caps->tx_tstamp_status[i];
-
-		if (skb == status->skb && status->state == current_state) {
-			status->state = expected_state;
+		if (skb == status->skb && status->state == state_before) {
+			status->state = state_after;
 			updated = true;
 			break;
 		}
 	}
-	spin_unlock(&caps->status_lock);
+	spin_unlock_bh(&caps->status_lock);
 
 	return updated;
 }
diff --git a/include/linux/net/intel/virtchnl2.h b/include/linux/net/intel/virtchnl2.h
index 39fea65c075c..80787197e7e2 100644
--- a/include/linux/net/intel/virtchnl2.h
+++ b/include/linux/net/intel/virtchnl2.h
@@ -1464,7 +1464,8 @@ VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_ptp_tx_tstamp_latch_caps);
  * @num_latches: Total number of latches
  * @tstamp_ns_lo_bit: First bit for nanosecond part of the timestamp
  * @tstamp_ns_hi_bit: Last bit for nanosecond part of the timestamp
- * @pad: Padding for future tstamp granularity extensions
+ * @readiness_offset_l: Tx tstamp readiness bitmap low register offset
+ * @readiness_offset_h: Tx tstamp readiness bitmap high register offset
  * @tstamp_latches: Capabilities of Tx timestamp entries
  *
  * PF/VF sends this message to negotiate the Tx timestamp latches for each
@@ -1477,7 +1478,8 @@ struct virtchnl2_ptp_get_vport_tx_tstamp_caps {
 	__le16 num_latches;
 	u8 tstamp_ns_lo_bit;
 	u8 tstamp_ns_hi_bit;
-	u8 pad[8];
+	__le32 readiness_offset_l;
+	__le32 readiness_offset_h;
 
 	struct virtchnl2_ptp_tx_tstamp_latch_caps tstamp_latches[]
 						  __counted_by_le(num_latches);
-- 
2.47.3

