Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A31C9832F
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 23:58:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3052B40B46;
	Fri, 25 Sep 2026 23:58:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MctL6VhgYwhc; Fri, 25 Sep 2026 23:58:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4BADC40BF2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790380697;
	b=KokAVkBRJVAj32/rh7BBfWTqTV+HiSXFirb5JI/tHr6hOXK9TX2cc7FcXPmR4tmZdWdy
	 Lolt7jCLGZLOqAYvTtsJFYP9D7R/p7/V2vVQPFvxogcid+cLo0PU9GiPq4kUHt4jw69GH
	 EWJv5HRpKVnyHR39RVnKpE1CpZ5KPQ2X4eRFPJrLHK+7MfMMGGoj20l0+4+0z3r8WBbvE
	 7BNOzjPIApZtt9CzLwUR9OFuwnN7YCspjwUEuVl6+O4QrQArZmMSD6vcmF5LpH7wqAe0O
	 N74zBYtsf8kM6eHYbeyiHtMqSX79+2e0pJ0yPHQ4nOdgCSX1Pz1Q9UgimjKkq5V/Z8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790380697;
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
	bh=oZ4DonPxN5mcGwVP+DLk6RxuPRCTUYaW2K0pyvd3Gs4=;
	b=H5tMqurtItU2kJOw+jXsJQQpeQNtmMD9YE4nf1p9wMKFGb9s/49fxGZqXWorPIZyV3KA
	 Qm0kZ8L50BTKpjcfnaVSI9v0AByD8af/xykRv6w/oztbA/CM/jlQ1wKEH2q0qvmjPCU9G
	 Nn35GvfX22nz30aBb1SmnIM6q5dMLcoN+H5L13Mw4ZUYMmScsLaa/E+MpAaMi41ELBciC
	 8mAeci/41nAy9JlyLE9QFJG6HtfvwwQ0ro+u0fgPDk8vTeYR4p7r0twUVjA6xFL1yMpRj
	 0XydsXFXu9GITl9ZuQU4y82zLj7v/6HFbUIP38B2FBM4WkOaMcc3bafKlsAtVbbxHyg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790380697;
	bh=oZ4DonPxN5mcGwVP+DLk6RxuPRCTUYaW2K0pyvd3Gs4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sQSd0ElwsoS9e0r9oB9kMu9gWWb/aryBW75uIEmH5sF+gBYghOF5vzDDiDb0XVVUH
	 KGXAZG+h8TcoD+KEXN4bCOWqopxyfNSQPqw0WD3lWjGWT8kIac8G8oKbJ6lbUa72+S
	 lo0WAy3DMOcoZ6K62i1Kf7l0KOVAHx1GW1VJM56zqfSRjURcjleK3pjytca0NrT9Iy
	 HJeVHdBdruc06nENdH1Ww15ePdTfvjRwHqqkL0VPKACRr+z++tEeRbqjeXRi6Qgzwd
	 Rm4Ovj8igRqu5WHvWoQemHpRyapGryRV8c2SIbV5aW03UVJu3jVZlar1hD1YSQqZQQ
	 xGwxgLNaEp9sA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4BADC40BF2;
	Fri, 25 Sep 2026 23:58:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D668194
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5343C81104
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TwBpIoYWg2_K for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 23:58:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 625A381178
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790380686;
 b=cAUMNnJ961IkcD3axd4zr0DtPapvupHjlAqOQW2Tiru7JZiC5ayp/iIOJLVuRe2WJ5nm
 Ve//M1t72K3xfZ5RJSRq8wNM1Z/8psqczRam1ssFcNaP9hbAp2r3I9ciumjtMe5mxP/fg
 0hCrYDeOYlMtTIdJxU2X/pTEHTykoaKu1mW0A7pqsd6nXRBlhwsuLO1+XYEYH8IlVbrzI
 cWNzZFiKq4vn1TLN8+IMZB9EOlOcuKuyVdGveZ+eHIOUwf/tbUCyiFyZUQBJdfuRYdUsl
 em0ukqcBhP4nbeZfeDDRrS40Icvsanc8/TdjYlVmnONbZ9exIL4afEymdjjvMjWyDHw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790380686;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=oZ4DonPxN5mcGwVP+DLk6RxuPRCTUYaW2K0pyvd3Gs4=;
 b=N3AG2GDfILM1hAsmeNeCaZ7+7IRUCYKHuH18YePDQD+dXhWWE9ZoECxYIAcp6QWGmBLs
 5T1019+hic3n8XTTC3LcHyLxMezHFVWODTAb8+DxKEh1aQX1omNLn+yUMlXX59krxG70X
 Fskx1NbbrzjAdeimaYF/maExQMH3cU3NBTL91dbxsbpdq5K1QGaMoKaOfg4M3qjMvPacp
 9L6DreG4LsthV/3WdzF+85B05INAv9674npa9Ni+RT+wCw9eamk3rwYDX4P2tSjGZi/ub
 oaWSkhTb32kEdcAgPOTdaRkSajkyBZF0R3M6KTnp1GjG36H0W3/T1euhdYeCIHcMO+w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=TbNTVnEk; 
 arc=none smtp.remote-ip=198.175.65.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=TbNTVnEk
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 625A381178
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790380686; x=1821916686;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=XKw10G5YYED4K0/71kHDXfA+DZWhX4M2uZMNBKB32gg=;
 b=TbNTVnEkgjqHEfYs5848lEsShPTxi2bcI092zI/TZk3UjfbBSIKVEP+f
 9ZwZfs+IoILxmNqm/1Tp01Xbs7EjgkEJ+RHK7mIfrqwRAz6IM2pxX5E5D
 ev/aSfbf9F6L09sYsE4GD58JzCgdRIHUOoxPQmLg6+2DJJerVrraad529
 YSzzWAxhzMt1dTba0cREObDZ+KeLk2bfAOxzEgCBu+DaYsBEQ+ZhCnQ/Q
 cGJMkbdZTHhcQRt6EOE7HhkPV3WTiYgyGBJZyQiu3rKAjYjNuBDQPYggo
 U2RzX5W31MjiSORWwkDQGp6F8DZmPFZUiDzgCVPzo/NxLdcZI8qBrYZHU g==;
X-CSE-ConnectionGUID: rA/DDUCFSYG9H/K0ApttVg==
X-CSE-MsgGUID: tpLMsVgASH2TUPQLFuKoTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="90212815"
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="90212815"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 16:58:03 -0700
X-CSE-ConnectionGUID: Un3zMzfoT9mGSk4grME9QQ==
X-CSE-MsgGUID: Amjn4IH3QSWvwAjjqdH7fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="300731132"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 16:58:03 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 25 Sep 2026 16:56:43 -0700
Subject: [PATCH iwl-net v3 11/15] ice: wait for in-flight Tx timestamps
 before flushing the tracker
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-11-6532598e8da8@intel.com>
References: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
In-Reply-To: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, Petr Oros <poros@redhat.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=3747;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=Te6PZmoxiAZ7MHmMFFcfNajxsOR3XxUDylUy3rlSvnQ=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqztXFXTSl9t2LtcMf2nu8YC+ZAg1p8zLh9W33qo+OKLI
 3LH/yx06ShlYRDjYpAVU2RRcAhZed14QpjWG2c5mDmsTCBDGLg4BWAim7wZGdYke+179VfrbfKe
 gj6tYGtWFaczLxZuluTd/uXskdezdQUZ/vC8iEmZEsix6vXV+98Li5ZtEa2OPWOaOGntQ3nB7rv
 SqzkA
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

Wait up to 10 ms (per port) for in-flight captures to publish their ready
bits before flushing, so the flush clears them together with the rest.

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
 drivers/net/ethernet/intel/ice/ice_ptp.c | 64 ++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 818e2e265a7e..5220de274819 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -744,6 +744,68 @@ ice_ptp_alloc_tx_tracker(struct ice_ptp_tx *tx)
 	return 0;
 }
 
+/**
+ * ice_ptp_is_tracker_drained - Check for outstanding timestamps
+ * @pf: Board private structure
+ * @tx: Timestamp tracker structure
+ *
+ * Return: False if there are any timestamps still waiting for hardware;
+ *         otherwise true, including when unable to read the ready bitmap.
+ */
+static bool
+ice_ptp_is_tracker_drained(struct ice_pf *pf, struct ice_ptp_tx *tx)
+{
+	struct ice_hw *hw = &pf->hw;
+	bool pending = false;
+	unsigned long flags;
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
+	spin_lock_irqsave(&tx->lock, flags);
+	for_each_set_bit(idx, tx->in_use, tx->len) {
+		if (!(tstamp_ready & BIT_ULL(idx + tx->offset))) {
+			pending = true;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&tx->lock, flags);
+
+	return !pending;
+}
+
+/**
+ * ice_ptp_wait_for_tracker_drain - Wait for PHY to complete timestamps
+ * @pf: Board private structure
+ * @tx: Timestamp tracker structure
+ *
+ * Wait for up to 10 milliseconds for the PHY to complete any outstanding
+ * timestamps before flushing.
+ */
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
@@ -760,6 +822,8 @@ ice_ptp_flush_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
 	int err;
 	u8 idx;
 
+	ice_ptp_wait_for_tracker_drain(pf, tx);
+
 	err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
 	if (err) {
 		dev_dbg(ice_pf_to_dev(pf), "Failed to get the Tx tstamp ready bitmap for block %u, err %d\n",

-- 
2.56.0.rc0.395.gd1f3524e15dc

