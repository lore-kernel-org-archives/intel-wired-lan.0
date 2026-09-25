Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC10BC9832F
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 23:58:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82EE440B84;
	Fri, 25 Sep 2026 23:58:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OmUwJ7CrTCg6; Fri, 25 Sep 2026 23:58:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B153840B88
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790380690;
	b=LZ4JmT55setbiA8XQEXOc1+BFQEVGd0zH9aa4DMyMrN0uAgPIYpWCLupzLj0mELO8o8j
	 KcTXKovzN4vH4rc8c1qiU6xd3n5QbswZqpRpJZY/wDh9UP3Qkw8oG7V+8EPBbfiond/wR
	 s8u97u5lzVvjuKnF7MOibSl5fJPXmNjk2EWA89layxdiwXRBptNC1LskaVOWMZc+xoKMx
	 lRV6Fpf/dW4zX9fQ0fjHIRjRDpFl/U3h8TBLzBAgp8IDwz4Idzcb6p298BP2a08cuTP7P
	 77fhM4ctrJ6E+bvc2Q1NpQCE4foQE3wIO8O3Xz2AXCeyMoJNRnzz5m7qxfYWRvU4Nlw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790380690;
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
	bh=oNHl1vKYn+zq4iPpaT2PeAjox/O77jgUsPi04vVa2jw=;
	b=e4ERrSxK/4F5F2hdhVohfbsotazu5L/2NmpkcqWccTdUmcqnc5rWYR9/8u42uRrcQy/n
	 69V+b7xaqH1QgmSexxam7chuSXv1+vQsNnao1ZmnRed4NU5YlDGsCzyVFjubJLYZAnhcY
	 +0QMzCwrom7wu+oPvZcBz11Z/Kvi5YEo3OArfR5x/Ge2LlLA+IbzUkCo64gJWr5UCK0vl
	 izvxDUJxqcHTuL+fgfP4lbwzX7pzLP9/3NdmVLG0DqbSsdklqx5aVcaCoA9zXZG4oa4ys
	 8+FTSP3xSE/+jAU/1Nv7d9x1NHQJZFDbEFTtiZ8GMZlEzilEv2Cb9+PxmkLi+8JKv4A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eDtYn2D9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790380690;
	bh=oNHl1vKYn+zq4iPpaT2PeAjox/O77jgUsPi04vVa2jw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sjs3f4W/ThKZVryahuzVE0OaA+ffDcvbwjgT4UfKA8InEazim/S/PN5bEFSjAaS2F
	 x+EQVxCmnw6ykYSD7DiuhriKRsDMc3dfHpeZGijEUmWEa1sH6SeT4WflOQRcD3pOsh
	 aOa9VnkzKMW8rcdRpU99jjd+jT8WvPEiSXax26F25JI0txa2NlpIOEEYYcwLJsjQT8
	 Jby1+z6rZSnMluTtroH78je1x91caMRC1iJZqvp4LOsuramZmTz4ZtFlMRNThinDPl
	 NFeK38Rd7wHIGU/z++of5SKDzLKqsOi1Pws1AGZ2VV9w1wMe9gX6h/SXPJBlA8ehfW
	 3O2sYaGG9q4Gg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B153840B88;
	Fri, 25 Sep 2026 23:58:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CF814355
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B50C040B46
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T9E581g5l1Iy for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 23:58:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C1D8A40B84
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790380686;
 b=HTMeLfdLWlipIkWpKYznzuXPHNsuRLn0kvf7P29scc0KtPWkWsT1zx2ib2MnhEndi30C
 y8ZeuaCFyO4EiFtL/w7Gw0rMIN5/jGp+puoz9D53/kEERYpXqezaBrOZFdfWWpJZhqROa
 Fzd8zQELCDP+iqXtcD5ErAW6lFyp2Jvg0Pu9EEZrvGUKCb++dIa9CTWoCso5YwjO15AQm
 QvDrK9LNQThNgx+AP6vQjps1tQV+mIWAk0a51sT9Vb59KblSIJTrgJDHDXSffGOfW9uEC
 XxH2pLsfPukZfvzKhw9kLfJGBeOfWebW9dC7O3ZYEQvGX8p4EW4rUVl2Dbqdvn2Vmwg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790380686;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=oNHl1vKYn+zq4iPpaT2PeAjox/O77jgUsPi04vVa2jw=;
 b=JMtyAu8k2JXJskWh1zOMR1l+W6o7fUwSDMFQb3iykzEonQO2oOocNrZEQB4mVBD6mbRx
 WOn2P9jRMTcPGcFKwEj8O56eSqIo04qQzHqnHLnmxGAdPjNlclH9XG7lEEU/dGeYJEAa3
 zrL8kZ6UMmXD+UW12I7euPNTLNSmTUnD5EGXYaKFfNRvr3TQsY+zssZOPyAoQ8GBVSlKK
 zhOyyzf81M180OV3rDzbocW27CBPdW3TpXVoVPBUoJ/15RExKt5Tm0QznihMsYddv8BTS
 F1fk3iqSjzwA8zwsSTitKz8wA/7alOMQzol7M7FeaIRkNT806kyMa6cxMQ2fHpElklA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=eDtYn2D9; 
 arc=none smtp.remote-ip=198.175.65.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=eDtYn2D9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C1D8A40B84
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790380686; x=1821916686;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=kfD9YKii69QGOLNOzXIhg6JLIBL2jq6Qbx27TaoiIZQ=;
 b=eDtYn2D9lLbTWkWkvnEqa+X2Au8oi1Vg2PoRcV45YxDLza3f9UypSKPS
 AYM0EOByDSbjhfzuvpxER2Xy2C3HxrApiUi2ILJdPiiGIX/DcOf3Fkh6d
 tvWJQ5Jo0OFCtzeD/nET6MeRENVepu1vYsdyrWXdIl2GtJSR+J236eq2T
 hahREhbKULvT2G/14BwUIuqRTC1anJmNv9njWP1UnQGNmXx/zHGjPQ2Oo
 neP72mgzCwRRYVI9lgLfGpvWuPg1St+0haFBGZoiBi7MZuhQYXk1BIe6A
 CEnWaE2bsvTg0MH5KX32B8IZkIh9ewv+Ec/mwjDvLk7lwIZaXb3aU0SCL g==;
X-CSE-ConnectionGUID: dKVqyBMJSneI7WL82bgJag==
X-CSE-MsgGUID: 73Bq92jfSCSNeOOkpV0n8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="90212809"
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="90212809"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 16:58:03 -0700
X-CSE-ConnectionGUID: wdL9smSCQNmgc9WZAjSoFw==
X-CSE-MsgGUID: xmsxOa0YRvixfQWP3xEzCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="300731117"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 16:58:02 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 25 Sep 2026 16:56:38 -0700
Subject: [PATCH iwl-net v3 06/15] ice: E822: keep Tx timestamps disabled
 during offset calibration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-6-6532598e8da8@intel.com>
References: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
In-Reply-To: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=6030;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=qVKL7S5Oe/lqnFvqEuqp7xXFeniEOHVlFXsjys6yawQ=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqztXJUGknunVTnOv3Ns0uc1LNLTKk69vBN0skMy+39d8
 gLT14uKOkpZGMS4GGTFFFkUHEJWXjeeEKb1xlkOZg4rE8gQBi5OAZjIWUFGho2OOauWXLQy7zh9
 6aH6Na/K8zMbQ9eWHntxofvyw0zxab8ZGT7ESG38oa5q896kftNcl4ertvkfn7j1VphXz48/79Y
 fkeMHAA==
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
has confirmed that the Tx PHY offset is properly configured.

Previously, tx.calibrating was set to true, then immediately back to
false right after ice_start_phy_timer_e82x() returned. This allowed Tx
timestamp requests to be served during the window where offset
verification was still pending. Timestamps produced during this window
should have their valid bit cleared, but it is better to prevent requests
until the driver has confirmed calibration is complete.

Move the tx.calibrating = false to ice_ptp_wait_for_offsets(), after
Tx offset configuration has completed successfully. This ensures that new
Tx timestamp requests are only accepted after the PHY has properly
calibrated the Tx offset.

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

Note that sashiko review has previously complained that leaving the
calibrating flag enabled "permanently" disables Tx timestamps if vernier
calibration never completes. This is true, but its important to realize
that timestamps would still fail regardless of whether the flag is set.
Until vernier calibration completes the device will not report valid
timestamps regardless. Thus, keeping the calibrating flag set simply
prevents new timestamp requests from software while it is known that the
hardware will not complete them.

Fixes: 3a7496234d17 ("ice: implement basic E822 PTP support")
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.h |  2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c | 29 +++++++++++++++++++++++------
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 27ea502b7576..029ee4612d76 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -107,7 +107,7 @@ enum ice_tx_tstamp_work {
  * @len: length of the tstamps and in_use fields.
  * @init: if true, the tracker is initialized;
  * @calibrating: if true, the PHY is calibrating the Tx offset. During this
- *               window, timestamps are temporarily disabled.
+ *               window, timestamp requests are disabled.
  * @has_ready_bitmap: if true, the hardware has a valid Tx timestamp ready
  *                    bitmap register. If false, fall back to verifying new
  *                    timestamp values against previously cached copy.
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 220d174397ba..7f82439c47ee 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1161,6 +1161,7 @@ static int ice_ptp_check_tx_fifo(struct ice_ptp_port *port)
 static void ice_ptp_wait_for_offsets(struct kthread_work *work)
 {
 	struct ice_ptp_port *port;
+	unsigned long flags;
 	struct ice_pf *pf;
 	struct ice_hw *hw;
 	int tx_err;
@@ -1181,9 +1182,26 @@ static void ice_ptp_wait_for_offsets(struct kthread_work *work)
 	tx_err = ice_ptp_check_tx_fifo(port);
 	if (!tx_err)
 		tx_err = ice_phy_cfg_tx_offset_e82x(hw, port->port_num);
+	if (!tx_err) {
+		/* Tx offset has been configured, re-enable Tx timestamps */
+		spin_lock_irqsave(&port->tx.lock, flags);
+		if (port->tx.calibrating) {
+			port->tx.calibrating = false;
+			dev_dbg(ice_pf_to_dev(pf), "PTP Tx offset valid for port %u, Tx timestamps enabled\n",
+				port->port_num);
+		}
+		spin_unlock_irqrestore(&port->tx.lock, flags);
+	}
+
 	rx_err = ice_phy_cfg_rx_offset_e82x(hw, port->port_num);
 	if (tx_err || rx_err) {
-		/* Tx and/or Rx offset not yet configured, try again later */
+		/* Tx and/or Rx offset not yet configured, try again later.
+		 * This is expected during normal link-up: the vernier offset
+		 * calibration cannot complete until at least one packet has
+		 * been transmitted, so the first retries routinely land here.
+		 */
+		dev_dbg(ice_pf_to_dev(pf), "PTP offset not yet valid for port %u (tx_err=%d rx_err=%d)\n",
+			port->port_num, tx_err, rx_err);
 		kthread_queue_delayed_work(pf->ptp.kworker,
 					   &port->ov_work,
 					   msecs_to_jiffies(100));
@@ -1276,11 +1294,10 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 		if (err)
 			break;
 
-		/* Enable Tx timestamps right away */
-		spin_lock_irqsave(&ptp_port->tx.lock, flags);
-		ptp_port->tx.calibrating = false;
-		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
-
+		/* Do not clear calibrating flag here. Tx timestamp requests
+		 * remain disabled until ice_ptp_wait_for_offsets() has
+		 * verified that the Tx offset calibration has completed.
+		 */
 		kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work,
 					   0);
 		break;

-- 
2.56.0.rc0.395.gd1f3524e15dc

