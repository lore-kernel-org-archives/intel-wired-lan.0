Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43046C43458
	for <intel-wired-lan@archiver.kernel.org>; Thu,  9 Jul 2026 15:59:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1FC340FC2;
	Thu,  9 Jul 2026 15:59:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id csI-khnABoiW; Thu,  9 Jul 2026 15:59:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A707540F8E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1783612782;
	bh=MGFKLQtkzqXPZ7saVL90IfDPQkSmCFDAN36+9tQO12I=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=vDBXmRh9zGOmY4sBnltmIz/0hjRAivAsNDjm8XpebLYSIGOAorT+LDXIgN9pd356v
	 AMRkw45beETzgI4YqSNUHipyASBYW/UtMjQXnKedp036DpeGzPQUbXXN2omhxjLIQL
	 muMLUacX5xJL6pHIMoNCDsxiwCbymoruaapscQzMCUPLsQBMr9ysr3Qt4VlZM3CPRW
	 m6UI04Arp4PmLJHN2wPSjbzgRsAwfHCzz9eqF6F2l/DvcT4yI4CE0SKwNrbjGr1mFZ
	 HDastbuhC/hM1g7uSO3BeXWcNmAJjTjOb0LGMQ2IHS+9U11qntU0+ktzBjVvRS1Lhj
	 0hT9myUaUNNQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A707540F8E;
	Thu,  9 Jul 2026 15:59:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 256C1BC
 for <intel-wired-lan@lists.osuosl.org>; Thu,  9 Jul 2026 15:59:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1746040F8E
 for <intel-wired-lan@lists.osuosl.org>; Thu,  9 Jul 2026 15:59:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sNjMlAX61GJJ for <intel-wired-lan@lists.osuosl.org>;
 Thu,  9 Jul 2026 15:59:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=marcin.szycik@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org EB40B40F7D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EB40B40F7D
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EB40B40F7D
 for <intel-wired-lan@lists.osuosl.org>; Thu,  9 Jul 2026 15:59:39 +0000 (UTC)
X-CSE-ConnectionGUID: kx5regrdRMiytG8KYE6hvA==
X-CSE-MsgGUID: Qr1e6xI6TDqZEze6NL++Eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95671658"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="95671658"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2026 08:59:39 -0700
X-CSE-ConnectionGUID: aJOjZyFIRIS4eZj9684RzA==
X-CSE-MsgGUID: l/gfQvLHSou4XVQm3Ltjeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="279019819"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa001.fm.intel.com with ESMTP; 09 Jul 2026 08:59:37 -0700
Received: from gond.igk.intel.com (gond.igk.intel.com [10.123.220.52])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 801AF312C4;
 Thu,  9 Jul 2026 16:59:36 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu,  9 Jul 2026 16:59:04 +0200
Message-ID: <20260709145904.164375-1-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783612780; x=1815148780;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=bnDDy05kYz3XkFFSJ+rs21I3F6XQAlDJfnl4nBcLMQE=;
 b=ABhjdrEWB3x6QiclELhjufups9H50eg3vZWJzf+2chNXftQ7M5sJ2UIV
 8nwW3W6lNaFiHrS1Znflt4ookYW1Tk4+kB1bUAuB6L7F25nAm8uMaUUCT
 915akwIk+PwrirqR7NDccZuBZkzfKKal2lnGB/f/s94XyFSYvCRvPK6rq
 mvcyRAZsblR1VeyFQQYqr6Eg3d/lsAKKTU5ycjbMc5UNEzVj2S4bGtbJ5
 9eIC9H4GsXaATnGhb2BLKunvdkalwsDkulZnGb4u5UDZKfMZFxZMN25nf
 vjRilwfNR+vjC1WRgImS3J1CXKYr1jJuyf0kLFgjboOpJzqH9E4yKYjLp
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ABhjdrEW
Subject: [Intel-wired-lan] [PATCH iwl-next] ice: fix uninitialized response
 buffer in ice_acl_create_tbl()
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
Cc: netdev@vger.kernel.org, Marcin Szycik <marcin.szycik@linux.intel.com>,
 anthony.l.nguyen@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Buffer is uninitialized in error path. Move assignment before goto. This
buffer is only used for response, so its content doesn't matter.

Fixes: d80ee68614c3 ("ice: initialize ACL table")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202607022231.FWjSU75X-lkp@intel.com
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
Tony, please squash this with the offending commit. It's not applied
yet, so hash is invalid, but I don't want to resend a ~5000 line
patchset just to move one line.
---
 drivers/net/ethernet/intel/ice/ice_acl_ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c b/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
index a76762e3aa46..4ea08bd9784c 100644
--- a/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
+++ b/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
@@ -354,14 +354,14 @@ int ice_acl_create_tbl(struct ice_hw *hw, struct ice_acl_tbl_params *params)
 		return -ENOMEM;
 	}
 
+	resp_buf = &tbl_alloc.buf.resp_buf;
+
 	tbl = kzalloc_obj(*tbl);
 	if (!tbl) {
 		err = -ENOMEM;
 		goto err_dealloc_tbl;
 	}
 
-	resp_buf = &tbl_alloc.buf.resp_buf;
-
 	/* Retrieve information of the allocated table */
 	tbl->id = alloc_id;
 	tbl->first_tcam = resp_buf->ops.table.first_tcam;
-- 
2.49.0

