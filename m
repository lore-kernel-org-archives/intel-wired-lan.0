Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B16BC001B0
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Aug 2023 22:36:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B035611DF;
	Tue, 15 Aug 2023 22:36:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5B035611DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692138996;
	bh=jLJDFitQPiC/9RwojyBn5RD4sKxrBc2Qa+CBcA3lrBs=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=RIc9eVHRFt5ZR9jrlKb24gxCl7qdlCHIqKusiUIbCVCO/XxHUx9617On2yLdOsRYj
	 dU8sFth2eytOFlYoV8beDDuZwUwzNuO5S0luIUW4/iDKCMGPYV74eEzG8gzb9A1tRF
	 HLLzBnCgBh/IytQhD3zaBAj49fsaH0A0qd7pZ5zNF1xt95kmNijds7g2sIdNDX64w8
	 Gx15eeyrXqHkOZ6+dAkf7UBGawEJe8xg05JX3J+oV9NyirQn0iClv6MXXgMV7pHmjl
	 9lRkenzQ7X6EuGjw/lCIWqWIk22ZV6jEZdbreMOTEY7X0gEtVdOYa2RyytZKAlPb6Z
	 kLiUx/KMoMcYg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HTGPxtvNm7_p; Tue, 15 Aug 2023 22:36:34 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 139C0611C7;
	Tue, 15 Aug 2023 22:36:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 139C0611C7
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id AE9141BF47F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 22:36:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 13AA341499
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 22:36:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 13AA341499
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 96OlqOMEhS4s for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Aug 2023 22:35:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 595804149D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 22:35:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 595804149D
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="352718857"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; d="scan'208";a="352718857"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2023 15:35:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="710906007"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; d="scan'208";a="710906007"
Received: from jekeller-desk.amr.corp.intel.com (HELO
 jekeller-desk.jekeller.internal) ([10.166.241.1])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2023 15:35:56 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Date: Tue, 15 Aug 2023 15:35:51 -0700
Message-ID: <20230815223551.1238091-10-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0.1.g9857a21e0017.dirty
In-Reply-To: <20230815223551.1238091-1-jacob.e.keller@intel.com>
References: <20230815223551.1238091-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692138959; x=1723674959;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MKFpsnEAMO12UVWNR442QHxKlhZ8digcQnoMc/YOjKQ=;
 b=RWvXHX1rLJskB6z8zBJxD9buFvyoQI7LadBPAoAngR11eAUrYuRLzWa5
 mLPCetokOLuRs64venk0CJoYyH0jcu57PAsD9y6y/Qn6zhbgySMNucGnY
 F/Y8B8Up9PYgh7nd4adB/1g9chH3omX4K24sbxBlNvsugz39/lX/01zN1
 VAaanla3o+Ezbd1i+6QW4sR1laNWfa7xFgQEwKZdZeM5Bz3jq3PB+WER6
 or/ajSlf3kxO5RXCYEC13zc/vnwFyIQlOcWdMntXiIRe8XLvecONu8s5C
 vhzcJxx8FlTTrn1HHmHt/J/e/qeJVaQSyd/s1pA0f3UxZBCfZEt6kO6qI
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=RWvXHX1r
Subject: [Intel-wired-lan] [PATCH iwl-next 4/4] ice: check netlist before
 enabling ICE_F_GNSS
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
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Similar to the change made for ICE_F_SMA_CTRL, check the netlist before
enabling support for ICE_F_GNSS. This ensures that the driver only enables
the GNSS feature on devices which actually have the feature enabled in the
firmware device configuration.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  2 ++
 drivers/net/ethernet/intel/ice/ice_lib.c        |  7 +++----
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c     | 15 +++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h     |  1 +
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 82c4daf0a825..2f0d4bffe210 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1368,6 +1368,7 @@ struct ice_aqc_link_topo_params {
 #define ICE_AQC_LINK_TOPO_NODE_TYPE_MEZZ	7
 #define ICE_AQC_LINK_TOPO_NODE_TYPE_ID_EEPROM	8
 #define ICE_AQC_LINK_TOPO_NODE_TYPE_CLK_MUX	10
+#define ICE_AQC_LINK_TOPO_NODE_TYPE_GPS		11
 #define ICE_AQC_LINK_TOPO_NODE_CTX_S		4
 #define ICE_AQC_LINK_TOPO_NODE_CTX_M		\
 				(0xF << ICE_AQC_LINK_TOPO_NODE_CTX_S)
@@ -1407,6 +1408,7 @@ struct ice_aqc_get_link_topo {
 #define ICE_AQC_GET_LINK_TOPO_NODE_NR_PCA9575			0x21
 #define ICE_AQC_GET_LINK_TOPO_NODE_NR_C827			0x31
 #define ICE_ACQ_GET_LINK_TOPO_NODE_NR_GEN_CLK_MUX		0x47
+#define ICE_ACQ_GET_LINK_TOPO_NODE_NR_GEN_GPS			0x48
 	u8 rsvd[9];
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 4ac8998cb964..24a30b55c7ff 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3991,10 +3991,9 @@ void ice_init_feature_support(struct ice_pf *pf)
 			break;
 		if (ice_is_clock_mux_present_e810t(&pf->hw))
 			ice_set_feature_support(pf, ICE_F_SMA_CTRL);
-		if (ice_is_e810t(&pf->hw)) {
-			if (ice_gnss_is_gps_present(&pf->hw))
-				ice_set_feature_support(pf, ICE_F_GNSS);
-		}
+		if (ice_is_gps_present_e810t(&pf->hw) &&
+		    ice_gnss_is_gps_present(&pf->hw))
+			ice_set_feature_support(pf, ICE_F_GNSS);
 		break;
 	default:
 		break;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index bd3f32bfbc78..455d7a15de26 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -3034,6 +3034,21 @@ bool ice_is_clock_mux_present_e810t(struct ice_hw *hw)
 	return true;
 }
 
+/**
+ * ice_is_gps_present_e810t
+ * @hw: pointer to the hw struct
+ *
+ * Check if the GPS generic device is present in the netlist
+ */
+bool ice_is_gps_present_e810t(struct ice_hw *hw)
+{
+	if (ice_find_netlist_node(hw, ICE_AQC_LINK_TOPO_NODE_TYPE_GPS,
+				  ICE_ACQ_GET_LINK_TOPO_NODE_NR_GEN_GPS, NULL))
+		return false;
+
+	return true;
+}
+
 /**
  * ice_read_sma_ctrl_e810t
  * @hw: pointer to the hw struct
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 3768e7a01920..4399338b7347 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -196,6 +196,7 @@ int ice_phy_cfg_rx_offset_e822(struct ice_hw *hw, u8 port);
 
 /* E810 family functions */
 bool ice_is_clock_mux_present_e810t(struct ice_hw *hw);
+bool ice_is_gps_present_e810t(struct ice_hw *hw);
 int ice_ptp_init_phy_e810(struct ice_hw *hw);
 int ice_read_sma_ctrl_e810t(struct ice_hw *hw, u8 *data);
 int ice_write_sma_ctrl_e810t(struct ice_hw *hw, u8 data);
-- 
2.41.0.1.g9857a21e0017.dirty

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
