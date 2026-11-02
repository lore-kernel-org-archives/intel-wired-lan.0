Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15DB606A32C
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 10:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=a1tGCsp5;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CHRuMels
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B58A480DE2;
	Mon,  2 Nov 2026 10:46:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JHmMFZOE3D0j; Mon,  2 Nov 2026 10:46:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D564680F72
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793616414;
	b=W9Xx3Xax4rQuOuZNEPpYuWsGTWFH+B7WxA/YsVfmlcbMrb7c7P43/NywOg5TEZfKy//Z
	 hYvmq2B5GqyybAsv/wRPYBSAFzkKPoG2DIgTsf7Fg9DrmUhgLuq6bl7rCr71XLBrNM4ct
	 NIRQRnzqN16K1l08fyQBEJgdDM5Ap/zguyVfqrgOj0Z+8nXuHqKtlCvvZgAIoSm9maDcv
	 qSUY0L3S7pylg8WlYJS/NuSt1AHm3PiqkYnnPAwMJ4ohQoFRmGVGh9ofVv2hKUAtgyK79
	 lfE7jsrADqZAMFLAwEpPO7O2JCM8/yq2aeu3tpj+xOOWfe1vXZogAcWW8NgLsyDVyOw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793616414;
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
	bh=l+TZkyelYqDiKLngkZfqLvg/0jB/ZxDpVjN7nX2qCLw=;
	b=VJuRLkWtyWG85tWy8I/seEy71aQK4YcxNmLn3Ojy/1bJqaAoNE4hLV85bG6NlAw9/Iii
	 Fh150FWc7lFI1jJEJFOTOQZNQ+D57EIF0qTZlLUVWfYbf+EiMPQ4R6vX9pMpQwqe3LS1/
	 QZ4ep66Rc1GEuyd5upv5mL5ISEA9mV7zYDY/gu9n1pl+iCKu8ijjZStVWEKgfpiqWTh60
	 s/lpf3itbP/AerXJV2r+7PJX1suZleDy372iLi+Pevn6rNJxCCz9ECbz49ETj27t0hdOj
	 u7uI7h3ncoHNZJPfeM+DUltHYW4pyV/KGC4/j0UN7ChX9Gb55vG7dMyWxnHlhiZunAA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793616414;
	bh=l+TZkyelYqDiKLngkZfqLvg/0jB/ZxDpVjN7nX2qCLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a1tGCsp5ziagoXnyh1CKR6Sycf+ney3NScV7JxvZ6GcqYZZWYeZoN/qr/sOcaSLZD
	 SHyeA+Ogd4lUZ/8wZ+eBNXB9FPaix7ktWg7kziyl4QJsEo5AfXONiW3Fbab3fjonhf
	 mddp9urN4+9ovSwdamtNFj/hBZPoxGKAIGCd9In2VtkxsbqhM20QA07y18N1XnkbIh
	 Wc65rZDCJRyqPHs+j6MEQFfi7YNYAzXGSesqLtXLWR6/eTfHyxb/X9WUysmQzNMDdh
	 g1EQXUsFwgx2vZHLKpG6RGwARjJLgWIKXztaa4fBisiKderqZjELzTjAFKS8+qKVb7
	 XzhLYnWb2wwMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D564680F72;
	Mon,  2 Nov 2026 10:46:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DA79ED3A
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:46:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C11856076F
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:46:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jcIBM3AvgJK9 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Nov 2026 10:46:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BC0BD6065F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793616410;
 b=EBUzMl32irG0kOvR1HjyLrSsbGf+W/0SQD3BVKlBwj6/D564WYid2VSHby3FBOgdc3p0
 etdvXjcMBZcfWfzW6xPxe39eCWUoQ6+2sbZkMjGCLBs75qujhjvxvz48intN+8rYqmAsj
 tNRcWve8poGM6W/Zi9tDHXYug8d+52hBVY8+r+vAAMxKBogHd/UVkOAY0x2bd/Q3wtqod
 qGvyajY8yOyZ/sxkW/++GoW1kA6B5ePkELddzcIXlOtDgbhlZvsFmAwaZrktcAYFpVVxF
 W+8eVRgIGkvK94I49VUvuwQ3cYZiLiYX1kWZYG6zn76tVnTcinTAZXb7vx58N4AOqLQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793616410;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=l+TZkyelYqDiKLngkZfqLvg/0jB/ZxDpVjN7nX2qCLw=;
 b=WYZtuWqMNxN2V3F8LWBaXE4HHUcSKByhKRRCECBzSG4liLftk2vVuh4uFVqpAaas5fzE
 +Dl6Mqylbki4W4YBNCg7qwvK4zKZ0oxLgvKB3T67V2vQRGaJn+WN1Zfiz0wUKSn9tyn1y
 kMGuLHrSSLwvlSEBhxhif8XA16C2osXnMo7A4jXrW406KESuwbfxHKaDtSUmquBk927ot
 yRGeMi4Xan30XsJXcRNMXiWx9i8C228Kj1u4mtkrUVfxxZNhpR72if71FfCGZyacFkuSq
 ktM61tbCWS0aVwvx0J0HxTTsAlHwNzfM7FReTc/co0HvuY6GU9sN4H+Ot7cVz7zJkMQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CHRuMels; 
 arc=none smtp.remote-ip=192.198.163.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=CHRuMels
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BC0BD6065F
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793616410; x=1825152410;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BSArHzWMJ0NSjxImgxT/Jbvl0fCoNAZt0L1fUjQa7xM=;
 b=CHRuMels6k24vNYdPd+yklw9AbSQIY9cJaTwxqlib3DuI51hEzG6LKHp
 0eAzWdjMbnHWlu6lfUo9h5e7tlUc2PGMM5YL+Z8QNaZTg8K/Uu01hLJW4
 nvk/FDkzeLZKLOrZudf9TC53IPd7NuCiqoirxw/P9XL+12M4MIEnluPQq
 jquKl9ygLCdL8LzHtYpVflBL2GEhPoldwVEruuqJ8l0d31eiFQcdt9YfI
 d7c7OcNOQihz8AakWv/gZNp7WDTtSPdMYLmHIP0bDYXocnlYeF3l0th6c
 SmSCr9tFoP6mpL146/YwJSeIWWDnP82h7QihkrUeCef2EufRokqiObBAi g==;
X-CSE-ConnectionGUID: 6wuY9T8nR0uYCqCXAzvsgw==
X-CSE-MsgGUID: pu4fPAPFQeirZ8uhWhld7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2305049"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2305049"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 02:46:34 -0800
X-CSE-ConnectionGUID: cn0WbREaQJuXx391DUdVsQ==
X-CSE-MsgGUID: wBlMzVeyQcSi8k1et+YpfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6012020"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orviesa004.jf.intel.com with ESMTP; 02 Nov 2026 02:46:31 -0800
Received: from pkitszel-desk1.igk.intel.com (pkitszel-desk1.igk.intel.com
 [10.217.184.18])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id B8A862876D;
 Mon,  2 Nov 2026 10:46:29 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net 4/6] ice: don't block on locks in
 ice_tear_down_devlink_rate_tree()
Date: Mon,  2 Nov 2026 11:50:19 +0100
Message-ID: <20261102105346.30739-5-przemyslaw.kitszel@intel.com>
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ice_tear_down_devlink_rate_tree() is called with RTNL held (dcbnl, mqprio),
and then blocks on the PF devlink lock and pf->vfs.table_lock, both of which
are taken the other way around elsewhere:
 - ice_start_vfs() and ice_free_vfs() hold table_lock and call
   ice_eswitch_{attach,detach}_vf(), which take the PF devlink lock and
   register/unregister representor netdevs (so RTNL).
 - ice_probe() holds the devlink lock across ice_load(), which registers
   the netdev (so RTNL).

Lockdep reports a possible ABBA deadlock:

        CPU0                    CPU1
        ----                    ----
   lock(&pf->vfs.table_lock);
                                lock(&devlink->lock_key);
                                lock(&pf->vfs.table_lock);
   lock(&devlink->lock_key);

Swapping the two locks would only fix this particular pair, as the RTNL
inversion would remain. Instead, only try both locks and fail with -EAGAIN
when either is contended, unlike the -EBUSY of an enabled custom Tx
scheduler.

Return early, without taking any lock, when no tree is exported: always
when switchdev is not running, and also after DCB got enabled, as the tree
is not exported again then. The latter is checked by rate_node pointers of
the Tx scheduler nodes, under the scheduler lock, unless the scheduler is
not ready (during a reset). This way DCB and mqprio configuration fails on
contention only when there is a tree to tear down. It also covers
ice_pf_dcb_cfg() with locked == false, called from probe or devlink reload,
where the devlink lock is already held and RTNL is not.

Propagate the error to the callers that can report it: dcbnl ops and
mqprio. For that, stop ice_dcbnl_setapp() from folding all errors into
ICE_DCB_NO_HW_CHG. ice_dcbnl_setapp() updates the app list, and may switch
the FW to DSCP mode, before it calls ice_pf_dcb_cfg(). To fail before any
change in the usual case, move the custom Tx scheduler check and the
teardown into a helper, and call it from ice_dcbnl_setapp() first.
ice_dcbnl_delapp() does not add TCs, so it has no tree to tear down.

ice_dcbnl_cee_set_all() returns a u8 status, not an errno, so it can't
report -EAGAIN, but the desired config is kept and a retry applies it.
DCB init, called from ethtool priv flags, already ignores ice_pf_dcb_cfg()
failures.

Found during development, reproducer:
  PF=ens801f7np7
  BDF=$(basename $(readlink /sys/class/net/$PF/device))
  ethtool --set-priv-flags $PF fw-lldp-agent off
  devlink dev eswitch set pci/$BDF mode switchdev
  echo 2 > /sys/class/net/$PF/device/sriov_numvfs
  dcb ets set dev $PF tc-tsa all:ets tc-bw all:0 0:50 1:50 prio-tc all:0 4:1

Fixes: fff292b47ac1 ("ice: add VF representors one by one")
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 .../net/ethernet/intel/ice/devlink/devlink.h  |  2 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.h  |  1 +
 .../net/ethernet/intel/ice/devlink/devlink.c  | 47 +++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  | 27 +++++++++--
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c   | 15 +++++-
 drivers/net/ethernet/intel/ice/ice_main.c     |  4 +-
 6 files changed, 83 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.h b/drivers/net/ethernet/intel/ice/devlink/devlink.h
index 1af3b0763fbb..4139171ca57c 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.h
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.h
@@ -20,7 +20,7 @@ void ice_devlink_init_regions(struct ice_pf *pf);
 void ice_devlink_destroy_regions(struct ice_pf *pf);
 
 int ice_devlink_rate_init_tx_topology(struct devlink *devlink, struct ice_vsi *vsi);
-void ice_tear_down_devlink_rate_tree(struct ice_pf *pf);
+int ice_tear_down_devlink_rate_tree(struct ice_pf *pf);
 void ice_devlink_rate_clear_tx_topology(struct ice_vsi *vsi);
 
 #endif /* _ICE_DEVLINK_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.h b/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
index da9ba814b4e8..dd00cb459212 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
@@ -20,6 +20,7 @@ u8 ice_dcb_get_num_tc(struct ice_dcbx_cfg *dcbcfg);
 void ice_vsi_set_dcb_tc_cfg(struct ice_vsi *vsi);
 bool ice_is_pfc_causing_hung_q(struct ice_pf *pf, unsigned int txqueue);
 u8 ice_dcb_get_tc(struct ice_vsi *vsi, int queue_index);
+int ice_dcb_prep_multi_tc(struct ice_pf *pf);
 int
 ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dcbx_cfg *new_cfg, bool locked);
 int ice_dcb_bwchk(struct ice_pf *pf, struct ice_dcbx_cfg *dcbcfg);
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 044aa62be473..c94bc75e448e 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -683,31 +683,68 @@ static int ice_devlink_tx_sched_layers_validate(struct devlink *devlink, u32 id,
 	return 0;
 }
 
+static bool ice_devlink_rate_tree_is_exported(struct ice_port_info *pi)
+{
+	struct ice_sched_node *tc_node;
+	bool exported = false;
+
+	if (pi->port_state != ICE_SCHED_PORT_STATE_READY)
+		return false;
+
+	mutex_lock(&pi->sched_lock);
+	tc_node = pi->root->children[0];
+	for (int i = 0; i < tc_node->num_children; i++) {
+		if (tc_node->children[i]->rate_node) {
+			exported = true;
+			break;
+		}
+	}
+	mutex_unlock(&pi->sched_lock);
+
+	return exported;
+}
+
 /**
  * ice_tear_down_devlink_rate_tree - removes devlink-rate exported tree
  * @pf: pf struct
  *
  * This function tears down tree exported during VF's creation.
+ *
+ * Return: 0 on success or when no tree is exported, -EAGAIN if a lock could
+ * not be taken.
  */
-void ice_tear_down_devlink_rate_tree(struct ice_pf *pf)
+int ice_tear_down_devlink_rate_tree(struct ice_pf *pf)
 {
 	struct devlink *devlink;
 	struct ice_vf *vf;
 	unsigned int bkt;
 
+	/* The tree is exported only when switchdev is running */
+	if (!ice_is_switchdev_running(pf) ||
+	    !ice_devlink_rate_tree_is_exported(pf->hw.port_info))
+		return 0;
+
+	ASSERT_RTNL();
+
 	devlink = priv_to_devlink(pf);
 
-	devl_lock(devlink);
-	mutex_lock(&pf->vfs.table_lock);
+	/* Both locks are taken before RTNL elsewhere, so only try them here */
+	if (!mutex_trylock(&pf->vfs.table_lock))
+		return -EAGAIN;
+	if (!devl_trylock(devlink)) {
+		mutex_unlock(&pf->vfs.table_lock);
+		return -EAGAIN;
+	}
 	ice_for_each_vf(pf, bkt, vf) {
 		if (vf->devlink_port.devlink_rate)
 			devl_rate_leaf_destroy(&vf->devlink_port);
 	}
-	mutex_unlock(&pf->vfs.table_lock);
-
 	ice_devlink_rate_clear_tx_topology(ice_get_main_vsi(pf));
 	devl_rate_nodes_destroy(devlink);
 	devl_unlock(devlink);
+	mutex_unlock(&pf->vfs.table_lock);
+
+	return 0;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index 3034f461f513..59fafd296f1c 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -341,6 +341,23 @@ int ice_dcb_bwchk(struct ice_pf *pf, struct ice_dcbx_cfg *dcbcfg)
 	return 0;
 }
 
+/**
+ * ice_dcb_prep_multi_tc - prepare the Tx scheduler for more than one TC
+ * @pf: pointer to the PF struct
+ *
+ * Return: 0 on success, -EBUSY if the Tx scheduler is customized via
+ * devlink-rate, -EAGAIN if its devlink-rate export could not be torn down.
+ */
+int ice_dcb_prep_multi_tc(struct ice_pf *pf)
+{
+	if (pf->hw.port_info->is_custom_tx_enabled) {
+		dev_err(ice_pf_to_dev(pf), "Custom Tx scheduler feature enabled, can't configure DCB\n");
+		return -EBUSY;
+	}
+
+	return ice_tear_down_devlink_rate_tree(pf);
+}
+
 /**
  * ice_pf_dcb_cfg - Apply new DCB configuration
  * @pf: pointer to the PF struct
@@ -364,12 +381,12 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dcbx_cfg *new_cfg, bool locked)
 
 	/* Enable DCB tagging only when more than one TC */
 	if (ice_dcb_get_num_tc(new_cfg) > 1) {
+		int err;
+
 		dev_dbg(dev, "DCB tagging enabled (num TC > 1)\n");
-		if (pf->hw.port_info->is_custom_tx_enabled) {
-			dev_err(dev, "Custom Tx scheduler feature enabled, can't configure DCB\n");
-			return -EBUSY;
-		}
-		ice_tear_down_devlink_rate_tree(pf);
+		err = ice_dcb_prep_multi_tc(pf);
+		if (err)
+			return err;
 
 		set_bit(ICE_FLAG_DCB_ENA, pf->flags);
 	} else {
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
index 9cdb9581fdc3..2b9f5e6c1bbe 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
@@ -736,6 +736,7 @@ static int ice_dcbnl_setapp(struct net_device *netdev, struct dcb_app *app)
 	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	struct ice_dcb_app_priority_table new_app;
 	struct ice_dcbx_cfg *old_cfg, *new_cfg;
+	int tc_to_prep;
 	u8 max_tc;
 	int ret;
 
@@ -779,6 +780,18 @@ static int ice_dcbnl_setapp(struct net_device *netdev, struct dcb_app *app)
 	new_cfg = &pf->hw.port_info->qos_cfg.desired_dcbx_cfg;
 	old_cfg = &pf->hw.port_info->qos_cfg.local_dcbx_cfg;
 
+	/* fail before any change; switching to DSCP mode enables max_tc TCs */
+	if (old_cfg->pfc_mode == ICE_QOS_MODE_VLAN)
+		tc_to_prep = max_tc;
+	else
+		tc_to_prep = ice_dcb_get_num_tc(new_cfg);
+
+	if (tc_to_prep > 1) {
+		ret = ice_dcb_prep_multi_tc(pf);
+		if (ret)
+			goto setapp_out;
+	}
+
 	ret = dcb_ieee_setapp(netdev, app);
 	if (ret)
 		goto setapp_out;
@@ -850,7 +863,7 @@ static int ice_dcbnl_setapp(struct net_device *netdev, struct dcb_app *app)
 	/* return of zero indicates new cfg applied */
 	if (ret == ICE_DCB_HW_CHG_RST)
 		ice_dcbnl_devreset(netdev);
-	else
+	else if (ret > 0)
 		ret = ICE_DCB_NO_HW_CHG;
 
 setapp_out:
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 454fba07d4ec..30de690ecf7c 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -9180,7 +9180,9 @@ static int ice_setup_tc_mqprio_qdisc(struct net_device *netdev, void *type_data)
 			dev_err(dev, "Custom Tx scheduler feature enabled, can't configure ADQ\n");
 			return -EBUSY;
 		}
-		ice_tear_down_devlink_rate_tree(pf);
+		ret = ice_tear_down_devlink_rate_tree(pf);
+		if (ret)
+			return ret;
 
 		ret = ice_validate_mqprio_qopt(vsi, mqprio_qopt);
 		if (ret) {
-- 
2.54.0

