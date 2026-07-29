Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1005DC54F51
	for <intel-wired-lan@archiver.kernel.org>; Wed, 29 Jul 2026 14:06:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F61E8121A;
	Wed, 29 Jul 2026 14:06:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cn9jo0UtPtne; Wed, 29 Jul 2026 14:06:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B133E811B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785333980;
	bh=6H7GJEs/cZstsDO5BfQ9ipynrk5UXDT/Vwf4/cBlAwQ=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Rrq7YL1N7iB7mCfnFTi3AEhV0OHglOUlRE64vyhjBlBy8roRXrTZwG+l/m2mVgo8R
	 RvteBAWQItJs7bZ2AvhAGLvmz5x9dz6MhZQx13T2I/C/AFt3VOowwj1D1sfX87ocHA
	 SbCgBZjyUKSGkhV1jyRDl/kJw1sIJLEsSu3WxNSc4mE8vz1AaYH/2V5/PF21hUX0IT
	 leiBGwUJURw+M6447O3l1/QCKf1msbV2lM8B4COzULiq2dISDJoy7xsRzF1+bdqIdF
	 jfVcLjvLZOn81ubS+VkIjLmk0AsfPDZzdcOxC4MumTeV97Z553dAQ/wFvE3WkdsIwy
	 e2PSI8NxlT0uQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B133E811B6;
	Wed, 29 Jul 2026 14:06:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D50C2E5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jul 2026 14:06:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6ABCB40267
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jul 2026 14:06:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IlMSNAMSIksg for <intel-wired-lan@lists.osuosl.org>;
 Wed, 29 Jul 2026 14:06:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=marcin.szycik@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4D7D540074
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4D7D540074
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4D7D540074
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jul 2026 14:06:17 +0000 (UTC)
X-CSE-ConnectionGUID: NyVftkV1RX+ce1wYPwvbKw==
X-CSE-MsgGUID: viAU+Pf6Ssmsc8jw78Ie8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="89617556"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="89617556"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 07:06:17 -0700
X-CSE-ConnectionGUID: 7G1aELTOTzOMXyEwHqnIdQ==
X-CSE-MsgGUID: t8LS+BrKRO2Z+ZmwEMgATg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="260072634"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orviesa007.jf.intel.com with ESMTP; 29 Jul 2026 07:06:16 -0700
Received: from gond.igk.intel.com (gond.igk.intel.com [10.123.220.52])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id B115D2FC47;
 Wed, 29 Jul 2026 15:06:14 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com,
 Marcin Szycik <marcin.szycik@linux.intel.com>,
 Alexander Nowlin <alexander.nowlin@intel.com>
Date: Wed, 29 Jul 2026 15:05:10 +0200
Message-ID: <20260729130510.220222-1-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785333978; x=1816869978;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1TeedpNf4se513fr5NdVyRJ/Tisrwdz3DUQxuoWnRKc=;
 b=HOJ6fti4wCNjTkNJhC2f6cE7sq6Vqa0Puan1lN2EN+6pyYaM9tKE38wz
 ARoWMqJZH8yNUOdecCK0bBd7AmsFAowI3+8rRkCHn1ZgzELCFWy50/7Q1
 Pq6rVpFu3qPG7Nv3gnCqpCYV/gSDx1E1UTZib6bv1vZRrONslFpX/ibBS
 WLHCL9jTYUbBKccQrZnCN3+VVI1GBtckqdsfx2gFhMDA2rkPIRDU57dsw
 KgBSj0HjuAvoasXNvJ2ki1gYb/xQ2kwrGcog0k+5eTmkDOoud1gNGCywD
 dvMBIn4j1xVZe4jTFUF2sRovjG/0+AtkV/4P9S9hOlBHcmnk0dfpvrcxb
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=HOJ6fti4
Subject: [Intel-wired-lan] [PATCH iwl-next v2] ice: detect duplicates in ACL
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

ntuple filters without masks (fdir) disallow duplicate entries. Extend
this behaviour to rules with masks (ACL).
Also skip checking ACL rules in ice_fdir_is_dup_fltr(), as it's only
used for fdir.

Keep the naming convention consistent with ice_fdir_is_dup_fltr() and
ice_fdir_comp_rules(). ice_fdir_is_dup_fltr() cannot be reused directly,
as it ignores masks.

Before fix: duplicate rules with masks are allowed to be created and the
duplicate rule cannot be removed:
  sudo ethtool -N eth0 flow-type udp4 src-port 9000 m 0xff00 action 18
    Added rule with ID 31231
  sudo ethtool -N eth0 flow-type udp4 src-port 9000 m 0xff00 action 18
    Added rule with ID 31230
  sudo ethtool -N eth0 delete 31230
  sudo ethtool -N eth0 delete 31231
    rmgr: Cannot delete RX class rule: Invalid argument
    Cannot delete classification rule

After fix: duplicate rule is correctly detected:
  sudo ethtool -N eth0 flow-type udp4 src-port 9000 m 0xff00 action 18
    Added rule with ID 31231
  sudo ethtool -N eth0 flow-type udp4 src-port 9000 m 0xff00 action 18
    rmgr: Cannot insert RX class rule: Invalid argument
    Cannot insert classification rule

Fixes: 3272c00a1247 ("ice: create ACL entry")
Reported-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
v2:
* Tweak ice_acl_is_dup_fltr() function doc and comments to accurately
  reflect what is actually happening in the function
* Add repro steps and expected behaviour to commit msg
* ice_acl_comp_rules(): rename ipv4_equal -> base_equal in expectation
  of future changes that might introduce more fields
---
Not sending to net because the fixed code is on dev-queue.
Tony, please squash this with the offending commit.
---
 drivers/net/ethernet/intel/ice/ice_acl_main.c | 87 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_fdir.c     |  3 +
 2 files changed, 90 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_acl_main.c b/drivers/net/ethernet/intel/ice/ice_acl_main.c
index 7c566077d55a..d13e8bc1b701 100644
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
+	bool base_equal;
+
+	if (a->flow_type != b->flow_type)
+		return false;
+
+	base_equal = a->ip.v4.dst_ip == b->ip.v4.dst_ip &&
+		     a->ip.v4.src_ip == b->ip.v4.src_ip &&
+		     a->mask.v4.dst_ip == b->mask.v4.dst_ip &&
+		     a->mask.v4.src_ip == b->mask.v4.src_ip;
+
+	switch (a->flow_type) {
+	case ICE_FLTR_PTYPE_NONF_IPV4_TCP:
+	case ICE_FLTR_PTYPE_NONF_IPV4_UDP:
+	case ICE_FLTR_PTYPE_NONF_IPV4_SCTP:
+		return base_equal &&
+		       a->ip.v4.dst_port == b->ip.v4.dst_port &&
+		       a->ip.v4.src_port == b->ip.v4.src_port &&
+		       a->mask.v4.dst_port == b->mask.v4.dst_port &&
+		       a->mask.v4.src_port == b->mask.v4.src_port;
+	case ICE_FLTR_PTYPE_NONF_IPV4_OTHER:
+		return base_equal &&
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
+ * Return: true if a filter with identical match criteria (same flow type,
+ * values, and masks) already exists, unless it is at the same location with a
+ * different queue (an update)
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
+		 * Same location with a different queue is an update, not a
+		 * duplicate - skip it. Everything else is a duplicate.
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

