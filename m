Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C9AE99050
	for <intel-wired-lan@archiver.kernel.org>; Fri, 10 Apr 2026 07:49:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ABBF06089D;
	Fri, 10 Apr 2026 07:49:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lGYW84rd9hl5; Fri, 10 Apr 2026 07:49:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DB5A060889
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775807368;
	bh=nIxp1/gtrOVAXIRr01aQUATxNocT4ZeQMQQgF1/kJiw=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F6gR/qQw42FevO6KOYvupPg5gnEfdpnrnJUqixs20Za1e51/NNMJ2ISdVo+eb8Srj
	 4NPY/Gjn7UXmvS3gkeI4s/e5M7TPFw2zdyrbvbgZUjtH7PAgp3e8Szm6jQoQBOjIS0
	 PT4P9SsSgU16FdM6l3AeRyYUvS6Opx0e+nYY48uDozH7MtSqzRcnfnZLGL91XPsXkz
	 tR1a7BNZ7hcuTeDrUDptzzfoky+U4HetrPwibx8HYdnavWCUny3akCB4WvJbTjPEtB
	 bylaydosOMhuGEGgjMV9et8IlFjIuZd1IRnJmj/qKO9wpTJMalGpJzWXAWJ+kEtQd3
	 Di70MX30nDkdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB5A060889;
	Fri, 10 Apr 2026 07:49:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D4C81237
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 07:49:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B95DB816EE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 07:49:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qQ2Vyoybt-4j for <intel-wired-lan@lists.osuosl.org>;
 Fri, 10 Apr 2026 07:49:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0D1AE81E25
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0D1AE81E25
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0D1AE81E25
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 07:49:25 +0000 (UTC)
X-CSE-ConnectionGUID: XHl/Kqf+RSKfAGknk/mudg==
X-CSE-MsgGUID: 3c/XTvLsRBScsHhyBXHNGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="77007921"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="77007921"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 00:49:26 -0700
X-CSE-ConnectionGUID: NXkxgQrHRIWOeCDQHAq+QA==
X-CSE-MsgGUID: /rvw9uVTS4i3Q+0nyNpQbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="228941849"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa008.jf.intel.com with ESMTP; 10 Apr 2026 00:49:24 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Dave Ertman <david.m.ertman@intel.com>
Date: Fri, 10 Apr 2026 09:49:12 +0200
Message-ID: <20260410074921.1254213-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
References: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775807366; x=1807343366;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8mVlqUSKhLghunpKta0EtGrvQtVkNh/RcZcNL/hOjQ0=;
 b=CRcXG1al264lCIo3yohwbM/8Oe21Cko/wCzX+EPsDR2HW9LKIMOg5Hoc
 IK4P1GGHE+YCN6EAN14aTkJAzNgHy+FEVbItnchvJvdDrPhN5Nd0hlaWJ
 El7Kezv8XQ2cJAqgErg5ZIZOWL8HnOd2ct2aDU46XH3uOOVlDPfPElpwr
 Z2Iz7V2MLpqQzsNj68cS+H0w7SXiFm5lzY1PLFPTwLTFAtXTveAR6pbGE
 YgDAv9b1GvRhcamyF6mHiCv6cyPiSfMeX5ngYW36WgHHQ9DBRT/B/gxC2
 /fOw0VDKRXYz6xikF67VpN/HP00QFj0gQLg0L2vjTwv4DUMrtRfIGrZnR
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=CRcXG1al
Subject: [Intel-wired-lan] [PATCH iwl-next 1/10] ice: translate FW to SW for
 max num TCs encoding
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

From: Dave Ertman <david.m.ertman@intel.com>

The FW uses a 3-bit field in a TLV to represent the maximum number of
Traffic Classes supported per interface. Since the maximum value is 8,
and at least one TC must be supported, the encoding uses bit values of
000 to represent 8 TCs.

The driver currently does not translate this value and reports 0 max TCs
to the DCBNL interface instead of 8.

Add a translation when interfacing with the FW to use 0x0 as the value
for 8 max TCs.

Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb.c | 2 ++
 drivers/net/ethernet/intel/ice/ice_dcb.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb.c b/drivers/net/ethernet/intel/ice/ice_dcb.c
index 7be1fa7..f15c6fe 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb.c
@@ -221,6 +221,8 @@ ice_parse_ieee_etscfg_tlv(struct ice_lldp_org_tlv *tlv,
 	etscfg->willing = FIELD_GET(ICE_IEEE_ETS_WILLING_M, buf[0]);
 	etscfg->cbs = FIELD_GET(ICE_IEEE_ETS_CBS_M, buf[0]);
 	etscfg->maxtcs = FIELD_GET(ICE_IEEE_ETS_MAXTC_M, buf[0]);
+	if (etscfg->maxtcs == ICE_DCB_MAXTC_ENCODE)
+		etscfg->maxtcs = ICE_DCB_MAXTC;
 
 	/* Begin parsing at Priority Assignment Table (offset 1 in buf) */
 	ice_parse_ieee_ets_common_tlv(&buf[1], etscfg);
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb.h b/drivers/net/ethernet/intel/ice/ice_dcb.h
index da57497..285c5f6 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb.h
+++ b/drivers/net/ethernet/intel/ice/ice_dcb.h
@@ -109,6 +109,9 @@
 #define ICE_DSCP_TC_BW_TLV_LEN		25
 #define ICE_DSCP_PFC_TLV_LEN		6
 
+#define ICE_DCB_MAXTC			8
+#define ICE_DCB_MAXTC_ENCODE		0x0
+
 /* IEEE 802.1AB LLDP Organization specific TLV */
 struct ice_lldp_org_tlv {
 	__be16 typelen;
-- 
2.52.0
