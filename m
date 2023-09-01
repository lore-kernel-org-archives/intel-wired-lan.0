Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C204ECA0FE8
	for <intel-wired-lan@archiver.kernel.org>; Fri,  1 Sep 2023 09:20:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 402FF400FE;
	Fri,  1 Sep 2023 09:20:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 402FF400FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1693560001;
	bh=UoomnI7Dpur6WQemrMSy6GU3lpYZfVO59dspRVpNqOI=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IzWXQkLdb1xhyX86xLbgm1irV8XN6HwOAlHeeXrFYsGcuC+X6LRuRBJTJmtAGGmx1
	 KefkCaayRQ5WFVkLRrd/0MJDULZ3T0ZLw8IZiYIBunp12atiXVKE9GMIGD0835hm6a
	 b2hBYVI7GOyGST7JQWG7ask4VnnLS0ACAMgw7f5B7g8BxjIo5kXOOQrBVWr50Oj4IU
	 reRXe17BKOQ+T4rFrsl+obbG/umL+X1LkCZvx9/mg6OP46LbHlkAVir7J/T0Bf8Zb1
	 3lg7kvJwSKtl4T3EmTlmCVMrBDI9DPmwMcLclQj0e1LwsqOeYGIPdIZaSlTe+C9RLb
	 0v7zGkOc56jrQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wcBh6lngm-9c; Fri,  1 Sep 2023 09:20:00 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 305C84171A;
	Fri,  1 Sep 2023 09:20:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 305C84171A
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id ABDBA1BF380
 for <intel-wired-lan@lists.osuosl.org>; Fri,  1 Sep 2023 09:19:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8B41B60F15
 for <intel-wired-lan@lists.osuosl.org>; Fri,  1 Sep 2023 09:19:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8B41B60F15
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wEdjPj1gRSr6 for <intel-wired-lan@lists.osuosl.org>;
 Fri,  1 Sep 2023 09:19:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 30BF660B10
 for <intel-wired-lan@lists.osuosl.org>; Fri,  1 Sep 2023 09:19:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 30BF660B10
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="379962770"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; d="scan'208";a="379962770"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2023 02:19:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="743045996"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; d="scan'208";a="743045996"
Received: from amlin-018-068.igk.intel.com ([10.102.18.68])
 by fmsmga007.fm.intel.com with ESMTP; 01 Sep 2023 02:19:54 -0700
From: Mateusz Palczewski <mateusz.palczewski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Fri,  1 Sep 2023 05:12:44 -0400
Message-Id: <20230901091244.15452-1-mateusz.palczewski@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693559997; x=1725095997;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Y0CYkhhSaZJXEmzt1J/H8zZ5B1lKDxF0ZrMG1CEbcaE=;
 b=jQYDSCpCdnt+8gKC9aaTChM8DJ/ASadhiOsHpOriyuZ33tTFsYUB5or7
 WvYnUAxrMFC/SgSbpPmL3OFhSc59A66smvDOwwyMNhSZszCiNpdr7D5Ma
 YIf6dKzeTm6SIJqBirfSDPjTztN3/2L5VLqrRhfbcPbe4WRxlHhsT+nho
 MffiHmSUXNFAUHQeuOt9GhjQuQoEFV2ez49+rTafeliqcquAyUzT5ftM5
 aSeqHuXD9K9Qe15jdvpaPb0/Wl2+/hcbLqdAKTuAuoR4/WUeGtLQM2v+z
 10DkkEMuosNmy/Cr7ePFMtBlUGAiAWhaiHGRCbwoeq8VIIn79Y+oeyl/M
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=jQYDSCpC
Subject: [Intel-wired-lan] [PATCH iwl-net v1] ice: Fix call trace when
 rebuild fails
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

In case rebuild fails trying to restart or unload a driver lead to call
trace.

    [  128.876458] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
    [  128.884417] PGD 33510d067 P4D 0
    [  128.887776] Oops: 0000 [#1] SMP NOPTI
    [  128.891571] CPU: 6 PID: 2141 Comm: ethtool Kdump: loaded Not tainted 4.18.0-372.34.1.el8_6.ice.2117361.repr.x86_64 #1
    [  128.902308] Hardware name: ACCTON BRIGHTONCITY/BRIGHTONCITY, BIOS IDVLCRB1.86B.0021.D40.2112020610 12/02/2021
    [  128.912351] RIP: 0010:ice_vsi_setup_tx_rings+0x26/0x80 [ice]
    [  128.918163] Code: 00 0f 1f 00 0f 1f 44 00 00 41 54 55 53 66 83 bf da 03 00 00 00 48 89 fb 0f 84 c9 38 05 00 48 8b 47 28 41 bc 08 00 00 00 31 ed <48> 8b 38 48 85 ff 75 21 eb 3d 0f b7 93 da 03 00 00 83 c5 01 39 ea
    [  128.937060] RSP: 0018:ff78a8b908183a10 EFLAGS: 00010246
    [  128.942417] RAX: 0000000000000000 RBX: ff4a4174c104e818 RCX: 0000000000000a50
    [  128.949683] RDX: 0000000000000a4f RSI: 641269b8ad24144d RDI: ff4a4174c104e818
    [  128.956946] RBP: 0000000000000000 R08: 0000000080000000 R09: ff4a4173241b9b30
    [  128.964208] R10: ff4a4173241b9b30 R11: 0000000000000000 R12: 0000000000000008
    [  128.971475] R13: ff4a417570650180 R14: 0000000000000001 R15: 0000000000000001
    [  128.978741] FS:  00007f18a268e740(0000) GS:ff4a41823ff80000(0000) knlGS:0000000000000000
    [  128.986961] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [  128.992837] CR2: 0000000000000000 CR3: 0000000109e8e003 CR4: 0000000000771ee0
    [  129.000103] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
    [  129.007368] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
    [  129.014635] PKRU: 55555554
    [  129.017473] Call Trace:
    [  129.020054]  ice_vsi_open+0x29/0x120 [ice]
    [  129.024292]  ice_vsi_recfg_qs+0xaa/0x110 [ice]
    [  129.028874]  ice_set_channels+0x18d/0x3d0 [ice]
    [  129.033549]  ethnl_set_channels+0x3a1/0x410
    [  129.037865]  genl_family_rcv_msg_doit.isra.17+0x113/0x150
    [  129.043394]  genl_family_rcv_msg+0xb7/0x170
    [  129.047708]  ? channels_fill_reply+0x1a0/0x1a0
    [  129.052282]  genl_rcv_msg+0x47/0xa0
    [  129.055901]  ? genl_family_rcv_msg+0x170/0x170

Fix this by setting ICE_RESET_FAILED when rebuild fails and
clearing number of qs when rings are free.

Fixes: 6624e780a577 ("ice: split ice_vsi_setup into smaller functions")
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c  | 4 ++++
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 0054d7e64ec3..9cbeb4ce06d3 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -321,6 +321,9 @@ static void ice_vsi_free_arrays(struct ice_vsi *vsi)
 
 	dev = ice_pf_to_dev(pf);
 
+	vsi->num_txq = 0;
+	vsi->num_rxq = 0;
+
 	bitmap_free(vsi->af_xdp_zc_qps);
 	vsi->af_xdp_zc_qps = NULL;
 	/* free the ring and vector containers */
@@ -3206,6 +3209,7 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
 	ice_vsi_decfg(vsi);
 err_vsi_cfg:
 	kfree(coalesce);
+	set_bit(ICE_RESET_FAILED, pf->state);
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index b40dfe6ae321..becf7f0fcd4c 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4232,7 +4232,7 @@ static void ice_deinit_fdir(struct ice_pf *pf)
 {
 	struct ice_vsi *vsi = ice_get_ctrl_vsi(pf);
 
-	if (!vsi)
+	if (!vsi || test_bit(ICE_RESET_FAILED, pf->state))
 		return;
 
 	ice_vsi_manage_fdir(vsi, false);
@@ -4746,7 +4746,7 @@ static void ice_deinit_pf_sw(struct ice_pf *pf)
 {
 	struct ice_vsi *vsi = ice_get_main_vsi(pf);
 
-	if (!vsi)
+	if (!vsi || test_bit(ICE_RESET_FAILED, pf->state))
 		return;
 
 	ice_vsi_release(vsi);
-- 
2.31.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
