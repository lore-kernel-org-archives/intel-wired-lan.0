Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EC0CD4F5B
	for <intel-wired-lan@archiver.kernel.org>; Tue, 19 May 2026 12:21:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5D9A40B2E;
	Tue, 19 May 2026 12:21:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7KT-qcsU--BR; Tue, 19 May 2026 12:21:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DAF7040AF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1779193281;
	bh=z0B2cJTMqzvmiq+9Hs3Q3Zteo9BRj6sFxiZZqDLdiZA=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=2Sy4jbvX8lm8GEgicdroPWnk9Jvyn6i8aMSAYfA3WEJbh4wwnBOd/tfNySJayIVBe
	 535IReVEtD89eBGoxn1vhZgDE4dgbvDpPNhiuZBwwocM2sJXVYMlB287gUbuAxq/yk
	 OWJYYfKPitSyChxqCOax9ZaJ3Ws2Q5Vc6RhfH06eYGd5IEZT5s58TvC5l69kbrPBBu
	 0DUipNfyhrkPmX9BZwGX4M8g8CacLQ8SuJ2iH4HfWjt//w+DKxiCDdQKh/1lM3ZKNI
	 ujRSIb869EVD581+oAHyC3Gx7iwVzEL/8F1/JZsejJOI3fG42cp3mylzHWa2J/bRQl
	 Ky4nNuUzyftug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DAF7040AF6;
	Tue, 19 May 2026 12:21:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AFBA4282
 for <intel-wired-lan@lists.osuosl.org>; Tue, 19 May 2026 12:21:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 957B860909
 for <intel-wired-lan@lists.osuosl.org>; Tue, 19 May 2026 12:21:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mog8lrwRv9G6 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 19 May 2026 12:21:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=marcin.szycik@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 962CC60902
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 962CC60902
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 962CC60902
 for <intel-wired-lan@lists.osuosl.org>; Tue, 19 May 2026 12:21:19 +0000 (UTC)
X-CSE-ConnectionGUID: A8ehdSmFT0Sr2R+W1I8hsQ==
X-CSE-MsgGUID: Dtddx81cTfuYZw2EOMd59g==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80048318"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="80048318"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 05:21:18 -0700
X-CSE-ConnectionGUID: kGmWhDvgRDGtKOqOmV/IZA==
X-CSE-MsgGUID: C7TeWnBBQkazB3t5dD/MtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="263533568"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa001.fm.intel.com with ESMTP; 19 May 2026 05:21:17 -0700
Received: from gond.igk.intel.com (gond.igk.intel.com [10.123.220.52])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 5B18528765;
 Tue, 19 May 2026 13:21:16 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Marcin Szycik <marcin.szycik@linux.intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Dave Ertman <david.m.ertman@intel.com>
Date: Tue, 19 May 2026 13:20:41 +0200
Message-ID: <20260519112041.125907-1-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779193279; x=1810729279;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4YPC6McjepweewladknEsCxM3GMex0C/sNPCjbzCacw=;
 b=Z9feTK7Si78cfu6srkcKLjZvWpDWDDfU7IxRM4Av6EY5JJUZ1xhSi1af
 p5BtNMRcjXoLnGiW5sDiqc0P+XGtdhHZtogAev9XArPlxCVzpdrdS4Eqm
 TAov/0hXJTJlgrls7wTZCz0tYfMp1fNPs2//il+XWIM9Ou+wAI4Iuov0S
 PgP+Gw5rb8jrt24aInlqM5iU1AnlWud7Q9fxTT5wHVqjiSsOXDhwMNMqO
 Bsis5nYnw0DaS8IIumCfaJEgHlD39ELujK7TsJAhtjiHE0V9s2x+7SP42
 cBWL3alA1wqi9jOJ2w1EnN6ETsQNnNbtmf3sLutgFieDj5M59/R3Q4axA
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Z9feTK7S
Subject: [Intel-wired-lan] [PATCH iwl-net] ice: fix LAG recipe to profile
 association
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

ice_init_lag() associates recipes to profiles, assuming that Link
Aggregation-related profiles will always have profile ID lower than 70
(ICE_PROFID_IPV6_GTPU_IPV6_TCP_INNER). This value seems arbitrary and
might not always be valid for some versions of DDP package, i.e. LAG
profiles may have profile ID greater than 70. This would lead to
misconfigured switch and LAG not working properly.

Fix it by checking up to maximum profile ID.

Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support for SRIOV on bonded interface")
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Dave Ertman <david.m.ertman@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 310e8fe2925c..08a17ded0ad5 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -2623,7 +2623,7 @@ int ice_init_lag(struct ice_pf *pf)
 		goto  free_lport_res;
 
 	/* associate recipes to profiles */
-	for (n = 0; n < ICE_PROFID_IPV6_GTPU_IPV6_TCP_INNER; n++) {
+	for (n = 0; n < ICE_MAX_NUM_PROFILES; n++) {
 		err = ice_aq_get_recipe_to_profile(&pf->hw, n,
 						   &recipe_bits, NULL);
 		if (err)
-- 
2.49.0

