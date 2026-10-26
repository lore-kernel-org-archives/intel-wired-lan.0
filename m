Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67411606A31B
	for <intel-wired-lan@archiver.kernel.org>; Mon, 26 Oct 2026 22:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=xxfUGO0u;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eINJxSPa
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B8EA80A95;
	Mon, 26 Oct 2026 22:37:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YHi-sYZZQL5M; Mon, 26 Oct 2026 22:37:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8E3EC80AA6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793054237;
	b=iitiiPI8k6cNGUqXwxlrZiGOBQj+AtBS8bRKG7HOVJRf9jS4wch4zj2liQzKic4tfvIV
	 7ACGkbaNVs6hzlGBen0SAtW4ZhwROHSyUMaeOg+p3FUHXvfm7WfrdmmzIJp89jaXaI+o/
	 ZS7lOPyYHa8g9Vd2Y/CM73kOB5hwTo6RucYzYjQl8jAwie0ehSgOpJ9b64bpgnmlsNtTu
	 HLT8zb6PY6E4mmTgpNsEIkXT8jPR+LrD8dhtIUPQd6lXh2UehvjzBDr7fpZFY+oZI8gUb
	 WuT6KcijQQYU2HynWtx+W3+ej3+dmqdZ2S7v54DNu1G/k2mMnDkNp86HPEDpS+Gsmug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793054237;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fET3OqgZ29gaEEzCWNOVIAJBad84Lj48tZKE+itwAT4=;
	b=X5DvxKSaJuf223KWZo1XcnBkjHWPzE2/Pp0ElxpUX3garsldQMuoP2gtyv2OpBJYP/10
	 Jn2y545cwv5mDYnqDS72adwWKS/ZEWVqh4TPqqS8qHTnYTfobLUeUEGPSe3lFz94fNn8r
	 zYxzQn9Oa6W+zW0eLmNjKtDeWAsHQb5+lJ49IcA8Cna+9O06Rjbl+3VBVn14fdDTw+wVj
	 IPHPbfvg6fpXTZrJy1s32qmTE9b99v6PXV6jeZT8sXYuIG7sjZxtEzsWtSmGPgNjpWEIb
	 OADQTq9ZffMHpv1goZyTQCQwdvgZNyplppIXs/mjLdkeV2FqQR4FMEzK5oYWkm3ldLA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793054237;
	bh=fET3OqgZ29gaEEzCWNOVIAJBad84Lj48tZKE+itwAT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xxfUGO0u6J+kvMBPQAjFyit8Py6dQO+02k4o+6iwRa05EBo/BvHn7u0THHwseUYNq
	 DduJhh9bVHrPK41V4GWgxN5rsswfb1g0m4ey2XvX1Msh30adf208S5rbmkFVeZ8g0C
	 qGLr3liClfNHgldx6pvwqOrg7Myk8IDh+yMtCyux4Tw/K4Ck9Pk1rYey0HryX0cIiG
	 vOmqnJUS9zIDYGT15runVfgSY9wKYdaEoY/klCmBDin5gE3Fg1SDDaaH4V2dq/dj/Q
	 +LlsZLu9AdDAfP9Vs55aO2NZ3kDtBHWqLDa+Xg5tldrkjh+7Q1kfLIo9+g6m+OrnXN
	 h/y4B+V0DWjuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E3EC80AA6;
	Mon, 26 Oct 2026 22:37:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 37F53235
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:37:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1D4CB40557
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:37:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fOS3FBfOqatV for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Oct 2026 22:37:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 62A4D40541
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793054235;
 b=Ig7ppEA7n0tAw/n3R0c1OpBfQlsEXw8JkKwCga79tuR6BR8ETQDL+OjPdnDNJSWXC9yN
 F5pXZhcaYo6nJKj2Jk0gmsliyloYm+nRAt+m1SRL7MK9FAkoXAKi4nb0+ekq3M+h0gCg8
 8hmPxScFrMbpa6mg7v1WJ1oso4x0aOmjLfgZx5mWXDYYyHLdcUrWxdbg/SShOixyP4BHD
 0TOgCxmPjneZpbS1LOoO7OXw+N3KjuDshZ1x6TAEtE+UuXjKoNCeeHW6fVLsdXNj9K44+
 Jg1oUeCRQtZvYrCZNivWs8vkfzu4ACbWBGGA+GJamLMjVxEJsk6skN3eAq9NMCAB8yA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793054235;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=fET3OqgZ29gaEEzCWNOVIAJBad84Lj48tZKE+itwAT4=;
 b=MTP7+LS7qomv79a0sVs7Kur/rM7m2THFHT7M9ML2LW+erBubAhYvTrFJgyZQrulFVmIJ
 LeOMUFSnL1RjvdLdD1fsDBlHZ9u+MkFqACfE3s9ms57YlssBr4vnWeYu5YrKXe9C5AYUy
 ggy+bMO37T+btsfdy6eVsz8zvip9zDobo5lkH9LoPKbUVknj+X/AF0r7ObmaIz2RNmCaA
 KUP8ZC1iTC+x81SPlNut1fYnf2Vvzj+gj7VTnSlIeC09iD++K6GkclV5UePuWGzN4T+nV
 v/ZcokNgA7OqGsVQKYffuv7Zofsz77eT29UO2yQr8QjBebK9Pqp7VVi7Ujj5DvKeZpA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=eINJxSPa; 
 arc=none smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=emil.s.tantilov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=eINJxSPa
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 62A4D40541
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793054235; x=1824590235;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mvFmjLvJAkR88BBIdXn9VlocT9H/yD92rfwg3/GRlLk=;
 b=eINJxSPaB6mSyFYW6ZdGdEzi8EzsVKPjqIacEOyNoRSx03FtgeP8pJkW
 n2oJgGF/ENz+MbuXzfYdzeEgliO+JRvF8u57fG0XHOYwhIINFDbqjX0eI
 kcIJpwK0h/JdV1NmUYNPJEf9w8w31hOokZTClFR5dbOxf6jCpistEMK7y
 qJ7lqZb80M1rTRENR7rbJg7vE3R7ar6wJ4CKafMNyfKXNR76JdznBrlCL
 VJvTrbX8eueW/0kc1vEseOHPR2vO+f3rLPHrAEjTNF8fzPdH1xbtFRrvf
 7uD2yFY9Ti/CzfGoLQPJz1zRCSeBW57iZ4B0pihc/UQeJJTS5/g5qQej/ A==;
X-CSE-ConnectionGUID: hHHzGpj9T821BZKIiY/NIA==
X-CSE-MsgGUID: Ktceu/JwS3O7+okbgJs/jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1616396"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1616396"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 15:37:13 -0700
X-CSE-ConnectionGUID: BIsY2z7DTxOdTuQGZs9UuQ==
X-CSE-MsgGUID: Xgw3zu68S7G4T9KXGHcwuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="6217170"
Received: from coyote-pass-p6-34563.jf.intel.com ([10.166.80.105])
 by fmviesa013.fm.intel.com with ESMTP; 26 Oct 2026 15:37:14 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: phani.r.burra@intel.com, larysa.zaremba@intel.com, joshua.a.hay@intel.com,
 horms@kernel.org
Subject: [PATCH iwl-net v2 1/4] idpf: fix possible race on remove during a
 reset
Date: Mon, 26 Oct 2026 15:19:05 -0700
Message-Id: <20261026221908.24690-2-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20261026221908.24690-1-emil.s.tantilov@intel.com>
References: <20261026221908.24690-1-emil.s.tantilov@intel.com>
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
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reset and remove can race, leaving NAPI registered and enabled:

modprobe idpf& sleep 1; ip link set eth0 up& rmmod idpf

  WARNING: net/core/dev.c:7699 at __netif_napi_del_locked+0x11a/0x130, CPU#30: rmmod/22393
  ...
  RIP: 0010:__netif_napi_del_locked+0x11a/0x130
  ...
  Call Trace:
  <TASK>
  free_netdev+0x110/0x2a0
  idpf_vport_dealloc+0x452/0x460 [idpf]
  idpf_deinit_task+0x51/0x70 [idpf]
  idpf_vc_core_deinit+0x32/0x170 [idpf]
  idpf_remove+0x40/0x200 [idpf]
  pci_device_remove+0x40/0xa0
  device_release_driver_internal+0x1a9/0x210
  driver_detach+0x4b/0x90
  bus_remove_driver+0x70/0x100
  pci_unregister_driver+0x2e/0xb0
  __do_sys_delete_module.constprop.0+0x190/0x2e0
  do_syscall_64+0xc8/0x6b0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x7fe628130beb

Make sure to call idpf_vport_stop() in idpf_stop(), irrespective of the
IDPF_REMOVE_IN_PROG state, to allow a reset racing with remove to tear
down NAPI in idpf_detach_and_close(), which runs under RTNL lock.

IDPF_VPORT_UP is modified under RTNL as idpf_vport_stop() and
idpf_up_complete() either take the lock themselves or are reached from
callbacks that do. Move the test inside the RTNL section so the test and
the teardown are atomic with respect to a racing close, and assert the
lock is held to keep the invariant documented and enforced.

Fixes: 2e281e1155fc ("idpf: detach and close netdevs while handling a reset")
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 2130bbef0c174..791ebff985072 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1005,12 +1005,14 @@ static void idpf_vport_stop(struct idpf_vport *vport, bool rtnl)
 	struct idpf_queue_id_reg_info *chunks;
 	u32 vport_id = vport->vport_id;
 
-	if (!test_bit(IDPF_VPORT_UP, np->state))
-		return;
-
 	if (rtnl)
 		rtnl_lock();
 
+	/* IDPF_VPORT_UP should only be changed under RTNL */
+	ASSERT_RTNL();
+	if (!test_bit(IDPF_VPORT_UP, np->state))
+		goto unlock;
+
 	netif_carrier_off(vport->netdev);
 	netif_tx_disable(vport->netdev);
 
@@ -1036,6 +1038,7 @@ static void idpf_vport_stop(struct idpf_vport *vport, bool rtnl)
 	idpf_vport_intr_rel(rsrc);
 	clear_bit(IDPF_VPORT_UP, np->state);
 
+unlock:
 	if (rtnl)
 		rtnl_unlock();
 }
@@ -1052,12 +1055,8 @@ static void idpf_vport_stop(struct idpf_vport *vport, bool rtnl)
  */
 static int idpf_stop(struct net_device *netdev)
 {
-	struct idpf_netdev_priv *np = netdev_priv(netdev);
 	struct idpf_vport *vport;
 
-	if (test_bit(IDPF_REMOVE_IN_PROG, np->adapter->flags))
-		return 0;
-
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
 
-- 
2.37.3

