Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3EBE9B36D
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Mar 2026 11:59:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B15626124B;
	Mon,  2 Mar 2026 11:59:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PIzRHfZykXe1; Mon,  2 Mar 2026 11:59:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 545EA60FD4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772452766;
	bh=2tD5mH9jNnN8kCh71S9sg45QzWdGd2pghLYTNE9OBYE=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rSJA++N5vOdqYd6bN3y6RB0e2JAB/jJ3t31RjljOjS4VZ5hQDYxN1E06ypV2trka2
	 OQtTfKdVz66h4Fy+UEZBclWUw/gzwk9MmngUNnTslZPLYk93kCcM7rOSVHF8xScD1g
	 k91dkOjy79RMLR8ib96xQLtqQz06JBAcWqgm4l3SZIdPkqPcU1ZQHT3KMSUL+RGA9h
	 5InV0tJUjtdYiv81Kk631MbscVW/5xyQR0Y5h59sjqtC1itEjqEB8smvJRaf6WnSjA
	 LnO04ni9vwOs6ayAbASrqLTtC4gO8zX8CpF0T7EHU24ehNHNEQF/Rjk2oV4kQQsfqw
	 vaeI4lIrXDAEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 545EA60FD4;
	Mon,  2 Mar 2026 11:59:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5CBFB1EB
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Mar 2026 11:59:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4E14F412A5
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Mar 2026 11:59:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bbNWMo-ke-kz for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Mar 2026 11:59:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=przemyslaw.korba@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C5C7C40724
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C5C7C40724
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C5C7C40724
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Mar 2026 11:59:22 +0000 (UTC)
X-CSE-ConnectionGUID: yJ422Ku2SLiSNG4xqY7s3A==
X-CSE-MsgGUID: SF6+DygXQBWnJcSszt9TLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="73568226"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; d="scan'208";a="73568226"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 03:59:22 -0800
X-CSE-ConnectionGUID: 5OFrZn9vQ9WCxyx+u2Ihiw==
X-CSE-MsgGUID: V6JRpJeBSxq8W2HGz3grng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; d="scan'208";a="216095873"
Received: from pae-d-dell-r7525-263.igk.intel.com ([172.28.191.240])
 by fmviesa008.fm.intel.com with ESMTP; 02 Mar 2026 03:59:20 -0800
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, Przemyslaw Korba <przemyslaw.korba@intel.com>
Date: Mon,  2 Mar 2026 12:59:40 +0100
Message-ID: <20260302120044.298362-1-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772452763; x=1803988763;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=0SQavlJE1tFWPxlo5oSgcJMUbpV7Y+RT1GMZ3NqL/QE=;
 b=gjsWTalTEi0LK8wX9I3rT70OZ/6LIJKOl4iPuwG2FnWwkCgnhx3wfCEn
 U7BDOf3lx+OLWfxyeMnZAThTXVODJvAEQeYwR4ZoxtknfD9HMh8cvyQiK
 ORgM1ZMWQy3eY3dMGvTOWyKJs+mLqv3U5fzgyvU6Cjp/ZbcjAZEN6jpOI
 YXbW/ng7T4VkNfesShE95eKDzu2C3eVvDoXYcWr95zKO77S0og6Fa+sMj
 O9HvyIgW7RJEVvImESD0zk71VUy7hl5iVsB4gxoALqxDaOceYbS/kgTZP
 tmxlSDpNyXbCMSJ4qnb7HMWWn2ml9n8o8xtgOloTlPJgYu4I2zAZ2p3nB
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=gjsWTalT
Subject: [Intel-wired-lan] [PATCH iwl-next] ice: dpll: Fix compilation
 warning
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

Introduced by commit ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and
dynamic pin discovery"):

ice_dpll.c: In function ‘ice_dpll_init’:
ice_dpll.c:3588:59: error: ‘%u’ directive output may be truncated
writing between 1 and 10 bytes into a region of size 4
[-Werror=format-truncation=] snprintf(pin_name, sizeof(pin_name),
"rclk%u", i);

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index e7d37a2fd1a2..1d89372b4840 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -3605,7 +3605,7 @@ static int
 ice_dpll_init_fwnode_pins(struct ice_pf *pf, struct ice_dpll_pin *pins,
 			  int start_idx)
 {
-	char pin_name[8];
+	char pin_name[16];
 	int i, ret;
 
 	pf->dplls.wq = create_singlethread_workqueue("ice_dpll_wq");

base-commit: d5fbc991435eac7a1ead7cd2ddb5a743528718bb
-- 
2.43.0

