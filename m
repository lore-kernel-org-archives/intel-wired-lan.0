Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66841EE49A6
	for <intel-wired-lan@archiver.kernel.org>; Mon, 21 Aug 2023 02:39:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 23FC640901;
	Mon, 21 Aug 2023 02:39:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 23FC640901
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692585568;
	bh=++qjKhq0snD5UuRCnNZSNVuT5PpwJjmg7vuunCN7RP4=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=wdunwGo3IrCRPW0mMAWDcUJOTQCIEpWLaMwGhqqHUW1EbFgm/B0U5tEOzL67oxGNh
	 3NeczELreTIRW7GBHrYbBVGaztYDcEOeSlvlfE/pCwgEgubjiN3NvcJTZY/kHYLuo2
	 IX2xdL3074NyHWf6QtI8XneSAGLkEN7DcZf3JuBzEdzY2Cb1gl89GbPC2xrezAnCa7
	 6qDYOW+ph1KF+l/GFjI6lsoZ2tkxcOK1E1TPxbuKcnxt/5INtunKnKH/jedQxTsqz6
	 pca2mRa8fqlaU/dU3W7guyvHh/3YYBWxkiH+I9civOV1wqhgWnzjmaJ7E7guuQKJ+x
	 TnOh68b085zGg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kqtFcP_tHxvh; Mon, 21 Aug 2023 02:39:27 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0939D40A08;
	Mon, 21 Aug 2023 02:39:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0939D40A08
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 94CF01BF2E3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Aug 2023 02:39:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6D18B61074
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Aug 2023 02:39:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6D18B61074
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IdysV5Dgk6p1 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 21 Aug 2023 02:39:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9224561072
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Aug 2023 02:39:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9224561072
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="377216737"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; d="scan'208";a="377216737"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2023 19:39:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="982326648"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; d="scan'208";a="982326648"
Received: from dpdk-jf-ntb-v2.sh.intel.com ([10.67.119.19])
 by fmsmga006.fm.intel.com with ESMTP; 20 Aug 2023 19:39:14 -0700
From: Junfeng Guo <junfeng.guo@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon, 21 Aug 2023 10:38:26 +0800
Message-Id: <20230821023833.2700902-9-junfeng.guo@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230821023833.2700902-1-junfeng.guo@intel.com>
References: <20230605054641.2865142-1-junfeng.guo@intel.com>
 <20230821023833.2700902-1-junfeng.guo@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692585559; x=1724121559;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cnR099NOF4O6zQNwMan3G0/kN7ZEMBNqP53WzEa1UD0=;
 b=YmHyz20mQF//ClHv0k6V+xQ553EqG8ELnWBKf3sW95fzzIk5BgnNLDyo
 uSAOYubFi5nzxeD59FZJ7b7P+u8Chmcuou4C+fLk/njTENfbkS9FM2lkt
 Ig/NQyT+qdyVqomxO1Ca0HleSn90h9A4eGOrwzRs8OXwfQKlBd8D6J9Qu
 +L+jxLo0IQhY+cSPIiPCwtaAt4/LVOTCq17zZg5rcb3zpqXQLpvQ/z2kt
 932iCwO+wOeoe5x42FXGRSBfvOCNsneK+ybm+4r6UWGHFrzTsNVq8XX7W
 2qOeIsnWI6dFwqsoqRtNrnSaoqdJWorh5Cltnu9T2VU1aBPaezItMvEpu
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=YmHyz20m
Subject: [Intel-wired-lan] [PATCH iwl-next v5 08/15] ice: init flag redirect
 table for parser
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
Cc: ivecera@redhat.com, netdev@vger.kernel.org, qi.z.zhang@intel.com,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Parse DDP section ICE_SID_RXPARSER_FLAG_REDIR into an array of
ice_flag_rd_item.

Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ddp.h    |  1 +
 drivers/net/ethernet/intel/ice/ice_flg_rd.c | 50 +++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_flg_rd.h | 23 ++++++++++
 drivers/net/ethernet/intel/ice/ice_parser.c | 10 +++++
 drivers/net/ethernet/intel/ice/ice_parser.h |  4 ++
 5 files changed, 88 insertions(+)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_flg_rd.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_flg_rd.h

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.h b/drivers/net/ethernet/intel/ice/ice_ddp.h
index da5dfeed3b1f..45beed8b4415 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.h
@@ -261,6 +261,7 @@ struct ice_meta_sect {
 #define ICE_SID_CDID_KEY_BUILDER_PE 87
 #define ICE_SID_CDID_REDIR_PE 88
 
+#define ICE_SID_RXPARSER_FLAG_REDIR	97
 /* Label Metadata section IDs */
 #define ICE_SID_LBL_FIRST 0x80000010
 #define ICE_SID_LBL_RXPARSER_TMEM 0x80000018
diff --git a/drivers/net/ethernet/intel/ice/ice_flg_rd.c b/drivers/net/ethernet/intel/ice/ice_flg_rd.c
new file mode 100644
index 000000000000..9d5d66d0c773
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_flg_rd.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Intel Corporation */
+
+#include "ice_common.h"
+#include "ice_parser_util.h"
+
+/**
+ * ice_flg_rd_dump - dump a flag redirect item info
+ * @hw: pointer to the hardware structure
+ * @item: flag redirect item to dump
+ */
+void ice_flg_rd_dump(struct ice_hw *hw, struct ice_flg_rd_item *item)
+{
+	dev_info(ice_hw_to_dev(hw), "index = %d\n", item->idx);
+	dev_info(ice_hw_to_dev(hw), "expose = %d\n", item->expose);
+	dev_info(ice_hw_to_dev(hw), "intr_flg_id = %d\n", item->intr_flg_id);
+}
+
+/** The function parses a 8 bits Flag Redirect Table entry with below format:
+ *  BIT 0:	Expose			(rdi->expose)
+ *  BIT 1-6:	Internal Flag ID	(rdi->intr_flg_id)
+ *  BIT 7:	reserved
+ */
+static void _ice_flg_rd_parse_item(struct ice_hw *hw, u16 idx, void *item,
+				   void *data, int size)
+{
+	struct ice_flg_rd_item *rdi = item;
+	u8 d8 = *(u8 *)data;
+
+	rdi->idx		= idx;
+	rdi->expose		= !!(d8 & ICE_RDI_EXP_M);
+	rdi->intr_flg_id	= (u8)((d8 >> ICE_RDI_IFD_S) & ICE_RDI_IFD_M);
+
+	if (hw->debug_mask & ICE_DBG_PARSER)
+		ice_flg_rd_dump(hw, rdi);
+}
+
+/**
+ * ice_flg_rd_table_get - create a flag redirect table
+ * @hw: pointer to the hardware structure
+ */
+struct ice_flg_rd_item *ice_flg_rd_table_get(struct ice_hw *hw)
+{
+	return (struct ice_flg_rd_item *)
+		ice_parser_create_table(hw, ICE_SID_RXPARSER_FLAG_REDIR,
+					sizeof(struct ice_flg_rd_item),
+					ICE_FLG_RD_TABLE_SIZE,
+					ice_parser_sect_item_get,
+					_ice_flg_rd_parse_item, false);
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_flg_rd.h b/drivers/net/ethernet/intel/ice/ice_flg_rd.h
new file mode 100644
index 000000000000..b3b4fd7a9002
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_flg_rd.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Intel Corporation */
+
+#ifndef _ICE_FLG_RD_H_
+#define _ICE_FLG_RD_H_
+
+#define ICE_FLG_RD_TABLE_SIZE	64
+#define ICE_FLG_RDT_SIZE	64
+
+#define ICE_RDI_EXP_S		0
+#define ICE_RDI_EXP_M		BITMAP_MASK(1)
+#define ICE_RDI_IFD_S		1
+#define ICE_RDI_IFD_M		BITMAP_MASK(6)
+
+struct ice_flg_rd_item {
+	u16 idx;
+	bool expose;
+	u8 intr_flg_id;
+};
+
+void ice_flg_rd_dump(struct ice_hw *hw, struct ice_flg_rd_item *item);
+struct ice_flg_rd_item *ice_flg_rd_table_get(struct ice_hw *hw);
+#endif /* _ICE_FLG_RD_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
index a47b21bb104c..2b3c4b44d1f2 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.c
+++ b/drivers/net/ethernet/intel/ice/ice_parser.c
@@ -68,6 +68,9 @@ void *ice_parser_sect_item_get(u32 sect_type, void *section,
 	case ICE_SID_RXPARSER_PROTO_GRP:
 		size = ICE_SID_RXPARSER_PROTO_GRP_ENTRY_SIZE;
 		break;
+	case ICE_SID_RXPARSER_FLAG_REDIR:
+		size = ICE_SID_RXPARSER_FLAG_REDIR_ENTRY_SIZE;
+		break;
 	default:
 		return NULL;
 	}
@@ -221,6 +224,12 @@ int ice_parser_create(struct ice_hw *hw, struct ice_parser **psr)
 		goto err;
 	}
 
+	p->flg_rd_table = ice_flg_rd_table_get(hw);
+	if (!p->flg_rd_table) {
+		status = -EINVAL;
+		goto err;
+	}
+
 	*psr = p;
 	return 0;
 err:
@@ -245,6 +254,7 @@ void ice_parser_destroy(struct ice_parser *psr)
 	devm_kfree(ice_hw_to_dev(psr->hw), psr->ptype_mk_tcam_table);
 	devm_kfree(ice_hw_to_dev(psr->hw), psr->mk_grp_table);
 	devm_kfree(ice_hw_to_dev(psr->hw), psr->proto_grp_table);
+	devm_kfree(ice_hw_to_dev(psr->hw), psr->flg_rd_table);
 
 	devm_kfree(ice_hw_to_dev(psr->hw), psr);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_parser.h b/drivers/net/ethernet/intel/ice/ice_parser.h
index 4038833450f2..62123788e0a2 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.h
+++ b/drivers/net/ethernet/intel/ice/ice_parser.h
@@ -11,6 +11,7 @@
 #include "ice_ptype_mk.h"
 #include "ice_mk_grp.h"
 #include "ice_proto_grp.h"
+#include "ice_flg_rd.h"
 
 #define ICE_SEC_DATA_OFFSET				4
 #define ICE_SID_RXPARSER_IMEM_ENTRY_SIZE		48
@@ -23,6 +24,7 @@
 #define ICE_SID_RXPARSER_MARKER_TYPE_ENTRY_SIZE		24
 #define ICE_SID_RXPARSER_MARKER_GRP_ENTRY_SIZE		8
 #define ICE_SID_RXPARSER_PROTO_GRP_ENTRY_SIZE		24
+#define ICE_SID_RXPARSER_FLAG_REDIR_ENTRY_SIZE		1
 
 #define ICE_SEC_LBL_DATA_OFFSET				2
 #define ICE_SID_LBL_ENTRY_SIZE				66
@@ -52,6 +54,8 @@ struct ice_parser {
 	struct ice_mk_grp_item *mk_grp_table;
 	/* load data from section ICE_SID_RXPARSER_PROTO_GRP */
 	struct ice_proto_grp_item *proto_grp_table;
+	/* load data from section ICE_SID_RXPARSER_FLAG_REDIR */
+	struct ice_flg_rd_item *flg_rd_table;
 };
 
 int ice_parser_create(struct ice_hw *hw, struct ice_parser **psr);
-- 
2.25.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
