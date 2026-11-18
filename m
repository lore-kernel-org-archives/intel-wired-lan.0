Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2212606A32C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 00:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=V+ED4X87;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LDcUeIBt
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 901C940598;
	Wed, 18 Nov 2026 00:32:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IcU3uD2dz--4; Wed, 18 Nov 2026 00:32:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E302540573
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794961926;
	b=Zelv/zHa1bxb+KeLqbLg6vmvN36OqrlFrBFeZzhDlnD7/l6IQNzYrAjmOUDZ2FbnxFYP
	 /kuHSvnthPaBGuDSqvMSpPnwrfLWu5jq4JOJ804n8Y2ElhzHDYIYzOEGGzGO36SqDOjUa
	 zYeO05UrGcLFk9QnwxaxC0lTx7//o/OUcKFed574ck0WsGFq0nJSTjZUPJbxEQsV8H0db
	 z60tt15JkBPGQdQachq0/OgULhblDy/9BhcAOVWi6wxPAxOU9lRAcLPLlsEIsg6my1nEW
	 qrr/xDoTbKh1zunINf8hF7nQ/vS2qy/jp9cxy/iRwEc1kRB0nzUpZBwk9OVC6p79W+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794961926;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kGzFg1/y9jzaORvo/keelk1HyeJ4VOqt47T+onI3V/0=;
	b=KeBswU/S3yKTV2887s1gGD6pWDkkzwDEZSC/jb/njYb/GIuWfbUCyyZ1DzLDM3j1C6I2
	 hyMhEOKmjhI1uz7fyGRWPcdS54psL84IsLyxrgxqpzKlkWQ3IUdN/UuVXzVhyS8ZduR+Y
	 cB36zUxKQvbY3ePpK92DgV4mT446bYnQ57FIdTpEEB32F8xW2WlpSvMN+3lyDX0uHrdbi
	 /BHEa4bHsItBaQ7v/o2pMK8glkMS6nwpJ/XedIVWoW3k8kZCibNP96JgpHPPq+v/Phpbv
	 aJc+CPvPPIiUc9FtRvwf9eNIo3pzuiUhp0dG7rCtLocGB8Wt5lvHeubL5YkchrzMFTA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794961925;
	bh=kGzFg1/y9jzaORvo/keelk1HyeJ4VOqt47T+onI3V/0=;
	h=From:Date:Subject:References:In-Reply-To:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V+ED4X87nK7CAVX+m6rjzKbTvkq0SXvEJyWBkvxxPOq7dmipdoqs9ai51fH03QEYy
	 sj/Q4HA1yE6JvtxlPlN89T7ey7lzgcad24+o/A5KsRpohiWadzIRMrrBvEvGpcJKZe
	 RI3DCDN0aZrxw4HkqcizNLcwwKFfhVwMPm95wUX1BgKPDXp/27rITZlP1rL3wmqcgo
	 eI2ZLwzqZbqWyCXb3anMgesUpsLYxJmzXEr14TBrsdO/7P/zXSfIAC0uKXdkGIho+5
	 sgEM5jDC1T+v2VXfkKYSyydAQgooF0t03d5QVZafLzS+7d39kI1Xbzb0nwzZ3jzhgH
	 uvQsYJQC9J0qA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E302540573;
	Wed, 18 Nov 2026 00:32:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1491A49B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 00:32:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 06500607A2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 00:32:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DvtDTxFiUrYI for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 00:32:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0960D60729
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=LDcUeIBt
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0960D60729
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 00:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794961924; x=1826497924;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to;
 bh=kmEcO5NRxwXr4zFW34EtZi4fxRX4Nalt7Uza6uDEy30=;
 b=LDcUeIBtBxDBp1p91zWUoqYFJk4dz3K2qakC6RYzBUoBz2PxWwX3vlLK
 Z9kbbMAktANdatUpAvSnt7NKlhQsW2iI3nrjEMZ+sApWCgZrHlpBk2hFk
 zHGzgMN1hzoVVJHsbBYAPYOGqZi9aZ3uS6nbcxsNxSyxObFE6xnuKM4N3
 HGJWezecTBgaoFrgEdCOh1tU60PaOl4iGBe8Dwtk9NVXfBlJ/AHy8aUv+
 mUfSrdDgFNZmAL4rv1+maSL978I0zd+bRTcPIF4xnJj1b0APMFde5icjt
 3wvRhVATtureEQwsXa0gPxwc+MO+P3+dEA+3L1GTyKgIiaX/nX/qKTPI3 w==;
X-CSE-ConnectionGUID: j2JE6WIJSjGbO5KH1DqOHA==
X-CSE-MsgGUID: y+CANXNfRsSNgvsD1spg6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3618633"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3618633"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 16:32:02 -0800
X-CSE-ConnectionGUID: xXzKYsGsR52rnIF++36bWw==
X-CSE-MsgGUID: z76IkvE7SEWXtPhZOf66rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9824884"
Received: from orcnseosdtjek.amr.corp.intel.com ([10.166.28.128])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 16:32:01 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 17 Nov 2026 16:31:43 -0800
Subject: [PATCH iwl-next v3 1/4] ice: fix computation of ETF timestamps for
 E830
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-jk-e825-e830-timecounter-v3-1-87ea4c86a249@intel.com>
References: <20261117-jk-e825-e830-timecounter-v3-0-87ea4c86a249@intel.com>
In-Reply-To: <20261117-jk-e825-e830-timecounter-v3-0-87ea4c86a249@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Sergey Temerkhanov <sergey.temerkhanov@intel.com>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.17-dev-67df5
X-Developer-Signature: v=1; a=openpgp-sha256; l=3870;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=kmEcO5NRxwXr4zFW34EtZi4fxRX4Nalt7Uza6uDEy30=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqw/H//uSZEzn7sg53iSwBwdsf/lrF0Biko/ba4uU/9f+
 1VetOBuRykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABORWsjI8GW2f/ScAtUnerb3
 HG2KrpeeO3jmxu9wphKdy9+/stX28zL8r7oj4vzsRypPSNlR/3MpUTeeSJ+cs/0Ju+CqN1XROdE
 LeAA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When Earliest TxTime First offload is enabled, the ice_tx_map() function
computes the appropriate timestamps for the timestamp ring used to set the
transmit times for each packet.

It computes this by converting the skb->tstamp into a timespec and then
taking the sub-second portion from tv_nsec and dividing it by the timestamp
resolution. This value is then inserted into the timestamp descriptor using
ice_build_tstamp_desc().

At first glance this may seem reasonable. After all, the Tx timestamp
descriptor field has a mask defined by ICE_TXTIME_STAMP_M which is
GENMASK(31,13). This is a 19-bit wide field. With a unit size of 128
nanoseconds, the maximum representable time is only ~67 milliseconds, far
below the size of the tv_nsec field (just shy of one second).

The E830 device time is represented as a single 64-bit nanosecond value as
seen by ice_ptp_read_src_clk_reg() using a simple rd64 on the GLTSYN_TIME_L
register.

According to the data sheet, the hardware uses the following flow to
determine when to transmit the next packet in the paced queue:

  half_window = window_size / 2
  if (ts <= timer) {
    if (timer - ts < half_window) {
      // timestamp expired
      pass
    } else {
      // wait before sending
      stall
    }
  } else {
    // Handle possible rollover case
    if (ts - timer < half_window) {
      // wait before sending
      stall
    } else {
      // timestamp expired
      pass
    }
  }

Here, window_size is the maximum value that fix in the 19 bit sized
timestamp field, ts is the next packet timestamp waiting in the queue, and
timer is the 19 bits of the GLTSYN_TIME MAC timer. The configured timestamp
"resolution" determines at which bit position to capture from the
GLTSYN_TIME registers. This logic does not perform any computation to
divide out seconds or to handle anything like a timespec. The timestamp and
timer values are compared directly with logic to account for handling
rollover.

Because of the faulty logic, all of the timestamps computed and placed in
the ring will result in the transmit time not matching the desired time per
the skb. Consider a timestamp exactly on a second boundary. The computed
timestamp will be 0, while the actual value should be (1,000,000,000 / 128)
mod 2^19 or 472,468 (0x73594).

Fix this by directly converting the ktime to nanoseconds rather than
converting to a timespec64.

Fixes: ccde82e90946 ("ice: add E830 Earliest TxTime First Offload support")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index d09a67bb6019..8576f186480f 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1519,10 +1519,9 @@ ice_tx_map(struct ice_tx_ring *tx_ring, struct ice_tx_buf *first,
 
 	if (ice_is_txtime_cfg(tx_ring)) {
 		struct ice_tstamp_ring *tstamp_ring;
-		u32 tstamp_count, j;
 		struct ice_ts_desc *ts_desc;
-		struct timespec64 ts;
-		u32 tstamp;
+		u32 tstamp_count, j;
+		u64 tstamp;
 
 		smp_rmb();	/* order flag read before pointer read */
 		tstamp_ring = READ_ONCE(tx_ring->tstamp_ring);
@@ -1532,8 +1531,8 @@ ice_tx_map(struct ice_tx_ring *tx_ring, struct ice_tx_buf *first,
 		tstamp_count = tstamp_ring->count;
 		j = tstamp_ring->next_to_use;
 
-		ts = ktime_to_timespec64(first->skb->tstamp);
-		tstamp = ts.tv_nsec >> ICE_TXTIME_CTX_RESOLUTION_128NS;
+		tstamp = ktime_to_ns(first->skb->tstamp);
+		tstamp >>= ICE_TXTIME_CTX_RESOLUTION_128NS;
 
 		ts_desc = ICE_TS_DESC(tstamp_ring, j);
 		ts_desc->tx_desc_idx_tstamp = ice_build_tstamp_desc(i, tstamp);

-- 
2.56.0.215.g47fdf2208c5b

