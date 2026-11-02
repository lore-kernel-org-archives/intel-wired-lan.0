Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5330C606A324
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=injA1mD6;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ivMf5fok
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 279F1605F3;
	Mon,  2 Nov 2026 11:17:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QzNe16_ZfSw2; Mon,  2 Nov 2026 11:17:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 00DD16075A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793618233;
	b=B/jLDN+/en4NfuvgdzvMOd8DboRSBRVbcFshuqutEsRvz4GK7RolU5gK//d8A2JtKyTY
	 NGPcBteWBLZSwaO9TQuN0SYIQNnjxeB2s6D3dXBZJ1vUxw9TZAalw0aDgdGq0wLZ5zZc9
	 1w+xKJ8qtf6VVAVPX+aSbP77lmwCYCu5GoYoM+q+UAmnq+OCMTuvQXFSDRMU/HgQ+EVnk
	 UJpGRORVs0NzgFKD7X69aN+JOqFqZsRjRwIXR3I9B8JTNf0pCcFCN8y7jDSfCz+hDW2+n
	 yzD5gaTnyzTVIKltelXBJwXiiey4PtrXZhPzg04/h+5hyTQ7CufzWnH7zAnoprq6Nnw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793618233;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eLW/Oy0vPSP1GvE8sryG+ILa6ehJYek40fIRUgh7/TM=;
	b=AtAEW5vIUArxh7r81FIIwTvV4V17+a4xFi5coEu/aw7T4hqL6pjg1b567HjrzhNjnlls
	 KaRHaPBeNiEztc5X6LU2RQ55fAvlB8B0qfuNODgqHWAyPzYc5F7Xjfk5qOFO/Dl99hHIe
	 A3cTLWveohQschInmXRyfdrrgVbo4Fi4us54hYUiisAH13J/gHFlEBmzGIa7D7WNpXOzI
	 OuaMQPkX0PYCdOW47fpv3n/HLzVLK9hlS0F1HPLmxH6t8XzPfI9Tmh+FlMK1gdBPMVj+j
	 dzvjlcsQTOJUc5APRx+Jl0jA/4BV1sEu5LslRdax/xrgSv0IPsrBOJpuB1X5hEdTc/g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793618233;
	bh=eLW/Oy0vPSP1GvE8sryG+ILa6ehJYek40fIRUgh7/TM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=injA1mD6V8LehIpZ6UXg3Gboc7jkw4z3x7xPLk32YZHB4tB/CQyLF/M0EyPJCp+Kc
	 DioAfBlvHeToy8ZnIntZONapUa25bXxtGFl22yExcfgMhCqq9BZwb3LysTriEpU3cN
	 a3uEvHz3Bbj/ozHtueXQywPRXHTKqNyvKuHQdXTHcMk6dzJDGLVnrxshMU2eDidO2U
	 bsj//gOdNLxmanPSMBtAZbHSGEILd+Fho9dEJFyf5sTx5tVKpU4PE/ztuZt6nQ6zPx
	 NurUOOqIdGQu+jELlUGFD4/fKkchJ2DrTjvAOs+gDXDeFBl5wbWyHVvYQHq/JGDltj
	 Y04r4kb979tAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00DD16075A;
	Mon,  2 Nov 2026 11:17:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CD4A9156
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 11:17:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C09F940730
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 11:17:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GYa1AVKcV-Rs for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Nov 2026 11:17:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3873740719
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793618229;
 b=l6jPEP5QZSzrGVbVwjuwqBbKYfPfL+/DGoQPm1oXjW1VFNtI+/dtZi/tlQF7FgOYCNNQ
 Uo7URu8moDJfELrS7XGAjtVIN/LYLlaLDWHr6mCELrhXpE4lcdSoos7m+RG6K2bCSfjPg
 7lMlSC9EGD2Ggg0b2Pyaq1/FqmcjiehEK/Oiv8oHVCGstaltP2mLajU449gTuo5RyK3nU
 AL3e2S2yCjYuRBg0XnEfpncc3V5O69TuUbZyt/j7mV56iiC/fflqhd+7YWkbbDzOLOY4T
 a575DiArKOByAdbsO9SRzG2OrQ9M1MIEQz5YPirqy924/Y5YmmT7Od1lzeEB0L0ns5A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793618229;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=eLW/Oy0vPSP1GvE8sryG+ILa6ehJYek40fIRUgh7/TM=;
 b=b8QHPRAlpDxYttB/K+RFxlQwuy6lSrcpg8jpEGmAKVUV1Edqz8AFq95yCqcDSwnlqMU/
 eksUbIwpGst2BtkJpCp5rtsuWjTLl31d5ADdtBknI4YTqhtmOtWKcXiMKuREgPeLh1WV0
 VfUTUtESdYYRafF7eE6imRXBwEajuW5sRB6z01HzN1bMYBrGZrprVnBBXywiqE7TMPhLV
 xUFmGVVcxbq20yLmgM+WBMe8zFvhPR2J7ODfZKaNAMM1IIiwq6AIDNTg4FXROwcxWxhGL
 nMuDP+ABcf5lH0WQIuwn2FLOHtQTH/CO5XEqVnLFeTGyc0Gerts9FbhBB6UWiyW4k/g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ivMf5fok; 
 arc=none smtp.remote-ip=192.198.163.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=przemyslaw.korba@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ivMf5fok
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3873740719
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 11:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793618229; x=1825154229;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Or9MjYHO6n7WBM9olqibmEdrnbtD7oVncbnSCDPRd2g=;
 b=ivMf5foks2q5NZLXHpwMW7tl09RHPV8HTUjSBFgKUM0iZ8JguAupBdLo
 lrdVo5gRysPv0VecGI43xdSuIDscbpFj0P9+Ettf/3qIT/tY/l1Hezy2x
 VxCGzJxLFr9c1LT6f43W3NGXx+RldUKw5T8AYivNlT93p/2KjF8onZ8ZV
 fkn8Tm42/mXTraTdIH6i5BzaXgtmjtSoutUPNAOZTA/IndxMBJ7SRBGmC
 2O51trSOCr+M0u5vVUABdVNNnyvdcQDA+iBj089Ah2j/aKRbeuOY9ePG3
 pMoTWu8DYLk4HmncLqyrviXA0Z+6etR6F+D9StFaldDR6EHwp0EyknRKH w==;
X-CSE-ConnectionGUID: r88rWTKzTPC5U9XUPO0R/A==
X-CSE-MsgGUID: XT+sRQiOTMmkhWlcy++POQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2199292"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2199292"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 03:17:08 -0800
X-CSE-ConnectionGUID: vYUwI1ftTxSzaMjT74W1mg==
X-CSE-MsgGUID: xyM9ZVk9TJ6soRT7RG4gUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7872845"
Received: from gklab-003-014.igk.intel.com ([10.91.173.44])
 by fmviesa012.fm.intel.com with ESMTP; 02 Nov 2026 03:17:06 -0800
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 aleksandr.loktionov@intel.com, arkadiusz.kubalewski@intel.com,
 konstantin.ilichev@intel.com, sreedevi.joshi@intel.com,
 Naman Gulati <namangulati@google.com>,
 Przemyslaw Korba <przemyslaw.korba@intel.com>
Subject: [PATCH iwl-next 2/2] idpf: add direct Tx timestamp readout
Date: Mon,  2 Nov 2026 12:07:11 +0100
Message-ID: <20261102110717.77800-3-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102110717.77800-1-przemyslaw.korba@intel.com>
References: <20261102110717.77800-1-przemyslaw.korba@intel.com>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
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
netdev. The collection stops as soon as the user turns it off, so a
latch taken with it disabled would never be collected nor freed.

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
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 333 +++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_ptp.h    |  46 ++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  24 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  12 +-
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  86 ++++-
 include/linux/net/intel/virtchnl2.h           |   6 +-
 8 files changed, 469 insertions(+), 52 deletions(-)

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
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
index a781b3dbe2d6..adb3f31daa5d 100644
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
@@ -814,6 +824,55 @@ u64 idpf_ptp_extend_ts(struct idpf_vport *vport, u64 in_tstamp)
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
@@ -829,35 +888,258 @@ u64 idpf_ptp_extend_ts(struct idpf_vport *vport, u64 in_tstamp)
 int idpf_ptp_request_ts(struct idpf_tx_queue *tx_q, struct sk_buff *skb,
 			u32 *idx)
 {
+	struct idpf_ptp_vport_tx_tstamp_caps *tstamp_caps;
 	struct idpf_ptp_tx_tstamp *ptp_tx_tstamp;
 	struct list_head *head;
 
+	tstamp_caps = tx_q->cached_tstamp_caps;
+
 	/* Get the index from the free latches list */
-	spin_lock(&tx_q->cached_tstamp_caps->latches_lock);
+	guard(spinlock)(&tstamp_caps->latches_lock);
 
-	head = &tx_q->cached_tstamp_caps->latches_free;
-	if (list_empty(head)) {
-		spin_unlock(&tx_q->cached_tstamp_caps->latches_lock);
+	head = &tstamp_caps->latches_free;
+	if (list_empty(head))
 		return -ENOBUFS;
-	}
 
 	ptp_tx_tstamp = list_first_entry(head, struct idpf_ptp_tx_tstamp,
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
+			clear_map |= BIT_ULL(idx);
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
+ * idpf_ptp_tx_tstamp_timer_set - Arm or disarm the Tx timestamp timer
+ * @vport: Virtual port structure
+ * @enable: whether the Tx timestamps are to be collected
+ *
+ * In the direct mode nothing in the Tx path reads the latches, so the
+ * collection is driven by a timer that runs for as long as the Tx
+ * timestamping is enabled.
+ */
+static void idpf_ptp_tx_tstamp_timer_set(struct idpf_vport *vport, bool enable)
+{
+	if (!idpf_ptp_is_vport_tx_tstamp_ena(vport) ||
+	    vport->tx_tstamp_caps->access != IDPF_PTP_DIRECT)
+		return;
+
+	if (enable)
+		hrtimer_start(&vport->tx_tstamp_timer,
+			      IDPF_PTP_TX_TSTAMP_PERIOD_NS,
+			      HRTIMER_MODE_REL_SOFT);
+	else
+		hrtimer_cancel(&vport->tx_tstamp_timer);
+}
+
 /**
  * idpf_ptp_set_rx_tstamp - Enable or disable Rx timestamping
  * @vport: Virtual port structure
@@ -917,12 +1199,18 @@ int idpf_ptp_set_timestamp_mode(struct idpf_vport *vport,
 	case HWTSTAMP_TX_ON:
 		if (!idpf_ptp_is_vport_tx_tstamp_ena(vport))
 			return -EINVAL;
+
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	vport->tstamp_config.tx_type = config->tx_type;
+	/* Publish the new mode before the collection is disarmed, so that the
+	 * Tx path stops handing out latches that nothing would collect.
+	 */
+	WRITE_ONCE(vport->tstamp_config.tx_type, config->tx_type);
+	idpf_ptp_tx_tstamp_timer_set(vport, config->tx_type == HWTSTAMP_TX_ON);
+
 	idpf_ptp_set_rx_tstamp(vport, config->rx_filter);
 	*config = vport->tstamp_config;
 
@@ -1029,8 +1317,19 @@ static void idpf_ptp_release_vport_tstamp(struct idpf_vport *vport)
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
@@ -1047,6 +1346,10 @@ static void idpf_ptp_release_vport_tstamp(struct idpf_vport *vport)
 	list_for_each_entry_safe(ptp_tx_tstamp, tmp, head, list_member) {
 		u64_stats_inc(&vport->tstamp_stats.flushed);
 
+		/* The index is only range-checked in the direct mode */
+		if (vport->tx_tstamp_caps->access == IDPF_PTP_DIRECT)
+			clear_map |= BIT_ULL(ptp_tx_tstamp->idx);
+
 		list_del(&ptp_tx_tstamp->list_member);
 		if (ptp_tx_tstamp->skb)
 			consume_skb(ptp_tx_tstamp->skb);
@@ -1055,6 +1358,10 @@ static void idpf_ptp_release_vport_tstamp(struct idpf_vport *vport)
 	}
 	u64_stats_update_end(&vport->tstamp_stats.stats_sync);
 
+	if (vport->tx_tstamp_caps->access == IDPF_PTP_DIRECT)
+		idpf_ptp_clear_tx_tstamp_ready(vport->tx_tstamp_caps,
+					       clear_map);
+
 	spin_unlock_bh(&vport->tx_tstamp_caps->latches_lock);
 
 	kfree(vport->tx_tstamp_caps);
@@ -1092,10 +1399,8 @@ bool idpf_ptp_get_txq_tstamp_capability(struct idpf_tx_queue *txq)
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
index 0a2f08b17033..634eeb68d27b 100644
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
@@ -302,12 +321,16 @@ int idpf_ptp_adj_dev_clk_fine_mb(struct idpf_adapter *adapter, u64 incval);
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
 void idpf_tstamp_task(struct work_struct *work);
 #else /* CONFIG_PTP_1588_CLOCK */
 static inline int idpf_ptp_init(struct idpf_adapter *adapter)
@@ -400,6 +423,9 @@ static inline int idpf_ptp_request_ts(struct idpf_tx_queue *tx_q,
 	return -EOPNOTSUPP;
 }
 
+static inline void idpf_ptp_tx_tstamp_timer_init(struct idpf_vport *vport) { }
+
 static inline void idpf_tstamp_task(struct work_struct *work) { }
+
 #endif /* CONFIG_PTP_1588_CLOCK */
 #endif /* _IDPF_PTP_H */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 8239c1e59620..4157dabaf508 100644
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
@@ -2981,6 +2989,14 @@ static int idpf_tx_tstamp(struct idpf_tx_queue *tx_q, struct sk_buff *skb,
 	if (likely(!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)))
 		return -1;
 
+	/* The latches are only collected while the Tx timestamping is enabled
+	 * on the netdev, so one handed out with it disabled would never be
+	 * freed.
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
index 427b15281ad0..6443ce34a0d9 100644
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
@@ -399,22 +400,24 @@ int idpf_ptp_adj_dev_clk_fine_mb(struct idpf_adapter *adapter, u64 incval)
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
@@ -452,7 +455,7 @@ int idpf_ptp_get_vport_tstamps_caps(struct idpf_vport *vport)
 		goto get_tstamp_caps_out;
 	}
 
-	tstamp_caps->access = true;
+	tstamp_caps->access = tstamp_access;
 	tstamp_caps->num_entries = num_latches;
 
 	INIT_LIST_HEAD(&tstamp_caps->latches_in_use);
@@ -463,9 +466,22 @@ int idpf_ptp_get_vport_tstamps_caps(struct idpf_vport *vport)
 
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
@@ -477,25 +493,59 @@ int idpf_ptp_get_vport_tstamps_caps(struct idpf_vport *vport)
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
@@ -503,6 +553,7 @@ int idpf_ptp_get_vport_tstamps_caps(struct idpf_vport *vport)
 		kfree(ptp_tx_tstamp);
 	}
 
+err_free_tstamp_caps:
 	kfree(tstamp_caps);
 get_tstamp_caps_out:
 	libie_ctlq_release_rx_buf(&xn_params.recv_mem);
@@ -515,8 +566,8 @@ int idpf_ptp_get_vport_tstamps_caps(struct idpf_vport *vport)
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
@@ -526,24 +577,23 @@ int idpf_ptp_get_vport_tstamps_caps(struct idpf_vport *vport)
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

