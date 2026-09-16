Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C376C982C3
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Sep 2026 14:42:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EFFC66068B;
	Wed, 16 Sep 2026 14:42:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ETbM8eXnGMpS; Wed, 16 Sep 2026 14:42:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AEDE3607F8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789569724;
	b=YdXw5p85Go6n9hn2+/0iO5AokoJWErf5d4IPaWd0v7ImglfE9Ji4EiOZD4iSUBbqDg5j
	 PGb5X5uMMEVtHv1m/i9wRtxR/QvbynWMdPJ114vIYOxVhCj/1qm+R7JICcXnBvXcW5+JG
	 Hx9maiU8fbUlONmCmkGBMHB85KAXprUoiFDknmmrRL/lGCxxC/kEFBVA9kKW9qM29wKGb
	 10n2VJ0vzL3SQJSSb8Jmu+BZyZ1RTbQzJpioD0R+BV3Oc2U5f8Har1rV+iDNtK6VymGZz
	 sIj5+bacSOfBt8jBIAuNKz5tIMCp8AtH3UQHKbfW8+hYYAfKWuMhmqAepx21DVOgNRg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789569724;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vwkxAtMc4/t7l1lYwlmK7CBbkBVAogXL7h4sRQPbgdk=;
	b=Z0hR6s/NEpLDSNOYBfKHgNfOqhZazasIHn6zt5cWsdpv9gcTuyOERYm5kelazoPmDoZU
	 ktCxN34ApS2MrYZKv5ICLGRK4lkI5nv55yln5rF1LnMX7IvXGjrEwOqv4I3lBqOJEbVPL
	 +qyym+DNSRFzco3dCm32Yfr+3VPh/3QJ2ZfO+/zwdqKhp41LUTtyHZKrigSq5F+7N51LR
	 KaKgJ+hwKJiBQXKxLyq8h3yrT1+XZHXpL4vM7ZWEoWz4vvMFCdh8+erER+hWP0Zss7p+/
	 BtzmpBXy5kgtLl2kXxhvFG3J/cn0os949XIV/GwKlC34b6z75rNc5rtMXGC4jaojgZA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789569724;
	bh=vwkxAtMc4/t7l1lYwlmK7CBbkBVAogXL7h4sRQPbgdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=30FKXv/s+a7temipmlmlVRpr9uUd1H/v2xXr7j5MscSSn6mpHKvhX6W8eIFQspUAz
	 AZZHLY8oaqq0oIB8MqkwQEGAWnblwxnYexogfLw8b+dsNoEkqzY8zJEoxWyK0rmX47
	 NBXfNiRdh2fEp4Vo/tM37+A9Bss/pd0DgkYcVo/TDlCECkGIjuNV3tPp+vPc33UayP
	 oNxhyDcTPfXjselS0aqdxPy/yqJMCQIWSIG2tOK3j2AkzQ3iry69MvJME+xE84XwDA
	 yLe+83YA5aSzlkXTu3CIECIX/+3ke5VEaFpS2KruEW1udMxOpgPQ7wv0E2sKD9P6fw
	 5oX3zaieGb//A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AEDE3607F8;
	Wed, 16 Sep 2026 14:42:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A6920DD7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 14:42:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C2B380EA0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 14:42:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3e0bKKAHhUen for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Sep 2026 14:42:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2BB2A80E9D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789569722;
 b=NQMzC09FJmg4mlwd3C93IRcrAdsaf7ZBDuv9tHwNCEn95h/8g10Is0ezww0RpCVR9r0r
 nZ8DCCbtnpH4DMZHNe3yUzW8rIK+IP2Iz+Jxi2iTq4bQbPAmzXjhRFXgu4Ib3ricavCi4
 nW5oqN2sTmlZBQZ4NGa/zSK0HC6YMn2r6Ww3Wl4sJm2X/df4wiuChOSsGBSWAV/Yz6nm8
 knfKxnelzouVhDj6fUNrPXemWmd/wXRjKSxrbBzMnGwNRSimYynrQYZmKJKjqf88WR5pg
 CybSMeRzhgwVzP2N4AhyaxZp3L9+tRHv5sBh61Ymspo+aPcrno33Hxk50IxeSKuUnAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789569722;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=vwkxAtMc4/t7l1lYwlmK7CBbkBVAogXL7h4sRQPbgdk=;
 b=edsn9yxws/y9DB9hCMHiaTGyPu97Xc/y/URXgwDpPIKBFKDKG6pKs7devOb5RTE2YefH
 6JTs+nOvtMwjPSVlGrc9zElH19OH1Iv+VHqT0C5oYqZ4DAvI87loYocrurtQ46ZA8kCA0
 LYE3WgXHwoV12+APfu9IpWMgJXSiSoJEN8v5xtuLZ/1CX23ivitMXlV1TayTVvTN5b3nH
 V+YTCKu3lTUf+BelhGLQjeD4hXwbMhXhg7Z8Fka+v1E7gGRgpo8FTdHtC2YvVOfB75mBO
 BKIZMNuXzJiLh8dPeJ8LrfsGflMqY2SHaweDQJavYGMBqhZ5sPXzt/Icfbc9pE1KN6w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=MR0RdyNq; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MR0RdyNq
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2BB2A80E9D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 14:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789569720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vwkxAtMc4/t7l1lYwlmK7CBbkBVAogXL7h4sRQPbgdk=;
 b=MR0RdyNqF8JhO4D7slPsmU1hCdvyHn2ibzh6OK0feVZfBRHN6K9v0TpV1/u02wCgsezce1
 q+Zmmi0exRbqj4lW9qAV3szagwmu4dOFRMO1raJDtr+SpI2rCdXX++DH1nwy5CnKYuIpRe
 Zq9GafyyTrP+MpWoX1cHRq/oReGvS04=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-gsA5rMVwNRq6SGVP5swV1A-1; Wed,
 16 Sep 2026 10:41:56 -0400
X-MC-Unique: gsA5rMVwNRq6SGVP5swV1A-1
X-Mimecast-MFC-AGG-ID: gsA5rMVwNRq6SGVP5swV1A_1789569714
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22FD51800655; Wed, 16 Sep 2026 14:41:54 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.49.1])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D4A519560AB; Wed, 16 Sep 2026 14:41:49 +0000 (UTC)
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
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Simon Horman <horms@kernel.org>, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v2 2/2] ice: don't offload drop filters that bypass
 higher priority filters
Date: Wed, 16 Sep 2026 16:41:30 +0200
Message-ID: <20260916144130.2699902-3-poros@redhat.com>
In-Reply-To: <20260916144130.2699902-1-poros@redhat.com>
References: <20260916144130.2699902-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: k_kz8OKym_lFSSpI3LjrFh16olcP25uy16Rva9yG3_Q_1789569714
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
blocks, and a shared block bound to multiple devices is tracked once
per binding. Filters with skip_sw bypass the check because the user
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
v2:
- track one entry per cookie and filter_dev pair instead of one per
  cookie, so a shared block bound to multiple devices of one PF is
  protected on every binding and each DESTROY invocation removes its
  own entry instead of returning -EINVAL for the later bindings
  (sashiko review via Simon Horman)
- pass the filter device to ice_del_cls_flower() for the lookup above

v1: https://lore.kernel.org/all/20260910154824.3603687-3-poros@redhat.com/
 drivers/net/ethernet/intel/ice/ice.h        |   1 +
 drivers/net/ethernet/intel/ice/ice_main.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice_repr.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 159 +++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_tc_lib.h |  23 ++-
 5 files changed, 177 insertions(+), 10 deletions(-)

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
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 3b76eb58666c07..3e6976cbb45c22 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -8392,7 +8392,7 @@ ice_setup_tc_cls_flower(struct ice_netdev_priv *np,
 	case FLOW_CLS_REPLACE:
 		return ice_add_cls_flower(filter_dev, vsi, cls_flower, ingress);
 	case FLOW_CLS_DESTROY:
-		return ice_del_cls_flower(vsi, cls_flower);
+		return ice_del_cls_flower(filter_dev, vsi, cls_flower);
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index 096566c697f444..312a1bda460035 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -223,7 +223,7 @@ ice_repr_setup_tc_cls_flower(struct ice_repr *repr,
 		return ice_add_cls_flower(repr->netdev, repr->src_vsi, flower,
 					  true);
 	case FLOW_CLS_DESTROY:
-		return ice_del_cls_flower(repr->src_vsi, flower);
+		return ice_del_cls_flower(repr->netdev, repr->src_vsi, flower);
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index fbd8cbad150a98..fec6970a74cfbf 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -2269,6 +2269,117 @@ ice_find_tc_flower_fltr(struct ice_pf *pf, unsigned long cookie)
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
+ * @filter_dev: device the filter was requested on
+ * @cookie: unique filter identifier from the offload request
+ *
+ * Return: true if the filter was tracked, false otherwise.
+ */
+static bool ice_tc_untrack_sw_fltr(struct ice_pf *pf,
+				   struct net_device *filter_dev,
+				   unsigned long cookie)
+{
+	struct ice_tc_sw_fltr *sw_fltr;
+
+	hlist_for_each_entry(sw_fltr, &pf->tc_sw_fltr_list, node) {
+		if (sw_fltr->cookie != cookie ||
+		    sw_fltr->filter_dev != filter_dev)
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
+		if (sw_fltr->cookie == cls_flower->cookie &&
+		    sw_fltr->filter_dev == filter_dev)
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
@@ -2284,14 +2395,24 @@ int ice_add_cls_flower(struct net_device *netdev, struct ice_vsi *vsi,
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
@@ -2304,7 +2425,8 @@ int ice_add_cls_flower(struct net_device *netdev, struct ice_vsi *vsi,
 		 */
 		if (netdev == vsi_netdev)
 			NL_SET_ERR_MSG_MOD(extack, "can't apply TC flower filters, turn ON hw-tc-offload and try again");
-		return -EINVAL;
+		err = -EINVAL;
+		goto track_sw;
 	}
 
 	/* avoid duplicate entries, if exists - return error */
@@ -2314,28 +2436,51 @@ int ice_add_cls_flower(struct net_device *netdev, struct ice_vsi *vsi,
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
  * ice_del_cls_flower - delete TC flower filters
+ * @netdev: Pointer to filter device
  * @vsi: Pointer to VSI
  * @cls_flower: Pointer to struct flow_cls_offload
  */
 int
-ice_del_cls_flower(struct ice_vsi *vsi, struct flow_cls_offload *cls_flower)
+ice_del_cls_flower(struct net_device *netdev, struct ice_vsi *vsi,
+		   struct flow_cls_offload *cls_flower)
 {
 	struct ice_tc_flower_fltr *fltr;
 	struct ice_pf *pf = vsi->back;
 	int err;
 
+	if (ice_tc_untrack_sw_fltr(pf, netdev, cls_flower->cookie))
+		return 0;
+
 	/* find filter */
 	fltr = ice_find_tc_flower_fltr(pf, cls_flower->cookie);
 	if (!fltr) {
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.h b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
index 752af65e70b7bf..47444b7dadd257 100644
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
@@ -214,7 +235,7 @@ static inline int ice_chnl_dmac_fltr_cnt(struct ice_pf *pf)
 struct ice_vsi *ice_locate_vsi_using_queue(struct ice_vsi *vsi, int queue);
 int ice_add_cls_flower(struct net_device *netdev, struct ice_vsi *vsi,
 		       struct flow_cls_offload *cls_flower, bool ingress);
-int ice_del_cls_flower(struct ice_vsi *vsi,
+int ice_del_cls_flower(struct net_device *netdev, struct ice_vsi *vsi,
 		       struct flow_cls_offload *cls_flower);
 void ice_replay_tc_fltrs(struct ice_pf *pf);
 bool ice_is_tunnel_supported(struct net_device *dev);
-- 
2.55.0

