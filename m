Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A4EFCE08C
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Feb 2026 14:40:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 034588461C;
	Thu, 26 Feb 2026 14:40:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kfvU9wP2CAGf; Thu, 26 Feb 2026 14:40:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6D90984620
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772116844;
	bh=6Y0wu0m2S+xmvajj4wnruotNKsfdEgel5Qle4IIau5c=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hjRVzBGsprkyKblD6Uj+oWlpfYRpKpr3mWDGOuaQdSQEVZbpFtaM7nfkKLJS5U789
	 ZUrYKikKg7h9DL3U1KVtOYYNZ3blTSerjKrSdJ4/ELafw+gXpPQIm4pI/qbdABFXPQ
	 ZBKha2JilgYI3Z808ygdTOyhQvvknyD1afvKHQ2+A2ViZfkgv60jqOZQPEm+NZ21q7
	 YbibXUwfnmTduougmnk3SjMV8oTjs+ARW5JS5W+M58NeLdJogmTH1AuvT01qGbntTR
	 VKO2xJxC0xeW6flq2myM98ZbCvRRP6KOoKYjY6cPpHGOz9YqAr1MV3vlKrdEK2R7DL
	 XY0/gQh038oCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D90984620;
	Thu, 26 Feb 2026 14:40:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 13F9324E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Feb 2026 14:40:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 05A4E844E3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Feb 2026 14:40:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ybbcONFJDO43 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Feb 2026 14:40:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0FF048446D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0FF048446D
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0FF048446D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Feb 2026 14:40:41 +0000 (UTC)
X-CSE-ConnectionGUID: FRwcdvdxREmZif6aIROdhA==
X-CSE-MsgGUID: VZNZQvceQi+6QTkG/ZyowA==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="76784553"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="76784553"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 06:40:42 -0800
X-CSE-ConnectionGUID: luwEjM4mTsypoBisDCqIQA==
X-CSE-MsgGUID: lLHXtRN8TSOl5auMnhd5YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="254353837"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa001.jf.intel.com with ESMTP; 26 Feb 2026 06:40:41 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, aleksandr.loktionov@intel.com
Date: Thu, 26 Feb 2026 15:40:36 +0100
Message-ID: <20260226144037.400815-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260226144037.400815-1-aleksandr.loktionov@intel.com>
References: <20260226144037.400815-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772116842; x=1803652842;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=t0chq214HkHrpgpq/8q/aGOsHgiMN8Wk/jEfJVeixCU=;
 b=mPKhaFIycq+sweakqCAzRrzTT1gJ1fB3UI7X9kANITRfBB350uIKqKpY
 0xfgImm4RHvy/rWsAwny4GIZYIbVmDBYStwdKGYC4B6lY2v8hQBHd18n7
 gmFRPq8myXQcoHckq4s9iNE2ig48k56r3LXnQrx3iIInQ+eSiC9q2IX79
 y6NUmwp0zprXtw2FThT7735UKbbMWbB7Hu9/mz/sCmbw3bNSdbcITSQIh
 w+UBBc1zdEJmNk4O/3zFoNXDxwmpah6XGS889nK12733FBT9wrjdL1Ns3
 a1gqtrDtdFJaCSIKY1/CFJjqdAHLq/iMN9+bMnfBUeRiS9uGL9EBX9Y9p
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=mPKhaFIy
Subject: [Intel-wired-lan] [PATCH iwl-next v4 1/2] ethtool: treat
 RXH_GTP_TEID as intrinsically symmetric
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

A GTP tunnel uses the same TEID value in both directions of a flow;
including TEID in the hash input does not break src/dst symmetry.

ethtool_rxfh_config_is_sym() currently rejects any hash field bitmap
that contains bits outside the four paired L3/L4 fields.  This causes
drivers that hash GTP flows on TEID to fail the kernel's preflight
validation in ethtool_check_flow_types(), making it impossible for
those drivers to support symmetric-xor transforms at all.

Strip RXH_GTP_TEID from the bitmap before the paired-field check so
that drivers may honestly report TEID hashing without blocking the
configuration of symmetric transforms.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 net/ethtool/common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 5fae329..9a3fd76 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -911,6 +911,9 @@ int ethtool_rxfh_config_is_sym(u64 rxfh)
 {
 	bool sym;
 
+	/* Strip TEID before checking - it carries no src/dst asymmetry */
+	rxfh &= ~(u64)RXH_GTP_TEID;
+
 	sym = rxfh == (rxfh & (RXH_IP_SRC | RXH_IP_DST |
 			       RXH_L4_B_0_1 | RXH_L4_B_2_3));
 	sym &= !!(rxfh & RXH_IP_SRC)   == !!(rxfh & RXH_IP_DST);
-- 
2.52.0

