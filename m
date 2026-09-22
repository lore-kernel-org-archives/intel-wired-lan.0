Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DFBC9830B
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 18:08:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F69C407FC;
	Tue, 22 Sep 2026 18:08:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZBGjmAetAl9U; Tue, 22 Sep 2026 18:08:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2F161407FE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790100514;
	b=X521Quq8b3NIrBvqx2bRc1T73l8Q9yVwhSykreeKCW9Y/AmgHJVuvK34RC8e0HIlidIF
	 nXUSrrs9t4sGE1Eacf2Lq8nHYA8sy3pTRN201xvcJdcdvdfqDyNmx4hf3XKYaLl6rjMKm
	 r59c4XgQGdYxJfRaIplH4p2JYHFzF34388aUKtFpJhXO1DDhX7RdVgUuGWBpNs15ntYPv
	 MXDdXLZ239Zw7puxUcbOjoKNTylEpnH5CG5L07QfWUxj5dCLXiJLEK+u8j6d9LLD23g2u
	 69VfzSh4NHYKqioxzKTeOWJl9x0D5fQf+Z/nKsHhgLJIuhR71UE1/jGofRBWevbanZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790100514;
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
	bh=ahX5HAkoDeu8T7McYkpoFD4xOsEYrA4bs4Xe1aF7Xh8=;
	b=GLOOyQGKkZSRMPTJ2QpxsyBPinfvHtYDSecJzbWvZaZdTHVzOU+0tZzmP9KAOxMIkjhQ
	 I6HEysfEuySZNCbotqZ8UTLQpUnSHQ9otWjp5EwsyVpb72dBa+BMnzyQtIuu+JwA4q6Y+
	 mc5Vr8HIpTe5/6bsQbhy1fBYRta244BZ4darlmwmuyLLfIi+RR1AXsUZAEGBRWr6vTQuT
	 TcPn9tKV29K+Bdqh6G/9RaRbLJus6ocNzAtZDaiXNxPnNGKpBsuaQBJ1e926DyDuBvohI
	 rDd/ovEjA5laAV6AfT8ZSH10g2n7dCn5ELBkNDqhTjMt1nZgbddp5UFlzTHLbojjh+A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790100514;
	bh=ahX5HAkoDeu8T7McYkpoFD4xOsEYrA4bs4Xe1aF7Xh8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TI3kpeJWv/pGCbE9ZTHmIcbSaIfHz5BW0JEx+I0YkehbYAOnqMCJnnLoLCdbc+w9q
	 DDC9v+/X9O9quYzoNGUageBmKqolvFosiRjl5yz4bzx7MUOG/luDGu0CJAlAqWG3VM
	 TrvE8AmwNL+WSsQwDXLKu/SanulrR+W8Xr2fl+VLwGANCShAuuW1O8yzMuq3O0BzL4
	 d5vT39UIxp2JZbF+I86KeB0mkPpLX8Rni0Hh/dFkX9VDyvS2N8hlMqOqOqhSe2nega
	 8rrTgcwP5FD1p/x9A/yqw9rQkLQNIom1D/n4cGUk0jOALHiJMX1Mkkj9vp0Et+4yPP
	 zjeeRysm6aOIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F161407FE;
	Tue, 22 Sep 2026 18:08:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C18712C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1D73240068
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SqtrSqU3qbDt for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 18:08:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0CA3440076
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790100507;
 b=J7UKf7nZk+rPgQfBP88E1+wS762ozuAiFxXNG1yRl340Z27MxRao4+rFB861KG/7Jjds
 ziu3FeED1xny9BVReMg+mn0N65aIZxy2taWqcLfCisva1wtsG9Sl67zD5YGia7f66NHme
 0tmdQpMLAKjtyMSB1TsKRrMpYPnnO2/CduKkth6KORYQ4G9iwlZhqMIKfk55t3J/iHqPs
 KukDFuqqZECQgWAHj9CTqC7WBO7lwum4hVYXe/E4Y2VS1UIsEMZQuZcJXhy4beCroUo/f
 +XvXrGRohJpcHkM0/uj0CPpT1ISqGoELWnUafYkZq9OYZNlSfdDj4n8st80RcZEMUYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790100507;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=ahX5HAkoDeu8T7McYkpoFD4xOsEYrA4bs4Xe1aF7Xh8=;
 b=aQ4uY9RNDnGhV1cc5rieOsp4rSj3Rk4WfoXhQqw9jMS4QqvlbAT5Ed2BTl1HQ5/FZCJ9
 5BOI4/FfOGxXbrS8ZocGAu64YAFYUIEdKV2s3A7FWrK0lIOAiK/CJwcTyiq+Jg2wV+veU
 1Rq9+X6OPvP/IRKgJun4eIHAb4WBXHiTzWYq7Rw/TvBoTW7D+sODgDv9imUrA7Y7xKvJv
 7tQBz05uFGdfvfQlkorfOfqdBmTV4S9tCWW1hK3D1HGScJiB8qhEqamQrnWkhlNF2CG4c
 leQZiVf9qP3MYZ60R6bdyeiuy9BlndwM+vlsQr9cYqo3uWQSBE3n4xXxZydR8o3ep7w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=mU5tZ8CW; 
 arc=none smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=mU5tZ8CW
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0CA3440076
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790100507; x=1821636507;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=I5AD9LG/RJDbDn+7pcYsp7MZuP0w2/C+lYgiDjHYQRE=;
 b=mU5tZ8CWGgab48K0ede/thWFodEGeWTGm1jvLsqVgErNtcuXGK2T0OWY
 /ExD5jKk8a+Yk+nNkmsCIx9OhNN7OrN0McvuUlAD793LcD7CzbrokZfkn
 onaXLLknSw/Cvjm3jPe8HqqJuE8SgSgq0oNh5ltjK8A3ueL7vZaHLBHjl
 LARm+9MAvH4Sjf87KrQAdLHQ/WUXzmD+v+HkHXqwkH9f1iHP5u8kK+xbY
 AS2u+r3KO6r+l5weVog2kgO63VHh4yrTSlBN09J6FWBeOilVcGdbYpzJ4
 /xPFKxlZDpezSqj6InMk5HKnrogEcAvABTnPhaXrJqGbpNzGULYnVIdgN Q==;
X-CSE-ConnectionGUID: 6SCb46/oT2+YXDVd6uYrmQ==
X-CSE-MsgGUID: VIWiZrVdRzmvKBTRNx7nPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="108232034"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="108232034"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 11:04:23 -0700
X-CSE-ConnectionGUID: IkDdG6CUQkqt8jF6OMJ4lw==
X-CSE-MsgGUID: sYhxT+gNTaWpQh1vLBQK5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="281315311"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 11:04:23 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 22 Sep 2026 11:02:38 -0700
Subject: [PATCH iwl-net v2 05/15] ice: E822: keep Tx timestamps disabled
 during offset calibration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-5-e55b692d0e6b@intel.com>
References: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
In-Reply-To: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, netdev@vger.kernel.org, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=6030;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=LMKv9Rckqm8xrU57YLqEs3ZI+P4/mCmZPP3UNpO2m0w=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqxNh6U+7THc935+1/EPW7i59E9ai5w8d13n+Aeri6kvD
 TLsVOqOdJSyMIhxMciKKbIoOISsvG48IUzrjbMczBxWJpAhDFycAjCRL6qMDN9lVHINbOYYvLU9
 u3el/rTNbixXdqgGJR5zerx/4+vl8ScZ/gfccZ//5MyZlWfdn/456Lv8zkwHP4cDm60me/y8s3d
 OXBM3AA==
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
index 1bcc78d08d2f..364f0f389d85 100644
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

