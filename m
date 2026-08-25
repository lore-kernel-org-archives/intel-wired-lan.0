Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F77C61DC6
	for <intel-wired-lan@archiver.kernel.org>; Tue, 25 Aug 2026 22:55:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B41C8406A3;
	Tue, 25 Aug 2026 22:55:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Td9xVhJJEQMf; Tue, 25 Aug 2026 22:55:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787698514;
	bh=rMKOpgQgi2dRXVBgzMHnhXJdycG40+K0B0Jh9SdZeiA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z7Sm9Xa6jh7JhysIQqtSxV/3xHTnk9iO1Xpe68ZjPeSUrpUYP+b5RNb1ArNsQO08e
	 9JifO6QskCjtkiZ4VWCiaoDjlYL9QdwdsweQX18qDqgfL3482D9ZSWx+8/Hw3hCd34
	 dKJ/nNJT3hZFBZnE2pwooKeVBmg61xRN+XJBnHVbV3ggao1hZJXEan4bLgL1I8kRe/
	 WdLqZk/O6Rej5lVo3r0YvlW4Y1Y4t+JsI9tSgtaWPv8L392aELOx9Zvexi6tWogHWF
	 c6CdiprKxVEzWCtezcyNq+yxMwq7byfUTwXee44kxp4+B1b70LB6bn2lAM5snqhHlV
	 x5GRMF0LIJtcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D23B7407A8;
	Tue, 25 Aug 2026 22:55:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CC1B4230
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 22:55:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BD71A80C0C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 22:55:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KBFAj2LBk5C4 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 25 Aug 2026 22:55:08 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=gsNVKQln
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C89E480C25
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 22:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787698508; x=1819234508;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=iRbwGApC4tmQ0aGWGh+Q2tqfhGKKtnkcYis151rAsVs=;
 b=gsNVKQln/gJfTjOerrS9V4MYuSTilH7hGE+ebZbZUd+mPUjEiRnlq3+Q
 VZbWm3nsLVMKTzzJ9o7dhOUMQVStbkUHJJFhmAFlCGc5XyTDyQxffnjlm
 CARkyisCuGojioqajzXjLrV66rZ7BMQ2rNFiFCtTyuWY8LxAQWZo/aoFI
 Y/jUOHxvi8Srs77l17AwIiP/xNErmLWumHDSQCDe8zFB81dLtKIYbcLEd
 DlhzgNhB1q9yfusPUFpb5Jz7CcjkhKelBUrzTEAdledXZN5ZrXzfGgfDE
 ywBEjuJRTR5e3ALT1fwydyZJRBoviQAjMvnmynByU1bGcnV66tCrzCPp8 g==;
X-CSE-ConnectionGUID: rbXdelcqQ3+SU9pigD9Wuw==
X-CSE-MsgGUID: siqrnZwTSG+NnIevIuhM6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="87120450"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; d="scan'208";a="87120450"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 15:55:07 -0700
X-CSE-ConnectionGUID: sbDQ7b/ARTmkbuzrP4ZIGQ==
X-CSE-MsgGUID: fXZGoVnhSjScuNeAXtMCtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; d="scan'208";a="264789700"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 15:55:07 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 25 Aug 2026 15:53:36 -0700
Subject: [PATCH iwl-net v2 12/14] ice: remove unnecessary discarding of
 timestamps after clock adjust
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-jk-e825c-minimized-fixes-v2-12-8223f95d26e3@intel.com>
References: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
In-Reply-To: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: netdev@vger.kernel.org, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
 alexander.nowlin@intel.com, kevin.bross@intel.com, ranjit.cavatur@intel.com, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-c276d
X-Developer-Signature: v=1; a=openpgp-sha256; l=4065;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=iRbwGApC4tmQ0aGWGh+Q2tqfhGKKtnkcYis151rAsVs=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqw+WbtS1QLpW2rWMhPORVo+nlPrceCP/anC66XZqr3f1
 2p/M17UUcrCIMbFICumyKLgELLyuvGEMK03znIwc1iZQIYwcHEKwEReFjMynOWPnXWi/vmCySvL
 0rPa265412hv598S9yHbRb74y5cdjQz/lPsC03ovbjm8Kmn97bwb+3fFxHEIv+ed/83oe3PVX0d
 ORgA=
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
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index f8ef054ca966..8500e9a5b047 100644
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

