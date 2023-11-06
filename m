Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A44C4332F
	for <intel-wired-lan@archiver.kernel.org>; Mon,  6 Nov 2023 15:26:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C98C24150C;
	Mon,  6 Nov 2023 15:26:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C98C24150C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1699284384;
	bh=sfMcv6Zlfru1lWCQ8Fg5tjhQ32ad0vBYXPjT1LVOofs=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=TflhzboM3igpucq76Dx3pYeHZ1NABYL7pcQrWms+7DH1hAuFlftp0SwcRZB9cQVkI
	 qMhdD837PrxwpEd7tWbj0W/nC8Q1502sH1jOQJ5EXNIEhzWaniggYRWga/fBwmHeZV
	 ofBTAELsioBwdkc5QzD3dF/Xfa1RSry0xkpAQ2+a5Y9Jp50j0IdbhKPCgD1bhI9DE3
	 d37/hHyO870bHXz3JGw+8XgraaAyCtM42rVpt2FynuuNjQTPBBMNIfb5Hfz/pLjo/S
	 P4L+uw9a14leE6bQaN3VFlR3g3ffkI2kf/4J/0ZyC+9JbF7WtoliJO6Vmzeeq1ZKjM
	 OtFwNEytZdssg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NB2kP1fxVI1I; Mon,  6 Nov 2023 15:26:24 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id BB7864151E;
	Mon,  6 Nov 2023 15:26:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BB7864151E
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 1EE7B1BF3AF
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Nov 2023 15:26:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5852041FED
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Nov 2023 15:26:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5852041FED
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JNbxesh_16N3 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  6 Nov 2023 15:26:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9349541FEE
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Nov 2023 15:26:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9349541FEE
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="389105792"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; d="scan'208";a="389105792"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2023 07:26:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="791492585"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; d="scan'208";a="791492585"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.244.154])
 by orsmga008.jf.intel.com with ESMTP; 06 Nov 2023 07:26:15 -0800
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon,  6 Nov 2023 10:18:08 -0500
Message-ID: <20231106151808.421280-2-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106151808.421280-1-paul.greenwalt@intel.com>
References: <20231106151808.421280-1-paul.greenwalt@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699284376; x=1730820376;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=C5xAmnqBSRvl7cD+EhLOcdeNwbvjBkRZfdt4wnE0Pxw=;
 b=J6lWYWXaae74TMMdDA9nZlyH7EFL+BSXHQu5YQNeMkPtW1NozHKn16sd
 E2KnBKUUEuly6SltNqUS/Wi8+UN3q7pluZUtSWzWNpktc8NCD7D6oydyG
 Wxp2d9iUlZd+is+PndyoFD1TqvyTFrHWMKZhIJs1nh/2MI6P8s4QO0S3l
 12pSu01kXzMkIT+b/23ZjlKcysChndOAoUP7k5i6w9W4vY01BJVi8LJux
 h3v/+02vsqVy6Vjn4vK3QAbWsW6/i/UkRzvKg+E5BDUWKti7hTCmjTHA8
 TAEI5G6837PopqdgGgGMnEfkhqu3TePr2QlHAckCSk2EHMMAZaoZ0y+J1
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=J6lWYWXa
Subject: [Intel-wired-lan] [PATCH iwl-net v2] ice: fix DDP package download
 for packages without signature segment
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
Cc: Dan Nowlin <dan.nowlin@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 Paul Greenwalt <paul.greenwalt@intel.com>, horms@kernel.org, kuba@kernel.org,
 davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Dan Nowlin <dan.nowlin@intel.com>

Commit 3cbdb0343022 ("ice: Add support for E830 DDP package segment")
incorrectly removed support for package download for packages without a
signature segment. These packages include the signature buffer inline
in the configurations buffers, and not in a signature segment.

Fix package download by providing download support for both packages
with (ice_download_pkg_with_sig_seg()) and without signature segment
(ice_download_pkg_without_sig_seg()).

Fixes: 3cbdb0343022 ("ice: Add support for E830 DDP package segment")
Reported-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
Changelog
v2->v3:
- correct Reported-by email address.
___

 drivers/net/ethernet/intel/ice/ice_ddp.c | 106 ++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index cfb1580f5850..3f1a11d0252c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -1479,14 +1479,14 @@ ice_post_dwnld_pkg_actions(struct ice_hw *hw)
 }
 
 /**
- * ice_download_pkg
+ * ice_download_pkg_with_sig_seg
  * @hw: pointer to the hardware structure
  * @pkg_hdr: pointer to package header
  *
  * Handles the download of a complete package.
  */
 static enum ice_ddp_state
-ice_download_pkg(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr)
+ice_download_pkg_with_sig_seg(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr)
 {
 	enum ice_aq_err aq_err = hw->adminq.sq_last_status;
 	enum ice_ddp_state state = ICE_DDP_PKG_ERR;
@@ -1519,6 +1519,106 @@ ice_download_pkg(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr)
 		state = ice_post_dwnld_pkg_actions(hw);
 
 	ice_release_global_cfg_lock(hw);
+
+	return state;
+}
+
+/**
+ * ice_dwnld_cfg_bufs
+ * @hw: pointer to the hardware structure
+ * @bufs: pointer to an array of buffers
+ * @count: the number of buffers in the array
+ *
+ * Obtains global config lock and downloads the package configuration buffers
+ * to the firmware.
+ */
+static enum ice_ddp_state
+ice_dwnld_cfg_bufs(struct ice_hw *hw, struct ice_buf *bufs, u32 count)
+{
+	enum ice_ddp_state state = ICE_DDP_PKG_SUCCESS;
+	struct ice_buf_hdr *bh;
+	int status;
+
+	if (!bufs || !count)
+		return ICE_DDP_PKG_ERR;
+
+	/* If the first buffer's first section has its metadata bit set
+	 * then there are no buffers to be downloaded, and the operation is
+	 * considered a success.
+	 */
+	bh = (struct ice_buf_hdr *)bufs;
+	if (le32_to_cpu(bh->section_entry[0].type) & ICE_METADATA_BUF)
+		return ICE_DDP_PKG_SUCCESS;
+
+	status = ice_acquire_global_cfg_lock(hw, ICE_RES_WRITE);
+	if (status) {
+		if (status == -EALREADY)
+			return ICE_DDP_PKG_ALREADY_LOADED;
+		return ice_map_aq_err_to_ddp_state(hw->adminq.sq_last_status);
+	}
+
+	state = ice_dwnld_cfg_bufs_no_lock(hw, bufs, 0, count, true);
+	if (!state)
+		state = ice_post_dwnld_pkg_actions(hw);
+
+	ice_release_global_cfg_lock(hw);
+
+	return state;
+}
+
+/**
+ * ice_download_pkg_without_sig_seg
+ * @hw: pointer to the hardware structure
+ * @ice_seg: pointer to the segment of the package to be downloaded
+ *
+ * Handles the download of a complete package without signature segment.
+ */
+static enum ice_ddp_state
+ice_download_pkg_without_sig_seg(struct ice_hw *hw, struct ice_seg *ice_seg)
+{
+	struct ice_buf_table *ice_buf_tbl;
+	enum ice_ddp_state state;
+
+	ice_debug(hw, ICE_DBG_PKG, "Segment format version: %d.%d.%d.%d\n",
+		  ice_seg->hdr.seg_format_ver.major,
+		  ice_seg->hdr.seg_format_ver.minor,
+		  ice_seg->hdr.seg_format_ver.update,
+		  ice_seg->hdr.seg_format_ver.draft);
+
+	ice_debug(hw, ICE_DBG_PKG, "Seg: type 0x%X, size %d, name %s\n",
+		  le32_to_cpu(ice_seg->hdr.seg_type),
+		  le32_to_cpu(ice_seg->hdr.seg_size), ice_seg->hdr.seg_id);
+
+	ice_buf_tbl = ice_find_buf_table(ice_seg);
+
+	ice_debug(hw, ICE_DBG_PKG, "Seg buf count: %d\n",
+		  le32_to_cpu(ice_buf_tbl->buf_count));
+
+	state = ice_dwnld_cfg_bufs(hw, ice_buf_tbl->buf_array,
+				   le32_to_cpu(ice_buf_tbl->buf_count));
+
+	return state;
+}
+
+/**
+ * ice_download_pkg
+ * @hw: pointer to the hardware structure
+ * @pkg_hdr: pointer to package header
+ * @ice_seg: pointer to the segment of the package to be downloaded
+ *
+ * Handles the download of a complete package.
+ */
+static enum ice_ddp_state
+ice_download_pkg(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr,
+		 struct ice_seg *ice_seg)
+{
+	enum ice_ddp_state state;
+
+	if (hw->pkg_has_signing_seg)
+		state = ice_download_pkg_with_sig_seg(hw, pkg_hdr);
+	else
+		state = ice_download_pkg_without_sig_seg(hw, ice_seg);
+
 	ice_post_pkg_dwnld_vlan_mode_cfg(hw);
 
 	return state;
@@ -2083,7 +2183,7 @@ enum ice_ddp_state ice_init_pkg(struct ice_hw *hw, u8 *buf, u32 len)
 
 	/* initialize package hints and then download package */
 	ice_init_pkg_hints(hw, seg);
-	state = ice_download_pkg(hw, pkg);
+	state = ice_download_pkg(hw, pkg, seg);
 	if (state == ICE_DDP_PKG_ALREADY_LOADED) {
 		ice_debug(hw, ICE_DBG_INIT,
 			  "package previously loaded - no work.\n");

base-commit: 016b9332a3346e97a6cacffea0f9dc10e1235a75
-- 
2.41.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
