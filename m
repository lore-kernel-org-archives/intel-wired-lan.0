Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C9FC6FD1A
	for <intel-wired-lan@archiver.kernel.org>; Tue,  7 Mar 2023 15:05:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65F9A6106E;
	Tue,  7 Mar 2023 15:05:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 65F9A6106E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1678201558;
	bh=13hAe3oMRcCGzvy1F2GKycF9cZS4t0yy5dkPifSQvYk=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=UzbMuBcaAS2rESqxL68iydC09adaOA/9Sq/mmIYAS9UgQiPuCBxXLFxwgif77N6cD
	 ilKMrGoa6R0UcQ3D+cU9k8eOkOENMAvo/p4weBOI5DBblta4umuA3nDPN5Z6rLMpyx
	 p+YjM5bR8O4EdAVEehaoSRXKmHZ1nv5zUgMqY+4PrGc7t9iB+KVP+I1qnYWOihE1cM
	 qSPPu7V/ADF7+kPq0TPAKvB1jSrvOM4AigdGWmu+ghyC5tJIUUoB5wB2ekkjUHi8Ng
	 blv7DenQfqgp7uig0AeOr+4ostXc6vA0lWUIME3AJB5zrbWOERPLujVPLAeI0gcFj2
	 0+sH2flwEvGMA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pyeBn0wD7g4N; Tue,  7 Mar 2023 15:05:57 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 61CB161074;
	Tue,  7 Mar 2023 15:05:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 61CB161074
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 6F2861BF5B4
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Mar 2023 15:05:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5591A40453
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Mar 2023 15:05:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5591A40453
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u-m2NpS_CWLn for <intel-wired-lan@lists.osuosl.org>;
 Tue,  7 Mar 2023 15:05:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 80ED6400A4
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 80ED6400A4
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Mar 2023 15:05:54 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="337387934"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; d="scan'208";a="337387934"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2023 07:05:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="706840675"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; d="scan'208";a="706840675"
Received: from gyorgysx-mobl2.ger.corp.intel.com (HELO azaki-desk1.intel.com)
 ([10.249.43.116])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2023 07:05:43 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue,  7 Mar 2023 08:04:33 -0700
Message-Id: <20230307150433.2441989-1-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1678201554; x=1709737554;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ZlogwVTbBc0X6c5vmDUFj0ii4cfEGmPWWSRpbhABjoc=;
 b=WAobqn9J0u7dO6gLSIZlFgnkoq9tCRvm6/bVFm59ILNioQ1829Ctb7uc
 01pNNZ2MaQgpf71rL9iBMMhPPaQAUPmrgZQA4TGSPIlDY21dSai1c1+G5
 qNFgrGuMyLnwmeTcqSgTxOXLNHPqVor/FVJGH9nu3W1kElEUlTHNk21S/
 W2HSeRVSdCoqECFZt9KAAP2Mufa+wxC7qn1eWn9EjOxR3YVAyPZ54mAlY
 Z6J1tqDHtfdHDy7QmD279f/AZqSJau446XsVhr4qeyGdxlRrhnao+BOLU
 EyN+FBhqXyRhVm6zuvYXP7wC08nXLHpRg0ytayhg38oaYwsUdls1MjQbG
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=WAobqn9J
Subject: [Intel-wired-lan] [PATCH] iavf: do not track VLAN 0 filters
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
Cc: michalx.jaron@intel.com, Michal Kubiak <michal.kubiak@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

When an interface with the maximum number of VLAN filters is brought up,
a spurious error is logged:

[  257.483082] 8021q: adding VLAN 0 to HW filter on device enp0s3
[  257.483094] iavf 0000:00:03.0 enp0s3: Max allowed VLAN filters 8. Remove existing VLANs or disable filtering via Ethtool if supported.

The VF driver complains that it cannot add the VLAN 0 filter.

On the other hand, the PF driver always adds VLAN 0 filter on VF
initialization. The VF does not need to ask the PF for that filter at
all.

Fix the error by not tracking VLAN 0 filters altogether. With that, the
check dded by commit 0e710a3ffd0c ("iavf: Fix VF driver counting VLAN 0
filters") in iavf_virtchnl.c is useless and might be confusing if left as
it suggests that we track VLAN 0.

Fixes: 0e710a3ffd0c ("iavf: Fix VF driver counting VLAN 0 filters")
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c     | 4 ++++
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 3273aeb8fa67..d4e50f6ed14b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -893,6 +893,10 @@ static int iavf_vlan_rx_add_vid(struct net_device *netdev,
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 
+	/* The PF always adds VLAN 0 filters on VF init */
+	if (!vid)
+		return 0;
+
 	if (!VLAN_FILTERING_ALLOWED(adapter))
 		return -EIO;
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 6d23338604bb..4e17d006c52d 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -2446,8 +2446,6 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		list_for_each_entry(f, &adapter->vlan_filter_list, list) {
 			if (f->is_new_vlan) {
 				f->is_new_vlan = false;
-				if (!f->vlan.vid)
-					continue;
 				if (f->vlan.tpid == ETH_P_8021Q)
 					set_bit(f->vlan.vid,
 						adapter->vsi.active_cvlans);
-- 
2.34.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
