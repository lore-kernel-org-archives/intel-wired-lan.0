Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4C7C9830E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 13:27:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56A5360D61;
	Fri, 25 Sep 2026 13:27:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JHQE92obd7xP; Fri, 25 Sep 2026 13:27:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 670BB60D78
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790342825;
	b=LoMIlVe36E2YBN2e4MydlvRs3I1LZB/4iT2RgxaiKIJDlFTMm8Hy+jbKti1FdEoiYO+A
	 c9jlZ1NTAPPs5NetZKP1hsV4MWK0vVbxrO2UKihqD/cqdauwb8M/smwiC0Ds0o3Y1Vv5i
	 oNoSs4vOaEf4S2KRBNPRg1OCyvnw4VRCuYl96KJp8Zc1swgF1uzkkN4z991HH+zz2uiA4
	 kgjKQfYGvMIbLcm4HsMMJ5waoI483EGBF83tsk53BwlF+zGHbhMiSL6rAHWXNUiYvECLb
	 pyObhK5YnmcfKWUEL7t/3cLEgw1eqSaKGKSER8tkKJq3JTOklztgCaaVq3UbPvcQZWA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790342825;
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
	bh=h8ugvn8xdXj2s7OsU6rDS6zTMr9XiQBxw+ubQr4g0YQ=;
	b=fnTJ1jnWKFEEVpEtOD8iKQmbmbzkYDSNYLG4Kq+iYSYU+gHKT9amdMJPHvsA/Iz8vbtI
	 Xy1Ncyp/UNixfYo7BXjUIUtALW0N+hewMpEjWb3IFc8I8f0HX8x2xudoB0Gj8aqFuwctA
	 nuYjDRG0vVPqP5m8+cHqkB196lLwkgxIvk/xnOmRZnm1ut5ZiEMRm96FC5OY/Sf+mGEgT
	 w1zrcPBtRJPPcaxernKQLGosnuHLQ86rKIUh+sGJc17d7YXAwW2r1J4M7c6wE+GH0JAVu
	 m2c/qj2E3V4davYa1dbC/+2RiJNfvHLMfMa7WJaqVdr+kANWSpeFp1UJvE0ivztR1jQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790342825;
	bh=h8ugvn8xdXj2s7OsU6rDS6zTMr9XiQBxw+ubQr4g0YQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ClO07eKXeJ5SSUQ0aUJPckFUUVp+YQrkNCx2mNWQOBulo1vQH3p8TiiQeSkLJd/p0
	 2G/gBDabPqu85jkbGlluzkkSuhaAV7tKiH5OeQmJtA2L4zCOWInBgWmERl5qNQJqnI
	 ysDdmfcPFokX75IO/1U53Gns9bu+Vtoa7HlRnd2YwGCv6fmq+/gBL1ZeiGHRJ5C71z
	 jOT8dzQPoXwJkscJ8gfsQGj/WsAljaIVUx2o2kyA3N60MjcNxEPJiLg4jjA0zmLP2U
	 iaZUXCkxNsPpkHOg2r02Ltgxaa3mgCzV2gkRXqGfV5XpAVD7Z8ugB+UiRzLAPBc7Nr
	 qTO1rTYIGZnug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 670BB60D78;
	Fri, 25 Sep 2026 13:27:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id ED9F4334
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 13:27:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C10DD40BA7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 13:27:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yjFseolCVyAv for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 13:27:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AEB1D40BAA
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790342821;
 b=aTXddoytNLs+Mfw53Z+aPn4HlUuDOdojIWqL8O94/DUFnTXQWVxyhIaJnEOpjCJkGMog
 dqvOolOPu1VAQsSpY6e8Zk6v5SAvuIndx+MZsKiDAqYDYqQY67ri+trp4lCBDqKYVwy1a
 537+pagT9oVQoSygpgPAiVQVtokCe4et4PuuVdqmeVNXdVxsnffqVEkerw1qYhgt73pkI
 1FWs4dR8M+fSv/HgSMVyPgb9rvb6+dJk35bH8d+Rv5fyJ1AXoHkM2JvcVzXh1SjAlz9la
 fP9bTxe3yKjtDbwyPRYrDrfuHgRNVilNBiCev6/iFYv3j8Tw2qDKAtEiXH3piTUQznA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790342821;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=h8ugvn8xdXj2s7OsU6rDS6zTMr9XiQBxw+ubQr4g0YQ=;
 b=b8TJ1HZmhWKdWqijiEaVCryKnJL505xp63YKeTrRoW6FTRMGViwGvlXuZFda6OrVQEQZ
 VWCIkzZMIe3ghcqaDlZjTvnHrk+w6EQQVkFiO4c2o3lHxVS1YU6VxvWIjdbOM1Ate8SZA
 QUWCDqpcs10MNWJefcFLSe5Z2y+SEDu7GC1xEE9yuAurF7Pi6tB8wFHKt7r59C7Bqpdm5
 lfSMvhevNMGJAvRQqg+0Vm9D11G+/xSRmjoVFkshoWbmpbjCPtqTaqu/NdmpRc62D+KYY
 5hMghtBW7Hh3nFLpJLiY2BuNTwoWaA2DJWyBlDesgL0eRLZpEK8hVkeLn4EVTJG9+JQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KdULqaAw; 
 arc=none smtp.remote-ip=198.175.65.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.10;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=KdULqaAw
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AEB1D40BAA
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 13:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790342822; x=1821878822;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6+u0PFe1nHuFQQKp9ilG1eh4GFW/bVKj9LEehtHjK9k=;
 b=KdULqaAwFCrJvieFKJTUjzriI5B3QWyxhIhIiIR4100IheB9hMoo/ko6
 tfyDGXTLnR5QkGyQ8m+rqfYlqLFMaqYX6o8XAEjsVGUWTXipDCak7r/+X
 QN4qh7yCmt1KhkWUZM+stNNSvBX1u6AIvh0Tvw6QahsURlslkx5HUqqL3
 WI6RW7ug/wmkWoNoqLDPFkeWbCgbBLvVjUiqHUHKQH9enM7NWYqueev14
 DSBuDmGu7XDB363WRtPhTQXuq81E8M48Em/IwGabfGOaOTHS+ZtBQd4dc
 GTp0iPCnGq176jgMwyobZB4Q2nb2k+Q257Ki6nmKbq6lTqFRoS489MNwh A==;
X-CSE-ConnectionGUID: tnkJGSJKQjWC2Je0ipUSnA==
X-CSE-MsgGUID: 60lTUq56Si2HRflpgkWxNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="107508276"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="107508276"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 06:27:01 -0700
X-CSE-ConnectionGUID: Vs+P74epRTKeM1iq0DyKrw==
X-CSE-MsgGUID: LDqo3DzyQqGo7OvB5JCoqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="282414750"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa005.fm.intel.com with ESMTP; 25 Sep 2026 06:26:57 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.245.32])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 188662FC53;
 Fri, 25 Sep 2026 14:26:56 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Michal Schmidt <mschmidt@redhat.com>, intel-wired-lan@lists.osuosl.org,
 edumazet@google.com, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net v5 5/6] ice: rebuild ring stats arrays instead of
 reallocating them in place
Date: Fri, 25 Sep 2026 15:15:47 +0200
Message-ID: <20260925132636.123300-6-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
References: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
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
end.

The VF case shows the divergence. ice_sriov_set_msix_vec_count() writes
vsi->req_txq and then calls ice_vsi_rebuild(), so the old resizer sized
from req_txq, while ice_vsi_get_num_qs() reads vf->num_req_qs ?:
vf->num_vf_qs and ignores req_txq entirely. Once a guest has raised
vf->num_req_qs through VIRTCHNL_OP_REQUEST_QUEUES the two disagree and
the arrays come out shorter than the alloc_txq/alloc_rxq the rebuild
installs. The reset that such a request triggers is a different path,
ice_vf_reconfig_vsi(), which does not use this resizer at all; that one
is handled by the next patch.

Replace it with ice_vsi_resize_stat_arrays(), which allocates a fresh
struct ice_vsi_stats instead, sized with ice_vsi_get_num_qs() and the
queues ice_vsi_decfg() is about to return to the PF pool, which is
exactly what ice_vsi_set_num_qs() will compute once they are back
there, barring a concurrent change of the PF pool; the next patch stops
relying on that. Copy the surviving entry pointers over and install
the new structure, all before ice_vsi_decfg() runs. The entries that
did not fit are freed by ice_vsi_free_unused_stat_arrays(); the old
container itself then goes through __ice_vsi_free_stats() with
@free_entries set to false, since the entries it still points at now
belong to the new structure.

Allocating up front also means a failure no longer leaves a half-updated
ice_vsi_stats behind, with the Tx array already swapped and its surplus
Tx entries already freed, but the Rx allocation failed.

Put the allocate-install-free-surplus sequence in
ice_vsi_install_stat_arrays(), next to ice_vsi_new_stat_arrays(), so
that only the sizing decision is left in the resizer.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
this removes some tech debt, but it is not independently backportable,
as it sits on three preceding refactors; the NULL dereference and the
sizing mismatch are fixed by their own patches, which carry Fixes: tags

v5:
 - drop the false "requesting fewer queues than the PF pool can hand
   out" reproducer, use the VF one that the code can exhibit (Clashiko)
 - describe the real failure-path benefit, the old code already returned
   before ice_vsi_decfg() with the VSI fully configured (Clashiko)
 - split the ICE_VSI_CHNL guard into its own patch with a Fixes: tag
   (Clashiko)
 - factor out ice_vsi_install_stat_arrays(), reused by the new sizing
   patch (Clashiko)
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 144 ++++++++++++++---------
 1 file changed, 88 insertions(+), 56 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 134984077d5d..448d3c7780ad 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -557,6 +557,80 @@ static struct ice_vsi_stats *ice_vsi_new_stat_arrays(int txq, int rxq)
 	return vsi_stat;
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
+/**
+ * ice_vsi_install_stat_arrays - swap in freshly sized ring stats arrays
+ * @vsi: VSI to install the ring stats arrays of
+ * @txq: number of Tx ring stats entries to make room for
+ * @rxq: number of Rx ring stats entries to make room for
+ *
+ * Surviving entries are carried over, the rest is freed together with the old
+ * container.
+ *
+ * Return: 0 on success and negative value on failure.
+ */
+static int ice_vsi_install_stat_arrays(struct ice_vsi *vsi, u16 txq, u16 rxq)
+{
+	struct ice_vsi_stats *old_stat, *new_stat;
+
+	new_stat = ice_vsi_new_stat_arrays(txq, rxq);
+	if (!new_stat)
+		return -ENOMEM;
+
+	old_stat = vsi->back->vsi_stats[vsi->idx];
+	ice_vsi_set_stat_arrays(vsi, new_stat);
+	if (old_stat) {
+		ice_vsi_free_unused_stat_arrays(old_stat, new_stat);
+		__ice_vsi_free_stats(old_stat, false);
+	}
+
+	return 0;
+}
+
 /**
  * ice_vsi_alloc_stat_arrays - Allocate statistics arrays
  * @vsi: VSI pointer
@@ -3040,69 +3114,27 @@ ice_vsi_rebuild_set_coalesce(struct ice_vsi *vsi,
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
+ * Return: 0 on success and negative value on failure.
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
-	struct ice_pf *pf = vsi->back;
-	u16 prev_txq = vsi->alloc_txq;
-	u16 prev_rxq = vsi->alloc_rxq;
-	int i;
+	struct ice_vsi_alloc_queues_params qs;
 
 	/* channel VSIs have no entry in pf->vsi_stats[] */
 	if (vsi->type == ICE_VSI_CHNL)
 		return 0;
 
-	vsi_stat = pf->vsi_stats[vsi->idx];
-
-	if (req_txq < prev_txq) {
-		for (i = req_txq; i < prev_txq; i++) {
-			if (vsi_stat->tx_ring_stats[i]) {
-				kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
-				WRITE_ONCE(vsi_stat->tx_ring_stats[i], NULL);
-			}
-		}
-	}
-
-	tx_ring_stats = vsi_stat->tx_ring_stats;
-	vsi_stat->tx_ring_stats =
-		krealloc_array(vsi_stat->tx_ring_stats, req_txq,
-			       sizeof(*vsi_stat->tx_ring_stats),
-			       GFP_KERNEL | __GFP_ZERO);
-	if (!vsi_stat->tx_ring_stats) {
-		vsi_stat->tx_ring_stats = tx_ring_stats;
-		return -ENOMEM;
-	}
-	vsi_stat->tx_ring_stats_len = req_txq;
+	qs = ice_vsi_get_num_qs(vsi, vsi->alloc_txq + vsi->num_xdp_txq,
+				vsi->alloc_rxq);
 
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
-	}
-	vsi_stat->rx_ring_stats_len = req_rxq;
-
-	return 0;
+	return ice_vsi_install_stat_arrays(vsi, qs.alloc_txq, qs.alloc_rxq);
 }
 
 /**
@@ -3132,7 +3164,7 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
 
 	mutex_lock(&vsi->xdp_state_lock);
 
-	ret = ice_vsi_realloc_stat_arrays(vsi);
+	ret = ice_vsi_resize_stat_arrays(vsi);
 	if (ret)
 		goto unlock;
 
-- 
2.51.1

