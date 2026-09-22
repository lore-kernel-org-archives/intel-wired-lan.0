Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13594C98308
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 18:08:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C92D04075C;
	Tue, 22 Sep 2026 18:08:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8m54G_PKeUht; Tue, 22 Sep 2026 18:08:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F346A40760
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790100512;
	b=eUwAe+QApPMCswvbBODIXQjZCugDRjUwpgKkBC4S1z6cCxrHwloldRWvgdbIxBwN2b1u
	 OYE7KWqp1SxgqjMk3JgAESdw0JZOM2OcyX+VQkyRulKqmByPrq/mP8Q5pYP4g7nZCmYEY
	 6As9HI7NDsM/Vbjyh3uXL7qXiifejfRQZRLAKYuBf7zgYwq6utSfn759+i7Ijs5OoDrEm
	 LHefyjmfiI4hbDyZMYRGhEgdSf8muUPq5EDGnNp3TJGH3J9OAogOzNDw40pBuXwh2jJgc
	 EuogXgeQMKxMEARGySTuVvY645053MTDatTq1QfESV7nYRHqSr82srz0Gsdgqmg04JA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790100512;
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
	bh=MNwjoyv1VfORZ/eOjMMMbN6b2MhVzE1WZkt5zIaFPck=;
	b=XWsEc+YChjpsMK7EFy14MEYcKhvow2PLbNLBh+/Xxpym9L3pwaFeO5JEDyVRdvaG4pUs
	 zTiTzrCVJ5RPTisU96vVumzl2ZCzFkjaeVg97Nzu6PmF+Y16Rq+qyF1ALl3QNsUhVvCdT
	 5/dTNsdKXSdfoztaH1dwBC3IJGdc7odGMziaX/62oUXFRavkhhaUT7usaHZuLkUv2O7Yt
	 3nmRAHslTMHgawplMVUIgXJ7aJksNLSjqRhd68K8s6G+fjMrM39vDoImuhGmT3BzKZmIW
	 vajW6E6nTLEs2D+DkQU+IIS1JAcX6eLvzvBs+bpc7PDeiDUM6aLPfWq2L8KTpAS6Lqw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UPL9ZizX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790100512;
	bh=MNwjoyv1VfORZ/eOjMMMbN6b2MhVzE1WZkt5zIaFPck=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KawuH6bN2JugJei0cG0gzp5eHsUVJOgaU/YQoy9yLUAI06d94dG51KSVHQvQ8MwDV
	 Jv4v1LXyFgUQ8OJsfmHYDVsIAuOpyOQPm2JIeaC+eQqacc4uCsJ0QAGLinNG+Qk3e2
	 pD4blJO7dA5XBbcTtB8rJ6vB/jLTW6moV6VLC443A7T11z/0A55kFz+n7WZ7SsnS0U
	 T1F9WanRNu4s6hLxer0DLDrmKrAZAYGQUiEVRqOjNskmweDIoRNnX2/tou+CHD6BEz
	 +o+ziyrbJwuP4VyX5YBw9EiJHM/T/S33022YqcQfm8SDR3igEUT2JHq5+U2hYfIcd6
	 /j4SwMp8tdGyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F346A40760;
	Tue, 22 Sep 2026 18:08:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 01F2C12C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DCBC240738
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZtqfT3bhHLS2 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 18:08:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DAEE34075C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790100507;
 b=QDqij8V+hAg/vPwIEgTGpCwnWx3Z/LqoUa7++mgnizO5a0zayrfso4PXQVB4HP+EETyv
 Z/9QxDNGH1UvgdysTwSyqeiYmbocE+qc4SjfvqpRuvbRwaoG7jyLt/u1ZVF9I+x1y2qAd
 JT98HYIJ5Yfl4I5wDn2IC/ZABHWSkiXCB0FLMHRth7QqhthsLDav4zJZNc3PzDuHJFpLk
 LgkGII8EBpWMpwGZ6Jqen2keebkeOstYWsEhllcnGno/dAcXsg/ptZsQwd9SpDoJvhPPf
 848pwUI8SvoKfcy+ikGtSquNnacpIV4e7tK7ljCi2FAMks1XZqbL3Eg0KewKVXZQVhQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790100507;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=MNwjoyv1VfORZ/eOjMMMbN6b2MhVzE1WZkt5zIaFPck=;
 b=GLWc1pES3M/IlDa3n/fb4Zg3a6fgXtm4s1lAZBEEz3Rd8a8jc7iaLqfrIpUk83OT4O1K
 HmqRwX+Oh1MGCBtkU5QmRTTzRue7pSb/Vwp/WXKXDEv+9tEIt+EsKvrn0pUTt69z0ehO/
 LnUHgkwC/uqbvmDv1B/IqMi5RrN5y/7fUzINK8NwWCzJ4r1D+iySjosN/cn3pqvMZ5XlY
 x0zW+DEoNqSfOSzSgFx47RdwT5F3QdEKrnAR1wtQb3y0OFTES+XoRpSxFdH84QD1R01aI
 EN1KXw8cuDopMKSdQjpMu0YlJC/GsmTmzlcCc7OlWWCSWcNdYXN3x1zMdqE0sXnUvKQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=UPL9ZizX; 
 arc=none smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=UPL9ZizX
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DAEE34075C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790100507; x=1821636507;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=w7tzbPfgL4SemDDc1M67jm5pchylDvuJvcpfrnE0kjw=;
 b=UPL9ZizXLRnQ6oxY78D8D0zNqutN4RLaovMdJd0W7UKfb3+50xYYEEt/
 JMx1xI4v+wZZ6NN6WrQdTFyUIhM2Dq/DwWPiSfGcu9Rk4mOi3TDvawDql
 bJJ647YTdc2zaRWH6Dd2daUaPpavVtvuBJuewQpP1Lnmy+8Xy58yOJDj+
 aXSs8gc5s7O4uWJjWDIkBC4f0lHMwYl50ii03SlfvSK4J6ck1TE+l8l+/
 O2WLML2ZtaQrmU4kYJ0KjASbnnhx/CHOjBB23tbEJevpTMg/XqAQmaQpi
 LsbXORwKg7kyuaGLR6Y++d3XcFFiW3/X1d+R1Xhptxq92ij4k/u7JApNB Q==;
X-CSE-ConnectionGUID: Cn7LRPBCRkytwJc0cwzBjQ==
X-CSE-MsgGUID: bIv+Eey4SgqS6wK6s6C7cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="108232031"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="108232031"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 11:04:23 -0700
X-CSE-ConnectionGUID: jyViF5rMRUemJ/6iBiwWLg==
X-CSE-MsgGUID: /HZ257ieR9iLblBOLGax8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="281315307"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 11:04:23 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 22 Sep 2026 11:02:37 -0700
Subject: [PATCH iwl-net v2 04/15] ice: set in_use only after preparing Tx
 timestamp index
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-4-e55b692d0e6b@intel.com>
References: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
In-Reply-To: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, netdev@vger.kernel.org, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=2657;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=w7tzbPfgL4SemDDc1M67jm5pchylDvuJvcpfrnE0kjw=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqxNh6UiNuhsWha8+kBt2/qFOw7/bLj5fOX+PR1b+fjfv
 Pkttbi6u6OEhUGMi0FWTJFFwSFk5XXjCWFab5zlYOawMoEMYeDiFICJiMgxMuzjTL+z7dGuh73v
 PYSj+I79nWtRa/u4cK6Ay2zurhbdSysZvjvm1Lc+OlflsFHNzLnc6M4vtjn8C06uMhG5eOXZhum
 rmQE=
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
index 2bb9beb94806..1bcc78d08d2f 100644
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
@@ -2677,11 +2680,13 @@ s8 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct sk_buff *skb)
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

