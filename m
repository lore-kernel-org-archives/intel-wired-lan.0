Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACAEE98FD2
	for <intel-wired-lan@archiver.kernel.org>; Thu,  9 Apr 2026 13:00:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BEC4440B5A;
	Thu,  9 Apr 2026 13:00:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fy2EnIhmZhbi; Thu,  9 Apr 2026 13:00:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A404D41065
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775739632;
	bh=LXLM1vLl074uX1RRoOHmrOOgQQQHC6E1pQlOjkEvwp0=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KSBn/7rEK5IB4bpqkA/wShpfeVI0kIwOCTi+bwd6Z6MAHEZhwIUqnnqrjW3fVOmIc
	 EebiZddZbsB7S8QAqo35KKhqxGRLR82PsWse7qet7zx+nJ3NWeqh/lx0CsWls8iuly
	 CQYBWfrXEmX0k0Bx9DLzq8pw4HfHFU/qeTlU+TsUqVFhN/SbJPFdPqxNxxMqi6/5hr
	 KrQ/36WwwT80dnmpgnxXePfelahRNLDnoZjSwuie43Lj34Q/xOXWGDTBUXO3xu5aDM
	 O0wxLh8JEB7k7ofM0MA4wxGXf6Ick4nf9TsioP8ijfWY1VsOTsPc8Wvn/ATH0RaERO
	 VpbG/uJSH+vow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A404D41065;
	Thu,  9 Apr 2026 13:00:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D83461F6
 for <intel-wired-lan@lists.osuosl.org>; Thu,  9 Apr 2026 13:00:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D4AAF40127
 for <intel-wired-lan@lists.osuosl.org>; Thu,  9 Apr 2026 13:00:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wv7tjozVtVJJ for <intel-wired-lan@lists.osuosl.org>;
 Thu,  9 Apr 2026 13:00:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=marcin.szycik@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CDE31400F6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CDE31400F6
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CDE31400F6
 for <intel-wired-lan@lists.osuosl.org>; Thu,  9 Apr 2026 13:00:27 +0000 (UTC)
X-CSE-ConnectionGUID: hfp6j3wRQwqaKbyWqjOTUw==
X-CSE-MsgGUID: 1ymKjJmGSL6+MKCzt/rQGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="75777526"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="75777526"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 06:00:18 -0700
X-CSE-ConnectionGUID: 36SONYIFQQGixnFsTayVkQ==
X-CSE-MsgGUID: R2QTIDzeSCyXuiGqqOje3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="259208113"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orviesa002.jf.intel.com with ESMTP; 09 Apr 2026 06:00:16 -0700
Received: from gond.igk.intel.com (gond.igk.intel.com [10.123.220.52])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id A5B2B2FC58;
 Thu,  9 Apr 2026 14:00:15 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, sandeep.penigalapati@intel.com, ananth.s@intel.com,
 alexander.duyck@gmail.com, Marcin Szycik <marcin.szycik@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Date: Thu,  9 Apr 2026 13:59:59 +0200
Message-ID: <20260409120003.2719-7-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260409120003.2719-1-marcin.szycik@linux.intel.com>
References: <20260409120003.2719-1-marcin.szycik@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775739628; x=1807275628;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bBbnnIzfb8m+qy0omERvBIWpootbQKRVNSRImW14udE=;
 b=ntV6S3AhjS+IFI9cUdeHRO2vN2TWVZf5l9jcEXmUlAQ4Bmr8dEvBm9o3
 HPSlH/2Qmr7JdNoAcBiKg662315f7BM00IL6NrYFaI4MYMxVTOfdW1vIA
 RMWz/9/F1yRR6dPdqsFiDYOWzyYkb4wL3XPm1eBPyUlahmuaYX77Mra8D
 HvdxdoVXOggnoDLdIzQopYhhtlYiEMhOnrpqKOad7tuR/GdyYkaqa3CNv
 XrfHn3qi93NSmWWJFAsqiNviLSO4t9zcRldQH04aWvBawVWMzooKbzGQG
 +hCWX5XyElEYVF3ihsFFxSZJSN/4Z1AzAE1LWUz/lCP7R7PJ2YTNxNw7f
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ntV6S3Ah
Subject: [Intel-wired-lan] [PATCH iwl-next v2 06/10] ice: use plain
 alloc/dealloc for ice_ntuple_fltr
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

Change struct ice_ntuple_fltr allocation from devm_ to plain alloc,
since its lifetime is not tied to the device. All such objects are being
removed on device remove via ice_deinit_features() -> ice_deinit_fdir()
-> ice_vsi_manage_fdir() -> ice_fdir_del_all_fltrs()

Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v2:
* Add this patch
---
 drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
index eca15cb2665e..b5a841732b58 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
@@ -1748,7 +1748,7 @@ void ice_fdir_del_all_fltrs(struct ice_vsi *vsi)
 		ice_fdir_update_cntrs(hw, f_rule->flow_type, f_rule->acl_fltr,
 				      false);
 		list_del(&f_rule->fltr_node);
-		devm_kfree(ice_pf_to_dev(pf), f_rule);
+		kfree(f_rule);
 	}
 }
 
@@ -1855,7 +1855,7 @@ ice_ntuple_update_list_entry(struct ice_pf *pf, struct ice_ntuple_fltr *input,
 			 */
 			ice_fdir_do_rem_flow(pf, old_fltr->flow_type);
 		list_del(&old_fltr->fltr_node);
-		devm_kfree(ice_hw_to_dev(hw), old_fltr);
+		kfree(old_fltr);
 	}
 	if (!input)
 		return err;
@@ -2206,7 +2206,7 @@ int ice_add_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 		return -ENOSPC;
 	}
 
-	input = devm_kzalloc(dev, sizeof(*input), GFP_KERNEL);
+	input = kzalloc_obj(*input);
 	if (!input)
 		return -ENOMEM;
 
@@ -2250,7 +2250,7 @@ int ice_add_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 	mutex_unlock(&hw->fdir_fltr_lock);
 free_input:
 	if (ret)
-		devm_kfree(dev, input);
+		kfree(input);
 
 	return ret;
 }
-- 
2.49.0

