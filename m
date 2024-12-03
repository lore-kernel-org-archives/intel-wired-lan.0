Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA20E6C60D
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Dec 2024 06:59:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9210E40725;
	Tue,  3 Dec 2024 06:59:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7w-IJwH_grEs; Tue,  3 Dec 2024 06:58:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CDC744074B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1733209139;
	bh=z7V2yv27S+N/Rmz2lkdrBTyIylxWKHaGGmedmPTXdDs=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=F7ANDa1amLlxycrnsjdneRHpTXrryQkSdXFIzL+0Np2PKbjmypq7sMreIwwAxIxe2
	 tK8WwT6F6RitQtmHu35MC9gMfGo5piLgiE+9ItTt4/EaaspmJrdisq5UE1hw6lsO+J
	 SxHJ3hGBDQ03zAbXCYO9dSv212EZsw9Cvtrq/I+D/4he+kwzVVnFL86hC19cOeTuii
	 rYRCtySOZccNaOvDVigc+Sj66pH9P8QIrVPy5vaIQJK1cdPwlAJ6RE8w2UB5UJ4KbH
	 gf+3OUEWxjhnwcG5/V1hsbQLqJoL8tf1vtS1aQoj9xaSZVhejZ4LX32WClxwAPCbUz
	 v1TAbbSXv+EUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CDC744074B;
	Tue,  3 Dec 2024 06:58:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9438660
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Dec 2024 06:58:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7178B404DD
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Dec 2024 06:58:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GzL0UU0ScYOW for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Dec 2024 06:58:57 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 918CE40201
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 918CE40201
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 918CE40201
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Dec 2024 06:58:57 +0000 (UTC)
X-CSE-ConnectionGUID: VpxrOFlbSYeYNLJjPIogSw==
X-CSE-MsgGUID: V1Vtold1TKiexCUdCz2m+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33330584"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; d="scan'208";a="33330584"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2024 22:58:57 -0800
X-CSE-ConnectionGUID: 4Mn7tKIATLyVZ0N26wumDA==
X-CSE-MsgGUID: tRK8sG7lQwukv3KNZUdECw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; d="scan'208";a="93673763"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
 by fmviesa010.fm.intel.com with ESMTP; 02 Dec 2024 22:58:54 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue,  3 Dec 2024 07:58:17 +0100
Message-ID: <20241203065817.13475-10-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241203065817.13475-1-michal.swiatkowski@linux.intel.com>
References: <20241203065817.13475-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733209137; x=1764745137;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TqMn5ZoOpTAoAK8iWGxuf7LA1zoNOY5g+SWXA7iZEuA=;
 b=AGCRvQVgzLhDJHvYXeRm6x3Pc2ifhwSKfIJbOLItf+gFMTY5wv6gZxMF
 OVYHuorgX97whyPHl+Gzxg2JncLDMX+oGe4DG5YXPvPG6e38PJED3XNn8
 XeeEOYT/7f2HJ/RHGLMvMqcrBoTARDzj3ZvHu1zREPQj9a52EUf+TCiZx
 rZb5/qv1RIMPY1IPPp8p8c7aoojUD+4FaiH6r10t0uOtMbPQveDxLuLM7
 BK0+xREKjBPxuozRWy9zYthajT6F4xujaTJXA3My9aFIYj7ODiGlnU/jj
 Kfzek3mrnJUcD9oOOfVfpa6TfwARxOb580OJNb1hVlx7lEULx4xvlSqXU
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=AGCRvQVg
Subject: [Intel-wired-lan] [iwl-next v9 9/9] ice: init flow director before
 RDMA
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
Cc: himasekharx.reddy.pucha@intel.com, pmenzel@molgen.mpg.de,
 wojciech.drewek@intel.com, marcin.szycik@intel.com, netdev@vger.kernel.org,
 rafal.romanowski@intel.com, konrad.knitter@intel.com,
 pawel.chmielewski@intel.com, horms@kernel.org, David.Laight@ACULAB.COM,
 nex.sw.ncis.nat.hpm.dev@intel.com, pio.raczynski@gmail.com,
 sridhar.samudrala@intel.com, jacob.e.keller@intel.com, jiri@resnulli.us,
 przemyslaw.kitszel@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Flow director needs only one MSI-X. Load it before RDMA to save MSI-X
for it.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 7b9be612cf33..576bff42f440 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5180,11 +5180,12 @@ int ice_load(struct ice_pf *pf)
 
 	ice_napi_add(vsi);
 
+	ice_init_features(pf);
+
 	err = ice_init_rdma(pf);
 	if (err)
 		goto err_init_rdma;
 
-	ice_init_features(pf);
 	ice_service_task_restart(pf);
 
 	clear_bit(ICE_DOWN, pf->state);
@@ -5192,6 +5193,7 @@ int ice_load(struct ice_pf *pf)
 	return 0;
 
 err_init_rdma:
+	ice_deinit_features(pf);
 	ice_tc_indir_block_unregister(vsi);
 err_tc_indir_block_register:
 	ice_unregister_netdev(vsi);
@@ -5215,8 +5217,8 @@ void ice_unload(struct ice_pf *pf)
 
 	devl_assert_locked(priv_to_devlink(pf));
 
-	ice_deinit_features(pf);
 	ice_deinit_rdma(pf);
+	ice_deinit_features(pf);
 	ice_tc_indir_block_unregister(vsi);
 	ice_unregister_netdev(vsi);
 	ice_devlink_destroy_pf_port(pf);
-- 
2.42.0

