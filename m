Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4813BC88E7F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 12:55:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1769D605E0;
	Tue, 15 Sep 2026 12:55:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id quQrOjO8dauf; Tue, 15 Sep 2026 12:55:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7AEAC6074D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789476925;
	b=gQyzIy4xEDAL6fq6QpUCfWxTYMF00hSeNffoYYyLEVNZMsMFhmwXA8RW888ZacWxI3Fu
	 VZs+CStihbjLLqYLsXreReRhnTPYubcRVFNsKKJMNyNn4/v9dIayC3K2pcmX+BVJ3QIsk
	 rtrP7JufkBfVW3WRvCnf8N/7V8XFMjAO8WjPI99cWg8WQrHAAv0Jh6ECS/5Ldq8z8VMIN
	 WN620cVd0N1JUNIf4iE8XCLniH6vStXG9znWJ76xx4yKjy04D+7xvGXTygj5atLyZZ6JD
	 HdTPwunNTAIZqAxqWW1gTBPVBH0fZ1HrVnx8R3NtK1WyphfCHgfd02AyUJOcrExFYzQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789476925;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BUHIlw42I6kt83rofw7Z117LBwBFfOsSLEBtgku9KZE=;
	b=FqT02LZ8fvhmH8sCiTdegLc0Y8O3IMCwiD1XoYxnjLM95gDfUidKfiOfiSqY/Q8rBaPO
	 4KrEmpo2Vau4tzl3psYF/907HdwYT+DfpCkTxV4geGTMDCi3C+OHvWNEh0g9h+pV0Aw5b
	 TrG+POZJPI8uvL8CcD7aaNKZVw2FC6sYWlgCQOfV6Q98vJ8/MBZ2mQwS/MOQ9dVDYRXjo
	 wO6PLGV/aVfKapgkn56T0EyxbwBBK++SDbRRvRnfEWv4qRzv8nHY5W9x43S/9dke7ZCSW
	 KJaAoQYHwaC5CNVjZObIXVVIoQGngSJOGWZwzcBEEj5/J3qmhiDOVsYUedazgGxVWBg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789476925;
	bh=BUHIlw42I6kt83rofw7Z117LBwBFfOsSLEBtgku9KZE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=u++cIOfBEjOBGgOp/eMufw4L5aK+2YY+fV3CWafrU4Soey6egHIf/nAIq8cVf9st9
	 5DxdfAYLyIbJitAOrbr0a5qCli5XsjFpKb9YJOCUMwu0t2ZEiSlcMhYp4DfLzz+Uem
	 EnijWXwPV8z+Q1ezPXKhHA8963IDObm3sGM00PGPpXNHzdupFd2G61nvnqc/wUIHuG
	 srNW89HM8e43UFBS7oIy/T5+HvUfDzTjMiDj7/dVrHdp4JnSs2bsLDiu+LD5yT9HiS
	 +RHNE3FVD7OHDuarrJ4xm1Fo4pSAAJrlgRz8JYcMPTgSuERYB2q++8cDI1XV7ZrUm8
	 CjlaQ6Ocdi8jQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7AEAC6074D;
	Tue, 15 Sep 2026 12:55:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D89D8493
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BEF6A4009D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jenzh3h3fCiH for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 12:55:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0F7334002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789476923;
 b=bdx7LLDmTuK7UcGjMgrpp5OUhBNbl6bZ6wXeA1Qq07YRSFiHmK5t+D3uaTnsylKxIb7B
 oAhdcBRh8jAYZSNafiNQd9ImWMBzCk7F+Wd9TIekFLxbMRnNSzyObCUp+wBMqkyWq1j3F
 +9YKUvWARkZxStt3y4pEEJjSgrNeWTSh7x3q/8HSWyPTiv0c9gdIcAnsrenilLLubC5qm
 xbmsL+zhe6d+G0gou5inR8eambO7Ukc0w1cNH6As3ziss3259OUIEOXJ8GnAiR6zmrYwN
 PXLbPMfpjLSxTnJ25h9NP4ixAxxXl6DxW+p5KrLpQHwW+pSELFuvXB/rzSaCuZ9WjtQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789476923;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=BUHIlw42I6kt83rofw7Z117LBwBFfOsSLEBtgku9KZE=;
 b=ZhQausEGvoZfIVYePdZCYX8o/B4HSpQtwED1ZGepgxB1QQP/EEacIcBkCwFYySwezBTx
 XuB1IMOlXi3dpHvoNpS7mnFsHetbsugHpqR3WJG7txJ/NeMCUuXWi/GXOv3kPU6xOTpJD
 yksf3IiKIJQi1EXMvf6i7U5lvafg9cZiKIbgg5dwpdgxaFTOPtambmk23xFSNHJDmgzs6
 faE60e88nRg19JcY1y93hmKLQiKspjc1rvDPBYDa4TgbR7oJuBEnOgB1tjUhyX16MXrxx
 1SmPFS97N7nIY2wUYdEoMMH3m3wzOLlDax+/PfCdr/OZjI4n0xX2UMsugQav7oa5BvQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=TK4F5WEa; 
 arc=none smtp.remote-ip=192.198.163.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=TK4F5WEa
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0F7334002B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789476923; x=1821012923;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=as05ITydtJv40NasvrOuvsBKvHNNZNXXjN1IanYdf4w=;
 b=TK4F5WEafBnCyc8rel7wNxhyQk/kORAIJSvbX1AXFxO2sGsipyVJTOz1
 vSfoJchQ362sCr3T7oSBcTmgFeZBwSKKfCz+bEb85xvTG+5xuJI3zyli6
 G2BIJbXjrGyQNPwp8AbwuAvaQP0/nJDsYp8ndHhDwt6555o5XtHI2/94J
 y+KyUCFo/th1sRUmF9KbZyc9/Yz2YxPvqPaMkqaF2Jph+YkdZpl8xgSE5
 +hmxjCfmRnLwKa4ODRq7aZGDp2LHGtEo8pbPWeouj4lAp/ZFC7MXYhHaW
 3fuWtTPM5kxW9aJO3xdYGkOG2b2wPo8296gBwWUzubTCbzgVn66zkWfMU Q==;
X-CSE-ConnectionGUID: FMGrrrlbRT61x16HBh3paA==
X-CSE-MsgGUID: nvvV8GDRSg+p9AU03Y4azA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89853094"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89853094"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 05:55:22 -0700
X-CSE-ConnectionGUID: HfsaFdiSTb6NbfDMXHkBsg==
X-CSE-MsgGUID: q33d96EtSwSYAjaFO/dkQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1225108"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa011.fm.intel.com with ESMTP; 15 Sep 2026 05:55:21 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org, Jakub Staniszewski <jakub.staniszewski@intel.com>
Subject: [PATCH iwl-net] ice: fix FDB deletion
Date: Tue, 15 Sep 2026 14:55:19 +0200
Message-ID: <20260915125519.3975583-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jakub Staniszewski <jakub.staniszewski@intel.com>

Correct the logic in ndo_fdb_del() to align with other drivers in
upstream. The condition was inverted — it was rejecting permanent
(NUD_PERMANENT) MAC addresses while allowing non-permanent ones to be
deleted, which is the opposite of the intended behavior.

The correct logic is to reject deletion of non-permanent entries,
mirroring the fix applied to ndo_dflt_fdb_del() in commit 645359930231
("rtnetlink: Fix inverted check in ndo_dflt_fdb_del()").

Also add is_link_local_ether_addr() to the unicast branch of
ice_fdb_del() to mirror ice_fdb_add(), which already handles link-local
addresses as unicast via dev_uc_add_excl(). Without this, a link-local
address added via ice_fdb_add() would fall through to dev_mc_del() on
deletion and fail to be removed.

Fixes: e94d4478669357cd ("ice: Implement filter sync, NDO operations and bump version")
Cc: stable@vger.kernel.org
Signed-off-by: Jakub Staniszewski <jakub.staniszewski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d888354..4c6d863 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6151,12 +6151,12 @@ ice_fdb_del(struct ndmsg *ndm, __always_unused struct nlattr *tb[],
 {
 	int err;
 
-	if (ndm->ndm_state & NUD_PERMANENT) {
+	if (!(ndm->ndm_state & NUD_PERMANENT)) {
 		netdev_err(dev, "FDB only supports static addresses\n");
 		return -EINVAL;
 	}
 
-	if (is_unicast_ether_addr(addr))
+	if (is_unicast_ether_addr(addr) || is_link_local_ether_addr(addr))
 		err = dev_uc_del(dev, addr);
 	else if (is_multicast_ether_addr(addr))
 		err = dev_mc_del(dev, addr);
-- 
2.52.0

