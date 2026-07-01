Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5945C44500
	for <intel-wired-lan@archiver.kernel.org>; Wed,  1 Jul 2026 12:45:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AECF86068F;
	Wed,  1 Jul 2026 12:45:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vfCY46hYL-73; Wed,  1 Jul 2026 12:45:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BE36E60D78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1782909948;
	bh=Ka0oLD/7tJn8uRojg6wAPwE24+85MTQ6ZFPbWVYhCs0=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dVmz/GqG/Q8FZR+zclgpnENgQU72JPs9EDfyeW/iQ4kJCbmnHq3nHIq8bP6LKJ7sB
	 eCXx5O5+jGIe7FWtNWnhDDDxvdhrw0Pefg+7k5l2Fxrnfp9wS5ZW+3Rc8zFVMJml5q
	 L7E/rBqLBi+Ze+1t2AozVBXulldVrVt1IPWQnqZfNfbfEDwI2JCRHtF5o2JYD4SWf0
	 SWdayd3+aymw1ah9LYLxpjN3D/l9b9eE2bu+TgngUERlw9E9nFMVlCexD2C4eVFYZX
	 7rFZ58WqmvS5zQg+QR24QMfztClwzwAxsbXJL7XSJEiHp+eSKK1G1HiuwZftnil3Qc
	 2N/ULhF7JKDtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE36E60D78;
	Wed,  1 Jul 2026 12:45:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 275D02D5
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Jul 2026 12:45:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 18F1840508
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Jul 2026 12:45:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xJVBCSPNvCly for <intel-wired-lan@lists.osuosl.org>;
 Wed,  1 Jul 2026 12:45:45 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=maciej.fijalkowski@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 70E954052B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 70E954052B
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 70E954052B
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Jul 2026 12:45:45 +0000 (UTC)
X-CSE-ConnectionGUID: JWwLRx7cTby1zcqSexFp+w==
X-CSE-MsgGUID: tVuHKTWMRpuOgB4x2hGL8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83839243"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; d="scan'208";a="83839243"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 05:45:38 -0700
X-CSE-ConnectionGUID: LS2XpwoSQtC3pq2UN3bcmg==
X-CSE-MsgGUID: zuC5blPTRHinkJVHV7WTDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; d="scan'208";a="276864918"
Received: from boxer.igk.intel.com ([10.102.20.173])
 by fmviesa001.fm.intel.com with ESMTP; 01 Jul 2026 05:45:35 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, przemyslaw.kitszel@intel.com,
 jacob.e.keller@intel.com,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Sashiko AI Review <sashiko-bot@kernel.org>
Date: Wed,  1 Jul 2026 14:45:21 +0200
Message-Id: <20260701124524.13644-5-maciej.fijalkowski@intel.com>
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
 bh=eRQgpL4qfxEAYee/aiq5vXUQEARM1LUI4g4CYk+FfSI=;
 b=lUeQZVnCCROmlqJeoxvZG14KgV/p7oy6Y2kh8ks54H/noUyIpP8kcWqj
 kqRBlcYASp2Y38lzIasALPUwLISpw/a+zgTE9E/EBKxgf/WIQBDeH54uw
 cc8wKU6VQyn1lqJRB7aBdLuNNUvh6LUi6+NJqmu6735qQgeuW4kD5F/cD
 lYOiG4smYD2Lchp+pztm+URKCHSvZGoXy/rQLgLpOPCZQ7ROnVPGeiuDj
 UGpy2BPl7wHmPiH+x/7CAIBZfMi2zH6UQ1YpaMrH9C7bWBBtSyBSWwl+X
 Cu3cwUHuD2Vcaw6dcuoMsYA6ZTIhX9FUyCDufeC76DWvVlWbKKGBgxLWL
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=lUeQZVnC
Subject: [Intel-wired-lan] [PATCH v5 net 4/7] i40e: avoid deadlock when
 calling unregister_netdev()
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

Sashiko reports:
***
> +err_netdev:
>  	if (vsi->netdev_registered) {
>  		vsi->netdev_registered = false;
>  		unregister_netdev(vsi->netdev);
Could this result in a deadlock when called during a device rebuild?
Looking at i40e_rebuild(), it explicitly acquires the RTNL lock before
proceeding:
drivers/net/ethernet/intel/i40e/i40e_main.c:i40e_rebuild() {
    ...
	if (!lock_acquired)
		rtnl_lock();
	ret = i40e_setup_pf_switch(pf, reinit, true);
    ...
}
If i40e_setup_pf_switch() calls i40e_vsi_reinit_setup() and takes this new
err_netdev path, unregister_netdev() will unconditionally attempt to acquire
rtnl_lock(), leading to a deadlock on the non-recursive mutex.
***

Use unregister_netdevice() when the rebuild path already holds RTNL, and
keep unregister_netdev() for callers that do not. This avoids both
recursive RTNL locking and dropping RTNL in the middle of the VSI unwind
path.

Fixes: bc7d338fbb3f ("i40e: reinit flow for the main VSI")
Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a29a89192a7a..e88cf7cfbd84 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14257,7 +14257,8 @@ static int i40e_vsi_setup_vectors(struct i40e_vsi *vsi)
  * Returns pointer to the successfully allocated and configured VSI sw struct
  * on success, otherwise returns NULL on failure.
  **/
-static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
+static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi,
+					      bool lock_acquired)
 {
 	struct i40e_vsi *main_vsi;
 	u16 alloc_queue_pairs;
@@ -14314,7 +14315,10 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 err_netdev:
 	if (vsi->netdev_registered) {
 		vsi->netdev_registered = false;
-		unregister_netdev(vsi->netdev);
+		if (lock_acquired)
+			unregister_netdevice(vsi->netdev);
+		else
+			unregister_netdev(vsi->netdev);
 		free_netdev(vsi->netdev);
 		vsi->netdev = NULL;
 	}
@@ -15036,7 +15040,7 @@ static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit, bool lock_acqui
 			main_vsi = i40e_vsi_setup(pf, I40E_VSI_MAIN,
 						  uplink_seid, 0);
 		else if (reinit)
-			main_vsi = i40e_vsi_reinit_setup(main_vsi);
+			main_vsi = i40e_vsi_reinit_setup(main_vsi, lock_acquired);
 		if (!main_vsi) {
 			dev_info(&pf->pdev->dev, "setup of MAIN VSI failed\n");
 			i40e_cloud_filter_exit(pf);
-- 
2.43.0

