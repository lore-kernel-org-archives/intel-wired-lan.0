Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D374D58E7D
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Mar 2026 09:03:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E7ED440BDB;
	Mon,  2 Mar 2026 09:03:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GDQTtji_rtee; Mon,  2 Mar 2026 09:03:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2598840BCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772442196;
	bh=DELX92T88GE5kIZVDFotxEQOX/8OGO76PjFYvuf6FaM=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=w9CYRDAfcg+peKNMFM5xmmcLro6c57AxS9xJxag/g5KziIrlJyIr13YemhZtm9l27
	 kf5APvLDsOTJRAMgVMUnjNkWQc+AlRdTnRCbrf76ZItIuryvbJPEJ9FWCocb8cwWbV
	 QSBLl2UPnEFnevH3E2C3XFDvsE3Zb2Moq2uBbomVeJGPgGriGgHH1OXvyBp5WNIp+n
	 C01cxNkrcQlASg20MX5oGuxsFTOt8Geesm2A8yKBos0XJjQOwYT5BSF7+kippu57B1
	 ZTCs0AMQUjNSATnQBPw3gbLwgcvEP/jdOP9WNB78Mtrjwm7RIziaBFaDmdWQLOw130
	 kRX0nmf/PZfeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2598840BCC;
	Mon,  2 Mar 2026 09:03:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 801FE231
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Mar 2026 09:03:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 64BD660F42
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Mar 2026 09:03:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v8j_wLKj_L5s for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Mar 2026 09:03:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E9F6660F26
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E9F6660F26
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E9F6660F26
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Mar 2026 09:03:12 +0000 (UTC)
X-CSE-ConnectionGUID: nDTnyOh+QqCGOkieyiJWug==
X-CSE-MsgGUID: 4LvqBXVjSvWL+QhOfSEtug==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="73555656"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; d="scan'208";a="73555656"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 01:03:12 -0800
X-CSE-ConnectionGUID: N2d4dtcCSnuGVyy6n//y6g==
X-CSE-MsgGUID: GH8A692CSNqesEH/CbG2HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; d="scan'208";a="221741553"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa003.jf.intel.com with ESMTP; 02 Mar 2026 01:03:09 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
 id D053895; Mon, 02 Mar 2026 10:03:07 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Date: Mon,  2 Mar 2026 10:03:05 +0100
Message-ID: <20260302090305.2193349-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772442193; x=1803978193;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=tjwDfVUOCv7OweMTrTAC/NmQxTm0fJ23jK+CFiLTyI4=;
 b=j1Rk+QSew/ohw0u8l2U5lJUdEO7xG/urlKpL3tWDiHgjvgD81o8ROhvn
 py1XbstSCHQuplHFbu30saCE0bj/Jn56CsXBfPSDcKnFAq3gFvtog/Oku
 m2iWvYq1Y5tn01Rg/5vM5b7h6pS6MW7/aCDIYU0UAkLue6BkqyCqnJsNY
 C9VCdD+3rt4UkXX0T9+nwAzv0ACJMBnJWUutr5MoJx4WqvFkAM+do1F3s
 /76erctkVPi4EfDGI3GlJQ/4HlCAWlzcg/OVO5Xcjk1KnuT9ZuYLvE6TP
 OuNv7/QUR+mF2n9Wrk9ULxv5p6g4QYXSSHlFf2n6zWXKYMFP4WTDfTg4i
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=j1Rk+QSe
Subject: [Intel-wired-lan] [PATCH net-next v1 1/1] i40e: Add missing header
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

When cleaning up another header I have met this build error:

drivers/net/ethernet/intel/i40e/i40e_hmc.h:105:22: error: implicit declaration of function 'upper_32_bits' [-Wimplicit-function-declaration]
  105 |         val1 = (u32)(upper_32_bits(pa));                                \

This is due to missing header, add it to fix the possible issue.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_hmc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_hmc.h b/drivers/net/ethernet/intel/i40e/i40e_hmc.h
index 480e3a883cc7..967711405919 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_hmc.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_hmc.h
@@ -4,6 +4,8 @@
 #ifndef _I40E_HMC_H_
 #define _I40E_HMC_H_
 
+#include <linux/wordpart.h>
+
 #include "i40e_alloc.h"
 #include "i40e_io.h"
 #include "i40e_register.h"
-- 
2.50.1

