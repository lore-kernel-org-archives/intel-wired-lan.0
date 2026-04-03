Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82104D730A3
	for <intel-wired-lan@archiver.kernel.org>; Fri,  3 Apr 2026 05:40:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3809240D51;
	Fri,  3 Apr 2026 05:40:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tyMexN92FrZ1; Fri,  3 Apr 2026 05:40:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 453C140BAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775194836;
	bh=7MEu+KWN7s4FVH14KOLq8wfiUsXFRe5XZXMOOgKL3E8=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1A1EYW62R2ymmYojN4ZZqdHO97lAWoIuM9UI07WAZm8Zsl+omVQcxaQwoSHxo1+ZE
	 8lXaX8Y+EUEa3nCy0rP2q5NVeaMuzdYCSoV7nPs/wvw+Li6b89wLi3ItAu0swJOXAV
	 bzNThRVQ89G4KaV0jLQlx9LLzNIwXk8BbQ8zschKznbDSoU7FSsSIykzlp7VkWdHsm
	 Q6ZWy1XtFRER2NKmVUkkBngB1mlbNsSgO76M3g+S7KwY8/MrMqVaCd8Vr+rxxW9J9S
	 QDSIyrWGVWje/ubH0WQ7Ihi19Q37saXnlLpui4ehyyL5wzdEyNKNbgH93UkFKOptAQ
	 f+LIaOwDH2mNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 453C140BAA;
	Fri,  3 Apr 2026 05:40:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 54C0C1F3
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 05:40:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4670B40BAA
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 05:40:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aKdgcQEz9hjg for <intel-wired-lan@lists.osuosl.org>;
 Fri,  3 Apr 2026 05:40:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9200B40B9C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9200B40B9C
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9200B40B9C
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 05:40:33 +0000 (UTC)
X-CSE-ConnectionGUID: lAJmTqzAR161q7lvV6lOeQ==
X-CSE-MsgGUID: hfJP2QSJTXemqVsiV9h8Sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75981738"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="75981738"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 22:40:33 -0700
X-CSE-ConnectionGUID: jbTBlcg1SAetYI2QwXajeg==
X-CSE-MsgGUID: 2xE0J/kwReG74IUN0Bb3lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="223904913"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa007.fm.intel.com with ESMTP; 02 Apr 2026 22:40:31 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org, Michal Swiatkowski <michal.swiatkowski@intel.com>
Date: Fri,  3 Apr 2026 07:40:19 +0200
Message-ID: <20260403054029.3789616-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260403054029.3789616-1-aleksandr.loktionov@intel.com>
References: <20260403054029.3789616-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775194834; x=1806730834;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Vp8t693MvIq+MfKl2r5GIw4QU1Y/T0mo5MRMbiHbG4c=;
 b=Oeg0dGr8x6UD54v8Jmphnch08vfW1NWHgVAP5oy12WItv7JA1UhcMhJn
 NbWeb88q6hpCtn1R3xR0NSsmWdioXpjfqfQO5l16PZU7zW+Dt2vHCLlr6
 JSXbUvzn2N86JtS6fQ4FiT436UYJyRcFovQ4T+/E5nJL3CQPITlO4PDil
 Wi8ojwhJQafVigIn8mtrmXcYmznTe501KNaBTDjfatAypUX6u1JS2Et6o
 2UUqxXc1EhRU1Gy/oqwi16lSfPt5mfohQZlNwkPJ74cOnENqavLWkJbsB
 lXduP8+hGwxDnvrj0qNLAFKRIM9ZIbhTwdECsKmXcwFWXIksSMSsUQ8kE
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Oeg0dGr8
Subject: [Intel-wired-lan] [PATCH iwl-net 1/10] ice: fix mirroring to VSI
 list
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

From: Michal Swiatkowski <michal.swiatkowski@intel.com>

Rules whose action can be "to VSI list" should have VSI count set to 1
after creation. There was a lack of it in case of mirroring action. Fix
it by setting correct VSI count also for mirror rules.

Reproduction:
  tc filter add dev eth5 ingress protocol arp prio 6301 flower skip_sw \
    dst_mac ff:ff:ff:ff:ff:ff action mirred egress mirror dev eth9
  tc filter add dev eth5 ingress protocol arp prio 6201 flower skip_sw \
    dst_mac ff:ff:ff:ff:ff:ff action mirred egress mirror dev eth10

  tc filter del dev eth5 prio 6301 ingress

The last command removes the rule, but should only remove one VSI from
the forward list. Without the fix:

  tc filter del dev eth5 prio 6201 ingress

results in an error during removing the rule.

Fixes: aa4967d8529c ("ice: Add support for packet mirroring using hardware in switchdev mode")
Cc: stable@vger.kernel.org
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index a3e93b1..d77c188 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -7318,7 +7318,8 @@ ice_add_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 	sw->recp_list[rid].adv_rule = true;
 	rule_head = &sw->recp_list[rid].filt_rules;
 
-	if (rinfo->sw_act.fltr_act == ICE_FWD_TO_VSI)
+	if (rinfo->sw_act.fltr_act == ICE_FWD_TO_VSI ||
+	    rinfo->sw_act.fltr_act == ICE_MIRROR_PACKET)
 		adv_fltr->vsi_count = 1;
 
 	/* Add rule entry to book keeping list */
-- 
2.52.0
