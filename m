Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160FDC9832A
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 23:58:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A0A9B60670;
	Fri, 25 Sep 2026 23:58:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jorz6D8djVnw; Fri, 25 Sep 2026 23:58:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D13DE60720
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790380688;
	b=bs82qFMJAwrzp/Zbm7D20gTyZXBVt2mKlfwbnS4qI5czafX8wC+wEJ5ZYAylXZDmSEWD
	 QYmLXaMxGXNAYSXwO2edbXrjQtW6k1/0gLmNIDMcjnRtoOEl/zD83Rg4R+3/d5GJbSE0/
	 h9jNIqxYFv6spS5zec90qa/f87ymG1k9E7JG7mZ4My2F56n7SyJ04fx2bX7a0zepC7aGj
	 BQNapU50AHJmJ6CrR4+CR9xsDRbQz6imHoBWqzfIK3adQ22RtnL+6O/pLWOeB1mjLWGL8
	 xUPapGxAaCeZ2T7YnqJrgikQWSpuz9LlLm7X3c2x46lisT1W5/Lr4SDnlHAQ92OdZ4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790380688;
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
	bh=3ib7ZO4ZntxdCIfUU6VEG/pjHOHLIJnEyhvdtIyRUiU=;
	b=Zh2Bu5z10XR7rb2YjjlRdfN9q9OmAujqis6fruWdxNdYgaqW7IUqnkOQ3jUXHshbD4Pv
	 2CaNnQEfOegaJkSFRXwp1HujnI9DV1xZHXMRtTNCxbtTDS+6H/bYyTIjspm1X2872OKUL
	 1ZfXn153jj9kT8/PNqDydQASo3mSYwlJJfGWGaRSrRZmij1MuFWZjaPwmkRo1BUtzRIyJ
	 8k597shGHV5tiCrtZclASt1RMBkZ6dDZG+eR+oqqt1mX/bwZiS8PSJUeQaEWMS3E0TY2a
	 wPp4s2JPx2FwX2dgWAxspsriKXE+CxE2jHWMfoG0E17GXJVQ+RqKxCWyzxFHxTHIE/w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790380688;
	bh=3ib7ZO4ZntxdCIfUU6VEG/pjHOHLIJnEyhvdtIyRUiU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZperKxgFuUUGC6uA3G9gLwyhHTTaTnHBOnulmYq7q6xGKt7NYOKJcEvM1iPIkgpsU
	 4oR0F2+7zTPjZlQvHOzlEawPCIolkuvB5EK4enN6TIbjdsXtVEtjTXnlxm7q5Mfgsu
	 qJckNignNr5MnPhoqozlQTRtaupQyT/NIle8NDQyLMRZvKnqMGRdFYBT44ODNl5Ad/
	 bTlLFuhNuoL53urC2QTsvKfMkeViyEb7KLWTMOoxeumMX+Ns72xyI0Vf63/eyPfXxJ
	 VZnyZKDFeHw1Yo4M5SE8uU+cnqhMaXj6eCLeU7avIrdGzJgh1ECEPbHr5grG/NGENL
	 T2oW5/5AE0Sxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D13DE60720;
	Fri, 25 Sep 2026 23:58:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 67701355
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 596A940B68
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L74fjJJjhPQV for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 23:58:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5BE0D40B6D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790380685;
 b=flUYh20g7KNmmdsOy/F7DcDnYkfuMrfmZ5FlkabTqd+SjEGRUmm2D8XcT3L0pnJ4V4F+
 VIbnGq/4fXUr0B9CFYC4LM8aV0U7M2AeS8qOCyypg1fNzj4c0pILqpOmacD2s3+tSKQae
 cBeaFIXbm/AOBmoTYaUwK+L2jYupmVAQjxFvyF4eTTg3cXfJoXkkXO26CaTK4sQTpLb3a
 cHLviiIFz/kJqut1k611fRanhAtTfQsieaucJUPBEKpEiWujaoamgBYr2sKf3JCDjqMQp
 AYIQkSY4MlM1p8dQEyGt0r0FwetbT2y3q2R1pOCmncg0cjWhDRqmmhZ6A3LmMImftsA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790380685;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=3ib7ZO4ZntxdCIfUU6VEG/pjHOHLIJnEyhvdtIyRUiU=;
 b=BBWqMSOoc9xb+/P+XPNo+CskAbZYTagmB6kDteT9GZlCUnwGmr33bTUk7FDmtLyjOjY0
 SJpFoVqeL3ab7Py77rssZobBdCw4rgUoVrMOdshNTcMueujitIGgE3ebuC6DH/SikkcgO
 gSoAy0SlmRdO9wDfdp/Sj2Cg5Rsjcc+LztGHumZGbfxQ1EnGvvVDqI2omdrhzEUCVJyz4
 QJIymPjShRKgNt97oCXPieQ/gZjvb1VHbyJzPVDYjHUmVZhLKQx25ZfjcfBn8hQKbubf3
 7X40+CXCzfbIcIqOb8RnBWs9CPvqtsVAPr7LYzGLlHG24mfJjYfZtXMtBoWnsrIDlhg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=H+2rZNi+; 
 arc=none smtp.remote-ip=198.175.65.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=H+2rZNi+
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5BE0D40B6D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790380685; x=1821916685;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=W2Nn+VpnAqljYuyR2ypGeppUYjsE9WhxMEDe+6fDvUM=;
 b=H+2rZNi+5Mt/z4Jg2QxOJXcTw41JgCxMi6DYOEz3y5iH9wM78h1zc9ZM
 MNh2ZE1bVh9EM3oEP5XZRSIL1S6WW49i2uUABN72WJbhqGrQWWg4A8RHg
 edNa+b2ExyhC57NkZJwGCRdN9iQ6nzXacDJDHrowpPbpzRJNQVY+u3tBa
 YYgvK/BvJ0RHHJDjwFtZ09V2y+sK+42soPLDfbujLseHZwPQNLsgUXx2v
 OkcySIeGa2USRLhuh1HqUOgvPCH3aRvlAAjd/87t8BxVZ88o3jTcMFPzM
 RSlJ2bk9OjysiWwPA9qUG36nww2sFcV8r6NHJD4cRI+Psu4muuvzvpcwx w==;
X-CSE-ConnectionGUID: uaRE8YYGQDeJZ6QDcVMa7g==
X-CSE-MsgGUID: Fz/iosA6SE6CCmTG050/NQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="90212806"
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="90212806"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 16:58:02 -0700
X-CSE-ConnectionGUID: 7XSjY1NGT0u+9P1cXRNa/A==
X-CSE-MsgGUID: 7n0GO3sCSl2cqER0DVbLXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="300731111"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 16:58:02 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 25 Sep 2026 16:56:36 -0700
Subject: [PATCH iwl-net v3 04/15] ice: set in_use only after preparing Tx
 timestamp index
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-4-6532598e8da8@intel.com>
References: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
In-Reply-To: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=2657;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=W2Nn+VpnAqljYuyR2ypGeppUYjsE9WhxMEDe+6fDvUM=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqztXBVXhHMEfCzbN3lHMOUoVFTffOayteXt03y9f+qbF
 YX3cx3qKGFhEONikBVTZFFwCFl53XhCmNYbZzmYOaxMIEMYuDgFYCK/BRgZ9tq4BKS/sf7Hd0Fo
 8vul68oDmFJlC35/l8zk2LBZWZZHgeG7/3FR54zbih/e34zdJf2HSbSsY6HX9nOcX6J843+UyLA
 CAA==
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
 drivers/net/ethernet/intel/ice/ice_ptp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index adc5308baefc..bbb57edcec0f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -592,6 +592,9 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 		bool drop_ts = !link_up;
 		struct sk_buff *skb;
 
+		/* Prevent speculative re-ordering of start and skb */
+		smp_rmb();
+
 		/* Drop packets which have waited for more than 2 seconds */
 		if (time_is_before_jiffies(tx->tstamps[idx].start + 2 * HZ)) {
 			drop_ts = true;
@@ -2670,11 +2673,13 @@ s8 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct sk_buff *skb)
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
2.56.0.rc0.395.gd1f3524e15dc

