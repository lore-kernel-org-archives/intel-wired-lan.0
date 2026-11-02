Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E9C606A327
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 10:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=YuI9xAqt;
	dkim=temperror header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BYqwXp3V
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DBF044079D;
	Mon,  2 Nov 2026 10:46:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jus-0f4e7Gfk; Mon,  2 Nov 2026 10:46:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C4FE540730
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793616415;
	b=n8lw2friRTVxUNT6LodXwlrj9SHzFWPLFE6xiQUksFbbqCC8kB8gcQ45hRraCTbjOBUy
	 GLu+fD3LmkYjCoZng+/EkorXAtbldDcfuFR5Qcj3fSQt7NOgjvAkLB8CrZWu/msGrUXi6
	 PxvuozJB4oSR+C0EOo9NiezDek/crTlF8up8EP/7dALYv0eY/jdhy8tYM4ey8FBe2KTP+
	 RaAIBV0bXFTCPP5Hs53B/vNNrxev0c7SrXv2lweiS4RrcWiViDNcd+SllJevqcV9YHrSO
	 vyysoy5P3Sqc49mclL9FHpOyq9r65z2wr+A6AWYMLaNmNDJpEVdgakhtZUQVMg8qeyA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793616415;
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
	bh=SVoFGUf6GXv+tO9V/ODg9yI1Wy2A/J/Aiuj0hfR9kCU=;
	b=sZfDPi9GKdxw+LUl4VOhfaNfEXUCNe3eHPNqYyg1i8vIdWSve1BMjCkrE+Dcr9hf0Ke9
	 25p2phC37JYJeciinHwT5MEtf/Pk0VLhUvg5bV74DKxKJlJYEYeXEkhARGKiV4wQBl2t6
	 dEln2koFCJ+NhogqPhMXJjWX/pKmDMOCyNuC0EYL0j0OCisRwHab4QzH556sWOr071UHq
	 bM4zRQVIX9d8t/fj7OGHFOpUFNHtLzNwRkvVbvjacpurvxdrh/j1SAKpFCTVdc75cHMza
	 Y9Jm6ItryMca63iDNgAHUz4L7bBVMI7nGHtpKlXymkuSYTqHNs9mfiKprBhBAVUoA2g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793616415;
	bh=SVoFGUf6GXv+tO9V/ODg9yI1Wy2A/J/Aiuj0hfR9kCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YuI9xAqtvn01n0HmjFf3k7JNRukJ4iuXbEn75nsOurqzcKRVSn7puj9tz2M4gSAvh
	 0gzfdy2mzeGBvRR/3pe1gCHDV91627ZLu8b57YjNAL71ahmbwAylXU44uyYTIDYqrq
	 URFj5ggHjK/t3cNMnhPHh84LM3fr2zToppmaviQVxLib0ZtL8rVKl2rqvOY9Kf43mS
	 GGfnHmF39WC9mnTTF2npGAyOx0yGMmwomlp09LuVQQG2E2rVrXWYmZqfbe92uM3X2G
	 J05e5nck7DJSOWxqvJUQhNhwcaVDa1QL+h1mvLB7IM12RK4+7a09OSLbg3BD0iF1df
	 1mi0qiXG8BCZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4FE540730;
	Mon,  2 Nov 2026 10:46:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 400BA362
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:46:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 262826065F
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:46:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Y44IpawKzwA for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Nov 2026 10:46:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F07B6607A9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793616411;
 b=R3PkCL1zgwevnIqDUUh0uvKtQgob67WroPwprFkvzBQBlv4cqYX2DGsS7rPG7R1KkAfW
 dM+g7oR/vzfgnyiOeHcTKUngq12K6u9ANfjxzCBmfMEVQLXNndpTvpj3WA/7Z/UUsO6tj
 1ykIuMz1vysWat+vlkirlfm7Hjnd1txNvOZlq5Vm3GoPQRpD8uMHjutEDyZkcmM8/RE2p
 V/f/ZzzkAJoRozemWebJm7IEIQP47OYWSHibN7d3BgOeEdSbLZUM53Ecbd5TLCFv1IHBy
 9s1dgOv4r+UGaFK218vkjjh3f0iYYgDJBBnZ2JbH2xDIlVUhGVJIhnxuAWl10P5DZKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793616411;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=SVoFGUf6GXv+tO9V/ODg9yI1Wy2A/J/Aiuj0hfR9kCU=;
 b=JnIFCXpG8BpS2YoMpsfOWrcAgZJFXzAXgeIzQFjwJxlVykuBVf1z9U/nAj7J1X6RHS1d
 84rALqSsAmIorU5YTyLl11cB0lVjviKq0nUG8Q1o8jNpAhEmOtCHeSm+m1lcqw+85Kffo
 7HAK0VEnLcRFSYmqcsVnX5hw6KXJBWGUSjD07wj6gUbRhNRXry282ZB6aryACpf2LHJJ9
 2QVJN+BmY7/1wY9DvXSwNzlQmbWStU181cS6l2vXywfVXilsMPM+CvKjVqIpQgB8tEFU3
 I+u5y+GqB0cnMdCeYWYzQI8UCXVDaSZlcCKaUVjE4Q2C7JdRC8YMUHSJBUkBlxEWo/A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=BYqwXp3V; 
 arc=none smtp.remote-ip=192.198.163.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=BYqwXp3V
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F07B6607A9
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793616411; x=1825152411;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pdw8KmbRx9IBcuVpZ651l8R1Lkf6/VlhieZIT5z+Drw=;
 b=BYqwXp3VEUBWLqFsgrCteIHKmkoiJMXr69cKc4hXcOgLa2vGs3XSBbI2
 rLMzdaLbD5TUVBNxLH9yrFfl0v+XDXcVIXlsQ9cT0CW9sD7HWKAWuH4Jo
 QqhohVX0gSxyLjOAyLp8Mei4gijRpCUMeiA1n9+bOqPEa0JUL1ZbEidDm
 vS/p0apWO0Q3hhJM5Ku6XofRH0NOIAUKtdcHkYIUigJZD/ARKlPybNATS
 r0NThcpRaiI+Up9DvGaj/vb+R5Bz/waQS32D9Bcs/O+b+rhKbG2adXK/o
 asUOUS+zbdXAyXI0FuaxbVZNf55bkfne1xKNvOKDRRjBjlQwIGpl38hri w==;
X-CSE-ConnectionGUID: TGyO4FyKS/2wwCc+hJq/VA==
X-CSE-MsgGUID: dIRtNBfoSS2Q9Y6OPzsznA==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2305045"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2305045"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 02:46:33 -0800
X-CSE-ConnectionGUID: faVRmSJ5Q7m2XBOK8eA+6g==
X-CSE-MsgGUID: Xh+9+gbTRo+7Qifs5/o1cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6012017"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orviesa004.jf.intel.com with ESMTP; 02 Nov 2026 02:46:32 -0800
Received: from pkitszel-desk1.igk.intel.com (pkitszel-desk1.igk.intel.com
 [10.217.184.18])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 332422876E;
 Mon,  2 Nov 2026 10:46:30 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net 5/6] ice: replace tc_mutex with RTNL
Date: Mon,  2 Nov 2026 11:50:20 +0100
Message-ID: <20261102105346.30739-6-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261102105346.30739-1-przemyslaw.kitszel@intel.com>
References: <20261102105346.30739-1-przemyslaw.kitszel@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ice_setup_tc() takes pf->adev_mutex and the RDMA aux device lock, and then
pf->tc_mutex, for mqprio. dcbnl ops take pf->tc_mutex, and then
pf->adev_mutex in ice_send_event_to_aux(), when ice_pf_dcb_cfg() notifies
the RDMA driver about a TC change. Lockdep reports a possible deadlock:

        CPU0                    CPU1
        ----                    ----
   lock(&pf->adev_mutex);
                                lock(&pf->tc_mutex);
                                lock(&pf->adev_mutex);
   lock(&pf->tc_mutex);

All users of pf->tc_mutex (dcbnl ops, ndo_setup_tc() for mqprio,
ice_dcb_rebuild() and the LLDP MIB change handler) already run under
RTNL, the latter two since they take it first, earlier in this series.
So the inversion can't deadlock, but lockdep still reports it, and the
mutex is redundant. Drop it, instead of reordering it against
pf->adev_mutex.

Reproducer, with RDMA enabled on the PF, but irdma not loaded:
  PF=eth3
  ethtool --set-priv-flags $PF fw-lldp-agent off
  dcb ets set dev $PF tc-tsa all:ets tc-bw all:0 0:50 1:50 prio-tc all:0 4:1
  dcb ets set dev $PF tc-tsa all:ets tc-bw all:0 0:100 prio-tc all:0
  tc qdisc add dev $PF root mqprio num_tc 2 map 0 0 0 0 1 1 1 1 \
          queues 4@0 4@4 hw 1 mode channel

Fixes: 4b31fd4d77ff ("ice: Fix RDMA VSI removal during queue rebuild")
Reported-by: Petr Oros <poros@redhat.com>
Closes: https://lore.kernel.org/all/20261023070258.730168-3-poros@redhat.com/
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |  1 -
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c |  6 ------
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c  | 15 ---------------
 drivers/net/ethernet/intel/ice/ice_main.c    |  4 ----
 4 files changed, 26 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 432da05c48c0..12907be77454 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -592,7 +592,6 @@ struct ice_pf {
 	struct work_struct serv_task;
 	struct mutex avail_q_mutex;	/* protects access to avail_[rx|tx]qs */
 	struct mutex sw_mutex;		/* lock for protecting VSI alloc flow */
-	struct mutex tc_mutex;		/* lock to protect TC changes */
 	struct mutex adev_mutex;	/* lock to protect aux device access */
 	struct mutex lag_mutex;		/* protect ice_lag struct in PF */
 	u32 msg_enable;
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index 59fafd296f1c..5355519726df 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -555,7 +555,6 @@ void ice_dcb_rebuild(struct ice_pf *pf)
 	int ret;
 
 	rtnl_lock();
-	mutex_lock(&pf->tc_mutex);
 
 	ret = ice_query_port_ets(pf->hw.port_info, &buf, sizeof(buf), NULL);
 	if (ret) {
@@ -587,16 +586,14 @@ void ice_dcb_rebuild(struct ice_pf *pf)
 		goto dcb_error;
 	}
 
-	mutex_unlock(&pf->tc_mutex);
 	rtnl_unlock();
 
 	return;
 
 dcb_error:
 	dev_err(dev, "Disabling DCB until new settings occur\n");
 	err_cfg = kzalloc_obj(*err_cfg);
 	if (!err_cfg) {
-		mutex_unlock(&pf->tc_mutex);
 		rtnl_unlock();
 		return;
 	}
@@ -614,7 +611,6 @@ void ice_dcb_rebuild(struct ice_pf *pf)
 	ice_pf_dcb_cfg(pf, err_cfg, true);
 	kfree(err_cfg);
 
-	mutex_unlock(&pf->tc_mutex);
 	rtnl_unlock();
 }
 
@@ -1077,7 +1073,6 @@ ice_dcb_process_lldp_set_mib_change(struct ice_pf *pf,
 
 	/* That a DCB change has happened is now determined */
 	rtnl_lock();
-	mutex_lock(&pf->tc_mutex);
 
 	/* store the old configuration */
 	tmp_dcbx_cfg = pi->qos_cfg.local_dcbx_cfg;
@@ -1142,7 +1137,6 @@ ice_dcb_process_lldp_set_mib_change(struct ice_pf *pf,
 	/* enable previously downed VSIs */
 	ice_dcb_ena_dis_vsi(pf, true, true);
 out:
-	mutex_unlock(&pf->tc_mutex);
 	rtnl_unlock();
 
 	/* Send Execute Pending MIB Change event if it is a Pending event */
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
index 2b9f5e6c1bbe..bc2af975b1e3 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
@@ -78,8 +78,6 @@ static int ice_dcbnl_setets(struct net_device *netdev, struct ieee_ets *ets)
 
 	new_cfg = &pf->hw.port_info->qos_cfg.desired_dcbx_cfg;
 
-	mutex_lock(&pf->tc_mutex);
-
 	new_cfg->etscfg.willing = ets->willing;
 	new_cfg->etscfg.cbs = ets->cbs;
 	ice_for_each_traffic_class(i) {
@@ -117,7 +115,6 @@ static int ice_dcbnl_setets(struct net_device *netdev, struct ieee_ets *ets)
 		err = ICE_DCB_HW_CHG_RST;
 
 ets_out:
-	mutex_unlock(&pf->tc_mutex);
 	return err;
 }
 
@@ -277,8 +274,6 @@ static int ice_dcbnl_setpfc(struct net_device *netdev, struct ieee_pfc *pfc)
 		return -EINVAL;
 	}
 
-	mutex_lock(&pf->tc_mutex);
-
 	new_cfg = &pf->hw.port_info->qos_cfg.desired_dcbx_cfg;
 
 	if (pfc->pfc_cap)
@@ -293,7 +288,6 @@ static int ice_dcbnl_setpfc(struct net_device *netdev, struct ieee_pfc *pfc)
 		ice_dcbnl_devreset(netdev);
 	if (err == ICE_DCB_NO_HW_CHG)
 		err = ICE_DCB_HW_CHG_RST;
-	mutex_unlock(&pf->tc_mutex);
 	return err;
 }
 
@@ -774,9 +768,6 @@ static int ice_dcbnl_setapp(struct net_device *netdev, struct dcb_app *app)
 		return -EINVAL;
 	}
 
-	/* grab TC mutex */
-	mutex_lock(&pf->tc_mutex);
-
 	new_cfg = &pf->hw.port_info->qos_cfg.desired_dcbx_cfg;
 	old_cfg = &pf->hw.port_info->qos_cfg.local_dcbx_cfg;
 
@@ -867,7 +858,6 @@ static int ice_dcbnl_setapp(struct net_device *netdev, struct dcb_app *app)
 		ret = ICE_DCB_NO_HW_CHG;
 
 setapp_out:
-	mutex_unlock(&pf->tc_mutex);
 	return ret;
 }
 
@@ -895,7 +885,6 @@ static int ice_dcbnl_delapp(struct net_device *netdev, struct dcb_app *app)
 		return -EINVAL;
 	}
 
-	mutex_lock(&pf->tc_mutex);
 	old_cfg = &pf->hw.port_info->qos_cfg.local_dcbx_cfg;
 
 	ret = dcb_ieee_delapp(netdev, app);
@@ -978,7 +967,6 @@ static int ice_dcbnl_delapp(struct net_device *netdev, struct dcb_app *app)
 		ret = ICE_DCB_HW_CHG;
 
 delapp_out:
-	mutex_unlock(&pf->tc_mutex);
 	return ret;
 }
 
@@ -1003,11 +991,8 @@ static u8 ice_dcbnl_cee_set_all(struct net_device *netdev)
 
 	new_cfg = &pf->hw.port_info->qos_cfg.desired_dcbx_cfg;
 
-	mutex_lock(&pf->tc_mutex);
-
 	err = ice_pf_dcb_cfg(pf, new_cfg, true);
 
-	mutex_unlock(&pf->tc_mutex);
 	return (err != ICE_DCB_HW_CHG_RST) ? ICE_DCB_NO_HW_CHG : err;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 30de690ecf7c..6b6e5ae533ae 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3876,7 +3876,6 @@ void ice_deinit_pf(struct ice_pf *pf)
 	mutex_destroy(&pf->lag_mutex);
 	mutex_destroy(&pf->adev_mutex);
 	mutex_destroy(&pf->sw_mutex);
-	mutex_destroy(&pf->tc_mutex);
 	mutex_destroy(&pf->avail_q_mutex);
 	mutex_destroy(&pf->vfs.table_lock);
 
@@ -3975,7 +3974,6 @@ int ice_init_pf(struct ice_pf *pf)
 	int err = -ENOMEM;
 
 	mutex_init(&pf->sw_mutex);
-	mutex_init(&pf->tc_mutex);
 	mutex_init(&pf->adev_mutex);
 	mutex_init(&pf->lag_mutex);
 
@@ -9461,9 +9459,7 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 		}
 
 		/* setup traffic classifier for receive side */
-		mutex_lock(&pf->tc_mutex);
 		err = ice_setup_tc_mqprio_qdisc(netdev, type_data);
-		mutex_unlock(&pf->tc_mutex);
 
 adev_unlock:
 		if (locked) {
-- 
2.54.0

