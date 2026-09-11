Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3072DC88E4A
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Sep 2026 11:39:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F29EF80F8B;
	Fri, 11 Sep 2026 11:39:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id En6qsQXp4JEg; Fri, 11 Sep 2026 11:39:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 10AA080EE3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789126753;
	b=ShTLNXcFIO1S6Kcljp1V60YRgFw6LgnQcbJWLQ3bq+/FWVsEa5ZK3nE5YeF0JFAJjAHh
	 VOSqUfDD+TLwHpRaOXBdFxt1kxljw9JvqZ3sJaclIQ2Y4RS9I3wY97vzmc4uxRvWy8rf4
	 RJXx6QL1uGWs4pkfBeyCCuVOhmwFCRse0r7bKCJdMypvgDvIltxIg93scQ9OVxAtdSRQD
	 WfkCMTI9SAMooGRDT38409jQ0XSwXzh7OWV/hFof1kFrjx0Owy8h1byEdscXmyQGjjhb+
	 FKbr8KLJbll7ZYb+y1N16nsxRfw+vh407BIL26zXdOV1a1MALBX3LUE/3N7aztyE5Xw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789126753;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Azk8u92AfRE0iieifZX29Gfp02+Y8XjAVGY+qN6czBE=;
	b=by5PfwZXC2BpBgLp24synJ3dDX3KvdFsC+UaNVfPHmUfIV4a/29q2kpVrSOZhsWjAXof
	 qGSsEgjiqRRTmWEmsnNKmrFvO4C6XNT8/ibu6Vi88MP6xn0Ybhz6fW8l1gCWuri7jt803
	 chBuix3WEVfqU529OZdv5ppgXanc8h7G7X79v4rKBGXkVbGM9ncYb7XPGLfwrCrNDnrpD
	 6Ga1FLcko9bl3HlZsDfUJMvyGetOh0ZQo7mECbCk+GXlOpTR2h0b8jeh3jjDYAqUD9cfi
	 XmygqX4sofTMjzo5DoGxZQGyONa3N9vldkP96+t0h4O05mVQBWtkfknIEFddyt4ALaw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CaaoLaiz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789126753;
	bh=Azk8u92AfRE0iieifZX29Gfp02+Y8XjAVGY+qN6czBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JM5EEx62zIatTpY+akEKpDAbPb2LJgklCAUKoh0uRuZnvOZg/67P/1njRTIwSg0+T
	 7H46KjNljxS4LvEtYNMsfk4ypCUdElGCn2bSVNg6nrBEa1DTz9B55LPB7ZHnjjMCei
	 kQmqCyB94cWjAtrSZhj3oIxoDT47ARu4mz6ZJkHr8LOeAecBRWCYePJyThKw9VMYQ3
	 ZeXGHFKULarspSdxoI9R/cFFBXT6WqY+BaLUUpWDHjGx9GwuOGh547ri38JnakjDsu
	 ibblGjLsm8ZsiqFjBJfL6gOoltZf9GgQ+PG6c1YEMT6zNH1bOISttkbl3zUsVFzwWG
	 USWjOx9yFtJ4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 10AA080EE3;
	Fri, 11 Sep 2026 11:39:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A53F2E3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 11:39:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 80D0180E97
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 11:39:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fOlnuQbxe6TW for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Sep 2026 11:39:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A04B380E95
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789126749;
 b=F87KMh+DS0ttbWlXNwXiIlrz0gwYXKPmAShzCLgQrAM1i/CKLgIkg2GfY9EUJ0SdKq5M
 roJbnJOzpjXet6GYxvWujHDEYug2TZ7tHRYnO7dC3kZ9CJ6uHVcA0ggMr/30WO/HGXPOT
 eHd/CEBqaxZlDIMYnWt7gFK3s740+MtsI4k6JlikBnwedf7EQaLIXDbEOjL5WOR9n9d3p
 sb6g6AIsAZHcobpNcD5C15xD9s+FS8BgDNvTny2ZX0hRGmhIo7iZiJP6nemtsyAfMReCO
 XbzBTwmcuP3u/hU4GYpIm6sjArjX4rn5W/rBawfoX1KAu7O7e2rA3mfFJb7OmSoTTuw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789126749;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Azk8u92AfRE0iieifZX29Gfp02+Y8XjAVGY+qN6czBE=;
 b=WO9JXG1cDWQSvQrPitJ5owVRlQGKi8VszUMfSceO41wRBL+ENoqjmNM1hHaQkunQUVn+
 Mkk0BYoY55MyhxcfX1hB/qRTaKAaVfh6gWJhgRzrBAqw31oabZ6vfBWAlq4roBbVU4fu3
 zGlc1lz3F2Nt9GXhJ4IY5ug68oLiqd7cerP2oLUVszt3VZu7GcgG3OZ2C7H2fvxaZDyk/
 9zAI7kUcVrYDGLtqdXUyWLmvE3IcTTEWUr4QvA41mALC23WCSqaPFg7m6VjJofgFDHTkR
 dpVTNW2Zpkwy3vWmsAOZh/Xa+MTpeGUGEK5Kfy/yA32BbCSw0HJbA3gkym1GJX9tjUA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CaaoLaiz; 
 arc=none smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CaaoLaiz
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A04B380E95
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 11:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789126749; x=1820662749;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JTi74+5ytxAlM7eF7gR+vF9lG/giPNoL2rgqGMy0XEo=;
 b=CaaoLaiztcrhSq2JTBnv7FG4oy8J9kmibBZo9REBLm9BjWFk7JdizYX0
 MTURKXHpaA5WTv2et83ZAKHxRwmJ8iJCZrtz5VrtE1pLrJ5PLMYmeujkD
 YcAE1SZtNTcrPF6mWjf0soPYk2d3Din8zROz3Gk6nsqpnDqEnVdRlxCot
 6O+NeZ5wzbwwTh4VFyTwpeYZDlwNuNmKrW47KMqdx4saILWnwzpqCeAKd
 OV/NLY9mRe8cwcFnhC/jrI+mPhWpCz661iH0FWXfyPZcCAtG41H5sgPUt
 9Xy1mQb/H5Ovn5TEb4SPrL3y4o1Vych+Vfe/F2PuuKzT2hh5hSQJv+58v w==;
X-CSE-ConnectionGUID: p5RK569zQS+vdhWAYwGqbg==
X-CSE-MsgGUID: WG0y5J01ScusCucDekS0WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="112359917"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="112359917"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 04:39:09 -0700
X-CSE-ConnectionGUID: YPzREYnhQUO6lhZMRxk8Zg==
X-CSE-MsgGUID: 955cymw8TfqdgKwOWtKumw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="270135867"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orviesa006.jf.intel.com with ESMTP; 11 Sep 2026 04:39:05 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.244.110])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 9AD202877E;
 Fri, 11 Sep 2026 12:39:03 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Michal Schmidt <mschmidt@redhat.com>, intel-wired-lan@lists.osuosl.org,
 edumazet@google.com, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net v3 4/5] ice: rebuild ring stats arrays instead of
 reallocating them in place
Date: Fri, 11 Sep 2026 13:26:19 +0200
Message-ID: <20260911113848.44086-5-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260911113848.44086-1-przemyslaw.kitszel@intel.com>
References: <20260911113848.44086-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

ice_vsi_realloc_stat_arrays() resized the ring stats arrays in place
with krealloc_array(), sizing them from vsi->req_txq/req_rxq. That is
not what ice_vsi_set_num_qs() computes later in ice_vsi_cfg_def(), so
after a rebuild the arrays could end up shorter than vsi->alloc_txq /
vsi->alloc_rxq, and ice_vsi_alloc_ring_stats() then walked past their
end. Requesting fewer queues than the PF pool can hand out was enough
to trigger it.

Replace it with ice_vsi_resize_stat_arrays(), which allocates a fresh
struct ice_vsi_stats instead, sized with ice_vsi_get_num_qs() and the
queues ice_vsi_decfg() is about to return to the PF pool, which is
exactly what ice_vsi_set_num_qs() will compute once they are back
there. Copy the surviving entry pointers over and install the new
structure, all before ice_vsi_decfg() runs. The entries that did not
fit are freed together with the old container, via
__ice_vsi_free_stats() with @free_entries set to false.

Doing the allocation up front also means the failure path is a plain
unlock and return, with the VSI still fully configured, rather than a
half-torn-down VSI to unwind.

While at it, skip the stats handling for ICE_VSI_CHNL, which has no
entry in pf->vsi_stats[] to begin with.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
this is an actual fix/improvement, that removes some of the tech debt,
but there is no Fixes tag, as this was not directly caused by an user
observable bug, rather as a pre-work / ai-review resolution for the next
commit
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 118 +++++++++++++----------
 1 file changed, 69 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 998b9eb6e9fe..0cd54af40c37 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2953,6 +2953,51 @@ ice_vsi_rebuild_get_coalesce(struct ice_vsi *vsi,
 	return vsi->num_q_vectors;
 }
 
+static void ice_vsi_free_unused_stat_arrays(struct ice_vsi_stats *vsi_stat,
+					    struct ice_vsi_stats *new_vsi_stat)
+{
+	int new_txq = new_vsi_stat->tx_ring_stats_len;
+	int new_rxq = new_vsi_stat->rx_ring_stats_len;
+	int prev_txq = vsi_stat->tx_ring_stats_len;
+	int prev_rxq = vsi_stat->rx_ring_stats_len;
+
+	for (int i = new_txq; i < prev_txq; i++) {
+		if (vsi_stat->tx_ring_stats[i]) {
+			kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
+			WRITE_ONCE(vsi_stat->tx_ring_stats[i], NULL);
+		}
+	}
+	for (int i = new_rxq; i < prev_rxq; i++) {
+		if (vsi_stat->rx_ring_stats[i]) {
+			kfree_rcu(vsi_stat->rx_ring_stats[i], rcu);
+			WRITE_ONCE(vsi_stat->rx_ring_stats[i], NULL);
+		}
+	}
+}
+
+static void ice_vsi_set_stat_arrays(struct ice_vsi *vsi,
+				    struct ice_vsi_stats *new_vsi_stat)
+{
+	u16 new_txq, new_rxq, prev_txq, prev_rxq;
+	struct ice_vsi_stats *vsi_stat;
+	struct ice_pf *pf = vsi->back;
+
+	new_txq = new_vsi_stat->tx_ring_stats_len;
+	new_rxq = new_vsi_stat->rx_ring_stats_len;
+	vsi_stat = pf->vsi_stats[vsi->idx];
+	pf->vsi_stats[vsi->idx] = new_vsi_stat;
+	if (!vsi_stat)
+		return; /* don't copy if there is no source */
+
+	prev_txq = vsi_stat->tx_ring_stats_len;
+	prev_rxq = vsi_stat->rx_ring_stats_len;
+
+	memcpy(new_vsi_stat->tx_ring_stats, vsi_stat->tx_ring_stats,
+	       sizeof(*vsi_stat->tx_ring_stats) * min(prev_txq, new_txq));
+	memcpy(new_vsi_stat->rx_ring_stats, vsi_stat->rx_ring_stats,
+	       sizeof(*vsi_stat->rx_ring_stats) * min(prev_rxq, new_rxq));
+}
+
 /**
  * ice_vsi_rebuild_set_coalesce - set coalesce from earlier saved arrays
  * @vsi: VSI connected with q_vectors
@@ -3039,63 +3084,38 @@ ice_vsi_rebuild_set_coalesce(struct ice_vsi *vsi,
 }
 
 /**
- * ice_vsi_realloc_stat_arrays - Frees unused stat structures or alloc new ones
- * @vsi: VSI pointer
+ * ice_vsi_resize_stat_arrays - resize ring stats arrays for new queue count
+ * @vsi: VSI to swap the ring stats arrays of
+ *
+ * Call while @vsi still owns its queues and before ice_vsi_decfg() returns them
+ * to the PF pool, so that the new size is what ice_vsi_set_num_qs() will compute
+ * afterwards. Surviving entries are carried over, the rest is freed.
+ *
+ * Returns 0 on success and negative value on failure
  */
-static int
-ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
+static int ice_vsi_resize_stat_arrays(struct ice_vsi *vsi)
 {
-	u16 req_txq = vsi->req_txq ? vsi->req_txq : vsi->alloc_txq;
-	u16 req_rxq = vsi->req_rxq ? vsi->req_rxq : vsi->alloc_rxq;
-	struct ice_ring_stats **tx_ring_stats;
-	struct ice_ring_stats **rx_ring_stats;
-	struct ice_vsi_stats *vsi_stat;
+	struct ice_vsi_alloc_queues_params qs;
+	struct ice_vsi_stats *old_stat;
+	struct ice_vsi_stats *new_stat;
 	struct ice_pf *pf = vsi->back;
-	u16 prev_txq = vsi->alloc_txq;
-	u16 prev_rxq = vsi->alloc_rxq;
-	int i;
 
-	vsi_stat = pf->vsi_stats[vsi->idx];
+	if (vsi->type == ICE_VSI_CHNL)
+		return 0;
 
-	if (req_txq < prev_txq) {
-		for (i = req_txq; i < prev_txq; i++) {
-			if (vsi_stat->tx_ring_stats[i]) {
-				kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
-				WRITE_ONCE(vsi_stat->tx_ring_stats[i], NULL);
-			}
-		}
-	}
+	qs = ice_vsi_get_num_qs(vsi, vsi->alloc_txq + vsi->num_xdp_txq,
+				vsi->alloc_rxq);
 
-	tx_ring_stats = vsi_stat->tx_ring_stats;
-	vsi_stat->tx_ring_stats =
-		krealloc_array(vsi_stat->tx_ring_stats, req_txq,
-			       sizeof(*vsi_stat->tx_ring_stats),
-			       GFP_KERNEL | __GFP_ZERO);
-	if (!vsi_stat->tx_ring_stats) {
-		vsi_stat->tx_ring_stats = tx_ring_stats;
+	new_stat = ice_vsi_new_stat_arrays(qs.alloc_txq, qs.alloc_rxq);
+	if (!new_stat)
 		return -ENOMEM;
-	}
-	vsi_stat->tx_ring_stats_len = req_txq;
 
-	if (req_rxq < prev_rxq) {
-		for (i = req_rxq; i < prev_rxq; i++) {
-			if (vsi_stat->rx_ring_stats[i]) {
-				kfree_rcu(vsi_stat->rx_ring_stats[i], rcu);
-				WRITE_ONCE(vsi_stat->rx_ring_stats[i], NULL);
-			}
-		}
-	}
-
-	rx_ring_stats = vsi_stat->rx_ring_stats;
-	vsi_stat->rx_ring_stats =
-		krealloc_array(vsi_stat->rx_ring_stats, req_rxq,
-			       sizeof(*vsi_stat->rx_ring_stats),
-			       GFP_KERNEL | __GFP_ZERO);
-	if (!vsi_stat->rx_ring_stats) {
-		vsi_stat->rx_ring_stats = rx_ring_stats;
-		return -ENOMEM;
+	old_stat = pf->vsi_stats[vsi->idx];
+	ice_vsi_set_stat_arrays(vsi, new_stat);
+	if (old_stat) {
+		ice_vsi_free_unused_stat_arrays(old_stat, new_stat);
+		__ice_vsi_free_stats(old_stat, false);
 	}
-	vsi_stat->rx_ring_stats_len = req_rxq;
 
 	return 0;
 }
@@ -3127,7 +3147,7 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
 
 	mutex_lock(&vsi->xdp_state_lock);
 
-	ret = ice_vsi_realloc_stat_arrays(vsi);
+	ret = ice_vsi_resize_stat_arrays(vsi);
 	if (ret)
 		goto unlock;
 
-- 
2.51.1

