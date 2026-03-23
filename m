Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602A9EC01B1
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Mar 2026 09:51:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F1CC86076D;
	Mon, 23 Mar 2026 09:51:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YsddB9cBO0CY; Mon, 23 Mar 2026 09:51:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EF2B36076C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774259462;
	bh=g/5dPMhGk2cuDeLTEgWsH+QIuj/Mt3+dFyP2nzc8lP0=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=6Qcr9hROU9e9iB7ULhe45T3OWnALbaa+fZvZ7uQFycisq7ScDwlDfM201gMBLvoPm
	 lYniRe2jARVgf/+buKmGQMH777QNlJVJ43EwprDeVBGdm7zlAKZ6GqnQzT/bRU7kSc
	 AGO+hbmXGW32m7eOo7MIlF/k3szkMCORIjgEm/iu5Fo53rNnK4YFDjnFha0nFlZB4D
	 ncYHtYsDTOgY1nCoA9b+cJCih8sRvLaUAtNFn7uyz7nE/p2/DCXPNFWomfZVfyJGpQ
	 m4AhsmimF8DOqQvRDvULAp6ymMtJzAbm2s75Kv5G5ZrcrYUKtv8hfSEZwXte0gwnWu
	 yLu6BlXKUU1WQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF2B36076C;
	Mon, 23 Mar 2026 09:51:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1676CF4
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Mar 2026 09:51:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F03F6824DD
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Mar 2026 09:51:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NXH5Fn3Lybss for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Mar 2026 09:51:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6353C824DC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6353C824DC
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6353C824DC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Mar 2026 09:50:59 +0000 (UTC)
X-CSE-ConnectionGUID: MGOwHmMWRciLR8CPyIhhmg==
X-CSE-MsgGUID: P8XFPe7gQoi6QJpPM3OHBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="85877237"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="85877237"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 02:50:59 -0700
X-CSE-ConnectionGUID: yS+VzuQ0S+2nClNtt4BOpA==
X-CSE-MsgGUID: R3MnNwgTSyaAZrbRq4Yyqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="219169351"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa006.fm.intel.com with ESMTP; 23 Mar 2026 02:50:57 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@intel.com>
Date: Mon, 23 Mar 2026 10:50:56 +0100
Message-ID: <20260323095056.3298435-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774259461; x=1805795461;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1AR2k69NDkzn7nG9lUAhkfsYmzx35qOQXPP7hwieuac=;
 b=G8sSQYkLkdbPjufhmVBzfXKXt+AEV3E3rlFgrclbXQ7DVTEI70AE8yRY
 hjzMAS+YPyjp6pGv0kOpyoDSVGfIAF9IykkxhqsgN3NS3KMnc7STTSUgK
 Q6yj1xnQ2PbMhDalVRBuwPGZLJaIsxyvKoetazEGQvmzLt6fVg4uk1+64
 8ri0J5dDU44jM0z+OLzAyZTJubjlIekt7VM0JJfWzLnKMdXcfp1kB8mez
 y/cZAYtFDZRYGdc6LMNMYtFpfA+VSn7/11J/PM+peomCKl/UtEtIWNKoO
 yZGvxvrM2mgxPRqxR+q+/Jizk5c8KpTElXTCBTfcnqcF/jl0CD/M5V/PH
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=G8sSQYkL
Subject: [Intel-wired-lan] [PATCH iwl-next v2] ice: remove excessive memory
 allocation in ice_create_lag_recipe()
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

From: Marcin Szycik <marcin.szycik@intel.com>

For some reason ice_create_lag_recipe() allocates an array of 64
struct ice_aqc_recipe_data_elem elements, while it only needs one (1).
Fix it, while also using kzalloc_obj().

Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v1 -> v2 remove 'Fixes' from commit message because it's not a critical bug
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 310e8fe..70357dc 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -2418,8 +2418,8 @@ static int ice_create_lag_recipe(struct ice_hw *hw, u16 *rid,
 	if (err)
 		return err;
 
-	new_rcp = kzalloc(ICE_RECIPE_LEN * ICE_MAX_NUM_RECIPES, GFP_KERNEL);
+	new_rcp = kzalloc_obj(*new_rcp, GFP_KERNEL);
 	if (!new_rcp)
 		return -ENOMEM;

 	memcpy(new_rcp, base_recipe, ICE_RECIPE_LEN);
 
