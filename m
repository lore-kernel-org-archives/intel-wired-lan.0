Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDEAF8E4B0
	for <intel-wired-lan@archiver.kernel.org>; Fri, 17 Apr 2026 06:30:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 932C7608F8;
	Fri, 17 Apr 2026 06:30:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id us1ewpwH5J3f; Fri, 17 Apr 2026 06:30:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A7CCF60BFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776407403;
	bh=BAVdXEdc+kEMMK5GDr62Q5KNVz2Hir6sxQPRqGYxj9Y=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=5W34lU6xHjY/BatTxxKGNJWLfm1eS8FvolUK1FPj3bt9OWElIqdDSR2g433KzTbWJ
	 oOufaE64L46VHFF1Gr5S2oZcjNkRa0crtW0oA05RCea4UPl7oh/1pCsJ+liXiXkWOz
	 8b926CO+mTakFc+ZyX2DuvWON9168oYRV4Ec82pek/WNS0iZwlnmNu0r4naMcJzPPW
	 WLQn968KyZ4MOwkp2rVz9n48sIc00MAs0/JabKKdTKB0NSKWLvyXIhPt8TgsEb/KKe
	 hVDtaCtkhkcfYfIMX5PJBJxxsc9UMx9/pe3r0LhOdTzw7gGoNPc3AuTTvrulIo6HFm
	 w1IaffafvgjSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A7CCF60BFF;
	Fri, 17 Apr 2026 06:30:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 17091396
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Apr 2026 06:30:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 08D9040544
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Apr 2026 06:30:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GSC74mQyhk_W for <intel-wired-lan@lists.osuosl.org>;
 Fri, 17 Apr 2026 06:30:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B2C7640549
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B2C7640549
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B2C7640549
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Apr 2026 06:30:00 +0000 (UTC)
X-CSE-ConnectionGUID: rtnCPW+ZRUiP4wkuTNIRhw==
X-CSE-MsgGUID: 6UywVrfYSfC3jHdLxQZ+5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="94987403"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; d="scan'208";a="94987403"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2026 23:30:00 -0700
X-CSE-ConnectionGUID: JJmhOj7/RSKCkBkovQMohw==
X-CSE-MsgGUID: 9fOiDqdaTaKO+Dwy6EXiyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; d="scan'208";a="235329569"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa004.jf.intel.com with ESMTP; 16 Apr 2026 23:29:59 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Konrad Knitter <konrad.knitter@intel.com>
Date: Fri, 17 Apr 2026 08:29:52 +0200
Message-ID: <20260417062954.1241900-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260417062954.1241900-1-aleksandr.loktionov@intel.com>
References: <20260417062954.1241900-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776407400; x=1807943400;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=edbHUJHOaA58QasrhNxyc7+ghy9rcKSjYx+XG+RjX4w=;
 b=hQToS5VT11hTfTNul6njittgyjS3Xpar+CnhBKSMQ2Nxvvj8xruObX8F
 f0ffyjAS/ukLNjTGA7O+cZ5hjbGrhrRhY46znRkPYZqa3zeWCMX2/lnaG
 SRwjjZTClFiwQlz9JsadpKYC7GcJr+cR4ZPEHCK8Ivi3EHoAj+6wygdRr
 FSM84LWefREfan9I+GvvpHLvkVkKWFQyMy4unUJNhkV/WVxim/BU/QhjC
 iQA3dv6xeHqxQFeGnDVcn4/unCLzYRgpq9sVQydXecEeVXvK5X1wNNrK0
 m/rxqNhD09Kd1IorfSOPmtVBt/iwLmUYzOSGcoVbEUABbEM03WiqFQMaV
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=hQToS5VT
Subject: [Intel-wired-lan] [PATCH iwl-net 2/4] ice: fix autoneg disable when
 link partner doesn't support AN
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

From: Konrad Knitter <konrad.knitter@intel.com>

Disabling autonegotiation was silently ignored when autoneg had not yet
completed (ICE_AQ_AN_COMPLETED was not set), leaving the configuration
unchanged with no error. This could prevent link from forming if the
link partner requires non-autoneg mode.

Extend the condition to also allow disabling autoneg when the link
partner reports no AN ability (ICE_AQ_LP_AN_ABILITY clear). Gate the
ICE_AQ_LP_AN_ABILITY check on the link being up so that stale or
zeroed an_info when link is down does not produce a false positive.
Introduce the helper ice_autoneg_disable_allowed() to make the check
explicit.

Fixes: f1a4a66d2310 ("ice: fix set pause param autoneg check")
Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 26 ++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 30d2550..e41fc8d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2509,6 +2509,28 @@ ice_ksettings_find_adv_link_speed(const struct ethtool_link_ksettings *ks)
 	return adv_link_speed;
 }

+/**
+ * ice_autoneg_disable_allowed - check if autoneg can be disabled
+ * @p: port info
+ *
+ * Check if autonegotiation can be disabled based on link state.
+ * ICE_AQ_LP_AN_ABILITY is only valid when the link is up; gate that
+ * check accordingly to avoid false positives from stale link data.
+ *
+ * Return: true if autoneg has completed, or if the link is up and the
+ *         link partner does not advertise autonegotiation capability.
+ */
+static bool ice_autoneg_disable_allowed(struct ice_port_info *p)
+{
+	u8 an_info = p->phy.link_info.an_info;
+
+	if (an_info & ICE_AQ_AN_COMPLETED)
+		return true;
+	/* ICE_AQ_LP_AN_ABILITY is only valid when link is up */
+	return (p->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
+	       !(an_info & ICE_AQ_LP_AN_ABILITY);
+}
+
 /**
  * ice_setup_autoneg
  * @p: port info
@@ -2547,8 +2569,8 @@ ice_setup_autoneg(struct ice_port_info *p, struct ethtool_link_ksettings *ks,
 			}
 		}
 	} else {
-		/* If autoneg is currently enabled */
-		if (p->phy.link_info.an_info & ICE_AQ_AN_COMPLETED) {
+		/* If autoneg completed or link partner does not support AN */
+		if (ice_autoneg_disable_allowed(p)) {
 			/* If autoneg is supported 10GBASE_T is the only PHY
 			 * that can disable it, so otherwise return error
 			 */
--
2.52.0

