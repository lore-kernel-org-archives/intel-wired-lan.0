Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B419CA5FED
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 14:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DAEEB80897;
	Tue,  6 Oct 2026 14:33:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DllK9pZWULga; Tue,  6 Oct 2026 14:33:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 25E4480BA6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791297201;
	b=kYj4Zqhmtv4D7FZ2bTjYXsPDq1kzleYjqIGKMmdx9kLYMgGB6ekYpDUhVW33b4WHL0HF
	 CH/gE0QOIXAOnEEjcSubhxUsb9LbRECV5FhtmaCvcQO7RgpbTVgilmuWkh4/Xpb7EL2L4
	 97Xw1rgmJBdaDwGIgtIsNrFVhX1r8kqxn5bAdFgd/i+dZaB7u+OUfp8FQad8owBW2BgWJ
	 fR7FxAuk1tYcdeFckS0WmDSSoNXXeQw8NRskPbBIjOT4OxgPOgMKS2e+9Nq5qZFqbhcE9
	 xoZTOoKO7+aQBTcDBMe6G947liRWfAgR8kfkiPGbHgeAIJherP5zGg4VUXtVIe6Vcjg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791297201;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AHFkOPpF+G6KZJwqI0EqwiQJyJNHWGOhOdgicaH72n4=;
	b=HiccnmXLGIA0ZH+cQM40FyqgioHKXv/pDbFYkdDw0/ZT4b5tb7pZcS6szPtrGCdJOsp+
	 RC8PhcXI2p8fi1HhbTCB92BEIAQvzaIrBjWWh9thChSAkaHiEGHhYhHFGiQbw7AK/oa8T
	 GHDkqX3ooGQ8OE7TDdLleumyjdAu1NRN6uOsLVL9KiyGqJtvaDT2yw+vUv57UjhHWcV5T
	 jUCkfzw2QfkJVIQHZxr4c1K8XbDkRuuECj/gVioMB8tES0KteIoAoCufTvtwsCKj8RPmL
	 SV6PQoAjE53wrISDW7d6KvLpAct00aEHLkRfpiXBpNemFNRTL9c0jNDDvWk74AGx0IQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791297201;
	bh=AHFkOPpF+G6KZJwqI0EqwiQJyJNHWGOhOdgicaH72n4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EmoTD33+tc8+OfQXnDKhDG7suFBvX6t07Jb4n/eHmGIYF8Gv8+DHuJzO+FlR3s92k
	 NDzISsMRb+BMbwLcXCoJ0JE/dJ8P0hcoj0E/rUHPupqj7rKpgw8+p9XMHioakXyg39
	 z+pz8lVhmyZSfXlmIuc976nEBNWo+USFjDsDqCuY17pbltnAGV8UwJxGySs2Dh39Kt
	 wRwankEl74Nf6OwAN7/8sCcQom9xfdoWKJnwljSCSEeFM2gSqlAPk7pMhG0mZzLDXS
	 fIuPzYXrUtjdvNr3U2unZpO7nHq7Mf0oafej4TDkilxo7odoz/qToqsQFDiFTDgfTc
	 SEzkGefoUd60g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25E4480BA6;
	Tue,  6 Oct 2026 14:33:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 78C5F317
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:24:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6A90D607D8
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:24:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 85Nx85LHTtXS for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 14:24:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org ACFCC607CA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791296690;
 b=iyZrpVP9IK79lkv26g/bMRWkvDISukaQ4ShNy1LdfBggl1wv3d2IJMl/9f61kJZXnPX+
 axH7T5jFP/O6qMEezAJsbn739KnrdBad4CYDHvf62aH8yLsGRh8dbfR1lyDfKRAMDLo/y
 93VGn1UK/5GUUoqZYi+/21YYHdGwJ+EYpJT6o6jLbgp5SUkn5h1Zfunxwgzv9NC68Cg57
 oj/a8Qg52KMWRzC37XJy73fjgM0BZKR+iafcxtlNUWhnXB5+Keqvm9NqXgjDo/tl4nHQi
 xtVNbWZZzFcTo+sV0q0k2DnotwsROKn3jT3xA1oWo0sYlT6EB3saTMtKRSQPyUH4k6w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791296690;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=AHFkOPpF+G6KZJwqI0EqwiQJyJNHWGOhOdgicaH72n4=;
 b=FqNhFgtVpEEvG/FLgU5LxjyeM/5DQcS1LtV1Yv5Px8avS/4y2szTesOwS1AqGFIJupIe
 i/tTItydEaMjlNUhz4duRVgbDV2sIH2PkctMg75aC29rF5H5XuzHl11mQH3eRs/KQL88i
 4+CO7a+EmZOo/i6/bhWGY6b7SRN+tVZIXLfXixnrYRkfHnf8gigHF8q34t99jDgBx7gsM
 TTXlgLZ9ga4GSQpNQA1liRyhNzR8dfY7ki9acendk9+o7p0ziIpVAX1L/NlzrNSyEFNKF
 YDUmUwKiy/vVwC2a56dk3EHw7KWTVUGcrlPi7hZeJy5SNroWE7rWc1W6BJkofTDpy8w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=UwV2fTLq; 
 arc=none smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=UwV2fTLq
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ACFCC607CA
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791296691; x=1822832691;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=T+vhxn8/Dj0GuTrjC8Msz+q5/R6/kYtcIpRI4Q4C8OM=;
 b=UwV2fTLq4aKSUMhMdW6Vd8GTyKwUIYZ7WJZEp8PnnZcJCsIBxFmLTQyz
 DZqiAy892C70cQPCtZkiDMVSJmS5oj9bxz6ANW6JrUnliTKIxpfzn5ExA
 LWI/jmY0rGoSl0wZyeXToX5uMwr/UGD7lY3wEHu3ULZC9NE27Lk/n439f
 sm1fZjOHm65WACP6qnhHLuQqcwaQR+LMJBFZb5Vgjy1Vz72Y4sQRU8ZXm
 W2s3gBYGdNjBle1QNEz6mLDBQygauCRWnkpHFlWLNyndJZDxJHHxfbHuT
 11NWOedyCTDtovthSMH0bi1k2xEPYBqUhURrBrYQE3SWddjP2giQqseF7 Q==;
X-CSE-ConnectionGUID: wHKInpAGREWXvNuKziGSCQ==
X-CSE-MsgGUID: a5Y+dfCNTBmFCxjvRQhJpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="117507490"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="117507490"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 07:24:50 -0700
X-CSE-ConnectionGUID: vZLs4DlMRHm3Ay5UY5Exjg==
X-CSE-MsgGUID: mIbUImsFQ32xEcuRZGmd/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="305105870"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa001.fm.intel.com with ESMTP; 06 Oct 2026 07:24:49 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: Konrad Knitter <konrad.knitter@intel.com>
Subject: [PATCH iwl-net v4 2/3] ice: honor autoneg disable requests when link
 is down
Date: Tue,  6 Oct 2026 16:24:44 +0200
Message-ID: <20261006142445.2867917-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261006142445.2867917-1-aleksandr.loktionov@intel.com>
References: <20261006142445.2867917-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Konrad Knitter <konrad.knitter@intel.com>

The ethtool setter uses the link-partner AN ability bit to decide whether a
request to disable autonegotiation can be handled. That bit is valid only
while the link is up, so a link-down request skips the configuration update
and returns success.

Allow link-down requests through to PHY capability validation. On legacy
MACs, retain the existing restriction for PHYs that advertise autoneg.
Generic MACs configure Clause 37 through low_power_ctrl_an, and must keep
AUTO_LINK_UPDT set so firmware applies the change. Handle that field for
both enable and disable requests.

Fixes: 48cb27f2fd18 ("ice: Implement handlers for ethtool PHY/link operations")
Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
Changes since v3:
- Allow link-down disable requests without relying on stale partner state.
- Keep the generic-MAC enable bypass; validate E830 Autoneg support before
	restoring Clause 37 when its cached bit is clear.
- Avoid marking unchanged Clause 37 requests as autoneg changes.
- Correct the Fixes tag to the commit that introduced the ethtool handler.

 drivers/net/ethernet/intel/ice/ice_ethtool.c | 57 +++++++++++++++++++-
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 8b7d7be..080a65a 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2510,6 +2510,28 @@ ice_ksettings_find_adv_link_speed(const struct ethtool_link_ksettings *ks)
 	return adv_link_speed;
 }
 
+/**
+ * ice_autoneg_disable_allowed - check if autoneg can be disabled
+ * @p: port info
+ *
+ * Check if autonegotiation can be disabled based on link state.
+ * ICE_AQ_LP_AN_ABILITY is only valid when the link is up, so let the
+ * MAC-specific handling below decide whether a link-down request is supported.
+ *
+ * Return: true if autoneg has completed, the link is down, or the link
+ *         partner does not advertise autonegotiation capability.
+ */
+static bool ice_autoneg_disable_allowed(struct ice_port_info *p)
+{
+	u8 an_info = p->phy.link_info.an_info;
+
+	if (an_info & ICE_AQ_AN_COMPLETED)
+		return true;
+	/* ICE_AQ_LP_AN_ABILITY is only valid when link is up */
+	return !(p->phy.link_info.link_info & ICE_AQ_LINK_UP) ||
+	       !(an_info & ICE_AQ_LP_AN_ABILITY);
+}
+
 /**
  * ice_setup_autoneg
  * @p: port info
@@ -2535,12 +2557,31 @@ ice_setup_autoneg(struct ice_port_info *p, struct ethtool_link_ksettings *ks,
 	if (autoneg_enabled == AUTONEG_ENABLE) {
 		/* If autoneg was not already enabled */
 		if (!(p->phy.link_info.an_info & ICE_AQ_AN_COMPLETED)) {
+			if (ice_is_generic_mac(p->hw)) {
+				if (!(config->low_power_ctrl_an &
+				      ICE_AQC_PHY_AN_EN_CLAUSE37)) {
+					config->low_power_ctrl_an |=
+						ICE_AQC_PHY_AN_EN_CLAUSE37;
+					config->caps |=
+						ICE_AQ_PHY_ENA_AUTO_LINK_UPDT;
+					*autoneg_changed = 1;
+				}
+				return 0;
+			}
 			/* If autoneg is not supported, return error */
 			if (!ethtool_link_ksettings_test_link_mode(ks,
 								   supported,
 								   Autoneg)) {
 				netdev_info(netdev, "Autoneg not supported on this phy.\n");
 				err = -EINVAL;
+			} else if (p->hw->mac_type == ICE_MAC_E830) {
+				if (!(config->low_power_ctrl_an &
+				      ICE_AQC_PHY_AN_EN_CLAUSE37)) {
+					config->low_power_ctrl_an |=
+						ICE_AQC_PHY_AN_EN_CLAUSE37;
+					config->caps |= ICE_AQ_PHY_ENA_AUTO_LINK_UPDT;
+					*autoneg_changed = 1;
+				}
 			} else {
 				/* Autoneg is allowed to change */
 				config->caps |= ICE_AQ_PHY_ENA_AUTO_LINK_UPDT;
@@ -2548,8 +2589,20 @@ ice_setup_autoneg(struct ice_port_info *p, struct ethtool_link_ksettings *ks,
 			}
 		}
 	} else {
-		/* If autoneg is currently enabled */
-		if (p->phy.link_info.an_info & ICE_AQ_AN_COMPLETED) {
+		/* If autoneg completed or link partner does not support AN */
+		if (ice_autoneg_disable_allowed(p)) {
+			if (ice_is_generic_mac(p->hw) ||
+			    p->hw->mac_type == ICE_MAC_E830) {
+				if (config->low_power_ctrl_an &
+				    ICE_AQC_PHY_AN_EN_CLAUSE37) {
+					config->low_power_ctrl_an &=
+						~ICE_AQC_PHY_AN_EN_CLAUSE37;
+					config->caps |=
+						ICE_AQ_PHY_ENA_AUTO_LINK_UPDT;
+					*autoneg_changed = 1;
+				}
+				return 0;
+			}
 			/* If autoneg is supported 10GBASE_T is the only PHY
 			 * that can disable it, so otherwise return error
 			 */
-- 
2.52.0

