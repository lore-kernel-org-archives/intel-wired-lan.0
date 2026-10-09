Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C3DDCA9EBB
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 12:14:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 61DE94092B;
	Fri,  9 Oct 2026 12:14:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zCmv4rvWNbcI; Fri,  9 Oct 2026 12:14:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8DAD74093C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791548097;
	b=s9z+n1p7Iz252h5rDHNGeXp8jsIt5JBGRgLyfoy8uRDzyv1n0Y481u6vhWlah+jW+jDX
	 jvLgec/a6KTWDCxTIZkeqeus1U74R4+S/gqScldqP/iM/EzevGFgFb+tfh48Au97GjOCw
	 EI0C5gmsmWNEg5HyXTskfXuI4qlPFLxbVPyn3KXYto8o8GqdOgEsuONCVrRNmdSwE02L1
	 NcklhNSCBdBDSpTbB94gIXh2B4CmhnvDoq3cOMibO5CP/Bz5klvSftn+BbVS1aGQm6g4h
	 2eVUtuMsMl9X9Jm/3F0C7+E+WF8R5aCDV/tfvaa+OEEHpDqIWnnF9jIg4iUWyRUzGWA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791548097;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5zVt7rrB1uviniXKKSkVJ3DEzuOLvTJKrHa/b3iGhbs=;
	b=hp4SADkdLCFkuq9DGQiFUgRAU+SEKu1sGCx3nmMgQVt8ivGcvfwLOKHI9cUA4U+rKRVz
	 dqrrNoxwwf+03VYPRu8CozbdAiE73h+4KFRh0igMLYPdSoWE3ped6kjuNPCg4Hd8ueL6U
	 XDLxA5UfrGw+aHmjhuYfx5ncPr+YwfYouadN96BpvUHdjYAZXU5hvh74FGQFrcKCmRPzc
	 15CTCoHEIZjuvxZu6BO1G7/IiIOB62psHWnVCT65QpoPsztICs8NnS96fD0SQ5u4VSewy
	 M2oNKEz8nEB5FOqpD0fXZ91OKjwa0ZQnGf2filfe1jU1xGUTGp6TeZGF4DSfUUl4FiA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gIaKYdse;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791548097;
	bh=5zVt7rrB1uviniXKKSkVJ3DEzuOLvTJKrHa/b3iGhbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x6pduvFzXxUuWudbCvWoWm+UoN4oClHMMupNuJkcr+V4zeCNk34VwhT3WwUSnDcOL
	 yK+O84Sir/RQF96Md6Xywacw0M8F+DwIMzGEasNlh46Fh70oRUxJSj/LbEoCqdNmwU
	 jqVLrNwoLrT3RCqsoxmWKQc5S+x79+xsmU+y4SyGrwStCvKQ/aSan2+rOqFBln5H3O
	 5LCjcfNLSoqTV+YP860OFqSKcgaplgNMcbuOLvwQTRxsp8N1KKko7n/0esAJuVSTtY
	 sGu+9WvzBQcw8vvZKX5H3XO9TQRN5suOA6LMI/mxLvtdUTt8X4lo/DkUDc2swsJO6K
	 4K1K6/oFCwS+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8DAD74093C;
	Fri,  9 Oct 2026 12:14:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4106B317
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:14:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1E7F44091E
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:14:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gr2TAk4V4ht3 for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 12:14:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 20F9E40920
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791548094;
 b=BpAtH07KaKJjeJKXtZQFyo/6dAMpsvqAx191H99m7rSPx46EMKBlYgLBJmJPqKnZrHhz
 sZOr4jEM5rjYvNsPEaB52mSMFkD7/pfwYgqUUA7+G6/7m6sK6SreVTaotrSSteyShpVyZ
 jC+JzfQRSH4cGOWYuLHgboFdcwF3VQ1AdqHV1neV5qiXaKE8mzEOWLQrZQl3WbznTC7ly
 BUrfPMzjGevU79bqCANd8Q1unb3R9OoOPaBQqG/3gKF/gJldieH6K5woR6t7gJyMUw+Jl
 HMVJqFeuP5AWWijeoENhQp2N9JRj5eD0/Ih8q3kse3ypxHRaGJQtLjBTiTtYuSIFuBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791548094;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=5zVt7rrB1uviniXKKSkVJ3DEzuOLvTJKrHa/b3iGhbs=;
 b=aAy9FhTqkV205YraOJ+QxVy2Gz1h7L2QbVcR5zXiioE1BzJo/xY71ITdCTumcdPBz5Pm
 pyAZN89QU+z6fd0wetjnO+OIi2wiO940MeXtHetXatcMrMzDH608kFu+8Yj7GLyc0LoM5
 aWemcK9SaagkS8xDuaqr2nUpxZvbUNfHoFKQ+Qw9BoatFV8DEuojE2GHYu1VZNm9upZCK
 mM0YS4fzz1Afqkuo6OvmFg1E9s0gbsii5xA8q2bZvD3KT8w3/CXgQJhbUUKjDhNGEGbwn
 3aJ4IsY5vSP1zCb7qTUdtSxhHjsR8S06/W7qEJXj4XyqrNCps/HdVm9lzafGTIS2FrQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=gIaKYdse; 
 arc=none smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=gIaKYdse
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 20F9E40920
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791548094; x=1823084094;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rY0QkeYRoOMZmdDikz46iNQ7y9zutWnesKXcXX6WIeA=;
 b=gIaKYdse0Bc1r7hL6clHTHasNUksY8AsoURC6YwTfMKutfEMMuQQajwE
 zkLOrFY7+6S1Acw7t+xYVrSck6S649p0F/KbZz8jZkxJB1DMk+csJAizJ
 +mD287b+2twnKcljerfIy6LbhqmPRnJP2nCpc5f1vGVR1Mlnbh345EBVp
 QlDCx5BOIwW9T9J4iS1rr+qJMMI3eCC+u3PH9TUXX5Nb0lNppidhfsHsy
 WtJlbwDO0n6P4qe7ZqUG6DBl9CIaPByTXnHEJ/n/3Tu6Gcm4nho0Y9HQ9
 8+E+EOYpnkViKrReKSJJ2wyi8UUJcIkLN1RoWYZR7+kzXSOJyIKvPQg4S g==;
X-CSE-ConnectionGUID: UroZwX8FT+O9djQhSDZCgw==
X-CSE-MsgGUID: fEuGv1x+RlWzC5fslFxm9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="251121"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="251121"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 05:14:53 -0700
X-CSE-ConnectionGUID: H08yDFpHQa+86x4f97v+5g==
X-CSE-MsgGUID: ThWdLRPoQUaax9oLgX6+GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="420400"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa002.fm.intel.com with ESMTP; 09 Oct 2026 05:14:48 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.245.238])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 7E6E72FC43;
 Fri,  9 Oct 2026 13:14:44 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Michal Schmidt <mschmidt@redhat.com>, intel-wired-lan@lists.osuosl.org,
 edumazet@kernel.org, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, Jonathan Corbet <corbet@lwn.net>,
 skhan@linuxfoundation.org, rdunlap@infradead.org, andrew+netdev@lunn.ch,
 saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org, mbloch@nvidia.com,
 jacob.e.keller@intel.com, jedrzej.jagielski@intel.com, anzaki@gmail.com,
 brett.creeley@amd.com, jtornosm@redhat.com, ohartoov@nvidia.com,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [PATCH net-next v2 03/14] ice: add VF queue ena/dis helper functions
Date: Fri,  9 Oct 2026 14:04:14 +0200
Message-ID: <20261009121433.30347-4-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
References: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Brett Creeley <brett.creeley@intel.com>

Add three new functions:
- ice_vf_vsi_dis_single_rxq()
- ice_vf_vsi_ena_single_rxq()
- ice_vf_vsi_ena_single_txq()
 (ice_vf_vsi_dis_single_txq() was introduced earlier).

Those functions wrap operations needed in the processes of enabling
and disabling single Tx/Rx VF queue, which are:
- check if the queue is not already in desired state
- perform the dis/ena operations
- bookkeeping of the queue's state.

Future commit will use them from another callsite.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v2:
 * convert one comment to kdoc (Alex)
 * fix typos (Sashiko)
 * rebase: move ice_vf_dis_rxq_interrupt(), added to ice_vc_dis_qs_msg()
   by commit fb096882095e ("ice: fix VF interrupts cleanup"), into
   ice_vf_vsi_dis_single_rxq()
---
 drivers/net/ethernet/intel/ice/virt/queues.c | 117 ++++++++++++++-----
 1 file changed, 89 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c b/drivers/net/ethernet/intel/ice/virt/queues.c
index ac7f98479b13..a22780575086 100644
--- a/drivers/net/ethernet/intel/ice/virt/queues.c
+++ b/drivers/net/ethernet/intel/ice/virt/queues.c
@@ -242,6 +242,57 @@ static void ice_vf_dis_rxq_interrupt(struct ice_vsi *vsi, u32 q_idx)
 	ice_flush(hw);
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
+ * already been configured/enabled in VIRTCHNL_OP_CONFIG_VSI_QUEUES so this
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
@@ -290,34 +341,20 @@ int ice_vc_ena_qs_msg(struct ice_vf *vf, u8 *msg)
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
@@ -369,6 +406,41 @@ int ice_vf_vsi_dis_single_txq(struct ice_vf *vf, struct ice_vsi *vsi, u16 q_id)
 	return 0;
 }
 
+/**
+ * ice_vf_vsi_dis_single_rxq - disable a Rx queue for VF on relative queue ID
+ * @vf: VF to disable queue for
+ * @vsi: VSI for the VF
+ * @q_id: VSI relative (0-based) queue ID
+ *
+ * Attempt to disable the Rx queue passed in. If the Rx queue was successfully
+ * disabled then clear q_id bit in the enabled queues bitmap.
+ *
+ * Return: 0 when queue was already disabled or disabling succeeded, otherwise
+ *         negative error code.
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
+	ice_vf_dis_rxq_interrupt(vsi, q_id);
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
@@ -433,21 +505,10 @@ int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
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
-			ice_vf_dis_rxq_interrupt(vsi, vf_q_id);
-			/* Clear enabled queues flag */
-			clear_bit(vf_q_id, vf->rxq_ena);
 		}
 	}
 
-- 
2.51.1

