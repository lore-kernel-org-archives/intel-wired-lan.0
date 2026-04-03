Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9D0D730A2
	for <intel-wired-lan@archiver.kernel.org>; Fri,  3 Apr 2026 05:40:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B0ABA40F33;
	Fri,  3 Apr 2026 05:40:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E5qG_s-Dto28; Fri,  3 Apr 2026 05:40:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E2FC040E83
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775194849;
	bh=HYfOhaScBI57s8uF+aOnVVxrGbvnYvmxP+1j5VoWcbM=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QxUZc9aLoiAmKC5bFsSKF5DQbpXicQuSreFIRotDjSqa47VNVtwN2Nui/Ebk8xaVU
	 PZpf1ilifSuSGaQiJhAmf0/D7NKQUYoAYqCzjehqzbO2ArO9uy2R5t8dghlXfoasFE
	 5P60g0UssqQrD6NVwslwfXhSALdkwoNly3m1zvd8X/DTzvpjTP08y1f4mzX79Yvo2y
	 xpJihbfWT9cUHr+V7s844tAx8+bXajZgaCeofP2i/PMGbikVNf9P4DNp52U1AFZnz9
	 TZEvNWRSiFhkp5Hzf/a0uqPZvtu9hnvZuPyAGs/OCnmUT/MViNZpUIqDJC38UMlcwU
	 iC34U/WaYweRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2FC040E83;
	Fri,  3 Apr 2026 05:40:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 463791F3
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 05:40:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 387324008E
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 05:40:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AYJv-1VLT_bx for <intel-wired-lan@lists.osuosl.org>;
 Fri,  3 Apr 2026 05:40:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 63A1640071
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 63A1640071
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 63A1640071
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 05:40:45 +0000 (UTC)
X-CSE-ConnectionGUID: iedwA6z0R/SgnXFyfYeBXw==
X-CSE-MsgGUID: 9yGXEjqwSNaODKNab8PvsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75981760"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="75981760"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 22:40:45 -0700
X-CSE-ConnectionGUID: DHKv9Q/bSWOapH5+nk6vsw==
X-CSE-MsgGUID: F7TH3JMjRbyWiRLV0GQgwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="223904951"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa007.fm.intel.com with ESMTP; 02 Apr 2026 22:40:44 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Date: Fri,  3 Apr 2026 07:40:28 +0200
Message-ID: <20260403054029.3789616-11-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260403054029.3789616-1-aleksandr.loktionov@intel.com>
References: <20260403054029.3789616-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775194846; x=1806730846;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nFD8pkeZbVN+oILrj3B+/KCNeAfTezohFmcf1myKIyA=;
 b=IXvB8TokZmpmzlZoE6usHYl1XajSpfttSpplSDPltYEEDQz23+sTXxPt
 Ecgs4VJxY6jYruIpsdohPuVxmujLiS2nDdMn1xjMEFpVgWSoTbFvFyPMw
 OuaaQhFI+jUkk5rWoTjIqSV5p2ldNGPXEaBtsBR2eEbOzS9tW7meb+KtH
 hrufGo5s14S+lHFiaz0+WiX59wl8vFI53Fon1EpAOSKPgpDWvB9v3sChM
 BnTH+BXKlFBbubqrfq6WJ/3JmyBxWZaVlRlDbT54ZYf8BhUMuG4yS9XSK
 CaYrPPWYfjbnTfosRknEOVxtoFrqyecG9iNpBID/Fdsx5e3Kk3gp4JnSV
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=IXvB8Tok
Subject: [Intel-wired-lan] [PATCH iwl-net 10/10] ice: allow setting
 min_tx_rate to 0 to resolve VF bandwidth oversubscription
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

ice_set_vf_bw() refuses to accept any min_tx_rate value when the
total guaranteed bandwidth is already oversubscribed, even when the
requested value is 0. This makes it impossible to recover from an
oversubscribed state via "ip link set <pf> vf <id> min_tx_rate 0".

Allow a zero min_tx_rate to bypass the oversubscription check so
users can always clear the guaranteed rate. Additionally print an
informational message when the oversubscription guard fires to help
diagnose why a non-zero request was rejected.

Fixes: 4ecc8633056b ("ice: Add support for VF rate limiting")
Cc: stable@vger.kernel.org
Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 7e00e09..6e3bec7 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1507,6 +1507,12 @@ ice_min_tx_rate_oversubscribed(struct ice_vf *vf, int min_tx_rate)
 	all_vfs_min_tx_rate -= vf->min_tx_rate;
 
 	if (all_vfs_min_tx_rate + min_tx_rate > link_speed_mbps) {
+		if (ice_calc_all_vfs_min_tx_rate(vf->pf) > link_speed_mbps) {
+			dev_info(ice_pf_to_dev(vf->pf),
+				 "The sum of min_tx_rate for all VFs is greater than the link speed\n");
+			dev_info(ice_pf_to_dev(vf->pf),
+				 "Set min_tx_rate to 0 on VFs to resolve oversubscription\n");
+		}
 		dev_err(ice_pf_to_dev(vf->pf), "min_tx_rate of %d Mbps on VF %u would cause oversubscription of %d Mbps based on the current link speed %d Mbps\n",
 			min_tx_rate, vf->vf_id,
 			all_vfs_min_tx_rate + min_tx_rate - link_speed_mbps,
@@ -1556,7 +1562,7 @@ ice_set_vf_bw(struct net_device *netdev, int vf_id, int min_tx_rate,
 		goto out_put_vf;
 	}
 
-	if (ice_min_tx_rate_oversubscribed(vf, min_tx_rate)) {
+	if (min_tx_rate && ice_min_tx_rate_oversubscribed(vf, min_tx_rate)) {
 		ret = -EINVAL;
 		goto out_put_vf;
 	}
-- 
2.52.0

