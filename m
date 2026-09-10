Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C49C79FBF
	for <intel-wired-lan@archiver.kernel.org>; Thu, 10 Sep 2026 15:48:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD97760B89;
	Thu, 10 Sep 2026 15:48:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 127aDH3zCY9a; Thu, 10 Sep 2026 15:48:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E37EF60B8D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789055335;
	b=SFrLCX0KYvQdB6iYLPgulcBnNws7m1t3/Sv+H7BHIF3Onb2q690L33kjyTtxYSY4sQW9
	 h3jFZxA7dIhEi9nUFMGZO+K1Iit4ZobPx+cr5JVqkFXLTMHKqkGC5c1F6VzeGbhGjT5Vh
	 3sqXYRoXqHgRXFdTndQ+I0nPg/Dy3XLDQZmAk403ROvxGdF3m1/Ks+c7BtC2AHf5uCDAZ
	 5Fl0ZGn/l1wPXTTnFwSuUV0CR9kd0Z8EVAaqA6C6ZAfaK6lXGNO4/rf1qSfLJOplDVrSq
	 0D+FW4wsEB6h69CzZ6hGmwWzfez2FTzZ8aCIsBLMMxhmi965Eb41/LmI/0r3qZE1woA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789055335;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WAXlfc/tf1p3QsrX+UCCT6KufH9ClSZnpXl6HvO2Sbw=;
	b=Tc5IUa9pjuGNl81pgq0X+05ekst2nNb7lbKhcf5WkFYGV/x6WDV+aM4UpOoO2UIX0IrV
	 hHCOaPoUSlZ7jkScqYtVQ8UyRiT+1nJIrKYUR3ZgaaTTYMYNr6Mir93aWosj9ta8hGQz0
	 hHW8ITWuycAFKLAS9dCRRiO8MngPKxibm6jNek0I25Bof/URxKNikRwJwNWo93zlxfMxj
	 GZtTgU7L3rtijQoC3770L/bR7Md47kZGgsrcsYFXz2/iHgmxNcpVQkX9njRTO0QiEABOh
	 +IjB4BheWUBWi7eb4jX9KdA550LrXlZ0PFqsMXBd8x4QWSdEbm6A+PdgPmNTn+PW2yQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789055334;
	bh=WAXlfc/tf1p3QsrX+UCCT6KufH9ClSZnpXl6HvO2Sbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V6l1RRPBuScbGggjDpsOrxKnqa6FsnwnWBoKzXJFLSMTnfp+T5dxYQJa9EuecR0YB
	 dfRkEUG8wwzyIReHzt74q0vPBWQN+oa353EbFurGIi7W42cTgducNDoML/9dyW7N+5
	 TIDgDjzwxmwjwBiuoaYy7Ti9vWIE4K2zjcepuj089Sy+gUenlBensO8I/0l6U5GdiH
	 jJeUijdCvrMT2MSElcWcWYrqM6mCoD3V5/6q5v+GhnNyzpLIdtMLYem2/xYf4iIHXX
	 Q5kwvsqIz3fPrlNbP6zEGWonNTc7efyLinz1XPAW0joHTHsF/Zh4KgyfHxgkZRqE1i
	 HXYVOr7HlLI7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E37EF60B8D;
	Thu, 10 Sep 2026 15:48:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E29B0362
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 15:48:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D435A40B02
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 15:48:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qp14RYh64eo9 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 10 Sep 2026 15:48:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9258A40B01
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789055331;
 b=NhE8RYjjfSqNKk4mhJz7QyO69B9hAAQiiXjjlfTqlf5WF9VTAZxNe0vB+6vkSrWLPx4b
 86w9A0kdrq2DCzL6NhH7fvn/dP87wOoun+jdXxJMW090w7ilG5jGzd/lGIyuSEgwWYVtj
 IQJONT/90MMqzZoonfetHYcmfgeJkV3z9q9ejdArFsAStL8aajyc6XdeSj+goihl64rjP
 ysmES0S/V3LPbgRbcWNfk8grc965gFPquPix+2CzN9t3U6D9D4HlZUK7RtRm2XqmGXCss
 7a1dHrN6/YQ7CK7oY3pd40/nl/YUrCk1CKLnwnRaiC3yH9qqQuOCMQLfFhwpxOcFPYw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789055331;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=WAXlfc/tf1p3QsrX+UCCT6KufH9ClSZnpXl6HvO2Sbw=;
 b=a60soP7E53+jsBE5HhZB8yioHFH3agWwrSSliPlV7HX87sqv5Rh5Llzuy2H1AVK98tZV
 i0D/RFRUaGM2HhYBJXtORZUyWLl31vZ6iulBRtmJYpdAfTyerJj8IMX/FF3dmJ3v9hSC9
 tpURjZ4O4RG4yZ5LsBDWpjCAwP0gM99/VGAmRiWZXMsADzddA+W6njNpP/4Gn6hUjAmPL
 zUB83s89nbpIU5B0t2qLSIJjyTEkJ11+S3CeopnEOVDp7nNJAzJTsw/yRddlfqoYpjb81
 YT90siNxVRHPn3XJGh17KPPgKrDV+OQFeakh3SSwkkFbYr3yqKMk10Zj1JtnpaYY2pQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=YjfRnziu; 
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YjfRnziu
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9258A40B01
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 15:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789055329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WAXlfc/tf1p3QsrX+UCCT6KufH9ClSZnpXl6HvO2Sbw=;
 b=YjfRnziufy6/BzZzH/nRe6lHhxpD9y16QV/NpfHUSs/Bty5W2gYH4KZIT5SOSHHlSoWvZB
 GKLZtKZqNnEIYgNgrX4espkMV07GUPKBgiPsOOUlmfH/A+LFs3tu5EuWIsm43KBUlI96Nd
 Tn3P0O9fb+dRT5Gh2Et0LMN8YUjAu4c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-1o1SDbTBONCmACAp4nDEcA-1; Thu,
 10 Sep 2026 11:48:46 -0400
X-MC-Unique: 1o1SDbTBONCmACAp4nDEcA-1
X-Mimecast-MFC-AGG-ID: 1o1SDbTBONCmACAp4nDEcA_1789055324
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DD2B180059D; Thu, 10 Sep 2026 15:48:44 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.48.140])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 45360418; Thu, 10 Sep 2026 15:48:39 +0000 (UTC)
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
Subject: [PATCH iwl-next 1/2] ice: fix TC flower filters matching more than
 the ip_proto key
Date: Thu, 10 Sep 2026 17:48:23 +0200
Message-ID: <20260910154824.3603687-2-poros@redhat.com>
In-Reply-To: <20260910154824.3603687-1-poros@redhat.com>
References: <20260910154824.3603687-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: 2PffXv6ausd5Y0xWDPvgxcRg7lXKRx_BCFtfHKUD41U_1789055324
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
Signed-off-by: Petr Oros <poros@redhat.com>
---
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

