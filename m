Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C2A606A32A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 16:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=f/thna/s;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DhbHQpoK
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A651D60A97;
	Wed, 18 Nov 2026 16:35:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ayx42BcxPh9I; Wed, 18 Nov 2026 16:35:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 10607606B8
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795019710;
	b=Ud9AR3JEUVX3j+5AM0dEgUa9OrvzYAKmaYHQ2u2kRnFjfhshPnyc4GHdwtticuwD4iHF
	 0y2UewzH8M/X9EmgVc5HJ+t7SG/RKw/feD7nWR2pu4272Lc07A/GwgRHFaP2y4f3bk2/c
	 0+RFPlVXZl85qZ1k6JEgaPDUDZlG3qUbsq/8GEaUDAsKeReKvvQjifeqYxogrCJx9MyI+
	 +lCx5FL+BBHHYwo0JAXx+oqGwbOecE+Xd4AjWzETBXDxMgKeiS6SYIQRNHba7ZyYJNF70
	 OLKN51LqUARwq0u0YHi/YMXUNLZThEzMKHooxLmg36nZmodqDDGSWzf2UE+/5zRJtAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795019710;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YumNVNQrj+bl3xKOxDIlu6xIKC+cNektHINoq4rs6LE=;
	b=AEzuq/NkYkGzFejDj6Qe7BOyWXuwjIUgYKyPsvEudRhn96UlBTpObdNSaPxdJcsu28AM
	 9+w+lZwj6bTHonzgSmyiVadK4DqQOMfTjpQePMFXCuwaWfn0WA9o2azxSn/ss7b7uOfj4
	 2S9JBdqzGb8DzsGNwY23RUgDIO+0uX0yxYohdxBP97bK/cSv3tOx0PDeM/BvpPDKNKrQc
	 UbkM1bMXjepIZ49POP0vGy/Rf6L2DPtT2HUFUwP9CS+AD0j2zudf2lJ9SgRW41O4jOeKR
	 rGnJ8O0ef4z7jyaPmw0xTU40SkmrfxXN+gdvh0Tw5mHMjKEq1XOi3Aq02uUOQjsTxrQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795019710;
	bh=YumNVNQrj+bl3xKOxDIlu6xIKC+cNektHINoq4rs6LE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f/thna/s94PHOoVZeh00ru78MGgLb+mROZRtQcxOu8j+IJDAC1RO21sQ677Hb7csz
	 7qnYFW6EjSRtSWpGNjlv5sv0V2jOuDgP6GlShYDBGwj954j7YM84Dj9wM+LI7CfAs9
	 nnVpabw7lINmF2102gPh755XfeggmhG69P+VkyEgLkkahtHJ217qrZDdknPp3HSXyW
	 qqBsfe18mW4Bkc8/OPRRtunDsLIU/cBc8hnN6LDwxOKh6ec3ZgJVXkZvMupFMgfaUI
	 hwgWhYqByFhEtzQeUfkJj23Y9SXC4cV3YLhAqz94dp/P7S9vPaSxWJ+33P6ckbRlXb
	 sDZYqDjttF6ng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10607606B8;
	Wed, 18 Nov 2026 16:35:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 857E89F8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 16:35:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6C42F404AD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 16:35:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XsqE9e8AwWd3 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 16:35:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B757240199
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=dima.ruinskiy@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=DhbHQpoK
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B757240199
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 16:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795019708; x=1826555708;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xI5rZ47VqkSxKD7w0gAk80aQDlXjvkXrpU97LmTtwWE=;
 b=DhbHQpoKZ5N9o52T5CdUpukG2MIYpHMsBHY1nMj4o8er24ZrVDevovHI
 mAlHIx6e5muKyBCfk2Nb1Oe+n3qPEYuvHQAp33Xyv0Sky7EZMvIPYvQBR
 0GVLgaDm2obxWgnhxepNXfnb/BPCUoXjDM90sfavcJpg0I8VX92rWhgHu
 xpLpq1bqeEFhU8FEmyKq8VBfd4HzV5br8iOBIaO6tYMkchEVfReSz8l02
 SDbPMaRL3zvarph5tljEb3+5yR24QYM+nJlo0ZfS4DVdDpuAROrZo7D6m
 IRd1Al9pCOJR0nptqNsrnjy4qe2Co7kPUB8tT6cJQnXC29K1wvEm9ifWx A==;
X-CSE-ConnectionGUID: umf62dx8TbefH57oauNz9Q==
X-CSE-MsgGUID: sZi3t2NnTsaqnqiwSPYn5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3855913"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3855913"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 08:35:04 -0800
X-CSE-ConnectionGUID: qI6EnS5ySEuQtqUgfVRSbQ==
X-CSE-MsgGUID: j4pB1UB8Syu07eHeqymmlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10071916"
Received: from ccdlinuxdev13.iil.intel.com ([143.185.161.17])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 08:34:57 -0800
From: Dima Ruinskiy <dima.ruinskiy@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: dima.ruinskiy@intel.com, anthony.l.nguyen@intel.com,
 Michael Edri <michael.edri@intel.com>
Subject: [PATCH iwl-net 2/2] e1000e: remove K1 workaround from Nova Lake
Date: Wed, 18 Nov 2026 18:34:47 +0200
Message-Id: <20261118163447.1117617-3-dima.ruinskiy@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118163447.1117617-1-dima.ruinskiy@intel.com>
References: <20261118163447.1117617-1-dima.ruinskiy@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 3c7bf5af2196 ("e1000e: Introduce private flag to disable K1")
implemented a workaround for packet loss issues when the K1 low-power link
state is enabled on the integrated LAN on several generations of platforms,
between Meteor Lake and Panther Lake. On Nova Lake platforms, it is not
needed, and may cause noticeable performance degradations.

Now that board_pch_nvp and e1000_pch_nvp are distinct types, add another
MAC type check in e1000_reconfigure_k1_params() so that it never applies
to MAC types before Meteor Lake or after Panther Lake.

Tested on an I219-V29 (8086:57ba), K1 enabled, 1 Gb/s link. For each test,
first line is the result without the patch, second line is with the patch.

  iperf3 TCP receive, 20 s runs:
      16-50 Mbps, 72-208 rx_crc_errors per run
      949 Mbps, 0 rx_crc_errors (5 of 5 runs)
  UDP 120 Mbps for 120 s, 2 runs:
      0.55-0.67 % lost, 1855-2651 rx_crc_errors
      0 % lost, 0 rx_crc_errors
  HTTPS download of a 4.3 GB and a 3.5 GB file:
      5.6 and 10.3 MB/s
      74 and 59 MB/s

Fixes: 3c7bf5af2196 ("e1000e: Introduce private flag to disable K1")
Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Co-developed-by: Michael Edri <michael.edri@intel.com>
Signed-off-by: Michael Edri <michael.edri@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index a412475f5..f5f3867ad 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -301,7 +301,7 @@ static s32 e1000_reconfigure_k1_params(struct e1000_hw *hw)
 	u32 fextnvm12;
 	s32 ret_val;
 
-	if (hw->mac.type < e1000_pch_mtp) {
+	if (hw->mac.type < e1000_pch_mtp || hw->mac.type > e1000_pch_ptp) {
 		if (hw->adapter->flags2 & FLAG2_DISABLE_K1)
 			return e1000_configure_k1_ich8lan(hw, false);
 		return 0;
-- 
2.44.0

