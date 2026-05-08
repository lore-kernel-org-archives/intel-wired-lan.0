Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C4ACD3447
	for <intel-wired-lan@archiver.kernel.org>; Fri,  8 May 2026 12:59:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B87040F2F;
	Fri,  8 May 2026 12:59:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xBl9LKuo5Vwv; Fri,  8 May 2026 12:59:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ADFBC40FA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778245191;
	bh=ytdItwycy+SOrdJ5g69fcSGWr0cGLimgtIav0EtLbVQ=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=5GTzgsSR8ox8wWAjWZGljUFq9hk0ZDl7EgVb28Tn7HDzKvweUaoZ9O53D78Jq539q
	 WNEojgEM40QywFtYqcJOguLO0ivEsrA3EqE+xo24LViX16Cb5oJ8Vpjm37lDO0ewgu
	 8jOZo9axmfRNpIbjn48NL8YtnNjRfV0l74g2MmBKB/mlvaqX4lYomhxAzavreIRJ6Q
	 KjOL8jSKTpDpJeJbJLrCMmryYb4/xzp68pC/kQ5hPUhm/SEQ8B8kk3YqsdpqoDRjnE
	 aZ8/4Pbus62/7zHoP17Z9Sig2Lido8CFJYHpQYn6sA1zDKUbisjrW/KzieLytuXbZA
	 fHUbJ6Vv1idaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ADFBC40FA3;
	Fri,  8 May 2026 12:59:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A9BF358
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 12:59:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2CAAA40FBC
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 12:59:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pKSGR5dPGaM0 for <intel-wired-lan@lists.osuosl.org>;
 Fri,  8 May 2026 12:59:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1413140F74
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1413140F74
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1413140F74
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 12:59:48 +0000 (UTC)
X-CSE-ConnectionGUID: sGplEGn1TFy/jatA1GcRXQ==
X-CSE-MsgGUID: zObYMSykT/uboxxWZbcrZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79199889"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="79199889"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 05:59:49 -0700
X-CSE-ConnectionGUID: QdjmrR3XRauMd4Hx955Iaw==
X-CSE-MsgGUID: Q/BjC+khSZ6c8iMpu/HHsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="241730112"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa005.fm.intel.com with ESMTP; 08 May 2026 05:59:43 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id DBA4E2FC40;
 Fri,  8 May 2026 13:59:40 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org, Michal Schmidt <mschmidt@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 bruce.richardson@intel.com,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 padraig.j.connolly@intel.com, ananth.s@intel.com,
 timothy.miskell@intel.com, Jacob Keller <jacob.e.keller@intel.com>,
 Lukasz Czapnik <lukasz.czapnik@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Date: Fri,  8 May 2026 14:41:57 +0200
Message-Id: <20260508124208.11622-5-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260508124208.11622-1-przemyslaw.kitszel@intel.com>
References: <20260508124208.11622-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778245190; x=1809781190;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=748h7Xx8q52MKpfWxfAmxkATQ+6j/9UMHqUMByZ1RCg=;
 b=Di+Hb8uEAtO2L2d+7ldT56+AFi2jaJ2pg/9ukVVsRNjNZAUsJAJuV1pi
 /3mzGGWLrdUNtaPmB0NLQYdNquKdLuvuZ+1kVsdzHzHFvBMNinBukOopd
 KMeW+nk8kVkA219qef0hYg6wdUXChGUcJMPE+7eLP82R1d53ojSzCjbFC
 EnWxnUxAUfRv5QWpX1JaxzGHuO5KkBkBx+2iuUFM0AwpBogS8W0Y0unjD
 cNxzq7HTTP2sVjLlvmraJigFR4ZJjWzzXYy6Bny3RPx84LZ2QBpT/Tzra
 /wDyM5WKbciTHO2Na9VF813SO41W5ZJ/X4aUkcY6aDgi3T4llAzVnkadi
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Di+Hb8uE
Subject: [Intel-wired-lan] [PATCH iwl-next v1 04/15] ice: add VF queue
 ena/dis helper functions
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Add three new functions:
- ice_vf_vsi_dis_single_rxq()
- ice_vf_vsi_ena_single_rxq()
- ice_vf_vsi_ena_single_txq()
 (ice_vf_vsi_dis_single_txq() was introduced earlier.

Those functions wrap operations needed in the processes of enabling
and disabling single Tx/Rx VF queue, which are:
- check if the queue is not already in desired state
- perform the dis/ena operations
- bookkeeping of the queue's state.

Future commit will use them from another callsite.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/virt/queues.c | 111 ++++++++++++++-----
 1 file changed, 84 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c b/drivers/net/ethernet/intel/ice/virt/queues.c
index 6e4ec681fd07..28adc24197b8 100644
--- a/drivers/net/ethernet/intel/ice/virt/queues.c
+++ b/drivers/net/ethernet/intel/ice/virt/queues.c
@@ -224,6 +224,57 @@ void ice_vf_ena_rxq_interrupt(struct ice_vsi *vsi, u32 q_idx)
 	wr32(hw, QINT_RQCTL(pfq), reg | QINT_RQCTL_CAUSE_ENA_M);
 }
 
+/**
+ * ice_vf_vsi_ena_single_rxq - enable single Rx queue based on relative q_id
+ * @vf: VF to enable queue for
+ * @vsi: VSI for the VF
+ * @q_id: VSI relative (0-based) queue ID
+ *
+ * Enable the Rx queue passed in.
+ *
+ * Return: 0 on success or negative on error.
+ */
+static int ice_vf_vsi_ena_single_rxq(struct ice_vf *vf, struct ice_vsi *vsi,
+				     u16 q_id)
+{
+	int err;
+
+	if (test_bit(q_id, vf->rxq_ena))
+		return 0;
+
+	err = ice_vsi_ctrl_one_rx_ring(vsi, true, q_id, true);
+	if (err) {
+		dev_err(ice_pf_to_dev(vsi->back), "Failed to enable Rx ring %d on VSI %d\n",
+			q_id, vsi->vsi_num);
+		return err;
+	}
+
+	ice_vf_ena_rxq_interrupt(vsi, q_id);
+	set_bit(q_id, vf->rxq_ena);
+
+	return 0;
+}
+
+/**
+ * ice_vf_vsi_ena_single_txq - enable single Tx queue based on relative q_id
+ * @vf: VF to enable queue for
+ * @vsi: VSI for the VF
+ * @q_id: VSI relative (0-based) queue ID
+ *
+ * Enable the Tx queue's interrupt. Note that the Tx queue(s) should have
+ * already been configurated/enabled in VIRTCHNL_OP_CONFIG_QUEUES so this
+ * function only enables the interrupt associated with the q_id.
+ */
+static void ice_vf_vsi_ena_single_txq(struct ice_vf *vf, struct ice_vsi *vsi,
+				      u16 q_id)
+{
+	if (test_bit(q_id, vf->txq_ena))
+		return;
+
+	ice_vf_ena_txq_interrupt(vsi, q_id);
+	set_bit(q_id, vf->txq_ena);
+}
+
 /**
  * ice_vc_ena_qs_msg
  * @vf: pointer to the VF info
@@ -272,34 +323,20 @@ int ice_vc_ena_qs_msg(struct ice_vf *vf, u8 *msg)
 			goto error_param;
 		}
 
-		/* Skip queue if enabled */
-		if (test_bit(vf_q_id, vf->rxq_ena))
-			continue;
-
-		if (ice_vsi_ctrl_one_rx_ring(vsi, true, vf_q_id, true)) {
-			dev_err(ice_pf_to_dev(vsi->back), "Failed to enable Rx ring %d on VSI %d\n",
-				vf_q_id, vsi->vsi_num);
+		if (ice_vf_vsi_ena_single_rxq(vf, vsi, vf_q_id)) {
 			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 			goto error_param;
 		}
-
-		ice_vf_ena_rxq_interrupt(vsi, vf_q_id);
-		set_bit(vf_q_id, vf->rxq_ena);
 	}
 
 	q_map = vqs->tx_queues;
 	for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF) {
 		if (!ice_vc_isvalid_q_id(vsi, vf_q_id)) {
 			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 			goto error_param;
 		}
 
-		/* Skip queue if enabled */
-		if (test_bit(vf_q_id, vf->txq_ena))
-			continue;
-
-		ice_vf_ena_txq_interrupt(vsi, vf_q_id);
-		set_bit(vf_q_id, vf->txq_ena);
+		ice_vf_vsi_ena_single_txq(vf, vsi, vf_q_id);
 	}
 
 	/* Set flag to indicate that queues are enabled */
@@ -351,6 +388,36 @@ int ice_vf_vsi_dis_single_txq(struct ice_vf *vf, struct ice_vsi *vsi, u16 q_id)
 	return 0;
 }
 
+/*
+ * ice_vf_vsi_dis_single_rxq - disable a Rx queue for VF on relative queue ID
+ * @vf: VF to disable queue for
+ * @vsi: VSI for the VF
+ * @q_id: VSI relative (0-based) queue ID
+ *
+ * Attempt to disable the Rx queue passed in. If the Rx queue was successfully
+ * disabled then clear q_id bit in the enabled queues bitmap.
+ */
+static int ice_vf_vsi_dis_single_rxq(struct ice_vf *vf, struct ice_vsi *vsi,
+				     u16 q_id)
+{
+	int err;
+
+	if (!test_bit(q_id, vf->rxq_ena))
+		return 0;
+
+	err = ice_vsi_ctrl_one_rx_ring(vsi, false, q_id, true);
+	if (err) {
+		dev_err(ice_pf_to_dev(vsi->back), "Failed to stop Rx ring %d on VSI %d\n",
+			q_id, vsi->vsi_num);
+		return err;
+	}
+
+	/* Clear enabled queues flag */
+	clear_bit(q_id, vf->rxq_ena);
+
+	return 0;
+}
+
 /**
  * ice_vc_dis_qs_msg
  * @vf: pointer to the VF info
@@ -415,20 +482,10 @@ int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
 				goto error_param;
 			}
 
-			/* Skip queue if not enabled */
-			if (!test_bit(vf_q_id, vf->rxq_ena))
-				continue;
-
-			if (ice_vsi_ctrl_one_rx_ring(vsi, false, vf_q_id,
-						     true)) {
-				dev_err(ice_pf_to_dev(vsi->back), "Failed to stop Rx ring %d on VSI %d\n",
-					vf_q_id, vsi->vsi_num);
+			if (ice_vf_vsi_dis_single_rxq(vf, vsi, vf_q_id)) {
 				v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 				goto error_param;
 			}
-
-			/* Clear enabled queues flag */
-			clear_bit(vf_q_id, vf->rxq_ena);
 		}
 	}
 
-- 
2.39.3

