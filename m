Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E244BC27C79
	for <intel-wired-lan@archiver.kernel.org>; Fri, 14 Jun 2024 13:17:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5113481A33;
	Fri, 14 Jun 2024 13:17:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hkfdtkPAFPCL; Fri, 14 Jun 2024 13:17:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7E2FD81B8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1718371026;
	bh=xINZR6+1wd4hl5509vBJtmOYRUw0xWdVs1qJ/ZRKrZk=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=HNlsipHxgsgcZb6asm9yJJL8e+VjqyVWYyZ4+rL9vDcXV5yVkuf8ibxkqE95ljNv5
	 YTtMFLmFYoBd3MSvh2esnLZGOPCLn3Vo0QemsCXpcX1clKHKP1f+EV6Y6MlxjZ8c6N
	 pZntQUGykNf4BvRAQlWtVWfaWphFu4g92OoIoSC2LW+glpkObbDOC6AIw/UGVpQjWB
	 Wh5M5s99eVePQy2Nc/YJTYpEEcjjuTo0OvWrp3dwMq7k6Y7iTi45Gp9LrZ6XRFtMya
	 y6yBozU6LCmpLWIWIlXvDsGUSRxB2Awrvlgs0qubqaO0h3Y17M8rMrSXNtVLGyKs/M
	 ef3+3Jg4USlVw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E2FD81B8A;
	Fri, 14 Jun 2024 13:17:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 4CFE81BF976
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Jun 2024 13:17:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 386F8610D6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Jun 2024 13:17:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rECwW-q8qhlS for <intel-wired-lan@lists.osuosl.org>;
 Fri, 14 Jun 2024 13:17:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=ahmed.zaki@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DF1FE610CF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DF1FE610CF
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DF1FE610CF
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Jun 2024 13:17:03 +0000 (UTC)
X-CSE-ConnectionGUID: P6GPQRSIRF6NkV3ukwJirw==
X-CSE-MsgGUID: o2lUi94PSHakgFzROg8jOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="26673918"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; d="scan'208";a="26673918"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2024 06:16:58 -0700
X-CSE-ConnectionGUID: 8VFvpNsgRAyvPxtFDU8XQg==
X-CSE-MsgGUID: Ho35azoVTqicKZkZ8CW17A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; d="scan'208";a="71687052"
Received: from unknown (HELO azaki-desk1.intel.com) ([10.245.244.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2024 06:16:53 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Fri, 14 Jun 2024 07:18:42 -0600
Message-ID: <20240614131842.277398-1-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718371024; x=1749907024;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=vvhK7IRFIVJXTyKRo/6mCkuFIH1/XQhjzV6+mSnl6Zs=;
 b=H7YxiyDjU0hqUp9P8rOPiKLItNNgOpslpYWNqwbZwgD1kEy/R+Ud/IMW
 ipJ4PC01ILf1XBxlQNo09fvVHVbZmr1tQKfG3SB0L0+jBt4WmtnQ43rGh
 LA3nn3iTPYtAuon14a0/oqzUmUKGhRRkY1CacY8NuvJQ02vOh5nibgWeo
 bgrT7t3uHN0V0RoUwbvw7Q99UVXmU4HAXp744vftWkfnfegKCbIZYQkSR
 jXDSVmZByOQdFPd6tgTjTAjX8ko6iT30UCqkMOjHCGipLuDpgIYYA45kY
 pj+4lnpNDrB/zzqy9nNLYj4G+VvkidYJRet3WxZzHvoGkP6eOQMoatp4l
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=H7YxiyDj
Subject: [Intel-wired-lan] [PATCH iwl-next] ice: Add a per-VF limit on
 number of FDIR filters
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
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>, stable@vger.kernel.org,
 Sridhar Samudrala <sridhar.samudrala@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

While the iavf driver adds a s/w limit (128) on the number of FDIR
filters that the VF can request, a malicious VF driver can request more
than that and exhaust the resources for other VFs.

Add a similar limit in ice.

CC: stable@vger.kernel.org
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Suggested-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 .../net/ethernet/intel/ice/ice_ethtool_fdir.c    |  2 +-
 drivers/net/ethernet/intel/ice/ice_fdir.h        |  3 +++
 .../net/ethernet/intel/ice/ice_virtchnl_fdir.c   | 16 ++++++++++++++++
 .../net/ethernet/intel/ice/ice_virtchnl_fdir.h   |  1 +
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
index e3cab8e98f52..5412eff8ef23 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
@@ -534,7 +534,7 @@ ice_parse_rx_flow_user_data(struct ethtool_rx_flow_spec *fsp,
  *
  * Returns the number of available flow director filters to this VSI
  */
-static int ice_fdir_num_avail_fltr(struct ice_hw *hw, struct ice_vsi *vsi)
+int ice_fdir_num_avail_fltr(struct ice_hw *hw, struct ice_vsi *vsi)
 {
 	u16 vsi_num = ice_get_hw_vsi_num(hw, vsi->idx);
 	u16 num_guar;
diff --git a/drivers/net/ethernet/intel/ice/ice_fdir.h b/drivers/net/ethernet/intel/ice/ice_fdir.h
index 021ecbac7848..ab5b118daa2d 100644
--- a/drivers/net/ethernet/intel/ice/ice_fdir.h
+++ b/drivers/net/ethernet/intel/ice/ice_fdir.h
@@ -207,6 +207,8 @@ struct ice_fdir_base_pkt {
 	const u8 *tun_pkt;
 };
 
+struct ice_vsi;
+
 int ice_alloc_fd_res_cntr(struct ice_hw *hw, u16 *cntr_id);
 int ice_free_fd_res_cntr(struct ice_hw *hw, u16 cntr_id);
 int ice_alloc_fd_guar_item(struct ice_hw *hw, u16 *cntr_id, u16 num_fltr);
@@ -218,6 +220,7 @@ int
 ice_fdir_get_gen_prgm_pkt(struct ice_hw *hw, struct ice_fdir_fltr *input,
 			  u8 *pkt, bool frag, bool tun);
 int ice_get_fdir_cnt_all(struct ice_hw *hw);
+int ice_fdir_num_avail_fltr(struct ice_hw *hw, struct ice_vsi *vsi);
 bool ice_fdir_is_dup_fltr(struct ice_hw *hw, struct ice_fdir_fltr *input);
 bool ice_fdir_has_frag(enum ice_fltr_ptype flow);
 struct ice_fdir_fltr *
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
index b8df8d0b2d85..60bf71da53bd 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
@@ -550,6 +550,8 @@ static void ice_vc_fdir_reset_cnt_all(struct ice_vf_fdir *fdir)
 		fdir->fdir_fltr_cnt[flow][0] = 0;
 		fdir->fdir_fltr_cnt[flow][1] = 0;
 	}
+
+	fdir->fdir_fltr_cnt_total = 0;
 }
 
 /**
@@ -1694,6 +1696,7 @@ ice_vc_add_fdir_fltr_post(struct ice_vf *vf, struct ice_vf_fdir_ctx *ctx,
 	resp->status = status;
 	resp->flow_id = conf->flow_id;
 	vf->fdir.fdir_fltr_cnt[conf->input.flow_type][is_tun]++;
+	vf->fdir.fdir_fltr_cnt_total++;
 
 	ret = ice_vc_send_msg_to_vf(vf, ctx->v_opcode, v_ret,
 				    (u8 *)resp, len);
@@ -1758,6 +1761,7 @@ ice_vc_del_fdir_fltr_post(struct ice_vf *vf, struct ice_vf_fdir_ctx *ctx,
 	resp->status = status;
 	ice_vc_fdir_remove_entry(vf, conf, conf->flow_id);
 	vf->fdir.fdir_fltr_cnt[conf->input.flow_type][is_tun]--;
+	vf->fdir.fdir_fltr_cnt_total--;
 
 	ret = ice_vc_send_msg_to_vf(vf, ctx->v_opcode, v_ret,
 				    (u8 *)resp, len);
@@ -2074,6 +2078,7 @@ int ice_vc_add_fdir_fltr(struct ice_vf *vf, u8 *msg)
 	struct virtchnl_fdir_add *stat = NULL;
 	struct virtchnl_fdir_fltr_conf *conf;
 	enum virtchnl_status_code v_ret;
+	struct ice_vsi *vf_vsi;
 	struct device *dev;
 	struct ice_pf *pf;
 	int is_tun = 0;
@@ -2082,6 +2087,17 @@ int ice_vc_add_fdir_fltr(struct ice_vf *vf, u8 *msg)
 
 	pf = vf->pf;
 	dev = ice_pf_to_dev(pf);
+	vf_vsi = ice_get_vf_vsi(vf);
+
+#define ICE_VF_MAX_FDIR_FILTERS	128
+	if (!ice_fdir_num_avail_fltr(&pf->hw, vf_vsi) ||
+	    vf->fdir.fdir_fltr_cnt_total >= ICE_VF_MAX_FDIR_FILTERS) {
+		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+		dev_err(dev, "Max number of FDIR filters for VF %d is reached\n",
+			vf->vf_id);
+		goto err_exit;
+	}
+
 	ret = ice_vc_fdir_param_check(vf, fltr->vsi_id);
 	if (ret) {
 		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.h b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.h
index c5bcc8d7481c..ac6dcab454b4 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.h
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.h
@@ -29,6 +29,7 @@ struct ice_vf_fdir_ctx {
 struct ice_vf_fdir {
 	u16 fdir_fltr_cnt[ICE_FLTR_PTYPE_MAX][ICE_FD_HW_SEG_MAX];
 	int prof_entry_cnt[ICE_FLTR_PTYPE_MAX][ICE_FD_HW_SEG_MAX];
+	u16 fdir_fltr_cnt_total;
 	struct ice_fd_hw_prof **fdir_prof;
 
 	struct idr fdir_rule_idr;
-- 
2.43.0

