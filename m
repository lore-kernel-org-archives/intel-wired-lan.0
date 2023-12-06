Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7A7C4167B
	for <intel-wired-lan@archiver.kernel.org>; Wed,  6 Dec 2023 19:36:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E882260B21;
	Wed,  6 Dec 2023 19:36:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E882260B21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1701891409;
	bh=Z4kwMhDhnDekDYeEOF2LcTy1kYG7KwkhDKM118WFPHg=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=xcwwTQIS7ui2Y5Q/L+7YSugsERQh7mcxLvPu1hj2clL8SXRS8pb9YA4+eMDfYic7b
	 n3xiX2TBhbR9mcDnw3TJ89uD+SUlWKiGFDjLbrs3jxBwNMZbPnHOzsdmNmDqMlGtiQ
	 4Oxv3Kot5/AifrhMI/WRClf6ImWZ2WiyA7vF3OI5KWlqzTNUZ4R2jRJ3GjaOWOxq8P
	 oYCORj9BtBvazZFQ9wW9oHYoXCXwHW1WiEmDRU0jFmZIFOrzvDuuKTIdOn0QdsFuhB
	 K360YGX5b2frFShdn1k9lYTjVoFoKtvUSFJjKYGIUq/1Hw+paJLF7oyxHFbwKMkEkm
	 2RTFYWQXEcs+w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bFzn2pJq1XvL; Wed,  6 Dec 2023 19:36:48 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2478B60BB9;
	Wed,  6 Dec 2023 19:36:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2478B60BB9
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 945171BF343
 for <intel-wired-lan@lists.osuosl.org>; Wed,  6 Dec 2023 19:36:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7B09D81E5A
 for <intel-wired-lan@lists.osuosl.org>; Wed,  6 Dec 2023 19:36:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B09D81E5A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Iexi4rLVAhqs for <intel-wired-lan@lists.osuosl.org>;
 Wed,  6 Dec 2023 19:36:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C3F4A81E20
 for <intel-wired-lan@lists.osuosl.org>; Wed,  6 Dec 2023 19:36:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C3F4A81E20
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1214443"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1214443"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Dec 2023 11:29:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="889446524"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; d="scan'208";a="889446524"
Received: from unknown (HELO gklab-003-001.igk.intel.com) ([10.211.3.1])
 by fmsmga002.fm.intel.com with ESMTP; 06 Dec 2023 11:29:32 -0800
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Wed,  6 Dec 2023 20:29:19 +0100
Message-Id: <20231206192919.3826128-4-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231206192919.3826128-1-grzegorz.nitka@intel.com>
References: <20231206192919.3826128-1-grzegorz.nitka@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701891399; x=1733427399;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zvt6CXhVc5yk2Dn7HEiJ060mJD3yzsu7T/YQ7hMWXyk=;
 b=DtReAV77sl9fyltJubVJyQsWWnlYoW0OcdOGD2dpFzlsT+d33phzqJHT
 3zTyV6BX7ajxGnukt9JfnnLbaKEoh/DhNHJFcYQlF0YEbuIK/M+iRKGs5
 q9QS+WWKqPw6KnQlfcK5OXuB2AqbO4WRYVoaO7GTfBn+r2IvkNHVdpIUT
 hf8vsCEyNGLNHVYlTaY0vjA8xfsTVa3I++eFJJTLfJ9cNMio5sUUMT26C
 AMJTMehJJoXoZVyhzWGZMXG9q4MNaFnZeo4juYmzFG+Kh1xgv5PZomdW1
 zgbnQV8EEshy9KXTybPDRyzjSyr8FKRG0G/FaDylPAvWFAgJ1BPJYhJ2h
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=DtReAV77
Subject: [Intel-wired-lan] [PATCH iwl-next v1 3/3] ice: add support for 3k
 signing DDP sections for E825C
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
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

E825C devices shall support the new signing type of RSA 3K for new DDP
section (SEGMENT_SIGN_TYPE_RSA3K_E825 (5) - already in the code).
The driver is responsible to verify the presence of correct signing type.
Add 3k signinig support for E825C devices based on mac_type:
ICE_MAC_GENERIC_3K_E825;

Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 6 ++++++
 drivers/net/ethernet/intel/ice/ice_ddp.c    | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 2a973fac8e54..cf4d7287f716 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -154,6 +154,12 @@ static int ice_set_mac_type(struct ice_hw *hw)
 	case ICE_DEV_ID_E823L_SFP:
 		hw->mac_type = ICE_MAC_GENERIC;
 		break;
+	case ICE_DEV_ID_E825C_BACKPLANE:
+	case ICE_DEV_ID_E825C_QSFP:
+	case ICE_DEV_ID_E825C_SFP:
+	case ICE_DEV_ID_E825C_SGMII:
+		hw->mac_type = ICE_MAC_GENERIC_3K_E825;
+		break;
 	case ICE_DEV_ID_E830_BACKPLANE:
 	case ICE_DEV_ID_E830_QSFP56:
 	case ICE_DEV_ID_E830_SFP:
diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index 8b7504a9df31..7532d11ad7f3 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -1825,6 +1825,7 @@ static u32 ice_get_pkg_segment_id(enum ice_mac_type mac_type)
 		seg_id = SEGMENT_TYPE_ICE_E830;
 		break;
 	case ICE_MAC_GENERIC:
+	case ICE_MAC_GENERIC_3K_E825:
 	default:
 		seg_id = SEGMENT_TYPE_ICE_E810;
 		break;
@@ -1845,6 +1846,9 @@ static u32 ice_get_pkg_sign_type(enum ice_mac_type mac_type)
 	case ICE_MAC_E830:
 		sign_type = SEGMENT_SIGN_TYPE_RSA3K_SBB;
 		break;
+	case ICE_MAC_GENERIC_3K_E825:
+		sign_type = SEGMENT_SIGN_TYPE_RSA3K_E825;
+		break;
 	case ICE_MAC_GENERIC:
 	default:
 		sign_type = SEGMENT_SIGN_TYPE_RSA2K;
-- 
2.39.3

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
