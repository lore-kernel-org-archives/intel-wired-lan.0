Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8FAD730A3
	for <intel-wired-lan@archiver.kernel.org>; Fri,  3 Apr 2026 05:40:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A8FF340FCC;
	Fri,  3 Apr 2026 05:40:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FHIbxjydmoeC; Fri,  3 Apr 2026 05:40:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E1E5540F09
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775194842;
	bh=wwhaw3Mb/PAU1ZMqSw+ChxWy7XnN8oXrpnBRuLb5GZI=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=yx4niWi2RW70Aj3ACVVdT8v0UWie5JmJ/bXyo0EOFi5HoHepv5q4qIuKE+or35AXZ
	 bpITegjo7xjt4+nnFZki9KQVpL2zPxDFKVG/O71g3uOxeyv2SUeNG++YJi7dR/Lle4
	 p3ZxKCOw5TJZYt7feIZJG2AtVJGoxCoWGsHQ1CLe2JuTObOSY7uKosL9ajHkRkJVFh
	 s1lTUWAjdoSV3xduUqQv2NVA0MLQdQCApcx+C3jfTKs4rwnBo+cTTg66uGpvev5A+5
	 GB8TcZyOpaAPkMXAC4imuIkagR19ijV9PtuYwiMh/dKam7w2wRLu1Zziz72rMtUzGw
	 8daphs28oXzwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1E5540F09;
	Fri,  3 Apr 2026 05:40:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5BA931F3
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 05:40:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 597204008E
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 05:40:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2tKOJ_mkNEiC for <intel-wired-lan@lists.osuosl.org>;
 Fri,  3 Apr 2026 05:40:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 563C240071
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 563C240071
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 563C240071
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 05:40:41 +0000 (UTC)
X-CSE-ConnectionGUID: K+9YpLFPSRW0FWorKup2iw==
X-CSE-MsgGUID: AQLlEyiqSEeZ5/SXYWGmqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75981751"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="75981751"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 22:40:41 -0700
X-CSE-ConnectionGUID: Qu7YQQCGT6aSwzqriAdn2A==
X-CSE-MsgGUID: R/t7P284T+yjc6nkPXFTPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="223904942"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa007.fm.intel.com with ESMTP; 02 Apr 2026 22:40:40 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Date: Fri,  3 Apr 2026 07:40:25 +0200
Message-ID: <20260403054029.3789616-8-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260403054029.3789616-1-aleksandr.loktionov@intel.com>
References: <20260403054029.3789616-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775194842; x=1806730842;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HT6+6y8kHjKZwAKXO8d3OVYIhr1SnK+5U5KWva9Y6hU=;
 b=Kf+EfEXmeAljfrLKgHAkt6dns4O9HGkMYrl/QlpT3/qiPEUDCBmfy3WY
 kxVCK3V4t3noi+T/IJer+KA500bcwK6Z5/UkJGXfqHPuDXXJZQoG6BGpB
 L3a2ixA0t6G3g4eIvhRngT1Yj+jbrCvsLn9lqiWsijurm0M9TEqY/eEHJ
 PvIY6ZT95gryfLAsVRjUt4GdMisL22sBE3XxJk/N3sTFESlv/ONBHD422
 KILIBFDB6Kdh18Ih/SAUkz3zrmTnKz2uPhusJwxYkUqEfI7YAn7XI0Lzh
 1EizFULF6qR+H0AMnRAKNrIIvLgDo0r8/NjJtj/3EPGlEfwVnB78frSvS
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Kf+EfEXm
Subject: [Intel-wired-lan] [PATCH iwl-net 7/10] ice: fix missing 50G
 single-lane ethtool link speed mappings
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
Cc: netdev@vger.kernel.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The ice_adv_lnk_speed_50000[] map is missing the single-lane
50G modes: 50000baseCR_Full, 50000baseKR_Full, 50000baseSR_Full,
and 50000baseLR_ER_FR_Full. When a user tries to advertise one
of these modes the driver prints "Nothing changed, exiting
without setting anything." even on hardware that supports them.
Add the missing entries to fix the mapping.

Fixes: 982b0192db45 ("ice: Refactor finding advertised link speed")
Cc: stable@vger.kernel.org
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 44483bc..0279cc5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -389,6 +389,10 @@ static const u32 ice_adv_lnk_speed_50000[] __initconst = {
 	ETHTOOL_LINK_MODE_50000baseCR2_Full_BIT,
 	ETHTOOL_LINK_MODE_50000baseKR2_Full_BIT,
 	ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseCR_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseKR_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseSR_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseLR_ER_FR_Full_BIT,
 };
 
 static const u32 ice_adv_lnk_speed_100000[] __initconst = {
-- 
2.52.0

