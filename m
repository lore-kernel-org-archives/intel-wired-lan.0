Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BABEC61DB9
	for <intel-wired-lan@archiver.kernel.org>; Tue, 25 Aug 2026 22:55:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE20A4073C;
	Tue, 25 Aug 2026 22:55:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AbtcFXvAZtuP; Tue, 25 Aug 2026 22:55:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787698511;
	bh=/zysGyK4DsLqHIDA5e7bKk9ksazejMCwNbaI9lvlLWM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D5jR+Gso0unkm9+vhcdevp3AEX8Y3cS2MgKXvB1lj2Hmmpix/lmu+3sNSqJLSXN3P
	 miK7kBLg9iH7olrVPhuZjQEO9iVPbHov2TL6BGKHaYDVgIXNAgh64S0FBWnXVyQP8g
	 ZchBHsDsWATNyF5sh1mLQEu2uRwTEZZmFjlnflO7Pf77b74JNCXfUN3udX4vYbOZKr
	 1gMu+wVdTAXOK9HX1zymDRjHz6FdaySqpc7v2UMxUiDJ7ibLZoVDJKQR4qXvol/IYb
	 YjEuiQSs3FyfwpNDZi8gkWtH4BmVg7Cnop5Uwb0xaL3Ysa7CdwlhVVBUf/pjnE6NEj
	 wLuy1iZlQpkCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E223640746;
	Tue, 25 Aug 2026 22:55:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C152E230
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 22:55:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A779F406E5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 22:55:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mApks-GCh7Az for <intel-wired-lan@lists.osuosl.org>;
 Tue, 25 Aug 2026 22:55:06 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=lCOenrk0
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A7E9E40688
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 22:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787698507; x=1819234507;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=DADCx5ikbCjxZtfqVaLtabxb276pvs/kXKBlg9ol2f0=;
 b=lCOenrk0BO1TUiFaLigScwvwk1BQCFD1IjmBjDazkXXuGXUuqPsJymLG
 gejqNc5P6ls64zBHpE3Drx2pLhbf9OCFF+//dyQrQvQQCg43L9jqiaXJx
 /nF/J27kd/NZZ6SZC2QYWGtFAo3b/wcy9jdfGdXNw0WFCrdgib8dyWUfi
 adRTvFylFKUL6eMOQx7u0vFPtPBLaubeL/cGzqG8zsYJuA0iNNLm6nmHF
 A3zpfDRg0vX5QeZmzb7+GJDlxLxyXLkqooZnbJecPLmaGbWuWMjgTRUss
 o02wqoWn3xeDaGn5czS+QKxS804wCn9qvSCCF6Tg7MUzAcGI7SXOA5+qY Q==;
X-CSE-ConnectionGUID: QEr8HJ2nQompBLMlDZQq/Q==
X-CSE-MsgGUID: 79cL7qdfRgeJxfq/UIY90Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="87120425"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; d="scan'208";a="87120425"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 15:55:06 -0700
X-CSE-ConnectionGUID: r7EGaFgHRXmNyLaYQR0A1Q==
X-CSE-MsgGUID: HfkQSuG6Traqb9bCoEnPBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; d="scan'208";a="264789671"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 15:55:05 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 25 Aug 2026 15:53:28 -0700
Subject: [PATCH iwl-net v2 04/14] ice: E822: keep Tx timestamps disabled
 during offset calibration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-jk-e825c-minimized-fixes-v2-4-8223f95d26e3@intel.com>
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
 Karol Kolacinski <karol.kolacinski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>
X-Mailer: b4 0.17-dev-c276d
X-Developer-Signature: v=1; a=openpgp-sha256; l=4837;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=Mk4dR0jl1aKzjq+uRi7trGpIdPS1BReUetnmDWNHCEE=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqw+Wesbe9ea15gstMnik2EP1GR7eSa5yPTZ8V7Feb9/7
 U46zhvfUcrCIMbFICumyKLgELLyuvGEMK03znIwc1iZQIYwcHEKwETi1Rj+Sv/b80//8/Zbju/u
 7vm96N3HI7v+Ghg5C//1Pzh92jKHiipGhs5uu+cPDC+1JMbIBYW4Cp6O1PaWS91/Pfm8i9SJ6rQ
 wFgA=
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

If ice_start_phy_timer_e82x() fails, do not restore calibrating to false.
The device is in a state where timestamps cannot succeed properly anyways.
A dev_err message is already logged on failure to start the timer at the
end of the function.

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
 drivers/net/ethernet/intel/ice/ice_ptp.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 68537705e839..d018f02f700d 100644
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
@@ -1269,10 +1286,13 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 		if (err)
 			break;
 
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

