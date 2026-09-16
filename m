Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980F0C982C4
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Sep 2026 14:42:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5984A40757;
	Wed, 16 Sep 2026 14:42:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JnjTQb5KiUqn; Wed, 16 Sep 2026 14:42:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 585B44072F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789569721;
	b=dlCHWr6BqQrWxd6mFJqzHtfwdzzcXWKTynScYP4Xw3aNj7p+WvYhR2p3h7IowSh1jVm4
	 SenJyL9fEvBJib0e5c1COA9GGNA18mLBKMlUPos83tv/DxC0AT9geLaboY2eOX+B8SZwt
	 ELnbPXTIPAORM9P95Leb2AJuJrh8BdPmZKdsRoeyttqW3sue83nyVtEjBltQBdzOPx3lA
	 cSX4JNWWL7au7bUNsxaG6iws6Q98T0P0Bz/dJAm80jWZ3X8qdsRq/hb00YjgCINNY3aWT
	 WnipZ1k7SByAHoPJTbKE17Yl2gN9CgIX3cfybNxY2Zj4V1cFdJCFPDz6KtDIfYqq3Ew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789569721;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bNH5x7SAmY4O0QWV34BUPLPeM7OS4osc8Eq3+VpugLg=;
	b=FhNJQk4x6SpEvqZQMnssBKQ1RXeZw7whtobUDXfW66Gwnm5AEowlrcbDtZhE4TGECe3V
	 Bt9Bu7/9MmW3UazzsZLR5IFLBLXA2v4SncZSYzH23PHPxhonTFRNKoLXsh6Hoh4IVlAGu
	 73G13Q9VLKeMWGCGgsL/EQfV+og3rAboHK0KjNV95ybLaEPSAGfBi1mXnM/uuB4mt1GVT
	 80ILp4LPd81kR4QHyhFP88inIZeeItbAyxgEG8vngFzOWnGxE6ydcSasK8/BokNkOTDQR
	 nnHBeOaGyiTTrbjRT+ERwcIOoBOq/qbwGRFDMJ7U3rpQFwcFp39d9LvhIGGzYU19/Kg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789569721;
	bh=bNH5x7SAmY4O0QWV34BUPLPeM7OS4osc8Eq3+VpugLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6lPg97Qkst8lYSUmB3r5zkHHyXdPr6BKsplAC+uhqTs3rICShFGNVH8LVPMSa37kR
	 C4QKu/z73CofzvfPt/xyiNMpdYzEbz4knm44co78AX0fBX3ECxUiIANbQWcDeQyUyP
	 ZIKnmWLD+xGMsh1sz9kgNhe9yaXW3m9FX3kTvWfv54AG9t5OJK1MF5QElZZ5ddkh7X
	 PGs/dULG62AbSLYtgtHrHwD3njdOtolGjFhokETp4U/AYnhsr7naea7rSh1OjdGUos
	 BeY88Nnhq6f+NojO35wX1CRqPLsKMAeZCurg89ClhQY/n3dK21QI9icAA9GQi/vjqC
	 TsDUNzHavCbQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 585B44072F;
	Wed, 16 Sep 2026 14:42:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BACEC493
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 14:41:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AAD9760820
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 14:41:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0TVqlqeC_etS for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Sep 2026 14:41:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3F643607F8
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789569718;
 b=btA7fwrdkJvUynJuu1kTQ00vVO16uhDCWwQH9urNzObamn5AP2guECwszEBFsEjwBs8q
 5wS+fvZaK/tJ0UspDLq82VdvzfyN9i4bXoPd0gdT4ccyfKhTnFFU2oUlqYF6WZmtXpoFa
 XPCPQQ9VAIuESydVRmZEDLyBsYyE6H+Q0mVLcHd6SAXIgW1ZO2J4zOoa8CN3AQ+S8pMb7
 /Z94/L3OgsO8Kuxenqm8V4Z4589wsFzv3bX1MVxbmqtaxTU0rKG9WrEAziAxk4//F0Hbe
 LBELEh7AiigprfaEdWt8CRpxuPWGBR/7KRy6JBXEP2q+xlhwpmcQhQ6jbwsh+cHFLkw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789569718;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=bNH5x7SAmY4O0QWV34BUPLPeM7OS4osc8Eq3+VpugLg=;
 b=AMDl6uqCNhGRrSB/prMpBfltFxChQSjQUdujEaBVdEo/4kIdIWdFA09f7Yg9w7KkT/X6
 +JjBBF51jdFCy4UavodFvhh0D9sau8mJI+oVFkkJdUAoPzsUGJrJbfrm+phRWpliI4TLt
 OaZFElKfMQR0Tf+aUOMBvEVJHsuNrPesNBvS+KrZwKgEOhKr3LAbmlkl29IANsV9xmxBU
 UrDp7I3MhPCNyqznxlHT4qc5MyZVEDckFCb0Z08Erl3sPGzzJYOeSc9sNz5EAGIrtUtXf
 LbZzcRvDwCFzurZE9NeSxPFNp46CgTTUTifKKw3TaYjrfpWbO+Col5LhAa8Vz1wVYqQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=QyOgS6KO; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=QyOgS6KO
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3F643607F8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 14:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789569715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bNH5x7SAmY4O0QWV34BUPLPeM7OS4osc8Eq3+VpugLg=;
 b=QyOgS6KONuZaFj8fKjvunKhg6KJDP4MQxf85A0j5Nb7QkxG5CAv8Jq6GNDwFyACwNdGzQS
 UMJtPx1/mmS6i5rZ8ws7W4gV+4dJ7sAhaIM4GJtS/men6MDSpuZIObIk2gr/PdinUdKmLm
 Xbzpf62sN/UM92iE9dGkub4ugao9aNs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-kwagSBRrN1ytxlZg2GJkZQ-1; Wed,
 16 Sep 2026 10:41:52 -0400
X-MC-Unique: kwagSBRrN1ytxlZg2GJkZQ-1
X-Mimecast-MFC-AGG-ID: kwagSBRrN1ytxlZg2GJkZQ_1789569710
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1744195F14F; Wed, 16 Sep 2026 14:41:49 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.49.1])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 28D14195604D; Wed, 16 Sep 2026 14:41:44 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Priyalee Kushwaha <priyalee.kushwaha@intel.com>,
 Kiran Patil <kiran.patil@intel.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Simon Horman <horms@kernel.org>, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v2 1/2] ice: fix TC flower filters matching more than
 the ip_proto key
Date: Wed, 16 Sep 2026 16:41:29 +0200
Message-ID: <20260916144130.2699902-2-poros@redhat.com>
In-Reply-To: <20260916144130.2699902-1-poros@redhat.com>
References: <20260916144130.2699902-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: vvBEc4SdZnGOXV5-iv5gJvNRfqaWvZjmfE5qa-4hhD8_1789569710
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

ice_parse_cls_flower() stores the ip_proto key from the flow rule but
never programs a matching lookup unless the filter also matches on L4
ports or the L2TPv3 session ID. A filter like:

  tc filter add dev $pf ingress protocol ip flower skip_sw \
      ip_proto udp action drop

is silently programmed into the hardware as a match on eth_type ipv4
alone and drops every IPv4 packet, not just UDP.

Program the IP protocol match through the protocol field of the IPv4
header lookup and the next header field of the IPv6 header lookup, the
same lookups that are already used for ToS and TTL. The OS default and
comms DDP packages provide no profile that extracts the IPv6 next
header word, so the IPv6 rule programming currently fails with
"Required profiles not found" and the filter falls back to software
evaluation instead of over-matching, and the offload starts working
with a DDP package that can extract it. Note that the lookup matches
the next header byte of the base IPv6 header, so packets carrying
extension headers are not matched in hardware and fall back to
software evaluation, which under-matches only for skip_sw filters.

GTP tunnel and PPPoE filters rewrite the parsed ethertype, the IP
header lookups are not available there, so reject an unconsumed
ip_proto for them instead of silently widening the match. Filters where
ip_proto is implied by an L4 ports or L2TPv3 session ID lookup are not
affected. Based on an earlier unapplied patch from Michal Swiatkowski
that implemented the IPv4 part [1].

Link: https://lore.kernel.org/intel-wired-lan/20240222123956.2393-3-michal.swiatkowski@linux.intel.com/ [1]
Fixes: 0d08a441fb1a ("ice: ndo_setup_tc implementation for PF")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Petr Oros <poros@redhat.com>
---
v2:
- no code changes, collect Reviewed-by from Aleksandr Loktionov

v1: https://lore.kernel.org/all/20260910154824.3603687-2-poros@redhat.com/
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 37 +++++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_tc_lib.h |  1 +
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index d20357c0412731..fbd8cbad150a98 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -78,7 +78,8 @@ static int ice_tc_count_lkups(u32 flags, struct ice_tc_flower_fltr *fltr)
 		     ICE_TC_FLWR_FIELD_DEST_IPV6 | ICE_TC_FLWR_FIELD_SRC_IPV6))
 		lkups_cnt++;
 
-	if (flags & (ICE_TC_FLWR_FIELD_IP_TOS | ICE_TC_FLWR_FIELD_IP_TTL))
+	if (flags & (ICE_TC_FLWR_FIELD_IP_TOS | ICE_TC_FLWR_FIELD_IP_TTL |
+		     ICE_TC_FLWR_FIELD_IP_PROTO))
 		lkups_cnt++;
 
 	/* are L2TPv3 options specified? */
@@ -552,7 +553,8 @@ ice_tc_fill_rules(struct ice_hw *hw, u32 flags,
 	}
 
 	if (headers->l2_key.n_proto == htons(ETH_P_IP) &&
-	    (flags & (ICE_TC_FLWR_FIELD_IP_TOS | ICE_TC_FLWR_FIELD_IP_TTL))) {
+	    (flags & (ICE_TC_FLWR_FIELD_IP_TOS | ICE_TC_FLWR_FIELD_IP_TTL |
+		      ICE_TC_FLWR_FIELD_IP_PROTO))) {
 		list[i].type = ice_proto_type_from_ipv4(inner);
 
 		if (flags & ICE_TC_FLWR_FIELD_IP_TOS) {
@@ -567,11 +569,19 @@ ice_tc_fill_rules(struct ice_hw *hw, u32 flags,
 				headers->l3_mask.ttl;
 		}
 
+		if (flags & ICE_TC_FLWR_FIELD_IP_PROTO) {
+			list[i].h_u.ipv4_hdr.protocol =
+				headers->l3_key.ip_proto;
+			list[i].m_u.ipv4_hdr.protocol =
+				headers->l3_mask.ip_proto;
+		}
+
 		i++;
 	}
 
 	if (headers->l2_key.n_proto == htons(ETH_P_IPV6) &&
-	    (flags & (ICE_TC_FLWR_FIELD_IP_TOS | ICE_TC_FLWR_FIELD_IP_TTL))) {
+	    (flags & (ICE_TC_FLWR_FIELD_IP_TOS | ICE_TC_FLWR_FIELD_IP_TTL |
+		      ICE_TC_FLWR_FIELD_IP_PROTO))) {
 		struct ice_ipv6_hdr *hdr_h, *hdr_m;
 
 		hdr_h = &list[i].h_u.ipv6_hdr;
@@ -592,6 +602,11 @@ ice_tc_fill_rules(struct ice_hw *hw, u32 flags,
 			hdr_m->hop_limit = headers->l3_mask.ttl;
 		}
 
+		if (flags & ICE_TC_FLWR_FIELD_IP_PROTO) {
+			hdr_h->next_hdr = headers->l3_key.ip_proto;
+			hdr_m->next_hdr = headers->l3_mask.ip_proto;
+		}
+
 		i++;
 	}
 
@@ -1737,6 +1752,9 @@ ice_parse_cls_flower(struct net_device *filter_dev, struct ice_vsi *vsi,
 		headers->l2_key.n_proto = cpu_to_be16(n_proto_key);
 		headers->l2_mask.n_proto = cpu_to_be16(n_proto_mask);
 		headers->l3_key.ip_proto = match.key->ip_proto;
+		headers->l3_mask.ip_proto = match.mask->ip_proto;
+		if (match.mask->ip_proto)
+			fltr->flags |= ICE_TC_FLWR_FIELD_IP_PROTO;
 	}
 
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
@@ -1910,6 +1928,19 @@ ice_parse_cls_flower(struct net_device *filter_dev, struct ice_vsi *vsi,
 		}
 	}
 
+	if (fltr->flags & (ICE_TC_FLWR_FIELD_DEST_L4_PORT |
+			   ICE_TC_FLWR_FIELD_SRC_L4_PORT |
+			   ICE_TC_FLWR_FIELD_L2TPV3_SESSID))
+		fltr->flags &= ~ICE_TC_FLWR_FIELD_IP_PROTO;
+
+	if ((fltr->flags & ICE_TC_FLWR_FIELD_IP_PROTO) &&
+	    headers->l2_key.n_proto != htons(ETH_P_IP) &&
+	    headers->l2_key.n_proto != htons(ETH_P_IPV6)) {
+		NL_SET_ERR_MSG_MOD(fltr->extack,
+				   "IP protocol match is not supported with GTP or PPPoE");
+		return -EOPNOTSUPP;
+	}
+
 	/* Ingress filter on representor results in an egress filter in HW
 	 * and vice versa
 	 */
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.h b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
index 8a3ab2f22af9ba..752af65e70b7bf 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
@@ -38,6 +38,7 @@
 #define ICE_TC_FLWR_FIELD_CVLAN_PRIO		BIT(28)
 #define ICE_TC_FLWR_FIELD_VLAN_TPID		BIT(29)
 #define ICE_TC_FLWR_FIELD_PFCP_OPTS		BIT(30)
+#define ICE_TC_FLWR_FIELD_IP_PROTO		BIT(31)
 
 #define ICE_TC_FLOWER_MASK_32   0xFFFFFFFF
 
-- 
2.55.0

