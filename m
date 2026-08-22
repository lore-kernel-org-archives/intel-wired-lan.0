Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71149C5DF94
	for <intel-wired-lan@archiver.kernel.org>; Sat, 22 Aug 2026 00:15:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D56260870;
	Sat, 22 Aug 2026 00:15:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gLKqDkGzUE_j; Sat, 22 Aug 2026 00:15:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787357702;
	bh=EsSW+Orb0Znjss7PUevWeI0AL157eqj/g7A6EZuyBCo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m3WgdWBVrp37J1bvxQ9mJ1yH4YW7MLhgmjoVK56ZJ2XZ8QlHojk4jt+Lw7VzNbsiF
	 MtiNZaFV/NYQyCqf/9Ynul7aN1VDZl2IBfM2HIw4Lxd7TvItjZwkEKL8hftP7yuLoU
	 V4vUThKrcaYEta0R/9JpvKCbQD+LmzeZaOQ2Dd/nnwW9sT5SXcfeYQPy4G5GvYykgU
	 eNzi4A6lX0qjjYylQDJ2GmzGBHpkcW2np0d4h9raMmcumz7vWNR4hirSJyDhxzG/6l
	 mWAh16KpT7mZmv9gvR4Tb6k6Yv8TpMiPC80fiGsS9VugLCCnJ7wBCI1E8UvyyHLxjq
	 AQFM8QG0JF2Yw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B64D60AD8;
	Sat, 22 Aug 2026 00:15:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 09B014C4
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 00:15:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DDB7A40A05
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 00:14:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OpNx-gy445Y4 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 22 Aug 2026 00:14:59 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=dv4kTuEm
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 21065400FB
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 00:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787357699; x=1818893699;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=ykZV2+vW3SLYhEntRCRH3HuzfRCJ0g8W/+CtjsohyO4=;
 b=dv4kTuEmJXaPErCsC68Cje3IZ/4y3dyeFWFAT830LadSJEjLLhrrg9rg
 /ZQTcu9twRq1bCyIz/ndMG1Itmj7hxVTEuF4nY8mvFITbPhuesU1UdzP5
 QieFM76QfN2uFzRnWr1uvFUxVUO27F1GbVmqUrLfOt/RZU768BOros3OY
 z6kK5hPPT7C9Q3jySNqUMubTFXwGIknJOdnIJ3BtWeyfcaZmpgq5STkFy
 auKlWLYVwoT6Zz4y1tSVev8Cp1JD//am2BAgthOuw5Cgyn+ZXWVs4pHyx
 a7xnTiAglB6V02Hm/ycVZ3c15H6oK5T24EEFqF0q/w+4bBwspYHchtH3Z w==;
X-CSE-ConnectionGUID: RN3Byfz+S3mhrXf8j+u2cg==
X-CSE-MsgGUID: 6UpySvY2Qa+wsF0moWWUGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91584757"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="91584757"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 17:14:57 -0700
X-CSE-ConnectionGUID: xF22i8fUQwy2TEtfYqc1kw==
X-CSE-MsgGUID: Fe4mJMo+Sta7HsM0hKY1CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="263836461"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 17:14:57 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 21 Aug 2026 17:13:07 -0700
Subject: [PATCH iwl-net 02/12] ice: E822: keep Tx timestamps disabled
 during offset calibration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-jk-e825c-minimized-fixes-v1-2-9d0731eb4858@intel.com>
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
 Karol Kolacinski <karol.kolacinski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>
X-Mailer: b4 0.17-dev-75809
X-Developer-Signature: v=1; a=openpgp-sha256; l=5018;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=sz/nG1arp4DPJGcG5ocSxMQWFYrOSeyE6veQhp2P4PM=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqyOlz/DVFYIHhdv+3popfubjKRg2wXKs/kcInMklTbuc
 bF0tCjsKGVhEONikBVTZFFwCFl53XhCmNYbZzmYOaxMIEMYuDgFYCLiuowMvW0J9rpLCs5H7pG+
 zv5OU4V3ykv7/3YWtptm/s0rj41LZmQ4fFcjYeJpZdna/n39DDfOX5zqeWi7e+yXd2fuCi2aNuU
 oOwA=
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

From: Karol Kolacinski <karol.kolacinski@intel.com>

Do not clear the tx.calibrating flag immediately after starting the PHY
timer in ice_ptp_port_phy_restart(). Instead, keep Tx timestamps
disabled until the offset verification work (ice_ptp_wait_for_offsets)
has confirmed that both Tx and Rx PHY offsets are properly configured.

Previously, tx.calibrating was set to true, then immediately back to
false right after ice_start_phy_timer_e82x() returned. This allowed Tx
timestamp requests to be served during the window where offset
verification was still pending. Timestamps produced during this window
use uncalibrated PHY offsets and can produce incorrect values.

When ptp4l receives incorrect timestamps, it may reject them and wait
for the next sync interval (typically 1-2 seconds), compounding delays
during link cycling. This contributes to the time transmitter port
becoming unresponsive after repeated link down/up cycles.

Move the tx.calibrating = false to ice_ptp_wait_for_offsets(), after
both Tx and Rx offset configuration has completed successfully. This
ensures that Tx timestamps are only reported with properly calibrated
PHY offsets.

If ice_start_phy_timer_e82x() fails, restore calibrating to false on
the error path to prevent permanently disabling Tx timestamps when
ov_work is never queued.

Log a debug message while offset calibration is still pending, including
the specific Tx/Rx error codes to aid debugging stalled calibration.
This path is expected on every routine link-up: ov_work is first queued
with no delay and the vernier offset cannot be computed until at least
one packet has been transmitted, so the first several invocations
normally land here. Use dev_dbg() rather than a rate-limited warning to
avoid emitting KERN_WARNING on every link-up during normal operation.
Log a debug message when calibration completes successfully.

Fixes: 3a7496234d17 ("ice: implement basic E822 PTP support")
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 36 ++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 1d647ccce7c4..9d99cbb42463 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1156,6 +1156,7 @@ static int ice_ptp_check_tx_fifo(struct ice_ptp_port *port)
 static void ice_ptp_wait_for_offsets(struct kthread_work *work)
 {
 	struct ice_ptp_port *port;
+	unsigned long flags;
 	struct ice_pf *pf;
 	struct ice_hw *hw;
 	int tx_err;
@@ -1178,12 +1179,28 @@ static void ice_ptp_wait_for_offsets(struct kthread_work *work)
 		tx_err = ice_phy_cfg_tx_offset_e82x(hw, port->port_num);
 	rx_err = ice_phy_cfg_rx_offset_e82x(hw, port->port_num);
 	if (tx_err || rx_err) {
-		/* Tx and/or Rx offset not yet configured, try again later */
+		/* Tx and/or Rx offset not yet configured, try again later.
+		 * This is expected during normal link-up: the vernier offset
+		 * calibration cannot complete until at least one packet has
+		 * been transmitted, so the first retries routinely land here.
+		 */
+		dev_dbg(ice_pf_to_dev(pf),
+			"PTP offset not yet valid for port %u (tx_err=%d rx_err=%d)\n",
+			port->port_num, tx_err, rx_err);
 		kthread_queue_delayed_work(pf->ptp.kworker,
 					   &port->ov_work,
 					   msecs_to_jiffies(100));
 		return;
 	}
+
+	/* Tx and Rx offsets are now configured, enable Tx timestamps */
+	spin_lock_irqsave(&port->tx.lock, flags);
+	port->tx.calibrating = false;
+	spin_unlock_irqrestore(&port->tx.lock, flags);
+
+	dev_dbg(ice_pf_to_dev(pf),
+		"PTP offset valid for port %u, Tx timestamps enabled\n",
+		port->port_num);
 }
 
 /**
@@ -1266,13 +1283,20 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 
 		/* Start the PHY timer in Vernier mode */
 		err = ice_start_phy_timer_e82x(hw, port);
-		if (err)
+		if (err) {
+			spin_lock_irqsave(&ptp_port->tx.lock, flags);
+			ptp_port->tx.calibrating = false;
+			spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
 			break;
+		}
 
-		/* Enable Tx timestamps right away */
-		spin_lock_irqsave(&ptp_port->tx.lock, flags);
-		ptp_port->tx.calibrating = false;
-		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
+		/* Do not clear calibrating flag here. Tx timestamps remain
+		 * disabled until ice_ptp_wait_for_offsets() has verified
+		 * that the Tx and Rx offset calibration has completed.
+		 * Clearing it here would allow Tx timestamps to be reported
+		 * before the PHY offset registers are configured, leading
+		 * to incorrect timestamp values.
+		 */
 
 		kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work,
 					   0);

-- 
2.55.0.814.gc42f45431d0f

