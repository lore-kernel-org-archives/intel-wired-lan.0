Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84B9606A333
	for <intel-wired-lan@archiver.kernel.org>; Fri,  6 Nov 2026 12:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=3q5Vd25R;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aLh2GTRt;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aLh2GTRt;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aLh2GTRt
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8BC1740934;
	Fri,  6 Nov 2026 12:10:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t5xP2Ud9pMhM; Fri,  6 Nov 2026 12:10:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BA94C4095D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793967039;
	b=L4lcESIrsBZD6c5OcI8zYd6gYJPR7fBZsfMBrs5a2xIa5YrvqM0yaB5sOwS8jWAffb25
	 fkJDYl6a5Mm5z4XmirCYZPdzLknIKV305nINTgrkpltmTvdTSCtSl0X6fE8hEnzCXXGni
	 GgJ3JMKvCYiuJgj53BOKZRCIxqkwlynQh3AmjNwC4YCqJs853VKxuAyVwMmChXKztXYBg
	 MsOSWrFJfmp9K92KbIysIMRWDEwXNeHCIxEORgxzQ6jJ9idzYO1xmw+zstb3eUQ8ag+un
	 iRZKZ4msuyRnbCO95DaBDhsjNf7tPbdcl0eVl7ZZqTu+9GNhjRWudAk5yQXfXN7lMcQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793967039;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7VqcSi1dSXj2faifoXjrJP8/CE3Zo8Lvj74KnRYzfxs=;
	b=PQYX1kxopURXjC3gkHfjx8mEDzemsyNNkYf2aHJEWPEHUDyX3GV8E4dCn4f09e9cApOK
	 +0sGQ8TCbDsjeMQqZ6pJ/jSOmsSKmYoU+KTz+RsMoLSTrdDqi0DntnQImJ2qhTCAncipU
	 Mk9XfDw2nLvkXeHUfhGYkABqniC59seh9cS8SubRc6F+1/ScOWrahT+s1qqJGBXKJIFlx
	 nOMP8mfMpvo19MtZ+WlRju/NPf74GbLG/tq6p7P5yPwEcqo/IZSXhaDiBNCe7TxS1suG6
	 NPwRvjjWHb1Xh4KjI8fDhLTUmsQ2LHXSfjgS0pOOyrb/7HLi3pAjKTRUo8TqnwahrMQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793967039;
	bh=7VqcSi1dSXj2faifoXjrJP8/CE3Zo8Lvj74KnRYzfxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=3q5Vd25REUGazn2q7nCMTPjZZ68poWyJoToyn5/xMoj+EgN8xq74wjLYJhs8oWoLt
	 NveHtmamfTZpcRjaii4sL5EPR6vMSoyxg3NEMs+6UG3Oju1sXoOmRwisQoJa4GLtSD
	 4ZZ5qEKCdzBlGi3+6lmsvxH3G1yG4CglfEKyq8yHhB0rvInGRngQH34zSNkUA632f3
	 TD5izHiEmptsMEcLuwDjJnqpWMdN13Uy5r6efW/P78hokBeg4rpjLC6itds99wQLfn
	 tLGLu5QnqRGFyTc8/Mnql99hFRfBkLpuaq8JV0DwV6HtH9x4NzzNiO5ln+cxEhCFkW
	 9iKcg3DX1T4KQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA94C4095D;
	Fri,  6 Nov 2026 12:10:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 68ECD235
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:10:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5AE33607C3
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:10:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Y4e6UXxkRxp for <intel-wired-lan@lists.osuosl.org>;
 Fri,  6 Nov 2026 12:10:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2702D6061F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aLh2GTRt; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aLh2GTRt; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aLh2GTRt
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2702D6061F
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793967033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7VqcSi1dSXj2faifoXjrJP8/CE3Zo8Lvj74KnRYzfxs=;
 b=aLh2GTRtBDS1sFfxPX7yzMYB5tpdPd+LXCOz5RXcuJmQ/wM+vnOnPNc6XmzU1tciK7wi9h
 rcRHns6CEZ3LGuraaJ16kxz5G0duj5oumovvvpu+3E9athsLT7Vmv1UQ5TJUpnNtre4P8O
 nrfiEI0cwhV5P/7RgHDfdzvy7e8DQl8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793967033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7VqcSi1dSXj2faifoXjrJP8/CE3Zo8Lvj74KnRYzfxs=;
 b=aLh2GTRtBDS1sFfxPX7yzMYB5tpdPd+LXCOz5RXcuJmQ/wM+vnOnPNc6XmzU1tciK7wi9h
 rcRHns6CEZ3LGuraaJ16kxz5G0duj5oumovvvpu+3E9athsLT7Vmv1UQ5TJUpnNtre4P8O
 nrfiEI0cwhV5P/7RgHDfdzvy7e8DQl8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793967033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7VqcSi1dSXj2faifoXjrJP8/CE3Zo8Lvj74KnRYzfxs=;
 b=aLh2GTRtBDS1sFfxPX7yzMYB5tpdPd+LXCOz5RXcuJmQ/wM+vnOnPNc6XmzU1tciK7wi9h
 rcRHns6CEZ3LGuraaJ16kxz5G0duj5oumovvvpu+3E9athsLT7Vmv1UQ5TJUpnNtre4P8O
 nrfiEI0cwhV5P/7RgHDfdzvy7e8DQl8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-oIK7eakaNg2ep2EGY3sRbg-1; Fri,
 06 Nov 2026 07:10:30 -0500
X-MC-Unique: oIK7eakaNg2ep2EGY3sRbg-1
X-Mimecast-MFC-AGG-ID: oIK7eakaNg2ep2EGY3sRbg_1793967027
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25F331955EAD; Fri,  6 Nov 2026 12:10:27 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D004F18004D2; Fri,  6 Nov 2026 12:10:20 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Min Li <min.li@microchip.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Petr Oros <poros@redhat.com>
Subject: [PATCH net-next 02/10] ice: dpll: serialize changes of the SyncE CGU
 registers
Date: Fri,  6 Nov 2026 13:09:57 +0100
Message-ID: <20261106121005.1327603-3-ivecera@redhat.com>
In-Reply-To: <20261106121005.1327603-1-ivecera@redhat.com>
References: <20261106121005.1327603-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: p9kpjRHIZLhR97VfTSHXt8xhSNva_eF6HTF-w0E7ViE_1793967027
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

On dual complex E825 only complex 0 has a functional CGU and the second
complex reaches it through cgu_peer, so PFs of both complexes share the
CGU registers R10 and R11. They read, modify and write them when the
state of an RCLK pin changes, and ice_ptp_link_change() rewrites R10 when
a link changes, under the pf->dplls.lock of their own PF only.

ice_ptp_link_change() does not hold dpll_lock, so it can already overwrite
an update of another PF. RCLK callbacks are serialized by dpll_lock, but
the DPLL core is going to serialize callbacks per (module, clock_id), and
each complex has its own DSN and so its own clock_id. With that change, a
test toggling RCLK pins of both complexes lost an update.

Add a mutex to struct ice_adapter, which all E825C PFs share, and hold it
around these sequences.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_adapter.c |  2 ++
 drivers/net/ethernet/intel/ice/ice_adapter.h |  4 ++++
 drivers/net/ethernet/intel/ice/ice_dpll.c    | 11 ++++++-----
 drivers/net/ethernet/intel/ice/ice_dpll.h    |  4 ++++
 drivers/net/ethernet/intel/ice/ice_ptp.c     |  2 ++
 drivers/net/ethernet/intel/ice/ice_tspll.c   |  4 ++--
 6 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index 536923b6ae979d..aa2d8addae5bef 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -72,6 +72,7 @@ static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
 	spin_lock_init(&adapter->txq_ctx_lock);
 	for (int i = 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
 		mutex_init(&adapter->cpi_phy_lock[i]);
+	mutex_init(&adapter->cgu_synce_lock);
 	refcount_set(&adapter->refcount, 1);
 
 	spin_lock_init(&adapter->ports.lock);
@@ -85,6 +86,7 @@ static void ice_adapter_free(struct ice_adapter *adapter)
 	WARN_ON(!list_empty(&adapter->ports.list));
 	for (int i = 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
 		mutex_destroy(&adapter->cpi_phy_lock[i]);
+	mutex_destroy(&adapter->cgu_synce_lock);
 
 	cleanup_srcu_struct(&adapter->ports.srcu);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index c61bd645e460de..fd5585005d91ba 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -41,6 +41,8 @@ struct ice_port_list {
  * @txq_ctx_lock: Spinlock protecting access to the GLCOMM_QTX_CNTX_CTL register
  * @cpi_phy_lock: Per-PHY mutex serializing CPI REQ/ACK transactions.
  *               Index 0 = PHY0, index 1 = PHY1. Used on E825C devices.
+ * @cgu_synce_lock: Mutex serializing changes of the CGU registers R10 and R11,
+ *                  which all PFs reach. Used on E825C devices.
  * @ctrl_pf: Control PF of the adapter
  * @ports: Ports list
  * @index: 64-bit index cached for collision detection on 32bit systems
@@ -53,6 +55,8 @@ struct ice_adapter {
 	spinlock_t txq_ctx_lock;
 	/* Serialize CPI REQ/ACK transactions per PHY (E825C only) */
 	struct mutex cpi_phy_lock[ICE_E825_MAX_PHYS];
+	/* Serialize changes of the SyncE CGU registers (E825C only) */
+	struct mutex cgu_synce_lock;
 
 	struct ice_pf *ctrl_pf;
 	struct ice_port_list ports;
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index bdbcf7af296eb4..d6302409a2dacf 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -2027,7 +2027,7 @@ ice_dpll_phase_offset_get(const struct dpll_pin *pin, void *pin_priv,
  *
  * DPLL subsystem callback. Set proper signals to recover clock from port.
  *
- * Context: Called under pf->dplls.lock
+ * Context: Called under pf->dplls.lock, acquires adapter->cgu_synce_lock
  * Return:
  * * 0 - success
  * * negative - error
@@ -2035,14 +2035,15 @@ ice_dpll_phase_offset_get(const struct dpll_pin *pin, void *pin_priv,
 static int ice_dpll_synce_update_e825c(struct ice_hw *hw, bool ena,
 				       u32 port_num, enum ice_synce_clk output)
 {
+	struct ice_pf *pf = hw->back;
 	int err;
 
+	mutex_lock(&pf->adapter->cgu_synce_lock);
 	/* configure the mux to deliver proper signal to DPLL from the MUX */
 	err = ice_tspll_cfg_bypass_mux_e825c(hw, ena, port_num, output);
-	if (err)
-		return err;
-
-	err = ice_tspll_cfg_synce_ethdiv_e825c(hw, output);
+	if (!err)
+		err = ice_tspll_cfg_synce_ethdiv_e825c(hw, output);
+	mutex_unlock(&pf->adapter->cgu_synce_lock);
 	if (err)
 		return err;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
index bce0bea9a664bc..4ba76e2e2e0b01 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -158,6 +158,7 @@ struct ice_dpll {
  *     txclk_notify_rwsem (read)
  *       -> pf->dplls.lock
  *         -> ctrl_pf->dplls.lock
+ *         -> adapter->cgu_synce_lock
  *
  *   - @lock serializes all DPLL state mutations on this PF. When the
  *     controlling PF's lock must also be taken (e.g. updating the shared
@@ -169,6 +170,9 @@ struct ice_dpll {
  *     dpll_*_change_ntf() calls. ice_dpll_deinit() takes the write side
  *     standalone (not nested under any other lock) to drain in-flight
  *     readers before pins and the TXC DPLL device are freed.
+ *   - adapter->cgu_synce_lock serializes changes of the CGU registers R10 and
+ *     R11. All PFs of a dual complex E825 reach one CGU, so @lock does not
+ *     cover them.
  */
 struct ice_dplls {
 	struct kthread_worker *kworker;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 3df08714510da5..4d4b6aaaf30c29 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1395,7 +1395,9 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 				break;
 			}
 
+			mutex_lock(&pf->adapter->cgu_synce_lock);
 			err = ice_tspll_cfg_synce_ethdiv_e825c(hw, clk_pin);
+			mutex_unlock(&pf->adapter->cgu_synce_lock);
 			if (active && err) {
 				dev_err_once(ice_pf_to_dev(pf),
 					     "Failed to configure SyncE ETH divider for pin %d, err %d\n",
diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index 85bacb7c3a7903..b99e02cfe559bd 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -792,7 +792,7 @@ int ice_tspll_bypass_mux_active_e825c(struct ice_hw *hw, u8 port, bool *active,
  *
  * Set reference clock source and output clock selection.
  *
- * Context: Called under pf->dplls.lock
+ * Context: Called under pf->dplls.lock and adapter->cgu_synce_lock
  * Return:
  * * 0 - success
  * * negative - error
@@ -898,7 +898,7 @@ static int ice_tspll_get_div_e825c(u16 link_speed, unsigned int *divider)
  *
  * Set the correct CGU divider for RCLKA or RCLKB.
  *
- * Context: Called under pf->dplls.lock
+ * Context: Called under pf->dplls.lock and adapter->cgu_synce_lock
  * Return:
  * * 0 - success
  * * negative - error
-- 
2.56.0

