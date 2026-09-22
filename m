Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77BF1C98302
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 18:08:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2142B406FB;
	Tue, 22 Sep 2026 18:08:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sntcRtEg5iMZ; Tue, 22 Sep 2026 18:08:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3567040738
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790100509;
	b=Rvh5wlWuNBcqbj1p3UehVCJgRTm/dJ2UnpNjtJPL+r4mbLDXX87KPaJ+35NTgC2g59gL
	 puQyPm4i/TmK3thCqSr8bzjMVoHDf3qFP10BvALJsRLdVFNmEsyCj3bgEaGlLCkdFYpRO
	 ZC8Bj6YUiwGpBg9KlrAsKNY4DNgMRwUwHYii/UshUOaKEgGPOCkcIRO/FW9YYt/2Iw7zF
	 Mqyq16tKNU7LDeg7pqBue42SBwFiACdukjqXaGeVBKRD+FE7stGoZ5EhGNw8vcZb2NIqN
	 B+6Z0XpfMn8SrcHXBr2v6MkMRXHWQ7E2pKfJJnhfdLaoCkFLdhVm+rDSAMvtHyd2IEg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790100509;
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
	bh=Z8BaxNtehkpCDwUKkJhezfnJzHTuyJ6k/f7sy94PaYY=;
	b=Fs0HfFkPascE5e9K76OG2YbO+MPy7xQeqgjn9pyC5tmna5p3H/v8V7G/WhdgMGahAPEI
	 WbQ2cu9VPeLWfRG905FCNlLRMtdn1ERxNBkZk30Ip7YUPaMY1CdVn3/nQvIH/KEOJ1wX8
	 w0pOsjzuYHaSoQeOhYFREYxIXklloqoz2rSW10pPmDr4lyDkADWo225AODu8YV7svc4Z1
	 G9V8AMEAN/HcTZaT+cE3K98cKNgqSEvYrnapprnZ/lFZIaeJW6COXI4IqGF3qd/xUKIAv
	 e3psbr7HixgJemPl08Y8hi+qNaRKJBc7CMP/utUtaEPIZ8v0WPTSDyBdPCScQVm6fWQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IwY7epF8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790100509;
	bh=Z8BaxNtehkpCDwUKkJhezfnJzHTuyJ6k/f7sy94PaYY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tGYLJhJZHwKsq1mAYy0AacqR+VSs50o+7wuioAVAIgCD8rV/yLPglXhsslarqOiRh
	 EQZpmPRdI2XCvTyNaUXmpXP/wdY+hHwLKlxurA6YgoIja8T6+EOu3qwp/wIQOjH+VW
	 +ZiEDhD0CbdocH/6me3vz5PM3bGyWgCfUURHPKRfxZZP9J6M9L6aiRb+WAGfc3PQY/
	 BBzQHOybbMDE6I5M7lJzhnC0KQJhRJ02YKbE9lQ6COOTorTcehOeEyS9XaCmam0Ge1
	 hJP0Jm3GwwNNbfcO1s3MO7ZAySmcJoETW/PA2RELPqvm45RpOsPvXlqrf+7OjsAgBv
	 FXsymKsr/iikw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3567040738;
	Tue, 22 Sep 2026 18:08:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4555612C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 37552406FB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8y4pEvNFc97w for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 18:08:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4698740752
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790100506;
 b=kpbO6NxbE0kO3zetJVULtd4TEtYWA4m1tZlj/i7mv7SDbMmjrtfRvfEI6pw/gWKUKsn/
 vWdFD93p6C10mT2NrDaTE/mrT+JJ5+fVU0aYsRK/E6ZFmDyWIEDTps8cAFiqt/pOeMbFZ
 CljRBnO9i+Bnal8phQxxz6XP4fLDeaDRIZdBEHoQE+an4zYF1iLVJ0CgM8OKYZlNkEvOP
 AWvcMSO386JVh5xUhqx1pPAQJ7mQBJNSzVBT/7RhZkcOcxpxvaY8yPY+4329c+IzfZX5z
 5x3fln/1ZgEAAOOZLiZiZ+CLhu0WeKdZNDuqkSiXg+u9giHzRXacc2yM/iPwC3buIWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790100506;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=Z8BaxNtehkpCDwUKkJhezfnJzHTuyJ6k/f7sy94PaYY=;
 b=nkct0FVcq5XYB50D4tstxZFYeFk8hMeEMrKt3uTu4s6DMadfkOPWIojCSHuhEmZ2Wenb
 gDzgFg6L1iQKYIe6Xd0TAY2QmGGTz2JamXZBIPYQJHFsqXsX6B0CBio8T3WtyWSRugv5X
 tajZtogT2tkFjSnHgfca1qSO2Lk/Qr5Yoe4boTbLDF0rQhgazOUjB7KqdsjPSRIGEUndW
 qAeNEl/5oHnHgaq2uaotWgpwVmUFz1H/l1mQ8DO5dhA5IvTvFSMghgnEWrGNLTKFnRebE
 2Rb5vCjecb+lqXo4Okbk4t3JQcFTp65NX8x9HCibfF+7QV6I2uvta8IRaAZf8Xo2TaQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=IwY7epF8; 
 arc=none smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=IwY7epF8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4698740752
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790100506; x=1821636506;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=UBEiLjWOKI122kTUAfj+4SUrO4xRBdnmc7aWTNRqiC8=;
 b=IwY7epF8hs9Hi0sdqd24ZWR6DtAY7pW9UOVJcRPtzHnqijaMI9atmd4B
 Jk7SI2izy9X2/aM9bmDPURiA4BCU+NjYA92HFzJ1V8v2zjAPAs99xNhi9
 D+FA3R4zCLX6YO7KDaaDIQjeGAA+NyWyAPj5mh0LqdLDVIRpAIrok+Bss
 kCf0rDBM0j4NW2vXriR2akftOpvXJgG4XwFupGhbgxr6IzsaLIXxopZvj
 ECcbdQf2UAYbkkJWzYG5hcJlGsRH/93Gy3N+YqdYKRzrTuOx8p1a/Q1WR
 4R5t0zHnB1AkUKdBV+kbT7iNUt6KdtRJkGDLQHE/aPlzHJZ+d9H0b2I3m w==;
X-CSE-ConnectionGUID: l/EMZyhySsCirmU3j1IgQw==
X-CSE-MsgGUID: 5ga8qLQ0TvCXZMDU+76MCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="108232029"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="108232029"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 11:04:23 -0700
X-CSE-ConnectionGUID: JCC6RXy0TcqRYlzztfJWdw==
X-CSE-MsgGUID: 5CNarpmDTiO4Oe8PtaKFjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="281315300"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 11:04:23 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 22 Sep 2026 11:02:36 -0700
Subject: [PATCH iwl-net v2 03/15] ice: fix removal of PTP timestamp tracker
 during reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-3-e55b692d0e6b@intel.com>
References: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
In-Reply-To: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, netdev@vger.kernel.org, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=3902;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=UBEiLjWOKI122kTUAfj+4SUrO4xRBdnmc7aWTNRqiC8=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqxNh6X2dcyWTjvoHbyQ6XL/8YdJjtec13v67ii6NHfzn
 YqATVpWHaUsDGJcDLJiiiwKDiErrxtPCNN64ywHM4eVCWQIAxenAEzkRxwjQ8O3yGtfvnLU96vr
 LLn/RLvcMkigsO7C+rVdv050KucWb2JkmLk9ePc9aT5rkyfBbK9rb/P5cMSs3h3H1iHwaYbhNOn
 NPAA=
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
potentially leak the PTP timestamp tracker. Fix ice_ptp_init() so that it
correctly calls ice_ptp_release_tx_tracker() as part of its teardown on
exit. Fix ice_ptp_release() so that it handles the cleanup if PTP is in the
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
 drivers/net/ethernet/intel/ice/ice_ptp.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 4422588472d0..2bb9beb94806 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2996,8 +2996,6 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	if (ice_pf_src_tmr_owned(pf) && hw->mac_type == ICE_MAC_GENERIC_3K_E825)
 		ice_ptp_prepare_rebuild_sec(pf, false, reset_type);
 
-	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
-
 	/* Disable periodic outputs */
 	ice_ptp_disable_all_perout(pf);
 
@@ -3454,11 +3452,13 @@ void ice_ptp_init(struct ice_pf *pf)
 
 	err = ice_ptp_init_work(pf, ptp);
 	if (err)
-		goto err_exit;
+		goto err_release_tx_tracker;
 
 	dev_info(ice_pf_to_dev(pf), "PTP init successful\n");
 	return;
 
+err_release_tx_tracker:
+	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
 err_clean_pf:
 	ice_ptp_cleanup_pf(pf);
 err_exit:
@@ -3488,6 +3488,14 @@ void ice_ptp_release(struct ice_pf *pf)
 
 	if (pf->ptp.state != ICE_PTP_READY) {
 		ice_ptp_cleanup_pf(pf);
+		ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
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

-- 
2.56.0.rc0.395.gd1f3524e15dc

