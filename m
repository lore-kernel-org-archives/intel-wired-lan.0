Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACF2C6FD19
	for <intel-wired-lan@archiver.kernel.org>; Tue, 14 Mar 2023 02:03:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1A6B4400CB;
	Tue, 14 Mar 2023 02:03:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1A6B4400CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1678759406;
	bh=khYYk093oX65FjNiF+I3AnfdqtWsbQigdjwwk9Zr0gM=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zj6kXUbHd7t652uHKfTZJRlMDNU4pg2A4hQ5N1KfDsds1Hk3tvv3JPUp2C3cSMdQx
	 wvh7ZgQEA6TBuxQMW8lV2lxb1xeIquO+7iHyUAQ2DzmXjszgfCXg/LQi6eOy3VDNMo
	 rnTIdwa1WN1FezLrQL8tT4bza38DAtM6WJR+O23ZabZLMDQYsTVJEVcq+0Da0jNSei
	 w4U29yv8aeZBQLTbe4ktQxTQ2mjhXbQDYnmndGUxUl5cyt6R/M1a6O7UjouB+qmUU9
	 FWJ3UhJEPu3y5sMmLHIIOSTBL7O0hY1IN40dycVIGlajjMFg0y3GVavyXTDImhLq2d
	 gCVZB9fDa1zGA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EsWBmiqXwvAE; Tue, 14 Mar 2023 02:03:25 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0867740286;
	Tue, 14 Mar 2023 02:03:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0867740286
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 7AD361BF954
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Mar 2023 02:03:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 60442813AA
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Mar 2023 02:03:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 60442813AA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W3BVQd61lUs9 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 14 Mar 2023 02:03:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1481E813A8
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1481E813A8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Mar 2023 02:03:22 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="337331748"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; d="scan'208";a="337331748"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2023 19:03:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="802667872"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; d="scan'208";a="802667872"
Received: from dpdk-jf-ntb-v2.sh.intel.com ([10.67.119.39])
 by orsmga004.jf.intel.com with ESMTP; 13 Mar 2023 19:03:19 -0700
From: Junfeng Guo <junfeng.guo@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 14 Mar 2023 10:03:15 +0800
Message-Id: <20230314020315.4190488-1-junfeng.guo@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1678759403; x=1710295403;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=vFfBOv1pcKddZ1GUrdYzl/kaxtrs/4hJTLZ9BzPF3dk=;
 b=Wk6Cn3KnBTbRq6FaqYJGRT6MO0i5m9paUBwLO8WmgmQq+KuFL3yvqMgm
 hqEEOVHaoQi0G747C09VwEqe625XYVG2EuxPQsem45/rD6GnBHfDx7ZUp
 tjFAgcScms17loG3tP9K7nIXZLpAXZdKjLHSa2W4Q1jmgsMT5jJ18YuTz
 P+42TSyYmYJjsgvFXoCLzX16YclSk1OCNYP/vbATe/3v0CVCDTdlajbuH
 9NxjCTjvPmmMrKk430IIAnXSdRb/R0HYhyViL3gLfCoLzc/dXWKHAuqFU
 M2OAiA+OBMXf5aSHgqU+Ljhrd9o3rZcoZLw7Ri3EhExRLRTm1dz8QfMXd
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Wk6Cn3Kn
Subject: [Intel-wired-lan] [PATCH net v3] ice: add profile conflict check
 for AVF FDIR
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Add profile conflict check while adding some FDIR rules to aviod
unexpected flow behavior, rules may have conflict including:
        IPv4 <---> {IPv4_UDP, IPv4_TCP, IPv4_SCTP}
        IPv6 <---> {IPv6_UDP, IPv6_TCP, IPv6_SCTP}

For example, when we create an FDIR rule for IPv4, this rule will work
on packets including IPv4, IPv4_UDP, IPv4_TCP and IPv4_SCTP. But if we
then create an FDIR rule for IPv4_UDP and then destroy it, the first
FDIR rule for IPv4 cannot work on pkt IPv4_UDP then.

To prevent this unexpected behavior, we add restriction in software
when creating FDIR rules by adding necessary profile conflict check.

Fixes: 1f7ea1cd6a37 ("ice: Enable FDIR Configure for AVF")
Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
---
 .../ethernet/intel/ice/ice_virtchnl_fdir.c    | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
index e6ef6b303222..5fd75e75772e 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
@@ -541,6 +541,72 @@ static void ice_vc_fdir_rem_prof_all(struct ice_vf *vf)
 	}
 }
 
+/**
+ * ice_vc_fdir_has_prof_conflict
+ * @vf: pointer to the VF structure
+ * @conf: FDIR configuration for each filter
+ *
+ * Check if @conf has conflicting profile with existing profiles
+ *
+ * Return: true on success, and false on error.
+ */
+static bool
+ice_vc_fdir_has_prof_conflict(struct ice_vf *vf,
+			      struct virtchnl_fdir_fltr_conf *conf)
+{
+	struct ice_fdir_fltr *desc;
+
+	list_for_each_entry(desc, &vf->fdir.fdir_rule_list, fltr_node) {
+		struct virtchnl_fdir_fltr_conf *existing_conf;
+		enum ice_fltr_ptype flow_type_a, flow_type_b;
+		struct ice_fdir_fltr *a, *b;
+
+		existing_conf = to_fltr_conf_from_desc(desc);
+		a = &existing_conf->input;
+		b = &conf->input;
+		flow_type_a = a->flow_type;
+		flow_type_b = b->flow_type;
+
+		/* No need to compare two rules with different tunnel types or
+		 * with the same protocol type.
+		 */
+		if (existing_conf->ttype != conf->ttype ||
+		    flow_type_a == flow_type_b)
+			continue;
+
+		switch (flow_type_a) {
+		case ICE_FLTR_PTYPE_NONF_IPV4_UDP:
+		case ICE_FLTR_PTYPE_NONF_IPV4_TCP:
+		case ICE_FLTR_PTYPE_NONF_IPV4_SCTP:
+			if (flow_type_b == ICE_FLTR_PTYPE_NONF_IPV4_OTHER)
+				return true;
+			break;
+		case ICE_FLTR_PTYPE_NONF_IPV4_OTHER:
+			if (flow_type_b == ICE_FLTR_PTYPE_NONF_IPV4_UDP ||
+			    flow_type_b == ICE_FLTR_PTYPE_NONF_IPV4_TCP ||
+			    flow_type_b == ICE_FLTR_PTYPE_NONF_IPV4_SCTP)
+				return true;
+			break;
+		case ICE_FLTR_PTYPE_NONF_IPV6_UDP:
+		case ICE_FLTR_PTYPE_NONF_IPV6_TCP:
+		case ICE_FLTR_PTYPE_NONF_IPV6_SCTP:
+			if (flow_type_b == ICE_FLTR_PTYPE_NONF_IPV6_OTHER)
+				return true;
+			break;
+		case ICE_FLTR_PTYPE_NONF_IPV6_OTHER:
+			if (flow_type_b == ICE_FLTR_PTYPE_NONF_IPV6_UDP ||
+			    flow_type_b == ICE_FLTR_PTYPE_NONF_IPV6_TCP ||
+			    flow_type_b == ICE_FLTR_PTYPE_NONF_IPV6_SCTP)
+				return true;
+			break;
+		default:
+			break;
+		}
+	}
+
+	return false;
+}
+
 /**
  * ice_vc_fdir_write_flow_prof
  * @vf: pointer to the VF structure
@@ -677,6 +743,13 @@ ice_vc_fdir_config_input_set(struct ice_vf *vf, struct virtchnl_fdir_add *fltr,
 	enum ice_fltr_ptype flow;
 	int ret;
 
+	ret = ice_vc_fdir_has_prof_conflict(vf, conf);
+	if (ret) {
+		dev_dbg(dev, "Found flow profile conflict for VF %d\n",
+			vf->vf_id);
+		return ret;
+	}
+
 	flow = input->flow_type;
 	ret = ice_vc_fdir_alloc_prof(vf, flow);
 	if (ret) {
-- 
2.25.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
