Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0B6C44511
	for <intel-wired-lan@archiver.kernel.org>; Thu, 16 Jul 2026 16:08:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 406F9608E7;
	Thu, 16 Jul 2026 16:08:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J_Qke287pRPC; Thu, 16 Jul 2026 16:08:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 72F63608B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784218090;
	bh=YququUgbdI7gwVNs7i7179IVeRHZuzDb123mlIh3OX8=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=US7JqSaYDDIp4huFS1dLyWxD15xs6UAKl+lHRMoEv9+lHjP2qnFj/H5UfnP60zzHw
	 +1N+ECfROdDGfEcmJGCSMf5BCNUAfVotT7+5W4B7RyngHMSmHWnHfnMhmpkVoMddDZ
	 9zeLiuiAJcgenqF0P4hRJmfdLhUg8CwvWuU5O8DrMUQk4jEMAGd1HblfXkCQAAjOVp
	 DuG4jUFA6O6YCaFRSdgoWh/spjreJrV/NmtFq/w5Z3hgkSAPvpveX+SR2h7d/aZtJt
	 E5E/Dmyqc/LMY8oFavPUzCOqu3+Km0Sgsg+UK9D7tYwc/wQlJKQ9lNqCnh6IQ3s7ZT
	 EXDvTnx1AkEeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72F63608B4;
	Thu, 16 Jul 2026 16:08:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 98C9F426
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 03:04:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8041F80DFF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 03:04:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DonFwoCRyQw9 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 16 Jul 2026 03:04:32 +0000 (UTC)
X-Greylist: delayed 778 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 16 Jul 2026 03:04:31 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0178380DF0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0178380DF0
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.3;
 helo=m16.mail.163.com; envelope-from=xiongwm2026@163.com; receiver=<UNKNOWN> 
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0178380DF0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 03:04:31 +0000 (UTC)
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
 by gzsmtp1 (Coremail) with SMTP id PCgvCgCnj5oPR1hqcsnBGQ--.45933S2;
 Thu, 16 Jul 2026 10:50:57 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Weimin Xiong <xiongwm2026@163.com>
Date: Thu, 16 Jul 2026 10:51:00 +0800
Message-ID: <20260716025100.118145-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PCgvCgCnj5oPR1hqcsnBGQ--.45933S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr4xuFy3Wr43ZFykGw48Zwb_yoWDZFg_uw
 4xXr4kGFWUKr4rGa1SkFyxuryFkryvqr95Z3yfW39xZ3WUArs7Ga4kXryfZr42g348CF98
 ArnxAFW2k3y5KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_0tC3UUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbC8BGGFmpYRxFyPgAA3Z
X-Mailman-Approved-At: Thu, 16 Jul 2026 16:08:08 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=163.com; 
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Yq
 uquUgbdI7gwVNs7i7179IVeRHZuzDb123mlIh3OX8=; b=EHGna4kzKWvw5CIaJf
 nvJzd8xaxDU0WR+zz+QU0IJkIqSi97+nPX03UrUsglBkjA7a9uk1YAf23hxZo2HP
 xLxqcm7qU/NEPEkwy3NTsgTcvY/vo6Wp8ttg3jmgxRiSMob66kq5mnu4GPXYCYN2
 CT0WXsEz5tqUVEncMmOXt9KxE=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=163.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=163.com header.i=@163.com
 header.a=rsa-sha256 header.s=s110527 header.b=EHGna4kz
Subject: [Intel-wired-lan] [PATCH] ice: parser: use array_size() for table
 allocation
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

Use array_size() when calculating the parser table allocation size so an
overflow in the firmware-provided item dimensions is detected before
allocation. Include the overflow helpers explicitly instead of relying on
an indirect include.

Signed-off-by: Weimin Xiong <xiongwm2026@163.com>
---
diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
index f8e69630f..c109d3c32 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.c
+++ b/drivers/net/ethernet/intel/ice/ice_parser.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2024 Intel Corporation */
 
+#include <linux/overflow.h>
+
 #include "ice_common.h"
 
 struct ice_pkg_sect_hdr {
@@ -102,7 +104,7 @@ ice_parser_create_table(struct ice_hw *hw, u32 sect_type,
 	if (!seg)
 		return ERR_PTR(-EINVAL);
 
-	table = kzalloc(item_size * length, GFP_KERNEL);
+	table = kzalloc(array_size(item_size, length), GFP_KERNEL);
 	if (!table)
 		return ERR_PTR(-ENOMEM);
 

