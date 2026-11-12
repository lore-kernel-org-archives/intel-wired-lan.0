Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48446606A321
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Nov 2026 10:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=XcInwTvo;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KEV9t/cR
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 269416081A;
	Thu, 12 Nov 2026 10:21:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oOCbVbsOioWT; Thu, 12 Nov 2026 10:21:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 620CE60733
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794478911;
	b=mVuyIP4o006CfbITVLVeKPafK4FzZS79k5gcxkf0CJv/Pw5Xilyg+gB2qzlsFAF9iSvb
	 ZQz9hjaGEsq2vy6feOgwT/+RVCP6KKCRwZIrQSxvqnEu7a3yCRW0Ih5WEukdikBRR7ike
	 srOQR3BPuVqaPcjkSXirwnWSOY/eCApCl95E0JuRjR76Vsa+XO4wXXreX8ICtkV01vPVM
	 mE3KVrs2PVv5/GuYODrbHvMCQJHB3lWel+LnL+CX7Ug81vi1OXErwGYTf1Ms77R2FDvxW
	 05HF+2Ii51MduGzvMqNAQblgKZqdK5Em90EG63jUCmxRgZpihHtWDugpEi2RuDj3Rzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794478911;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1n5mgnz6UvLoqWNhz9tjze/ocmQDb+0D4Lcz+o1EE9Y=;
	b=QuM99W/JZGHT/nGeQicVIW0+BUvDVLOwlihYwhXYRugnQEDdmSC8BiWnZfnTfi+McDdl
	 zIHyXoWblRKEfyIqs9SnZdKtv8OCQVHk+hQkLQkvSNj4Cp8KaFEDLgzD1vr/huynsbUZT
	 +mglnamwvQ/06tuiR/+LzApMWAQGtSsNiRLC/uUcETue0hIjsxKgf3YST8D0GEv38kVdo
	 nuaaudgFuQzSMCkpiqV0aAQhM725u9G1OxFQTIG5e+avVTkftP0+LiPvdkKACWOVVDH+2
	 ii3qk0L5ymEbwR07pWipN34w7aVOaIurM/U60B3JXKoPJKMjt/Plwm9GLX6jWrfcT5A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="KEV9t/cR";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794478911;
	bh=1n5mgnz6UvLoqWNhz9tjze/ocmQDb+0D4Lcz+o1EE9Y=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XcInwTvoXlwUKTTZ4jGtxqw05+plG4lHj880gew4sXaevj+HUsdjK6nGQZE5zuMGe
	 LmGvyFtdeifJyR0HdQlC99Gil8qB47NePKmxHJ/AdG0X6RdQQyDU/QPsxKQQ5GvZmX
	 VW0erWFbeHEiex9ut8BNgLA+DOInM1VspPngOjJd31ly61Bt2YS7Dj7uYXn+Ce1SKr
	 sFu2splsRy2fCdxcoRrX7mJglIA5yG55VZZaJa+wtxbRGTstcet/zqP5TO484657Hl
	 MdjqkXxtoXURbGh/9W9yBcVn5JymKzMM8c4rbUFAQGGAY3GgUfyxzydOYJY6tXvM8F
	 Kz9DY7PZ9QEzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 620CE60733;
	Thu, 12 Nov 2026 10:21:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A3AF335
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 10:21:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 483F060784
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 10:21:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JcthQHHJKitY for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Nov 2026 10:21:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0A18F60733
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=przemyslaw.korba@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KEV9t/cR
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0A18F60733
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 10:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794478909; x=1826014909;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=onNY6HmcHV+vGYFfgMFBrzZ/E44RTGgC9Vy15TPvHPA=;
 b=KEV9t/cRGjpwC4mLXek9ycNBZFz7AhxYGcX/jWNfxnns9/G21IIIi+Im
 p1YK2IHq5EuXPvsvIjojRoFtOKVXl861QZF6kCDC4lPGuAByp8k9lXTCj
 Sl8p590LVUM5ap1PL5P5mmn+4jOxtHhdwVQYqz9Y9vKoJrWE808Q4pDEQ
 nrijwsPvrhC563SmiFUPmqpwDwOlydllWLbDvumO9spd0RD4He6Ntmqob
 PfvkK7lNmaLLLcMTJHyu4gkfIU3358SSe0ZyCjbdh51kLrYlj+v5sdD+Y
 ky1vT7M7LChplMlH0/OwNW+yPWvyEXAnmBR8AC8fuGT6UDZ2LSneoc10z g==;
X-CSE-ConnectionGUID: MAAfgn2VTG6FUKXBFZcC0g==
X-CSE-MsgGUID: 3XIgSnoURhiX/LbYU02uYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3257500"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3257500"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 02:21:47 -0800
X-CSE-ConnectionGUID: v01RP930SZOcmU1IHR0AzA==
X-CSE-MsgGUID: DGwzrjNWRDekWp5Bb69wcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="9190270"
Received: from pae-d-dell-r7525-263.igk.intel.com ([172.28.191.240])
 by fmviesa010.fm.intel.com with ESMTP; 12 Nov 2026 02:21:45 -0800
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 aleksandr.loktionov@intel.com, arkadiusz.kubalewski@intel.com,
 konstantin.ilichev@intel.com, Milena Olech <milena.olech@intel.com>,
 Przemyslaw Korba <przemyslaw.korba@intel.com>
Subject: [PATCH iwl-net] ice: fix stale cached PHC time after a time step
Date: Thu, 12 Nov 2026 11:21:52 +0100
Message-ID: <20261112102301.342584-2-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ice_ptp_update_cached_phctime() reads the PHC and then stores the value
in the cached time that is used to extend Tx and Rx timestamps. It is
called both from the periodic work and, after the PHC time is changed,
from the settime/adjtime paths.

Nothing orders these refreshes. The periodic work can read the PHC just
before software changes its time, be delayed, and then store its reading
after the refresh that follows the change. The cache then holds the old
time until the next periodic update, up to 500 ms later. Timestamps
extended in that window keep the correct low 32 bits but take the upper
bits from the old time, so they are off by a multiple of 2^32 ns. Two
concurrent time changes can race in the same way.

For a follower that steps a large initial offset this makes ptp4l see
the offset remain unchanged after the step, followed by a clockcheck
failure and a second UNCALIBRATED transition:

  port 1: UNCALIBRATED to SLAVE on MASTER_CLOCK_SELECTED
  clockcheck: clock jumped forward or running faster than expected!
  port 1: SLAVE to UNCALIBRATED on SYNCHRONIZATION_FAULT
  port 1: UNCALIBRATED to SLAVE on MASTER_CLOCK_SELECTED

In the failing case the offset after the step was exactly 5867 * 2^32 ns
plus noise, i.e. only the low 32 bits of the time were right.

Hold a spinlock across both the PHC read and the store of the cached
time. Whichever refresh reads the PHC last then also stores last, so an
older reading can never overwrite a newer one. The lock is only held for
the register read and is taken before the GLTSYN_TIME lock that
ice_ptp_read_src_clk_reg() takes, which is never held while taking it.

Steps to reproduce:
1. Create QinQ (802.1ad outer, 802.1Q inner) VLANs on two directly
   connected E810 ports.
2. Run a PTP leader on one side and ptp4l -s on the other, with the
   follower PHC about 7 hours behind the leader, and run iperf3 on the
   VLAN.
3. Restart the follower repeatedly.

This is not reliably reproducible, as it depends on the periodic work
overlapping the step. With a 200 ms delay added between the PHC read and
the store, 3 of 20 runs show the second UNCALIBRATED transition and
SYNCHRONIZATION_FAULT without this change.

With a random delay of up to 100 ms added at the same place, and 4
parallel "phc_ctl adj 1" loops running for 20 seconds, the stored value
went backwards 579 times in 1509 stores without this change, and 0
times in 399 stores with it.

Tested on E810-C.

Fixes: 77a781155a65 ("ice: enable receive hardware timestamping")
Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adapter.c | 1 +
 drivers/net/ethernet/intel/ice/ice_adapter.h | 4 ++++
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 9 +++++++++
 3 files changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index 207e4fe97be7..9874380b642d 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -91,6 +91,7 @@ static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
 	timecounter_init(&adapter->phc.tc, &adapter->phc.cc, 0);
 
 	seqlock_init(&adapter->phc.tc_lock);
+	spin_lock_init(&adapter->phc.cache_lock);
 
 	return adapter;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index d8da68e73177..45c82f8d7f43 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -51,6 +51,8 @@ struct ice_port_list {
  *
  * Legacy timestamp extension fields:
  * @cached_time: Cached copy of the PHC time for timestamp extension
+ * @cache_lock: Serializes reading the PHC and updating @cached_time, so that
+ *              an older reading can never overwrite a newer one
  *
  * struct timecounter fields:
  * @tc: timecounter representing the current time
@@ -64,6 +66,8 @@ struct ice_port_list {
 struct ice_phc {
 	/* Legacy timestamp extension fields */
 	u64 cached_time;
+	/* Protects reading the PHC for, and updating, cached_time */
+	spinlock_t cache_lock;
 
 	/* struct timecounter fields */
 	struct timecounter tc;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 488db8298059..1486a6fc35f5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1079,6 +1079,15 @@ static void ice_ptp_update_cached_phctime(struct ice_pf *pf)
 		u64 systime;
 		int err;
 
+		/* The periodic work and the time set/adjust paths all refresh
+		 * the cache. Hold the lock across both the PHC read and the
+		 * store, so that whichever refresh reads the PHC last is also
+		 * the one that stores last. Otherwise, a reading taken before
+		 * a time change can overwrite a newer one and leave timestamps
+		 * extended against the old time until the next update.
+		 */
+		guard(spinlock)(&phc->cache_lock);
+
 		err = ice_ptp_read_src_clk_reg(pf, NULL, &systime);
 		if (err) {
 			/* The source clock is gone, so the cache can no

base-commit: 34a70a40c954fb8044ecd124840a2c38cd3aa4cc
-- 
2.43.0

