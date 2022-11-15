Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4848C4332F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Nov 2022 08:49:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B9D260BC8;
	Tue, 15 Nov 2022 08:49:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5B9D260BC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1668502189;
	bh=bBn5V2jplZa6Gc7dA9U/62QXYcDf1QqQ5FrMwyUv74U=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=OF7GhBOx32ql8MgT5CmZWCJF9jyO0LYE40/qFrj0dv7J7E5a3ZTYqm64p+mQN7qMF
	 14VZtukt/YhNnaF12cZj/yzuNfDMSh/tfEpHPO3EUMh+uhmpvhaB70y+09sne12dfq
	 NU8C8WMGUD8Eo8JGj1vI9OYP9JcoEf+39J2fIgTX8mb6ddUnmcUGLh8pKgZALyL8KJ
	 AAh+AQh3UDjTrkNsqkOxfYyhyJAiJ8DcigBwQb9rV1dI6GeBkKuVW1xZKAHLt28wCR
	 oLp49aKzC8fD1ngBWP5WHGc3riDdE/Rkp9qy7JDnV/fjKomkSS6hxgmSdTM3OoThdo
	 dbuejzUuwBbNw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 49qE4a377Fni; Tue, 15 Nov 2022 08:49:48 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C02260BD2;
	Tue, 15 Nov 2022 08:49:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5C02260BD2
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 4F8D71BF232
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Nov 2022 08:49:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2669D400E7
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Nov 2022 08:49:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2669D400E7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VN08r_oDJDQA for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Nov 2022 08:49:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3C2BB400D1
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3C2BB400D1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Nov 2022 08:49:45 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="313349271"
X-IronPort-AV: E=Sophos;i="5.96,165,1665471600"; d="scan'208";a="313349271"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2022 00:49:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="744507722"
X-IronPort-AV: E=Sophos;i="5.96,165,1665471600"; d="scan'208";a="744507722"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmsmga002.fm.intel.com with ESMTP; 15 Nov 2022 00:49:29 -0800
From: Kamil Maziarz <kamil.maziarz@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 15 Nov 2022 09:49:25 +0100
Message-Id: <20221115084925.2489227-1-kamil.maziarz@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1668502185; x=1700038185;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=hF9yUngWf1ruzMIzrZ7nPIRF3nJpkTZNDfq56i+BMV8=;
 b=LbKg8CM9myDUZ/QedO/qyeUtvdqyw2xD49e1m0SoXtbk2MdSw5yN2CCM
 9Bp/3OZGyW5NXNYRmuQIcIliOPAo44HOVHqTof4+HqfTASCJbLUfulbB8
 fwyboX5OWQbLVLQR+NAO+uQxN017/dWgaAuRNBMfTs/mg49EjyqyF90tz
 r2kwbyKCbxvZyRi/xxtOlXROFuOdq6mi0aBMAgTrFUrkkpmvt8A5K4lR9
 pR/L9miY6TL/1AvuoQmvDYKChZFvXAdZEUjzYfQS+Q0G3oBr6WAeleh0K
 fWIZO6OC4cN4JBXn3EzQLaT1Gm5lR2lfEdPQoU7W1D6bX7WIPK717cCvc
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=LbKg8CM9
Subject: [Intel-wired-lan] [PATCH net v3] i40e: Disallow ip4 and ip6
 l4_4_bytes
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>,
 Kamil Maziarz <kamil.maziarz@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>

Return -EOPNOTSUPP, when user requests l4_4_bytes for raw IP4 or
IP6 flow director filters. Flow director does not support filtering
on l4 bytes for PCTYPEs used by IP4 and IP6 filters.
Without this patch, user could create filters with l4_4_bytes fields,
which did not do any filtering on L4, but only on L3 fields.

Fixes: 36777d9fa24c ("i40e: check current configured input set when adding ntuple filters")
Signed-off-by: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
Signed-off-by: Kamil Maziarz  <kamil.maziarz@intel.com>
---
 v3: removed footer and added Fixes tag
---
 v2: changed author and tree
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 156e92c43780..6695dbe61a04 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -4447,11 +4447,7 @@ static int i40e_check_fdir_input_set(struct i40e_vsi *vsi,
 			return -EOPNOTSUPP;
 
 		/* First 4 bytes of L4 header */
-		if (usr_ip4_spec->l4_4_bytes == htonl(0xFFFFFFFF))
-			new_mask |= I40E_L4_SRC_MASK | I40E_L4_DST_MASK;
-		else if (!usr_ip4_spec->l4_4_bytes)
-			new_mask &= ~(I40E_L4_SRC_MASK | I40E_L4_DST_MASK);
-		else
+		if (usr_ip4_spec->l4_4_bytes)
 			return -EOPNOTSUPP;
 
 		/* Filtering on Type of Service is not supported. */
@@ -4490,11 +4486,7 @@ static int i40e_check_fdir_input_set(struct i40e_vsi *vsi,
 		else
 			return -EOPNOTSUPP;
 
-		if (usr_ip6_spec->l4_4_bytes == htonl(0xFFFFFFFF))
-			new_mask |= I40E_L4_SRC_MASK | I40E_L4_DST_MASK;
-		else if (!usr_ip6_spec->l4_4_bytes)
-			new_mask &= ~(I40E_L4_SRC_MASK | I40E_L4_DST_MASK);
-		else
+		if (usr_ip6_spec->l4_4_bytes)
 			return -EOPNOTSUPP;
 
 		/* Filtering on Traffic class is not supported. */
-- 
2.25.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
