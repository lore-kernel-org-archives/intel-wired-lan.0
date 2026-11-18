Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC53A606A33E
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=8Qk1oth0;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Zfiu2DXZ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CFD554050C;
	Wed, 18 Nov 2026 14:00:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zh6MN4InH8DH; Wed, 18 Nov 2026 14:00:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D78274069D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795010407;
	b=EVWp6pOUnTV5A/hORHPTSCF2kDrsGgDpas1ytdkzaitVokKGICfEaRIemkcfVGTIvqqg
	 f661Vhc/7T6wCGcWuhlrDKQiUXQHunrj+7KDg/K+fHiG8BZKiUgDWqD7IRvfjJ9uAKrI+
	 jPTHRyaj0ulyViWzDy8SISJXEbRWf+UeQIq8ThYV8d8nQSboaaa/QsNYETZdkOv6cYg9W
	 ZgjMQWfy1x54PjvHXR8+riCHXQM9G012Dy5xdip/H5CQh1+/mXYQLU59yTxoJHgq6in4V
	 2D4Mid6j5CodfVewRAflRMHDB3xG/cxLBQShxPcExuS6vs5jnYZemzl1VhVwyyvLn4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795010407;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CU52GiM+has28OEfkMVCa6R0J86Tp/VoRoY42HiIaN8=;
	b=f44QAPGnF0dhS07kJDmwZY+dBjZ3U9nok61BjTze4EoTySGmfJdBCZ1KzP6fOckcYrCi
	 K8s8gobbjMsGd16KsljF0Iz1sTLQ302S7dBjL31kqUV3lvdIfCbIaLUZJihfXl1m3CAGv
	 Bbbf+CWZDNbYh73DnOPr/fQi+MM5DXlusoHGimXVdHGdRixCW8sTPQk+rrT/PlU5zBx7L
	 GLWC69CFyy3PvzNi4iMGY418GT/z4jEht8pa7Atvt/s52AFq7D8VJrtiIUkYcxVyCuOdf
	 uGgcSAl4jTUxwF0AfpWKrzvW6WkLDLef2pEOU8LNzq0ZP3G8wcIHLCFCNQDUzRMECAg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795010407;
	bh=CU52GiM+has28OEfkMVCa6R0J86Tp/VoRoY42HiIaN8=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=8Qk1oth0fkjH50C6Q/x3vu1KXVzkyb0RF38RnzBmlo4dvMyalZgbGNZtTjcNJm5pq
	 V/FU3bdFGFxh2YxCzs0GKMW+AFr3jwwsVHDUarbCFbUpopENe5Wdz3APa3ay5P5C5P
	 3z5QVA0cjui7cHyYlolHjITOx+Lyzsr48ly/JwQp8b7qiHqNCLx2LuXy9ZVCMKZTLr
	 NHTI6Px38mDC/1YjRdUYKFGo0k9kEZLVEz/QLvHWmbhMUS3hfykqdQIKMkOPDDaItD
	 LOvANQM8fq66glKp1NpphTi6oHgw4gI5qKkNoWGObVRXvp9p5nGQjhRPrx8tqo8V54
	 fDuHp68IN0mYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D78274069D;
	Wed, 18 Nov 2026 14:00:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5712C70B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 14:00:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3D3BE40481
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 14:00:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P3Tcz2maMii5 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 14:00:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 34E71401E9
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=magnus.karlsson@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Zfiu2DXZ
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 34E71401E9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 14:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795010406; x=1826546406;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=MAzAzRoepft+GrK/4Dq6V7b8G8HgEweqKyrv9CZbXVo=;
 b=Zfiu2DXZ3I70Dr7IRCAsS81WGkCEGlOxCOA2ftRiuPqX9PEPVeaVyZfa
 XxgP5X1sdl2DrrrJ7Getb6Jy2RFIdV5d/n109MELaOMIZ8D41x7zpBKdE
 n8YYKs4T28xD3wiJ1OW/sF5TD55/HlVBCwS0ASHpiObRe4Vre8/4KAZs3
 Kkj+rUKd8lfm7wVz+WU6dDpaC/+2vlnYNHSffJ4pzisAC6u46xbUI3ITe
 uVX0dnasuYXZ2eHf0fD1jNaYSVjaV1ntl3XOtZ6Y6E7rwXMRRghX56U2x
 9z1UoBJMoPKDGiVKwIkotKUTIlljAH+wL4v/QZl8TtWVvvfb8Lp2xcpZE Q==;
X-CSE-ConnectionGUID: hGzS7ni3SbusiH1qwfEJdA==
X-CSE-MsgGUID: j1R5bWxUTGiSJymQMGE2Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3741275"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3741275"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 06:00:03 -0800
X-CSE-ConnectionGUID: q7lnwHm4RBi59OGRXemojg==
X-CSE-MsgGUID: IUxI8sNzRU+d8EvbdTfpcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10031756"
Received: from boxer.igk.intel.com ([10.102.20.173])
 by orviesa005.jf.intel.com with ESMTP; 18 Nov 2026 06:00:01 -0800
From: Magnus Karlsson <magnus.karlsson@intel.com>
To: magnus.karlsson@intel.com, magnus.karlsson@gmail.com,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 maciej.fijalkowski@intel.com, przemyslaw.kitszel@intel.com
Subject: [PATCH iwl-net] ice: use the queue pair's XDP ring in ice_qp_{dis,
 ena}()
Date: Wed, 18 Nov 2026 14:59:52 +0100
Message-Id: <20261118135952.1063685-1-magnus.karlsson@intel.com>
X-Mailer: git-send-email 2.38.1
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since commit 9ead7e74bfd6 ("ice: xsk: use Rx ring's XDP ring when picking
NAPI context"), an Rx ring uses the XDP ring that is first on its queue
vector's Tx ring list, both for XDP_TX and for AF_XDP zero-copy Tx. With
fewer queue vectors than CPUs, a vector carries several XDP rings, so Rx
ring N then does not use XDP ring N. ice_qp_dis(), ice_qp_ena() and the
ring cleaning and stats reset they call still operate on
vsi->xdp_rings[q_idx].

As a result, a zero-copy pool is attached to and detached from an XDP ring
that is never stopped, cleaned or reconfigured. At the same time, another
XDP ring is stopped and cleaned, possibly while it is in use from another
queue vector whose NAPI context keeps running.

With 4 channels on a machine with 8 CPUs, for example, queue vector 0
carries XDP rings 0 and 1, and Rx ring 0 uses XDP ring 1. Disabling queue
pair 1 then disables the NAPI context of vector 1, but stops and cleans
XDP ring 1, which vector 0 is still using.

Use rx_rings[q_idx]->xdp_ring, the ring that ice_tx_xsk_pool() assigns
the pool to, in all of these places. ice_vsi_cfg_single_txq() checks
its index against the number of LAN Tx queues, which an XDP ring index
can exceed, so configure that ring with ice_vsi_cfg_txq() directly.

Fixes: 9ead7e74bfd6 ("ice: xsk: use Rx ring's XDP ring when picking NAPI context")
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c | 42 +++++++++++++++++------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 1667f686ff75..aa0ad313a97c 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -1386,6 +1386,22 @@ ice_fill_txq_meta(const struct ice_vsi *vsi, struct ice_tx_ring *ring,
 	}
 }
 
+/**
+ * ice_qp_xdp_ring - Get the XDP ring used by a queue pair
+ * @vsi: VSI that contains rings of interest
+ * @q_idx: ring index in array
+ *
+ * A queue vector can carry more than one XDP ring, and Rx ring @q_idx then
+ * does not use XDP ring @q_idx. Return the XDP ring that XDP_TX and AF_XDP
+ * zero-copy use for this queue pair, as picked by ice_map_xdp_rings().
+ *
+ * Return: the XDP ring, or NULL if XDP rings are not configured.
+ */
+static struct ice_tx_ring *ice_qp_xdp_ring(struct ice_vsi *vsi, u16 q_idx)
+{
+	return vsi->xdp_rings ? vsi->rx_rings[q_idx]->xdp_ring : NULL;
+}
+
 /**
  * ice_qp_reset_stats - Resets all stats for rings of given index
  * @vsi: VSI that contains rings of interest
@@ -1393,6 +1409,7 @@ ice_fill_txq_meta(const struct ice_vsi *vsi, struct ice_tx_ring *ring,
  */
 static void ice_qp_reset_stats(struct ice_vsi *vsi, u16 q_idx)
 {
+	struct ice_tx_ring *xdp_ring = ice_qp_xdp_ring(vsi, q_idx);
 	struct ice_vsi_stats *vsi_stat;
 	struct ice_pf *pf;
 
@@ -1408,9 +1425,9 @@ static void ice_qp_reset_stats(struct ice_vsi *vsi, u16 q_idx)
 	       sizeof(vsi_stat->rx_ring_stats[q_idx]->stats));
 	memset(&vsi_stat->tx_ring_stats[q_idx]->stats, 0,
 	       sizeof(vsi_stat->tx_ring_stats[q_idx]->stats));
-	if (vsi->xdp_rings)
-		memset(&vsi->xdp_rings[q_idx]->ring_stats->stats, 0,
-		       sizeof(vsi->xdp_rings[q_idx]->ring_stats->stats));
+	if (xdp_ring)
+		memset(&xdp_ring->ring_stats->stats, 0,
+		       sizeof(xdp_ring->ring_stats->stats));
 }
 
 /**
@@ -1420,9 +1437,11 @@ static void ice_qp_reset_stats(struct ice_vsi *vsi, u16 q_idx)
  */
 static void ice_qp_clean_rings(struct ice_vsi *vsi, u16 q_idx)
 {
+	struct ice_tx_ring *xdp_ring = ice_qp_xdp_ring(vsi, q_idx);
+
 	ice_clean_tx_ring(vsi->tx_rings[q_idx]);
-	if (vsi->xdp_rings)
-		ice_clean_tx_ring(vsi->xdp_rings[q_idx]);
+	if (xdp_ring)
+		ice_clean_tx_ring(xdp_ring);
 	ice_clean_rx_ring(vsi->rx_rings[q_idx]);
 }
 
@@ -1435,9 +1454,9 @@ static void ice_qp_clean_rings(struct ice_vsi *vsi, u16 q_idx)
  */
 int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 {
+	struct ice_tx_ring *tx_ring, *xdp_ring;
 	struct ice_txq_meta txq_meta = { };
 	struct ice_q_vector *q_vector;
-	struct ice_tx_ring *tx_ring;
 	struct ice_rx_ring *rx_ring;
 	int fail = 0;
 	int err;
@@ -1447,6 +1466,7 @@ int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 
 	tx_ring = vsi->tx_rings[q_idx];
 	rx_ring = vsi->rx_rings[q_idx];
+	xdp_ring = ice_qp_xdp_ring(vsi, q_idx);
 	q_vector = rx_ring->q_vector;
 
 	synchronize_net();
@@ -1460,9 +1480,7 @@ int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 	err = ice_vsi_stop_tx_ring(vsi, ICE_NO_RESET, 0, tx_ring, &txq_meta);
 	if (!fail)
 		fail = err;
-	if (vsi->xdp_rings) {
-		struct ice_tx_ring *xdp_ring = vsi->xdp_rings[q_idx];
-
+	if (xdp_ring) {
 		memset(&txq_meta, 0, sizeof(txq_meta));
 		ice_fill_txq_meta(vsi, xdp_ring, &txq_meta);
 		err = ice_vsi_stop_tx_ring(vsi, ICE_NO_RESET, 0, xdp_ring,
@@ -1497,9 +1515,11 @@ int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 		fail = err;
 
 	if (ice_is_xdp_ena_vsi(vsi)) {
-		struct ice_tx_ring *xdp_ring = vsi->xdp_rings[q_idx];
+		DEFINE_RAW_FLEX(struct ice_aqc_add_tx_qgrp, qg_buf, txqs, 1);
+		struct ice_tx_ring *xdp_ring = ice_qp_xdp_ring(vsi, q_idx);
 
-		err = ice_vsi_cfg_single_txq(vsi, vsi->xdp_rings, q_idx);
+		qg_buf->num_txqs = 1;
+		err = ice_vsi_cfg_txq(vsi, xdp_ring, qg_buf);
 		if (!fail)
 			fail = err;
 		ice_set_ring_xdp(xdp_ring);
-- 
2.38.1

