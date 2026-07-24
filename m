Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3F8C531C9
	for <intel-wired-lan@archiver.kernel.org>; Fri, 24 Jul 2026 10:45:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ABA3360B07;
	Fri, 24 Jul 2026 10:45:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hYNKLh7ZpyXD; Fri, 24 Jul 2026 10:45:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ED08B607A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784889940;
	bh=BfWcbGLYGCaUmIqhTC9w9sO4m26WSxdm9a2VlpBYvhg=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PDX2CWzQG1SuPyWHc46LSfhLS2YNjPtzQQfWonAHt1aUPRLvOVMtlVevIo5d1wsoA
	 WaDkDh5yiy9rsQJcjeKPKZKyQD6I0+RxCKgbcARse8FYDPs7VK6mWUR4OBpDk5+GfD
	 pTga5mKhYQTqmyLObDyklrGsWAYssFiGf7OUGL49o8clmP7lmLK+iKAj5QDnfQHsKJ
	 gs92AkgxLQNjhwRZXGvl7dhnW1Eekw3mnWpUCKDlU8RBj9IdwzuUy8DRY6bKGYIvso
	 W/858juqzf8kCH543giHABqwhZfadWMRbm1FNjlxj4cYntTNt4W9OyuyzY7njpTrTn
	 N2fxoWiV6/vHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED08B607A8;
	Fri, 24 Jul 2026 10:45:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E64CB3B1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Jul 2026 10:45:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D832840392
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Jul 2026 10:45:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aTrd8gycx17h for <intel-wired-lan@lists.osuosl.org>;
 Fri, 24 Jul 2026 10:45:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=marcin.szycik@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C5721402E7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C5721402E7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C5721402E7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Jul 2026 10:45:36 +0000 (UTC)
X-CSE-ConnectionGUID: p/xJtf5vTwKp4MHcCk69xw==
X-CSE-MsgGUID: XH0LCPqzSMmltZgtvnGwHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96147910"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; d="scan'208";a="96147910"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2026 03:45:36 -0700
X-CSE-ConnectionGUID: boER7GEIQJ6dKdjn68JlBQ==
X-CSE-MsgGUID: dE37CkzqSjuUpuZZZUvUFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; d="scan'208";a="254737982"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa010.fm.intel.com with ESMTP; 24 Jul 2026 03:45:34 -0700
Received: from gond.igk.intel.com (gond.igk.intel.com [10.123.220.52])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 659C828763;
 Fri, 24 Jul 2026 11:45:33 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 Marcin Szycik <marcin.szycik@linux.intel.com>
Date: Fri, 24 Jul 2026 11:44:54 +0200
Message-ID: <20260724094454.16079-1-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784889937; x=1816425937;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=42qq2mzSR5oQOgXgBny4rWUjHkADJbz8UNxSJimHz8o=;
 b=i7bvCL7ZjdRZX1rZV0dN2UPGWnFb+j0N1Ad7OZcL3RMYoWwYzgVmCXNJ
 52y+I4SoMSRmxMS1wmdCDaOkbqm8oNiNFEYmfcY0Ew5zP2GgbfENeY6M3
 sIJmWARRqbzGbxxztWTvVUc+miB9tKbBsT9fwDgdlbrVERTHJFqu2kjpv
 Fy/Rx9YPoynIHOnWoVQycE1xa8kXzzoY/fhLk17VrO1pPuIafy//jfwa0
 J3mr8qJ1oBkhAfW/uOexuP7k8VlGWH039Zcahr8l0K/ec3CGinMKPknkP
 Q0ApyYkMHr5gZGCZwE9zYvMMwKSpzFoq5muNCUTftaZ4P2O3aFw5TTlLA
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=i7bvCL7Z
Subject: [Intel-wired-lan] [PATCH iwl-next] ice: detect duplicates in ACL
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

Prevent duplicate rules from being added to ACL.
Also skip checking ACL rules in ice_fdir_is_dup_fltr(), as it's only
used for fdir.

Fixes: fe9b91ade50e ("ice: create ACL entry")
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
Not sending to net because the fixed code is on dev-queue.
Tony, please squash this with the offending commit.
---
 drivers/net/ethernet/intel/ice/ice_acl_main.c | 87 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_fdir.c     |  3 +
 2 files changed, 90 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_acl_main.c b/drivers/net/ethernet/intel/ice/ice_acl_main.c
index 7c566077d55a..473b329b37bb 100644
--- a/drivers/net/ethernet/intel/ice/ice_acl_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_acl_main.c
@@ -283,6 +283,85 @@ void ice_acl_replay_fltrs(struct ice_pf *pf)
 	}
 }
 
+/**
+ * ice_acl_comp_rules - compare two ACL filters
+ * @a: first ACL filter
+ * @b: second ACL filter
+ *
+ * Return: true if a and b values and masks are identical, false otherwise
+ */
+static bool
+ice_acl_comp_rules(struct ice_ntuple_fltr *a, struct ice_ntuple_fltr *b)
+{
+	bool ipv4_equal;
+
+	if (a->flow_type != b->flow_type)
+		return false;
+
+	ipv4_equal = a->ip.v4.dst_ip == b->ip.v4.dst_ip &&
+		     a->ip.v4.src_ip == b->ip.v4.src_ip &&
+		     a->mask.v4.dst_ip == b->mask.v4.dst_ip &&
+		     a->mask.v4.src_ip == b->mask.v4.src_ip;
+
+	switch (a->flow_type) {
+	case ICE_FLTR_PTYPE_NONF_IPV4_TCP:
+	case ICE_FLTR_PTYPE_NONF_IPV4_UDP:
+	case ICE_FLTR_PTYPE_NONF_IPV4_SCTP:
+		return ipv4_equal &&
+		       a->ip.v4.dst_port == b->ip.v4.dst_port &&
+		       a->ip.v4.src_port == b->ip.v4.src_port &&
+		       a->mask.v4.dst_port == b->mask.v4.dst_port &&
+		       a->mask.v4.src_port == b->mask.v4.src_port;
+	case ICE_FLTR_PTYPE_NONF_IPV4_OTHER:
+		return ipv4_equal &&
+		       a->ip.v4.l4_header == b->ip.v4.l4_header &&
+		       a->ip.v4.proto == b->ip.v4.proto &&
+		       a->ip.v4.ip_ver == b->ip.v4.ip_ver &&
+		       a->ip.v4.tos == b->ip.v4.tos &&
+		       a->mask.v4.l4_header == b->mask.v4.l4_header &&
+		       a->mask.v4.proto == b->mask.v4.proto &&
+		       a->mask.v4.ip_ver == b->mask.v4.ip_ver &&
+		       a->mask.v4.tos == b->mask.v4.tos;
+	default:
+		return false;
+	}
+}
+
+/**
+ * ice_acl_is_dup_fltr - test if an ACL filter is already in the list
+ * @hw: hardware data structure
+ * @input: ACL filter to check
+ *
+ * Return: true if an identical filter (same flow type, values, and masks)
+ * already exists at a different location
+ */
+static bool
+ice_acl_is_dup_fltr(struct ice_hw *hw, struct ice_ntuple_fltr *input)
+{
+	struct ice_ntuple_fltr *rule;
+
+	list_for_each_entry(rule, &hw->fdir_list_head, fltr_node) {
+		if (!rule->acl_fltr)
+			continue;
+
+		if (!ice_acl_comp_rules(rule, input))
+			continue;
+
+		/* At this point rule and input have same match criteria.
+		 * Different location is a duplicate.
+		 * Same location with a different queue is an update (not a
+		 * duplicate).
+		 */
+		if (rule->fltr_id == input->fltr_id &&
+		    rule->q_index != input->q_index)
+			continue;
+
+		return true;
+	}
+
+	return false;
+}
+
 /**
  * ice_acl_add_rule_ethtool - add an ACL rule
  * @vsi: pointer to target VSI
@@ -322,6 +401,14 @@ int ice_acl_add_rule_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 	if (err)
 		goto free_input;
 
+	mutex_lock(&hw->fdir_fltr_lock);
+	if (ice_acl_is_dup_fltr(hw, input)) {
+		mutex_unlock(&hw->fdir_fltr_lock);
+		err = -EINVAL;
+		goto free_input;
+	}
+	mutex_unlock(&hw->fdir_fltr_lock);
+
 	memset(&acts, 0, sizeof(acts));
 	if (fsp->ring_cookie == RX_CLS_FLOW_DISC)
 		ice_acl_set_act_drop(&acts[0]);
diff --git a/drivers/net/ethernet/intel/ice/ice_fdir.c b/drivers/net/ethernet/intel/ice/ice_fdir.c
index 1bc91cb41769..1d79138683b0 100644
--- a/drivers/net/ethernet/intel/ice/ice_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_fdir.c
@@ -1261,6 +1261,9 @@ bool ice_fdir_is_dup_fltr(struct ice_hw *hw, struct ice_ntuple_fltr *input)
 	bool ret = false;
 
 	list_for_each_entry(rule, &hw->fdir_list_head, fltr_node) {
+		if (rule->acl_fltr)
+			continue;
+
 		if (rule->flow_type != input->flow_type)
 			continue;
 
-- 
2.49.0

