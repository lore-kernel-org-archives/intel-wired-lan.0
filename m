Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61381C5DF9D
	for <intel-wired-lan@archiver.kernel.org>; Sat, 22 Aug 2026 00:15:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A67D240C08;
	Sat, 22 Aug 2026 00:15:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 31FnIzbR6hCU; Sat, 22 Aug 2026 00:15:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787357704;
	bh=7WG0Q6VWTKGF8gqcu6vaUBn+uPy1SW3wHQDHNeVrC90=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hd8pjHX8ehQ1AU66Lq12V8hFvdSnIhkFvpL656pHFelES7xi9ZNHPXvqrZ4YyiyLs
	 XElBHAYy4auBigKOzlHu84ATwSWJ6vlgGMQIreebhQTPZpwG6gnk3vQAr8Yz7ASX1s
	 DlGDlT0LwCRstAEGk3Qtz0qQq9myWuurB/G3ge4DxLqUS+Ts9/MqN+DZMlBbv04opo
	 2wuGAcLpLPl+kAK/RiBgLHhJjMoHiaJhX56jVinU31yycug0Frg2WrVdvjdYEqJmK9
	 Ux05bPNKrmwPicsN4O8kP3vS6X/EU9T0ilM7Df2P0c7H9PXqSmc7ojW/uFDZOLJp6c
	 3eObm5rsC014Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4F07F40C4D;
	Sat, 22 Aug 2026 00:15:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DEDE2EA3
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 00:15:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C0DF240A15
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 00:15:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zzcKw2Euf6Gf for <intel-wired-lan@lists.osuosl.org>;
 Sat, 22 Aug 2026 00:15:00 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=XdUeb07b
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 031A340A12
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 00:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787357700; x=1818893700;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=DdiuRcPosYhy7NuVjHP3/zhyDcqMNAbUl/73h11PIl4=;
 b=XdUeb07b68zCqmW7BNt6msFBOmNfjU5LaQvEGaPblJzjnXECgpaSlHXL
 5SRv6oshHOpaF48Hsfw3dgbEpFq2SaDfwuCl8qmwYH8JYVjGiU/2+Pzrx
 3cWdFBytxTiJ0ful/o1M/ZYv3YBsVmt7UB9zVhScbCN4xKi1incjrBwvx
 H69za+wMQngrU9eQK4V1Drer4s3eCyiwUEWrKJErw54RTWe1/r52ibyR2
 PC1GZg0mul8Pamb53ayAlMWkMJE1wrk8CsxaM6Z33dWRQyou2r64XKw8H
 fdqD4nhNeV2xkSNoT6U6pdKmguckMMy0atIDOYrU7fB7VeU4US/Ogbzov w==;
X-CSE-ConnectionGUID: 0ocmhYJKRqyExL6IiYxEEQ==
X-CSE-MsgGUID: nPv9dd0hQDSaguZnbyZBkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91584780"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="91584780"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 17:14:59 -0700
X-CSE-ConnectionGUID: mlqXvjHeSu67qo1hXgFPYA==
X-CSE-MsgGUID: 6w5qdaGrRS253bR0oYOB0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="263836484"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 17:14:59 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 21 Aug 2026 17:13:13 -0700
Subject: [PATCH iwl-net 08/12] ice: wait for in-flight Tx timestamps before
 flushing the tracker
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-jk-e825c-minimized-fixes-v1-8-9d0731eb4858@intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2476;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=z6i5K5O1IlONQimxEEaxr21SOuuhG2xszeqrH2sUzp4=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqyOl7+6RCdFL7M7/uiyzoRlr/YF13Y/ZFx8df350GfLp
 qTZNC8X7yhlYRDjYpAVU2RRcAhZed14QpjWG2c5mDmsTCBDGLg4BWAijSaMDO1JbQ4bK39571Bo
 3HfRUEmK69M598e+208etXfxmh+ypZKRobtZ7QlDUa2Ek0TLPQMexTU1fZknP+7UYzk7a2sf68Z
 0ZgA=
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

Fixes: ea9b847cda64 ("ice: enable transmit timestamps for E810 devices")
Signed-off-by: Petr Oros <poros@redhat.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 8aa49dda90a2..a049dc7a2241 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -740,6 +740,37 @@ ice_ptp_alloc_tx_tracker(struct ice_ptp_tx *tx)
 	return 0;
 }
 
+static void
+ice_ptp_wait_for_tracker_drain(struct ice_pf *pf, struct ice_ptp_tx *tx)
+{
+	unsigned long deadline = jiffies + msecs_to_jiffies(10);
+	struct ice_hw *hw = &pf->hw;
+	u64 tstamp_ready;
+	bool pending;
+	u8 idx;
+
+	if (hw->reset_ongoing)
+		return;
+
+	do {
+		if (ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready))
+			return;
+
+		pending = false;
+		for_each_set_bit(idx, tx->in_use, tx->len) {
+			if (!(tstamp_ready & BIT_ULL(idx + tx->offset)))
+				pending = true;
+		}
+		if (!pending)
+			return;
+
+		usleep_range(500, 1000);
+	} while (time_before(jiffies, deadline));
+
+	dev_dbg(ice_pf_to_dev(pf), "Timed out waiting for in-flight Tx timestamps on block %u\n",
+		tx->block);
+}
+
 /**
  * ice_ptp_flush_tx_tracker - Flush any remaining timestamps from the tracker
  * @pf: Board private structure
@@ -756,6 +787,8 @@ ice_ptp_flush_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
 	int err;
 	u8 idx;
 
+	ice_ptp_wait_for_tracker_drain(pf, tx);
+
 	err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
 	if (err) {
 		dev_dbg(ice_pf_to_dev(pf), "Failed to get the Tx tstamp ready bitmap for block %u, err %d\n",

-- 
2.55.0.814.gc42f45431d0f

