Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA56BCA601E
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 20:45:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E0C74094D;
	Fri,  9 Oct 2026 20:45:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1fNn6Qyf97y6; Fri,  9 Oct 2026 20:45:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2A4A740931
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791578742;
	b=Gqx4/9iCBvS+yGK4T+zgXlhSLT/oBjELEFf7r08+zxiFxEk0WEm/9C89YQQ5NCYVVPqR
	 6e3vqE9gpYhZND/fc5GloWB12/xadGAb3ssSGfNyHpznKLZK6x6AqRBB9MQferXEfvnkY
	 NF44HNQm07MiONf3gGm7c3xflhSzRYiWYlqpWNHiRBdNkSv021WbSo+sc+fFoQzqAKmlB
	 RmIfp9WXXyr1an782ZuYhF1cogsLzNn7y1bsw0jp2ONNc/YQ76ZmttjMxJX+pMx9lIDrx
	 gRMEAZ/2TQ71/5sSmWWs0QRprSxcB96xkMA8K8V6e9m1C8FyUrS6UIGd70kvYQIrabg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791578742;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IPAS-Result:
	 IronPort-Data:IronPort-HdrOrdr:X-Talos-CUID:X-Talos-MUID:
	 X-IronPort-Anti-Spam-Filtered:X-IronPort-AV:Received:Received:From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Outbound-Client-TLS:
	 X-Outbound-SMTP-Client:X-Outbound-Node:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MFj/mOELH4XfYRBDkKtBQzj+Kmx/9lRFQz4MOlN9PAc=;
	b=lawgWkH3hgGu3jhCP+AvjVJftl+y+yDj+zxvNov8iZAPaBXKybHUXy2zsRlWVMvbW+4v
	 xsP0mI+HAPTXpOSVrSfr+VEHRD2keF5PUBryk59388gg5iM6NF3V9hHV9YZ+Z7wi1ABvZ
	 DI+Z66YPkHV6MjCVu589doanujRPJM4l7CjINopi6k5GhwrAl/YdpM0W3TNxgIR004MQM
	 s0aoZQbPUnqsOILlLrGtG87ghERvhQpVwzl6R1WP6uiYp4kwAPLQuvK4V6Ewny44aRuBx
	 W7xENs6ZUFBrdfOq0tEJdw1JEbFEy3Ap7JJTc2/I5gMBvJy07S0PEQF3kXNzF6SN0Uw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791578742;
	bh=MFj/mOELH4XfYRBDkKtBQzj+Kmx/9lRFQz4MOlN9PAc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=6DcFTsCpgmjYk+xTU9n9YOcfYnA/0L5gGMTHwwK90fUS8pB9V2DGJ0HkziX8PN93P
	 kgIFagWz9pkOQScpC57TxJ4FK0Ic2xZsiWI4vzMPTFms/1DdF6W89ubKxgz+LLOiDL
	 TUagYNwX5v3G7pbWZJx2+ZssYIbmXbo8u9nBj6wSoeV7g4+0vPN5+R3BassO+v5SEo
	 44JkdeHQD9GM2r2HdrfgAMC3X5n9fCWL8mK25I/k3cJKoW+oF/toE5mCGYq2igYjMH
	 RJ+27LviKto2AwrFNDvyEIsXN5A0QKpS33zAzW6yaUz4cwbMV3DhzV7X7WnkS1Sioh
	 Z0dF164qHuihg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A4A740931;
	Fri,  9 Oct 2026 20:45:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 74FF875
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 20:45:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 66F7981460
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 20:45:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gHvLuBgERB4d for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 20:45:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9C72780DAF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=173.38.203.69
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791578713;
 b=pT9bcHxOqnZx+9Edgg/Ece11cQ96uCu9jpulcJe6kbftsQ86LtzXJOoIQyuDiw40+kdD
 le7IEAQ8zkyrN9S+OA4x+CiaBMmd2yOeaccTi0/KJNrgdnRYIRC/FQimeOfOXdhLwRKwC
 YHyzLBbEY8TvvGbpDu8+DGsHSVrDwA8FC+Qq9QCMde3WfKO1sIgqkBiSDJ70Qed3LWnAg
 ztgpPbSLmbkWvqsZ8TUu27tvrB8T2Whollrfz+skYg2c1TAktsXkQnutnVPcnhmOxzkFo
 NhXb4WJyYZJOoO98MRIWKVHqpHTL30geex/oYdtYNlHholt98OrUhkPxGgT5I3YKJFg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791578713;
 h=X-Greylist:Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-IPAS-Result:IronPort-Data:IronPort-HdrOrdr:
 X-Talos-CUID:X-Talos-MUID:X-IronPort-Anti-Spam-Filtered:X-IronPort-AV:
 Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 MIME-Version:Content-Transfer-Encoding:X-Outbound-Client-TLS:
 X-Outbound-SMTP-Client:X-Outbound-Node;
 bh=MFj/mOELH4XfYRBDkKtBQzj+Kmx/9lRFQz4MOlN9PAc=;
 b=Zt3kyBbYEi3qFZ2HtxlPNeqGvO5m8GNtB4M4rzV3C2Y9T6W7EE9zVRAzvQYE6BezseX9
 4+ubowwCO4RO692QLKO5BTtm3FnZkbGpCVUo7tdykUywnXsbmRXX0shZ1m+n9w92zRPMJ
 5lDCE57/tEhD6inRiMO+vE189YZBIzJXsKl8AEp+1SiyHoVjZFnkIajvpf1jDlf25aK8x
 8+Qa1zkLwD/Y07xtooSNY7zi+LpvdRWelAoozMcc/jTwq6uk0ryH+pY5DBpWZD0z8cRtr
 tupUKR7PXMmwGuMSocNgNIBf8miLJ3F4xpHjAbMq3nrCh2UbDdP+0Qa6sib+h5lL9Dg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=cisco.com;
 dkim=pass header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256
 header.s=iport01 header.b=HujGnuaV; 
 arc=none smtp.remote-ip=173.38.203.69
X-Greylist: delayed 65 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 09 Oct 2026 20:45:11 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256
 header.s=iport01 header.b=HujGnuaV
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=173.38.203.69;
 helo=aer-iport-7.cisco.com; envelope-from=adiyenga@cisco.com;
 receiver=<UNKNOWN> 
Received: from aer-iport-7.cisco.com (aer-iport-7.cisco.com [173.38.203.69])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9C72780DAF
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 20:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=1415; q=dns/txt;
 s=iport01; t=1791578712; x=1792788312;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=MFj/mOELH4XfYRBDkKtBQzj+Kmx/9lRFQz4MOlN9PAc=;
 b=HujGnuaV3ZpazUDywKUmgt8h1xJ+t5GjoX/1sD9/SZu8kXsInSYzrcii
 cV+P1vELF3I4STnTIuUdXQ7UIWSiaxYdanOf1FUva+Hm11z/6rXt//yrL
 7mvgq5U4HNjf2Dni9TJ1RROe39e0JaDqXAyJ3MUujc1k7RCaQic43Uquu
 bjao2Xo6OLCP8Pf0u92hCH7K1Pw8ikS+WF8vRDz/PjSaB8KgO6pfCZkdQ
 Dih17T1qUqJVstNnaX1bVaRCC+pRoA24GYvg3YYvh2wGujXS6HUeyq1pg
 exAJKfo/VTYQmFkAoevF52qBynahYN07mv2ngHXYSzK957S79crcMNB/q A==;
X-CSE-ConnectionGUID: nZFgwp0WRs+HGQ2CBEhcGA==
X-CSE-MsgGUID: 97234tCDSk2KI6OzfUjZFg==
X-IPAS-Result: =?us-ascii?q?A0DAAgCuUclq/9RK/pBaHgEBCxIMggULgleBVkJJlkqeH?=
 =?us-ascii?q?RSBag8BAQEPUQQBAYUFjhQCJjUIDgECBAMCAwEBAQEBAQEBAQEBAQoBAQUBA?=
 =?us-ascii?q?QECAQcFgQ4ThlyQFSsLAUaBSAiDAoJ1A7w+gXkzgQHeSIFoAQsUAYE4jWOFc?=
 =?us-ascii?q?icVBn2BEIQPb4QFGgtmhXgEgiKBDIJdky5IgR4DWSwBVRMNCgsHBYFmAzUSK?=
 =?us-ascii?q?hVuMh2BIz4XgQcbBgWBHYEgghYjGTZ6gQlegSspYAEQF4EJggcCglSCAAIBS?=
 =?us-ascii?q?UEOB0VTCSVDEkcmIggSCQETGjALgRs4PAkoQRcMdAwKGA1IESw3FRkEPm4Hk?=
 =?us-ascii?q?Qkegh5DewkKlgaSRYE4n1qEKKFcGjOqb5kIpFqEaYFpATqBWU0jFTuCZ1MZD?=
 =?us-ascii?q?44uFtABPDU/BwIHDwKSBIFtAQE?=
IronPort-Data: A9a23:Dm+inK6tmuEaOb8yNfNvvQxRtCbGchMFZxGqfqrLsTDasY5as4F+v
 mFKXG7SOviKYTSmettwOY+yoxhTvpbTn4cwHQNlpSowZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyGa+1H1dOex9RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wo/KUzBHf/g2QqazpMuvrZwP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4eO7829flvWV507
 r84BwlXRTquh+mZ6efuIgVsrpxLwMjDNY4F/3UlxjbDALN/GNbIQr7B4plT2zJYasJmRKqCI
 ZBENXwwMFKaOkcn1lQ/UPrSmM+hinjufjtXoXqepLE85C7YywkZPL3FboOEIIHSHZw9ckCw9
 z2cpDjlKT0hN4a86GSi4HyRhN3hknauMG4VPPjinhJwu3WawHATDxsHE1/9p/akm0O4c9NZN
 0EQvCEpqMAa7Fa5Q9zsRBmxvziHvwIHSddUO+w89AyJjKHT5m6xB24YQzoEd908ucNzQTUs/
 luIhM/yQzt0rbqOTTSa7Lj8hTW/JSQYM0ccaiIeCwgI+d/upMc0lB2nczp4OKe4lJjxXDr32
 T3P9XF4jLQIhslN3KK+lbzavw+RSlHyZlZdzm3qsqiNt2uVuKbNi1SU1GXm
IronPort-HdrOrdr: A9a23:jApRcqFZiK8YwZtLpLqE3MeALOsnbusQ8zAXPo5KJSC9Ffbo9f
 xG88506faZslwssRIb6LO90de7IE80nKQdieIs1NyZMzUO1lHEEGgb1+vf6gylPTHi/ehA0q
 olWa1/BNrsSWVet6/BkWyF+xJK+qjhzEhu7t2uq0tQcQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AcIi6eGiP6dPFKHCbtQ+OcoayozJudE/zw2jIe3C?=
 =?us-ascii?q?CEiVJZ4TPYnW9+KhLup87?=
X-Talos-MUID: 9a23:FLvLLQYNcy2H4eBT5mC2321+H+tT4P6NKR4qg5s7ufuqOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,149,1787011200"; d="scan'208";a="61925001"
Received: from aer-l-core-11.cisco.com ([144.254.74.212])
 by aer-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 09 Oct 2026 20:43:54 +0000
Received: from bgl-ads-6462.cisco.com (bgl-ads-6462.cisco.com [173.39.34.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by aer-l-core-11.cisco.com (Postfix) with ESMTPS id CFCA4180001C9;
 Fri,  9 Oct 2026 20:43:52 +0000 (GMT)
From: Aadityarangan Shridhar Iyengar <adiyenga@cisco.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 netdev@vger.kernel.org, adiyenga@cisco.com
Subject: [PATCH net-next] ixgbevf: Warn when mailbox API negotiation fails
Date: Sat, 10 Oct 2026 02:13:46 +0530
Message-Id: <20261009204346.11223-1-adiyenga@cisco.com>
X-Mailer: git-send-email 2.35.6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-Client-TLS: ANONYMOUS; bgl-ads-6462.cisco.com [173.39.34.78];
 TLSv1.3; TLS_AES_256_GCM_SHA384; 256
X-Outbound-SMTP-Client: 173.39.34.78, bgl-ads-6462.cisco.com
X-Outbound-Node: aer-l-core-11.cisco.com
X-Mailman-Approved-At: Fri, 09 Oct 2026 20:45:40 +0000
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

ixgbevf_negotiate_api() tries supported mailbox API versions from newest
to oldest. If all attempts fail, it continues without reporting the
failure, leaving the API version at its reset default. This makes mailbox
communication failures difficult to diagnose.

Warn when the version list is exhausted and include the error from the
final attempt. Do not warn about individual failed attempts, since a PF
rejecting a newer version before accepting an older one is expected.

This is a diagnostic improvement only; negotiation, fallback and recovery
behavior remain unchanged.

This is a diagnostic improvement only.

Signed-off-by: Aadityarangan Shridhar Iyengar <adiyenga@cisco.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 7ce46b4b4821..76c9ac3ac69a 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -2344,6 +2344,10 @@ static void ixgbevf_negotiate_api(struct ixgbevf_adapter *adapter)
 		idx++;
 	}
 
+	if (api[idx] == ixgbe_mbox_api_unknown)
+		netdev_warn(adapter->netdev,
+			    "Mailbox API negotiation with PF failed: %d\n", err);
+
 	ixgbevf_set_features(adapter);
 
 	if (adapter->pf_features & IXGBEVF_PF_SUP_ESX_MBX) {
-- 
2.35.6

