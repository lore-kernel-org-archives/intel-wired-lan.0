Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABF9CA600D
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 14:14:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C06B440ABB;
	Thu,  8 Oct 2026 14:14:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0raJN4h-s4jO; Thu,  8 Oct 2026 14:14:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2586A40AEF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791468867;
	b=tTlju/vw4Tt6FHdPWvlIFTkDBLRv/o244ozlp6uBrByRn8Zqxh+4K6SK7L81lMFb38PO
	 RH7ItaGIJ242aHzyKSbuKezTEGYz3jQ97/mmz22RszjJGDekLOxwrgPsI3lL4BXxwg8Pv
	 OJZ302HZDFRcsRvpyJjUvFTZT8i5ZI2Rit24sE8mKpXC7saLxgbjuim7GWX028PcYf/4d
	 hXZdZebzPATE5HYJX8RzNALrjesCZKCcdipGgXns9769YgSIISvyec5LlHsVP+HswegtK
	 RnrpiG2aaglcwbyLYWbbP/pxpl0MtdTHKys3MKzm6ZfKkMjiPU5bykU1VwhNZ0FVbHQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791468867;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YyyD9STczWKneqg5Xb0NSBhgrArN5bzfG9PC9pYhQ2U=;
	b=W2AWTa+SXuoezAPqA2512AwTpRH9PPIVwSlOZOyxf3++MGCJxbJofCph4GCnel8wQJN5
	 m6DVmowBvAEQnPZaa/fXzHOasMGJGpe5FmELnXGkQeXHxxm8Ki3DFOwIMFJN7rN3nLBH9
	 u5Ny9RudsqSZmtaKOw2veL1ReGxgAclyrVvosWfWqyGPwoeIUKpvQctqs8u/nnc78NA0Z
	 D3H/1aCA4tVrcsgquLV+e5sPATtYuRJuhMjL6YXce7G6qLol1nHMdmKZ+gaoSmH1xDc/H
	 v3QweB9f0W3Aw36VZjdSDWIZMS2C/F7AeURGrfDsguAAi/PX4f6gvqqJqaD2TLelUjA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791468867;
	bh=YyyD9STczWKneqg5Xb0NSBhgrArN5bzfG9PC9pYhQ2U=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9sBXF3n7dtqOM8DRycCF4a7y2Pm2NXvbU08+KzwGd4d/Fv2Msf6G7w8vO6LLJxWUq
	 0gkg6B2RD+pA6DI938096HtJP8A4Fx6IxBNud8YUP1i3kVGIAxbqZTyt8okb9JO/Rq
	 PzWBR4ojRYCWhwGqPMsYWXLeHiby5Tu2IgCKvPwy86ZqHX2mF4lP7hXfL4JvJ70Ezc
	 xXF2NghbRLdIivz7CM+Y0NkBm0BswxFGJBFJR54fiLmbh1x78+limwiqTVAG08/1i8
	 SBNtTJPUxT5hoJ0DZLsLP8YDCI1CC2MZWUFYgzlgUsKKxL+Sn8bqWlRK/YUnnsBR08
	 jxwk6IaLP4Ezw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2586A40AEF;
	Thu,  8 Oct 2026 14:14:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A1931A6
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 14:14:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1FCDB404B5
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 14:14:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UXZlVSURvNmZ for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 14:14:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 49ECE40059
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791468864;
 b=doDCnNBGgkOVpZZMAFSvSuxIRUcFQ5rMJI2O9DA3R/lawSoaFmyAh3sb/OCcF+tIg/Qr
 K107Z7RSe73fCKfsbPLBkO4b0X7FogMJRfPR8rRs9XfiQJrUBt8gFy8eEqU9BXH/HDlG0
 88LNjMCy48Me3E13ZkAYlAtUgc0t6hZeO15ep2y8CQgBklAuCfcSatvAXM9bP2EOwddfM
 Iox0FDhk4vuzQFilPpP4twULvoYFUiJIn/zd+m3SQewL/m03yUyEvchv55ZlaPVAuYYWm
 LU5jEf5Ap6PMVZ/ELpH1oPHcRJJoKr3akcZmXSj1/P82OPk9r1T3msAldVp9j6PrpTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791468864;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=YyyD9STczWKneqg5Xb0NSBhgrArN5bzfG9PC9pYhQ2U=;
 b=F8UFOxJJ1KfiMdWfb/Apb7dIACYEhVyRSvN/EJPmU0Rieb3Rn5//81WEWK1phte/EV8R
 TgUWr5ihT2/UT+jNjtgpz4CUsZG2P4ucqKY3wZRM5vh+RrrwvPzPVV5JkZ8Hn/2KzB0mr
 5WFZzOh/RHmBU4f9PPJLiDavIaFfc1D8lSdAxzMpmf45zYsN7a6YRptoDAyR/b6nPU0g1
 5zkLu3kbhHuU2hCxvMbNvNqs7qXrNS24pgZG+3OiO8Ta90SYakox0SIq8iCUgxIx+jPZ1
 ISj/KKClOA1eW9LJS44qclfaweZyg/iU6oSK5bQcoLAEyJgyHFCPEiMqClQm36h4VaA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=mK6CI54g; 
 arc=none smtp.remote-ip=198.175.65.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=mK6CI54g
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 49ECE40059
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 14:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791468865; x=1823004865;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=gpvQlk2UdVPTRZ09EBpdKhavPrDJD4fowFkroyUw52U=;
 b=mK6CI54g80Jy5Ewsc6W8jm1Ku1MpbC7bwfy3/yV2V44jSDeaCPMsr6Wo
 apx3qyfRAGwa1ShjS+/e88XgD2uknopwGndpXi5nhPjGTxjmKwm+GXDEl
 z2sLdlrDdvzVvYd4fnOxe/Ph0npM1tXvz/2XDhxCJZfux25MtrDPEHApe
 /IOSR3BsWkN8ih3Y19KwBEPQrlaV1x4pxQyJgh3KmDfmOcIGFImRtdnqp
 YaIUZuDaIO5Jv/+5Gepi1ohJMsISeqEL6hjYOaeNlAt+mHyw7vnUWFxUR
 O8RH4IvcBuMXndRP94qFkD2l2b6snmKr5ANECPuz9kx58Mbs8m53TKZQM Q==;
X-CSE-ConnectionGUID: 7cHwiIBEQMWKw0QuHMxwBg==
X-CSE-MsgGUID: mglHkG/zQ8Km8Csquma7zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="250629"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="250629"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 07:14:23 -0700
X-CSE-ConnectionGUID: PtOWTFV2RauUps9FVky4Iw==
X-CSE-MsgGUID: iZi4Yqw/RV2hRJ9dmU96ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="1887320"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa012.fm.intel.com with ESMTP; 08 Oct 2026 07:14:21 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v2 1/2] ice: parse external Root of Trust capability
Date: Thu,  8 Oct 2026 16:14:17 +0200
Message-ID: <20261008141418.958066-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261008141418.958066-1-aleksandr.loktionov@intel.com>
References: <20261008141418.958066-1-aleksandr.loktionov@intel.com>
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

Reserve the external PQC Root of Trust capability ID in the shared libie
capability list and parse its value into the common capabilities.

Firmware reports 1 for present and 0 for absent. Treat an omitted
capability as absent to preserve legacy behavior. Keep a separate invalid
bit so consumers can reject an explicitly reported unknown encoding
instead of treating it as absence. Log the reported value for debugging.

Leave the decision to the capability consumer. No NVM layout assumptions
or probe-time derived state are needed.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 6 ++++++
 drivers/net/ethernet/intel/ice/ice_type.h   | 2 ++
 include/linux/net/intel/libie/adminq.h      | 1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 6bde8f5..f1262d9 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2484,6 +2484,12 @@ ice_parse_common_caps(struct ice_hw *hw, struct ice_hw_common_caps *caps,
 	case LIBIE_AQC_CAPS_TX_SCHED_TOPO_COMP_MODE:
 		caps->tx_sched_topo_comp_mode_en = (number == 1);
 		break;
+	case LIBIE_AQC_CAPS_EXTERNAL_PQC_ROT_PRESENT:
+		caps->external_pqc_rot_present = (number == 1);
+		caps->external_pqc_rot_invalid = (number != 0 && number != 1);
+		ice_debug(hw, ICE_DBG_INIT, "%s: external_pqc_rot = %u\n",
+			  prefix, number);
+		break;
 	default:
 		/* Not one of the recognized common capabilities */
 		found = false;
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 67b90c0..1fede0f 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -311,6 +311,8 @@ struct ice_hw_common_caps {
 	/* Post update reset restriction */
 	bool reset_restrict_support;
 	bool tx_sched_topo_comp_mode_en;
+	bool external_pqc_rot_present;
+	bool external_pqc_rot_invalid;
 };
 
 /* IEEE 1588 TIME_SYNC specific info */
diff --git a/include/linux/net/intel/libie/adminq.h b/include/linux/net/intel/libie/adminq.h
index 839114d..df42f5b 100644
--- a/include/linux/net/intel/libie/adminq.h
+++ b/include/linux/net/intel/libie/adminq.h
@@ -175,6 +175,7 @@ LIBIE_CHECK_STRUCT_LEN(16, libie_aqc_list_caps);
 #define LIBIE_AQC_CAPS_PENDING_OROM_VER			0x004B
 #define LIBIE_AQC_CAPS_NET_VER				0x004C
 #define LIBIE_AQC_CAPS_PENDING_NET_VER			0x004D
+#define LIBIE_AQC_CAPS_EXTERNAL_PQC_ROT_PRESENT		0x004E
 #define LIBIE_AQC_CAPS_RDMA				0x0051
 #define LIBIE_AQC_CAPS_LED				0x0061
 #define LIBIE_AQC_CAPS_SDP				0x0062
-- 
2.52.0

