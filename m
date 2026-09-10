Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017C1C79FBF
	for <intel-wired-lan@archiver.kernel.org>; Thu, 10 Sep 2026 15:49:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A72E240B01;
	Thu, 10 Sep 2026 15:49:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HZIj84u_p44T; Thu, 10 Sep 2026 15:48:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C015940B02
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789055339;
	b=NhllF0zOZpGMU1mMNlj5VlHAajWn01cULamoY5XECkukgowv28HQh2wA7Pg3b50VYcJ6
	 hEjw0jGEpIznc/7BoQ04LtDFqz00vAYFIDeLgW0iW7fHdj7PlSc6D6Ep4Ivk/uCLHc4Q8
	 vEAtJ9IH7EzSeZvlV11ErivFQdE2+c9MmH3DQ0pr9dqq0UuJWbhjmRneW0Lq6hCTSQVQu
	 9IDbFKYr8JRMeZaDgv4iTJM0P1RXbsMeCkdo+DUiRB87Fg92uSa2Lqk7Rl46la5QAgyrp
	 pO3MelIFh5vS3TX+XiAV/3h+pdRHM7/GD/GFal6/DIKBQQJl3/j7jn898m939WVeP4g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789055339;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=F5w0jy246kHftjN+D2Du9qEiLGYhb901y8Up9PxXONM=;
	b=tf6XpRZON2l41418eHOA/5mtQyG7vmReS3lHHfSKDh3ZI6MGkEVZ3NPeBKeOqfxPmKBO
	 Y1iUKMoTeUjeYZs3BifNaLajpWBlSWAVic5lROfGHBkNR8azPa99RGZ4JsZdwcdegYQAg
	 FJIkVZw8daOGr2UyQ4R3AYDufAQKG8BUiiOIpksTAcuy+2tkhCkJ9FlUop4UnfHo5jLZU
	 ZuTGXYqPkCBkPi/qCrm2pWoBIGVqm6i2YFdLWkVlSHpHpfZB4wDML7ZcvbO/tv8Bppk8X
	 1lczLzJGE0jl+KWKMpdDuOfeu5X8c5+eAgBNyV54SCi2F9tR6Cz5IBNfZi4CmuX57Jw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789055339;
	bh=F5w0jy246kHftjN+D2Du9qEiLGYhb901y8Up9PxXONM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R5xAzRtZlfrCkUksg/sF7T4hICICv2mCiBLD21r7MYncNis7unaHVWTpyfR4h1qND
	 EMnUSnu69aluONVW0HQ2CkAjxvRgHGXc8kqr210W9W1YwIpJozyK6yRnM4HSnlnvXJ
	 f/eJ7lB0kzFhSzMbDTgBhRXEJeS/CamGDivSab+BUrExzKpyoFP1n/ihqjc4DFNba0
	 qN0hfMo87rJOqZpQnGXbvaM7p8WkhIx4y/PVv8KMLS1CFO0DwZeJcseO/Vb3k5sUj2
	 1HzkjastG2VLvNc2+EYIXq31DDbA9vWpOeP/nxhl8v2q3hBuAso3iV5ogkjX/W+CAJ
	 cMZjqSYj8f/eg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C015940B02;
	Thu, 10 Sep 2026 15:48:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A7E30769
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 15:48:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 99AAC40332
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 15:48:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nSd4cJozac7h for <intel-wired-lan@lists.osuosl.org>;
 Thu, 10 Sep 2026 15:48:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 51FCF4032B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789055337;
 b=rEoL6IDmB/fW/5GoCMGwbDaZ7DLEPoMbCFi6m1+4am42TN1PURCMR90UjjgMTkZ038nU
 ZpkDivWxcIr995vAi8euDtKCAc8/wdABDiNrtqVKE0HcglurbirXBe0WjrBqjOJ7RiD2a
 sBxIdf30rlSOX8N8kAjbjJgU9jcdmA3NLH2UL7hKW+ksyf51A/TSMKyA/97bzWAjJFmAi
 CkNNkJRRPQbSFmiWRuLh206BOn+BAjIweym8Yrw1F4x5Ga+qlWiPmgGv9UvmkPtnjvYwS
 ctrVovaMaQp7lIRpanmIQl/RIeqJZ26zAUsJzRm877VlMp89zCGdc338LeLTvPbWDgw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789055337;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=F5w0jy246kHftjN+D2Du9qEiLGYhb901y8Up9PxXONM=;
 b=UoXXgw/VdpL+mAWsskTY8XzVIvX3WE9bjh64AJxR2WYbXsjcqiO3c92UhefuRfxNxJEJ
 Eo9vA6XNU6jPdYCoRSgn4u4lNvCKs1rAZ3R3y8Qs8Zf/6pHvnp8yeJ4Z/VSwdEjKG3CII
 RNPIV3nODTQR2LIbb1rhcVRmMusMyaV9EQDyFvWT8mB8M2gTSbvRIzYkQPVAbdNjvA+mP
 aChzd1NngN4qKExOHMWUE376sSWd7EzcflhH7d3z6f3i4gWcZ0DEbAAOoEw3Ixdc0bsz3
 oWHPxx7clbvyP6zzKa+eTUaKPt5SigibvEGxBwXmiGpJeTi0CccOL9ljv5NvDPi7d2A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=ZKPwTmBY; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZKPwTmBY
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTP id 51FCF4032B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 15:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789055335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F5w0jy246kHftjN+D2Du9qEiLGYhb901y8Up9PxXONM=;
 b=ZKPwTmBYPIZVHMorDmV0yTfyKcuo63UfGQzVMdP1wWdsk1fqP3vTmFYkgHgZcJF583LEL/
 GCNY6ge37VY1Nf2LITQijlbxOOpE+2cBd4SrkUrS9lQyyAMi+KU32xXvgRmt/qPfx/AXcj
 T/FdgxBNQSVIFMZ19zSNdW9sfMaXlRw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-_AgsWjZpMvisMCj0xFMMFw-1; Thu,
 10 Sep 2026 11:48:51 -0400
X-MC-Unique: _AgsWjZpMvisMCj0xFMMFw-1
X-Mimecast-MFC-AGG-ID: _AgsWjZpMvisMCj0xFMMFw_1789055329
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E72A1955DDB; Thu, 10 Sep 2026 15:48:48 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.48.140])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B3B0F418; Thu, 10 Sep 2026 15:48:44 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Priyalee Kushwaha <priyalee.kushwaha@intel.com>,
 Kiran Patil <kiran.patil@intel.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next 2/2] ice: don't offload drop filters that bypass
 higher priority filters
Date: Thu, 10 Sep 2026 17:48:24 +0200
Message-ID: <20260910154824.3603687-3-poros@redhat.com>
In-Reply-To: <20260910154824.3603687-1-poros@redhat.com>
References: <20260910154824.3603687-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: 1l4TG7Tc7KqGSDgtBwRr03tLX52DYUB-imvZuFauCOo_1789055329
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

The E810 switch gives drop rules absolute precedence over forwarding
rules regardless of recipe priority (verified on E810 in every
combination of installation order and match specificity). TC however
requires filters to be evaluated in priority order, so when a higher
priority filter stays software-only because its match or action cannot
be offloaded while a lower priority drop filter is offloaded, the
hardware drops packets the higher priority filter should have seen:

  tc filter add dev $pf ingress prio 1 protocol ip flower \
      ip_proto l2tp action pass
  tc filter add dev $pf ingress prio 2 protocol ip flower action drop

The pass filter is rejected (unsupported action), the drop filter is
offloaded and the hardware drops all IPv4 traffic including the L2TP
packets the prio 1 filter should accept.

Track filters that were presented to the driver but not offloaded and
refuse to offload a drop filter when a higher priority filter on the
same device block and direction is software-only or is offloaded with a
forwarding action, which the hardware drop would equally override. The
refused drop filter keeps working in software. Filters are compared
only within one device block since TC priorities are not ordered across
blocks. Filters with skip_sw bypass the check because the user
explicitly requested hardware-only operation and refusing would fail
the filter add entirely, and the tracking applies to the legacy switch
mode only, switchdev pipelines manage rule priorities themselves.

The check does not analyze match overlap, so it is conservative, and it
runs only at drop offload time. A conflicting filter installed after a
drop filter was already offloaded cannot un-offload it, and filters the
driver never saw (added while hw-tc-offload was off) are invisible to
it. Installing filters in priority order with offload enabled avoids
both.

Fixes: 0d08a441fb1a ("ice: ndo_setup_tc implementation for PF")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice.h        |   1 +
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 150 +++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_tc_lib.h |  21 +++
 3 files changed, 166 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index db3c7015c56c43..6c596e5a315175 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -643,6 +643,7 @@ struct ice_pf {
 	 */
 	u16 num_dmac_chnl_fltrs;
 	struct hlist_head tc_flower_fltr_list;
+	struct hlist_head tc_sw_fltr_list;
 
 	u64 supported_rxdids;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index fbd8cbad150a98..7cfc8941b7ba57 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -2269,6 +2269,112 @@ ice_find_tc_flower_fltr(struct ice_pf *pf, unsigned long cookie)
 	return NULL;
 }
 
+/**
+ * ice_tc_fltr_is_drop - check if a filter carries a drop action
+ * @cls_flower: offload request describing the filter
+ *
+ * Return: true if any action of the filter is a drop, false otherwise.
+ */
+static bool ice_tc_fltr_is_drop(struct flow_cls_offload *cls_flower)
+{
+	struct flow_rule *rule = flow_cls_offload_flow_rule(cls_flower);
+	struct flow_action_entry *act;
+	int i;
+
+	if (cls_flower->classid)
+		return false;
+
+	flow_action_for_each(i, act, &rule->action)
+		if (act->id == FLOW_ACTION_DROP)
+			return true;
+
+	return false;
+}
+
+/**
+ * ice_tc_untrack_sw_fltr - forget a tracked software-only filter
+ * @pf: pointer to PF structure
+ * @cookie: unique filter identifier from the offload request
+ *
+ * Return: true if the filter was tracked, false otherwise.
+ */
+static bool ice_tc_untrack_sw_fltr(struct ice_pf *pf, unsigned long cookie)
+{
+	struct ice_tc_sw_fltr *sw_fltr;
+
+	hlist_for_each_entry(sw_fltr, &pf->tc_sw_fltr_list, node) {
+		if (sw_fltr->cookie != cookie)
+			continue;
+
+		hlist_del(&sw_fltr->node);
+		kfree(sw_fltr);
+		return true;
+	}
+
+	return false;
+}
+
+/**
+ * ice_tc_track_sw_fltr - remember a filter that was not offloaded
+ * @pf: pointer to PF structure
+ * @filter_dev: device the filter was requested on
+ * @cls_flower: offload request describing the filter
+ * @direction: block direction the filter was requested for
+ */
+static void ice_tc_track_sw_fltr(struct ice_pf *pf,
+				 struct net_device *filter_dev,
+				 struct flow_cls_offload *cls_flower,
+				 enum ice_eswitch_fltr_direction direction)
+{
+	struct ice_tc_sw_fltr *sw_fltr;
+
+	hlist_for_each_entry(sw_fltr, &pf->tc_sw_fltr_list, node)
+		if (sw_fltr->cookie == cls_flower->cookie)
+			return;
+
+	sw_fltr = kzalloc_obj(*sw_fltr);
+	if (!sw_fltr)
+		return;
+
+	sw_fltr->cookie = cls_flower->cookie;
+	sw_fltr->filter_dev = filter_dev;
+	sw_fltr->prio = cls_flower->common.prio;
+	sw_fltr->direction = direction;
+	sw_fltr->is_drop = ice_tc_fltr_is_drop(cls_flower);
+	hlist_add_head(&sw_fltr->node, &pf->tc_sw_fltr_list);
+}
+
+/**
+ * ice_tc_drop_bypasses_fltr - check if a drop rule would bypass a filter
+ * @pf: pointer to PF structure
+ * @filter_dev: device the drop filter is requested on
+ * @prio: TC priority of the drop filter
+ * @direction: block direction of the drop filter
+ *
+ * Return: true if such a filter exists, false otherwise.
+ */
+static bool
+ice_tc_drop_bypasses_fltr(struct ice_pf *pf, struct net_device *filter_dev,
+			  u32 prio, enum ice_eswitch_fltr_direction direction)
+{
+	struct ice_tc_flower_fltr *fltr;
+	struct ice_tc_sw_fltr *sw_fltr;
+
+	hlist_for_each_entry(sw_fltr, &pf->tc_sw_fltr_list, node)
+		if (sw_fltr->filter_dev == filter_dev &&
+		    sw_fltr->direction == direction && sw_fltr->prio < prio &&
+		    !sw_fltr->is_drop)
+			return true;
+
+	hlist_for_each_entry(fltr, &pf->tc_flower_fltr_list, tc_flower_node)
+		if (fltr->filter_dev == filter_dev &&
+		    fltr->direction == direction && fltr->prio < prio &&
+		    fltr->action.fltr_act != ICE_DROP_PACKET)
+			return true;
+
+	return false;
+}
+
 /**
  * ice_add_cls_flower - add TC flower filters
  * @netdev: Pointer to filter device
@@ -2284,14 +2390,24 @@ int ice_add_cls_flower(struct net_device *netdev, struct ice_vsi *vsi,
 {
 	struct netlink_ext_ack *extack = cls_flower->common.extack;
 	struct net_device *vsi_netdev = vsi->netdev;
+	enum ice_eswitch_fltr_direction direction;
 	struct ice_tc_flower_fltr *fltr;
 	struct ice_pf *pf = vsi->back;
+	bool track_sw_fltrs;
 	int err;
 
-	if (ice_is_reset_in_progress(pf->state))
-		return -EBUSY;
-	if (test_bit(ICE_FLAG_FW_LLDP_AGENT, pf->flags))
-		return -EINVAL;
+	direction = ingress ? ICE_ESWITCH_FLTR_INGRESS :
+			      ICE_ESWITCH_FLTR_EGRESS;
+	track_sw_fltrs = !ice_is_eswitch_mode_switchdev(pf);
+
+	if (ice_is_reset_in_progress(pf->state)) {
+		err = -EBUSY;
+		goto track_sw;
+	}
+	if (test_bit(ICE_FLAG_FW_LLDP_AGENT, pf->flags)) {
+		err = -EINVAL;
+		goto track_sw;
+	}
 
 	if (ice_is_port_repr_netdev(netdev))
 		vsi_netdev = netdev;
@@ -2304,7 +2420,8 @@ int ice_add_cls_flower(struct net_device *netdev, struct ice_vsi *vsi,
 		 */
 		if (netdev == vsi_netdev)
 			NL_SET_ERR_MSG_MOD(extack, "can't apply TC flower filters, turn ON hw-tc-offload and try again");
-		return -EINVAL;
+		err = -EINVAL;
+		goto track_sw;
 	}
 
 	/* avoid duplicate entries, if exists - return error */
@@ -2314,14 +2431,32 @@ int ice_add_cls_flower(struct net_device *netdev, struct ice_vsi *vsi,
 		return -EEXIST;
 	}
 
+	if (track_sw_fltrs && !cls_flower->common.skip_sw &&
+	    ice_tc_fltr_is_drop(cls_flower) &&
+	    ice_tc_drop_bypasses_fltr(pf, netdev, cls_flower->common.prio,
+				      direction)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Drop filter not offloaded because it would bypass a higher priority filter");
+		err = -EOPNOTSUPP;
+		goto track_sw;
+	}
+
 	/* prep and add TC-flower filter in HW */
 	err = ice_add_tc_fltr(netdev, vsi, cls_flower, &fltr, ingress);
 	if (err)
-		return err;
+		goto track_sw;
+
+	fltr->filter_dev = netdev;
+	fltr->prio = cls_flower->common.prio;
 
 	/* add filter into an ordered list */
 	hlist_add_head(&fltr->tc_flower_node, &pf->tc_flower_fltr_list);
 	return 0;
+
+track_sw:
+	if (track_sw_fltrs && !cls_flower->common.skip_sw)
+		ice_tc_track_sw_fltr(pf, netdev, cls_flower, direction);
+	return err;
 }
 
 /**
@@ -2336,6 +2471,9 @@ ice_del_cls_flower(struct ice_vsi *vsi, struct flow_cls_offload *cls_flower)
 	struct ice_pf *pf = vsi->back;
 	int err;
 
+	if (ice_tc_untrack_sw_fltr(pf, cls_flower->cookie))
+		return 0;
+
 	/* find filter */
 	fltr = ice_find_tc_flower_fltr(pf, cls_flower->cookie);
 	if (!fltr) {
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.h b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
index 752af65e70b7bf..37d6f4100ecfbc 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
@@ -139,12 +139,33 @@ enum ice_eswitch_fltr_direction {
 	ICE_ESWITCH_FLTR_EGRESS,
 };
 
+/**
+ * struct ice_tc_sw_fltr - filter presented to the driver but not offloaded
+ * @node: node in the pf->tc_sw_fltr_list
+ * @cookie: unique filter identifier from the offload request
+ * @filter_dev: device the filter was requested on
+ * @prio: TC priority, lower value is evaluated first
+ * @direction: block direction the filter was requested for
+ * @is_drop: the filter carries a drop action
+ */
+struct ice_tc_sw_fltr {
+	struct hlist_node node;
+	unsigned long cookie;
+	struct net_device *filter_dev;
+	u32 prio;
+	enum ice_eswitch_fltr_direction direction;
+	bool is_drop;
+};
+
 struct ice_tc_flower_fltr {
 	struct hlist_node tc_flower_node;
 
 	/* cookie becomes filter_rule_id if rule is added successfully */
 	unsigned long cookie;
 
+	struct net_device *filter_dev;
+	u32 prio;
+
 	/* add_adv_rule returns information like recipe ID, rule_id. Store
 	 * those values since they are needed to remove advanced rule
 	 */
-- 
2.55.0

