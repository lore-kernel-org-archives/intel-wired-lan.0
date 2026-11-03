Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FB5606A331
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=9e+KAXzM;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hZQ8sYyo
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 93CE660839;
	Tue,  3 Nov 2026 14:39:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vp3b1AR3ZtOe; Tue,  3 Nov 2026 14:39:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D74CF6083A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793716792;
	b=N59lzqhQ0pNbHFTpb/SQBoqB+lQbtwsaykmTtj2e3D+GAQv9JYXOP2pDMAHDdsJAye6Y
	 TFl5cgcdVkY4S3q1TYOJLhoYhNjZqIgp/51BWZQapcAXnMPNS2q+smbd8ADOgHlUqjErT
	 lXOpGH5CEKd9kL9r3WiWXpnLMLdUYWQrLSsk8qoeDjXPxs67H/IQo4DuFb/qpfmVhhDoh
	 50k7EL/Pk2ZiXui1KytRSh9Z9jCgT8+ju72WpINLr7qTSrnFrjkgrfDZstUF3ZBEHcBbP
	 hXmfEqVN4rE/rsZ+dLreJuEQgFm5tWCOnMzC5i1x68OfJNWSTljIOSbMDkZgKyuDvkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793716792;
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
	bh=mbiicu9wLOzaXOjyJuzoheYHvBlLyJoB5VWqTIheeoM=;
	b=ix37+VYslzMNx62So0ehEH9XnHqy0iJjWCHfftJCFRSGInXpCHcPsUW4y09F+PwMRwzd
	 9l+W69wfn32Az6meZ/1KhfagITHCfECvIIOMRm87iHq4A5LcTpdyPiFCARLabrbZoyb55
	 wVkzRFgJmOj5lH/AdZ0eR4xoZK8w4wLTnIN31X1/4pRyKFI44ElEMqqEBeFOozdeFsJ4W
	 a6sxseIkxaevsg5K/s/jdmFMt99GYAQVrTPqG2t0+lhshcfkzrB5RWqnLHT8MTynyCF/c
	 kh0BWjKmo3RF5BxoSHRDfy/swyCmbmXaUD8+mHnN3rzTYI7CJjElc5Rezr9r6pj98Gg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793716792;
	bh=mbiicu9wLOzaXOjyJuzoheYHvBlLyJoB5VWqTIheeoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9e+KAXzMaDLGBSfORFxRArDALcMvdF4cPidWT5wbdwvCQZsEscM60qqxdgUlYaV2/
	 yycDXhTTSFjxSTxBYhj/pYErtS7FAxdPOeIG5JrNimvPeQfM+q3HjnOb8YJkpDGSg5
	 oNMHO6kan+QzFFfWDjFWmU3TGmpwqiGR+Mf2qDg7EPwdkzueR1ADKuPe9wXUyNZD0I
	 fmQ0O+6imu7eGFUIYPfjdwHFvsB8Q2Q+0y1qSA/TTz9S2z97JQgjFAC3co/2pzxOET
	 B0G9Ib0qVIrQOJhDuwvL+kPyPM7cw/MiXkhX4BU0f7NHCj1qgvCSyQI72xw7lT+Lie
	 RIKskcxdyaTbg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D74CF6083A;
	Tue,  3 Nov 2026 14:39:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BDDC5356
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:39:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A405E810D6
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:39:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SXA75j8D3GEz for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 14:39:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D4AD280FB9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793716791;
 b=UsWdJCrZ/x3VfaSQU0HLB42jq70F673mn5eHZ9bLUNiA/flPYFz3sC2ddGe5S30eTo8U
 UD0vcr9/ZKAqnvtJ4DP2+kJ2dSD1r9M50VaHgOaDRXUrams+cByKkv/yFiGDBJtGuiTga
 x4LL8IG9Mj8MkdeEEYrTsyL7TjLEUOPabaEXE1bEWld3oRN8UoKfArpPma//rD/kgOCDM
 sLsVYaDegUfQSo/y6KV65NyNYSKBOnx8GUwYsW4hMTV8rRsINoTuHknQviiUFm3YO5J5u
 9hwTEk5IHLpWbw15IS1jUL63aVfVwcLVcxc+CT1IQUpnSNAiA3o8tn3bNzPBvDV/fjQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793716791;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=mbiicu9wLOzaXOjyJuzoheYHvBlLyJoB5VWqTIheeoM=;
 b=WybKTA76B9tGbKu4ZzWsqEBuX8GYkJikEbXWDjZACl8NDB4JDn/Di/zhYs9dSMb+zKTb
 XtggHDcmIdugJhy24evT8jzZFHTXTHOdzhIXkLhmTfZKrdilBhNb7/yEdCYsOJaFuTd73
 fYgDQnZbU5vqlglRiyC1UkpHMfUP2mcB8k+kXVDbznFobF62r7wb03YJ+9pX+OSfaHNxR
 YOipRvkdcoZitIYTy/KP+mkYmoH8mzUljFNaFjcQBvjJ949uqQCv3i7Yiq9vBqwCeMjE+
 jxDUxS8++bSRR/mIhHEM4Gq5zxqDUTn8o6KI6JXXeML1DqIoVsQxgHWPv9Em++5ppUg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=hZQ8sYyo; 
 arc=none smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=hZQ8sYyo
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D4AD280FB9
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793716791; x=1825252791;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Jp4Kfvt5JUngmuAAx6/ST9Y80lNlOVL+8kw0C8xpOhM=;
 b=hZQ8sYyoyZ8DNPzBcN+uzqLY4S2adf6Rzk+wF188/GxWBMSnNRguHE38
 rHE8HffaxdL1l7OSjIfnYC/guvvGFsehSSa32jZLRNkgkKlcYxq7YA6Ha
 kjnDJ9bj26FFNi4QGnri0iwuPyRD7J44Zw+NnPGEaLCLIyMDfZ0oRtHq2
 2UxvDd5xBapQWxbaneWpTONRhKC54PrqBVF59yNYoG6aUZ/EmbQC2lK6w
 +t7gEQSkzPXCtXG7V19H+swG/FD6DWE/slgH41fJRh7dcmlOLZZaykKFi
 wZh82tSaHAafvz/j8rjr8kNXPPltf4Kw2MtfxkZoisM+6W6CYzGh4ptb1 Q==;
X-CSE-ConnectionGUID: wpl8vo/5QIunqRYwyw5D3g==
X-CSE-MsgGUID: pas+iOpAR5OmqyWksjL16w==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2323992"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2323992"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 06:39:49 -0800
X-CSE-ConnectionGUID: 4tGYh+X+SWSO3am4H4uT4A==
X-CSE-MsgGUID: G1jw815zTNicLfe7gLhnrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="8289852"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa013.fm.intel.com with ESMTP; 03 Nov 2026 06:39:44 -0800
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 1036A312EE;
 Tue,  3 Nov 2026 14:39:41 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, Simon Horman <horms@kernel.org>,
 Michal Schmidt <mschmidt@redhat.com>,
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
Subject: [PATCH iwl-next v4 03/15] ice: add VF queue ena/dis helper functions
Date: Tue,  3 Nov 2026 15:14:44 +0100
Message-ID: <20261103141646.303620-4-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103141646.303620-1-przemyslaw.kitszel@intel.com>
References: <20261103141646.303620-1-przemyslaw.kitszel@intel.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
2.54.0

