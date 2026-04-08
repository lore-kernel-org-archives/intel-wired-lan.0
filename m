Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638511073CBC
	for <intel-wired-lan@archiver.kernel.org>; Wed,  8 Apr 2026 14:14:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10FDE40EE6;
	Wed,  8 Apr 2026 14:14:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oaE0kJReA6uC; Wed,  8 Apr 2026 14:14:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D2F6740ED1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775657674;
	bh=59JzdarhuqKN+Ltdli4ZQCYPcZP8imhj4kqdn/TLBmo=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AYLtM6xCZicVqQrJFtCgsqVkQfvuj2w/tXgUm6rfq6SRS5QlaP7gAq01b3e+dYndN
	 W/yVjEidTwW7hMDeRlk6iEoE4D4/Nv0t8tcfXgQUjrXE904ux9RzokHFjdMcWgcZQY
	 /JZFZzv3ezKXazANwXi2ErkrVo2T+/+5215sSPB8cUfclMzUxH5ckdCepQO34XtG5l
	 IpMKhuuMMBggZM7fO9Up6E7AnmqEpzNXqiI5wSwQS4mhsrvRDIXaUJkO/Uh/WLbV0X
	 bazhbI3SX9IeO33I3lF6rgi7oFctpI8Ln7vFiTCe48R58TEmY3B1oCff82Cs4YEoBE
	 hMLdmGM0Qoa2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D2F6740ED1;
	Wed,  8 Apr 2026 14:14:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DD2E8237
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 14:14:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CF1CC823AA
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 14:14:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mi77yVDotPld for <intel-wired-lan@lists.osuosl.org>;
 Wed,  8 Apr 2026 14:14:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 343A28235C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 343A28235C
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 343A28235C
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 14:14:31 +0000 (UTC)
X-CSE-ConnectionGUID: mZG6noXYQmGInsCLPjNs6A==
X-CSE-MsgGUID: Z51zAp2FTr2cGMxf2DbRPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="64187417"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="64187417"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 07:14:31 -0700
X-CSE-ConnectionGUID: nQZXeFGxTmqJm5Ko0JrjIA==
X-CSE-MsgGUID: hil73vjbRmufhZPqKUfXRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="225721117"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa008.fm.intel.com with ESMTP; 08 Apr 2026 07:14:30 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@intel.com>
Date: Wed,  8 Apr 2026 16:14:29 +0200
Message-ID: <20260408141429.2798589-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775657672; x=1807193672;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=sw3WqSkSk8vlNUrCc326Em40Cu7by960cERr0qqQGu4=;
 b=cqfCl5B7ggGwRrIGGHgd7sGW55IIIN5/PT4pmJYdM60XCq5RhfmcnuKl
 O9hXfKvZiInL1s5ArfyQh5GxBIy7L1yIbfHr8GHQY//eBv2xCeM3Bi2yx
 Zx0EWjs04iUkSnLTSGcgwI107vu0Z3Senh6cZlKUiAIv2uw3TOiQGqOLS
 ZyOojWmkI4w8vkmpDEFq/gSTJARHAoqd9KS5cl91hpXZMvXpjjpfjwRwA
 E0zTzon8uJvd4IlHKKwgv/8mmUxTIebZvbhna3PLVUYrGNtR2XhGgJd++
 c3x32u1t56ySkP8xe4JMCInpm/e2GahPoL4wahzDjwyVs8lakpUp+WmvI
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=cqfCl5B7
Subject: [Intel-wired-lan] [PATCH iwl-next v2] ice: call netif_keep_dst()
 once when entering switchdev mode
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Marcin Szycik <marcin.szycik@intel.com>

netif_keep_dst() only needs to be called once for the uplink VSI, not
once for each port representor.  Move it from ice_eswitch_setup_repr()
to ice_eswitch_enable_switchdev().

Fixes: defd52455aee ("ice: do Tx through PF netdev in slow-path")
Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v1 -> v2:
 - Verified Fixes: tag via bisect - defd52455aee introduced the redundant
   per-repr call to netif_keep_dst(uplink_vsi->netdev) by changing the
   target netdev to the uplink VSI inside the per-representor setup
   function. Before that commit, each call was on a distinct repr->netdev
   so no Fixes: predating it applies.

 drivers/net/ethernet/intel/ice/ice_eswitch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 2e4f096..c30e27b 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -117,8 +117,6 @@ static int ice_eswitch_setup_repr(struct ice_pf *pf, struct ice_repr *repr)
 	if (!repr->dst)
 		return -ENOMEM;
 
-	netif_keep_dst(uplink_vsi->netdev);
-
 	dst = repr->dst;
 	dst->u.port_info.port_id = vsi->vsi_num;
 	dst->u.port_info.lower_dev = uplink_vsi->netdev;
@@ -312,6 +310,8 @@ static int ice_eswitch_enable_switchdev(struct ice_pf *pf)
 	if (ice_eswitch_br_offloads_init(pf))
 		goto err_br_offloads;
 
+	netif_keep_dst(uplink_vsi->netdev);
+
 	pf->eswitch.is_running = true;
 
 	return 0;
-- 
2.52.0

