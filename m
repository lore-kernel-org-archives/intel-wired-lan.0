Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D1E606A31C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Nov 2026 08:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=I7fcD9MB;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tq9d5Rln
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4651380E45;
	Fri, 27 Nov 2026 08:57:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YgVOB4jypj4u; Fri, 27 Nov 2026 08:57:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4D9D7811A5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795769878;
	b=WXsaDBl40S2ypEzTFnhaiTrHBt7ebnR6KziKDIIetUsBfrm1pthSJXVupt2JVFZQZDlC
	 KHzGuHV4LUo6Mo+ipygBSk3DRFb1T5NwVtyPWuPpbA/nmySlVO2DfSsdBR9ZbLhvzStSL
	 R2gmSVouU+wQWIo1muhHQsAk61mgvAQ4cpMfT7FyuBEEqtnMyJpsCx2GIKg/s9KGpJC/S
	 ByLuNCsvcOGgdDGCC5N8nxDuaZ2GvEzhSSHLg7R/rHp8Mi8e/DzJ0bh1S9gFKpJ8+zl2T
	 3bAinNV5gdf/5jNuDSETiGzKQNxbkPpp+O/Z49tFRCUJq3dXfD78n9cm7kevxZxqpmw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795769878;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-MC-Rep:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pGItFsxuB0+ywnPwyerD8G3BjwdYG0IkHkd0t9qWHVc=;
	b=iDfusk2eQ4vlvfxIFjAFonh5B8Qw1grY438IyjB+O/W/QJlBc5bF1OILH8ItzB4zDzeF
	 KDce/AhQJhvNAtaFqazm0G3FVBXvAAf9xsgbJIguBaL/3Ur+ciAYyxXQjpLtY+0NWOUKM
	 dV58tMCZhWhEFQ1RAjQkTUZwCcUY1IFOndcLWTCDUDi+z1P0E3rDtVW23sGPmYb1WYcTQ
	 fttacZIr9KNN/LhR3RnrmmXGrpEanitQhjJNPqjYkOCPVAZv6A+ZOB3Dz4mK9db/kPjzp
	 qMHPd/+Eahy/zFvbBX5U4UO4nRUP0sako1s/Ax61Y8DOtsGVFLn+hwEOnDR1pVfz/bg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795769878;
	bh=pGItFsxuB0+ywnPwyerD8G3BjwdYG0IkHkd0t9qWHVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I7fcD9MBZassp4j9jVdDy7SlSZ+a6nOIJcoj/JCreeVX3NbrHB7thn0K+nFpjnYBv
	 NlU3wfhZZnEAqItGBv9vnBZQO2XqxyYNITWANZMpQRYbtGhMSPmjOsL+8fbBeVYDkg
	 egmcNXA+GLSXWGNKecGFsIlFut96+43KYdGefv5cluVAIqCnBzTBAw64FrhcVfpz2G
	 Fl//AbOvcZT5rVyrQd5fSObq0O2uTvz6dj9QpnN7ncnextTnUy4kNAYO0vxksC//bq
	 Zcyo2n1cxPm6CkayCsKmgHifJrE6x+ICyc2tb0H8FowK6N2DKhNW8pnFh6/W+aTNYb
	 8m3u2UpddRHtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D9D7811A5;
	Fri, 27 Nov 2026 08:57:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 64FBE311
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 08:57:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 55A9B40A3B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 08:57:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nsWczooA4yYF for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Nov 2026 08:57:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2B24640A36
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tq9d5Rln
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2B24640A36
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 08:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795769876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pGItFsxuB0+ywnPwyerD8G3BjwdYG0IkHkd0t9qWHVc=;
 b=Tq9d5RlnLW/SlT0VjuH5WcpSWtEXy8FSkbMnYiR1mKqX7Z5Nobd0L9u0ZhSzPjAlnVZXjP
 YzT+3gvvjC4HEi8LmIUV0WqMWjy69j+5201YBMF5wwD876dxYG0O7PD+QOPUS4GNj4yR5f
 mNk/LWV3nz+Ru4FukkX80LwHtdlXpus=
X-MC-Rep: binary re single
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-BPhrlezOO3C5l9N-nzhhdA-1; Fri,
 27 Nov 2026 08:57:48 +0000
X-MC-Unique: BPhrlezOO3C5l9N-nzhhdA-1
X-Mimecast-MFC-AGG-ID: BPhrlezOO3C5l9N-nzhhdA_1795769865
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D6F41944A92; Fri, 27 Nov 2026 08:57:45 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.48.12])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 38A67428; Fri, 27 Nov 2026 08:57:39 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Simon Horman <horms@kernel.org>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 Wojciech Drewek <wojciech.drewek@intel.com>,
 Marcin Szycik <marcin.szycik@linux.intel.com>,
 Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
 Ivan Vecera <ivecera@redhat.com>, Alice Michael <alice.michael@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 Patryk Holda <patryk.holda@intel.com>, Rinitha S <sx.rinitha@intel.com>,
 Aaron Ma <aaron.ma@canonical.com>, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH net v5 3/4] ice: resync uplink filters after a switchdev
 session
Date: Fri, 27 Nov 2026 09:57:08 +0100
Message-ID: <20261127085714.1207361-4-poros@redhat.com>
In-Reply-To: <20261127085714.1207361-1-poros@redhat.com>
References: <20261127085714.1207361-1-poros@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: ybFrWqNzvL2PLdgNsyYbp39MAsTMh6PZiA-l318jmpI_1795769865
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A switchdev session leaves the uplink filters out of sync with its
netdev. ice_eswitch_setup_env() removes the multicast promisc rules and
the address filters, and ice_eswitch_release_env() removes the default
VSI (DFLT) Rx rule that a promiscuous uplink needs. ice_set_rx_mode()
ignores the uplink during the session and nothing syncs it when the
session ends, so these are not installed again, and flag changes made
meanwhile are lost.

Let the eswitch own the uplink promisc configuration during a session.
While the new ICE_VSI_ESWITCH_UPLINK bit is set, ice_vsi_sync_fltr()
leaves it alone. When the session ends, after is_running is cleared,
ice_eswitch_resync_uplink() clears the bit and queues a full filter
sync, which programs the uplink from the netdev flags. Also subscribe a
promiscuous VSI to multicast when it already holds the DFLT rule, and
enable VLAN pruning on every promisc off, because it can be off without
our DFLT rule after a session or with LAG.

This does not restore the uplink VLAN filters that
ice_eswitch_setup_env() removes, a separate problem that now also shows
when promisc is cleared after a promiscuous session.

Found by AI code review, starting with the Sashiko review of v4, and
reproduced on an E810-C (FW 8.1.1, ICE COMMS package 1.3.55.0) without
kernel changes:

  ip link set $PF promisc on
  devlink dev eswitch set pci/$BDF mode switchdev
  echo 1 > /sys/class/net/$PF/device/sriov_numvfs
  echo 0 > /sys/class/net/$PF/device/sriov_numvfs

after which unknown unicast no longer reaches the PF, and with this
patch it does again. Also tested on that E810-C with promisc changed
before, during and after sessions, allmulti across a session, and PF
resets and driver removal during sessions. LAG and switchdev setup
errors were not tested. No kernel selftests cover this.

Fixes: 1a1c40df2e80 ("ice: set and release switchdev environment")
Fixes: 2571a3fa6251 ("ice: Prohibit rx mode change in switchdev mode")
Fixes: 5c07be96d8b3 ("ice: Avoid setting default Rx VSI twice in switchdev setup")
Fixes: 776fe19953b0 ("ice: block default rule setting on LAG interface")
Signed-off-by: Petr Oros <poros@redhat.com>
---
v5:
- Reworked after the Sashiko review of the v4 pull. Instead of keeping
  the Rx DFLT rule on release, the eswitch now owns the uplink promisc
  configuration during a session, and the uplink filters are resynced
  from the netdev flags when the session ends.
- A new VSI state bit keeps filter syncs away from the uplink promisc
  configuration during a session. The sync queued at the end of a
  session relies on patch 1 when the PF goes away.
- A promiscuous VSI that already holds the DFLT rule is subscribed to
  multicast, and VLAN pruning is re-enabled on every promisc off.
- New title, was "ice: preserve uplink DFLT Rx rule on switchdev
  release". Moved before the multicast patch.
- Added Fixes tags for 1a1c40df2e80, 2571a3fa6251 and 776fe19953b0.
- Dropped the Reviewed-by and Tested-by tags because of the rework.

v4: https://lore.kernel.org/all/20260708125755.706263-3-poros@redhat.com/
v3: https://lore.kernel.org/all/20260701133601.2118382-3-poros@redhat.com/
v2: https://lore.kernel.org/all/20260622113428.2565255-3-poros@redhat.com/
v1: https://lore.kernel.org/all/deef5756e534ef06c12d910c5305d3fd205d30a0.1781786935.git.poros@redhat.com/
---
 drivers/net/ethernet/intel/ice/ice.h         |  1 +
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 40 ++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_main.c    | 17 +++++++--
 3 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 432da05c48c08a..a1b373e04bab30 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -321,6 +321,7 @@ enum ice_vsi_state {
 	ICE_VSI_MMAC_FLTR_CHANGED,
 	ICE_VSI_PROMISC_CHANGED,
 	ICE_VSI_REBUILD_PENDING,
+	ICE_VSI_ESWITCH_UPLINK,		/* eswitch owns the promisc config */
 	ICE_VSI_STATE_NBITS		/* must be last */
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index c96b201901f48c..d55c70edb7f7f6 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -10,6 +10,34 @@
 #include "devlink/devlink.h"
 #include "ice_tc_lib.h"
 
+/**
+ * ice_eswitch_resync_uplink - hand the uplink filters back after switchdev
+ * @uplink_vsi: the uplink VSI
+ */
+static void ice_eswitch_resync_uplink(struct ice_vsi *uplink_vsi)
+{
+	struct ice_pf *pf = uplink_vsi->back;
+
+	while (test_and_set_bit(ICE_CFG_BUSY, uplink_vsi->state))
+		usleep_range(1000, 2000);
+
+	/* VLAN changes during the session may have added these */
+	ice_fltr_clear_vlan_vsi_promisc(&pf->hw, uplink_vsi,
+					ICE_MCAST_VLAN_PROMISC_BITS);
+	ice_fltr_clear_vsi_promisc(&pf->hw, uplink_vsi->idx,
+				   ICE_MCAST_PROMISC_BITS, 0);
+	uplink_vsi->current_netdev_flags &= ~IFF_ALLMULTI;
+
+	clear_bit(ICE_VSI_ESWITCH_UPLINK, uplink_vsi->state);
+	set_bit(ICE_VSI_PROMISC_CHANGED, uplink_vsi->state);
+	set_bit(ICE_VSI_UMAC_FLTR_CHANGED, uplink_vsi->state);
+	set_bit(ICE_VSI_MMAC_FLTR_CHANGED, uplink_vsi->state);
+	clear_bit_unlock(ICE_CFG_BUSY, uplink_vsi->state);
+
+	set_bit(ICE_FLAG_FLTR_SYNC, pf->flags);
+	ice_service_task_schedule(pf);
+}
+
 /**
  * ice_eswitch_setup_env - configure eswitch HW filters
  * @pf: pointer to PF struct
@@ -28,6 +56,12 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
 		if (ice_down(uplink_vsi))
 			return -ENODEV;
 
+	/* the eswitch owns the uplink promisc config until the resync */
+	while (test_and_set_bit(ICE_CFG_BUSY, uplink_vsi->state))
+		usleep_range(1000, 2000);
+	set_bit(ICE_VSI_ESWITCH_UPLINK, uplink_vsi->state);
+	clear_bit_unlock(ICE_CFG_BUSY, uplink_vsi->state);
+
 	ice_remove_vsi_fltr(&pf->hw, uplink_vsi->idx);
 	ice_vsi_cfg_sw_lldp(uplink_vsi, true, false);
 
@@ -77,6 +111,8 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
 	if (if_running)
 		ice_up(uplink_vsi);
 
+	ice_eswitch_resync_uplink(uplink_vsi);
+
 	return -ENODEV;
 }
 
@@ -318,6 +354,7 @@ static int ice_eswitch_enable_switchdev(struct ice_pf *pf)
 
 err_br_offloads:
 	ice_eswitch_release_env(pf);
+	ice_eswitch_resync_uplink(uplink_vsi);
 	return -ENODEV;
 }
 
@@ -331,6 +368,9 @@ static void ice_eswitch_disable_switchdev(struct ice_pf *pf)
 	ice_eswitch_release_env(pf);
 
 	pf->eswitch.is_running = false;
+
+	/* after is_running is cleared, so no rx mode change is lost */
+	ice_eswitch_resync_uplink(pf->eswitch.uplink_vsi);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 6dede87b78944f..2ce2b7138f6682 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -394,6 +394,10 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
 		}
 	}
 	err = 0;
+	/* the eswitch owns the uplink promisc config during a session */
+	if (test_bit(ICE_VSI_ESWITCH_UPLINK, vsi->state))
+		goto exit;
+
 	/* check for changes in promiscuous modes */
 	if (changed_flags & IFF_ALLMULTI) {
 		if (vsi->current_netdev_flags & IFF_ALLMULTI) {
@@ -438,6 +442,12 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
 						      ICE_MCAST_PROMISC_BITS);
 				if (err)
 					goto out_promisc;
+			} else if (ice_is_vsi_dflt_vsi(vsi)) {
+				/* still the default VSI, so subscribe it */
+				err = ice_set_promisc(vsi,
+						      ICE_MCAST_PROMISC_BITS);
+				if (err)
+					goto out_promisc;
 			}
 		} else {
 			/* Clear Rx filter to remove traffic from wire */
@@ -450,11 +460,12 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
 						IFF_PROMISC;
 					goto out_promisc;
 				}
-				if (vsi->netdev->features &
-				    NETIF_F_HW_VLAN_CTAG_FILTER)
-					vlan_ops->ena_rx_filtering(vsi);
 			}
 
+			/* pruning can be off even without our DFLT rule */
+			if (vsi->netdev->features & NETIF_F_HW_VLAN_CTAG_FILTER)
+				vlan_ops->ena_rx_filtering(vsi);
+
 			/* disable allmulti here, but only if allmulti is not
 			 * still enabled for the netdev
 			 */
-- 
2.56.1

