Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC2B10BA431
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Mar 2026 07:22:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8275783C3A;
	Fri, 27 Mar 2026 07:22:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fJ8fBsMXWvnF; Fri, 27 Mar 2026 07:22:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8D90B83C18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774596162;
	bh=ufh+uGdTitr2FxctMNp1yPRIR2ITNVbHqGxO5C6v6hc=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ya0P78M+xkJqHdpM40dP+eHERum55blAzUYXlyk9rsLIMWCiXNtldN+iA9xP3hUqq
	 IiqkmIvSfH4Cai2dsSRAH1p91TC4JJyVA7yFiI5jZGSzpUoo4RN+zzGH22PWJl3VKx
	 rV60F4KE8pMTW+zOyes/tajnS61YPTEdR/NjOug8LHgplZPYk+/Q1AS2lE4g/Fob5o
	 hgUCTqC1d8Yi6AM/YRS2h3JxB7drlr2STH1F9vGR3ZYfwVVUaMzyfvi2/W5vjqtxyV
	 gX40vA+tFZENZySZKzn+GsIKh+2pILmRINpFYu9B7EPscxt6KxV3g13NAjtrV9dAAc
	 04umgKfOrVaqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D90B83C18;
	Fri, 27 Mar 2026 07:22:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 78BF8249
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:22:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5FEA261275
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:22:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fc9bQXn8irKu for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Mar 2026 07:22:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2EDDC611DF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2EDDC611DF
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2EDDC611DF
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:22:38 +0000 (UTC)
X-CSE-ConnectionGUID: Pz0qZofhRW+7Coq29snIdA==
X-CSE-MsgGUID: EnDvAxnhTCiNWN5pCYSNkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="74848613"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="74848613"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 00:22:38 -0700
X-CSE-ConnectionGUID: 6/9e78DSS/GRznaHMWAXsw==
X-CSE-MsgGUID: ntREl+RURPirFn3v7oSxXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="222359329"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2026 00:22:37 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org, Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Date: Fri, 27 Mar 2026 08:22:32 +0100
Message-ID: <20260327072236.129802-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774596159; x=1806132159;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=D+s5dkR7PiyUUKF6dt62fXzb5w6vmdnbxG390mMhAoY=;
 b=h2H947/LbZSFboT5p4tGUXqp5C4Cw0uARWu9NiiAxWqfkaXXgmiiIiuC
 gZBEgpxeNGn91cGileFsP86yCQT3tJhCnsyC6kvKmBzjGcsuhYvdDUtq+
 38mNL4djkA/wsMShx2iPyt0ZPhz2YWK+hnzcRJf4DcWLBhfrzIwQsnBzu
 v/eTsvT9jsHiOwmRqMw9/lUp7+q7HPqnohlOkvQAquRZKjp0lcorDQMkh
 JGI/C5DkztGG/1Qpm05NpPHUmKDTyszWW5IRpggNWJ3otnHOs+8U+KLg5
 HyqdBB/8k8Id7pD2DlpMkBdYdgwuIlcaixelghkggl4MR4+pnPsGu/10D
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=h2H947/L
Subject: [Intel-wired-lan] [PATCH iwl-next] ice: fix FDIR CTRL VSI resource
 leak in ice_reset_all_vfs()
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

From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

Resetting all VFs causes resource leak on VFs with FDIR filters
enabled as CTRL VSIs are only invalidated and not freed. Fix by using
ice_vf_ctrl_vsi_release() instead of ice_vf_ctrl_invalidate_vsi() which
aligns behavior with the ice_reset_vf() function.

Reproduction:
  echo 1 > /sys/class/net/$pf/device/sriov_numvfs
  ethtool -N $vf flow-type ether proto 0x9000 action 0
  echo 1 > /sys/class/net/$pf/device/reset

Fixes: da62c5ff9dcd ("ice: Add support for per VF ctrl VSI enabling")
Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---

 drivers/net/ethernet/intel/ice/ice_vf_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index c8bc952f..7d33f09 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -801,7 +801,7 @@ void ice_reset_all_vfs(struct ice_pf *pf)
 		 * setup only when VF creates its first FDIR rule.
 		 */
 		if (vf->ctrl_vsi_idx != ICE_NO_VSI)
-			ice_vf_ctrl_invalidate_vsi(vf);
+			ice_vf_ctrl_vsi_release(vf);
 
 		ice_vf_pre_vsi_rebuild(vf);
 		ice_vf_rebuild_vsi(vf);
-- 
2.52.0

