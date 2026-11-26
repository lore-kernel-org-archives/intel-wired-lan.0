Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDA4606A31C
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 20:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=w0dvlerF;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aNeQagmJ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8CB6360A8F;
	Thu, 26 Nov 2026 20:34:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id btTgITTQT1ZJ; Thu, 26 Nov 2026 20:34:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EE57860AC8
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795725261;
	b=FOn5WZd4R96yZ2ZdZTIiK+TOEM+89Fdnlbp1CYXLLGl9QolRMCSXygy5JOr+EmulHHYV
	 UW2U5VYCWV08ihvyC3zOnLQxu8MDLyugaltMsExleq7cDOlepb6R+Rg/jbsko45djKvVz
	 5ePKYek++C61j1IxpjRzS+1lb8YH0CuHDBHCO/L0n1V0VBc0SN2sQ4etir9lHdLZ/C+q5
	 WzRrpBRVsJfo2wBQOTJBykMTIGWrAoLpTS1GjT3AG5hqxZtz1zX9JKIrgiArtCAho15NM
	 +Hpvw9BiLu9+AshK9CSc8WPlutOoamoxDBvAKZ7xCtLylj0qssOQ/lMpA114d6XmWlQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795725261;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hM9iEMB0a337G81XcGw0vSEnttTEWbw5Jfrm8RM5QwU=;
	b=OjgqwFvP+dVjOGLwtHG7AT6kFovzjRghuRc5rKIf5sjnIMUZt6KmIM9+oNVupbUa0501
	 IVfsFydqY9vOZN3+skWvtnoktSKPCgdB3UaU36PXI3uAN0ITX0uAgTIxaHaJCqceszkaW
	 Ma9SU+ARyp18fhUhFzoEBRP8qSL6OJCJcq5/2qDPntRNs7DNzcIDs/oOSUM7DGEFyFjR/
	 xxd8o5l1hCS8BqgAv7qdZf1CduIq4RJvUfC6cScKSBTe0g7p04xROhG1BW/VWEd3v2Nnc
	 uXI0kVLVP8dajFBHAAWbE2oQqK6aakKTaDee0nwRloIVhRl49MbTuOlyO+QnZ3PwYgQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795725261;
	bh=hM9iEMB0a337G81XcGw0vSEnttTEWbw5Jfrm8RM5QwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w0dvlerF7KxJ3ZZwzA9EqSVBqQgN72ritW6603KaFWAP2iNd0DSxNwGeG5uw6gk7o
	 z/XDSMSpK0cn5FJsR+VZF34avFOQOzfPAFr8Jlyfp5D2kgRMzXtDCYl/i3PUx4DDKC
	 4QJODLtK2ooU9HrbM+o12UKcJv+beRePYGrbMlykfXZ1FRIVMMY4/qR/SpAQ0DCXNI
	 q902ORVDIGseE/dSJQn1J25wqswb3Ny+aDI18Mc2WyKGAXq6qPe92N416pLIaHQLpT
	 sheuygFJcHRyez9dFmoCBCg0O7AL2FRq+In0gC35QTJg/iNwJIZoAgdS5KQJKKmAbB
	 lvaZuMxCxXu7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE57860AC8;
	Thu, 26 Nov 2026 20:34:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id ECB821AB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:34:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D2C6E4054A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:34:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aIXDNEzQ5WqB for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 20:34:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 58EA5400CB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aNeQagmJ
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 58EA5400CB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795725257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hM9iEMB0a337G81XcGw0vSEnttTEWbw5Jfrm8RM5QwU=;
 b=aNeQagmJjNw3GTpnkHNFJFsReDBO4Ikca6wOukrSKK8eQtYuVauGR2ns8m7M4+TGoePO4f
 bgjkush/UfmoMiLmSRgVIw/8iHfbN79QEy6g6zIAh7cgnsrKo/PxUiSZNbLcKfG4vUMQ2K
 0SokK4nwkr2+KjnvDQjy+BBsq3QeHXI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-GX_CUZO2MBK71-G3Kx2K7w-1; Thu,
 26 Nov 2026 20:34:12 +0000
X-MC-Unique: GX_CUZO2MBK71-G3Kx2K7w-1
X-Mimecast-MFC-AGG-ID: GX_CUZO2MBK71-G3Kx2K7w_1795725249
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6997919541B2; Thu, 26 Nov 2026 20:34:09 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3A01F1801971; Thu, 26 Nov 2026 20:34:03 +0000 (UTC)
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
Subject: [PATCH RFC net-next 13/19] ice: dpll: register the E825 recovered
 clock muxes as DPLL devices
Date: Thu, 26 Nov 2026 21:32:25 +0100
Message-ID: <20261126203231.934632-14-ivecera@redhat.com>
In-Reply-To: <20261126203231.934632-1-ivecera@redhat.com>
References: <20261126203231.934632-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: Q0Bh1yfbG7BNMg2mFuTf1CK_y0zB3G6hWnq1951CV_U_1795725249
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

Each of the two recovered clock muxes of the E825 CGU feeds a SyncE
output, which the board wires to an input of the platform DPLL. Describe
each mux with a DPLL device of type generic with one output pin, RCLK0
or RCLK1. The output pin is linked with the pin at the other end of the
wire through the firmware node rclk0 or rclk1, the same nodes the
recovered clock pins use to find their parent pins.

The devices and the output pins belong to the adapter. Their clock ID is
the adapter index, which all PFs of the adapter share, both NACs of E825
included. The device index is the SyncE output. The first PF registers
the devices and the pins and the last one unregisters them, under the
instance lock of the adapter devlink. The callers already hold the
instance lock of the PF devlink, which is nested in the adapter devlink,
so the two locks are taken in the order the devlink rules require.

A mux reports a locked status, and its output pin the connected state,
while the mux routes the port of a bound PF, as recorded in the adapter.
The callbacks of the devices and of the output pins do not access the
hardware. A change of the routing, also by a failed write, notifies the
device, its output pin and the recovered clock pins whose state on the
mux changed, the pin of the port routed before included, which is read
together with the write under cgu_synce_lock. When a PF finds at probe
that the registers differ from the record, it notifies only the device
and its output pin, because the pin routed before belongs to another PF,
which can go away meanwhile, and the state of a recovered clock pin is
read from the hardware. The recovered clock pins do not use the muxes
yet.

Tested on a GNR-D platform with a dual NAC E825 and a ZL80132B DPLL: the
mux devices and RCLK0/1 stay while any PF of the adapter is bound and go
with the last one, and RCLK0 and RCLK1 report their links to the zl3073x
inputs REF1P and REF1N.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_adapter.c |   3 +-
 drivers/net/ethernet/intel/ice/ice_adapter.h |  22 +-
 drivers/net/ethernet/intel/ice/ice_dpll.c    | 323 ++++++++++++++++++-
 3 files changed, 335 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index 8cb61f145d27a2..929c965724dba1 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -43,6 +43,7 @@ static int ice_adapter_init(void *priv, void *init_param)
 
 	devlink = shd_priv_to_devlink(adapter);
 	adapter->devlink = devlink;
+	adapter->index = *(u64 *)init_param;
 
 	spin_lock_init(&adapter->ptp_gltsyn_time_lock);
 	spin_lock_init(&adapter->txq_ctx_lock);
@@ -96,7 +97,7 @@ struct ice_adapter *ice_adapter_get(struct pci_dev *pdev)
 	index = ice_adapter_index(pdev);
 	snprintf(devlink_id, sizeof(devlink_id), "ice:%llx", index);
 	devlink = devlink_shd_get(devlink_id, &ice_adapter_devlink_ops,
-				  sizeof(*adapter), NULL, pdev->dev.driver);
+				  sizeof(*adapter), &index, pdev->dev.driver);
 	if (IS_ERR(devlink))
 		return ERR_CAST(devlink);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index 1e4558f2d8c727..e321bdd70d36a0 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -5,6 +5,7 @@
 #define _ICE_ADAPTER_H_
 
 #include <linux/types.h>
+#include <linux/dpll.h>
 #include <linux/mutex.h>
 #include <linux/srcu.h>
 #include <linux/spinlock_types.h>
@@ -13,7 +14,6 @@
 
 #include "ice_type.h"
 
-struct dpll_pin;
 struct pci_dev;
 struct ice_pf;
 
@@ -37,19 +37,33 @@ struct ice_port_list {
 
 /**
  * struct ice_dpll_rclk_mux - recovered clock mux of the E825C CGU
+ * @dpll: DPLL device of the mux
+ * @tracker: reference tracker of @dpll
+ * @out: output pin of the mux
+ * @out_tracker: reference tracker of @out
  * @src: recovered clock pin of the port that the mux routes to its output,
  *	 NULL when it routes no port of a bound PF or the routing is unknown
+ * @idx: SyncE output of the CGU fed by the mux
  *
  * The CGU routes the recovered clock of one port of the adapter to each of
- * its two SyncE outputs. Writers of @src hold cgu_synce_lock of the adapter.
+ * its two SyncE outputs. The PFs of the adapter share the muxes: the first
+ * PF registers @dpll and @out, the last one unregisters them, under the
+ * instance lock of the adapter devlink. Writers of @src hold cgu_synce_lock
+ * of the adapter.
  */
 struct ice_dpll_rclk_mux {
+	struct dpll_device *dpll;
+	dpll_tracker tracker;
+	struct dpll_pin *out;
+	dpll_tracker out_tracker;
 	struct dpll_pin *src;
+	enum ice_synce_clk idx;
 };
 
 /**
  * struct ice_adapter - PCI adapter resources shared across PFs
  * @devlink: ice adapter's devlink (whole dev devlink)
+ * @index: Index of the adapter, also the clock ID of its recovered clock muxes
  * @ptp_gltsyn_time_lock: Spinlock protecting access to the GLTSYN_TIME
  *                        register of the PTP clock.
  * @txq_ctx_lock: Spinlock protecting access to the GLCOMM_QTX_CNTX_CTL register
@@ -58,11 +72,14 @@ struct ice_dpll_rclk_mux {
  * @cgu_synce_lock: Mutex serializing changes of the CGU registers R10 and R11,
  *                  which all PFs reach. Used on E825C devices.
  * @rclk_mux: Recovered clock muxes of the CGU. Used on E825C devices.
+ * @rclk_mux_users: Number of PFs that use @rclk_mux, protected by the
+ *                  instance lock of @devlink
  * @ctrl_pf: Control PF of the adapter
  * @ports: Ports list
  */
 struct ice_adapter {
 	struct devlink *devlink;
+	u64 index;
 
 	/* For access to the GLTSYN_TIME register */
 	spinlock_t ptp_gltsyn_time_lock;
@@ -73,6 +90,7 @@ struct ice_adapter {
 	/* Serialize changes of the SyncE CGU registers (E825C only) */
 	struct mutex cgu_synce_lock;
 	struct ice_dpll_rclk_mux rclk_mux[ICE_SYNCE_CLK_NUM];
+	unsigned int rclk_mux_users;
 
 	struct ice_pf *ctrl_pf;
 	struct ice_port_list ports;
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 11c5dc0376bb4c..a608c5ea4d5cc3 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -89,6 +89,13 @@ static const char * const ice_dpll_ext_synce_pin = "EXT_SYNCE";
 static const char * const ice_dpll_time_ref_pin = "TIME_REF";
 static const char * const ice_dpll_fwnode_ext_synce = "clk_ref_synce";
 static const char * const ice_dpll_fwnode_time_ref = "time_ref";
+static const char * const ice_dpll_rclk_out_pins[ICE_SYNCE_CLK_NUM] = {
+	"RCLK0", "RCLK1"
+};
+
+static const char * const ice_dpll_fwnode_rclk[ICE_SYNCE_CLK_NUM] = {
+	"rclk0", "rclk1"
+};
 
 static const struct dpll_pin_frequency ice_esync_range[] = {
 	DPLL_PIN_FREQUENCY_RANGE(0, DPLL_PIN_FREQUENCY_1_HZ),
@@ -2082,6 +2089,7 @@ static int ice_dpll_rclk_src_sync(struct ice_pf *pf, enum ice_synce_clk output)
  * @ena: true if enable, false in disable
  * @port_num: port number
  * @output: output pin, we have two in E825C
+ * @prev: holds the recovered clock pin the mux routed before
  *
  * DPLL subsystem callback. Set proper signals to recover clock from port.
  * Record in the adapter which port the mux routes.
@@ -2092,12 +2100,14 @@ static int ice_dpll_rclk_src_sync(struct ice_pf *pf, enum ice_synce_clk output)
  * * negative - error
  */
 static int ice_dpll_synce_update_e825c(struct ice_hw *hw, bool ena,
-				       u32 port_num, enum ice_synce_clk output)
+				       u32 port_num, enum ice_synce_clk output,
+				       struct dpll_pin **prev)
 {
 	struct ice_pf *pf = hw->back;
 	int err;
 
 	mutex_lock(&pf->adapter->cgu_synce_lock);
+	*prev = pf->adapter->rclk_mux[output].src;
 	/* configure the mux to deliver proper signal to DPLL from the MUX */
 	err = ice_tspll_cfg_bypass_mux_e825c(hw, ena, port_num, output);
 	if (!err) {
@@ -2121,6 +2131,45 @@ static int ice_dpll_synce_update_e825c(struct ice_hw *hw, bool ena,
 	return 0;
 }
 
+/**
+ * ice_dpll_rclk_mux_ntf - notify a change of the port routed by a mux
+ * @mux: recovered clock mux
+ *
+ * The lock status and the output of a mux follow the port it routes.
+ */
+static void ice_dpll_rclk_mux_ntf(struct ice_dpll_rclk_mux *mux)
+{
+	dpll_device_change_ntf(mux->dpll);
+	dpll_pin_change_ntf(mux->out);
+}
+
+/**
+ * __ice_dpll_rclk_mux_ntf - notify a change of the port routed by a mux
+ * @mux: recovered clock mux
+ * @prev: recovered clock pin the mux routed before
+ * @skip: recovered clock pin the caller notifies, or NULL
+ *
+ * When the mux routes another port than before, notify its device and its
+ * output, and the recovered clock pins whose state on the mux changed.
+ *
+ * Context: Called under dpll_lock
+ */
+static void __ice_dpll_rclk_mux_ntf(struct ice_dpll_rclk_mux *mux,
+				    struct dpll_pin *prev,
+				    struct dpll_pin *skip)
+{
+	struct dpll_pin *src = READ_ONCE(mux->src);
+
+	if (src == prev)
+		return;
+	if (prev && prev != skip)
+		__dpll_pin_change_ntf(prev);
+	if (src && src != skip)
+		__dpll_pin_change_ntf(src);
+	__dpll_device_change_ntf(mux->dpll);
+	__dpll_pin_change_ntf(mux->out);
+}
+
 /**
  * ice_dpll_rclk_src_init - record the muxes that route the port of the PF
  * @pf: board private structure
@@ -2135,13 +2184,27 @@ static int ice_dpll_synce_update_e825c(struct ice_hw *hw, bool ena,
  */
 static int ice_dpll_rclk_src_init(struct ice_pf *pf)
 {
+	struct ice_dpll_rclk_mux *muxes = pf->adapter->rclk_mux;
+	bool changed[ICE_SYNCE_CLK_NUM] = {};
+	struct dpll_pin *prev;
 	int err = 0, i;
 
 	mutex_lock(&pf->adapter->cgu_synce_lock);
-	for (i = 0; !err && i < ICE_SYNCE_CLK_NUM; i++)
+	for (i = 0; !err && i < ICE_SYNCE_CLK_NUM; i++) {
+		prev = muxes[i].src;
 		err = ice_dpll_rclk_src_sync(pf, i);
+		changed[i] = muxes[i].src != prev;
+	}
 	mutex_unlock(&pf->adapter->cgu_synce_lock);
 
+	/* A pin routed before belongs to another PF, which can go away once
+	 * cgu_synce_lock is dropped, so notify only the muxes. The state of a
+	 * recovered clock pin is read from the hardware.
+	 */
+	for (i = 0; i < ICE_SYNCE_CLK_NUM; i++)
+		if (changed[i])
+			ice_dpll_rclk_mux_ntf(&muxes[i]);
+
 	return err;
 }
 
@@ -2154,13 +2217,21 @@ static int ice_dpll_rclk_src_init(struct ice_pf *pf)
 static void ice_dpll_rclk_src_fini(struct ice_pf *pf)
 {
 	struct ice_adapter *adapter = pf->adapter;
+	struct dpll_pin *pin = pf->dplls.rclk.pin;
+	bool routed[ICE_SYNCE_CLK_NUM] = {};
 	int i;
 
 	mutex_lock(&adapter->cgu_synce_lock);
-	for (i = 0; i < ICE_SYNCE_CLK_NUM; i++)
-		if (adapter->rclk_mux[i].src == pf->dplls.rclk.pin)
+	for (i = 0; i < ICE_SYNCE_CLK_NUM; i++) {
+		routed[i] = adapter->rclk_mux[i].src == pin;
+		if (routed[i])
 			WRITE_ONCE(adapter->rclk_mux[i].src, NULL);
+	}
 	mutex_unlock(&adapter->cgu_synce_lock);
+
+	for (i = 0; i < ICE_SYNCE_CLK_NUM; i++)
+		if (routed[i])
+			ice_dpll_rclk_mux_ntf(&adapter->rclk_mux[i]);
 }
 
 /**
@@ -2630,7 +2701,9 @@ ice_dpll_rclk_state_on_pin_set(const struct dpll_pin *pin, void *pin_priv,
 			       struct netlink_ext_ack *extack)
 {
 	bool enable = state == DPLL_PIN_STATE_CONNECTED;
+	struct ice_dpll_rclk_mux *mux = NULL;
 	struct ice_dpll_pin *p = pin_priv;
+	struct dpll_pin *prev = NULL;
 	struct ice_pf *pf = p->pf;
 	struct ice_hw *hw;
 	int ret = -EINVAL;
@@ -2658,11 +2731,15 @@ ice_dpll_rclk_state_on_pin_set(const struct dpll_pin *pin, void *pin_priv,
 		goto unlock;
 	}
 
-	ret = hw->mac_type == ICE_MAC_GENERIC_3K_E825 ?
-		ice_dpll_synce_update_e825c(hw, enable,
-					    pf->ptp.port.port_num,
-					    (enum ice_synce_clk)hw_idx) :
-		ice_aq_set_phy_rec_clk_out(hw, hw_idx, enable, &p->freq);
+	if (hw->mac_type == ICE_MAC_GENERIC_3K_E825) {
+		mux = &pf->adapter->rclk_mux[hw_idx];
+		ret = ice_dpll_synce_update_e825c(hw, enable,
+						  pf->ptp.port.port_num,
+						  (enum ice_synce_clk)hw_idx,
+						  &prev);
+	} else {
+		ret = ice_aq_set_phy_rec_clk_out(hw, hw_idx, enable, &p->freq);
+	}
 	if (ret)
 		NL_SET_ERR_MSG_FMT(extack,
 				   "err:%d %s failed to set pin state:%u for pin:%u on parent:%u",
@@ -2672,6 +2749,9 @@ ice_dpll_rclk_state_on_pin_set(const struct dpll_pin *pin, void *pin_priv,
 				   ice_dpll_pin_get_parent_num(p, parent_pin));
 unlock:
 	mutex_unlock(&pf->dplls.lock);
+	/* The core notifies this pin on success */
+	if (mux)
+		__ice_dpll_rclk_mux_ntf(mux, prev, ret ? NULL : p->pin);
 
 	return ret;
 }
@@ -2728,6 +2808,82 @@ ice_dpll_rclk_state_on_pin_get(const struct dpll_pin *pin, void *pin_priv,
 	return ret;
 }
 
+/**
+ * ice_dpll_rclk_mux_lock_status_get - get the status of a recovered clock mux
+ * @dpll: registered dpll pointer
+ * @dpll_priv: private data pointer passed on dpll registration
+ * @status: on success holds the lock status of the mux
+ * @status_error: status error value
+ * @extack: error reporting
+ *
+ * Dpll subsystem callback. A mux has no loop to lock, report it locked while
+ * it routes the recovered clock of a port to its output.
+ *
+ * Return: 0 - success
+ */
+static int
+ice_dpll_rclk_mux_lock_status_get(const struct dpll_device *dpll,
+				  void *dpll_priv,
+				  enum dpll_lock_status *status,
+				  enum dpll_lock_status_error *status_error,
+				  struct netlink_ext_ack *extack)
+{
+	struct ice_dpll_rclk_mux *mux = dpll_priv;
+
+	*status = READ_ONCE(mux->src) ? DPLL_LOCK_STATUS_LOCKED :
+					DPLL_LOCK_STATUS_UNLOCKED;
+
+	return 0;
+}
+
+/**
+ * ice_dpll_rclk_mux_mode_get - get the mode of a recovered clock mux
+ * @dpll: registered dpll pointer
+ * @dpll_priv: private data pointer passed on dpll registration
+ * @mode: on success holds the mode of the mux
+ * @extack: error reporting
+ *
+ * Dpll subsystem callback. The port routed by a mux is selected manually.
+ *
+ * Return: 0 - success
+ */
+static int ice_dpll_rclk_mux_mode_get(const struct dpll_device *dpll,
+				      void *dpll_priv, enum dpll_mode *mode,
+				      struct netlink_ext_ack *extack)
+{
+	*mode = DPLL_MODE_MANUAL;
+
+	return 0;
+}
+
+/**
+ * ice_dpll_rclk_out_state_get - get a state of a recovered clock mux output
+ * @pin: pointer to a pin
+ * @pin_priv: private data pointer passed on pin registration
+ * @dpll: registered dpll pointer
+ * @dpll_priv: private data pointer passed on dpll registration
+ * @state: on success holds the state of the output
+ * @extack: error reporting
+ *
+ * Dpll subsystem callback. The output carries a clock while the mux routes
+ * the recovered clock of a port.
+ *
+ * Return: 0 - success
+ */
+static int
+ice_dpll_rclk_out_state_get(const struct dpll_pin *pin, void *pin_priv,
+			    const struct dpll_device *dpll, void *dpll_priv,
+			    enum dpll_pin_state *state,
+			    struct netlink_ext_ack *extack)
+{
+	struct ice_dpll_rclk_mux *mux = dpll_priv;
+
+	*state = READ_ONCE(mux->src) ? DPLL_PIN_STATE_CONNECTED :
+				       DPLL_PIN_STATE_DISCONNECTED;
+
+	return 0;
+}
+
 /**
  * ice_dpll_txclk_work - apply a pending TX reference clock change
  * @work: work_struct embedded in struct ice_dplls
@@ -2922,6 +3078,11 @@ static const struct dpll_pin_ops ice_dpll_rclk_ops = {
 	.direction_get = ice_dpll_input_direction,
 };
 
+static const struct dpll_pin_ops ice_dpll_rclk_out_ops = {
+	.state_on_dpll_get = ice_dpll_rclk_out_state_get,
+	.direction_get = ice_dpll_output_direction,
+};
+
 static const struct dpll_pin_ops ice_dpll_txclk_ops = {
 	.state_on_dpll_set = ice_dpll_txclk_state_on_dpll_set,
 	.state_on_dpll_get = ice_dpll_txclk_state_on_dpll_get,
@@ -3156,6 +3317,11 @@ static const struct dpll_device_ops ice_dpll_pom_ops = {
 	.phase_offset_monitor_get = ice_dpll_phase_offset_monitor_get,
 };
 
+static const struct dpll_device_ops ice_dpll_rclk_mux_ops = {
+	.lock_status_get = ice_dpll_rclk_mux_lock_status_get,
+	.mode_get = ice_dpll_rclk_mux_mode_get,
+};
+
 /**
  * ice_generate_clock_id - generates unique clock_id for registering dpll.
  * @pf: board private structure
@@ -4131,6 +4297,40 @@ static void ice_dpll_deinit_tspll_pins(struct ice_pf *pf)
 	time_ref->pin = NULL;
 }
 
+/**
+ * ice_dpll_deinit_rclk_mux - deinitialize a recovered clock mux
+ * @mux: recovered clock mux
+ *
+ * Unregister the output pin and the DPLL device of the mux and release them.
+ */
+static void ice_dpll_deinit_rclk_mux(struct ice_dpll_rclk_mux *mux)
+{
+	dpll_pin_unregister(mux->dpll, mux->out, &ice_dpll_rclk_out_ops, mux);
+	dpll_pin_put(mux->out, &mux->out_tracker);
+	dpll_device_unregister(mux->dpll, &ice_dpll_rclk_mux_ops, mux);
+	dpll_device_put(mux->dpll, &mux->tracker);
+}
+
+/**
+ * ice_dpll_rclk_muxes_put - release the recovered clock muxes for a PF
+ * @pf: board private structure
+ *
+ * The last PF of the adapter deinitializes the recovered clock muxes.
+ *
+ * Context: Acquires the instance lock of the adapter devlink
+ */
+static void ice_dpll_rclk_muxes_put(struct ice_pf *pf)
+{
+	struct ice_adapter *adapter = pf->adapter;
+	int i;
+
+	devl_lock(adapter->devlink);
+	if (!--adapter->rclk_mux_users)
+		for (i = 0; i < ICE_SYNCE_CLK_NUM; i++)
+			ice_dpll_deinit_rclk_mux(&adapter->rclk_mux[i]);
+	devl_unlock(adapter->devlink);
+}
+
 /**
  * ice_dpll_deinit_pins - deinitialize direct pins
  * @pf: board private structure
@@ -4156,6 +4356,7 @@ static void ice_dpll_deinit_pins(struct ice_pf *pf, bool cgu)
 			ice_dpll_deinit_tspll_pins(pf);
 		ice_dpll_deinit_txclk_pins(pf);
 		ice_dpll_deinit_fwnode_pins(pf, pf->dplls.inputs, 0);
+		ice_dpll_rclk_muxes_put(pf);
 	}
 	if (cgu) {
 		ice_dpll_unregister_pins(dp->dpll, inputs, &ice_dpll_input_ops,
@@ -4226,6 +4427,101 @@ static int ice_dpll_pin_link_add(struct ice_pf *pf, struct dpll_pin *pin,
 	return ret;
 }
 
+/**
+ * ice_dpll_init_rclk_mux - initialize a recovered clock mux
+ * @pf: board private structure
+ * @i: SyncE output of the CGU fed by the mux
+ *
+ * Register the mux as a DPLL device with an output pin, and link the output
+ * pin with the pin wired to it. The clock ID of both is the adapter index.
+ *
+ * Return:
+ * * 0 - success
+ * * negative - initialization failure reason
+ */
+static int ice_dpll_init_rclk_mux(struct ice_pf *pf, enum ice_synce_clk i)
+{
+	struct ice_dpll_rclk_mux *mux = &pf->adapter->rclk_mux[i];
+	struct dpll_pin_properties prop = {
+		.board_label = ice_dpll_rclk_out_pins[i],
+		.type = DPLL_PIN_TYPE_EXT,
+	};
+	u64 clock_id = pf->adapter->index;
+	int ret;
+
+	mux->idx = i;
+	mux->dpll = dpll_device_get(clock_id, i, THIS_MODULE, &mux->tracker);
+	if (IS_ERR(mux->dpll))
+		return PTR_ERR(mux->dpll);
+	ret = dpll_device_register(mux->dpll, DPLL_TYPE_GENERIC,
+				   &ice_dpll_rclk_mux_ops, mux);
+	if (ret)
+		goto put_dpll;
+	mux->out = dpll_pin_get(clock_id, i, THIS_MODULE, &prop,
+				&mux->out_tracker);
+	if (IS_ERR(mux->out)) {
+		ret = PTR_ERR(mux->out);
+		goto unregister_dpll;
+	}
+	ret = ice_dpll_pin_link_add(pf, mux->out, ice_dpll_fwnode_rclk[i]);
+	if (ret)
+		goto put_pin;
+	ret = dpll_pin_register(mux->dpll, mux->out, &ice_dpll_rclk_out_ops,
+				mux);
+	if (ret)
+		goto put_pin;
+
+	return 0;
+
+put_pin:
+	dpll_pin_put(mux->out, &mux->out_tracker);
+unregister_dpll:
+	dpll_device_unregister(mux->dpll, &ice_dpll_rclk_mux_ops, mux);
+put_dpll:
+	dpll_device_put(mux->dpll, &mux->tracker);
+
+	return ret;
+}
+
+/**
+ * ice_dpll_rclk_muxes_get - get the recovered clock muxes for a PF
+ * @pf: board private structure
+ *
+ * The PFs of the adapter share the recovered clock muxes, the first PF
+ * initializes them.
+ *
+ * Context: Acquires the instance lock of the adapter devlink
+ * Return:
+ * * 0 - success
+ * * negative - initialization failure reason
+ */
+static int ice_dpll_rclk_muxes_get(struct ice_pf *pf)
+{
+	struct ice_adapter *adapter = pf->adapter;
+	int ret, i;
+
+	devl_lock(adapter->devlink);
+	if (adapter->rclk_mux_users)
+		goto out;
+	for (i = 0; i < ICE_SYNCE_CLK_NUM; i++) {
+		ret = ice_dpll_init_rclk_mux(pf, i);
+		if (ret)
+			goto deinit_muxes;
+	}
+out:
+	adapter->rclk_mux_users++;
+	devl_unlock(adapter->devlink);
+
+	return 0;
+
+deinit_muxes:
+	while (i--)
+		ice_dpll_deinit_rclk_mux(&adapter->rclk_mux[i]);
+	devl_unlock(adapter->devlink);
+
+	return ret;
+}
+
 static int
 ice_dpll_init_fwnode_pin(struct ice_dpll_pin *pin, const char *name)
 {
@@ -4428,10 +4724,14 @@ static int ice_dpll_init_pins_e825(struct ice_pf *pf)
 {
 	int ret;
 
-	ret = ice_dpll_init_fwnode_pins(pf, pf->dplls.inputs, 0);
+	ret = ice_dpll_rclk_muxes_get(pf);
 	if (ret)
 		return ret;
 
+	ret = ice_dpll_init_fwnode_pins(pf, pf->dplls.inputs, 0);
+	if (ret)
+		goto put_muxes;
+
 	ret = ice_dpll_init_rclk_pin(pf, DPLL_PIN_IDX_UNSPEC,
 				     &ice_dpll_rclk_ops);
 
@@ -4467,6 +4767,9 @@ static int ice_dpll_init_pins_e825(struct ice_pf *pf)
 		complete_all(&pf->dplls.dpll_init);
 		ice_dpll_deinit_fwnode_pins(pf, pf->dplls.inputs, 0);
 	}
+put_muxes:
+	if (ret)
+		ice_dpll_rclk_muxes_put(pf);
 
 	return ret;
 }
-- 
2.56.1

