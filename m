Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08E7C61DCA
	for <intel-wired-lan@archiver.kernel.org>; Tue, 25 Aug 2026 22:55:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB1CD60773;
	Tue, 25 Aug 2026 22:55:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KshgzBfbpALN; Tue, 25 Aug 2026 22:55:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787698516;
	bh=4AD1BsVIGN/dMjob3tZF8FioVawMySQvgJzNdc85cZ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YaWtBn4dzVv3Ka6le8lzHgTnVp5pHQJy3lFTgHA9fhTjl9hYJZ2HVVasZ6JJ7tzcj
	 OG0CYZJ5iPHFp9USvx9OoNT9HKeeHvkHgXO9NoSDG7CwNbNgyuqBBGKUNHklAxjWn6
	 VxSr6bkT/uzx1YfYPDe6KVJvVCBuyutFN24Y/Bha9wzozrEEHqjR96y3lh83CowH52
	 Zsj6vgD/J6Pue7RpZPMu6a/xDPCli92NYgkHi7+65rv6C1/apHECqeVAEinUwz7iYH
	 hfB00MHMC6XHUCJJJqTPEo2ccpvFvUE0QWAD9Cl5ctydq2wVCwBcjuYDuoSQYsm7w5
	 YzYdUqw0mrEjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F41C460760;
	Tue, 25 Aug 2026 22:55:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id F3429334
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 22:55:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DA6D380C0C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 22:55:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jtf5ciAoE8hX for <intel-wired-lan@lists.osuosl.org>;
 Tue, 25 Aug 2026 22:55:07 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=mu97D7ZB
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 84A6F80C1E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 22:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787698507; x=1819234507;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=SYQ638ls0iaQ5NOJX73+AOiJst5sa1nueiULyMyePR4=;
 b=mu97D7ZBUz9KCXfPWZaHiz/nXXnOokI58bxQC0uwjH1DDKoX04A3mYwT
 0i/09/kseanGOJQ4/iffXvdgIPgjCCxRx5r7ZizTe8ue1L4Ddtwth3IDT
 FpPxBSONcTjroV9I3knFL/jb+SXX1YBS8oDhyGJmK4RwRfvUHqdXXnuZW
 XyIXuVR7wYNRGsnIrl4z6HBrldjExe2xl3kUzytM+fcpb3FV7TeS4O4Nd
 XpYcBQBFIP3+CNN7jNQwv4aICrh1mrMfvf9eJI7YARvSzk0+FDrchZxDd
 PxBpQkExp7t8VlUF9uOX3MCHFHRUa7RTzRkRRrE/1fvj4sSr1mltVWmEK g==;
X-CSE-ConnectionGUID: SMJli9svRUO4uZ6h3ad3aQ==
X-CSE-MsgGUID: 3jsL4RRPQfqJ+cUcoJYtnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="87120444"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; d="scan'208";a="87120444"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 15:55:07 -0700
X-CSE-ConnectionGUID: O4HLaHlfSRq/HW4HRfkCHg==
X-CSE-MsgGUID: RDPRJnq2RPe+oSvXB0806g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; d="scan'208";a="264789692"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 15:55:07 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 25 Aug 2026 15:53:34 -0700
Subject: [PATCH iwl-net v2 10/14] ice: wait for in-flight Tx timestamps
 before flushing the tracker
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-jk-e825c-minimized-fixes-v2-10-8223f95d26e3@intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2534;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=nw+J/yGspiIlrSItsx0RtBZBWcC8KghOWywDHXUUTYY=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqw+WdtNi47fzL4VIMQ3/UG6H+/Z9w2blXh3sQVI331UL
 LgnRuh3RykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABMximNk+H5L9DjH1FdHHhZa
 zHZmtdp/0NMxX1cz4I3m+unPDkQrBDEyrMhaEqw8k1mLY1P2vpdFrTahG27Yx+rpHp60fgdLHgc
 rFwA=
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
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index c535658b30fb..59972de1eda2 100644
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

