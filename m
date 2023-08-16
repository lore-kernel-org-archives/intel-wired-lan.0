Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B19BC2FC06
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Aug 2023 00:12:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DE174401C9;
	Thu, 17 Aug 2023 00:12:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DE174401C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692231123;
	bh=75pqvD5Wb7FGCs2KmBXwS8SDZhj9AkuIAVaFRijeddE=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=iNWnSNl56vzxNEpj7cvsyCDr+fO8X8Oh/jVwkbPCOKOx8rvkbX4NlwbrnbKW8aFqG
	 B9iL+CxaYix+zgNMvnVeAsq8nVBliPyuOyZSGgw/8YKoIHHrjCqhykkorZ1vLp1wUJ
	 q8dW79jRv4F4uBDXJc1SjaSUGEEhUU8gPZVske0TGref0QI65c4rESnQGxCbICr065
	 M0/APuGjuPMQ3y3vLEjSig9tDPUd2gfGsa9J+ZWoUhNwgAiW6Ewt8OcxYnbJluw0uC
	 kCdO7+wXNlZI75yn72ZCQWuq5zuBv7mr8+jgliMVfpV+eFEOgLH/PzWPRS7cDIK7M5
	 Vxdvx//9DU4hg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VZhlkzhhxSOj; Thu, 17 Aug 2023 00:12:03 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id E90DA41781;
	Thu, 17 Aug 2023 00:12:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E90DA41781
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 2E6561BF390
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Aug 2023 00:12:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 13A1461429
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Aug 2023 00:12:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 13A1461429
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EkH8BXUgnqcd for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Aug 2023 00:12:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4FECF61420
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Aug 2023 00:12:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4FECF61420
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="371570652"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; d="scan'208";a="371570652"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2023 17:04:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="824422140"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; d="scan'208";a="824422140"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.244.168])
 by FMSMGA003.fm.intel.com with ESMTP; 16 Aug 2023 17:04:52 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Wed, 16 Aug 2023 16:57:16 -0700
Message-Id: <20230816235719.1120726-5-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816235719.1120726-1-paul.greenwalt@intel.com>
References: <20230816235719.1120726-1-paul.greenwalt@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692231120; x=1723767120;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PJHQJXNTEmQY/gNUbbB6CO7+7E2GDRCDC6ex15O9rhk=;
 b=HrFPOtIu8M/qwn/tEhySP5+1DyjTXnmZEShPR8SkTlmtikZc7e1Ng+um
 CARjgEzGJ82wqbmYTLC/XTOoX/TI7RG35C7UC2xmiEHuR+6gpuJ+kxjYj
 sk4izZRylWLoDgMMy541vhTNeqlpEaW4fjR4l4jVr0gW6lFBa9wGrK/Kg
 Wi1BzCqZ3g3JQJwicSw8zYWaePA7ri8wMu26QOQEg86faXnUkjY2xxYZ3
 K/YzPtyi6B+MKBF9z5aXVy1lot5YAav6r6G8Ibqx0EAlf7DL9xDo4MDD/
 +ORvdOj2LZlqIPYDHQ0gFgu9epYgH/TIj+4VYMLUirUdcg38I+if826Hq
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=HrFPOtIu
Subject: [Intel-wired-lan] [PATCH iwl-next 4/7] ice: Add
 ice_get_link_status_datalen
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
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The Get Link Status data length can vary with different versions of
ice_aqc_get_link_status_data. Add ice_get_link_status_datalen() to return
datalen for the specific ice_aqc_get_link_status_data version.
Add new link partner fields to ice_aqc_get_link_status_data; PHY type,
FEC, and flow control.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Co-developed-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 37 +++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_common.c   | 22 ++++++++++-
 2 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index d28c610b004d..9ec96478ed44 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1329,10 +1329,39 @@ struct ice_aqc_get_link_status_data {
 #define ICE_AQ_LINK_SPEED_100GB		BIT(10)
 #define ICE_AQ_LINK_SPEED_200GB		BIT(11)
 #define ICE_AQ_LINK_SPEED_UNKNOWN	BIT(15)
-	__le32 reserved3; /* Aligns next field to 8-byte boundary */
-	__le64 phy_type_low; /* Use values from ICE_PHY_TYPE_LOW_* */
-	__le64 phy_type_high; /* Use values from ICE_PHY_TYPE_HIGH_* */
-};
+	/* Aligns next field to 8-byte boundary */
+	__le16 reserved3;
+	u8 ext_fec_status;
+	/* RS 272 FEC enabled */
+#define ICE_AQ_LINK_RS_272_FEC_EN      BIT(0)
+	u8 reserved4;
+	/* Use values from ICE_PHY_TYPE_LOW_* */
+	__le64 phy_type_low;
+	/* Use values from ICE_PHY_TYPE_HIGH_* */
+	__le64 phy_type_high;
+#define ICE_AQC_LS_DATA_SIZE_V1 \
+	offsetofend(struct ice_aqc_get_link_status_data, phy_type_high)
+	/* Get link status v2 link partner data */
+	__le64 lp_phy_type_low;
+	__le64 lp_phy_type_high;
+	u8 lp_fec_adv;
+#define ICE_AQ_LINK_LP_10G_KR_FEC_CAP  BIT(0)
+#define ICE_AQ_LINK_LP_25G_KR_FEC_CAP  BIT(1)
+#define ICE_AQ_LINK_LP_RS_528_FEC_CAP  BIT(2)
+#define ICE_AQ_LINK_LP_50G_KR_272_FEC_CAP BIT(3)
+#define ICE_AQ_LINK_LP_100G_KR_272_FEC_CAP BIT(4)
+#define ICE_AQ_LINK_LP_200G_KR_272_FEC_CAP BIT(5)
+	u8 lp_fec_req;
+#define ICE_AQ_LINK_LP_10G_KR_FEC_REQ  BIT(0)
+#define ICE_AQ_LINK_LP_25G_KR_FEC_REQ  BIT(1)
+#define ICE_AQ_LINK_LP_RS_528_FEC_REQ  BIT(2)
+#define ICE_AQ_LINK_LP_KR_272_FEC_REQ  BIT(3)
+	u8 lp_flowcontrol;
+#define ICE_AQ_LINK_LP_PAUSE_ADV       BIT(0)
+#define ICE_AQ_LINK_LP_ASM_DIR_ADV     BIT(1)
+#define ICE_AQC_LS_DATA_SIZE_V2 \
+	offsetofend(struct ice_aqc_get_link_status_data, lp_flowcontrol)
+} __packed;
 
 /* Set event mask command (direct 0x0613) */
 struct ice_aqc_set_event_mask {
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 7992eaab94fe..df4aa921aa9d 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -576,6 +576,24 @@ static enum ice_media_type ice_get_media_type(struct ice_port_info *pi)
 	return ICE_MEDIA_UNKNOWN;
 }
 
+/**
+ * ice_get_link_status_datalen
+ * @hw: pointer to the HW struct
+ *
+ * Returns datalength for the Get Link Status AQ command, which is bigger for
+ * newer adapter families handled by ice driver.
+ */
+static u16 ice_get_link_status_datalen(struct ice_hw *hw)
+{
+	switch (hw->mac_type) {
+	case ICE_MAC_E830:
+		return ICE_AQC_LS_DATA_SIZE_V2;
+	case ICE_MAC_E810:
+	default:
+		return ICE_AQC_LS_DATA_SIZE_V1;
+	}
+}
+
 /**
  * ice_aq_get_link_info
  * @pi: port information structure
@@ -614,8 +632,8 @@ ice_aq_get_link_info(struct ice_port_info *pi, bool ena_lse,
 	resp->cmd_flags = cpu_to_le16(cmd_flags);
 	resp->lport_num = pi->lport;
 
-	status = ice_aq_send_cmd(hw, &desc, &link_data, sizeof(link_data), cd);
-
+	status = ice_aq_send_cmd(hw, &desc, &link_data,
+				 ice_get_link_status_datalen(hw), cd);
 	if (status)
 		return status;
 
-- 
2.39.2

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
