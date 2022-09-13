Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DA6C54EE9
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Sep 2022 13:38:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB36F80C68;
	Tue, 13 Sep 2022 13:38:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CB36F80C68
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1663076331;
	bh=LmzZoA0XJ5zp+uuVqkJka2LtokoaByW5UPB7KESLXdM=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=VXjXNhluQ3M5qXyXYLvYcvPlw39E1IeXHS8kbYYFgLluYQeAZWwEwbBJF92ZRC6Cq
	 WwTlW+9wPqdB529FeUzt9+LHt/MUhfYlmmlaloyw7aRMk1GBqZxBl0yALgCel+z9os
	 Cfd27LJWl5HuTd2YdwNekoH08dTY6voGyxVGhBl8C+B4nugDFYBr/7ALpe2bGU4k6j
	 lHIVEstdU9KAlnxc2mr8vsyq3xK2TdtJ6dK9Bmefb8xhKJj8cIu2eC06SJiGPpklvs
	 sycVIl5weZjWyxB1r0ww5e47d/9n0DZsZ8XRlNO2UKXmyfS5QQalfe/WE/jna+J7Wl
	 QDC9y+RH18xQw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d6S_Pcs2VeKm; Tue, 13 Sep 2022 13:38:51 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id D976880C83;
	Tue, 13 Sep 2022 13:38:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D976880C83
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 2F3D51BF2AB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Sep 2022 13:38:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 17D5040490
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Sep 2022 13:38:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 17D5040490
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5o1X5T6M96nZ for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Sep 2022 13:38:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 73A1A40982
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 73A1A40982
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Sep 2022 13:38:43 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="298141345"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; d="scan'208";a="298141345"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Sep 2022 06:38:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; d="scan'208";a="678569579"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmsmga008.fm.intel.com with ESMTP; 13 Sep 2022 06:38:42 -0700
From: Mateusz Palczewski <mateusz.palczewski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 13 Sep 2022 15:38:36 +0200
Message-Id: <20220913133836.48284-3-mateusz.palczewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913133836.48284-1-mateusz.palczewski@intel.com>
References: <20220913133836.48284-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1663076323; x=1694612323;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iSB71iFSJOxujpeKzatIAnwLFXDMtEePXwEIK8W1n9A=;
 b=TcDG0gxeA4FXmnWyhQOWQ/e3lcXWOL8RCd/AhCbMtLDVjVuXDtjpBSJg
 syafqiRpF7JEIxN8vV1dtqwxwPLivZzxHO8wGuXna6WcBLc+YfCCMD327
 44txC59QS7A6PEeRxYo1/Z943XPLqwN91dEXZObDgs6sqw4oRPaZl5iLO
 Z5GuZZxoH/FrfbZaBwjZYsYvnt0Z+XEWSf1S99Dz6uE1k8KJemb01voCu
 ka83JGzKrtZqDvf6Tt5MfFHHgOHp3hQEcCq2Qu1r0MLr3MgI9Y6xX6oo1
 +q5qoxflAo8QQbhD8Emz5ifcbB5HaQRAELfMcPKW3DiAjGHmSSlgAm2Sz
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=TcDG0gxe
Subject: [Intel-wired-lan] [PATCH net v2 2/2] i40e: Fix vf set max mtu size
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
Cc: Michal Jaron <michalx.jaron@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Michal Jaron <michalx.jaron@intel.com>

Max mtu sent to vf is set to 0 during memory allocation. It cause
that max mtu on VF is changed to IAVF_MAX_RXBUFFER and does not
depend on data from hw.

Set max_mtu field in virtchnl_vf_resource struct to inform
vf in GET_VF_RESOURCES msg what size should be max frame.

Fixes: dab86afdbbd1 ("i40e/i40evf: Change the way we limit the maximum frame size for Rx")
Signed-off-by: Michal Jaron <michalx.jaron@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 v2: Fixed one check regarding !max_frame
---
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 4f184c50f6e8..7e9f6a69eb10 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2038,6 +2038,25 @@ static void i40e_del_qch(struct i40e_vf *vf)
 	}
 }
 
+/**
+ * i40e_vc_get_max_frame_size
+ * @vf: pointer to the VF
+ *
+ * Max frame size is determined based on the current port's max frame size and
+ * whether a port VLAN is configured on this VF. The VF is not aware whether
+ * it's in a port VLAN so the PF needs to account for this in max frame size
+ * checks and sending the max frame size to the VF.
+ **/
+static u16 i40e_vc_get_max_frame_size(struct i40e_vf *vf)
+{
+	u16 max_frame_size = vf->pf->hw.phy.link_info.max_frame_size;
+
+	if (vf->port_vlan_id)
+		max_frame_size -= VLAN_HLEN;
+
+	return max_frame_size;
+}
+
 /**
  * i40e_vc_get_vf_resources_msg
  * @vf: pointer to the VF info
@@ -2139,6 +2158,7 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 	vfres->max_vectors = pf->hw.func_caps.num_msix_vectors_vf;
 	vfres->rss_key_size = I40E_HKEY_ARRAY_SIZE;
 	vfres->rss_lut_size = I40E_VF_HLUT_ARRAY_SIZE;
+	vfres->max_mtu = i40e_vc_get_max_frame_size(vf);
 
 	if (vf->lan_vsi_idx) {
 		vfres->vsi_res[0].vsi_id = vf->lan_vsi_id;
-- 
2.25.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
