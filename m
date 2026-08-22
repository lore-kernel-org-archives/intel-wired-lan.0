Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217D0C5DF9C
	for <intel-wired-lan@archiver.kernel.org>; Sat, 22 Aug 2026 00:15:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6C5360AF5;
	Sat, 22 Aug 2026 00:15:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q82tHc3qn0Cq; Sat, 22 Aug 2026 00:15:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787357707;
	bh=zY1tmNaTIQ6HWv9xnny5kbMKHc2WjSHlzDglOgp6Dh0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uoW6WlwKL1wI00svKZKkj6K8yMmZiDaDQadVWMJPOHF7AXzpSr0yBmHoKxCfh4DI/
	 KlDOENSR+tob6qRj07bvP3u6w6auKDn814FN/16iMK4A7rdXzhBD2spjNRQyIqgT0G
	 nsFf6mBNeg1qhiwBUCcfpvuWkbImEdGPrtLfSbLgSU70RHFdoSm7XfHVYCM0nIAzFF
	 hb2zuTZ5NAaE5e+Ht/jJ8SyznpuXqb31diuDa2RB1+yxDbFaGL0ARsltdjwvoagLQD
	 uqNKgMA2A2XEDuOSYxM9bUtrfskSdFiII11UoBqTwNEgWbeoLrqeBpCstWTLZy5SIf
	 TLULkvXT8pAVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2568C60AEC;
	Sat, 22 Aug 2026 00:15:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 391F14C4
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 00:15:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2B03E40A15
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 00:15:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yqgkfZzRDYd2 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 22 Aug 2026 00:15:00 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=SBYS63Ap
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B0F5240A05
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 00:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787357700; x=1818893700;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=uA66S9LgWH4Cu3mjCRofvh4OAjJNVg8vbR9+NSJQuH0=;
 b=SBYS63Api7yr/H/50S3bDhYv1VhkbWvge5NFxWAzRYb9vSJW0Od8zMPC
 JxtCe+D7QOlV3e6k2sZcZLghx9mTlVkxzOC2zopNJld1CIuLARLSMkpt7
 IA7Ur4S7GME8Ve/kYpe00+x4JjB/eQKIuBCJ+rvBihCrno4xLg2R8Nmat
 UOHRHwxfQBgjomOCfVNbJ9vJczYKaT0V8ySTM1XheSwKW/7TBlme3ch2C
 pDXdOqjeeTMdfAH9tB5/lC5ulezMImfF4iUg5eRMywOgB2GZoOaP+FY5u
 TTAB+UNMAROQikY07T/18FSRjn0TCVaakN4YmuOxBCgKyJXMD+CezZJ3M Q==;
X-CSE-ConnectionGUID: kmA6xp/JTxWjn7uCp/MXCQ==
X-CSE-MsgGUID: NGgmqR8WSlysX0M9OdjKMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91584786"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="91584786"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 17:15:00 -0700
X-CSE-ConnectionGUID: 2iLgpgbpQjSFgw4Gkt32hg==
X-CSE-MsgGUID: NJfPlO0SRheqTUYngJAN5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="263836492"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 17:15:00 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 21 Aug 2026 17:13:15 -0700
Subject: [PATCH iwl-net 10/12] ice: remove unnecessary discarding of
 timestamps after clock adjust
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-jk-e825c-minimized-fixes-v1-10-9d0731eb4858@intel.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: netdev@vger.kernel.org, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
 alexander.nowlin@intel.com, kevin.bross@intel.com, ranjit.cavatur@intel.com, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-75809
X-Developer-Signature: v=1; a=openpgp-sha256; l=4007;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=uA66S9LgWH4Cu3mjCRofvh4OAjJNVg8vbR9+NSJQuH0=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqyOl78v1Zul7ftwe/pXJ8fzJhdal6T7vGGMVlzaG7sz7
 rGYsOW2jlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACYi94iR4fh/zROnZ4funHuu
 seVr8LQtf37UFrLFVbl8M9oxs2n+wdkM/6P4Chbvs9L6F1ihes165425kzduzu54l+XbzzOX8cZ
 pbnYA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
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

The ice driver currently discards any outstanding timestamps that are
happening very near to a .adjtime or .settime callback. This was originally
add by commit d40fd6009332 ("ice: handle flushing stale Tx timestamps in
ice_ptp_tx_tstamp").

The original motivation for discarding timestamps was that extending an old
timestamp using the new cached value of PHC was a problem, as it could
produce incorrect results. The change did not describe what such "incorrect
results" were.

There are no such incorrect results. Extending the 32 bit timestamp with
the new time value just means that the timestamp is reported in terms of
the newly updated and adjusted system clock. This won't produce incorrect
results or problematic timestamps to applications. Either the timestamp
will be extended with the value of the PHC just prior to the time
adjustment (if the timestamp completes prior to the adjust callback), or it
will be extended using the new PHC value after the adjustment. In either
case, the resulting extended timestamp value makes sense.

The timestamp extension logic is very similar to the logic found in
timecounter_cyc2time, the primary difference being that the ice hardware
maintains the full 64 bits of nanoseconds in the MAC rather than being
maintained purely by software as in the timecounter case.

Indeed, I couldn't find an example of a driver using timecounter_cyc2time
which does discard timestamps that occur nearby a time adjustment. The ice
driver behavior of discarding such timestamps just results in failure to
deliver a Tx timestamp to userspace, resulting in applications such as
ptp4l to timeout and enter a fault state. Reporting the extended timestamp
based on the updated PHC value isn't producing "garbage" results, and
doesn't lead to incorrect behavior.

This effectively reverts commit d40fd6009332 ("ice: handle flushing stale
Tx timestamps in ice_ptp_tx_tstamp"). However, the stale logic remains, as
we now use it to inform the driver to drop timestamps which might fail due
to link down.

Fixes: d40fd6009332 ("ice: handle flushing stale Tx timestamps in ice_ptp_tx_tstamp")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 1a9bf8839404..8c2dd83d8d6c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -826,12 +826,10 @@ ice_ptp_flush_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
  * ice_ptp_mark_tx_tracker_stale - Mark unfinished timestamps as stale
  * @tx: the tracker to mark
  *
- * Mark currently outstanding Tx timestamps as stale. This prevents sending
- * their timestamp value to the stack. This is required to prevent extending
- * the 40bit hardware timestamp incorrectly.
- *
- * This should be called when the PTP clock is modified such as after a set
- * time request.
+ * Mark currently outstanding Tx timestamps as stale. This prevents the driver
+ * from reporting the timestamp to the stack. This is called to inform the
+ * driver that a timestamp is expected to fail if it was initiated as the link
+ * went down.
  */
 static void
 ice_ptp_mark_tx_tracker_stale(struct ice_ptp_tx *tx)
@@ -1049,13 +1047,6 @@ static void ice_ptp_reset_cached_phctime(struct ice_pf *pf)
 		kthread_queue_delayed_work(pf->ptp.kworker, &pf->ptp.work,
 					   msecs_to_jiffies(10));
 	}
-
-	/* Mark any outstanding timestamps as stale, since they might have
-	 * been captured in hardware before the time update. This could lead
-	 * to us extending them with the wrong cached value resulting in
-	 * incorrect timestamp values.
-	 */
-	ice_ptp_mark_tx_tracker_stale(&pf->ptp.port.tx);
 }
 
 /**

-- 
2.55.0.814.gc42f45431d0f

