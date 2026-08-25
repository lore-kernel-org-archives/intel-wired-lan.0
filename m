Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D212C61DC6
	for <intel-wired-lan@archiver.kernel.org>; Tue, 25 Aug 2026 22:55:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FBD6406FD;
	Tue, 25 Aug 2026 22:55:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7RCRacec2TUl; Tue, 25 Aug 2026 22:55:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787698511;
	bh=BzCKRERUEtPIVm9+OA/8ebkyXqxUxV7Pg0QUsiuxKAc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hAL4wGikNsMFT2j4HDae/RR7KVbngJ/QuRWlu4pJ/WGROSL2p7iwWSA3w3GmXZLj3
	 rg6gveNOq6/HGgwIwvV/idgr8aH/CADX1iePuj19k6Uq/vL8q3wp9TFwBLljq5E2kk
	 okOw1qJYm6iklbpYAtpMrUj/JQZIrc70ofCKKPYKyuGveShHU94fOYGm09SSP7EbzB
	 fMnPKyhY4fm5Rr3mykJe4YtDylVzWClR4xncSAztVfVE0LBt8suErA1o3d1ukNR36K
	 zVtu3qMhAv9SKZp8+jRWSstrG7AT2d2uNblYsJN9ax/jG8y5NPRZqtrWfQmMwq6fBR
	 HcopMPz/JIFEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 594B2406E6;
	Tue, 25 Aug 2026 22:55:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AB4E2334
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 22:55:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A8F6080C25
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 22:55:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id awMPMAe0Zh2r for <intel-wired-lan@lists.osuosl.org>;
 Tue, 25 Aug 2026 22:55:06 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Xdjq5fWR
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B949480C0C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 22:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787698507; x=1819234507;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=IWVM4EjWcI7Wh7RPq3uvEJvVsi4+ccGsgc+lRY4c+mE=;
 b=Xdjq5fWRLVftseYDajUlAcSs3a/bTn3Se6uI/u+iMQHqIFfK6BZd0laN
 PKmiOygLMfkZOIXa3Gil3j7JuVVeyNfDMD5yzgw3KUKbiNA/3Dhxi+DS/
 viT5bcGF/eZKL9om7mRWHbZLGA4BMA0DHNZLb2EnPGnPLdJ+XuY/8OSUi
 1/49+MT2V8rk6igJNwO0xnemOaVJhZy9Md3PseRqHaObnpSftkFivelRs
 ujaO2dp6KVjz2lNWQtRAXkzTztlcSx3PCeaLLNoc/9PrdK/L6WZXpWAR7
 /VakOdyWEaS2yIMJTXqIZ5IyumYF+L4XbgEmIxoAaR6fBe9V3Enmw2/JB A==;
X-CSE-ConnectionGUID: f5aHlXSMS7yVPhGhxTjdTQ==
X-CSE-MsgGUID: Vgn9I4QGTNuhLNtPIckubg==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="87120421"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; d="scan'208";a="87120421"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 15:55:05 -0700
X-CSE-ConnectionGUID: C/leY4PGSWSuE94QXB3Yuw==
X-CSE-MsgGUID: CTWqHrIAQqm1gdJqnDipMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; d="scan'208";a="264789668"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 15:55:05 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 25 Aug 2026 15:53:27 -0700
Subject: [PATCH iwl-net v2 03/14] ice: set in_use only after preparing Tx
 timestamp index
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-jk-e825c-minimized-fixes-v2-3-8223f95d26e3@intel.com>
References: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
In-Reply-To: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: netdev@vger.kernel.org, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
 alexander.nowlin@intel.com, kevin.bross@intel.com, ranjit.cavatur@intel.com, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.17-dev-c276d
X-Developer-Signature: v=1; a=openpgp-sha256; l=2281;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=IWVM4EjWcI7Wh7RPq3uvEJvVsi4+ccGsgc+lRY4c+mE=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqw+Wev/IpWvitSNjI/MaFexfqSZVPL+2/bJhbvS3J/f5
 WFZ0CDbUcrCIMbFICumyKLgELLyuvGEMK03znIwc1iZQIYwcHEKwEQc3zAy/OY8UzDlTFniex59
 vjmPp775s/jjBqEM/r4JG6O3JHtwNTH8r53jw5TT1OR4zzovbGl8T5VEwu7pqny3I28HGx71TrB
 kAwA=
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

The ice_ptp_request_ts() function is used to request a timestamp index for
use with a packet. When reserving an index, it sets the start time and
saves a pointer to the skb into the appropriate index. The function marks
the in_use bit first before doing any of these steps. The IRQ handler which
clears the timestamps reads the in_use bits uses a lockless flow for
reading the in_use bits to determine which ones are in-use. This is
necessary as actually processing a complete timestamp must be able to sleep
so we cannot hold the timestamp tracker lock over the entire sequence.
Additionally, blocking the Tx hotpath with such a lock indefinitely would
be problematic.

However, the existing flow now has a very narrow window where the IRQ
handler could see a timestamp as in-use but read a stale value for its
"start" time.

Fix this by ordering the sequence to mark the in_use bit last, and add a
memory barrier to prevent re-ordering of the previous writes to setup the
index.

This was found and reported by Sashiko while reviewing an unrelated change.

Closes: https://sashiko.dev/#/patchset/20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858%40intel.com?part=7
Fixes: ea9b847cda64 ("ice: enable transmit timestamps for E810 devices")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 142d39ee5cc5..68537705e839 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2672,11 +2672,13 @@ s8 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct sk_buff *skb)
 		 * a reference to the skb and the start time to allow discarding old
 		 * requests.
 		 */
-		set_bit(idx, tx->in_use);
-		clear_bit(idx, tx->stale);
 		tx->tstamps[idx].start = jiffies;
 		tx->tstamps[idx].skb = skb_get(skb);
 		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+		clear_bit(idx, tx->stale);
+		/* Ensure index is setup before marking it as used */
+		smp_mb__before_atomic();
+		set_bit(idx, tx->in_use);
 		ice_trace(tx_tstamp_request, skb, idx);
 	}
 

-- 
2.55.0.814.gc42f45431d0f

