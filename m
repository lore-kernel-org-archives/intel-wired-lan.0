Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396E6606A31B
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Nov 2026 00:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=UGJvCqOT;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FzQ4X5N8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0133880D87;
	Wed,  4 Nov 2026 00:12:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 57XkZLQ9uTev; Wed,  4 Nov 2026 00:12:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7669E80D81
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793751140;
	b=swbXl3tpc6zLgeZp2xV+re854LKDdI49Pis++/eWRNroYS6NvgFduIKJV7p7zmnYvprY
	 n9D2YAAOzg1cjmKUTaRD7vAhr3mYAufIWvz2oPq1ICrcqbH4rMvaxUnR5AuDY90jDJ+hX
	 llJloqQKude7PMoVkY56iJGVQBxxPdVuz6sS8bEf+Dg0P76cH4APdo15lO62CLMgNvDt/
	 eMg+p7Y2C3X/UpGcA3CLB+sYb+rkuR5MP92LkJ0Aq4H41RxrW2a/CCaXQjrXSa+T/GwSM
	 hf3/ZE4UuBHyBMP9YefKsJyA1qC4Azrvr+w2QDpDJBs0tpEkLvHXvrqYkhNrJTcrZxQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793751140;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xYV7BioCbB23gsP74vrLy4PRSpHWzwKUT/pMrV/LAUw=;
	b=flL1Q4n2g0neJBO9kaaxjlPB3EQv3kZhMIB2a9QKsvbDkOe4OpMixRnrzf8lSIRtfxar
	 TTZuAgmRzt3ddM5ws3tVIiK4amOmlHUDkw8HJeeLSoq95diT6emtOr0JISPJRw3uEoabR
	 dAvjrWlXhMfsUBHGITw1IDosr0xWTx0aDhxdsbfTXIKaiJFwvqlQ/3JD5xZYC0lhv9/dN
	 TRMLcrlmgwmefBy0QitVrHptYoCBri7N5/131kbyMKFu9TZth6oRTt6n6Qf5T3HnJic/s
	 uBvrLWojhpzTlTLisdSu4GlOVoAyEUcIqEKuT/8oKnHdSjeIuIpJm9Xw6PXKlxLYh6A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793751140;
	bh=xYV7BioCbB23gsP74vrLy4PRSpHWzwKUT/pMrV/LAUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UGJvCqOTljVA5pbLb2rSpV3HytOg+KY5vv+BcQL2uG7yvoCJQRpaRq5joRoJkQ8TW
	 mXtzQSOw/e2QrGueVvGjHLGWKbT9pijdU6dPx3UhD6HVhe7BUtsKrdgz92nL/2tO6y
	 RZ94/P7TwHUTjRMV5lhRZmUjXMgicJSG9uVQxc8eFfBjr0NgfZeHujfov7O8uVXwYV
	 D3ww9Dl1l8uQ6f9kniMRlTDyW3aCbHg99bBAoMycUP6YerjYh4qr6cnvocg0P2PY6H
	 NWfeiAEGoLB3B/lED/SfjH4c7PtYApgBXQDm700mCFYmHVbPyM6ZstSFSgdfN8Qbeq
	 EJA0846PHFSnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7669E80D81;
	Wed,  4 Nov 2026 00:12:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 83D0FA14
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 00:12:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 694ED400D2
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 00:12:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hAKNU7n958yz for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Nov 2026 00:12:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 37E0040048
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793751138;
 b=k1bIc+HcSbOqSp4TPnQZA0d1PrNdL8Nf/QR4IbIm1nr7pAtcz5S163ccI63I5F4p21hu
 gEdhXQMDEjQLUFLCTUycCQZaMY8J/AwrmrmQkFPbTtA94oki+Ymz6A53qQEXXWw5Y/MW5
 55LOsvXy5hGii/WwoTa9BNuQ0pcIlvlqkdYpXy53EuaGacpAwIclX7Xdnc5yoORZsXlcU
 8j2NCpMPxdCMjPaGdBIP2+XY2AKAMBvI97KW2SL/6kSIZRqY9bgjpKYAdQQ3sdoHh5t3Z
 /go7y8pe7q3PUwnbWvIsEm/UqVbBeEVRvbugHrEmNELZZEYX+R52IUDq2R0HQL+bCEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793751138;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=xYV7BioCbB23gsP74vrLy4PRSpHWzwKUT/pMrV/LAUw=;
 b=a2B5QaHBWCEZn+c+kqwuzndc8RWQzlNIwoYkdOQS8axe3GnEvpX/BUtH8t1hcUfnHDS8
 q8pGN0kGqVIVmY3x8Fsp1R/2y42Mq4l+YKLa7hxmqnnMsSFL9AJQAdHSPfk3DDZpk1Ozw
 rmUsjdOU81OaFgcsDNyihnLz+6Kf10QQQONKgzV4SKJn9/Q5Z0aYgKF50jlkAJgxSNjeY
 5pS6KYMA0vh1v+z9l7R7/ZBIVf0bZK6E2rCe7uMXiUIN/hnUUYrg2BycqSzfcQW0+9frr
 S+X9DDuffIUye2R788kVBEWZa4EoRpF2Jan8C7giLRMct7GnasB9JS3ItShQMBXvPyQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=FzQ4X5N8; 
 arc=none smtp.remote-ip=198.175.65.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=emil.s.tantilov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=FzQ4X5N8
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 37E0040048
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 00:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793751138; x=1825287138;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=T2VhqlpUyE6RYV8QmtmPWsSvWYsuvJNKvN1pNkUfKjc=;
 b=FzQ4X5N86WhuzWbYpRRmKj9PA3syXD1NOka3q0HqK3e94y6gpxCbwm4j
 VfCdkupP7XsR3MkUbREP7pXCBXMQRY+uFjgfXm+6p2A1DBNQiOxGxty4a
 5lWqz92s0OZPJsNBQGfbWQsUkbXjO0V6paRsg2EpDRwGQxYlvICqwzE/F
 IjjPERkkphgXplOkZAKti3qeUdnV9Dq8PwMOZNNPFyy7cbskoDaz53tnC
 fcGc51VeTT9tUGW8hyJRMpysMcBc4YxwLxlp1YHkTwNMDruXlCWSloooL
 nmCPHRPkhLdc2k2Z+6pI3DyLJ839jV4GBJai5xmuZ11H02npnqgSBK8Yn Q==;
X-CSE-ConnectionGUID: 4imEVB41RKGj6986lfQW6w==
X-CSE-MsgGUID: QT65gG3TRfKw4Bz+G5XOzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2522931"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2522931"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 16:12:15 -0800
X-CSE-ConnectionGUID: JxzD16XMTtygTN7Kim4OyA==
X-CSE-MsgGUID: 6eucz1/CSg+ZP7t+HNB6OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6904714"
Received: from coyote-pass-p6-34563.jf.intel.com ([10.166.80.105])
 by fmviesa001.fm.intel.com with ESMTP; 03 Nov 2026 16:12:15 -0800
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: phani.r.burra@intel.com, larysa.zaremba@intel.com, joshua.a.hay@intel.com,
 horms@kernel.org, brianvv@google.com, decot@google.com
Subject: [PATCH iwl-net v3 1/2] idpf: fix possible race on remove during a
 reset
Date: Tue,  3 Nov 2026 15:53:53 -0800
Message-Id: <20261103235354.1063721-2-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20261103235354.1063721-1-emil.s.tantilov@intel.com>
References: <20261103235354.1063721-1-emil.s.tantilov@intel.com>
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
index 2130bbef0c17..791ebff98507 100644
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

