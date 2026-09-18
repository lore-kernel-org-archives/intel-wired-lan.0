Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E01BC982DA
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Sep 2026 13:32:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3638F60E09;
	Fri, 18 Sep 2026 13:32:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GJiIeCdtZheJ; Fri, 18 Sep 2026 13:32:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 98DBA60E0C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789738377;
	b=hYZKNhxQ1YgSv2PalnUu7SuxJavJtsilWSiwKI0j9sIw+b4If4BaAS3hbJIZEwqgAEnv
	 kvfhwns8/CTqi53+7SuL3PkGf3knn1Uw6rKlyOIEn9/QeebwRV1r03gdAvJ5ipoK3LqGa
	 sp/ZvoJeJd/7muV3cXBArAkp3U6bbVMEtO6EbLyBIyNbHeNqChWUUHRe/WjbrtD6RxzO2
	 XzdK/moKB1MKOHw4EyRiPxMVhmaB83dHQ38sbCMSN3sDIrYkr/vHqOZwMqn0OhvBb4xeg
	 sA1mO8zqYyYKwcUle/5XyPtp0Y7vxpMO5Qa3Jm/pbQCbJmsRoLjZLHueBsKJuNpzI7Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789738377;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Njbgo568IMs4ztuMdWCc2efwHnIkpMPxUuFOwK0kbok=;
	b=XRt1G7CA1l8nVQXb6IfKfMQ95sGDt9EyAiGF/6YhADjn5uQbg87Bdn7hsesuO/LMW/LA
	 y5C1XsaNyx53Em6QynJNlhIu9zwqoFbb0Ff6oKwc6b5/yLkD8miXGkaSJeZhj55mrXhvi
	 QDatTLTsmhLaYZqU+h3RpdspywqzGxwHHJfcxEMx4Jz3RX6FMH/FOlun94iwaF2yUbIdx
	 Mj1tfS/dR8I1SA/ifkyuLAm3ragzCHVoUgrkZ14RviogH4ZyGFq6KTzMmo/DaKY06QrsZ
	 GaZ+RqLsRODwL64jNVhkLVX2Kq1+SSFdR5UAt5bXZiqkT4hCzyuBQkplqNnjCWfdcsw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789738377;
	bh=Njbgo568IMs4ztuMdWCc2efwHnIkpMPxUuFOwK0kbok=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uhp4qu0Oft5BcIa+QYhZ2HuFTbAOZU9dUkeyX7HiwziRnUWNHJqM8g8AW8vIOS5SR
	 I25TCkMJk0e3Xh2zAharogSghfhYCa4r9z3YaAoMuxJAwLUSneUrW6cI9+NzedpGFG
	 DU8yxlpfycCAbLtCIgpImK44GXsm/OrvTPjLf0L7WG+NHQ+WxBZ5bnmFiYRSCe5e7+
	 R7URuAcw3sGqzl+MlYCBnfN6IbKk8qrwmwDEzl+ZOAvMjkvx8WYE8aqeg+dcdZTBMP
	 mFhYAdRD6RSGflRfIbbqgGPzyygOn1B3z8bDDgA9wd0JT/4YbtMHFlc1QlDmGaVtbR
	 YJFg7vntAyDHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98DBA60E0C;
	Fri, 18 Sep 2026 13:32:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0EE54279
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:32:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 00C29810D4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:32:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GLHbD3wxXkvx for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Sep 2026 13:32:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5943C81021
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789738375;
 b=rmTrQqEPRFoGNndcRmmy3ezWOnETU8TgJ3yuOw5+uOLA0o28eGwPOlT7mVQfhODedgxP
 mFihgUJJkVvuNOu2bfldzCNOXdGQLfP/+qsLRAmVknM/ik2/oYR3u9Q3ZatKuAsfSi9Nj
 USpw27K5fgbiW7vGMEJfOU0ozHLiecEbx2tgvVhhpTr7DCJW3QYwYsT5l0PlEHZMm8JUJ
 EUbnA23rHYQXxLhL0Alho8BQ/d1Dx7E7jCd7z/kTFSRQcdsNRMKYuedf6QOcGj+5D8NTK
 Ez8HVvytzo1LHDbaunhcNkFJnY3+jYDGdSY+rfOtQQJzoOpV78Mg2Dh1o6XfwTVdg5w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789738375;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=Njbgo568IMs4ztuMdWCc2efwHnIkpMPxUuFOwK0kbok=;
 b=WMIzkKTwyVf/wwFLt1ad/a5y1kB7sXgjJqhvObaaZGtw8AuaAj3KsufR7vDbB3CRnyyF
 4LP89lVycIihcvYz/VqfG56P7E/j3HdlfRP6GdqlYxV/h5xifxYNVk0W1DRcuql44wjP7
 DGHPMNGI69BxOOAuGqK6eBJBT0MwRbIze4QTeYXea9v2kDPn/cFTVJlxKGuKWyuUuxXKd
 vJ+eFCE2KbgwNg9PiZKvKJuym/k/Zfho88Ro0DI7zjZDwtIgxvCQfY5y/7aOy09j5qDrF
 lVIEBLVqIo+l2vT1Un6sJMvgvm39HRdc43dQT/36a2Phs8LL2JsqdGHc7TkAbYyh7+Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=XI6s1W88; 
 arc=none smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=XI6s1W88
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5943C81021
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789738375; x=1821274375;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BrpjM1qFUlCr7XSqLaq155Sox0UuelYL+wjy9hCmh4A=;
 b=XI6s1W88+lMllvnw+bwmpIWvwttNh5nke65fjeZXD1iHwJOfk2zE4IdM
 f1auKRdQ29L/XSGCkbxNWlCARN8eU1LHGAdHryidGznlBp9O10c28WJbm
 IQt1lbtsgyGusY8OOh1UN11q5dv9TGtMk8/lu/2BwRVyogNqQGJT4qa3o
 hPwuiH0R5nVSdmD9Ofna3eky0gLpc8tpC9ih99ePtZoAtE9pIfRc1A89O
 6nu3veA+GBwG20mYgF+czyNpZGK3KiDcak9ymbbGHhZqaaNqr55gZy+Ac
 wjMNDE8uVjYO1AgFld5ZiNsxvHiy0XyRm1csOTk4A8n+LaeBkYFKQXCbs Q==;
X-CSE-ConnectionGUID: ekIB6EuYTN2CUCJ8nbjsLg==
X-CSE-MsgGUID: SSdwfF6TQEeF12j/oTxBdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="100840811"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="100840811"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 06:32:55 -0700
X-CSE-ConnectionGUID: JTMUIvI0T9qn6L4D7jiYzQ==
X-CSE-MsgGUID: FlDH24J7Sp+98lPDYr3kkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="270717765"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa010.fm.intel.com with ESMTP; 18 Sep 2026 06:32:53 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org, Jakub Staniszewski <jakub.staniszewski@intel.com>,
 Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-net v2] ice: fix FDB deletion
Date: Fri, 18 Sep 2026 15:32:52 +0200
Message-ID: <20260918133252.4169450-1-aleksandr.loktionov@intel.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
---
v1 -> v2: no code changes, resending to pick up Reviewed-by.
---
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 707c743..39cc622 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6160,12 +6160,12 @@ ice_fdb_del(struct ndmsg *ndm, __always_unused struct nlattr *tb[],
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

