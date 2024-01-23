Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544D7C47DDB
	for <intel-wired-lan@archiver.kernel.org>; Tue, 23 Jan 2024 23:32:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D860C8543E;
	Tue, 23 Jan 2024 23:32:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D860C8543E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1706052734;
	bh=JOTYvsBQTtuBU5IyQ1KLl7dydeoeFxYwhT56x+dPAjE=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=CIcxSVFVluRQrjLmGvOTUZdLAmyTpuIMB7Tb9kFn5F49H1FEF4JLA7cNZ5w6rRom0
	 J/kHVxgQQ8Af3PCzSMdZF9EWAFXo6LiGX9KmIabo3UM1Z+mMfeD6h34vI5j7MOIrSq
	 mjfkTQ5t8kBOC/T3FjSH+nCWvWkJYTMsMMrP6ElkjLcIsCxjJtIunCRM0EWv7b8LdU
	 FKuPAZBP8qncMGBYyLtTX4WVfuerxlb9WLwEoLZWW3E7F2sH1969imGzp9rNXGGAwb
	 NtF7dnknwqH9+0PwovN7ZCFA8INLeTuA3i5kXCm9vvGZ6rNpIOkARBYU0OraWhv7dI
	 wrveYkk5psP3g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HZbvjt4eFteP; Tue, 23 Jan 2024 23:32:14 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 157E38542F;
	Tue, 23 Jan 2024 23:32:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 157E38542F
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id D364F1BF84C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jan 2024 23:32:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AC7FA8542D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jan 2024 23:32:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AC7FA8542D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hHM57U-VF4Hj for <intel-wired-lan@lists.osuosl.org>;
 Tue, 23 Jan 2024 23:32:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9E7A28542B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jan 2024 23:32:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9E7A28542B
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="400552166"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; d="scan'208";a="400552166"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2024 15:32:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="909469425"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; d="scan'208";a="909469425"
Received: from gkon-mobl1.ger.corp.intel.com (HELO azaki-desk1.intel.com)
 ([10.252.41.99])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2024 15:32:01 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 23 Jan 2024 16:31:39 -0700
Message-Id: <20240123233140.309522-2-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123233140.309522-1-ahmed.zaki@intel.com>
References: <20240123233140.309522-1-ahmed.zaki@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706052727; x=1737588727;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Qnk+CLXPsz3J+1HCOsUazVYd2TdrH4w8Yw3fWliKBk4=;
 b=Nar33ixm+OAHbD0fUVL5xbVOk0aqpPLLJwuqPTlEMVahsVBpG2gEf0Nz
 tAKUtX0i5dfl7WPuFMUVNbWA0oUEUresiCaQb3GjuMkwbJbrxzdSYT4tF
 TI7M+024c9wy4W2mEM/yo2ngEKCZjVu5KkQJrvshWUTUKEaDufdVKkGos
 guzwzDwEInSWTFheRTBbqZeLzaWRzCrWvm7x2Omc6WEptTvrSEHo31EgZ
 eYEV+s2XIDi+twuBfmByHFuA4n9MFapAFLo+9G3QnuZiCdq1/UJRHl7WH
 tWJrc3+mtLfPHkIVFp7DAx8fTXq2tFRME4sXusvFyxASC787zrvyOWI4g
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Nar33ixm
Subject: [Intel-wired-lan] [PATCH iwl-net 1/2] iavf: fix reset in early
 states
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
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The iavf_reset_task() assumes that the adapter has finished the
initialization cycle and is either in __IAVF_DOWN or __IAVF_RUNNING.

At the early states, no resources have been allocated. Allow an early reset
by simply shutting down the admin queue and reverting to the first state
__IAVF_STARTUP.

Fixes: 5eae00c57f5e ("i40evf: main driver core")
Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 335fd13e86f7..e1569035d5d0 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3037,6 +3037,17 @@ static void iavf_reset_task(struct work_struct *work)
 	}
 
 continue_reset:
+	/* If we are still early in the state machine, just restart. */
+	if (adapter->state <= __IAVF_INIT_FAILED) {
+		iavf_shutdown_adminq(hw);
+		iavf_change_state(adapter, __IAVF_STARTUP);
+		iavf_startup(adapter);
+		mutex_unlock(&adapter->crit_lock);
+		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
+				   msecs_to_jiffies(30));
+		return;
+	}
+
 	/* We don't use netif_running() because it may be true prior to
 	 * ndo_open() returning, so we can't assume it means all our open
 	 * tasks have finished, since we're not holding the rtnl_lock here.
-- 
2.34.1

