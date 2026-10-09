Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27EECA9EBB
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 12:15:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 97B89813CA;
	Fri,  9 Oct 2026 12:15:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ixF5OGQOSQmE; Fri,  9 Oct 2026 12:15:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A67E3813CB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791548101;
	b=aeyds6J4AjHM6BKiCmMpZSai1ZrwhGN0fb891DBqh/YNUCyWhWA2dBPNzwGv3olfM62z
	 gq93WbKzHnJGvnaqSopm0JaZop2eHFzRm42h8Cw2WodoLMpCSJB8z7B3a9JB7VMGqi+HX
	 9XnNWLZWZZxvEyauh0qe9pFCnGc2vfGJJiG7foDxyFP7GIy5BZt4NBhSDhj2V+IoxJ0OM
	 fGGMb9NIlo1+pluSOdjfdJEY7DANGWcaF2ZtZ1phVg9FhchmXCY9YFLr8FlF6Fs2UOMzD
	 idd2gJEGpdJOCRfta/LB9bwk6tZAG5k/BNxu6Ew2cbjOaCn53hFJuFlYPts+fZIuWcA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791548101;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=41r5cnmUK0xIpSbsVnacjFU3ggqzaP5Pm0WU2yysu6E=;
	b=qdKAKuIyX147gOty3U1X8rAZFwOMfwyuC6u+5fyN5tgTGL5NSPQ1KMx+qWd1YLwtBeuv
	 ZY9pLa6L/NGD+hzFi1VMP1tb16ESYqnOvhmsD20UvKxtdV22YFzFqftti1Tth9CzdYbrT
	 WapxII4GkO8lvS1FhifxZas6ngb79p0/9jPCIq9qDAKfor4E4M2gTm5yf7t6TZIgv+SPY
	 XGqGM00isR/UanReQb9qybmWL3B1v2DNidLaCdy6h2tlO1y/4GLZrpl4R+iTMqHPArrTX
	 68ouwiczfrH2+PGO7tOGKrKAI+pE9TvF/hR9bXaW8hokmN7uDsQBlbgeZgBjnIfzGeg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791548101;
	bh=41r5cnmUK0xIpSbsVnacjFU3ggqzaP5Pm0WU2yysu6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6SF6gHTm8+rBB28nc6Lq3bto4qgHI8R2tAFxKfQQeQnZjP4S8oJJ+MDRmi0deDbJ9
	 7LKA/+9npV/i2p2ZlxBJnrbuybf7vDQlt7QuGLTyQ5W2tqADe+EDBQ6bafxkiAIDdU
	 5zLSt/Z3wmxAhCeSfoWAW1UlNdkOuJZJzPNGn1tooJGHRNQS6LgdEL19aOSFsXH8T0
	 IA1VJkJuYRMz6uekAtb1hI7AseK9g6MsmRag9eMCTETCxtC1I+ewSeQUSQzRLrxIOI
	 b1dfZ/T+qMBq5ptrCgtHaTpNenqru8Kz4FYy0KQEGcYft8LxN3nPdRhjW6hH2yvdq3
	 G922vTpznOUJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A67E3813CB;
	Fri,  9 Oct 2026 12:15:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0633B2AA
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:15:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EC1E060680
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:15:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HZRwj8YAxKem for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 12:15:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F28D56067C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791548100;
 b=HerjYWAtAX26k/FBUivNzH4jU+mbcUG4UTickZo/Lld46t/N2Cj5D1V05w6bjR3630h/
 x3rDhydqZ5nL5ONghV44vH1DfC/bNgDjEeWjDccnwpZchYn5ZkGm4mmGvrl8pVtWNAkRD
 VkPqPXKfjtXo4c5IKmzC/bm+sNo5fJsx+mPmuF8lKEttdPd5EoR0+q7u/uBKwGakDOGPU
 9HR49REee933c5j41exeDqFaJPqlMUuV1sCXrGKr/sYZdj9P3SW2gSgeatsT2Yz14QHrH
 TQnSRUDxU4vUtlvmUafwlfcjHprAhOxMdoV4ACI3Wz1f1FFCqxWkWlGOXKoCFSTqafA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791548100;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=41r5cnmUK0xIpSbsVnacjFU3ggqzaP5Pm0WU2yysu6E=;
 b=k3cXMGAgqTYRqM/PhlF+Vbtsg2dwoRZheaTk40xAKcCpvgk+B2XyYWwjILKPhYJhayyf
 EOl0p4ZtBiLG/u/c2eWBLXu0gqiOhKDo/VL2rCmv4WOsJjZDVw8ZetztKxKD3OOqUinUB
 oGg12XBUpmg5Sdq0Mfper/wLj0Y6rF+ByryRwn/LPwxKnwwNa6+R6oTmWmiJvJblZ3Bzn
 AYVKR4fgcI3SIoxswEfoRa/azV7WD3dvHC/5jrcXAr/HD1dPvGnYRoFjxAEQJvTyiMjER
 tPIGyxWMyDjjJp1H2+8G9eZ4gQ5OMQoOoEfG7CZ9/16HAEarBW/V2AgoDbjeLZMV8Pg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=lSlBTSvx; 
 arc=none smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=lSlBTSvx
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F28D56067C
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791548100; x=1823084100;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lrGh1SeNInxM82wcIDBIfhSMextgyOQuj5LXlzoOu0A=;
 b=lSlBTSvxpzSK5bCjTNMD6dHKTfrDUwuxTWSrmkJD+zFyd712SK4lKbfJ
 WEwNdJH7oWT6GKJfuPvJLYQQsXTJ7d1irHN4A+IV2SSajIOT8MhrD05a2
 y0ctP71LFkJGUS0aEUt6KercxnPEa0v3cwuB/fdN03ZOpUx2r+hdAb8Qa
 pJb0puvRvWB3Jw1brRirQMKZYHvApFFcoSVDEXy8LciodaW78zpmoNqxg
 Ae2U8aMImQ9OW6nUkokiAgA2Q3Do4iDMkwqdHg5DaM8jkU1M9N6LFbTxZ
 wQZtpFn6htA+rh6BYK62x2grYr1WJtGLf56GKmHOW0Txrh5JD+un34OS0 w==;
X-CSE-ConnectionGUID: ER+kvusETdiqXARa1ZGvuA==
X-CSE-MsgGUID: R7ilAFDLQs6U5Sz1kyZCxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="251162"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="251162"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 05:14:58 -0700
X-CSE-ConnectionGUID: zNruflQMST2cJYBKWQMPmw==
X-CSE-MsgGUID: m6Y3oSCBSCyShW37SeU9nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="420439"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa002.fm.intel.com with ESMTP; 09 Oct 2026 05:14:53 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.245.238])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 1C21D2FC46;
 Fri,  9 Oct 2026 13:14:50 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Michal Schmidt <mschmidt@redhat.com>, intel-wired-lan@lists.osuosl.org,
 edumazet@kernel.org, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, Jonathan Corbet <corbet@lwn.net>,
 skhan@linuxfoundation.org, rdunlap@infradead.org, andrew+netdev@lunn.ch,
 saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org, mbloch@nvidia.com,
 jacob.e.keller@intel.com, jedrzej.jagielski@intel.com, anzaki@gmail.com,
 brett.creeley@amd.com, jtornosm@redhat.com, ohartoov@nvidia.com,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v2 06/14] ice: bump to 256qs for VF
Date: Fri,  9 Oct 2026 14:04:17 +0200
Message-ID: <20261009121433.30347-7-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
References: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Adjust all bitmaps and arrays in ice to accept 256 VF queues.
Extend struct ice_vf::num_req_qs width to allow 256 queues.
Keep old/legacy size for virtchnl opcodes that were designed to accept
only up to 16 queues.

Raise also the limits for the default VF queue count and for
VIRTCHNL_OP_REQUEST_QUEUES to 256. New virtchnl opcodes, needed to
make use of more than 16 queues, are handled by subsequent commits
of this series, the work is split for easier review.

Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v2:
 * change ice_lag allocations to kvzalloc(), as they have grown to
   66KB (Sashiko)
 * commit message: mention that the default and requested VF queue
   limits are raised already here, while more than 16 queues are
   enabled by subsequent commits

Sashiko suggestions I don't want to apply:
 S: there is an existing error handling issue in ice_init_lag()
 me: pre-existing and unrelated, will be fixed separately
---
 drivers/net/ethernet/intel/ice/ice_lag.h     |  2 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h  |  9 +++++----
 drivers/net/ethernet/intel/ice/ice_lag.c     |  6 +++---
 drivers/net/ethernet/intel/ice/ice_lib.c     |  2 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c   |  4 ++--
 drivers/net/ethernet/intel/ice/ice_vf_lib.c  |  8 ++++----
 drivers/net/ethernet/intel/ice/virt/queues.c | 14 +++++++-------
 7 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.h b/drivers/net/ethernet/intel/ice/ice_lag.h
index 4bfffecbdc97..39f6a6cc844d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.h
+++ b/drivers/net/ethernet/intel/ice/ice_lag.h
@@ -52,7 +52,7 @@ struct ice_lag {
 	u8 bond_lport_sec; /* lport values for secondary PF */
 
 	/* q_home keeps track of which interface the q is currently on */
-	u8 q_home[ICE_MAX_SRIOV_VFS][ICE_MAX_QS_PER_VF_VCV1];
+	u8 q_home[ICE_MAX_SRIOV_VFS][ICE_MAX_QS_PER_VF];
 
 	/* placeholder VSI for hanging VF queues from on secondary interface */
 	struct ice_vsi *sec_vf[ICE_MAX_SRIOV_VFS];
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index 4959ecee0c21..a9e95c85bc98 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -21,6 +21,7 @@
 /* VF resource constraints */
 /* for "old" virtchnl opcodes that accept up to 16 queues */
 #define ICE_MAX_QS_PER_VF_VCV1	16
+#define ICE_MAX_QS_PER_VF	256
 
 struct ice_pf;
 struct ice_vf;
@@ -162,8 +163,8 @@ struct ice_vf {
 	u8 dev_lan_addr[ETH_ALEN];
 	u8 hw_lan_addr[ETH_ALEN];
 	struct ice_time_mac legacy_last_added_umac;
-	DECLARE_BITMAP(txq_ena, ICE_MAX_QS_PER_VF_VCV1);
-	DECLARE_BITMAP(rxq_ena, ICE_MAX_QS_PER_VF_VCV1);
+	DECLARE_BITMAP(txq_ena, ICE_MAX_QS_PER_VF);
+	DECLARE_BITMAP(rxq_ena, ICE_MAX_QS_PER_VF);
 	struct ice_vlan port_vlan_info;	/* Port VLAN ID, QoS, and TPID */
 	struct virtchnl_vlan_caps vlan_v2_caps;
 	struct ice_mbx_vf_info mbx_info;
@@ -185,7 +186,7 @@ struct ice_vf {
 	DECLARE_BITMAP(vf_states, ICE_VF_STATES_NBITS);	/* VF runtime states */
 
 	unsigned long vf_caps;		/* VF's adv. capabilities */
-	u8 num_req_qs;			/* num of queue pairs requested by VF */
+	u16 num_req_qs;			/* num of queue pairs requested by VF */
 	u16 num_mac;
 	u16 num_mac_lldp;
 	u16 num_vf_qs;			/* num of queue configured per VF */
@@ -206,7 +207,7 @@ struct ice_vf {
 	u16 lldp_recipe_id;
 	u16 lldp_rule_id;
 
-	struct ice_vf_qs_bw qs_bw[ICE_MAX_QS_PER_VF_VCV1];
+	struct ice_vf_qs_bw qs_bw[ICE_MAX_QS_PER_VF];
 };
 
 /* Flags for controlling behavior of ice_reset_vf */
diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 08a17ded0ad5..e006311c18b6 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -2577,7 +2577,7 @@ int ice_init_lag(struct ice_pf *pf)
 	if (!ice_is_feature_supported(pf, ICE_F_SRIOV_LAG))
 		return 0;
 
-	pf->lag = kzalloc_obj(*lag);
+	pf->lag = kvzalloc_obj(*lag);
 	if (!pf->lag)
 		return -ENOMEM;
 	lag = pf->lag;
@@ -2651,7 +2651,7 @@ int ice_init_lag(struct ice_pf *pf)
 	ice_free_hw_res(&pf->hw, ICE_AQC_RES_TYPE_RECIPE, 1,
 			&lag->pf_recipe);
 lag_error:
-	kfree(lag);
+	kvfree(lag);
 	pf->lag = NULL;
 	return err;
 }
@@ -2680,7 +2680,7 @@ void ice_deinit_lag(struct ice_pf *pf)
 	ice_free_hw_res(&pf->hw, ICE_AQC_RES_TYPE_RECIPE, 1,
 			&pf->lag->lport_recipe);
 
-	kfree(lag);
+	kvfree(lag);
 
 	pf->lag = NULL;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index e18128bce959..f81b310a98c3 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1026,7 +1026,7 @@ static void ice_vsi_set_rss_params(struct ice_vsi *vsi)
 		 * For VSI_LUT, LUT size should be set to 64 bytes.
 		 */
 		vsi->rss_table_size = ICE_LUT_VSI_SIZE;
-		vsi->rss_size = ICE_MAX_QS_PER_VF_VCV1;
+		vsi->rss_size = ICE_MAX_QS_PER_VF;
 		vsi->rss_lut_type = ICE_LUT_VSI;
 		break;
 	case ICE_VSI_LB:
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index dcd6d48ea38d..d7c4a6540008 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -398,15 +398,15 @@ static int ice_set_per_vf_res(struct ice_pf *pf, u16 num_vfs)
 	}
 
 	num_txq = min_t(u16, num_msix_per_vf - ICE_NONQ_VECS_VF,
-			ICE_MAX_QS_PER_VF_VCV1);
+			ICE_MAX_QS_PER_VF);
 	avail_qs = ice_get_avail_txq_count(pf) / num_vfs;
 	if (!avail_qs)
 		num_txq = 0;
 	else if (num_txq > avail_qs)
 		num_txq = rounddown_pow_of_two(avail_qs);
 
 	num_rxq = min_t(u16, num_msix_per_vf - ICE_NONQ_VECS_VF,
-			ICE_MAX_QS_PER_VF_VCV1);
+			ICE_MAX_QS_PER_VF);
 	avail_qs = ice_get_avail_rxq_count(pf) / num_vfs;
 	if (!avail_qs)
 		num_rxq = 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index be87a83d2599..320b393ddaaf 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -528,8 +528,8 @@ static void ice_vf_rebuild_host_cfg(struct ice_vf *vf)
 static void ice_set_vf_state_qs_dis(struct ice_vf *vf)
 {
 	/* Clear Rx/Tx enabled queues flag */
-	bitmap_zero(vf->txq_ena, ICE_MAX_QS_PER_VF_VCV1);
-	bitmap_zero(vf->rxq_ena, ICE_MAX_QS_PER_VF_VCV1);
+	bitmap_zero(vf->txq_ena, ICE_MAX_QS_PER_VF);
+	bitmap_zero(vf->rxq_ena, ICE_MAX_QS_PER_VF);
 	clear_bit(ICE_VF_STATE_QS_ENA, vf->vf_states);
 }
 
@@ -1243,8 +1243,8 @@ bool ice_is_vf_trusted(struct ice_vf *vf)
  */
 bool ice_vf_has_no_qs_ena(struct ice_vf *vf)
 {
-	return bitmap_empty(vf->rxq_ena, ICE_MAX_QS_PER_VF_VCV1) &&
-	       bitmap_empty(vf->txq_ena, ICE_MAX_QS_PER_VF_VCV1);
+	return bitmap_empty(vf->rxq_ena, ICE_MAX_QS_PER_VF) &&
+	       bitmap_empty(vf->txq_ena, ICE_MAX_QS_PER_VF);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c b/drivers/net/ethernet/intel/ice/virt/queues.c
index 2667634e3c8c..61304493af34 100644
--- a/drivers/net/ethernet/intel/ice/virt/queues.c
+++ b/drivers/net/ethernet/intel/ice/virt/queues.c
@@ -681,7 +681,7 @@ int ice_vc_cfg_q_bw(struct ice_vf *vf, u8 *msg)
 		goto err;
 	}
 
-	if (qbw->num_queues > ICE_MAX_QS_PER_VF_VCV1 ||
+	if (qbw->num_queues > ICE_MAX_QS_PER_VF ||
 	    qbw->num_queues > min_t(u16, vsi->alloc_txq, vsi->alloc_rxq)) {
 		dev_err(ice_pf_to_dev(vf->pf), "VF-%d trying to configure more than allocated number of queues: %d\n",
 			vf->vf_id, min_t(u16, vsi->alloc_txq, vsi->alloc_rxq));
@@ -773,7 +773,7 @@ int ice_vc_cfg_q_quanta(struct ice_vf *vf, u8 *msg)
 		goto err;
 	}
 
-	if (end_qid > ICE_MAX_QS_PER_VF_VCV1 ||
+	if (end_qid > ICE_MAX_QS_PER_VF ||
 	    end_qid > min_t(u16, vsi->alloc_txq, vsi->alloc_rxq)) {
 		dev_err(ice_pf_to_dev(vf->pf), "VF-%d trying to configure more than allocated number of queues: %d\n",
 			vf->vf_id, min_t(u16, vsi->alloc_txq, vsi->alloc_rxq));
@@ -841,7 +841,7 @@ int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 	if (!vsi)
 		goto error_param;
 
-	if (qci->num_queue_pairs > ICE_MAX_QS_PER_VF_VCV1 ||
+	if (qci->num_queue_pairs > ICE_MAX_QS_PER_VF ||
 	    qci->num_queue_pairs > min_t(u16, vsi->alloc_txq, vsi->alloc_rxq)) {
 		dev_err(ice_pf_to_dev(pf), "VF-%d requesting more than supported number of queues: %d\n",
 			vf->vf_id, min_t(u16, vsi->alloc_txq, vsi->alloc_rxq));
@@ -1019,16 +1019,16 @@ int ice_vc_request_qs_msg(struct ice_vf *vf, u8 *msg)
 	if (!req_queues) {
 		dev_err(dev, "VF %d tried to request 0 queues. Ignoring.\n",
 			vf->vf_id);
-	} else if (req_queues > ICE_MAX_QS_PER_VF_VCV1) {
+	} else if (req_queues > ICE_MAX_QS_PER_VF) {
 		dev_err(dev, "VF %d tried to request more than %d queues.\n",
-			vf->vf_id, ICE_MAX_QS_PER_VF_VCV1);
-		vfres->num_queue_pairs = ICE_MAX_QS_PER_VF_VCV1;
+			vf->vf_id, ICE_MAX_QS_PER_VF);
+		vfres->num_queue_pairs = ICE_MAX_QS_PER_VF;
 	} else if (req_queues > cur_queues &&
 		   req_queues - cur_queues > tx_rx_queue_left) {
 		dev_warn(dev, "VF %d requested %u more queues, but only %u left.\n",
 			 vf->vf_id, req_queues - cur_queues, tx_rx_queue_left);
 		vfres->num_queue_pairs = min_t(u16, max_allowed_vf_queues,
-					       ICE_MAX_QS_PER_VF_VCV1);
+					       ICE_MAX_QS_PER_VF);
 	} else {
 		/* request is successful, then reset VF */
 		vf->num_req_qs = req_queues;
-- 
2.51.1

