Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58517C64ED6
	for <intel-wired-lan@archiver.kernel.org>; Tue, 28 Feb 2023 08:49:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5A7C41798;
	Tue, 28 Feb 2023 08:49:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B5A7C41798
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1677574164;
	bh=OQXhlB+VpBT+svGazCUpFCSbDjRmVcJPIWswq2yeGaE=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=Wia5B4ArN/bVUeVfoM9pVWKtXpOPlxtctPF4w4GDXlyIWBGFKraPjQb/zgda6ruML
	 FYCfHh01ANBHgQebuBeOZrzblP2xhbpLM8hyJp2l2DZHgBvoVDbWNzT9WLgA01N8F5
	 2bFiHhOjSEH1A9BsBsj5iSXwDLaLJiDUhtpVmtdQm+mgPuA9iCvvx0D9fokMEgSV7B
	 xtAA0cfIvsLPLuOywt5QjGmF25/PIVKYoTt1VyIobCRGvl28+hPDZVJRuzDGvNzYoz
	 cSzNLbO3CCL0FKGCOjq/XhjTPCFLF7cjtiKobFcvmECWHnzKXNk3wW79/pG8c146A7
	 K3qxg25IYzg3w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ID9YaNHFM_Uc; Tue, 28 Feb 2023 08:49:23 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 86E99410E5;
	Tue, 28 Feb 2023 08:49:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 86E99410E5
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id D5C4D1BF2BE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Feb 2023 08:49:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ADA98402EB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Feb 2023 08:49:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ADA98402EB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vJYzlchfMjSz for <intel-wired-lan@lists.osuosl.org>;
 Tue, 28 Feb 2023 08:49:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9E290400D6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9E290400D6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Feb 2023 08:49:20 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="317884827"
X-IronPort-AV: E=Sophos;i="5.98,221,1673942400"; d="scan'208";a="317884827"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2023 00:49:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="706506987"
X-IronPort-AV: E=Sophos;i="5.98,221,1673942400"; d="scan'208";a="706506987"
Received: from unknown (HELO fedora.igk.intel.com) ([10.123.220.50])
 by orsmga001.jf.intel.com with ESMTP; 28 Feb 2023 00:49:18 -0800
From: Kalyan Kodamagula <kalyan.kodamagula@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 28 Feb 2023 09:49:15 +0100
Message-Id: <20230228084915.2866564-1-kalyan.kodamagula@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1677574160; x=1709110160;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=rANLstLET0Aycwc4eLGO/FmMZPbbWRwyVJE64zPhCwA=;
 b=ER0qLRmjB1ZNSuMm7qPHRUryZheDgPvPVkQEEgi2VC+EzhYu9ruFGYsk
 5jgxjrI/mwVwFRT2Eo3WMRcc/Myfw7XV+r43XwMJM1dpFTcZ9TQACYXFm
 5RsmJrsaQW9rDnEtwcmEBGfK+gelk7jEEEd2erSM6XkmwAyNboDUjoPab
 XUzuzDoX9C5Ib6ktxfdNkVuRWviNV3QrpqASGTvqL2JRmzJGrhJnFnDgD
 5U9iBzXKFh4VaVOOi3NwkF6ZjzlU161a6EcPcCZyliImPUDb0oQU0W4h5
 frdsX4Kmpxlu0tmh4A8yT/xknFzoyy25DtFV+KbK/k16O8Q6NRmIL5f1b
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ER0qLRmj
Subject: [Intel-wired-lan] [PATCH net-next] ice: Fix implicit cast u32 to u16
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
Cc: Marcin Szycik <marcin.szycik@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Marcin Szycik <marcin.szycik@intel.com>

Fix implicit cast by changing argument types of two functions to correct
types.

Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
Signed-off-by: Kalyan Kodamagula <kalyan.kodamagula@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ddp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index d71ed210f9c4..830fa53b5e0a 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -701,14 +701,14 @@ struct ice_buf_build *ice_pkg_buf_alloc(struct ice_hw *hw)
 	return bld;
 }
 
-static bool ice_is_gtp_u_profile(u16 prof_idx)
+static bool ice_is_gtp_u_profile(u32 prof_idx)
 {
 	return (prof_idx >= ICE_PROFID_IPV6_GTPU_TEID &&
 		prof_idx <= ICE_PROFID_IPV6_GTPU_IPV6_TCP_INNER) ||
 	       prof_idx == ICE_PROFID_IPV4_GTPU_TEID;
 }
 
-static bool ice_is_gtp_c_profile(u16 prof_idx)
+static bool ice_is_gtp_c_profile(u32 prof_idx)
 {
 	switch (prof_idx) {
 	case ICE_PROFID_IPV4_GTPC_TEID:
-- 
2.39.2

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
