Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415C2CC6B08
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 14:44:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F020D40475;
	Tue, 13 Oct 2026 14:44:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZsxaiL8e4egO; Tue, 13 Oct 2026 14:44:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 44434404C1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791902681;
	b=XGtujqjsP20Y4SesmvkvwNVgzTxXbBdSwhUTJ3dUhY3K5jKmI8KyvyhK7bSTMduRuUUq
	 fCfJWa1W4MZ1kah7ayOhhozgrabhUDJhenFb0pkNy62UKv9CCDfJ9WICSpAKo914FtQXq
	 kggafHuoIt6IOiMN9rdWPn+1JUi31UfE/kmZUUYty1SJCgppvugr3/RvcdZiiotDKWPtp
	 M5e4w5Lyt/SM6bkAf6u1iTNllJlzxA2RwiQZdiv2rcW2QGy2DLlmlHH4LiIkbppIkiNCo
	 s+GGMpWZRxoTMgupIi08Zci02/hFRXBd0gC7nPJWtHBHfRFO8FITXVkUnzNcPZ4JFNw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791902681;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3vjixoyDnhnS/NYxFDav4HV71UX7tX+tVlaAMRQvVig=;
	b=YgrqMS5peduoC+0WSydetDx/n4yVmn/ZbBjUw+dMNAshfQNV6rr6+R1kQwCVBAEHk5Uu
	 w9KvQDxI2zgRza4NNeBotVKVhkFiewyOTtAfFxXhk9xb493nzk2efV4sekoxTNvpiOJT+
	 xvByz9KqkialkkuBH9rUMAzx0L3ui8Tk7PN96BecqQa/TPodiz8tUhfXWkZdrFlK9GDro
	 l64R2yqbQqyEVgZ/Pi2mGb20tVAxgDkL7m6tTjg9VSeo41cuY4yWqJ9xc7/SVUiQCxvR+
	 H1E/Q4TGqhhQEHeyc+Xn5lXxpOLw7BHba9Qq/jvJCTv4t+0QzjbNq311pJt9JkfvDRg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791902681;
	bh=3vjixoyDnhnS/NYxFDav4HV71UX7tX+tVlaAMRQvVig=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oUHEludyjTmKQ3OMt/YAsbeCf8e+g5U2s1dk8zM6gpBdiT88w1r60vtRJAoNEpwR0
	 uxbYROfWCUAhBL488lMjK8GadiDrofJDvkMx7CWJUL//UlEDLz4jA71T5kr0s8yp/0
	 +18bJJSw3T7m2tMepPEmMK7GuY0y+OdrihVLSGkATXauSHGjbGPd5CKDE/h8H7BOI1
	 DdXYwaPktUuXz7CxAbSSdDAM0Wic9TqO5h9EQ77e6OvCR+jpXPw878s4aKWYYa6Mfd
	 q6G0+dJ+5m4e+UK46SUJgh+VfZinKM9rpyNKuai2eSfdOzGsXDouSuTeS0J0fkvlci
	 EnDOf7Cb0xU7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 44434404C1;
	Tue, 13 Oct 2026 14:44:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8053C2E0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 14:44:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 71F606073F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 14:44:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J3gpchbBInTi for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 14:44:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A48FB6072B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791902678;
 b=PHeTXr3tSg2IuVY4P0A/YPrOUKFF+BaRi6nvllHC1LBFJcdX/lMUWRnSgnhBDr9BY7Bt
 53t/7W4ZDBZAtm6Cqk4JJT184VEjbDNgzYyOuJv05aHyeiihlTt/WSpaSKRDFFbHOp/xV
 oSyBTlk85MZjHmn254+mK/5t+cEp5fM09HMuZuQPzLKzQQafJzENsEdl73qv2QC0odzG8
 OU0IEjmvP8ptW3nsZHD+nZDEXNaeybFOy8pL6m8pdRMbGYv/4fg1MtB4C00phZGlmxFFH
 pQ2iVNQprsB9X0ZDUo+d8gPW38at3gCJSCHCiVCEAodg3hJBfVb3FQSR9txQJHPI3+w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791902678;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=3vjixoyDnhnS/NYxFDav4HV71UX7tX+tVlaAMRQvVig=;
 b=kfWqCHSlxOEsfJ7smLoGy06QC4E6AXZMgIoBXf9ewKbpJYQGD9WBFVDwFNaaEY1UEV0Y
 ikqbvyxcnx7WLkpIhlsspjm41Hf8EpSMBjkbleR4EOpEME+pL2iyG5M5iwYpI8mzX+qUj
 xSXpXpMLuReCIRHp6/sMiHHsDbbS2glUy88ZK7tYKy0EPseKcvzjMb/n2nTwSZbq5oNb1
 G/6AEaPDWWTOIUCFugmIkcj2cB2phlvkM8YnLdb/oJknhcEVTT5GFKY3ohDT0E8LD4Yx/
 mheDEAq01r+2f1oauQrwOpoMcRfP6Y0C3UuKkRjN/4jo02KpaVe3QpQXw3jNi7YucCA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=b0iAuyTh; 
 arc=none smtp.remote-ip=198.175.65.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=b0iAuyTh
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A48FB6072B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 14:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791902678; x=1823438678;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=cxtgDiaANgV3ctVMciuAZkfWIKukFPGrP9mNNsfbIbE=;
 b=b0iAuyThK/fVYR3nxkag91cBO5BcOjfrW5EcbT7kcAw2bCtge8eAtFjC
 1+tm+62BAXc8PYzYKYFqD8cwZRROElJVINWnYukcMVu2utsoI8RSn3Emy
 h1uDkmuxtHU+63rEPujb77NlUkI2JnSV7qNOkbKh7OVfr3M+QnPFvBe2b
 sSikJRjPHgyNP2h8ZjDPDeLA8eCsdluqZrNQwrN+ZjcudoZ+aHLwpaS9K
 iwUjM9rMF89dcZ9kZcN/tC9sLNMX5Dxx7hQ2+qBRuPDXrYtby778wr5Go
 dzkAOZSYnSVsy425+qeOXtJP6eEpmvu9IAivpYa3RGcoCTr9WST720ftn g==;
X-CSE-ConnectionGUID: /jhK9NxyTmmHzjUIhelNRA==
X-CSE-MsgGUID: kz9pyMT/QxmyutxTk2tPEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="623682"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="623682"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 07:44:37 -0700
X-CSE-ConnectionGUID: friQgNrMStmOFJATcA/BOg==
X-CSE-MsgGUID: 3++DS7UvS+q4ljm7SXfx7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1539048"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa006.fm.intel.com with ESMTP; 13 Oct 2026 07:44:37 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Subject: [PATCH iwl-net v2] ice: validate VF FDIR queue and queue region
 actions
Date: Tue, 13 Oct 2026 16:44:35 +0200
Message-ID: <20261013144435.1406126-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
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

ice_vc_fdir_parse_action() copies the VF-supplied queue index and, for
VIRTCHNL_ACTION_Q_REGION, the queue region size straight into the Flow
Director filter.  Both end up in the programming descriptor (QINDEX and
TO_Q), which the hardware interprets relative to the VF's VSI, so a VF
can steer matched packets to queues beyond its own range, i.e. queues
belonging to another VF or to the PF.

For VIRTCHNL_ACTION_QUEUE reject an index that is not below the VSI's
Rx queue count.

For VIRTCHNL_ACTION_Q_REGION the filter covers 2^region queues starting
at the index.  Reject a region that does not fit the 3-bit TO_Q field
(it would be silently truncated) and require the whole range to fit
within the VSI's Rx queues.  No alignment of the index is required for
this to hold: however the hardware combines the index with the hash
bits, no queue it selects from the region is at or above
index + 2^region.

Fixes: 0ce332fd62f6 ("ice: Add FDIR pattern action parser for VF")
Fixes: 346bf2504397 ("ice: Add new actions support for VF FDIR")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v1 -> v2:
 - also bound queue.region and require index + 2^region <= num_rxq for
   VIRTCHNL_ACTION_Q_REGION (Simon Horman / Sashiko)
 - reword commit message to describe the upstream code path
 - retarget to iwl-net

 drivers/net/ethernet/intel/ice/virt/fdir.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/virt/fdir.c b/drivers/net/ethernet/intel/ice/virt/fdir.c
index 4f1f344..4456f49 100644
--- a/drivers/net/ethernet/intel/ice/virt/fdir.c
+++ b/drivers/net/ethernet/intel/ice/virt/fdir.c
@@ -1152,6 +1152,7 @@ ice_vc_fdir_parse_action(struct ice_vf *vf, struct virtchnl_fdir_add *fltr,
 	struct virtchnl_filter_action_set *as = &fltr->rule_cfg.action_set;
 	struct device *dev = ice_pf_to_dev(vf->pf);
 	struct ice_fdir_fltr *input = &conf->input;
+	struct ice_vsi *vsi;
 	u32 dest_num = 0;
 	u32 mark_num = 0;
 	int i;
@@ -1162,6 +1163,10 @@ ice_vc_fdir_parse_action(struct ice_vf *vf, struct virtchnl_fdir_add *fltr,
 		return -EINVAL;
 	}
 
+	vsi = ice_get_vf_vsi(vf);
+	if (!vsi)
+		return -EINVAL;
+
 	for (i = 0; i < as->count; i++) {
 		struct virtchnl_filter_action *action = &as->actions[i];
 
@@ -1176,11 +1181,25 @@ ice_vc_fdir_parse_action(struct ice_vf *vf, struct virtchnl_fdir_add *fltr,
 			break;
 		case VIRTCHNL_ACTION_QUEUE:
 			dest_num++;
+			if (action->act_conf.queue.index >= vsi->num_rxq) {
+				dev_dbg(dev, "Invalid queue index %u for VF %d\n",
+					action->act_conf.queue.index, vf->vf_id);
+				return -EINVAL;
+			}
 			input->dest_ctl = ICE_FLTR_PRGM_DESC_DEST_DIRECT_PKT_QINDEX;
 			input->q_index = action->act_conf.queue.index;
 			break;
 		case VIRTCHNL_ACTION_Q_REGION:
 			dest_num++;
+			if (action->act_conf.queue.region >
+			    FIELD_MAX(ICE_FXD_FLTR_QW0_TO_Q_M) ||
+			    action->act_conf.queue.index +
+			    BIT(action->act_conf.queue.region) > vsi->num_rxq) {
+				dev_dbg(dev, "Invalid queue region %u/%u for VF %d\n",
+					action->act_conf.queue.index,
+					action->act_conf.queue.region, vf->vf_id);
+				return -EINVAL;
+			}
 			input->dest_ctl = ICE_FLTR_PRGM_DESC_DEST_DIRECT_PKT_QGROUP;
 			input->q_index = action->act_conf.queue.index;
 			input->q_region = action->act_conf.queue.region;
-- 
2.52.0

