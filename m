Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF02CC7619A
	for <intel-wired-lan@archiver.kernel.org>; Wed,  5 Apr 2023 08:10:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F71960AC9;
	Wed,  5 Apr 2023 08:10:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6F71960AC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1680682228;
	bh=T02UpROqwhRkvNzCBXN+UAKIdhGQNlDbPxV6VB8FHek=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=h8C1Qg6/R6g6M3o0nJwz593Df6s4woSzCrtnEQuOH9PaLxWKbNSeDCzSiE6VPEbAN
	 Y9IZ0uCDgk7UnhLukGx+RUWFbyajKXO00HiU8brCF3w5jpHi4yUfafM2IFHvHjTn7H
	 pbMEL5UHkeDF3PJitkyEFKJUm+kh1ujvqn2jVT9qbaKvvt60CFad3lig1RPQXcV1u7
	 9Rt6TgSsQBtH8XfmRJ5S4TuQ4ebfDX5dbkkCZ/s38bJ81Bxm/3gUHAjsE8b7I9WQBA
	 90IEMguR87dCp+DYb3y35i1udisb8eJ6HddL0o43683YbhEvDsPNRNBoyKNiFM8FnR
	 saIJZLrKCwrGQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jJmoHHzTD22j; Wed,  5 Apr 2023 08:10:27 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B92360EE0;
	Wed,  5 Apr 2023 08:10:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3B92360EE0
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 3B4D21C2A08
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Apr 2023 08:10:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 21E45405B9
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Apr 2023 08:10:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 21E45405B9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 58_r87ZA0BJJ for <intel-wired-lan@lists.osuosl.org>;
 Wed,  5 Apr 2023 08:10:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 789B5400DD
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 789B5400DD
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Apr 2023 08:10:14 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="428681522"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; d="scan'208";a="428681522"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Apr 2023 01:10:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="775961374"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; d="scan'208";a="775961374"
Received: from wasp.igk.intel.com ([10.102.20.192])
 by FMSMGA003.fm.intel.com with ESMTP; 05 Apr 2023 01:10:12 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Wed,  5 Apr 2023 09:51:12 +0200
Message-Id: <20230405075113.455662-5-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230405075113.455662-1-michal.swiatkowski@linux.intel.com>
References: <20230405075113.455662-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1680682214; x=1712218214;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=f9kZWSoj2+QokfXDMwh3Hc004hMjldoGCh4xjerbVDU=;
 b=Rwv9/MUVedMN0UHvhByss9VBlg73dg2qKBxDfOvDNaPL/tTFpqMZuDiA
 Td4rviPkf9jr9O8WHJMatsTDlHtmT+0qmvU675t95xxAUoLFObvg3epnZ
 Im9CglV26o5SX42YIT8TkWlx5KfQg4XUf57fWpyJ3+ZhX+a4AXpUW8XS/
 QysxkqDRZDIB3om6bv7/Zbd0wLvlIx4Is2Td9/bGDKOxM+dQiXcrJaGLC
 5kPkzBI74czym53KKjyXINzjUtJj1FDRjW+r7B3c78k5aFC0eckgrsHvx
 NFeF1ASx9uXAcA5NKixftLnv+32Z/2kFIeXD4GlTTuflECAfyfgd0J4eV
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Rwv9/MUV
Subject: [Intel-wired-lan] [PATCH net-next v3 4/5] ice: specify field names
 in ice_prot_ext init
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
Cc: pmenzel@molgen.mpg.de, netdev@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Anonymous initializers are now discouraged. Define ICE_PROTCOL_ENTRY
macro to rewrite anonymous initializers to named one. No functional
changes here.

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 68 +++++++++++----------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index b55cdb9a009f..8872e26d1368 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -4540,6 +4540,11 @@ ice_free_res_cntr(struct ice_hw *hw, u8 type, u8 alloc_shared, u16 num_items,
 	return status;
 }
 
+#define ICE_PROTOCOL_ENTRY(id, ...) {	\
+	.prot_type = id,		\
+	.offs	   = {__VA_ARGS__},	\
+}
+
 /* This is mapping table entry that maps every word within a given protocol
  * structure to the real byte offset as per the specification of that
  * protocol header.
@@ -4550,38 +4555,37 @@ ice_free_res_cntr(struct ice_hw *hw, u8 type, u8 alloc_shared, u16 num_items,
  * structure is added to that union.
  */
 static const struct ice_prot_ext_tbl_entry ice_prot_ext[ICE_PROTOCOL_LAST] = {
-	{ ICE_MAC_OFOS,		{ 0, 2, 4, 6, 8, 10, 12 } },
-	{ ICE_MAC_IL,		{ 0, 2, 4, 6, 8, 10, 12 } },
-	{ ICE_ETYPE_OL,		{ 0 } },
-	{ ICE_ETYPE_IL,		{ 0 } },
-	{ ICE_VLAN_OFOS,	{ 2, 0 } },
-	{ ICE_IPV4_OFOS,	{ 0, 2, 4, 6, 8, 10, 12, 14, 16, 18 } },
-	{ ICE_IPV4_IL,		{ 0, 2, 4, 6, 8, 10, 12, 14, 16, 18 } },
-	{ ICE_IPV6_OFOS,	{ 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24,
-				 26, 28, 30, 32, 34, 36, 38 } },
-	{ ICE_IPV6_IL,		{ 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24,
-				 26, 28, 30, 32, 34, 36, 38 } },
-	{ ICE_TCP_IL,		{ 0, 2 } },
-	{ ICE_UDP_OF,		{ 0, 2 } },
-	{ ICE_UDP_ILOS,		{ 0, 2 } },
-	{ ICE_VXLAN,		{ 8, 10, 12, 14 } },
-	{ ICE_GENEVE,		{ 8, 10, 12, 14 } },
-	{ ICE_NVGRE,		{ 0, 2, 4, 6 } },
-	{ ICE_GTP,		{ 8, 10, 12, 14, 16, 18, 20, 22 } },
-	{ ICE_GTP_NO_PAY,	{ 8, 10, 12, 14 } },
-	{ ICE_PPPOE,		{ 0, 2, 4, 6 } },
-	{ ICE_L2TPV3,		{ 0, 2, 4, 6, 8, 10 } },
-	{ ICE_VLAN_EX,          { 2, 0 } },
-	{ ICE_VLAN_IN,          { 2, 0 } },
-	{ ICE_HW_METADATA,	{ ICE_SOURCE_PORT_MDID_OFFSET,
-				  ICE_PTYPE_MDID_OFFSET,
-				  ICE_PACKET_LENGTH_MDID_OFFSET,
-				  ICE_SOURCE_VSI_MDID_OFFSET,
-				  ICE_PKT_VLAN_MDID_OFFSET,
-				  ICE_PKT_TUNNEL_MDID_OFFSET,
-				  ICE_PKT_TCP_MDID_OFFSET,
-				  ICE_PKT_ERROR_MDID_OFFSET,
-				}},
+	ICE_PROTOCOL_ENTRY(ICE_MAC_OFOS, 0, 2, 4, 6, 8, 10, 12),
+	ICE_PROTOCOL_ENTRY(ICE_MAC_IL, 0, 2, 4, 6, 8, 10, 12),
+	ICE_PROTOCOL_ENTRY(ICE_ETYPE_OL, 0),
+	ICE_PROTOCOL_ENTRY(ICE_ETYPE_IL, 0),
+	ICE_PROTOCOL_ENTRY(ICE_VLAN_OFOS, 2, 0),
+	ICE_PROTOCOL_ENTRY(ICE_IPV4_OFOS, 0, 2, 4, 6, 8, 10, 12, 14, 16, 18),
+	ICE_PROTOCOL_ENTRY(ICE_IPV4_IL,	0, 2, 4, 6, 8, 10, 12, 14, 16, 18),
+	ICE_PROTOCOL_ENTRY(ICE_IPV6_OFOS, 0, 2, 4, 6, 8, 10, 12, 14, 16, 18,
+			   20, 22, 24, 26, 28, 30, 32, 34, 36, 38),
+	ICE_PROTOCOL_ENTRY(ICE_IPV6_IL, 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20,
+			   22, 24, 26, 28, 30, 32, 34, 36, 38),
+	ICE_PROTOCOL_ENTRY(ICE_TCP_IL, 0, 2),
+	ICE_PROTOCOL_ENTRY(ICE_UDP_OF, 0, 2),
+	ICE_PROTOCOL_ENTRY(ICE_UDP_ILOS, 0, 2),
+	ICE_PROTOCOL_ENTRY(ICE_VXLAN, 8, 10, 12, 14),
+	ICE_PROTOCOL_ENTRY(ICE_GENEVE, 8, 10, 12, 14),
+	ICE_PROTOCOL_ENTRY(ICE_NVGRE, 0, 2, 4, 6),
+	ICE_PROTOCOL_ENTRY(ICE_GTP, 8, 10, 12, 14, 16, 18, 20, 22),
+	ICE_PROTOCOL_ENTRY(ICE_GTP_NO_PAY, 8, 10, 12, 14),
+	ICE_PROTOCOL_ENTRY(ICE_PPPOE, 0, 2, 4, 6),
+	ICE_PROTOCOL_ENTRY(ICE_L2TPV3, 0, 2, 4, 6, 8, 10),
+	ICE_PROTOCOL_ENTRY(ICE_VLAN_EX, 2, 0),
+	ICE_PROTOCOL_ENTRY(ICE_VLAN_IN, 2, 0),
+	ICE_PROTOCOL_ENTRY(ICE_HW_METADATA, ICE_SOURCE_PORT_MDID_OFFSET,
+			   ICE_PTYPE_MDID_OFFSET,
+			   ICE_PACKET_LENGTH_MDID_OFFSET,
+			   ICE_SOURCE_VSI_MDID_OFFSET,
+			   ICE_PKT_VLAN_MDID_OFFSET,
+			   ICE_PKT_TUNNEL_MDID_OFFSET,
+			   ICE_PKT_TCP_MDID_OFFSET,
+			   ICE_PKT_ERROR_MDID_OFFSET),
 };
 
 static struct ice_protocol_entry ice_prot_id_tbl[ICE_PROTOCOL_LAST] = {
-- 
2.39.2

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
