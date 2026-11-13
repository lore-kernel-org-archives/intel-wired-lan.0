Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5273B606A330
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Nov 2026 16:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=VQth36tT;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FN61A5Lf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2CBE581161;
	Fri, 13 Nov 2026 16:15:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N8x7DbaN7hB7; Fri, 13 Nov 2026 16:15:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 02AA0813D5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794586529;
	b=dm23zfw1+8jsOudeLsKVxCgIDLrOax6YzvGacbX+rlyDLc9AtX3wF12HaWbQZn3bNtVK
	 KxvztzlCi0NQ4BS8V0GF/QZRSAWTlwOit9RbdYWQ8iEaXAr/gI70tXjNVG8xczv0fQoY/
	 NDOi+qYGec+d87zI0PbGPGVxGNc9fUernZljg1tDtZ8MX6L0N7AwjGMj/kXy3PLRWsa4a
	 PwDvcJn/X75cKEB6LCQXpTiiCImGs98iSW3kz7eYB3nDS1WTyZhlq/qdFQ7UAheLFxL4U
	 msZ4kbP5/RcZVytUzRIwA+LMi5SSkyFOxO0nHn1PEO4urtmbBNHEOFObxH+X/SElZLA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794586529;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rsaDk08NruTMc95xzf3A9/pVNvkXYnP21FzKlQuOIPc=;
	b=HQQy2zfX/T/W0Aiu0xFS6OjzxzO72EfiRkdbZnIkxnDZ8fFm3R+6DQctMQ1dRdZG8XW2
	 aZOaKcE0A9PDTyobaGXpe9/71iEP+3NLt0a5Ev9IQzeZReuL3di8wrBcg9ysPVmI9/SZR
	 0oo2A/MvAqCzI4JyPg1efRzxlQeAngIKYnvi1ES5IEiGQ6Kugz4zzo711L6t4Vyo8U5NB
	 UBg0s5Fh4vpc+6TZNA6Ltej1KmgVM1nd1VEnUAkdJ6C+F9w947/pXCfU9SxjBXaA17mA4
	 US12rmI+oJJiqiOyaVuE2FAal98+Dl5kGdFDogIp5kBEbbFn+h031CwfdU+0oITHJDA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FN61A5Lf;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794586529;
	bh=rsaDk08NruTMc95xzf3A9/pVNvkXYnP21FzKlQuOIPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VQth36tTk2RoD0BiJpEkrWo2UhLu22quFeSgcIUhZytgrCNn2WT8oMuzqnUjuTZTI
	 Ly1Xx2z0lgHPVHvFEhFkbZSbsBHn3WEk9Mfnekt0LJMkEOnvf/LlUZaxLyRV3aRdpR
	 JdnvSccFLpC7DzVjYOKkcsgZuCGuR3hvAiSinN9Jwqdq3cCqzUg7qL+Edlqx1i0xEL
	 t1RSnxzzxPCsMiidPx80JAKla0Y9qbN/LsfLzN+7rkqoRpmczj958E/PHsPJmXAjFj
	 ifhi7yChYmEGyUGqb7A8An6WxYvr5kJW8A7tFdQxU3fyHH7qzmw7SL+Rc6AxEqoauz
	 3TITUzBSiweFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02AA0813D5;
	Fri, 13 Nov 2026 16:15:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 93ED2AF8
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 16:15:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8556C813D5
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 16:15:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aNSwFCMLNdQZ for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Nov 2026 16:15:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 329F281161
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=FN61A5Lf
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id 329F281161
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 16:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794586524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rsaDk08NruTMc95xzf3A9/pVNvkXYnP21FzKlQuOIPc=;
 b=FN61A5LfjwVRrLI4obWTLCYYwtv1pJAmiOaqEf0QLsfL1py61S2HjD32LdUXh7Jk1ZiY4y
 +Y0XxWgZ7WuovPD42OyPv36EN/xo481TUN72bW5iORoCDGIXC/HvfEGNbSs19pJrT7DFDK
 uyNJUwH6N2U3J4/8BoHl6K5NHybn6Ag=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-ueAqyFbxPzqfveYY_NvFiQ-1; Fri,
 13 Nov 2026 11:15:18 -0500
X-MC-Unique: ueAqyFbxPzqfveYY_NvFiQ-1
X-Mimecast-MFC-AGG-ID: ueAqyFbxPzqfveYY_NvFiQ_1794586516
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31F711955EB5; Fri, 13 Nov 2026 16:15:16 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3BDAD1800550; Fri, 13 Nov 2026 16:15:10 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Dave Ertman <david.m.ertman@intel.com>,
 Mateusz Palczewski <mateusz.palczewski@intel.com>,
 Leon Romanovsky <leon@kernel.org>,
 Rafal Rogalski <rafalx.rogalski@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-net v3 2/4] ice: avoid RTNL deadlock when notifying the
 RDMA auxiliary driver
Date: Fri, 13 Nov 2026 17:14:51 +0100
Message-ID: <20261113161453.1234851-3-poros@redhat.com>
In-Reply-To: <20261113161453.1234851-1-poros@redhat.com>
References: <20261113161453.1234851-1-poros@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: a0QHH_2kcB6gKOIRW_mA-CgllDSlslia45MyOBIXcIM_1794586516
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ice_send_event_to_aux() blocks on the auxiliary device lock, and the
dcbnl callers reach it with the RTNL lock held. The RDMA auxiliary probe
takes the two in the opposite order, because __driver_attach() holds the
auxiliary device lock across ib_register_device(), which needs the RTNL
lock:

  systemd-udevd   state:D
    really_probe                  <- holds device_lock(&adev->dev)
    icrdma_probe
    irdma_ib_register_device
    ib_register_device
    setup_device
    irdma_roce_port_immutable
    ib_query_port
    irdma_query_port
    ib_get_eth_speed              <- blocks on rtnl_lock()

  lldpad          state:D
    rtnetlink_rcv_msg             <- holds rtnl_lock()
    dcb_doit
    dcbnl_ieee_set
    ice_dcbnl_setets
    ice_pf_dcb_cfg
    ice_send_event_to_aux         <- blocks on device_lock(&adev->dev)

Everything else that needs the RTNL lock piles up behind lldpad and the
boot never completes. The probe side cannot be changed, so take the
auxiliary device lock with device_trylock() around the event and let the
caller decide what to do when it is contended.

The DCB reconfiguration sends IIDC_RDMA_EVENT_BEFORE_TC_CHANGE, on which
the RDMA driver suspends its queue pairs, and
IIDC_RDMA_EVENT_AFTER_TC_CHANGE, on which it resumes them. Neither can be
dropped, the first would change the traffic classes behind the RDMA
driver's back and the second would leave its queue pairs suspended. So
ice_pf_dcb_cfg() takes the locks once before the first event, keeps them
across the whole reconfiguration and sends the second event before
releasing them. The driver core holds the lock while it binds, unbinds or
suspends the auxiliary device and in a few of its sysfs handlers, and the
request is then refused with -EBUSY. The RTNL lock is taken before the
auxiliary locks also for the callers that did not hold it, so every path
takes the two in the same order, and the first event is delivered with
the RTNL lock held on those paths too, as it already was for the dcbnl
callers. The second event is now sent on the error paths too, which used
to leave the queue pairs suspended after a failed commit.
ice_pf_dcb_recfg() still sends the second event on its own for the LLDP
MIB change path, which sends no first event, so a dropped one is ignored
by the RDMA driver there.

The fallback for non-contiguous traffic classes is a nested
ice_pf_dcb_cfg() and would block on pf->adev_mutex under the locks. So
ice_pf_dcb_cfg() runs it in place of the transaction when the new
configuration is not contiguous, before it takes the locks, and
ice_pf_dcb_recfg() leaves it to the caller when the locks are held. The
other caller that passes locked, ice_vsi_recfg_qs(), already held
pf->adev_mutex there and would have deadlocked the same way through
ice_send_event_to_aux().

ice_pf_dcb_cfg() already returns -EBUSY when the custom Tx scheduler is
enabled, so the refused request takes the same path through its callers.

The critical error and MTU change events are sent from the service task,
which consumes their pending bits before sending, so those are re-armed
instead. The critical error event takes the locks before it consumes
pf->oicr_err_reg, so a contended lock leaves the register value to the
next run instead of merging it back underneath the interrupt handler.

Fixes: 348048e724a0 ("ice: Implement iidc operations")
Signed-off-by: Petr Oros <poros@redhat.com>
---
v3:
- rebased on "ice: fix DCB lock ordering"
- run the fallback for non-contiguous traffic classes in place of the
  transaction, before the locks, instead of after them

v2: https://lore.kernel.org/all/20261023070258.730168-4-poros@redhat.com/
v1: https://lore.kernel.org/all/20261019065301.3983537-2-poros@redhat.com/
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 47 ++++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_idc.c     | 48 ++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_idc_int.h |  2 +
 drivers/net/ethernet/intel/ice/ice_main.c    | 14 ++++--
 4 files changed, 90 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index 5355519726df9f..dba74d940d25b9 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -5,6 +5,9 @@
 #include "ice_dcb_nl.h"
 #include "devlink/devlink.h"
 
+static bool ice_dcb_tc_contig(u8 *prio_table);
+static int ice_dcb_noncontig_cfg(struct ice_pf *pf);
+
 /**
  * ice_dcb_get_ena_tc - return bitmap of enabled TCs
  * @dcbcfg: DCB config to evaluate for enabled TCs
@@ -369,11 +372,15 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dcbx_cfg *new_cfg, bool locked)
 	struct ice_aqc_port_ets_elem buf = { 0 };
 	struct ice_dcbx_cfg *old_cfg, *curr_cfg;
 	struct device *dev = ice_pf_to_dev(pf);
+	struct iidc_rdma_priv_dev_info *privd;
+	struct iidc_rdma_core_dev_info *cdev;
 	struct iidc_rdma_event *event;
 	int ret = ICE_DCB_NO_HW_CHG;
 	struct ice_vsi *pf_vsi;
+	bool dcb_ena;
 
 	curr_cfg = &pf->hw.port_info->qos_cfg.local_dcbx_cfg;
+	dcb_ena = test_bit(ICE_FLAG_DCB_ENA, pf->flags);
 
 	/* FW does not care if change happened */
 	if (!pf->hw.port_info->qos_cfg.is_sw_lldp)
@@ -422,16 +429,26 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dcbx_cfg *new_cfg, bool locked)
 		goto free_cfg;
 	}
 
-	set_bit(IIDC_RDMA_EVENT_BEFORE_TC_CHANGE, event->type);
-	ice_send_event_to_aux(pf, event);
-	kfree(event);
-
 	/* avoid race conditions by holding the lock while disabling and
 	 * re-enabling the VSI
 	 */
 	if (!locked)
 		rtnl_lock();
 
+	if (!ice_dcb_tc_contig(new_cfg->etscfg.prio_table)) {
+		ret = ice_dcb_noncontig_cfg(pf);
+		goto unlock_rtnl;
+	}
+
+	if (!ice_aux_dev_trylock(pf)) {
+		assign_bit(ICE_FLAG_DCB_ENA, pf->flags, dcb_ena);
+		ret = -EBUSY;
+		goto unlock_rtnl;
+	}
+
+	set_bit(IIDC_RDMA_EVENT_BEFORE_TC_CHANGE, event->type);
+	ice_send_event_to_aux(pf, event);
+
 	/* disable VSIs affected by DCB changes */
 	ice_dcb_ena_dis_vsi(pf, false, true);
 
@@ -458,13 +475,25 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dcbx_cfg *new_cfg, bool locked)
 		goto out;
 	}
 
-	ice_pf_dcb_recfg(pf, false);
+	ice_pf_dcb_recfg(pf, true);
 
 out:
+	cdev = pf->cdev_info;
+	if (cdev) {
+		privd = cdev->iidc_priv;
+		ice_setup_dcb_qos_info(pf, &privd->qos_info);
+	}
+	clear_bit(IIDC_RDMA_EVENT_BEFORE_TC_CHANGE, event->type);
+	set_bit(IIDC_RDMA_EVENT_AFTER_TC_CHANGE, event->type);
+	ice_send_event_to_aux(pf, event);
+	ice_aux_dev_unlock(pf);
+
 	/* enable previously downed VSIs */
 	ice_dcb_ena_dis_vsi(pf, true, true);
+unlock_rtnl:
 	if (!locked)
 		rtnl_unlock();
+	kfree(event);
 free_cfg:
 	kfree(old_cfg);
 	return ret;
@@ -778,7 +807,8 @@ void ice_pf_dcb_recfg(struct ice_pf *pf, bool locked)
 			 */
 			if (!ice_dcb_tc_contig(dcbcfg->etscfg.prio_table)) {
 				tc_map = ICE_DFLT_TRAFFIC_CLASS;
-				ice_dcb_noncontig_cfg(pf);
+				if (!locked)
+					ice_dcb_noncontig_cfg(pf);
 			}
 		} else if (vsi->type == ICE_VSI_CHNL) {
 			tc_map = BIT(ice_get_first_droptc(vsi));
@@ -813,7 +843,10 @@ void ice_pf_dcb_recfg(struct ice_pf *pf, bool locked)
 			return;
 
 		set_bit(IIDC_RDMA_EVENT_AFTER_TC_CHANGE, event->type);
-		ice_send_event_to_aux(pf, event);
+		if (ice_aux_dev_trylock(pf)) {
+			ice_send_event_to_aux(pf, event);
+			ice_aux_dev_unlock(pf);
+		}
 		kfree(event);
 	}
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_idc.c b/drivers/net/ethernet/intel/ice/ice_idc.c
index 09dfcffeb5df97..9e8bff128e0e63 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc.c
+++ b/drivers/net/ethernet/intel/ice/ice_idc.c
@@ -30,34 +30,62 @@ ice_get_auxiliary_drv(struct iidc_rdma_core_dev_info *cdev)
 			    struct iidc_rdma_core_auxiliary_drv, adrv.driver);
 }
 
+/**
+ * ice_aux_dev_trylock - take the locks that guard the RDMA AUX driver
+ * @pf: pointer to PF struct
+ *
+ * Return: true when the locks are held, false when the auxiliary device lock
+ * was contended and nothing is held.
+ */
+bool ice_aux_dev_trylock(struct ice_pf *pf)
+{
+	struct iidc_rdma_core_dev_info *cdev = pf->cdev_info;
+
+	mutex_lock(&pf->adev_mutex);
+	if (cdev && cdev->adev && !device_trylock(&cdev->adev->dev)) {
+		mutex_unlock(&pf->adev_mutex);
+		return false;
+	}
+
+	return true;
+}
+
+/**
+ * ice_aux_dev_unlock - release the locks taken by ice_aux_dev_trylock()
+ * @pf: pointer to PF struct
+ */
+void ice_aux_dev_unlock(struct ice_pf *pf)
+{
+	struct iidc_rdma_core_dev_info *cdev = pf->cdev_info;
+
+	if (cdev && cdev->adev)
+		device_unlock(&cdev->adev->dev);
+	mutex_unlock(&pf->adev_mutex);
+}
+
 /**
  * ice_send_event_to_aux - send event to RDMA AUX driver
  * @pf: pointer to PF struct
  * @event: event struct
+ *
+ * The caller holds the locks taken by ice_aux_dev_trylock().
  */
 void ice_send_event_to_aux(struct ice_pf *pf, struct iidc_rdma_event *event)
 {
+	struct iidc_rdma_core_dev_info *cdev = pf->cdev_info;
 	struct iidc_rdma_core_auxiliary_drv *iadrv;
-	struct iidc_rdma_core_dev_info *cdev;
 
 	if (WARN_ON_ONCE(!in_task()))
 		return;
 
-	cdev = pf->cdev_info;
+	lockdep_assert_held(&pf->adev_mutex);
+
 	if (!cdev)
 		return;
 
-	mutex_lock(&pf->adev_mutex);
-	if (!cdev->adev)
-		goto finish;
-
-	device_lock(&cdev->adev->dev);
 	iadrv = ice_get_auxiliary_drv(cdev);
 	if (iadrv && iadrv->event_handler)
 		iadrv->event_handler(cdev, event);
-	device_unlock(&cdev->adev->dev);
-finish:
-	mutex_unlock(&pf->adev_mutex);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_idc_int.h b/drivers/net/ethernet/intel/ice/ice_idc_int.h
index 17dbfcfb6a2aff..4cccb4764271ae 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc_int.h
+++ b/drivers/net/ethernet/intel/ice/ice_idc_int.h
@@ -9,6 +9,8 @@
 
 struct ice_pf;
 
+bool ice_aux_dev_trylock(struct ice_pf *pf);
+void ice_aux_dev_unlock(struct ice_pf *pf);
 void ice_send_event_to_aux(struct ice_pf *pf, struct iidc_rdma_event *event);
 
 #endif /* !_ICE_IDC_INT_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 1cc481ba4ca5f0..bbe4409b16cf57 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2385,13 +2385,16 @@ static void ice_service_task(struct work_struct *work)
 		struct iidc_rdma_event *event;
 
 		event = kzalloc_obj(*event);
-		if (event) {
+		if (event && ice_aux_dev_trylock(pf)) {
 			set_bit(IIDC_RDMA_EVENT_CRIT_ERR, event->type);
 			/* report the entire OICR value to AUX driver */
 			swap(event->reg, pf->oicr_err_reg);
 			ice_send_event_to_aux(pf, event);
-			kfree(event);
+			ice_aux_dev_unlock(pf);
+		} else {
+			set_bit(ICE_AUX_ERR_PENDING, pf->state);
 		}
+		kfree(event);
 	}
 
 	/* unplug aux dev per request, if an unplug request came in
@@ -2408,11 +2411,14 @@ static void ice_service_task(struct work_struct *work)
 		struct iidc_rdma_event *event;
 
 		event = kzalloc_obj(*event);
-		if (event) {
+		if (event && ice_aux_dev_trylock(pf)) {
 			set_bit(IIDC_RDMA_EVENT_AFTER_MTU_CHANGE, event->type);
 			ice_send_event_to_aux(pf, event);
-			kfree(event);
+			ice_aux_dev_unlock(pf);
+		} else {
+			set_bit(ICE_FLAG_MTU_CHANGED, pf->flags);
 		}
+		kfree(event);
 	}
 
 	ice_clean_adminq_subtask(pf);
-- 
2.56.0

