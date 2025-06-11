Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8444BC677C4
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Jun 2025 08:46:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 580B440E4F;
	Wed, 11 Jun 2025 08:46:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ESSbZBIcBxdh; Wed, 11 Jun 2025 08:46:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C870940E61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1749631579;
	bh=WDvWFy8UbnpOLujqvC8g3GGB73WRCaef0B4gw5Rr4vc=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JAu1JhJWP0pa8YzYnRky6OahWa26/DLBtV+F8B+A/kfzVspOXHs6WmZC+LlIcIZfc
	 T+F123zk9XRLCRu/oBaF2qg5/KTyORIrKCDRgV+07pr4FiPvO7bGBMUWhLKbawFRd2
	 b2jrNco7Uel50d/dTpA55E6mwe/ZdNWvUrpPCzueTEOd8VP04kEHE4FVwkLMisAODc
	 ZZs3a0amJwq8oIRZ0OfvealfqVvwFWx4P+u4YdsTKIQ5zK25ydvlSBN//Q7wRqbaOo
	 0s5KyVKqRLYaP1jpYMTld+Sm25TSKkF0jsChn0HZckWr+C3pf6cDmAilXMs/WuFFQz
	 cGrpUIak19NXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C870940E61;
	Wed, 11 Jun 2025 08:46:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F2611F2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Jun 2025 08:46:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3138E403CA
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Jun 2025 08:46:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z_zWrXCKopP9 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Jun 2025 08:46:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=konrad.knitter@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8C55C403BD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8C55C403BD
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8C55C403BD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Jun 2025 08:46:17 +0000 (UTC)
X-CSE-ConnectionGUID: M+FZ70HbTWyjSKCBfEVh2g==
X-CSE-MsgGUID: evXtk8edQGypIoM1IUN9zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="62046159"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; d="scan'208";a="62046159"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2025 01:46:17 -0700
X-CSE-ConnectionGUID: bTb/FLHOST6nd0bHeHumug==
X-CSE-MsgGUID: 3sHeCa0ERRqjoandVdG6KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; d="scan'208";a="152298394"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa004.fm.intel.com with ESMTP; 11 Jun 2025 01:46:16 -0700
Received: from kord.igk.intel.com (kord.igk.intel.com [10.123.220.9])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 73C8B332AE;
 Wed, 11 Jun 2025 09:46:15 +0100 (IST)
From: Konrad Knitter <konrad.knitter@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Konrad Knitter <konrad.knitter@intel.com>
Date: Wed, 11 Jun 2025 11:01:22 +0200
Message-Id: <20250611090122.4312-4-konrad.knitter@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250611090122.4312-1-konrad.knitter@intel.com>
References: <20250611090122.4312-1-konrad.knitter@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749631578; x=1781167578;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6x6QL82OphoxZIikvvYXWnq+2WXRIS75JJh3r94rvgE=;
 b=lkFXsMSpQ4MAwjN7S0NM73BmMdi+Mosni5++d7ccXyeiDeE3GI451A1+
 qYHQL4H8EpjKkp9yuNocNuVval4xR4egCAKsKH9jEaEZGCRUBmhd/R1RS
 TKIaHT5qNBxANhYxJrNZDAeElANC71h2ZnjbM+Cp1Xm0/iAPhRDtz0tko
 SfXlo8y74RDTXSUEL3dwDAgVxB2Ccayg5syLPferJJQBm4sJ58LSMiwmo
 mot9F9WsfQTftCbsrhw3yv0hMq6hlEhQS2WEtPL8w2Hoxm5UGRyUtyW9V
 QXtmvE5PJNfdOMhR1yuUOORGqEcwjfcZpZ7GNIC7TKXWIZR/NEjT+9ehB
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=lkFXsMSp
Subject: [Intel-wired-lan] [PATCH iwl-next v1 3/3] ixgbe: add overwrite mask
 from factory settings
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

Support for restoring settings and identifiers from factory settings
instead of using those found in the image.

Restoring data from factory settings requires restoring both settings
and identifiers simultaneously. Other combinations are not supported.

Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_fw_update.c | 6 ++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fw_update.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fw_update.c
index e5479fc07a07..6b46da369934 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fw_update.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fw_update.c
@@ -654,6 +654,12 @@ int ixgbe_flash_pldm_image(struct devlink *devlink,
 		/* overwrite both settings and identifiers, preserve nothing */
 		preservation = IXGBE_ACI_NVM_NO_PRESERVATION;
 		break;
+	case (DEVLINK_FLASH_OVERWRITE_SETTINGS |
+	     DEVLINK_FLASH_OVERWRITE_IDENTIFIERS |
+	     DEVLINK_FLASH_OVERWRITE_FROM_FACTORY_SETTINGS):
+		/* overwrite both settings and identifiers, from factory settings */
+		preservation = IXGBE_ACI_NVM_FACTORY_DEFAULT;
+		break;
 	default:
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Requested overwrite mask is not supported");
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
index d76334b8fbad..426bb2424620 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -691,6 +691,7 @@ struct ixgbe_aci_cmd_nvm {
 #define IXGBE_ACI_NVM_LAST_CMD		BIT(0)
 #define IXGBE_ACI_NVM_PCIR_REQ		BIT(0) /* Used by NVM Write reply */
 #define IXGBE_ACI_NVM_PRESERVE_ALL	BIT(1)
+#define IXGBE_ACI_NVM_FACTORY_DEFAULT	BIT(2)
 #define IXGBE_ACI_NVM_ACTIV_SEL_NVM	BIT(3) /* Write Activate/SR Dump only */
 #define IXGBE_ACI_NVM_ACTIV_SEL_OROM	BIT(4)
 #define IXGBE_ACI_NVM_ACTIV_SEL_NETLIST	BIT(5)
-- 
2.38.1

