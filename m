Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0988606A326
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Qx6tDXq1;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hiuAg5iP
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8FC3F60847;
	Tue,  3 Nov 2026 14:39:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n8UC0Ts2ZO8k; Tue,  3 Nov 2026 14:39:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BAF496083A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793716793;
	b=XmOb86N3oX4pNgWrxsJPP2d6pd4xRCJbeoxDAtXZB7yB372BZJ24kVZtwH6eL7bCLWj4
	 6dTJNTTNI5gff6/DwDcIuYheipNiG6yoTNqNZqnqq9P5Ki2BU+E3bCj7/LqhzfK34C1vk
	 aHlB888Oo8zNAbd3jYU0echgnqbatzF1Z7b+zT9xeAWZCAqtR0jNVUfizMTRbDolobD4z
	 tsetvL/JSE38FRwpL/G5m/pM/xhpphKpIgsDoQxzw+Tijueo45y6Iw6qZhAg/vNP2uUqM
	 hw4RSQkQ9lHwvl262HM7TsUCrPnMhqfgjVhaEj1QsohtSOhhkL9eq539IPNtuEAfWXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793716793;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zOFfHGv1oKAPKzpH3l+ZqRr3Q/KSmoXPTyv2QFeWXDY=;
	b=eNSxabpjadzoBFG462D96kXz5foMDzMdt4K3koDmgq8JtsZxJnYusKlIy7xmrPskgDfO
	 yt79dF21Ffsq+VvIxPl0ssATsBy2hZR/1evIyIVQpdfCiqpUyapQ626qvpc2wspzMflQa
	 Wd9yK7g2G2hrryE0jCxoDydGthbKux/Vv50asWh9TFmpBdonuS9GfRy2o/rmlScV7vC4E
	 MK8Ye7cSqVQ+2ngTpEiIrQvv0tXR17kpX1oQfSkZ09vC+qun1JKPID2DJAs5RrvuvXjUO
	 /LZNdfm7zf/cuLzwKcCC8HHAdXXgd2kdl/S3sjXLDu+e6bzKkfx0YChziCXyg3kEk6Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793716793;
	bh=zOFfHGv1oKAPKzpH3l+ZqRr3Q/KSmoXPTyv2QFeWXDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qx6tDXq1pcbt09RS9p1bjO+ZRCCzGnewXYujz4v0vh/rke2OaAme1brlSmZ/Su0lt
	 SRVA4JnLV6CzngvvnT2aqt0jK8YcPXXTLgNsq/lOBU/JNEgHM6FQKE9i+EXIAzfTTX
	 pvmdQChuz/ehSW90IHbc2GF0wXHcww2omI90c5wpbuvmhpq6l/ThiagQklW8KbQGR/
	 G8hvn2u8Dym27KDbBsB66za/sOykEZu+D/jjWW3cjUV52PJxcfVoVUAjSFY4TgS6Sn
	 hsd+HuqDnMPKNkRKiTtmI4lLFGXQ7SwYgb/MAQrauNKBoqPepiTX37XIgEX+by0mys
	 gDFww5e9LBUxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BAF496083A;
	Tue,  3 Nov 2026 14:39:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EEADF356
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:39:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EC39180FB9
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:39:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LKZKXvFoNVW1 for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 14:39:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 254AD8100D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793716791;
 b=qyuw+lRYabsvg27YxSwvrd8plfxguBJGMl/EsJNZKe1T2+cr1rbo9kQnllp+HGihopy4
 nK55/WvmkqFUdxl34wFwGtRieM9m2X171ww0Kf6Xd/kcuhLTjrKybQNPYAoP64l3vgxRN
 Qt5zGYNtJCiSWic9ln4BGkIkJ0Tw00Zdgh9ysPGgr0FyS7M3Ds45Msafmlc7AwgseZ3BF
 7H6OiCr9Wu1UcNBx+hoWumfdEUFZJ2zOg/FLUjeLAhpa9yhgViJpkVK6xBwBRa16Lhjay
 QITt6jrC6kDjn+OiG20lenS+JB5LGnOrUEsoOdAnPk8TTB3wLVqcgt+9gQsV4Jh0COw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793716791;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=zOFfHGv1oKAPKzpH3l+ZqRr3Q/KSmoXPTyv2QFeWXDY=;
 b=ghDUu65Owl4S8IhMfh7CpnJ6tlSxkE8hWeQe5Jg5m3D3zcBsXy0OBCJvnOwzvMnxGXXd
 H7GE3KWG7W9S0EeRoJL9P01y2jFaUfsBqOPg9/193+PD7hnjRLMreAM4sLhyuatUNsc2h
 dlArEqG82opicDihyW5NzrPINrvenIpWWZUEXU1OW73v9sARitkvhRKhtDw3fD9S464fX
 2OHxNEYbxycncP5ilTkjlVx6qDsP6uKn3tk3iuax3oR1nzU/sO08wK0OwrVf0CLy6ANi7
 iAHrEV2nwGj5OWTClq3bG0B4KDu6mQcR5E/zpbA+Mg5FwDWfJaN+CfdD8aPkv97YZvg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=hiuAg5iP; 
 arc=none smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=hiuAg5iP
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 254AD8100D
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793716791; x=1825252791;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DlaWBN9NMhq7QScxwJI/p54ObnWTuqBPVaehENFxK0s=;
 b=hiuAg5iPMR+2x9++tFghOTpYAqDYW4U4WyZfEhTKXqsHef2KpHe4Kv6F
 MJJR9m7lVFMJUbBsi831uSuale4JS5IjyYY4wGF0CatoNHBl+W1u6+fe1
 28i4kFw+8jilAQFtKVMu5bmkxja3zvWfkRAjVJgnxz5lwSezyTdVKLDTS
 8Pa//NLwRsi+6PEfWNoDH2WyhcR0r05S7UCa1rW/b+t92mguLE/bkzCfg
 kYV/h1vSPDubpAOy1jcVmXWGDsjRHKpgfX78smvazkdBxqBJ7AwNrKtH2
 8AhIeeaGvJe4q26tzybP7Tg44aCayzFz1zN6wkaCHvSmuhrZ1AdsxDmD6 w==;
X-CSE-ConnectionGUID: RFARNOc0TnGljIuW2M8SCw==
X-CSE-MsgGUID: lzAqlPOXTcqqwRAbfHw5pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2324011"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2324011"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 06:39:50 -0800
X-CSE-ConnectionGUID: ynvnUJhrQU6oss3N+z5CuA==
X-CSE-MsgGUID: be/1P5egStSVbxbJ6PXFlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="8289864"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa013.fm.intel.com with ESMTP; 03 Nov 2026 06:39:45 -0800
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 0D8BF312E9;
 Tue,  3 Nov 2026 14:39:43 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, Simon Horman <horms@kernel.org>,
 Michal Schmidt <mschmidt@redhat.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 bruce.richardson@intel.com,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 padraig.j.connolly@intel.com, ananth.s@intel.com,
 timothy.miskell@intel.com, Jacob Keller <jacob.e.keller@intel.com>,
 Lukasz Czapnik <lukasz.czapnik@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v4 04/15] ice: add helpers for Global RSS LUT alloc,
 free, vsi_update
Date: Tue,  3 Nov 2026 15:14:45 +0100
Message-ID: <20261103141646.303620-5-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103141646.303620-1-przemyslaw.kitszel@intel.com>
References: <20261103141646.303620-1-przemyslaw.kitszel@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add AQ commands for RSS Global LUT allocation and free operations.
The new functions are used by subsequent commits.

Add programming code for GLOBAL LUT ID of UPDATE VSI AQ,
do the same for RSS LUT "type", also for PF LUT in case of VF VSI.

Co-developed-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v2: fix whitespace (Sashiko)
---
 drivers/net/ethernet/intel/ice/ice.h          |  1 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_switch.h   |  2 +
 drivers/net/ethernet/intel/ice/ice_lib.c      | 28 +++++++++++--
 drivers/net/ethernet/intel/ice/ice_switch.c   | 41 +++++++++++++++++++
 5 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 432da05c48c0..89a2bdbecf60 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -367,6 +367,7 @@ struct ice_vsi {
 	u8 *rss_hkey_user;	/* User configured hash keys */
 	u8 *rss_lut_user;	/* User configured lookup table entries */
 	u8 rss_lut_type;	/* used to configure Get/Set RSS LUT AQ call */
+	u8 global_lut_id;       /* valid when lut_type == GLOBAL_LUT */
 
 	/* aRFS members only allocated for the PF VSI */
 #define ICE_MAX_ARFS_LIST	1024
diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 42878abac9eb..90c5587642d0 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -169,6 +169,7 @@ struct ice_aqc_set_port_params {
 #define ICE_AQC_RES_TYPE_VSI_LIST_PRUNE			0x04
 #define ICE_AQC_RES_TYPE_RECIPE				0x05
 #define ICE_AQC_RES_TYPE_SWID				0x07
+#define ICE_AQC_RES_TYPE_GLOBAL_RSS_HASH		0x20
 #define ICE_AQC_RES_TYPE_FDIR_COUNTER_BLOCK		0x21
 #define ICE_AQC_RES_TYPE_FDIR_GUARANTEED_ENTRIES	0x22
 #define ICE_AQC_RES_TYPE_FDIR_SHARED_ENTRIES		0x23
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.h b/drivers/net/ethernet/intel/ice/ice_switch.h
index 671d7a5f359f..99b593b68bd0 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.h
+++ b/drivers/net/ethernet/intel/ice/ice_switch.h
@@ -387,6 +387,8 @@ ice_rem_adv_rule_by_id(struct ice_hw *hw,
 		       struct ice_rule_query_data *remove_entry);
 
 int ice_init_def_sw_recp(struct ice_hw *hw);
+int ice_alloc_rss_global_lut(struct ice_hw *hw, u16 *global_lut_id);
+int ice_free_rss_global_lut(struct ice_hw *hw, u16 global_lut_id);
 u16 ice_get_hw_vsi_num(struct ice_hw *hw, u16 vsi_handle);
 
 int ice_replay_vsi_all_fltr(struct ice_hw *hw, u16 vsi_handle);
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 7cd2dd066ef5..8319956754b7 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1247,30 +1247,46 @@ static void ice_set_fd_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
 	ctxt->info.fd_report_opt = cpu_to_le16(val);
 }
 
+/* Translate @lut_type used in most of the places to the Admin Queue
+ * Q_OPT value for RSS.
+ * Used with VSI ADD and VSI UPDATE AQs (opcodes 0x0210, 0x0211).
+ */
+static u8 ice_lut_type_to_aq_qopt_rss_val(enum ice_lut_type lut_type)
+{
+	switch (lut_type) {
+	case ICE_LUT_PF:
+		return ICE_AQ_VSI_Q_OPT_RSS_LUT_PF;
+	case ICE_LUT_GLOBAL:
+		return ICE_AQ_VSI_Q_OPT_RSS_LUT_GBL;
+	case ICE_LUT_VSI:
+	default:
+		return ICE_AQ_VSI_Q_OPT_RSS_LUT_VSI;
+	}
+}
+
 /**
  * ice_set_rss_vsi_ctx - Set RSS VSI context before adding a VSI
  * @ctxt: the VSI context being set
  * @vsi: the VSI being configured
  */
 static void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
 {
 	u8 lut_type, hash_type;
+	u8 global_lut_id = 0;
 	struct device *dev;
 	struct ice_pf *pf;
 
 	pf = vsi->back;
 	dev = ice_pf_to_dev(pf);
 
 	switch (vsi->type) {
 	case ICE_VSI_CHNL:
-	case ICE_VSI_PF:
-		/* PF VSI will inherit RSS instance of PF */
 		lut_type = ICE_AQ_VSI_Q_OPT_RSS_LUT_PF;
 		break;
+	case ICE_VSI_PF:
 	case ICE_VSI_VF:
 	case ICE_VSI_SF:
-		/* VF VSI will gets a small RSS table which is a VSI LUT type */
-		lut_type = ICE_AQ_VSI_Q_OPT_RSS_LUT_VSI;
+		lut_type = ice_lut_type_to_aq_qopt_rss_val(vsi->rss_lut_type);
 		break;
 	default:
 		dev_dbg(dev, "Unsupported VSI type %s\n",
@@ -1281,8 +1297,12 @@ static void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
 	hash_type = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
 	vsi->rss_hfunc = hash_type;
 
+	if (vsi->rss_lut_type == ICE_LUT_GLOBAL)
+		global_lut_id = vsi->global_lut_id;
+
 	ctxt->info.q_opt_rss =
 		FIELD_PREP(ICE_AQ_VSI_Q_OPT_RSS_LUT_M, lut_type) |
+		FIELD_PREP(ICE_AQ_VSI_Q_OPT_RSS_GBL_LUT_M, global_lut_id) |
 		FIELD_PREP(ICE_AQ_VSI_Q_OPT_RSS_HASH_M, hash_type);
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 4daee252e2a6..e6f08fe9b5c2 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -1527,6 +1527,47 @@ ice_aq_get_sw_cfg(struct ice_hw *hw, struct ice_aqc_get_sw_cfg_resp_elem *buf,
 	return status;
 }
 
+/* Allocate a new Global LUT for the caller.
+ * LUT ID is returned via @global_lut_id.
+ */
+int ice_alloc_rss_global_lut(struct ice_hw *hw, u16 *global_lut_id)
+{
+	DEFINE_RAW_FLEX(struct ice_aqc_alloc_free_res_elem, buf, elem, 1);
+	u16 buf_len = __struct_size(buf);
+	int err;
+
+	buf->num_elems = cpu_to_le16(1);
+	buf->res_type = cpu_to_le16(ICE_AQC_RES_TYPE_GLOBAL_RSS_HASH);
+
+	err = ice_aq_alloc_free_res(hw, buf, buf_len, ice_aqc_opc_alloc_res);
+	if (err)
+		ice_debug(hw, ICE_DBG_RES, "Failed to allocate RSS global LUT, err %d\n",
+			  err);
+	else
+		*global_lut_id = le16_to_cpu(buf->elem[0].e.sw_resp);
+
+	return err;
+}
+
+/* Free Global LUT at @global_lut_id. */
+int ice_free_rss_global_lut(struct ice_hw *hw, u16 global_lut_id)
+{
+	DEFINE_RAW_FLEX(struct ice_aqc_alloc_free_res_elem, buf, elem, 1);
+	u16 buf_len = __struct_size(buf);
+	int err;
+
+	buf->num_elems = cpu_to_le16(1);
+	buf->res_type = cpu_to_le16(ICE_AQC_RES_TYPE_GLOBAL_RSS_HASH);
+	buf->elem[0].e.sw_resp = cpu_to_le16(global_lut_id);
+
+	err = ice_aq_alloc_free_res(hw, buf, buf_len, ice_aqc_opc_free_res);
+	if (err)
+		ice_debug(hw, ICE_DBG_RES, "Failed to free RSS global LUT %d, err %d\n",
+			  global_lut_id, err);
+
+	return err;
+}
+
 /**
  * ice_aq_add_vsi
  * @hw: pointer to the HW struct
-- 
2.54.0

