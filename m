Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EEC9C0015E
	for <intel-wired-lan@archiver.kernel.org>; Wed, 26 Jul 2023 18:28:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D40082D04;
	Wed, 26 Jul 2023 18:28:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9D40082D04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1690396090;
	bh=N8XHa2beWE5Co/cBUJrEMknUT5Q+AwS8JtZMGg9l0CM=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=KT6dwq7A+3OYh/BfAtFOTpE2yxgKgJQ8Rxd+Ja8KkePzhOjgGOWGtfuvM+Dsfefgv
	 jdY6IjomDoVj9/FlpGzbkCj/ICGv+mengcq4g24CQoFOBCjmfc4zr0yGIUaof+dlN+
	 TO///MmgFjF4MJIdKB+KiH6c5J9/OmbD+IvDFSE5lpCy+Nkzh9VPw3YcEW1KkjVHWP
	 Fl4ofPnot9CQ00hR/x7aq5sP5rpMO2NK2Z0ni6Js/3BORXc1fdF7GO+xVLfWIos9I/
	 sHo8L7LNPgtk7FJZ+poOjUAMt8bTIJ9fb/5ZcYUb2LPB2WGxivgJX96m4aTAa6rIKo
	 O6vUTclsTwc6Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s1fZ7eCPCJzZ; Wed, 26 Jul 2023 18:28:09 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id BDD0A833B7;
	Wed, 26 Jul 2023 18:28:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BDD0A833B7
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 68B121BF421
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Jul 2023 18:28:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8DC0141E44
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Jul 2023 18:27:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8DC0141E44
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HifFiWkIe8pr for <intel-wired-lan@lists.osuosl.org>;
 Wed, 26 Jul 2023 18:27:58 +0000 (UTC)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A0C0D41E45
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Jul 2023 18:27:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A0C0D41E45
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="358096579"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; d="scan'208";a="358096579"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jul 2023 11:27:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="796684724"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; d="scan'208";a="796684724"
Received: from jekeller-desk.amr.corp.intel.com (HELO
 jekeller-desk.jekeller.internal) ([10.166.241.1])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jul 2023 11:27:52 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Date: Wed, 26 Jul 2023 11:27:44 -0700
Message-ID: <20230726182745.1326754-3-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0.1.g9857a21e0017.dirty
In-Reply-To: <20230726182745.1326754-1-jacob.e.keller@intel.com>
References: <20230726182745.1326754-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690396078; x=1721932078;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RZcrFc2Fhg9o2H7gfHVTZcPv/nCBeseyKKol6kTkrcU=;
 b=ekQ+hNHJWDy/Fa83MikR6U74eLN7HGemY4kAca5NLx2E9qNBpd4saJOn
 +X+r74W40sRAg/nDcyFdUVEPKrTPkOZScPx6TAVgUQqePdhsZoMb0dhtX
 JiaKFKMwiQL8Z5W0BgHGZsNDkds2n7PuSkMsJZeMTrxTN9FatO/PlYeOw
 0N35RP2tGhDLWw+l4vzeQ+c9r/JHvCQ7Zc47Zld6TCZbyK0NinlCD+Oan
 XehKQMapxCrWg7SjQcjrLY+vvpPnuhIB8XfN3x855aH/ySecjdN6uT21E
 Y48LyfqEv1hhaFBUiwUkqe6DNv51Wtpm3HJlhj6cPi5j35QU1c+fT5KPM
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ekQ+hNHJ
Subject: [Intel-wired-lan] [PATCH iwl-next v2 2/3] ice: PTP: Rename macros
 used for PHY/QUAD port definitions
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
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Karol Kolacinski <karol.kolacinski@intel.com>

The ice_fill_phy_msg_e822 function uses several macros to specify the
correct address when sending a sideband message to the PHY block in
hardware.

The names of these macros are fairly generic and confusing. Future
development is going to extend the driver to support new hardware families
which have different relationships between PHY and QUAD. Rename the macros
for clarity and to indicate that they are E822 specific. This also matches
closer to the hardware specification in the data sheet.

Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c |  8 ++++----
 drivers/net/ethernet/intel/ice/ice_type.h   | 14 +++++++-------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 584e63f6b617..7a9bf3ea1750 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -168,9 +168,9 @@ ice_fill_phy_msg_e822(struct ice_sbq_msg_input *msg, u8 port, u16 offset)
 {
 	int phy_port, phy, quadtype;
 
-	phy_port = port % ICE_PORTS_PER_PHY;
-	phy = port / ICE_PORTS_PER_PHY;
-	quadtype = (port / ICE_PORTS_PER_QUAD) % ICE_NUM_QUAD_TYPE;
+	phy_port = port % ICE_PORTS_PER_PHY_E822;
+	phy = port / ICE_PORTS_PER_PHY_E822;
+	quadtype = (port / ICE_PORTS_PER_QUAD) % ICE_QUADS_PER_PHY_E822;
 
 	if (quadtype == 0) {
 		msg->msg_addr_low = P_Q0_L(P_0_BASE + offset, phy_port);
@@ -502,7 +502,7 @@ ice_fill_quad_msg_e822(struct ice_sbq_msg_input *msg, u8 quad, u16 offset)
 
 	msg->dest_dev = rmn_0;
 
-	if ((quad % ICE_NUM_QUAD_TYPE) == 0)
+	if ((quad % ICE_QUADS_PER_PHY_E822) == 0)
 		addr = Q_0_BASE + offset;
 	else
 		addr = Q_1_BASE + offset;
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 86165d388f34..a5429eca4350 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -909,13 +909,13 @@ struct ice_hw {
 	/* INTRL granularity in 1 us */
 	u8 intrl_gran;
 
-#define ICE_PHY_PER_NAC		1
-#define ICE_MAX_QUAD		2
-#define ICE_NUM_QUAD_TYPE	2
-#define ICE_PORTS_PER_QUAD	4
-#define ICE_PHY_0_LAST_QUAD	1
-#define ICE_PORTS_PER_PHY	8
-#define ICE_NUM_EXTERNAL_PORTS		ICE_PORTS_PER_PHY
+#define ICE_PHY_PER_NAC_E822		1
+#define ICE_MAX_QUAD			2
+#define ICE_QUADS_PER_PHY_E822		2
+#define ICE_PORTS_PER_PHY_E822		8
+#define ICE_PORTS_PER_QUAD		4
+#define ICE_PORTS_PER_PHY_E810		4
+#define ICE_NUM_EXTERNAL_PORTS		(ICE_MAX_QUAD * ICE_PORTS_PER_QUAD)
 
 	/* Active package version (currently active) */
 	struct ice_pkg_ver active_pkg_ver;
-- 
2.41.0.1.g9857a21e0017.dirty

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
