Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915A2C4828F
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Feb 2024 21:27:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3C22941CD8;
	Fri,  9 Feb 2024 21:27:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YvrelKeZAu9d; Fri,  9 Feb 2024 21:27:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8AB2B41BFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1707514071;
	bh=vBQz/TZGSj92BCu4uAF8I7gXj0KXmIsJkcwzNJ4wBoU=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=ixRgY+Z7qCmmtfE3C3CSpkqQFOpBLDaGiiI1dU4MnQseTIOtPB3FDHzqOK7qRmMow
	 //qiKew+1GZY/0IkXke7n8t99BaY+fA82ocePBIJb5k4tm0sj98nJaPI5Ay2QLUKqq
	 lWUPEEkWXYtv5N/6RQ4jtB4Sr0s0xCX6nPVho/AXblrKWqVl4TVsS6rv6hw/kWV3Wl
	 PgfPr1peyN4INn1ttJGkSsvL+/jF3nvRH6bwBH9OjQ2M/YaEctSEIZMZpRKErLHDZe
	 ZaoF6AIMXlbYVGfgYwKoLpqiuB4JWS4WdYYRffBI8ApMFDIemaXGqc7XJZayRQdg8P
	 8xCLBjo3izGpQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8AB2B41BFE;
	Fri,  9 Feb 2024 21:27:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 4646E1BF3AE
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Feb 2024 21:27:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A214A40173
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Feb 2024 21:27:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kxtWq6yMScSw for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Feb 2024 21:27:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=arkadiusz.kubalewski@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BD41D400D0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BD41D400D0
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BD41D400D0
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Feb 2024 21:27:45 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="5321573"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="5321573"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2024 13:27:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="6681840"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
 by orviesa003.jf.intel.com with ESMTP; 09 Feb 2024 13:27:44 -0800
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Fri,  9 Feb 2024 22:24:31 +0100
Message-Id: <20240209212432.750653-3-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240209212432.750653-1-arkadiusz.kubalewski@intel.com>
References: <20240209212432.750653-1-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1707514065; x=1739050065;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/zLFYfKrCHlgzoG+Jis0BmozSOrd3qxox8x2jrMAiLI=;
 b=Vw7q2Eo4t19OP35BkTfwNWuUqZPJdgUjSIJqOFTI/KaIqYLXKDwytL6m
 UMUrmFNzEHMQJqE8Zmpe7ZA2q8hpVSxzaoebJpovyaFje2Gid2oWF0CrF
 sCoe21Mo9QxTZRovAFyGJKXTnlnpLJcBCxv6UyC2AsuF7nzHiqvIej9l4
 DIafBMPuG1q2SB6Q4IBUWKdnPQOuSmtoGlXXtaBB9ehvAerNOGu2V3avq
 0DpsZ3C/vEnEmTSFoEwBTTq1IwdRFzNtwkBJTuZxc0eCod4oIDxfhh9e7
 iVnA8QF+iKHEOC0EMWQB6ybGe1VpRbYV+F0VBrsgWapPyY7cCxwGhOzSb
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Vw7q2Eo4
Subject: [Intel-wired-lan] [PATCH iwl-net v2 2/3] ice: fix dpll periodic
 work data updates on PF reset
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
Cc: Igor Bagnucki <igor.bagnucki@intel.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Do not allow dpll periodic work function to acquire data from firmware
if PF reset is in progress. Acquiring data will cause dmesg errors as the
firmware cannot respond or process the request properly during the reset
time.

Test by looping execution of below step until dmesg error appears:
- perform PF reset
$ echo 1 > /sys/class/net/<ice PF>/device/reset

Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 58d135764ab0..544cfedf6c55 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -1364,8 +1364,10 @@ static void ice_dpll_periodic_work(struct kthread_work *work)
 	struct ice_pf *pf = container_of(d, struct ice_pf, dplls);
 	struct ice_dpll *de = &pf->dplls.eec;
 	struct ice_dpll *dp = &pf->dplls.pps;
-	int ret;
+	int ret = 0;
 
+	if (ice_is_reset_in_progress(pf->state))
+		goto resched;
 	mutex_lock(&pf->dplls.lock);
 	ret = ice_dpll_update_state(pf, de, false);
 	if (!ret)
@@ -1385,6 +1387,7 @@ static void ice_dpll_periodic_work(struct kthread_work *work)
 	ice_dpll_notify_changes(de);
 	ice_dpll_notify_changes(dp);
 
+resched:
 	/* Run twice a second or reschedule if update failed */
 	kthread_queue_delayed_work(d->kworker, &d->work,
 				   ret ? msecs_to_jiffies(10) :
-- 
2.38.1

