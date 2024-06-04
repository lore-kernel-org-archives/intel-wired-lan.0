Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A3BC27C54
	for <intel-wired-lan@archiver.kernel.org>; Tue,  4 Jun 2024 22:13:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85C4C81205;
	Tue,  4 Jun 2024 22:13:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Z3PoeBmLa1i; Tue,  4 Jun 2024 22:13:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BF9BA8117A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1717539229;
	bh=KsuEleWLY4luaxUtrf2wQxM5LXgjuP4ooFXRFRCgv4A=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=zcMGvYFFxsUzn5dVKS+9zCXaRpNh+jaQEtC32E5fTHmrtNAWn1gKMJCFDIeugC0V9
	 ZZqjGkS+zOhHYi6Qn2WAWSPuMckrDoAmOb6u5BiKeHdr0jVx6237chdtjVtVFv0fgY
	 99r1sGrSyo3mCaCBSpIkkrkE62hHvXai7MWuluBUvemoptWsjREJkRuT6K65Gp4/Ou
	 D1rrVuGXc5J7o0/smiI79YXJsB8SzdUPEdAOGzDqgn3G67lxdMYFleU5nqNePQpTmH
	 tcdSaeDMyccBOfeF9vgwuRqHIPLezXCd92bgbuLZJtNeu5E0v6DO2/Swt+UKbMLB5n
	 IB0+DhzJ2LRKw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF9BA8117A;
	Tue,  4 Jun 2024 22:13:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 5AAE31BF409
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Jun 2024 22:13:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6C5F54026E
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Jun 2024 22:13:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iWMjQTlwT5ED for <intel-wired-lan@lists.osuosl.org>;
 Tue,  4 Jun 2024 22:13:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=jesse.brandeburg@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3C0CB402A2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3C0CB402A2
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3C0CB402A2
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Jun 2024 22:13:36 +0000 (UTC)
X-CSE-ConnectionGUID: bcoEoGFoRb+BFHHLtzE8pw==
X-CSE-MsgGUID: 6B/vMr7YSzGJVT/tySKV5w==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="36635264"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; d="scan'208";a="36635264"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2024 15:13:33 -0700
X-CSE-ConnectionGUID: SWJB63lcQD+crIeTePZKCg==
X-CSE-MsgGUID: NbgbaTUIQAWvWMxL/mN2fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; d="scan'208";a="37503242"
Received: from jbrandeb-spr1.jf.intel.com ([10.166.28.233])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2024 15:13:32 -0700
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Date: Tue,  4 Jun 2024 15:13:23 -0700
Message-ID: <20240604221327.299184-4-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240604221327.299184-1-jesse.brandeburg@intel.com>
References: <20240604221327.299184-1-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717539216; x=1749075216;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sPI1vmf9knwUD727FBcKhAG4rMv2hV9/5rA9aOi+/7A=;
 b=gzcm087J5WXrhjciHusyrCzzB+cveJ6yElRqzMfgZFQiUl/G2audrXFU
 6jCYlENEX7Xr11lJhGETSBdNqC1x/+Eb/5JAthiAypXeyHWlFUqK6BrGP
 cHuYOTD/aMggHpSh34FHh1Nnrn3aa45usYBSCT+HZ61Y3/Ugg+43gkOtB
 JtgCQmIQeJUvA6bg9RIfJxJU3/TQm1RSuHkaWipNDGxHMISztncJnR0j3
 kfW0UVuM4YOhz8KIhrsZsYEQ2iyiG1wV4dKuZNKaZx/XtuJZyzw1BgDSS
 2yHyCUgIaPlSMg5xzHOGwiQnNjnsww8SInxkG0HCuKY2WzN7IJJg8PG3K
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=gzcm087J
Subject: [Intel-wired-lan] [PATCH iwl-next v1 3/5] ice: add tracking of good
 transmit timestamps
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Jacob Keller <jacob.e.keller@intel.com>, linux-doc@vger.kernel.org,
 corbet@lwn.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

As a pre-requisite to implementing timestamp statistics, start tracking
successful PTP timestamps. There already existed a trace event, but
add a counter as well so it can be displayed by the next patch.

Good count is a u64 as it is much more likely to be incremented. The
existing error stats are all u32 as before, and are less likely so will
wrap less.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 9 +++++++++
 drivers/net/ethernet/intel/ice/ice_ptp.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 0f17fc1181d2..ff0ba81d0694 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -628,6 +628,9 @@ void ice_ptp_complete_tx_single_tstamp(struct ice_ptp_tx *tx)
 	if (tstamp) {
 		shhwtstamps.hwtstamp = ns_to_ktime(tstamp);
 		ice_trace(tx_tstamp_complete, skb, idx);
+
+		/* Count the number of Tx timestamps that succeeded */
+		pf->ptp.tx_hwtstamp_good++;
 	}
 
 	skb_tstamp_tx(skb, &shhwtstamps);
@@ -686,6 +689,7 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 {
 	struct ice_ptp_port *ptp_port;
 	unsigned long flags;
+	u32 tstamp_good = 0;
 	struct ice_pf *pf;
 	struct ice_hw *hw;
 	u64 tstamp_ready;
@@ -786,11 +790,16 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 		if (tstamp) {
 			shhwtstamps.hwtstamp = ns_to_ktime(tstamp);
 			ice_trace(tx_tstamp_complete, skb, idx);
+
+			/* Count the number of Tx timestamps that succeeded */
+			tstamp_good++;
 		}
 
 		skb_tstamp_tx(skb, &shhwtstamps);
 		dev_kfree_skb_any(skb);
 	}
+
+	pf->ptp.tx_hwtstamp_good += tstamp_good;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 3af20025043a..2b15f2b58789 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -253,6 +253,7 @@ struct ice_ptp {
 	struct ptp_clock *clock;
 	struct hwtstamp_config tstamp_config;
 	u64 reset_time;
+	u64 tx_hwtstamp_good;
 	u32 tx_hwtstamp_skipped;
 	u32 tx_hwtstamp_timeouts;
 	u32 tx_hwtstamp_flushed;
-- 
2.43.0

