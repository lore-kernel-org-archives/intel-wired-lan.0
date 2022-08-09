Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB20FC25B06
	for <intel-wired-lan@archiver.kernel.org>; Tue,  9 Aug 2022 08:55:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1967A40283;
	Tue,  9 Aug 2022 08:55:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1967A40283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1660035334;
	bh=6A1mxop+sSW3Vm9kloYqQMkIAMIRfT8mvB3zUYcIjEM=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=wVDzjJcNB/ii2GN7PKtfCG3j3xgy3xp8EIVtFggPSLlOezqVzxXJBzNQjp1bsBLXw
	 27dbb+p1xAHONMzkQwQ8qz152exSAtswKofi2WvASfYeSlVSIpxCBk9R++LbxaVtHu
	 WuzM2VHzw1AdA/7bEyu055BJfFJraOPYYagm8g9Bo4U9HSsg9iApXk1AWwOqqNiU+O
	 iNUULWxc4Tuy6a91PDZYeBXOgcWa6BOwBcEJRue4TKNxx2wJwbub7wGLw4pdxqT0tt
	 0KHb7jwtiQxWEy+XIPrmwX57va93Nb/ej0+FHelFXI98Yzr0x1Lp7tl83J8MM0erQt
	 +gWelsMPWspdQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x-9BNI0ZWo57; Tue,  9 Aug 2022 08:55:33 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1A55240549;
	Tue,  9 Aug 2022 08:55:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1A55240549
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 017D51BF5F5
 for <intel-wired-lan@lists.osuosl.org>; Tue,  9 Aug 2022 08:55:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C5E8240549
 for <intel-wired-lan@lists.osuosl.org>; Tue,  9 Aug 2022 08:55:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C5E8240549
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JMvWqudoNVB9 for <intel-wired-lan@lists.osuosl.org>;
 Tue,  9 Aug 2022 08:55:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 831A740283
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 831A740283
 for <intel-wired-lan@lists.osuosl.org>; Tue,  9 Aug 2022 08:55:30 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="288353986"
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; d="scan'208";a="288353986"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Aug 2022 01:55:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; d="scan'208";a="694069185"
Received: from s240.igk.intel.com (HELO s048.nql.local) ([10.102.18.202])
 by FMSMGA003.fm.intel.com with ESMTP; 09 Aug 2022 01:55:28 -0700
From: "Sokolowski, Jan" <jan.sokolowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue,  9 Aug 2022 10:57:44 +0200
Message-Id: <20220809085744.2573-1-jan.sokolowski@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1660035330; x=1691571330;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=U8fMxvWVuTpNRo8au5arBqlmE51WSwNoz2ibbUd8/i4=;
 b=jk1PRt/N7KbeLQVYnbXNSDKIC85dUlgLaF+EgqLc4Pm2z1B3QmPOuPOx
 jXztk8D7+H2OItpH17U2ZutOF65Gtx9s/EgWGSy6KVaNbienCJgdCoy4A
 8h46e5TTHS634OemzU2mqR8P6Mw/yHkslGjPFZAT3dyRtN4qJ53GDABIX
 bUTRE97Q4HNfjThcOiTyfhAa+7Q0BGKQwq2y3U2XH+hx2t6CvrH2Uaodp
 POS2FMVIutauYMCUnMjMOQhHQdRwdwYGcPUNBMEcECconHzVRVGmnoN9o
 nyGjB1wIhChSBG0f7IeQuKsO/oCVCY5MpUmvHW7RmDQ16HGHXlgRk0weA
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=jk1PRt/N
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix ADq rate limiting for PF
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
Cc: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>

Fix HW rate limiting for ADq.
Fallback to kernel queue selection for ADq, as it is network stack
that decides which queue to use for transmit with ADq configured.
Reset PF after creation of VMDq2 VSIs required for ADq, as to
reprogram TX queue contexts in i40e_configure_tx_ring.
Without this patch PF would limit TX rate only according to TC0.

Fixes: a9ce82f744dc ("i40e: Enable 'channel' mode in mqprio for TC configs")
Signed-off-by: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +++
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 9f1d5de7bf16..10c1e1ea83a1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6659,6 +6659,9 @@ static int i40e_configure_queue_channels(struct i40e_vsi *vsi)
 			vsi->tc_seid_map[i] = ch->seid;
 		}
 	}
+
+	/* reset to reconfigure TX queue contexts */
+	i40e_do_reset(vsi->back, I40E_PF_RESET_FLAG, true);
 	return ret;
 
 err_free:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index d4226161a3ef..69e67eb6aea7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -3688,7 +3688,8 @@ u16 i40e_lan_select_queue(struct net_device *netdev,
 	u8 prio;
 
 	/* is DCB enabled at all? */
-	if (vsi->tc_config.numtc == 1)
+	if (vsi->tc_config.numtc == 1 ||
+	    i40e_is_tc_mqprio_enabled(vsi->back))
 		return netdev_pick_tx(netdev, skb, sb_dev);
 
 	prio = skb->priority;
-- 
2.31.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
