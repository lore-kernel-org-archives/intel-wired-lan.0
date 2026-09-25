Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE7AC9832A
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 23:58:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64FA581178;
	Fri, 25 Sep 2026 23:58:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uEZOka_j3-FS; Fri, 25 Sep 2026 23:58:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7D63181179
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790380692;
	b=C+fqMZ5ggRsqtincpiKKqvOpkSwR4GetULw6B2Ek/NaN+Koa/PWbNsSzFJNG0U8x37PL
	 +wjbXHgMwcSn28VjKGcisbAwdFQhEBX5XTitGvDOOMWhRIk9Qcx5zluN96nB5kP3Q+uxs
	 NXmIBsOS8WJaaprX6GTnmSLPoglFnnVZKWjkbyLFEu8LpQIxkjt2W6bO3frOhmVjMhOUa
	 oB3D4UsJdWpEtF/yrimSwAJ/NFDU4cuQEzu5XY5wVZ3cH5kqxc7D0wyBeTXm8zXvUNpRF
	 9UmfZFxwqPGCrm8GQFSfXxn8jAxhCQ0r1617qenu6RACbvRLWftfMpJEnb08hs6R0UQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790380692;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/e/WGK0SMHPyBATrXPCyEzwqFhzOQsjBIW7oR9pa/ao=;
	b=G9flKiuEIXQCPtYKkvkOUQVSQ/8edTBrVUN3sxIXyJbv4R+S58bwE/3uO8e1DmEm3f5A
	 Hgy9riUMw48EPwy8JbfCpOK8+ukzlBwJuvL+wyHyt1k4K/pzsjwATVGwHeBe+LVAn9Bj9
	 SxijCL9oz27QmT3lNNik/NcEhqbVjjzii9/bOpZUfBWtRfifc3IbVKdp2ip+K0/84g0cP
	 cN0+uX5j55RcDfDcZdQ0P85oh43W8LZJZG/wWOr13B0lgHBkxSdYyA2SkIJq+lmMrrl2d
	 sqpEF+NtRWhya9MB+kMfJlNKI1j38HrQcM9r7ALielvzRhM6wXbVxmCnm/Bm5Xh685w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OpUwE4E1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790380692;
	bh=/e/WGK0SMHPyBATrXPCyEzwqFhzOQsjBIW7oR9pa/ao=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jCDPXN/jZsKGqtotJ6m90Wf6rB5n5HcOjYveaLutinzuvyzq4NXwUFr1FrULEmUVy
	 Yj8WLgYTdaGpAlNvCOTX2UOIpxFaoG879mC/tFxfnRr+viBbpLHNJQnwbVv5dgehUk
	 VWdJ4LwSCTxfsKCi9m5Ih53l3CfkSheq1vRCeVe60pLoTPHDo/edmg0lZlxhnNEijt
	 OfWCaIeiCfRTpjnk9EOSFGlBJU9ZWB7xjl26FRaNStsmPXLqsLhUFIxv+wTZ2hmkyg
	 8V0atkwAo5mVEsfyu1g+jLQyZzBsl4A40rbN+aK/svMrmpJv5lbZEgry0czFWtMQAk
	 +GMyFCBjpE4Mw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D63181179;
	Fri, 25 Sep 2026 23:58:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 06ACE355
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E05F1811DF
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zBrnZ2CKftuc for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 23:58:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 46E1381103
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790380685;
 b=isjzD5p7QGj0cZO8svYyhgJwH2o9UpYOv7plSX3+8nkGE+6UpZrYnA3QKP/2ikfVhqGL
 TxIeCdrvBv3olW4324xH0KQWYqLvbf5M7BfQicm34FAbSYtsQfmsr2fk5NwrcBaSAGGD4
 dK09bUlwrzBRkdC0haS5mCJM38I9HlHu8giIPuXCx1b3TF1y8CG7Sm8JllE3+jlijTagR
 LFpFSom6+nusCXgGdSqyJeS4KDkiAKvjhc8g9rXg3+11rVbI4Rp5QEsSQrpq/967Te8K6
 3h4F+xL1rivEtNjmxMdYpqY3/3OvrhjGFKJUcITEVloeX3j1Nb8UHWVV4iBf1UJ70Nw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790380685;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=/e/WGK0SMHPyBATrXPCyEzwqFhzOQsjBIW7oR9pa/ao=;
 b=mOk+aSiIOy5UZqYJv8rAnflGkS94axQlMOQHeIrDYcBD0KF7GpbS55jZfGFrZxN/umzR
 XPWvb1yEDzlF1P0t3jxIqjMpKKaI44RRdlLXWknvAEt08ICap977d9uE/MSPnFKfk84dV
 i7VwVilQVERU6GEgpiESSjIS9UeXG2OYOARCN9TFPDf6vNh9djhTR5I3Ok4ee4DK1ps4T
 VQqkfMfqgquBQEYUpWJBMvE0ToxRjHg+0zP/U8L4e+bPX6TnX2huP+CCjHI0DtJmMczX6
 3ZIXghRjOMa3bFJsNT0ROwjeygbkFX5ZQaiwn5UNtG0FXnyUkNFFksDCd1kbRmsg31g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OpUwE4E1; 
 arc=none smtp.remote-ip=198.175.65.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OpUwE4E1
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 46E1381103
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790380685; x=1821916685;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=JyzTT6GsFBl2As+hciHWAnOrhDBFo1VaTcUL4eHOU8c=;
 b=OpUwE4E12+u0VMNbWsb9FIey0qc8MMembtfhUGHVLkZIr7fmCfmV7djB
 6tHRb89gCLjOaeUbhUhfsIVsJXDRnjSrzTYWEtU9+/5fVDjXG8zamKHre
 sbrqgjA51xC23nNEOgrTK3z1v/9zrDjFzCWoFpDzg/bXLWy7r5aSglF3m
 P5d7KQsjLIAYvu96+Y/voG0WSK0K2fx9k8rVL8g+WxIJVwckpYOQhxO4T
 0xOmuXfv9nmVIgXGMpg/zL9bprHk9o0R2i6Yz43HTc7lrUraWcLxvndBe
 bz1DX8oBdlVzCPiXZfqVX+SHdCKLnmX0UQ0S5vn0FkK+83BLu87KiDMxq g==;
X-CSE-ConnectionGUID: +FONb9EvTfuuLBY6CnGPaQ==
X-CSE-MsgGUID: /DEsQ2lXSgaxJBVG5r7opg==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="90212803"
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="90212803"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 16:58:02 -0700
X-CSE-ConnectionGUID: EM6JM+53Ty6NfZ3+Wjgc/w==
X-CSE-MsgGUID: efQ8x+H5TKa4rect3h7v0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="300731101"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 16:58:01 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 25 Sep 2026 16:56:33 -0700
Subject: [PATCH iwl-net v3 01/15] ice: fix removal of PTP timestamp tracker
 during reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-1-6532598e8da8@intel.com>
References: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
In-Reply-To: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=4811;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=JyzTT6GsFBl2As+hciHWAnOrhDBFo1VaTcUL4eHOU8c=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqztXOW6eg2V9dNfPNjyjHmJ6qNLUrZb1xbXv80Iq7sow
 Jkx4/OcjlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACZSycbwz0JazvTlG95pqz83
 3RM4xSfoevvWF97U49HLF7nubzwjepKRYY+y4TNunwUZ3et2NbKE9RWbFjkEPvXa07dC3uxQwXF
 NXgA=
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

Commit 7a25fe5cd5fb ("ice: stop destroying and reinitalizing Tx tracker
during reset") intended to modify the PTP reset flow of the driver so that
it stopped calling ice_ptp_reset_tx_tracker() during teardown and stopped
calling ice_ptp_init_tx_*() during rebuild.

Unfortunately, the commit only removed the calls to ice_ptp_init_tx_*().
This fixed a memory leak in PF reset. However, now a CORE, GLOBAL, or EMP
reset will leave the device unable to initiate Tx timestamp requests
indefinitely.

In practice the CORE and GLOBAL resets rarely happen in production
environments, while EMP resets happen after a firmware update that is often
followed by a platform reboot. This explains why this has not been caught
until now. However, it is trivial to verify by triggering the reset from
userspace via ethtool. For ice the following command will trigger a GLOBAL
reset:

  $ ethtool --reset eno8303np0 irq-shared dma-shared filter-shared \
                               offload-shared ram-shared mac-shared phy-shared

Remove the call of ice_ptp_release_tx_tracker() from
ice_ptp_prepare_for_reset(), to keep the tracker memory in place so that
timestamping can resume after a reset.

During review of a previous version of this change, sashiko pointed out
that the teardown flows for ice_ptp_init() and ice_ptp_release() could
potentially leak the PTP timestamp tracker.

Fix ice_ptp_init() so that it allocates the tracker before adding the port
to the port list, and properly calls ice_ptp_release_tx_tracker() as part
of its cleanup on error. Ensure the ps_lock mutex isn't destroyed until the
PF has been cleared from the port list.

Fix ice_ptp_release() so that it handles the cleanup if PTP is in the
error state by cancelling the kworker items and releasing the Tx tracker as
appropriate.

This was found by Sashiko review during feedback for an unrelated change,
and iterated based on further feedback from Sashiko after the initial fix
to remove the call to ice_ptp_release_tx_tracker();

Closes: https://sashiko.dev/#/patchset/20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858%40intel.com?part=8
Closes: https://lore.kernel.org/netdev/20260916011213.1632286-1-kuba@kernel.org/
Fixes: 7a25fe5cd5fb ("ice: stop destroying and reinitalizing Tx tracker during reset")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index eaec36ab6ae3..fe21cee4f9de 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2939,8 +2939,6 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	if (ice_pf_src_tmr_owned(pf) && hw->mac_type == ICE_MAC_GENERIC_3K_E825)
 		ice_ptp_prepare_rebuild_sec(pf, false, reset_type);
 
-	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
-
 	/* Disable periodic outputs */
 	ice_ptp_disable_all_perout(pf);
 
@@ -3347,13 +3345,13 @@ void ice_ptp_init(struct ice_pf *pf)
 		}
 	}
 
-	err = ice_ptp_setup_pf(pf);
-	if (err)
-		goto err_exit;
-
 	err = ice_ptp_init_port(pf, &ptp->port);
 	if (err)
-		goto err_clean_pf;
+		goto err_destroy_ps_lock;
+
+	err = ice_ptp_setup_pf(pf);
+	if (err)
+		goto err_release_tx_tracker;
 
 	/* Start the PHY timestamping block */
 	ice_ptp_reset_phy_timestamping(pf);
@@ -3365,14 +3363,17 @@ void ice_ptp_init(struct ice_pf *pf)
 
 	err = ice_ptp_init_work(pf, ptp);
 	if (err)
-		goto err_exit;
+		goto err_clean_pf;
 
 	dev_info(ice_pf_to_dev(pf), "PTP init successful\n");
 	return;
 
 err_clean_pf:
-	mutex_destroy(&ptp->port.ps_lock);
 	ice_ptp_cleanup_pf(pf);
+err_release_tx_tracker:
+	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
+err_destroy_ps_lock:
+	mutex_destroy(&ptp->port.ps_lock);
 err_exit:
 	/* If we registered a PTP clock, release it */
 	if (pf->ptp.clock) {
@@ -3399,12 +3400,20 @@ void ice_ptp_release(struct ice_pf *pf)
 		return;
 
 	if (pf->ptp.state != ICE_PTP_READY) {
-		mutex_destroy(&pf->ptp.port.ps_lock);
-		ice_ptp_cleanup_pf(pf);
+		if (pf->ptp.kworker) {
+			kthread_cancel_delayed_work_sync(&pf->ptp.work);
+			if (pf->hw.mac_type == ICE_MAC_GENERIC)
+				kthread_cancel_delayed_work_sync(&pf->ptp.port.ov_work);
+			kthread_destroy_worker(pf->ptp.kworker);
+			pf->ptp.kworker = NULL;
+		}
 		if (pf->ptp.clock) {
 			ptp_clock_unregister(pf->ptp.clock);
 			pf->ptp.clock = NULL;
 		}
+		ice_ptp_cleanup_pf(pf);
+		ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
+		mutex_destroy(&pf->ptp.port.ps_lock);
 		return;
 	}
 

-- 
2.56.0.rc0.395.gd1f3524e15dc

