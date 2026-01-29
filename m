Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A382D73E81
	for <intel-wired-lan@archiver.kernel.org>; Thu, 29 Jan 2026 17:33:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E83840C4A;
	Thu, 29 Jan 2026 17:33:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OXZ4NGwhXCWM; Thu, 29 Jan 2026 17:33:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BFC5E40C42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769708036;
	bh=iGrxPtow25DQCg7gYX4cuizprfQXIsgOmTd0n3Na5VQ=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=P9la2gk+TgVbBSzOqun/S6FLU9Fot4jQgYsj8UjBIcRHtAkAFL4VhTfVwwadQOZQX
	 mYMJ7HrzWJgs6ifybb8Cf+AbPj0ENVdwq4KWLFRclPcoaAWyc1/VGZg2e1U+ih1pfq
	 KG4RfLymjb7Eudyyr2r+6EfykGlTKZpZTLFJVSOmSYw5J0QZZ+IRsL2gGphsk5HBRG
	 Ush/J10tDIo4dpYLRhvmIFlVKSRBxmti6Z/PU/O0CFQcTakQ1RWD0Aw7Q+lqMm5CDB
	 XHq504cBdC24ivJCpojgLH8zs3YZaKkHbN/mcCfhFF+k8WSMl2PI3FKXMCpDiLtciW
	 hzL/4O8wXw3ow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFC5E40C42;
	Thu, 29 Jan 2026 17:33:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E4932CF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 17:33:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8144683E42
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 17:33:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q0MNDaxhstfV for <intel-wired-lan@lists.osuosl.org>;
 Thu, 29 Jan 2026 17:33:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=piotr.kwapulinski@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org CCBC683C90
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CCBC683C90
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CCBC683C90
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 17:33:53 +0000 (UTC)
X-CSE-ConnectionGUID: PkWPpg5eSdmlGABH0TSTDg==
X-CSE-MsgGUID: hvHgIUSyS2GSl7Jxz7j/4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="70669875"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; d="scan'208";a="70669875"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2026 09:33:53 -0800
X-CSE-ConnectionGUID: 4X0A2IIfTjq0eptgPZDixw==
X-CSE-MsgGUID: TehO8w2/S227xSzpkeJksQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; d="scan'208";a="212714930"
Received: from amlin-018-252.igk.intel.com ([10.102.18.252])
 by orviesa003.jf.intel.com with ESMTP; 29 Jan 2026 09:33:52 -0800
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, dan.carpenter@linaro.org, horms@kernel.org,
 pmenzel@molgen.mpg.de, Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Date: Thu, 29 Jan 2026 18:54:55 +0100
Message-ID: <20260129175455.174241-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769708034; x=1801244034;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wvvhLxpUEzjH/aPyrEvcmEFhPUBwZcBiCHVY0w9yFpE=;
 b=FZdCRG/Gwx14Pd84GDbv8mLeSHsoO8yuMXlBASbV8b8BNsOxLkeFNY+q
 NzdqQa1gBMXGa7RaMs6+kI2HR+XlkhyCgo14S0ymVmOl/1SbxAVnDWCMk
 Bw5wNzfaP3zw24wy+rQl3JmXucTziMqLBuq+6Y/00UXw9dyu61Wp80OoK
 mL2LiwnNq7fPgm0pc8CVfijpXCzTRzvnUBaSY8dB3X+QKi6G9D/8NOW2y
 GerPONdZVhaUm2Svxw3kV6thNGI3qinjh5FbX/j3gd0nOHbD2kFRuYMuL
 msWqCTBdljUw8qy9Glc2g9r4K8xrAMwiU9i/8AquxRSXNWXM1NOu6ftQ6
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=FZdCRG/G
Subject: [Intel-wired-lan] [PATCH iwl-next] ixgbe: e610: remove redundant
 assignment
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

Remove unnecessary code. No functional impact.

Fixes: 46761fd52a88 ("ixgbe: Add support for E610 FW Admin Command Interface")
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index c2f8189..6f380fc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -142,20 +142,14 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
 			  IXGBE_PF_HICR);
 
 	/* Read sync Admin Command response */
-	if ((hicr & IXGBE_PF_HICR_SV)) {
-		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
+	if ((hicr & IXGBE_PF_HICR_SV))
+		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
 			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA(i));
-			raw_desc[i] = raw_desc[i];
-		}
-	}
 
 	/* Read async Admin Command response */
-	if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C)) {
-		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
+	if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C))
+		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
 			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA_2(i));
-			raw_desc[i] = raw_desc[i];
-		}
-	}
 
 	/* Handle timeout and invalid state of HICR register */
 	if (hicr & IXGBE_PF_HICR_C)
-- 
2.47.1

