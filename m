Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170F8606A31C
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 20:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=BZ9iryPE;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iahEccWf
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF13D60A68;
	Thu, 26 Nov 2026 20:34:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yBaEkivit6Ux; Thu, 26 Nov 2026 20:34:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 13C5560A8F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795725256;
	b=m+rYPmxo/JMT0c9l9UykJ3mmFDvvScvoYFmWn+YZShpBmSTZDCFuc+8GqQZ138CE4ykb
	 PVzXvbdf/m4rPy2948dy+ReFLbh0Ga1VhEunRfpnnzlSyqkjgQz1LiMkl71R6qVD8Dk3W
	 GCiBgQfYkQ4xzEDSi6v/10RLG2n2kLvaRCgwfw/BoVXasqN2Duvs3Kz/9uZl2tqzgvWIz
	 Ti83RPDXB3aHHljB8Zi7VJ/m4qzalSyhAZi55m2BdWHDjmMFb7JErHcDzOkP0yn5CrT76
	 sDYzo9WPRvWlto4tzXv5h8olIefa7JZlIZGFcOXgrSHLCwdQy+1vkvDjQAn4A+BpJdA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795725256;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6GflS39ZA87/bQbCixcyE8qn96sKyIclpCroT8dZ1o4=;
	b=LAcJObobE/GvZVeumnc0VOzQzTTCcZH7h7po9hN5Cc44vI2DrfNNj4vMOZ3xTsNkKTNC
	 tkr0hPnakhT7Ig1bHZRAR/ct417vnLUJ3j6JJhbqIzesjqEJ2hsN/oj+EVmdlKWAFFSnU
	 sXy82DsuP2UXTGcX+2Jo/kwsn9nDZq/375dd5VVDUqiMW9xC9v4o7HMXLc5yuHvESrk7a
	 EL1bjvG5RYPaJHwo5nkQ8IplpPAWd+HYnay6v0C/FXMk4R9DBQX9OBBamy3j97t70DzId
	 NCWMZNNYwLdT2ltUI3JfmLr+L09q/ZEwNrtGin+9F5Iz9Pk3TKe243goBQqwXF81V8g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795725256;
	bh=6GflS39ZA87/bQbCixcyE8qn96sKyIclpCroT8dZ1o4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BZ9iryPEeiu2J5CbhpnT/1fCVgf7YEXMBpz40q4Dow71qQz0AAX6bx4hG43tUtnsl
	 1LAKH4VttsVqVbTvWgKm3WYL94j26kgVZsZC4mJh1K31RhQcv4F5uprMD7eCj7uxYP
	 gl062DcliAWXgyLbEx9TgVtZ2ravKbQ7grqb1vD3XxZ76aJdjM7EqLF/0oaJiLY/s3
	 e46F3RJkPCF0ZQPWDgeY0OvpgaM0ctzs4WzhOgvhI9BJVqhbHDh7VxayW9WFSHBrCj
	 LFuMPL0i5nMVtp8JcidRLUKQEqyXgTkA41ZdlShvFpMVYH/RMI5bfeYJWpGRo+aDXD
	 /DEtHHKyYQGNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 13C5560A8F;
	Thu, 26 Nov 2026 20:34:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6CA91311
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:34:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 546A44054A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:34:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cH15F3BOOTSv for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 20:34:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 43201400CB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iahEccWf
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 43201400CB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795725251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6GflS39ZA87/bQbCixcyE8qn96sKyIclpCroT8dZ1o4=;
 b=iahEccWfubRlqYV78QUCbVF7yrPNoE7Jy6OmFwlihYW2g+oJ2YqRFAxGSfSkHuh+Z25PAV
 KGR5zdDeEzdGjmqKj6wP2KSG1uNNbIDXrPQUyP/tsQaPPRuZKyn/ndV4RYt8Yq0d7vn/Dk
 ELJtXLILKMMM59ABK3pM1zQSF+1bmuw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-Cbmm1PmwOaauHAqDhFFatA-1; Thu,
 26 Nov 2026 20:34:05 +0000
X-MC-Unique: Cbmm1PmwOaauHAqDhFFatA-1
X-Mimecast-MFC-AGG-ID: Cbmm1PmwOaauHAqDhFFatA_1795725243
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD0781956080; Thu, 26 Nov 2026 20:34:02 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 779921801A72; Thu, 26 Nov 2026 20:33:55 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Richard Cochran <richardcochran@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Min Li <min.li@microchip.com>, Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Petr Oros <poros@redhat.com>
Subject: [PATCH RFC net-next 12/19] ice: dpll: track the E825 recovered clock
 routing in the adapter
Date: Thu, 26 Nov 2026 21:32:24 +0100
Message-ID: <20261126203231.934632-13-ivecera@redhat.com>
In-Reply-To: <20261126203231.934632-1-ivecera@redhat.com>
References: <20261126203231.934632-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: RBZqOKTYY_bFhXwLzkcxleri6Jpa7D94YrUPTB2iQtE_1795725243
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On E825 the CGU has two muxes, each routing the recovered clock of one
port of the adapter to a SyncE output. All PFs of the adapter reach the
muxes, but the driver tracks the routing only per PF, as the state of
the recovered clock pin of the PF on each mux.

Record in the adapter which recovered clock pin each mux routes. A PF
records its pin when it creates the pin and the mux routes its port, and
when it routes its port. The record is cleared when a PF disables the
mux and when the routed PF removes its pin. A failed configuration may
leave the mux registers changed, for example the R11 selection of SyncE
output 1 is written before R10, so the record is then read back from
them, or set to no port if that read fails too, as the routing is then
unknown. Writers hold cgu_synce_lock, which already serializes the
writes of the mux registers.

Nothing reads the record yet. Creating the pin adds one read of the mux
registers R10 and R11, the same reads as for getting the pin state, and
a failed configuration adds a read of the register that selects the
port.

Tested on a GNR-D platform with a dual NAC E825 and a ZL80132B DPLL: the
record follows the routing of each of the eight ports, and the mux
registers keep the routing over a PF reset, a CORER and a GLOBR, so the
record stays valid. EMPR was not tested.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_adapter.h |  15 ++
 drivers/net/ethernet/intel/ice/ice_dpll.c    | 154 ++++++++++++++++---
 2 files changed, 150 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index 698a5b9af82ffd..1e4558f2d8c727 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -13,6 +13,7 @@
 
 #include "ice_type.h"
 
+struct dpll_pin;
 struct pci_dev;
 struct ice_pf;
 
@@ -34,6 +35,18 @@ struct ice_port_list {
 	struct srcu_struct srcu;
 };
 
+/**
+ * struct ice_dpll_rclk_mux - recovered clock mux of the E825C CGU
+ * @src: recovered clock pin of the port that the mux routes to its output,
+ *	 NULL when it routes no port of a bound PF or the routing is unknown
+ *
+ * The CGU routes the recovered clock of one port of the adapter to each of
+ * its two SyncE outputs. Writers of @src hold cgu_synce_lock of the adapter.
+ */
+struct ice_dpll_rclk_mux {
+	struct dpll_pin *src;
+};
+
 /**
  * struct ice_adapter - PCI adapter resources shared across PFs
  * @devlink: ice adapter's devlink (whole dev devlink)
@@ -44,6 +57,7 @@ struct ice_port_list {
  *               Index 0 = PHY0, index 1 = PHY1. Used on E825C devices.
  * @cgu_synce_lock: Mutex serializing changes of the CGU registers R10 and R11,
  *                  which all PFs reach. Used on E825C devices.
+ * @rclk_mux: Recovered clock muxes of the CGU. Used on E825C devices.
  * @ctrl_pf: Control PF of the adapter
  * @ports: Ports list
  */
@@ -58,6 +72,7 @@ struct ice_adapter {
 	struct mutex cpi_phy_lock[ICE_E825_MAX_PHYS];
 	/* Serialize changes of the SyncE CGU registers (E825C only) */
 	struct mutex cgu_synce_lock;
+	struct ice_dpll_rclk_mux rclk_mux[ICE_SYNCE_CLK_NUM];
 
 	struct ice_pf *ctrl_pf;
 	struct ice_port_list ports;
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index ccbe34abf74661..11c5dc0376bb4c 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -556,6 +556,37 @@ ice_dpll_pin_store_state(struct ice_dpll_pin *pin, int parent, bool state)
 					DPLL_PIN_STATE_DISCONNECTED;
 }
 
+/**
+ * ice_dpll_rclk_mux_sel_get - get the input selected by a recovered clock mux
+ * @hw: pointer to the HW struct
+ * @output: SyncE output of the CGU fed by the mux
+ * @sel: on success holds the selected input
+ *
+ * Return:
+ * * 0 - OK
+ * * negative - error
+ */
+static int ice_dpll_rclk_mux_sel_get(struct ice_hw *hw,
+				     enum ice_synce_clk output, u8 *sel)
+{
+	int err;
+	u32 reg;
+
+	if (output == ICE_SYNCE_CLK0) {
+		err = ice_read_cgu_reg(hw, ICE_CGU_R10, &reg);
+		if (err)
+			return err;
+		*sel = FIELD_GET(ICE_CGU_R10_SYNCE_S_REF_CLK, reg);
+	} else {
+		err = ice_read_cgu_reg(hw, ICE_CGU_R11, &reg);
+		if (err)
+			return err;
+		*sel = FIELD_GET(ICE_CGU_R11_SYNCE_S_BYP_CLK, reg);
+	}
+
+	return 0;
+}
+
 /**
  * ice_dpll_rclk_update_e825c - updates the state of rclk pin on e825c device
  * @pf: private board struct
@@ -571,28 +602,19 @@ ice_dpll_pin_store_state(struct ice_dpll_pin *pin, int parent, bool state)
 static int ice_dpll_rclk_update_e825c(struct ice_pf *pf,
 				      struct ice_dpll_pin *pin)
 {
-	u8 rclk_bits;
-	int err;
-	u32 reg;
+	u8 port = pf->ptp.port.port_num + ICE_CGU_BYPASS_MUX_OFFSET_E825C;
+	int err, i;
+	u8 sel;
 
 	if (pf->dplls.rclk.num_parents > ICE_SYNCE_CLK_NUM)
 		return -EINVAL;
 
-	err = ice_read_cgu_reg(&pf->hw, ICE_CGU_R10, &reg);
-	if (err)
-		return err;
-
-	rclk_bits = FIELD_GET(ICE_CGU_R10_SYNCE_S_REF_CLK, reg);
-	ice_dpll_pin_store_state(pin, ICE_SYNCE_CLK0, rclk_bits ==
-		(pf->ptp.port.port_num + ICE_CGU_BYPASS_MUX_OFFSET_E825C));
-
-	err = ice_read_cgu_reg(&pf->hw, ICE_CGU_R11, &reg);
-	if (err)
-		return err;
-
-	rclk_bits = FIELD_GET(ICE_CGU_R11_SYNCE_S_BYP_CLK, reg);
-	ice_dpll_pin_store_state(pin, ICE_SYNCE_CLK1, rclk_bits ==
-		(pf->ptp.port.port_num + ICE_CGU_BYPASS_MUX_OFFSET_E825C));
+	for (i = 0; i < ICE_SYNCE_CLK_NUM; i++) {
+		err = ice_dpll_rclk_mux_sel_get(&pf->hw, i, &sel);
+		if (err)
+			return err;
+		ice_dpll_pin_store_state(pin, i, sel == port);
+	}
 
 	return 0;
 }
@@ -2020,6 +2042,40 @@ ice_dpll_phase_offset_get(const struct dpll_pin *pin, void *pin_priv,
 	return 0;
 }
 
+/**
+ * ice_dpll_rclk_src_sync - record the port a recovered clock mux routes
+ * @pf: board private structure
+ * @output: SyncE output of the CGU fed by the mux
+ *
+ * Read the input selected by the mux. Record the recovered clock pin of the
+ * PF as the source of the mux when the mux routes the port of the PF, and no
+ * pin when it routes no port. When it routes another port, keep the record
+ * unless it names the PF.
+ *
+ * Context: Called under adapter->cgu_synce_lock
+ * Return:
+ * * 0 - OK
+ * * negative - error
+ */
+static int ice_dpll_rclk_src_sync(struct ice_pf *pf, enum ice_synce_clk output)
+{
+	u8 port = pf->ptp.port.port_num + ICE_CGU_BYPASS_MUX_OFFSET_E825C;
+	struct ice_dpll_rclk_mux *mux = &pf->adapter->rclk_mux[output];
+	struct dpll_pin *pin = pf->dplls.rclk.pin;
+	int err;
+	u8 sel;
+
+	err = ice_dpll_rclk_mux_sel_get(&pf->hw, output, &sel);
+	if (err)
+		return err;
+	if (sel == port)
+		WRITE_ONCE(mux->src, pin);
+	else if (sel < ICE_CGU_BYPASS_MUX_OFFSET_E825C || mux->src == pin)
+		WRITE_ONCE(mux->src, NULL);
+
+	return 0;
+}
+
 /**
  * ice_dpll_synce_update_e825c - setting PHY recovered clock pins on e825c
  * @hw: Pointer to the HW struct
@@ -2028,6 +2084,7 @@ ice_dpll_phase_offset_get(const struct dpll_pin *pin, void *pin_priv,
  * @output: output pin, we have two in E825C
  *
  * DPLL subsystem callback. Set proper signals to recover clock from port.
+ * Record in the adapter which port the mux routes.
  *
  * Context: Called under pf->dplls.lock, acquires adapter->cgu_synce_lock
  * Return:
@@ -2043,8 +2100,17 @@ static int ice_dpll_synce_update_e825c(struct ice_hw *hw, bool ena,
 	mutex_lock(&pf->adapter->cgu_synce_lock);
 	/* configure the mux to deliver proper signal to DPLL from the MUX */
 	err = ice_tspll_cfg_bypass_mux_e825c(hw, ena, port_num, output);
-	if (!err)
+	if (!err) {
+		/* A disabled mux routes no port, whichever it routed before */
+		WRITE_ONCE(pf->adapter->rclk_mux[output].src,
+			   ena ? pf->dplls.rclk.pin : NULL);
 		err = ice_tspll_cfg_synce_ethdiv_e825c(hw, output);
+	} else if (ice_dpll_rclk_src_sync(pf, output)) {
+		/* The routing is unknown after a partial write that cannot
+		 * be read back, record no port.
+		 */
+		WRITE_ONCE(pf->adapter->rclk_mux[output].src, NULL);
+	}
 	mutex_unlock(&pf->adapter->cgu_synce_lock);
 	if (err)
 		return err;
@@ -2055,6 +2121,48 @@ static int ice_dpll_synce_update_e825c(struct ice_hw *hw, bool ena,
 	return 0;
 }
 
+/**
+ * ice_dpll_rclk_src_init - record the muxes that route the port of the PF
+ * @pf: board private structure
+ *
+ * Record the recovered clock pin of the PF as the source of the recovered
+ * clock muxes that route the port of the PF, see ice_dpll_rclk_src_sync().
+ *
+ * Context: Acquires adapter->cgu_synce_lock
+ * Return:
+ * * 0 - success
+ * * negative - error
+ */
+static int ice_dpll_rclk_src_init(struct ice_pf *pf)
+{
+	int err = 0, i;
+
+	mutex_lock(&pf->adapter->cgu_synce_lock);
+	for (i = 0; !err && i < ICE_SYNCE_CLK_NUM; i++)
+		err = ice_dpll_rclk_src_sync(pf, i);
+	mutex_unlock(&pf->adapter->cgu_synce_lock);
+
+	return err;
+}
+
+/**
+ * ice_dpll_rclk_src_fini - drop the PF as the source of recovered clock muxes
+ * @pf: board private structure
+ *
+ * Context: Acquires adapter->cgu_synce_lock
+ */
+static void ice_dpll_rclk_src_fini(struct ice_pf *pf)
+{
+	struct ice_adapter *adapter = pf->adapter;
+	int i;
+
+	mutex_lock(&adapter->cgu_synce_lock);
+	for (i = 0; i < ICE_SYNCE_CLK_NUM; i++)
+		if (adapter->rclk_mux[i].src == pf->dplls.rclk.pin)
+			WRITE_ONCE(adapter->rclk_mux[i].src, NULL);
+	mutex_unlock(&adapter->cgu_synce_lock);
+}
+
 /**
  * ice_dpll_output_esync_set - callback for setting embedded sync
  * @pin: pointer to a pin
@@ -3745,6 +3853,8 @@ static void ice_dpll_deinit_rclk_pin(struct ice_pf *pf)
 		dpll_pin_on_pin_unregister(parent->pin, rclk->pin,
 					   &ice_dpll_rclk_ops, rclk);
 	}
+	if (pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825)
+		ice_dpll_rclk_src_fini(pf);
 	if (WARN_ON_ONCE(!vsi || !vsi->netdev))
 		return;
 	dpll_netdev_pin_clear(vsi->netdev);
@@ -4328,6 +4438,12 @@ static int ice_dpll_init_pins_e825(struct ice_pf *pf)
 	if (ret)
 		goto unregister_pins;
 
+	ret = ice_dpll_rclk_src_init(pf);
+	if (ret) {
+		ice_dpll_deinit_rclk_pin(pf);
+		goto unregister_pins;
+	}
+
 	ret = ice_dpll_init_txclk_pins(pf);
 	if (ret) {
 		ice_dpll_deinit_rclk_pin(pf);
-- 
2.56.1

