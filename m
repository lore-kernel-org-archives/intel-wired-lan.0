Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC70606D83D
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=h9SV5dQ8;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UKeVEtQJ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF39C60670;
	Tue,  3 Nov 2026 14:40:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q-hyb2yr7Q8O; Tue,  3 Nov 2026 14:40:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DF43B607BE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793716802;
	b=qElGDBtlC9axx8vYlDwyBxjMILEEpDnAjTa6Bkawv0abkPRgBzCqOljyhcA9WlngZFP1
	 PlmPj8fiGmSc/W9ZzySqkURD8YdQYPURiL+PW5RYmSxPpixINPfpQEoUCumW5wWLw9t15
	 PLYsqQ+wv1pkbMsosGBjbstxCKFUiOm7+7KqJewkrlk+okIaEoM+kYdZqSggNPKc99MWf
	 DQVtK1y1gCY/WuFy0+1xf+4p6V0puA2V4mBe1XVV8PBJMSXG6eqhcng90wvbv5C+mpbtG
	 gS/9bJQC7EBbZ0e5H3hNQLz9tqWfQocFY5o074yXgDxzLw1khQ20ZABQjUZ05ZlhSGA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793716802;
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
	bh=rUNOrLH2Zgu09+TutPekDgiCKK46z/pZxgmj/VX7P90=;
	b=B7R14pPhC+ae28lgYXbfwqzVGTOpxvE/WctZKxW3WuUi54Atzwu4ntS7Hr9alTOcN4tl
	 F1HFY79EQpPmRRbMN7Zy4sLcHEqGAemwDuEYeI96Ry28EzzINDq6CrGIHAGzrkryO+W8y
	 EqmDNERc03UYJC4mFP3MDU9e70h370OvTd9PdoeFjVZzqyPmmFLgJEcMucVYgrAQ/1jTM
	 p23ZPQY9QalUibxdUCVZziDJ0xeueXlmmSb9lfSUfvdf4wh15QsSU9Gj6cPJky/wHIDWd
	 grr21Kf7EDYN68HebPr+TyYvT53wpaBaSmXdR3MXHvRdf6zJLRECMKp35gnrkPA7zQg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793716801;
	bh=rUNOrLH2Zgu09+TutPekDgiCKK46z/pZxgmj/VX7P90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h9SV5dQ8GY68HkrGgdvQjnE9y8WcqjBaoPTtFLhueh210jzk2e5wreaEKSMsBvmnI
	 HUPOyCCB8np8PHTJ3R3WyrYCqQw9Ilhj2A1C1u8JI6M6GNPAxZ17V1RES55gNgqny2
	 7xkYjC514/splxwxMhF1pdNVdm2moCh/vRY50ZP3vTCPfDyLqYclE4xvg+tkMJcIhx
	 dixRNnwB47j5ixKn1WA7hp9R1kjPt9g75Wb2K258CdhQjU/nwdNium8wCaWtSlqCtw
	 ha8ATNVWHdp7TV4XuOhPRZARZu/ECA4tPnhLnhtwlPlrtVkqB5f+XgGjW+MDk6GVHo
	 VR+wxALipKdIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF43B607BE;
	Tue,  3 Nov 2026 14:40:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 53A3E11CA
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:39:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 458F2400E0
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:39:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e_Y5gC8cIEXJ for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 14:39:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 15EB140070
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793716796;
 b=ZftJVsdQLjlMXxWlXP6WNunZM8wtuX+9z/W5YT0eS1Tcm5RVRUBCwwcaZ8gAc2k2Z2T0
 XxrifusjFaSetKG+GGczY4RMvFhZkGNCAlDtWrzZAcQfMUdfjv0kCjcwDWKs4vjmjsVL/
 creJSHiu52xR2wWiGmH5QJ98eZ4HiVny7XYubK1rwOEEKUM/JKJlMRBVuobNnYPT8wvRV
 EMn0MGUN2QNgGhuuQNrZSwno99IK4D3U3XXaXlSMFl1NjEgzo1YBYvV6od+nx+ZHzsV4k
 WOKBTXut06GZPNfFdN2RBQjYmgH5MxWB48c0KS4SlgJ2L6JlYYPMA2SWKaWP+AG/6aA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793716796;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=rUNOrLH2Zgu09+TutPekDgiCKK46z/pZxgmj/VX7P90=;
 b=VAxdLI4qLtCwQjzioQy1KHpgfRjG9YvrMOSEML3esYu9tp3FTwPmmApFu7HedJCApqma
 Z0j8erxvQ4bEaR4Ol6q9ONdQyr7OYlPp8B958pbrPuSbQOnLxSgKO9sPeSi7ZxVOTDpD2
 xo4FzzB3T6uQT6zW769+5u8UeEj1dkHeZniTx8Gpnv1V1g7ZuOyOTuXUKv3y/DSIA48Gm
 lAiqhRGLAFuoik8FiB4XrM+wkT2q4gb/QrVSZr4+Byl1trQSjwrQ5hg/c/D5whoy4rX8b
 O8IRW+PE4KHxWcC6s6DIFqjYfmpBAJLfLMHMC0rD9iBcnVekyqgU0GcOBG5zEn7UBrw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=UKeVEtQJ; 
 arc=none smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=UKeVEtQJ
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 15EB140070
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793716796; x=1825252796;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CgxXHW8YgqFqqfNU+x2pkbZZZKZplk0UpiUXl3L5xUg=;
 b=UKeVEtQJT1L3nnw64YyI/wUhJSD1mYnkMyb1JrgoS3TcPK7v/hD9QYCb
 OW/SBFYm0FzepRvdQyQch7ZcJ/38ZAjb4fUsS9dtZMR2AjTsV7t/YsIRv
 6M880DAJ4Azwh7LG41NPLhDuIHcwYtYc7l2bi1sSzCbseNvSU9sXzWfwF
 yulnAC0EMXF5LMhYdX+6vBTZQVfxTD+ukiBVvoE34YpMu2vyHOrKfOYB7
 EOBraQZuB+Xdzjslhd2pNxrjyjk6Q7h6CLWpXhbzpoj2mhYsgc05y6Oy6
 ZAnEQfcOw2plzBmraXgcHhRIM3ec0er9mQZhIiP6p0QFksSfbkw12yJh0 g==;
X-CSE-ConnectionGUID: w689rl3eS2yrQqLfP8owdA==
X-CSE-MsgGUID: hJ/LA00fQ9iF4GGM7ok3+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2324036"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2324036"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 06:39:55 -0800
X-CSE-ConnectionGUID: ui/awQZ0TbGr0z+kHLRQ2Q==
X-CSE-MsgGUID: yKm6OiYrSnCPOSQ6K8N7Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="8289913"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa013.fm.intel.com with ESMTP; 03 Nov 2026 06:39:49 -0800
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 529A7312F0;
 Tue,  3 Nov 2026 14:39:46 +0000 (GMT)
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
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v4 06/15] ice: bump to 256qs for VF
Date: Tue,  3 Nov 2026 15:14:47 +0100
Message-ID: <20261103141646.303620-7-przemyslaw.kitszel@intel.com>
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adjust all bitmaps and arrays in ice to accept 256 VF queues.
Extend struct ice_vf::num_req_qs width to allow 256 queues.
Keep old/legacy size for virtchnl opcodes that were designed to accept
only up to 16 queues.

Raise also the limits for the default VF queue count and for
VIRTCHNL_OP_REQUEST_QUEUES to 256. New virtchnl opcodes, needed to
make use of more than 16 queues, are handled by subsequent commits
of this series, the work is split for easier review.

Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v3:
 * fix rollback in ice_vc_cfg_qs_msg() to disable queues by their IDs,
   not by qpair index, as config could be now split into many messages;
   unwind only the entries that got past validation (Sashiko)

v2:
 * change ice_lag allocations to kvzalloc(), as they have grown to
   66KB (Sashiko)
 * commit message: mention that the default and requested VF queue
   limits are raised already here, while more than 16 queues are
   enabled by subsequent commits

Sashiko suggestions I don't want to apply:
 S: there is an existing error handling issue in ice_init_lag()
 me: pre-existing and unrelated, will be fixed separately
---
 drivers/net/ethernet/intel/ice/ice_lag.h     |  2 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h  |  9 ++++---
 drivers/net/ethernet/intel/ice/ice_lag.c     |  6 ++---
 drivers/net/ethernet/intel/ice/ice_lib.c     |  2 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c   |  4 +--
 drivers/net/ethernet/intel/ice/ice_vf_lib.c  |  8 +++---
 drivers/net/ethernet/intel/ice/virt/queues.c | 28 +++++++++++---------
 7 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.h b/drivers/net/ethernet/intel/ice/ice_lag.h
index 4bfffecbdc97..39f6a6cc844d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.h
+++ b/drivers/net/ethernet/intel/ice/ice_lag.h
@@ -52,7 +52,7 @@ struct ice_lag {
 	u8 bond_lport_sec; /* lport values for secondary PF */
 
 	/* q_home keeps track of which interface the q is currently on */
-	u8 q_home[ICE_MAX_SRIOV_VFS][ICE_MAX_QS_PER_VF_VCV1];
+	u8 q_home[ICE_MAX_SRIOV_VFS][ICE_MAX_QS_PER_VF];
 
 	/* placeholder VSI for hanging VF queues from on secondary interface */
 	struct ice_vsi *sec_vf[ICE_MAX_SRIOV_VFS];
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index 4959ecee0c21..a9e95c85bc98 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -21,6 +21,7 @@
 /* VF resource constraints */
 /* for "old" virtchnl opcodes that accept up to 16 queues */
 #define ICE_MAX_QS_PER_VF_VCV1	16
+#define ICE_MAX_QS_PER_VF	256
 
 struct ice_pf;
 struct ice_vf;
@@ -162,8 +163,8 @@ struct ice_vf {
 	u8 dev_lan_addr[ETH_ALEN];
 	u8 hw_lan_addr[ETH_ALEN];
 	struct ice_time_mac legacy_last_added_umac;
-	DECLARE_BITMAP(txq_ena, ICE_MAX_QS_PER_VF_VCV1);
-	DECLARE_BITMAP(rxq_ena, ICE_MAX_QS_PER_VF_VCV1);
+	DECLARE_BITMAP(txq_ena, ICE_MAX_QS_PER_VF);
+	DECLARE_BITMAP(rxq_ena, ICE_MAX_QS_PER_VF);
 	struct ice_vlan port_vlan_info;	/* Port VLAN ID, QoS, and TPID */
 	struct virtchnl_vlan_caps vlan_v2_caps;
 	struct ice_mbx_vf_info mbx_info;
@@ -185,7 +186,7 @@ struct ice_vf {
 	DECLARE_BITMAP(vf_states, ICE_VF_STATES_NBITS);	/* VF runtime states */
 
 	unsigned long vf_caps;		/* VF's adv. capabilities */
-	u8 num_req_qs;			/* num of queue pairs requested by VF */
+	u16 num_req_qs;			/* num of queue pairs requested by VF */
 	u16 num_mac;
 	u16 num_mac_lldp;
 	u16 num_vf_qs;			/* num of queue configured per VF */
@@ -206,7 +207,7 @@ struct ice_vf {
 	u16 lldp_recipe_id;
 	u16 lldp_rule_id;
 
-	struct ice_vf_qs_bw qs_bw[ICE_MAX_QS_PER_VF_VCV1];
+	struct ice_vf_qs_bw qs_bw[ICE_MAX_QS_PER_VF];
 };
 
 /* Flags for controlling behavior of ice_reset_vf */
diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 08a17ded0ad5..e006311c18b6 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -2577,7 +2577,7 @@ int ice_init_lag(struct ice_pf *pf)
 	if (!ice_is_feature_supported(pf, ICE_F_SRIOV_LAG))
 		return 0;
 
-	pf->lag = kzalloc_obj(*lag);
+	pf->lag = kvzalloc_obj(*lag);
 	if (!pf->lag)
 		return -ENOMEM;
 	lag = pf->lag;
@@ -2651,7 +2651,7 @@ int ice_init_lag(struct ice_pf *pf)
 	ice_free_hw_res(&pf->hw, ICE_AQC_RES_TYPE_RECIPE, 1,
 			&lag->pf_recipe);
 lag_error:
-	kfree(lag);
+	kvfree(lag);
 	pf->lag = NULL;
 	return err;
 }
@@ -2680,7 +2680,7 @@ void ice_deinit_lag(struct ice_pf *pf)
 	ice_free_hw_res(&pf->hw, ICE_AQC_RES_TYPE_RECIPE, 1,
 			&pf->lag->lport_recipe);
 
-	kfree(lag);
+	kvfree(lag);
 
 	pf->lag = NULL;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index e18128bce959..f81b310a98c3 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1026,7 +1026,7 @@ static void ice_vsi_set_rss_params(struct ice_vsi *vsi)
 		 * For VSI_LUT, LUT size should be set to 64 bytes.
 		 */
 		vsi->rss_table_size = ICE_LUT_VSI_SIZE;
-		vsi->rss_size = ICE_MAX_QS_PER_VF_VCV1;
+		vsi->rss_size = ICE_MAX_QS_PER_VF;
 		vsi->rss_lut_type = ICE_LUT_VSI;
 		break;
 	case ICE_VSI_LB:
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index dcd6d48ea38d..d7c4a6540008 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -398,15 +398,15 @@ static int ice_set_per_vf_res(struct ice_pf *pf, u16 num_vfs)
 	}
 
 	num_txq = min_t(u16, num_msix_per_vf - ICE_NONQ_VECS_VF,
-			ICE_MAX_QS_PER_VF_VCV1);
+			ICE_MAX_QS_PER_VF);
 	avail_qs = ice_get_avail_txq_count(pf) / num_vfs;
 	if (!avail_qs)
 		num_txq = 0;
 	else if (num_txq > avail_qs)
 		num_txq = rounddown_pow_of_two(avail_qs);
 
 	num_rxq = min_t(u16, num_msix_per_vf - ICE_NONQ_VECS_VF,
-			ICE_MAX_QS_PER_VF_VCV1);
+			ICE_MAX_QS_PER_VF);
 	avail_qs = ice_get_avail_rxq_count(pf) / num_vfs;
 	if (!avail_qs)
 		num_rxq = 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index be87a83d2599..320b393ddaaf 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -528,8 +528,8 @@ static void ice_vf_rebuild_host_cfg(struct ice_vf *vf)
 static void ice_set_vf_state_qs_dis(struct ice_vf *vf)
 {
 	/* Clear Rx/Tx enabled queues flag */
-	bitmap_zero(vf->txq_ena, ICE_MAX_QS_PER_VF_VCV1);
-	bitmap_zero(vf->rxq_ena, ICE_MAX_QS_PER_VF_VCV1);
+	bitmap_zero(vf->txq_ena, ICE_MAX_QS_PER_VF);
+	bitmap_zero(vf->rxq_ena, ICE_MAX_QS_PER_VF);
 	clear_bit(ICE_VF_STATE_QS_ENA, vf->vf_states);
 }
 
@@ -1243,8 +1243,8 @@ bool ice_is_vf_trusted(struct ice_vf *vf)
  */
 bool ice_vf_has_no_qs_ena(struct ice_vf *vf)
 {
-	return bitmap_empty(vf->rxq_ena, ICE_MAX_QS_PER_VF_VCV1) &&
-	       bitmap_empty(vf->txq_ena, ICE_MAX_QS_PER_VF_VCV1);
+	return bitmap_empty(vf->rxq_ena, ICE_MAX_QS_PER_VF) &&
+	       bitmap_empty(vf->txq_ena, ICE_MAX_QS_PER_VF);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c b/drivers/net/ethernet/intel/ice/virt/queues.c
index 2667634e3c8c..7f2b459dbc83 100644
--- a/drivers/net/ethernet/intel/ice/virt/queues.c
+++ b/drivers/net/ethernet/intel/ice/virt/queues.c
@@ -681,7 +681,7 @@ int ice_vc_cfg_q_bw(struct ice_vf *vf, u8 *msg)
 		goto err;
 	}
 
-	if (qbw->num_queues > ICE_MAX_QS_PER_VF_VCV1 ||
+	if (qbw->num_queues > ICE_MAX_QS_PER_VF ||
 	    qbw->num_queues > min_t(u16, vsi->alloc_txq, vsi->alloc_rxq)) {
 		dev_err(ice_pf_to_dev(vf->pf), "VF-%d trying to configure more than allocated number of queues: %d\n",
 			vf->vf_id, min_t(u16, vsi->alloc_txq, vsi->alloc_rxq));
@@ -773,7 +773,7 @@ int ice_vc_cfg_q_quanta(struct ice_vf *vf, u8 *msg)
 		goto err;
 	}
 
-	if (end_qid > ICE_MAX_QS_PER_VF_VCV1 ||
+	if (end_qid > ICE_MAX_QS_PER_VF ||
 	    end_qid > min_t(u16, vsi->alloc_txq, vsi->alloc_rxq)) {
 		dev_err(ice_pf_to_dev(vf->pf), "VF-%d trying to configure more than allocated number of queues: %d\n",
 			vf->vf_id, min_t(u16, vsi->alloc_txq, vsi->alloc_rxq));
@@ -822,9 +822,9 @@ int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 	struct virtchnl_vsi_queue_config_info *qci =
 	    (struct virtchnl_vsi_queue_config_info *)msg;
 	struct virtchnl_queue_pair_info *qpi;
+	int i, q_idx, last_valid = -1;
 	struct ice_pf *pf = vf->pf;
 	struct ice_vsi *vsi;
-	int i = -1, q_idx;
 	bool ena_ts;
 	u8 act_prt;
 
@@ -841,7 +841,7 @@ int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 	if (!vsi)
 		goto error_param;
 
-	if (qci->num_queue_pairs > ICE_MAX_QS_PER_VF_VCV1 ||
+	if (qci->num_queue_pairs > ICE_MAX_QS_PER_VF ||
 	    qci->num_queue_pairs > min_t(u16, vsi->alloc_txq, vsi->alloc_rxq)) {
 		dev_err(ice_pf_to_dev(pf), "VF-%d requesting more than supported number of queues: %d\n",
 			vf->vf_id, min_t(u16, vsi->alloc_txq, vsi->alloc_rxq));
@@ -877,6 +877,7 @@ int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 		if (q_idx >= vsi->alloc_txq || q_idx >= vsi->alloc_rxq) {
 			goto error_param;
 		}
+		last_valid = i;
 
 		/* copy Tx queue info from VF into VSI */
 		if (qpi->txq.ring_len > 0) {
@@ -967,13 +968,14 @@ int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 				     VIRTCHNL_STATUS_SUCCESS, NULL, 0);
 error_param:
 	/* disable whatever we can */
-	for (; i >= 0; i--) {
-		if (ice_vsi_ctrl_one_rx_ring(vsi, false, i, true))
+	for (; last_valid >= 0; last_valid--) {
+		q_idx = qci->qpair[last_valid].rxq.queue_id;
+		if (ice_vsi_ctrl_one_rx_ring(vsi, false, q_idx, true))
 			dev_err(ice_pf_to_dev(pf), "VF-%d could not disable RX queue %d\n",
-				vf->vf_id, i);
-		if (ice_vf_vsi_dis_single_txq(vf, vsi, i))
+				vf->vf_id, q_idx);
+		if (ice_vf_vsi_dis_single_txq(vf, vsi, q_idx))
 			dev_err(ice_pf_to_dev(pf), "VF-%d could not disable TX queue %d\n",
-				vf->vf_id, i);
+				vf->vf_id, q_idx);
 	}
 
 	ice_lag_complete_vf_reset(pf->lag, act_prt);
@@ -1019,16 +1021,16 @@ int ice_vc_request_qs_msg(struct ice_vf *vf, u8 *msg)
 	if (!req_queues) {
 		dev_err(dev, "VF %d tried to request 0 queues. Ignoring.\n",
 			vf->vf_id);
-	} else if (req_queues > ICE_MAX_QS_PER_VF_VCV1) {
+	} else if (req_queues > ICE_MAX_QS_PER_VF) {
 		dev_err(dev, "VF %d tried to request more than %d queues.\n",
-			vf->vf_id, ICE_MAX_QS_PER_VF_VCV1);
-		vfres->num_queue_pairs = ICE_MAX_QS_PER_VF_VCV1;
+			vf->vf_id, ICE_MAX_QS_PER_VF);
+		vfres->num_queue_pairs = ICE_MAX_QS_PER_VF;
 	} else if (req_queues > cur_queues &&
 		   req_queues - cur_queues > tx_rx_queue_left) {
 		dev_warn(dev, "VF %d requested %u more queues, but only %u left.\n",
 			 vf->vf_id, req_queues - cur_queues, tx_rx_queue_left);
 		vfres->num_queue_pairs = min_t(u16, max_allowed_vf_queues,
-					       ICE_MAX_QS_PER_VF_VCV1);
+					       ICE_MAX_QS_PER_VF);
 	} else {
 		/* request is successful, then reset VF */
 		vf->num_req_qs = req_queues;
-- 
2.54.0

