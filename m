Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C17CA5FFE
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 14:39:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C7430605D0;
	Tue,  6 Oct 2026 14:39:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5XHz5eQ0-zy1; Tue,  6 Oct 2026 14:39:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 33FF66062D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791297551;
	b=Q006BZQtVaZZIqbHATEBUBeSsp/o/a8DsnqY70FnIO0fMQ4/fgU/Vi5rbyrtQ3WLFlbv
	 V0c0jF7ruuhFpG7g2ZQt8CR8MLAp3x3ErlEuunZVY+NanE3vCY+E5zb2pAd9hEFLwhKsE
	 ToSGTBMRHQAx3M7zr5QqIhBdIHAAlEgfoAcEXvRT3B20qzqt5EtrAo49ltLOeyxxWyIrr
	 oOOHqAYU6YDl1Ub1fpMB7lS2eq3e+NrnT5K43Y1a2fQ20e5ag34bW6BMtN16cK+1BxmVu
	 53oQYrmX8UcR08jsRSQ8XyGcv/4wP4LULEK/aEz06AtuD7Z9VUpk7HCmfAnhPVAIGKw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791297551;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iX61u/yEG288tJKisFWKypJQe5vLJACBsyJGs2lSiHE=;
	b=eBLRsT1zxr6LuYktcBHSWNEBSTWZ9KSyr4ijE7uOgTCLmZmUr0o5pOHpyBZti2Gn/SEX
	 MvrpCpx/KmBCL8W2BEco9jvcOG4l3yPSqc7XFRPmznS3zPHVWyQGRF+86/DHSnV0Ty4yZ
	 tCgGAKzxgamNnZDoJVyZLdZw2BkhlHxrqQuiWQN7293NBi5UdzEfGfbL7c0pPrFzwdLTU
	 mlogurTkhyeDq1R5Cr1PLFegVO0kkIpZhvPHXGPqAkGHPCPFPfl90UoQYslnobOfarKvu
	 vkcGRFm3FNNYSRR1cV6ODYMR6hmRFADOAj5Co8rBPWZFD/rCDqcnkErYD2OaGshowAA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791297551;
	bh=iX61u/yEG288tJKisFWKypJQe5vLJACBsyJGs2lSiHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0GS7BHZbrCoyVboEKPsXmCc6KB1oqQCIHyXjmfrB1g6wN+9HgOBjUHXgSdJzI7X0j
	 ya7nDvcJ+DEeKIGe81n325JPYrHCzfGwLgkAwK4/50OZ9TCxHI6yWhyVAY608XCLHq
	 1GLV0YJkj05yv7C240S5DNUFsh7NyiWKPLjECfHDnxMSWdGccQG/d/rMF/8Tyfy1yg
	 1drI8ttvLBPGikJSPt2MWVflWxy3mDQk71r7ikxS6K7sr38uGQAOASBYefM0ayo+H9
	 vjfqyspAnnTirCaNjLht96ZJ0LEOLQLpnq4S/L9ljXlhPGVZyeDkGqx0l7HybKA918
	 VM6kcTnUw4z0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33FF66062D;
	Tue,  6 Oct 2026 14:39:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CE9E6317
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:37:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B439A80AA1
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:37:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gwxc6rxIGM_2 for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 14:37:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 12202808D3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791297447;
 b=EE333sbIXu8KrahAxa2y9Gt1Kmt5QFjCC2Wyn5P2pV/DiCZVgDjRiA5Ug3HrkxL3tI/D
 soc8MpBuqKNLNTO9hFSsA0uUiBn+WJ1oy2RWY7lEpGI5IxqyQWDU0ZVbyG4SCNHhv8PJb
 VQ2t82JoaIvphY+kRjYMa7uI2W6ujPf19uOg8C/0w1mNKoQrRx/Mv6cfQ7c1f8Qveg2oL
 FxGOeILfcJdQG8ZdeUekZZZXIG3jIrDWbMlhHO4BRLJsJq+2Uy1keW7AOcW9do0tUp71A
 F7+8Vc/+dNOdo4PagYRVYSOqemFF7+0EEYf19WO0kZlwRIjtVtGq7AG0EPKIWolFkRA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791297447;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=iX61u/yEG288tJKisFWKypJQe5vLJACBsyJGs2lSiHE=;
 b=K5fcn26GxI1Fqr/JonWyrA3M82h21FlEDLMx1c/e2tEreXbDDHJ4qh8HcJ628J2sSC4y
 zwX+l7P1D+dfV/QZ1fZ/W1peVuNaTJHnF+cKc4Sszue9TF9rwi0nSNPwyLa2+Bk95Xuu5
 uex1H7sZSfnmRPvnD+Rxf5iakjraQwfxPvFhYBtLih9bvJ1GkhshH6InB++Bo6ZdtoUBQ
 lUN3Q8ff9IsWdKcyOOlRyZ0NIbI0ZXeZIPCHmrr5C+OA0zjzzIyXbU7da83Dy+jxsisMt
 S82Km4AsmShO8+aFK2xhjRLIQpxDKem1Oztp0TVk5ldSIZ9buXnQlmTBEv6DBIiu8gg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=mEkmSCfg; 
 arc=none smtp.remote-ip=192.198.163.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=mEkmSCfg
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 12202808D3
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791297447; x=1822833447;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NvrKt5QBIM7ekb5sHycky5gkUj37yhKls2Iw+zJkdJY=;
 b=mEkmSCfgDtGvYzoqOUNOie5p8SqsNn6gYNNmGHj8HFlASQlxdA3RdsMZ
 w9K5zqGzpZoVbxgiiP1V7DNecOGLXxcQbtm1Nvbapw2mlx2sfOOz5MYKy
 4YS9tZLCuFqc/JUwDvwW0FLWSVj9ysKRBrIPCa7uGHgkNedtQQo1NKLY8
 jTHg2HnDiz8lwfogCP82WOqaODHGAla8jd36Rb8frY8+IZZrPbXWv3t7p
 LW5GlUpoo2fCWAw4l33tnRWibcYZd5Ura6PV7FvJnCj3o1wXS4FWb3OS0
 JBcRikFidyN0jx37Gn7jvra9ySE9nwmj6WHagwZM24w/NCFQAccbglAeL A==;
X-CSE-ConnectionGUID: 8mn/Zyg1Tu2zVFgjATaJyA==
X-CSE-MsgGUID: 0A+Yph+7RD6RD554Tn/kwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="43276"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="43276"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 07:37:27 -0700
X-CSE-ConnectionGUID: A1Qy2vavRZm7hx4F+kpkAg==
X-CSE-MsgGUID: VFdRKTMAQzCz5CMOuthQzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="1185322"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa013.fm.intel.com with ESMTP; 06 Oct 2026 07:37:26 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: Avinash Dayanand <avinash.dayanand@intel.com>,
 Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-net v3 1/2] iavf: fix TC boundary check in
 iavf_handle_tclass
Date: Tue,  6 Oct 2026 16:37:22 +0200
Message-ID: <20261006143723.2883728-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261006143723.2883728-1-aleksandr.loktionov@intel.com>
References: <20261006143723.2883728-1-aleksandr.loktionov@intel.com>
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

From: Avinash Dayanand <avinash.dayanand@intel.com>

The condition 'tc < adapter->num_tc' only gates the destination-port
check for in-range TCs; when tc is out of range (tc >= num_tc) the if
body is skipped entirely and the function falls through to
VIRTCHNL_ACTION_TC_REDIRECT and returns 0, silently steering traffic to
a non-existent traffic class instead of rejecting the request.

Simply flipping the comparison to 'tc > adapter->num_tc' does not fix
this: it would let every in-range, non-zero tc (tc <= num_tc) skip the
destination-port requirement entirely, while an out-of-range tc with a
destination port set would still fall through and return 0.

Fix this by explicitly rejecting tc >= adapter->num_tc with -EINVAL,
and only then requiring a destination port for the remaining in-range,
non-zero TCs.

Fixes: 0075fa0fadd0 ("i40evf: Add support to apply cloud filters")
Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v2 -> v3: Resend the reviewed TC fix in a focused two-patch series.

 drivers/net/ethernet/intel/iavf/iavf_main.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index d1fe7db..09b7f51 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4098,12 +4098,15 @@ static int iavf_handle_tclass(struct iavf_adapter *adapter, u32 tc,
 {
 	if (tc == 0)
 		return 0;
-	if (tc < adapter->num_tc) {
-		if (!filter->f.data.tcp_spec.dst_port) {
-			dev_err(&adapter->pdev->dev,
-				"Specify destination port to redirect to traffic class other than TC0\n");
-			return -EINVAL;
-		}
+	if (tc >= adapter->num_tc) {
+		dev_err(&adapter->pdev->dev,
+			"Unable to add filter because of invalid destination traffic class\n");
+		return -EINVAL;
+	}
+	if (!filter->f.data.tcp_spec.dst_port) {
+		dev_err(&adapter->pdev->dev,
+			"Specify destination port to redirect to traffic class other than TC0\n");
+		return -EINVAL;
 	}
 	/* redirect to a traffic class on the same device */
 	filter->f.action = VIRTCHNL_ACTION_TC_REDIRECT;
-- 
2.52.0

