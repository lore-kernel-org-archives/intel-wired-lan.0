Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952BE606A33B
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=VFSCZDn+;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L4OLBmLw
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7906E60852;
	Tue,  3 Nov 2026 14:40:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3E7uAUlRlVDS; Tue,  3 Nov 2026 14:40:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6EA8B607CC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793716807;
	b=pg/O6txXPla+ba91NYsZqQmj9aTCwmPBBIpfkFdNBy3YLlmggRuEyEf2xQZBqGUYWQbK
	 nvOwt1lS3O9aJTiHnA9PAhO0Ht2P3fEcQ5mUjoKWG2xSaJ1WYwD1rm4dgOHIAC7PZSROL
	 1gqRG8uOo5tQDa56dGVDQLkNIrAJGihkVWbdMQkfjayNscW4FZvvulIrRbjfGRa25lWpi
	 7h5zt52G2qR+dSJmVV1fGrOSbikDA85UmukIyc12k23rtm94vLxG4kunw+wMKlc/Z3lud
	 3BJF8NsrzzCdTY6jS1YMEbjCDyyrAc4iOVZNe1tqE5K1L8N97QbMDfDM36I5lc50e0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793716807;
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
	bh=gLkKF3jViOTmENU8uv1meav94XfHzNufzbFwLUCU+P0=;
	b=gXL+ZVgfDnwZ27NGCZ2mC+aXAEcY1dc2YODmxyorwnJB9Tn9J5reY/zJUC4+osOrejOC
	 J1uz23/ZLPEmpfG0UwhryfKa5+ENyJv1/IFTZ721HDXBd49BWXpjtejduTMoiqzlyNuQ8
	 IlSyHXuwJ8bP0nqL+mdPoicGWXP2S/ZXpDCuTsEhVliU4UzF7gtF4DFNoqKeTDTbPo2hE
	 o7E9AWcClxiVeeV5ljNqy1sFRshjwDW3vpRuItjUBQneA2PhQ7aEivETkoxFR+bknSUoQ
	 ARuWwTeN3P1wqTxDhTYj0ZCwxMAqVcOTtipGfISsFGY6I82TIRCWd77bCqihfVHCcEA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793716807;
	bh=gLkKF3jViOTmENU8uv1meav94XfHzNufzbFwLUCU+P0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VFSCZDn+qcjhrEeYQKhEdyPOa/wXBY11vD31MWkvV9NOyBoVsG7SJQTCprF70wYc1
	 vjw+dX5BS3PKwhNzkpTiNo3UVB8xZ14js0SyWGqctnSxWwlQgxNwo8+AS6OfJiZM0D
	 2jKV4GKSD341gcnhncPzcEq9VQpPPdAOha6gJStudfc9+h/nfQH9NiK3SrGn1d++hf
	 BwJDZLRnJC8q83Cqz7/qex6MRQI7TreM5JdLnct4fqqpciDqGnESg2UY+u5fyh04G1
	 bd3Mm75bavGuKkZGLj7NIqDRuc/CSzO8NaSuAi/2xIV1c1Ce2qiveyB8ZRCNm9/iur
	 5MJupvVqNkS3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6EA8B607CC;
	Tue,  3 Nov 2026 14:40:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CA1E235
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:40:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 12CA9406FA
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:40:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9dqp5JY10i5S for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 14:40:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CCE6440704
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793716805;
 b=BnZGLgeDctk8+ROZsP8qQ8vyk5CmXpaSmCnl6ysBw2Cy6P/xmolkLeAHFPfLiZJSvtyt
 vrpJMcd+iG7W46gctb/N/24pkhVHpXBRjdTSNGUVB63mVrEpunb2vXKcskzzgZF6EsCAL
 Sz7LOgow236we66V1SYB7dCSknwtzQGxyS3W3RJoc/kSqLoUrFm0flsvfLb0cZSokxfIM
 R3YDaFTJA6bA2kssTv4yeUXogOamTsNYv10EtZUCwLy9SJVFM1MFuGSXrw6b5lkrUWkVx
 mSmSPpbwiUsyaO9etzfGT/eZUsy49/xkZC88V4Z3SfI/3LnHDFtt+F3vDHoK+8hCJdw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793716805;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=gLkKF3jViOTmENU8uv1meav94XfHzNufzbFwLUCU+P0=;
 b=WAxEA/FVAKKpiV6b3sSNSP2/QwTJI8tDdqoDFB+1aR7kfZn1N9jgBxsmh6svqqxGSYlN
 28iJAh+OloWrWqIpSRcLlqEJoXccCOzzrDDf5WtBb05c6+k2gfmMk90t0XNGL8xagIx8p
 i4gLIzFqP9Dh6gxh+BGbdmpUm4cdIbVT7Bur75/YPoHhtP7OYcp2B2NcsZwYY7WYyqRDv
 pIOkIWBi1yyV4vQZc2s0HlMR4Rww6Xot+iR745p1gTXbPD0TylGxURv5AT6RLwDt6rO75
 1JtEWFg5LA0qAE9O1uDK1KiUgJcGgLnltyp01wpjaL3ScJLw8ZnoW5i1A/pv7SiwrEw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=L4OLBmLw; 
 arc=none smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=L4OLBmLw
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CCE6440704
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793716805; x=1825252805;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=L4SObc9X+u/OIAv6Iq8LSMBLSOHmTLL6FIiJMIq+bo4=;
 b=L4OLBmLwvTswAPz0qYGODmvu+Ct4sMg46Oss8o8V8zpEmxReSua89er4
 E5bN23W0a9AaEoL9AVdawnrEipemTyf92B5OuZh1AiwMCsNwDAB6FoGBq
 B0Um2exSgIqwLutbm7VBN568n94WwcXcjUvdID9veSiX9JHUZeYqii7J1
 kXvRIBnfHCDYB5ToXkv7v/KpSGNAp/5ONlyMJ1UuaXGdCqPIu7XB7TAMN
 YlRdSl38oWUIP3bnCPg22fuOz/6C6lM3W/5xKoxfHA6yfI6wrDa+pURhW
 ppFfs1/ttqAfEdcme5c7pNxGL8qxfej+yuScvIqBU6V/uxC77/FYkrJJ0 A==;
X-CSE-ConnectionGUID: NKlvF0hqRguzi4n++tpF2w==
X-CSE-MsgGUID: vGm3c1cNSj6AmyEfnB0dlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2324085"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2324085"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 06:40:04 -0800
X-CSE-ConnectionGUID: mLn7ZAL8QPaGeRyB8olQiw==
X-CSE-MsgGUID: iBonToRHSeuYf5qdNQO/Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="8289998"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa013.fm.intel.com with ESMTP; 03 Nov 2026 06:40:00 -0800
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 8CEDD312EA;
 Tue,  3 Nov 2026 14:39:57 +0000 (GMT)
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
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v4 11/15] ice: introduce handling of virtchnl LARGE
 VF opcodes
Date: Tue,  3 Nov 2026 15:14:52 +0100
Message-ID: <20261103141646.303620-12-przemyslaw.kitszel@intel.com>
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

With new virtchnl offload/capability VFs are able to make use of more than
16 queues. But the old opcodes were designed with a max of 16 queues,
so new ones were added (by iavf/virtchnl commit of this series).
Handle VIRTCHNL_OP_ENABLE_QUEUES_V2, VIRTCHNL_OP_DISABLE_QUEUES_V2 and
VIRTCHNL_OP_MAP_QUEUE_VECTOR here. VIRTCHNL_OP_GET_MAX_RSS_QREGION is
only allowlisted, its handler comes with bigger RSS LUT support later
in the series.

If a VF wishes to request >16 queues it should first make sure that the
PF supports the VIRTCHNL_VF_LARGE_NUM_QPAIRS capability.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Co-developed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com> # msglen val
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Co-developed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v4:
 * limit queue chunks to ICE_MAX_QS_PER_VF, the size of
   vf->{rx,tx}q_ena, as num_vf_qs could be set higher via
   sriov_vf_msix_count (Sashiko)
 * VIRTCHNL_OP_MAP_QUEUE_VECTOR: set ring->q_vector, num_ring_{rx,tx}
   and {rx,tx}.itr_idx, as VIRTCHNL_OP_CONFIG_IRQ_MAP does (Sashiko)
 * look up the VF VSI once per message, make ice_vc_ena_txq_chunk()
   void (Sashiko)

v3:
 * reject VIRTCHNL_OP_MAP_QUEUE_VECTOR entries with an out of range
   itr_idx (me)

v2:
 * fix error response in one case of ice_vc_map_q_vector_msg() (Alex)
 * use ice_get_vf_vsi() instead of plain array access (Sashiko)
 * return VIRTCHNL_STATUS_ERR_PARAM on error (Sashiko)
 * commit message: GET_MAX_RSS_QREGION is handled only later
---
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   1 +
 drivers/net/ethernet/intel/ice/virt/queues.h  |   3 +
 .../net/ethernet/intel/ice/virt/allowlist.c   |   8 +
 drivers/net/ethernet/intel/ice/virt/queues.c  | 339 ++++++++++++++++++
 4 files changed, 351 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index a9e95c85bc98..396dfb2b2d97 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -125,6 +125,7 @@ struct ice_vf_ops {
 	void (*clear_reset_trigger)(struct ice_vf *vf);
 	void (*irq_close)(struct ice_vf *vf);
 	void (*post_vsi_rebuild)(struct ice_vf *vf);
+	struct ice_q_vector *(*get_q_vector)(struct ice_vsi *vsi, u16 vec_id);
 };
 
 /* Virtchnl/SR-IOV config info */
diff --git a/drivers/net/ethernet/intel/ice/virt/queues.h b/drivers/net/ethernet/intel/ice/virt/queues.h
index c4a792cecea1..223f609dd4f3 100644
--- a/drivers/net/ethernet/intel/ice/virt/queues.h
+++ b/drivers/net/ethernet/intel/ice/virt/queues.h
@@ -16,5 +16,8 @@ int ice_vc_cfg_q_bw(struct ice_vf *vf, u8 *msg);
 int ice_vc_cfg_q_quanta(struct ice_vf *vf, u8 *msg);
 int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg);
 int ice_vc_request_qs_msg(struct ice_vf *vf, u8 *msg);
+int ice_vc_ena_qs_v2_msg(struct ice_vf *vf, u8 *msg, u16 msglen);
+int ice_vc_dis_qs_v2_msg(struct ice_vf *vf, u8 *msg, u16 msglen);
+int ice_vc_map_q_vector_msg(struct ice_vf *vf, u8 *msg, u16 msglen);
 
 #endif /* _ICE_VIRT_QUEUES_H_ */
diff --git a/drivers/net/ethernet/intel/ice/virt/allowlist.c b/drivers/net/ethernet/intel/ice/virt/allowlist.c
index a07efec19c45..ef769b843c6f 100644
--- a/drivers/net/ethernet/intel/ice/virt/allowlist.c
+++ b/drivers/net/ethernet/intel/ice/virt/allowlist.c
@@ -95,6 +95,13 @@ static const u32 tc_allowlist_opcodes[] = {
 	VIRTCHNL_OP_CONFIG_QUANTA,
 };
 
+static const u32 large_num_qpairs_allowlist_opcodes[] = {
+	VIRTCHNL_OP_GET_MAX_RSS_QREGION,
+	VIRTCHNL_OP_ENABLE_QUEUES_V2,
+	VIRTCHNL_OP_DISABLE_QUEUES_V2,
+	VIRTCHNL_OP_MAP_QUEUE_VECTOR,
+};
+
 struct allowlist_opcode_info {
 	const u32 *opcodes;
 	size_t size;
@@ -117,6 +124,7 @@ static const struct allowlist_opcode_info allowlist_opcodes[] = {
 	ALLOW_ITEM(VIRTCHNL_VF_OFFLOAD_VLAN_V2, vlan_v2_allowlist_opcodes),
 	ALLOW_ITEM(VIRTCHNL_VF_OFFLOAD_QOS, tc_allowlist_opcodes),
 	ALLOW_ITEM(VIRTCHNL_VF_CAP_PTP, ptp_allowlist_opcodes),
+	ALLOW_ITEM(VIRTCHNL_VF_LARGE_NUM_QPAIRS, large_num_qpairs_allowlist_opcodes),
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c b/drivers/net/ethernet/intel/ice/virt/queues.c
index 7f2b459dbc83..f87ccf5d370b 100644
--- a/drivers/net/ethernet/intel/ice/virt/queues.c
+++ b/drivers/net/ethernet/intel/ice/virt/queues.c
@@ -1046,3 +1046,342 @@ int ice_vc_request_qs_msg(struct ice_vf *vf, u8 *msg)
 				     v_ret, (u8 *)vfres, sizeof(*vfres));
 }
 
+static bool ice_vc_supported_queue_type(s32 queue_type)
+{
+	return queue_type == VIRTCHNL_QUEUE_TYPE_RX ||
+	       queue_type == VIRTCHNL_QUEUE_TYPE_TX;
+}
+
+/**
+ * ice_vc_validate_qs_v2_msg - validate all qs_msg parameters
+ * @vf: VF the message was received from
+ * @qs_msg: contents of the message from the VF
+ * @msglen: length of @qs_msg
+ *
+ * Used to validate both the VIRTCHNL_OP_ENABLE_QUEUES_V2 and
+ * VIRTCHNL_OP_DISABLE_QUEUES_V2 messages. This should always be called before
+ * attempting to enable and/or disable queues on behalf of a VF in response to
+ * the previously mentioned opcodes.
+ *
+ * Return: If all checks succeed, then return true. Otherwise return
+ *         false, indicating to the caller that the qs_msg is invalid.
+ */
+static bool ice_vc_validate_qs_v2_msg(struct ice_vf *vf,
+				      struct virtchnl_del_ena_dis_queues *qs_msg,
+				      u16 msglen)
+{
+	u32 max_qs = min_t(u32, vf->num_vf_qs, ICE_MAX_QS_PER_VF);
+
+	if (msglen < virtchnl_struct_size(qs_msg, chunks, 0))
+		return false;
+
+	if (msglen < virtchnl_struct_size(qs_msg, chunks, qs_msg->num_chunks))
+		return false;
+
+	if (!qs_msg->num_chunks)
+		return false;
+
+	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states))
+		return false;
+
+	if (!ice_vc_isvalid_vsi_id(vf, qs_msg->vport_id))
+		return false;
+
+	for (int i = 0; i < qs_msg->num_chunks; i++) {
+		struct virtchnl_queue_chunk *chunk = &qs_msg->chunks[i];
+		u32 end;
+
+		if (!ice_vc_supported_queue_type(chunk->type))
+			return false;
+
+		if (!chunk->num_queues)
+			return false;
+
+		end = chunk->start_queue_id + chunk->num_queues;
+		if (end > max_qs)
+			return false;
+	}
+
+	return true;
+}
+
+#define ice_for_each_q_in_chunk(chunk, q_id) \
+	for ((q_id) = (chunk)->start_queue_id; \
+	     (q_id) < (chunk)->start_queue_id + (chunk)->num_queues; \
+	     (q_id)++)
+
+static int
+ice_vc_ena_rxq_chunk(struct ice_vf *vf, struct ice_vsi *vsi,
+		     struct virtchnl_queue_chunk *chunk)
+{
+	u32 vf_qid;
+
+	ice_for_each_q_in_chunk(chunk, vf_qid) {
+		int err;
+
+		err = ice_vf_vsi_ena_single_rxq(vf, vsi, vf_qid);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static void
+ice_vc_ena_txq_chunk(struct ice_vf *vf, struct ice_vsi *vsi,
+		     struct virtchnl_queue_chunk *chunk)
+{
+	u32 vf_qid;
+
+	ice_for_each_q_in_chunk(chunk, vf_qid)
+		ice_vf_vsi_ena_single_txq(vf, vsi, vf_qid);
+}
+
+/**
+ * ice_vc_ena_qs_v2_msg - message handling for VIRTCHNL_OP_ENABLE_QUEUES_V2
+ * @vf: source of the request
+ * @msg: message to handle
+ * @msglen: length of the @msg
+ *
+ * Return: 0 on success or negative on error.
+ */
+int ice_vc_ena_qs_v2_msg(struct ice_vf *vf, u8 *msg, u16 msglen)
+{
+	struct virtchnl_del_ena_dis_queues *ena_qs_msg =
+			(struct virtchnl_del_ena_dis_queues *)msg;
+	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+	struct ice_vsi *vsi;
+
+	if (!ice_vc_validate_qs_v2_msg(vf, ena_qs_msg, msglen))
+		goto error_param;
+
+	vsi = ice_get_vf_vsi(vf);
+	if (!vsi)
+		goto error_param;
+
+	for (int i = 0; i < ena_qs_msg->num_chunks; i++) {
+		struct virtchnl_queue_chunk *chunk = &ena_qs_msg->chunks[i];
+
+		if (chunk->type == VIRTCHNL_QUEUE_TYPE_RX &&
+		    ice_vc_ena_rxq_chunk(vf, vsi, chunk))
+			goto error_param;
+		else if (chunk->type == VIRTCHNL_QUEUE_TYPE_TX)
+			ice_vc_ena_txq_chunk(vf, vsi, chunk);
+	}
+
+	v_ret = VIRTCHNL_STATUS_SUCCESS;
+	set_bit(ICE_VF_STATE_QS_ENA, vf->vf_states);
+
+error_param:
+	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_ENABLE_QUEUES_V2,
+				     v_ret, NULL, 0);
+}
+
+static int
+ice_vc_dis_rxq_chunk(struct ice_vf *vf, struct ice_vsi *vsi,
+		     struct virtchnl_queue_chunk *chunk)
+{
+	u32 vf_qid;
+
+	ice_for_each_q_in_chunk(chunk, vf_qid) {
+		int err;
+
+		err = ice_vf_vsi_dis_single_rxq(vf, vsi, vf_qid);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int
+ice_vc_dis_txq_chunk(struct ice_vf *vf, struct ice_vsi *vsi,
+		     struct virtchnl_queue_chunk *chunk)
+{
+	u32 vf_qid;
+
+	ice_for_each_q_in_chunk(chunk, vf_qid) {
+		int err;
+
+		err = ice_vf_vsi_dis_single_txq(vf, vsi, vf_qid);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+/**
+ * ice_vc_dis_qs_v2_msg - message handling for VIRTCHNL_OP_DISABLE_QUEUES_V2
+ * @vf: source of the request
+ * @msg: message to handle
+ * @msglen: length of @msg
+ *
+ * Return: 0 on success or negative on error.
+ */
+int ice_vc_dis_qs_v2_msg(struct ice_vf *vf, u8 *msg, u16 msglen)
+{
+	struct virtchnl_del_ena_dis_queues *dis_qs_msg =
+			(struct virtchnl_del_ena_dis_queues *)msg;
+	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+	struct ice_vsi *vsi;
+
+	if (!ice_vc_validate_qs_v2_msg(vf, dis_qs_msg, msglen))
+		goto error_param;
+
+	vsi = ice_get_vf_vsi(vf);
+	if (!vsi)
+		goto error_param;
+
+	for (int i = 0; i < dis_qs_msg->num_chunks; i++) {
+		struct virtchnl_queue_chunk *chunk = &dis_qs_msg->chunks[i];
+
+		if (chunk->type == VIRTCHNL_QUEUE_TYPE_RX &&
+		    ice_vc_dis_rxq_chunk(vf, vsi, chunk))
+			goto error_param;
+		else if (chunk->type == VIRTCHNL_QUEUE_TYPE_TX &&
+			 ice_vc_dis_txq_chunk(vf, vsi, chunk))
+			goto error_param;
+	}
+
+	v_ret = VIRTCHNL_STATUS_SUCCESS;
+	if (ice_vf_has_no_qs_ena(vf))
+		clear_bit(ICE_VF_STATE_QS_ENA, vf->vf_states);
+
+error_param:
+	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_DISABLE_QUEUES_V2,
+				     v_ret, NULL, 0);
+}
+
+/**
+ * ice_vc_validate_qv_maps - validate parameters sent in the qs_msg structure
+ * @vf: VF the message was received from
+ * @qv_maps: contents of the message from the VF
+ * @msglen: length of the @qv_maps
+ *
+ * Used to validate VIRTCHNL_OP_MAP_QUEUE_VECTOR messages. This should always
+ * be called before attempting map interrupts to queues. If all checks succeed,
+ * then return success indicating to the caller that the qv_maps are valid.
+ * Otherwise return false, indicating to the caller that the qv_maps are
+ * invalid.
+ *
+ * Return: true if parameters are valid, false otherwise.
+ */
+static bool ice_vc_validate_qv_maps(struct ice_vf *vf,
+				    struct virtchnl_queue_vector_maps *qv_maps,
+				    u16 msglen)
+{
+	struct ice_vsi *vsi;
+	int total_vectors;
+
+	vsi = ice_get_vf_vsi(vf);
+	if (!vsi)
+		return false;
+
+	if (msglen < virtchnl_struct_size(qv_maps, qv_maps, 0))
+		return false;
+
+	if (msglen < virtchnl_struct_size(qv_maps, qv_maps, qv_maps->num_qv_maps))
+		return false;
+
+	if (!qv_maps->num_qv_maps)
+		return false;
+
+	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states))
+		return false;
+
+	if (!ice_vc_isvalid_vsi_id(vf, qv_maps->vport_id))
+		return false;
+
+	total_vectors = vsi->num_q_vectors + ICE_NONQ_VECS_VF;
+
+	for (int i = 0; i < qv_maps->num_qv_maps; i++) {
+		if (!ice_vc_supported_queue_type(qv_maps->qv_maps[i].queue_type))
+			return false;
+
+		if (qv_maps->qv_maps[i].queue_id >= vf->num_vf_qs)
+			return false;
+
+		if (qv_maps->qv_maps[i].vector_id >= total_vectors ||
+		    qv_maps->qv_maps[i].vector_id < ICE_NONQ_VECS_VF)
+			return false;
+
+		if (qv_maps->qv_maps[i].itr_idx < ICE_IDX_ITR0 ||
+		    qv_maps->qv_maps[i].itr_idx > ICE_ITR_NONE)
+			return false;
+	}
+
+	return true;
+}
+
+/**
+ * ice_vc_map_q_vector_msg - message handling for VIRTCHNL_OP_MAP_QUEUE_VECTOR
+ * @vf: source of the request
+ * @msg: message to handle
+ * @msglen: length of @msg
+ *
+ * Return: 0 on success or negative on error
+ */
+int ice_vc_map_q_vector_msg(struct ice_vf *vf, u8 *msg, u16 msglen)
+{
+	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+	struct virtchnl_queue_vector_maps *qv_maps;
+	struct ice_vsi *vsi;
+
+	qv_maps = (struct virtchnl_queue_vector_maps *)msg;
+
+	if (!ice_vc_validate_qv_maps(vf, qv_maps, msglen))
+		goto error_param;
+
+	vsi = ice_get_vf_vsi(vf);
+	if (!vsi)
+		goto error_param;
+
+	for (int i = 0; i < qv_maps->num_qv_maps; i++) {
+		struct virtchnl_queue_vector *qv_map = &qv_maps->qv_maps[i];
+		struct ice_q_vector *q_vector;
+		u16 vector_id;
+		int vsi_q_id;
+
+		vsi_q_id = qv_map->queue_id;
+		vector_id = qv_map->vector_id;
+
+		q_vector = vf->vf_ops->get_q_vector(vsi, vector_id);
+		if (!q_vector)
+			goto error_param;
+
+		if (!ice_vc_isvalid_q_id(vsi, vsi_q_id))
+			goto error_param;
+
+		/* keep SW state in sync with HW, as ice_cfg_interrupt() does */
+		if (qv_map->queue_type == VIRTCHNL_QUEUE_TYPE_RX) {
+			struct ice_rx_ring *ring = vsi->rx_rings[vsi_q_id];
+
+			if (ring->q_vector && ring->q_vector->num_ring_rx)
+				ring->q_vector->num_ring_rx--;
+			ring->q_vector = q_vector;
+			q_vector->num_ring_rx++;
+			q_vector->rx.itr_idx = qv_map->itr_idx;
+			ice_cfg_rxq_interrupt(vsi, vsi_q_id,
+					      q_vector->vf_reg_idx,
+					      qv_map->itr_idx);
+		} else if (qv_map->queue_type == VIRTCHNL_QUEUE_TYPE_TX) {
+			struct ice_tx_ring *ring = vsi->tx_rings[vsi_q_id];
+
+			if (ring->q_vector && ring->q_vector->num_ring_tx)
+				ring->q_vector->num_ring_tx--;
+			ring->q_vector = q_vector;
+			q_vector->num_ring_tx++;
+			q_vector->tx.itr_idx = qv_map->itr_idx;
+			ice_cfg_txq_interrupt(vsi, vsi_q_id,
+					      q_vector->vf_reg_idx,
+					      qv_map->itr_idx);
+		}
+	}
+
+	v_ret = VIRTCHNL_STATUS_SUCCESS;
+
+error_param:
+	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_MAP_QUEUE_VECTOR,
+				     v_ret, NULL, 0);
+}
-- 
2.54.0

