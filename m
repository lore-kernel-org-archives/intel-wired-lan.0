Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1E0C4167B
	for <intel-wired-lan@archiver.kernel.org>; Tue, 28 Nov 2023 18:35:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A91C81F42;
	Tue, 28 Nov 2023 18:35:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3A91C81F42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1701196517;
	bh=7wI9jW1/WPYssMnCKTDUSlIdayugKDl2d/ayAFnw27Q=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=MzQFVOS4G5GNL+wcMFeF84qlhiG0E15eRWCkgC27u+KCQOEOxtAHzUgSqf8tww1PR
	 Pfyeci7veAaa46TZTqymB4b3zQYlKD1J1nXMUj8t70LuskErWJpaKrz0UopZifsqwT
	 Y9CC4Au4Igj+9nOhUNKwQu43R2vohuA0eY1J4bYY8GjOKYr0MK5QMy/B2z3PCKIL59
	 lXmzBJFXRxfX7N5zgpUw0z3zqAxcvo/jWjb47gU/r5Jhrd3QSXNTQ6HdjpD1ZowNVG
	 TvQ7NCPV5MHPzofO/5DHHB/2S7acnCg33QKf0w8h9Q2dBzLsek5fh9dZMfJwVlPd/c
	 2ndctcgf59WcQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PIhH5k-12uLh; Tue, 28 Nov 2023 18:35:16 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5876F81F3A;
	Tue, 28 Nov 2023 18:35:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5876F81F3A
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 075411BF28F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Nov 2023 18:35:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D2A7381F3A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Nov 2023 18:35:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D2A7381F3A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cQvb04k3uFqf for <intel-wired-lan@lists.osuosl.org>;
 Tue, 28 Nov 2023 18:35:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CC08181EBB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Nov 2023 18:35:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CC08181EBB
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="390142835"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; d="scan'208";a="390142835"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Nov 2023 10:35:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="803027246"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; d="scan'208";a="803027246"
Received: from sbahadur1-bxdsw.sj.intel.com ([10.232.237.139])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Nov 2023 10:35:12 -0800
From: Sachin Bahadur <sachin.bahadur@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 28 Nov 2023 10:35:05 -0800
Message-Id: <20231128183505.1338736-1-sachin.bahadur@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701196513; x=1732732513;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=3XrKzGgorsTXEq5Z259hGATFbw7UsEoW85mUltUx3Mc=;
 b=JqoexW5OAU6W4g1yQquzEGlr+C8DXZ4MlMf9LRwCJMKZmYY8GTxQzrRZ
 ei51E+5lk/rIif1GIkouu0WEtOOz1/MXTwIVLsH4OURu8mFKe2+GQExqQ
 Ey2a3uTRyMWgfCUeDG1ka+TQ8QO3y0N/2Sx30RIvZKBIbt/r+DrrKFqXq
 BvrNcBTsaqyMUA2AXKWlErqmlhCV3uTUxhSNQ3E3HnOsF/DvPCkgXx43U
 cmgBFqr2A98GJZAV08saPh4sleBSrGPuYbaxNZZnZiPuhcYXD6iMUdJhC
 YJEiM/vpPzrVPxjgMzmQagXcNoqUUumW52rKm1aDbBRpLXk3BWfnfNC49
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=JqoexW5O
Subject: [Intel-wired-lan] [PATCH iwl-next v1] ice: Print NIC FW version
 during init
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

Print NIC FW version during PF initialization. FW version in dmesg is used
to identify and isolate issues. Particularly useful when dmesg is read
after reboot.

Reviewed-by: Pawel Kaminski <pawel.kaminski@intel.com>
Signed-off-by: Sachin Bahadur <sachin.bahadur@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 1f159b4362ec..71d3d8cfdd1d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4568,6 +4568,12 @@ static int ice_init_dev(struct ice_pf *pf)
 		dev_err(dev, "ice_init_hw failed: %d\n", err);
 		return err;
 	}
+	dev_info(dev, "fw %u.%u.%u api %u.%u.%u nvm %u.%u 0x%08x %u.%u.%u\n",
+		 hw->fw_maj_ver, hw->fw_min_ver, hw->fw_patch, hw->api_maj_ver,
+		 hw->api_min_ver, hw->api_patch, hw->flash.nvm.major,
+		 hw->flash.nvm.minor, hw->flash.nvm.eetrack,
+		 hw->flash.orom.major, hw->flash.orom.build,
+		 hw->flash.orom.patch);
 
 	/* Some cards require longer initialization times
 	 * due to necessity of loading FW from an external source.
-- 
2.25.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
