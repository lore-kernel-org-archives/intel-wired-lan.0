Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86000C352A1
	for <intel-wired-lan@archiver.kernel.org>; Wed,  7 Dec 2022 14:45:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 143AE40B78;
	Wed,  7 Dec 2022 14:45:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 143AE40B78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1670424312;
	bh=mJLwW/a9S5UoM9DlgpXprsV4GLCxHfHxtRGtY8UVG3I=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OaDQKqEiHB3BgiOyTcuWH4DiPD4U6rlwEaE8XLq2eGMxrqEcyhIj17Zru8Lv1o35q
	 CdleWKBFLS8OORI1gUJQGwc7vNIOU5iYYbwvVLoEhz8uOCBTsx0pudpQ2/qO+3sZxf
	 lPZ5AZxPhs57GI0XB/dQ5ghMDA1CIP1LutPj/NTyTIkezbbw4Ep0wIFmXIR51sJi9e
	 BJwobDswQ6krKGOleCzA1MkJq5eVazzWtt4uacaaEo1gx1H7AFk1mCXLkFAr0oaBnq
	 Vw7Y4ClsG+cLdrXzTsqU2RyM+ePNO3JtmOITqSbrapzbm4Y6R4neU0rGvve/DOGchy
	 2WmFsK3etuz9w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JtEyCn-PwfQT; Wed,  7 Dec 2022 14:45:11 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id D073340A01;
	Wed,  7 Dec 2022 14:45:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D073340A01
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 55EDC1BF488
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Dec 2022 14:45:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3E94360D78
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Dec 2022 14:45:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3E94360D78
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2NqRetWPdtZL for <intel-wired-lan@lists.osuosl.org>;
 Wed,  7 Dec 2022 14:45:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7175060792
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7175060792
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Dec 2022 14:45:05 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="381198217"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; d="scan'208";a="381198217"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2022 06:45:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="735416121"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; d="scan'208";a="735416121"
Received: from s240.igk.intel.com (HELO s048.nql.local) ([10.102.18.202])
 by FMSMGA003.fm.intel.com with ESMTP; 07 Dec 2022 06:45:03 -0800
From: Jan Sokolowski <jan.sokolowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Wed,  7 Dec 2022 15:47:57 +0100
Message-Id: <20221207144800.1257060-2-jan.sokolowski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221207144800.1257060-1-jan.sokolowski@intel.com>
References: <20221207144800.1257060-1-jan.sokolowski@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1670424305; x=1701960305;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wyAkLkJOD9gzd/0dA2r17FtSamJSDxZEPqCz0LePhSY=;
 b=hUJJpj6SMEWsEcihan9ko6+i08MzT7pu3clklxwHkoqSS0V/yckmM8S1
 N+DLW3gLSawCn9dRQZcsPAhrUZwcSUxBEC5WKWcKV0Jj25bCXX9Ly0jUa
 Kbwjg+zlRCzwGDwxrucWepoivBHCCvYS/XScfcYMofbnQStsLXcCD9oJ6
 hl0TqjC/oF8bnl7998fHjnmc7KFLNnuO0GCAhNoCwmflig5xOkI5BgQhe
 RqnRa2AD6KZFgFufEeoliv2DuTaIz/qusOQFpxQt8c6vj6gKDv8MWUy/Q
 tafQ9JvZCZyo6WNz7FLGfiwVj5CFLxxxbq8H+kNyjVNRWKpXvd/ZJtKhQ
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=hUJJpj6S
Subject: [Intel-wired-lan] [PATCH net-next v3 1/4] i40e: Remove unused i40e
 status codes
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

In an effort to remove i40e status codes and replace them
with standard kernel errornums, unused values of i40e_status_code
were removed.

Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 70 -------------------
 drivers/net/ethernet/intel/i40e/i40e_status.h | 35 ----------
 2 files changed, 105 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 8f764ff5c990..0b77307841b0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -138,106 +138,40 @@ const char *i40e_stat_str(struct i40e_hw *hw, i40e_status stat_err)
 		return "I40E_ERR_NVM";
 	case I40E_ERR_NVM_CHECKSUM:
 		return "I40E_ERR_NVM_CHECKSUM";
-	case I40E_ERR_PHY:
-		return "I40E_ERR_PHY";
 	case I40E_ERR_CONFIG:
 		return "I40E_ERR_CONFIG";
 	case I40E_ERR_PARAM:
 		return "I40E_ERR_PARAM";
-	case I40E_ERR_MAC_TYPE:
-		return "I40E_ERR_MAC_TYPE";
 	case I40E_ERR_UNKNOWN_PHY:
 		return "I40E_ERR_UNKNOWN_PHY";
-	case I40E_ERR_LINK_SETUP:
-		return "I40E_ERR_LINK_SETUP";
-	case I40E_ERR_ADAPTER_STOPPED:
-		return "I40E_ERR_ADAPTER_STOPPED";
 	case I40E_ERR_INVALID_MAC_ADDR:
 		return "I40E_ERR_INVALID_MAC_ADDR";
 	case I40E_ERR_DEVICE_NOT_SUPPORTED:
 		return "I40E_ERR_DEVICE_NOT_SUPPORTED";
-	case I40E_ERR_PRIMARY_REQUESTS_PENDING:
-		return "I40E_ERR_PRIMARY_REQUESTS_PENDING";
-	case I40E_ERR_INVALID_LINK_SETTINGS:
-		return "I40E_ERR_INVALID_LINK_SETTINGS";
-	case I40E_ERR_AUTONEG_NOT_COMPLETE:
-		return "I40E_ERR_AUTONEG_NOT_COMPLETE";
 	case I40E_ERR_RESET_FAILED:
 		return "I40E_ERR_RESET_FAILED";
-	case I40E_ERR_SWFW_SYNC:
-		return "I40E_ERR_SWFW_SYNC";
 	case I40E_ERR_NO_AVAILABLE_VSI:
 		return "I40E_ERR_NO_AVAILABLE_VSI";
 	case I40E_ERR_NO_MEMORY:
 		return "I40E_ERR_NO_MEMORY";
 	case I40E_ERR_BAD_PTR:
 		return "I40E_ERR_BAD_PTR";
-	case I40E_ERR_RING_FULL:
-		return "I40E_ERR_RING_FULL";
-	case I40E_ERR_INVALID_PD_ID:
-		return "I40E_ERR_INVALID_PD_ID";
-	case I40E_ERR_INVALID_QP_ID:
-		return "I40E_ERR_INVALID_QP_ID";
-	case I40E_ERR_INVALID_CQ_ID:
-		return "I40E_ERR_INVALID_CQ_ID";
-	case I40E_ERR_INVALID_CEQ_ID:
-		return "I40E_ERR_INVALID_CEQ_ID";
-	case I40E_ERR_INVALID_AEQ_ID:
-		return "I40E_ERR_INVALID_AEQ_ID";
 	case I40E_ERR_INVALID_SIZE:
 		return "I40E_ERR_INVALID_SIZE";
-	case I40E_ERR_INVALID_ARP_INDEX:
-		return "I40E_ERR_INVALID_ARP_INDEX";
-	case I40E_ERR_INVALID_FPM_FUNC_ID:
-		return "I40E_ERR_INVALID_FPM_FUNC_ID";
-	case I40E_ERR_QP_INVALID_MSG_SIZE:
-		return "I40E_ERR_QP_INVALID_MSG_SIZE";
-	case I40E_ERR_QP_TOOMANY_WRS_POSTED:
-		return "I40E_ERR_QP_TOOMANY_WRS_POSTED";
-	case I40E_ERR_INVALID_FRAG_COUNT:
-		return "I40E_ERR_INVALID_FRAG_COUNT";
 	case I40E_ERR_QUEUE_EMPTY:
 		return "I40E_ERR_QUEUE_EMPTY";
-	case I40E_ERR_INVALID_ALIGNMENT:
-		return "I40E_ERR_INVALID_ALIGNMENT";
-	case I40E_ERR_FLUSHED_QUEUE:
-		return "I40E_ERR_FLUSHED_QUEUE";
-	case I40E_ERR_INVALID_PUSH_PAGE_INDEX:
-		return "I40E_ERR_INVALID_PUSH_PAGE_INDEX";
-	case I40E_ERR_INVALID_IMM_DATA_SIZE:
-		return "I40E_ERR_INVALID_IMM_DATA_SIZE";
 	case I40E_ERR_TIMEOUT:
 		return "I40E_ERR_TIMEOUT";
-	case I40E_ERR_OPCODE_MISMATCH:
-		return "I40E_ERR_OPCODE_MISMATCH";
-	case I40E_ERR_CQP_COMPL_ERROR:
-		return "I40E_ERR_CQP_COMPL_ERROR";
-	case I40E_ERR_INVALID_VF_ID:
-		return "I40E_ERR_INVALID_VF_ID";
-	case I40E_ERR_INVALID_HMCFN_ID:
-		return "I40E_ERR_INVALID_HMCFN_ID";
-	case I40E_ERR_BACKING_PAGE_ERROR:
-		return "I40E_ERR_BACKING_PAGE_ERROR";
-	case I40E_ERR_NO_PBLCHUNKS_AVAILABLE:
-		return "I40E_ERR_NO_PBLCHUNKS_AVAILABLE";
-	case I40E_ERR_INVALID_PBLE_INDEX:
-		return "I40E_ERR_INVALID_PBLE_INDEX";
 	case I40E_ERR_INVALID_SD_INDEX:
 		return "I40E_ERR_INVALID_SD_INDEX";
 	case I40E_ERR_INVALID_PAGE_DESC_INDEX:
 		return "I40E_ERR_INVALID_PAGE_DESC_INDEX";
 	case I40E_ERR_INVALID_SD_TYPE:
 		return "I40E_ERR_INVALID_SD_TYPE";
-	case I40E_ERR_MEMCPY_FAILED:
-		return "I40E_ERR_MEMCPY_FAILED";
 	case I40E_ERR_INVALID_HMC_OBJ_INDEX:
 		return "I40E_ERR_INVALID_HMC_OBJ_INDEX";
 	case I40E_ERR_INVALID_HMC_OBJ_COUNT:
 		return "I40E_ERR_INVALID_HMC_OBJ_COUNT";
-	case I40E_ERR_INVALID_SRQ_ARM_LIMIT:
-		return "I40E_ERR_INVALID_SRQ_ARM_LIMIT";
-	case I40E_ERR_SRQ_ENABLED:
-		return "I40E_ERR_SRQ_ENABLED";
 	case I40E_ERR_ADMIN_QUEUE_ERROR:
 		return "I40E_ERR_ADMIN_QUEUE_ERROR";
 	case I40E_ERR_ADMIN_QUEUE_TIMEOUT:
@@ -248,14 +182,10 @@ const char *i40e_stat_str(struct i40e_hw *hw, i40e_status stat_err)
 		return "I40E_ERR_ADMIN_QUEUE_FULL";
 	case I40E_ERR_ADMIN_QUEUE_NO_WORK:
 		return "I40E_ERR_ADMIN_QUEUE_NO_WORK";
-	case I40E_ERR_BAD_IWARP_CQE:
-		return "I40E_ERR_BAD_IWARP_CQE";
 	case I40E_ERR_NVM_BLANK_MODE:
 		return "I40E_ERR_NVM_BLANK_MODE";
 	case I40E_ERR_NOT_IMPLEMENTED:
 		return "I40E_ERR_NOT_IMPLEMENTED";
-	case I40E_ERR_PE_DOORBELL_NOT_ENABLED:
-		return "I40E_ERR_PE_DOORBELL_NOT_ENABLED";
 	case I40E_ERR_DIAG_TEST_FAILED:
 		return "I40E_ERR_DIAG_TEST_FAILED";
 	case I40E_ERR_NOT_READY:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_status.h b/drivers/net/ethernet/intel/i40e/i40e_status.h
index db3714a65dc7..4d2782e76038 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_status.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_status.h
@@ -9,65 +9,30 @@ enum i40e_status_code {
 	I40E_SUCCESS				= 0,
 	I40E_ERR_NVM				= -1,
 	I40E_ERR_NVM_CHECKSUM			= -2,
-	I40E_ERR_PHY				= -3,
 	I40E_ERR_CONFIG				= -4,
 	I40E_ERR_PARAM				= -5,
-	I40E_ERR_MAC_TYPE			= -6,
 	I40E_ERR_UNKNOWN_PHY			= -7,
-	I40E_ERR_LINK_SETUP			= -8,
-	I40E_ERR_ADAPTER_STOPPED		= -9,
 	I40E_ERR_INVALID_MAC_ADDR		= -10,
 	I40E_ERR_DEVICE_NOT_SUPPORTED		= -11,
-	I40E_ERR_PRIMARY_REQUESTS_PENDING	= -12,
-	I40E_ERR_INVALID_LINK_SETTINGS		= -13,
-	I40E_ERR_AUTONEG_NOT_COMPLETE		= -14,
 	I40E_ERR_RESET_FAILED			= -15,
-	I40E_ERR_SWFW_SYNC			= -16,
 	I40E_ERR_NO_AVAILABLE_VSI		= -17,
 	I40E_ERR_NO_MEMORY			= -18,
 	I40E_ERR_BAD_PTR			= -19,
-	I40E_ERR_RING_FULL			= -20,
-	I40E_ERR_INVALID_PD_ID			= -21,
-	I40E_ERR_INVALID_QP_ID			= -22,
-	I40E_ERR_INVALID_CQ_ID			= -23,
-	I40E_ERR_INVALID_CEQ_ID			= -24,
-	I40E_ERR_INVALID_AEQ_ID			= -25,
 	I40E_ERR_INVALID_SIZE			= -26,
-	I40E_ERR_INVALID_ARP_INDEX		= -27,
-	I40E_ERR_INVALID_FPM_FUNC_ID		= -28,
-	I40E_ERR_QP_INVALID_MSG_SIZE		= -29,
-	I40E_ERR_QP_TOOMANY_WRS_POSTED		= -30,
-	I40E_ERR_INVALID_FRAG_COUNT		= -31,
 	I40E_ERR_QUEUE_EMPTY			= -32,
-	I40E_ERR_INVALID_ALIGNMENT		= -33,
-	I40E_ERR_FLUSHED_QUEUE			= -34,
-	I40E_ERR_INVALID_PUSH_PAGE_INDEX	= -35,
-	I40E_ERR_INVALID_IMM_DATA_SIZE		= -36,
 	I40E_ERR_TIMEOUT			= -37,
-	I40E_ERR_OPCODE_MISMATCH		= -38,
-	I40E_ERR_CQP_COMPL_ERROR		= -39,
-	I40E_ERR_INVALID_VF_ID			= -40,
-	I40E_ERR_INVALID_HMCFN_ID		= -41,
-	I40E_ERR_BACKING_PAGE_ERROR		= -42,
-	I40E_ERR_NO_PBLCHUNKS_AVAILABLE		= -43,
-	I40E_ERR_INVALID_PBLE_INDEX		= -44,
 	I40E_ERR_INVALID_SD_INDEX		= -45,
 	I40E_ERR_INVALID_PAGE_DESC_INDEX	= -46,
 	I40E_ERR_INVALID_SD_TYPE		= -47,
-	I40E_ERR_MEMCPY_FAILED			= -48,
 	I40E_ERR_INVALID_HMC_OBJ_INDEX		= -49,
 	I40E_ERR_INVALID_HMC_OBJ_COUNT		= -50,
-	I40E_ERR_INVALID_SRQ_ARM_LIMIT		= -51,
-	I40E_ERR_SRQ_ENABLED			= -52,
 	I40E_ERR_ADMIN_QUEUE_ERROR		= -53,
 	I40E_ERR_ADMIN_QUEUE_TIMEOUT		= -54,
 	I40E_ERR_BUF_TOO_SHORT			= -55,
 	I40E_ERR_ADMIN_QUEUE_FULL		= -56,
 	I40E_ERR_ADMIN_QUEUE_NO_WORK		= -57,
-	I40E_ERR_BAD_IWARP_CQE			= -58,
 	I40E_ERR_NVM_BLANK_MODE			= -59,
 	I40E_ERR_NOT_IMPLEMENTED		= -60,
-	I40E_ERR_PE_DOORBELL_NOT_ENABLED	= -61,
 	I40E_ERR_DIAG_TEST_FAILED		= -62,
 	I40E_ERR_NOT_READY			= -63,
 	I40E_NOT_SUPPORTED			= -64,
-- 
2.31.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
