Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F2AC43458
	for <intel-wired-lan@archiver.kernel.org>; Wed,  1 Jul 2026 12:45:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6DE4E83C98;
	Wed,  1 Jul 2026 12:45:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Q7jBIdSzCr2; Wed,  1 Jul 2026 12:45:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 525F184173
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1782909949;
	bh=+IsOc6/WlQFIftTxG2wVEm2A/Iywu9UVmM0cRZMShLU=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EwnjTHD3UoziDsZypu9DNflj0mGq+Wj1NBHo5datXX27aoScPVjzBBcefdstAJiI2
	 l6S1iw/3mXQbVoPV2FQ8wu+1ms5kNl2iRG3JUxCMRjcx7U9JELEt0Qp+f9Tyc7M6Kk
	 D0mB7v85ALte511ni8SSfwSpY2JiRApCxI0FSF9EWbhJh5JO0OXGk1su5/921T6jdU
	 T5lgVMmlxlQLLDhAHBSeoslI0D1oYPRqARA9TkZjeWKodZI1Q4xiORS9xCln/6v8O9
	 MYJi1lvoChG8pGk0SR3qN1jR1/Qk+Io0KydtLoXxqo6VDpZB6ng5/tBabFEyFwchVA
	 g+MjaBgUXjOTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 525F184173;
	Wed,  1 Jul 2026 12:45:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 435BA2D5
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Jul 2026 12:45:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 295AF403FF
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Jul 2026 12:45:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qp15l6afpStq for <intel-wired-lan@lists.osuosl.org>;
 Wed,  1 Jul 2026 12:45:45 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=maciej.fijalkowski@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7E8094053A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7E8094053A
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7E8094053A
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Jul 2026 12:45:45 +0000 (UTC)
X-CSE-ConnectionGUID: s6ze21ahQ6mprTcfaSUc5Q==
X-CSE-MsgGUID: NoRbsN6bST2tktdkmBg2gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83839249"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; d="scan'208";a="83839249"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 05:45:41 -0700
X-CSE-ConnectionGUID: ky2i92M2TQqZpfYl11eLEg==
X-CSE-MsgGUID: 2s2ilFaMT/yhpKQpjL+RdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; d="scan'208";a="276864931"
Received: from boxer.igk.intel.com ([10.102.20.173])
 by fmviesa001.fm.intel.com with ESMTP; 01 Jul 2026 05:45:38 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, przemyslaw.kitszel@intel.com,
 jacob.e.keller@intel.com, Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Wed,  1 Jul 2026 14:45:22 +0200
Message-Id: <20260701124524.13644-6-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260701124524.13644-1-maciej.fijalkowski@intel.com>
References: <20260701124524.13644-1-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782909946; x=1814445946;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=v9P7/6NHV1OYqx1b6O4LwdxncKZIH965VKOqbFUDLyI=;
 b=hc00XZF4BXPD7JwUj7brp2ELUcYDf9dFxjZtj/cQJPiawz1oQADsFQTB
 Jbl+UA+GdJCv8KO2MIDY8AXt+Nwqfsi63Amx4Wmk9FONEcwg+oBp71YXd
 sZRifGaIEkhGcxB/vFz90yjbxYrjBDSH1cFhC02W7iMVFph3xPjfy8EDX
 Iz6b2fOgFQAfT1Gg8h+k/cPvjZ+K7YTbJnsr0GHar3V0OHs/KlTVSke4h
 doZxPChFuudQM0ht6BhFZn1llXIsPUP5BkvEP5QlpAJYl7PR/KDwdesj9
 NQ7MBZ9iUM/aPXVloc+Pe0YkTP87dsRG7RV48WXdjuydZwmMeK8owkj6z
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=hc00XZF4
Subject: [Intel-wired-lan] [PATCH v5 net 5/7] i40e: fix potential UAF in
 i40e_vsi_setup()'s error path
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

Sashiko pointed out an issue where error path in i40e_vsi_reinit_setup()
released ring memory but then when freeing q_vectors, the rings mapped
to q_vectors where touched which implies a regular use-after-free bug.

Apparently i40e_vsi_setup() has the same problem, so swap the allocation
and freeing order and fix the 13 year old bug.

Fixes: 41c445ff0f48 ("i40e: main driver core")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index e88cf7cfbd84..fcdd13af08ea 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14466,14 +14466,14 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 		fallthrough;
 	case I40E_VSI_FDIR:
 		/* set up vectors and rings if needed */
-		ret = i40e_vsi_setup_vectors(vsi);
-		if (ret)
-			goto err_msix;
-
 		ret = i40e_alloc_rings(vsi);
 		if (ret)
 			goto err_rings;
 
+		ret = i40e_vsi_setup_vectors(vsi);
+		if (ret)
+			goto err_qvec;
+
 		/* map all of the rings to the q_vectors */
 		i40e_vsi_map_rings_to_vectors(vsi);
 
@@ -14493,10 +14493,10 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 	return vsi;
 
 err_config:
+	i40e_vsi_free_q_vectors(vsi);
+err_qvec:
 	i40e_vsi_clear_rings(vsi);
 err_rings:
-	i40e_vsi_free_q_vectors(vsi);
-err_msix:
 	if (vsi->netdev_registered) {
 		vsi->netdev_registered = false;
 		unregister_netdev(vsi->netdev);
-- 
2.43.0

