Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68510C98307
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 18:08:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 35BF580E9B;
	Tue, 22 Sep 2026 18:08:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F2qlOpSANYqh; Tue, 22 Sep 2026 18:08:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8D12A80EAA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790100520;
	b=NtVSfj95owkB4WXsT3m0zM7ywjL+A9lc7kNtZlMOjO0lIyxQBIIAIMme/600pIsxbHzk
	 KOM2ycTpfA0A98VTK6U2aVJN5/yR5tHZDg0wM2JWVnNHkAiDrfx0Wuu6nLJ0uRPpWZ2uN
	 LGtn354CizDpXcNlC9u7mTA/Vb9Jj5m3u10OjLuDgssvxVwUXGMDYIEgyiebvZgL0TFPB
	 ZY/KSGxzULJHngV+vmHqg7qq61QavUdptj4PG9GEibnivrIC5aAjk0c4x17l0nPNbwQvQ
	 u/4liIPavTAezsCdJRHZlLERwhONCa0kFm5eD94Vtwct3d8gfTI1J4M1SYMOS3+sDVw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790100520;
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
	bh=evLOSJZng0b9CyOsjFEWUh1l1FRfqz7Y3lUUYqTg3tI=;
	b=Puzcd1UXQeenFfY47HU1ZaZW7VA38xbBQYHVg5uTnGbTrZ70Ra2BnRMMTSYnCe0HPHqr
	 20xvhUymFS2DIJZsRqvBX5PRFFHX+96Puc4WU9+4G2QkYUV4Zd28MhWCpr3sSNsCGcEtS
	 ePkFs/LcgeBp+J1BxXmpmuqY3ayzo3Khy0dFr0RmtxvFOiEvci6zEvwSxgqOMYa0MHzM4
	 fx0GAO48G4L41N8KnMZoSD1pDjDON2x9tLZ4JqQGsmQbCpbB+aU7p/NkmdwAx/d/dkAIp
	 u8cknA8tHJbVWBcrgM4+7r5Zl3CXSP9perBMewiYO2vLSYU5JnokRl/Ik2r+BkfnXww==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790100520;
	bh=evLOSJZng0b9CyOsjFEWUh1l1FRfqz7Y3lUUYqTg3tI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6GiwH8uNWuVnKRROZL6lvjqGJkNosjfGF4TGehCwUPczce9VXK8CxWiG+X2eBfLzd
	 e1r+X/9UwabarO+rDcjR3o292Mc3Nwzm1HpViohyLSIMY9tmQMhqUESdUpuBo0bVLu
	 8usfvPgPWClf9GgT/4iymvYgfBlSKIiATXColamd+8NPljyzcQZMZXbQIv9JlXlNPW
	 QsaqmSDw+IrsBXmi39EO1lhQJp51UcKHcTh2pyf//m8Y5ReCOOjH8DcYax+yhnOfRl
	 gIW2MsJa+B5RdtJoH6U9MdAvkvoz1Oi7/MXXLKLw5vy9EzCfy/6aSH9yc91Uql2KxF
	 GZfIq9vSWwNoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D12A80EAA;
	Tue, 22 Sep 2026 18:08:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B3A893A9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B22B4406FB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7WA9u0HpZbXM for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 18:08:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EBC934075C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790100508;
 b=DGlhqJEoeQfLCHjeASIOzrNkL5y62J78oi3cfgJ1SC+n8sxhsUv5xV6/LrQS0YWJ5I0H
 SEg8/cVc2KvekFDV2aerdvZ6bYmfrsZSaG4X0oGcmP+5oilEfDscf9r5Amk0rjLvGziPy
 Knxh1EfZa8fCW2GClAEi5fWFv3+z7ncvmG7BFF9eRTz/Oup9rVzBFuqPNYhL1rDitsh0h
 Vt57MY0vB29nub1Bx0Bev1sS/EplNK+y/9PcXiVZFk6uW9yMXuH4Xf+UXJWg0jUM/UVc6
 9iizcxscC1qY0hbc2HaWo3b6BCZCYvUF7PFf5aRPIiOGntoUhC8R7k7e8cMFgDDckqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790100508;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=evLOSJZng0b9CyOsjFEWUh1l1FRfqz7Y3lUUYqTg3tI=;
 b=QEIL+8f+KRpQxsc7EZg09AFGa/ncUJ3AvkTd73Y2XwOXRBzjlhZ3K0vWKrn+poBYW5Z3
 13l601INH5KNNW/zqCC46NFaJT4nbUhNQL6VrcEjabiWiTSKETHjWELoeQD/FNnFdowIq
 yry2ho6eYl+XMKL1qnkFU9cHzwUQbhfuMbQa/Vaf4wqKNSRiosZNDPMQZu9m6saVHN4+j
 2PHylqwJW3k3bYHkS3SCKj0jMFyILlEvW+Nruv4MmcXwx/q+83WWLlwk9m6EDGkN5HbYo
 /kaxtK6ja2msG4/5K5hG5I6TaZquZdK1Lf55ro2k1H2bnpUZHNdf1PUUSwQ72G+FPWA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KS4shsev; 
 arc=none smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=KS4shsev
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EBC934075C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790100508; x=1821636508;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=31BLiW6+gM0P/lNSOno+h9fVruEdC4wIwqDW9dNzsgU=;
 b=KS4shsevrYnm9DFHTwgjeQmd9Ro2AqBw02PR+qpKpw/MZygmUR6vyGUX
 tLHISW1SIpP6m9cHTITh/eqzoOh0i3NVVE0mHhoySMs49DpMYI8bDWwnO
 B0B7EBLwa/jx5fEoUICDCw45fnc8eTyl2AbftuzUZDP8JMTNcehLXAC3s
 ZM24/kyYvHSSlYRd9wufwG838obuLTRviHBsnwSwSU93vF4WqS7+Gxupz
 fOpi4OYYh4AhAKkEeO80n8wMdsd/bC9RL/u6HLr/qWrK+kJ0rf+6Fn/J1
 1f/DdWI2PM4nrlWJqKwgQtc7i61EAKxxireQ+p3NOc4FyZcgD13eO/SbB A==;
X-CSE-ConnectionGUID: lB+ammDkSkyo/MVk6UjkqQ==
X-CSE-MsgGUID: b/ap/eTmTKea0yi3bkBuJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="108232052"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="108232052"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 11:04:24 -0700
X-CSE-ConnectionGUID: T+sVDZZfR16XKOERX5kDxg==
X-CSE-MsgGUID: uZSB8qFcS3Kb0GA3KTASrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="281315337"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 11:04:24 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 22 Sep 2026 11:02:44 -0700
Subject: [PATCH iwl-net v2 11/15] ice: wait for in-flight Tx timestamps
 before flushing the tracker
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-11-e55b692d0e6b@intel.com>
References: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
In-Reply-To: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, netdev@vger.kernel.org, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, Petr Oros <poros@redhat.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=3027;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=GJLyGkVYnnRRmU5BgwXqkMVcvvTKw8l4fUj+knzvHbY=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqxNh2WWOidyskz62PdbfdLqvxu+Zimc/i3pedRy4f2t6
 +XXu5g7d5SyMIhxMciKKbIoOISsvG48IUzrjbMczBxWJpAhDFycAjCRDXaMDJsXZAudTPm3r5it
 Uy8nKDDYVvHZi81Ltm/OfOj+9jx3wjOG/9XXheftmf0zZ3KdvQW7EKfYtHIrVh+DBVaneKNsXzP
 sYgEA
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

From: Petr Oros <poros@redhat.com>

ice_ptp_flush_tx_tracker() frees every tracked request, but a request
whose timestamp is still being captured by the PHY at that moment is
freed without touching the PHY entry. The ready bit published shortly
after has no tracked owner, and the PHY does not raise another Tx
timestamp interrupt until every outstanding ready bit is read, so
delivery for the whole quad degrades to the periodic work.

Wait up to 10 ms for in-flight captures to publish their ready bits
before flushing, so the flush clears them together with the rest.

Note that the ice_ptp_flush_tx_tracker() function was introduced along with
the original E810 support, but that device does not have a ready bitmap.
Only later devices (E822, E825, E830) have the bitmap and potential issues
with internal tracking. Thus, skip the wait for E810 by checking the
tx->has_ready_bitmap flag.

Fixes: 10e4b4a3a3e1 ("ice: check Tx timestamp memory register for ready timestamps")
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 43 ++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 657cd78ec738..142d9e1c1f2e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -744,6 +744,47 @@ ice_ptp_alloc_tx_tracker(struct ice_ptp_tx *tx)
 	return 0;
 }
 
+static bool
+ice_ptp_is_tracker_drained(struct ice_pf *pf, struct ice_ptp_tx *tx)
+{
+	struct ice_hw *hw = &pf->hw;
+	bool pending = false;
+	u64 tstamp_ready;
+	u8 idx;
+
+	/* If HW reset is ongoing, we can't access SBQ */
+	if (hw->reset_ongoing)
+		return true;
+
+	if (ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready))
+		return true;
+
+	for_each_set_bit(idx, tx->in_use, tx->len) {
+		if (!(tstamp_ready & BIT_ULL(idx + tx->offset)))
+			pending = true;
+	}
+
+	return !pending;
+}
+
+static void
+ice_ptp_wait_for_tracker_drain(struct ice_pf *pf, struct ice_ptp_tx *tx)
+{
+	bool drained;
+	int err;
+
+	if (!tx->has_ready_bitmap)
+		return;
+
+	err = read_poll_timeout(ice_ptp_is_tracker_drained,
+				drained, drained, 500, 10 * USEC_PER_MSEC, false,
+				pf, tx);
+	if (err) {
+		dev_dbg(ice_pf_to_dev(pf), "Timed out waiting for in-flight Tx timestamps on block %u\n",
+			tx->block);
+	}
+}
+
 /**
  * ice_ptp_flush_tx_tracker - Flush any remaining timestamps from the tracker
  * @pf: Board private structure
@@ -760,6 +801,8 @@ ice_ptp_flush_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
 	int err;
 	u8 idx;
 
+	ice_ptp_wait_for_tracker_drain(pf, tx);
+
 	err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
 	if (err) {
 		dev_dbg(ice_pf_to_dev(pf), "Failed to get the Tx tstamp ready bitmap for block %u, err %d\n",

-- 
2.56.0.rc0.395.gd1f3524e15dc

