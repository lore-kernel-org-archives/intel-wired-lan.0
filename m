Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1C6606A687
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 20:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=fSBkwrw/;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RGTQwvIE
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9280160AE4;
	Thu, 26 Nov 2026 20:34:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jFm-m-YJI1u2; Thu, 26 Nov 2026 20:34:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1707F60A8F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795725270;
	b=Vzqf+O7kMUiSKMtRBUVcLZXyinaNzIIJsZlnDy5uamUdUzA7jNe/Bu7/xbBw4qFLVdKO
	 5g+YpLEYzI1/1KePIKLY6Lu0DJA99H3J7Z2UYExZSKI/UKIc/+S+0o5FMebX9GHl3OXmu
	 lxgif5PRXDYUQZR7yqqW0PWzCxOT/OQYpDg0ugHjhXsBH9X8ydgf1Fn7OxLzEygSNGRKE
	 Qx0fyQFnqicpzg1m1fBiXCLqkh42yM2GtlhsGREK/mVPR5PjEGcjVfGqOuZya0cP9/A18
	 Q0GOEafKUKT4xcxAiVHrARkfb6TPOsilurEyOfsfyuV5pR4QL34gLSja/c6XHS70j/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795725270;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-MC-Rep:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gFvAshBb3ItEkFoZLWOKRrtMPlUAP2kdmmHXO+xkgDU=;
	b=Y0xRZuomobVcYw93pIhFOyuEBp8+pNjw5g759SHLuaVl2S4+9BaUPgW8BfCAORFetNBA
	 jmzIy7tEdVuoVxoDcQKyZ64OGxjeLlElPVtoHtHOWI9GeT4bfmaMw0A2Km9C7ftgBaQYa
	 k4EB7P79O2MA4UnhP/kkHSRiYQ/sSd/gZQSu4RvA/K34P448IJagiENm/c/YqagzfZmau
	 u8Npe68KgreTuccPQVmiiKfYVy9TMJoTE936zOof14mINLJAmXhlNmMKmWK46uBY1RyuB
	 WE1Dx3Wh4UefA04wps3P5w6ZBIGRCPuqHoWSSD0AknLRV8pqfNBbeGOQZl7ci28FevA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795725270;
	bh=gFvAshBb3ItEkFoZLWOKRrtMPlUAP2kdmmHXO+xkgDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fSBkwrw/xxspriqS37PN4Ff3CFHExYoewbephSCUTzGjZRYgb1oJ6GKmCicTzJ4q1
	 Gc1BNRfnexGH3XbRzVCZwb9EFcJVsgiWfBQnwaWy9TbarNIKTgjxv6E5AVWB1CqO/7
	 0cdNYWjZ4uUZd2vBVDEcP/1gECefFgLEjRK1O8DIUkFppmWBR3uCSShiCNfcMWKtLr
	 VkQkIik87KMmT/1nLDGQ45RAAPENp0rNNwFAqAg2c9hD28PQshiqCsCGYexjMg+ZOT
	 G1c8TceJwUQXchGP/vVYULjETPJXEb1TYrW3WU02UONpjKMtyJroHgdSdLsIBGimCd
	 t3/wGXxVbn1Og==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1707F60A8F;
	Thu, 26 Nov 2026 20:34:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AAF311AB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:34:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9BF1D4054A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:34:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8-XiaVJuzrG1 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 20:34:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6E2FC400CB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RGTQwvIE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6E2FC400CB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795725266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gFvAshBb3ItEkFoZLWOKRrtMPlUAP2kdmmHXO+xkgDU=;
 b=RGTQwvIEgyUns8PTvjnKJ2XbjD/AZuHgXxK5XYKt3bJMzAkn/TV5ZKVhOoPJJRRGvNvvcU
 TXWqLpyFQUvwJ+H5VNtaH7X4qIFIgPI3xfojpvjcMXHHavc1eoFbtUifZlRA80DOa82Bj7
 TwFF++OipsippbrJmm+wmfXWFVbWpC8=
X-MC-Rep: binary re single
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-ns_tOmfsO-63Nd6RACXUcw-1; Thu,
 26 Nov 2026 20:34:19 +0000
X-MC-Unique: ns_tOmfsO-63Nd6RACXUcw-1
X-Mimecast-MFC-AGG-ID: ns_tOmfsO-63Nd6RACXUcw_1795725256
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09864180062A; Thu, 26 Nov 2026 20:34:16 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CCB611801A6D; Thu, 26 Nov 2026 20:34:09 +0000 (UTC)
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
Subject: [PATCH RFC net-next 14/19] ice: dpll: route the E825 recovered clock
 through the mux devices
Date: Thu, 26 Nov 2026 21:32:26 +0100
Message-ID: <20261126203231.934632-15-ivecera@redhat.com>
In-Reply-To: <20261126203231.934632-1-ivecera@redhat.com>
References: <20261126203231.934632-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: oHu33hMvGHNj5Cpdx4QOuPwYK82vvzNtKU9rLwTRSj8_1795725256
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

On E825 the driver registers the recovered clock pin of each PF as a
child of the zl3073x pins rclk0 and rclk1 with
dpll_pin_on_pin_register(). It finds them by firmware node, holds
references to them and uses the DPLL notifier to wait for them and to
follow their removal.

Register the recovered clock pin as an input of both mux devices
instead, with the clock ID of the muxes. The state of the pin on a mux
selects the port for the output of the mux. Connecting a port
disconnects the port the mux routed before, which gets a change
notification. Setting and reading the state accesses the same CGU
registers as before.

Drop the notifier work, the firmware node pins and the dpll_init
completion, which served only this path, and the E825 case of
ice_get_cgu_rclk_pin_info().

What user space sees on E825 changes:
- the recovered clock pin lists the two mux devices as parent devices
  instead of the zl3073x pins as parent pins, so a port is routed by
  setting the state of its pin on a mux device
- the clock ID of the recovered clock pin is the adapter index instead
  of the DSN; neither tells the PFs apart, as all PFs of a complex have
  the same DSN
- the zl3073x pins have no child pins; the firmware still describes
  them as MUX pins, which they no longer need to be
- the recovered clock pin exists also when the zl3073x driver is not
  loaded

Tested on a GNR-D platform with a dual NAC E825 and a ZL80132B DPLL:
routing each port to RCLK0 or RCLK1 updates the pin states, the lock
status of the mux and the output pin, and notifies the port routed
before. With a 25 Gb/s port routed, the zl3073x input measures
78.125 MHz and qualifies; a 1 Gb/s port gives 62.5 MHz, as set by the
divider. A PF bound again finds its port still routed.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c   | 522 +++++++-------------
 drivers/net/ethernet/intel/ice/ice_dpll.h   |   9 -
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c |   8 -
 3 files changed, 190 insertions(+), 349 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index a608c5ea4d5cc3..42579cc3fb9e03 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -613,9 +613,6 @@ static int ice_dpll_rclk_update_e825c(struct ice_pf *pf,
 	int err, i;
 	u8 sel;
 
-	if (pf->dplls.rclk.num_parents > ICE_SYNCE_CLK_NUM)
-		return -EINVAL;
-
 	for (i = 0; i < ICE_SYNCE_CLK_NUM; i++) {
 		err = ice_dpll_rclk_mux_sel_get(&pf->hw, i, &sel);
 		if (err)
@@ -2701,9 +2698,7 @@ ice_dpll_rclk_state_on_pin_set(const struct dpll_pin *pin, void *pin_priv,
 			       struct netlink_ext_ack *extack)
 {
 	bool enable = state == DPLL_PIN_STATE_CONNECTED;
-	struct ice_dpll_rclk_mux *mux = NULL;
 	struct ice_dpll_pin *p = pin_priv;
-	struct dpll_pin *prev = NULL;
 	struct ice_pf *pf = p->pf;
 	struct ice_hw *hw;
 	int ret = -EINVAL;
@@ -2731,15 +2726,7 @@ ice_dpll_rclk_state_on_pin_set(const struct dpll_pin *pin, void *pin_priv,
 		goto unlock;
 	}
 
-	if (hw->mac_type == ICE_MAC_GENERIC_3K_E825) {
-		mux = &pf->adapter->rclk_mux[hw_idx];
-		ret = ice_dpll_synce_update_e825c(hw, enable,
-						  pf->ptp.port.port_num,
-						  (enum ice_synce_clk)hw_idx,
-						  &prev);
-	} else {
-		ret = ice_aq_set_phy_rec_clk_out(hw, hw_idx, enable, &p->freq);
-	}
+	ret = ice_aq_set_phy_rec_clk_out(hw, hw_idx, enable, &p->freq);
 	if (ret)
 		NL_SET_ERR_MSG_FMT(extack,
 				   "err:%d %s failed to set pin state:%u for pin:%u on parent:%u",
@@ -2749,9 +2736,6 @@ ice_dpll_rclk_state_on_pin_set(const struct dpll_pin *pin, void *pin_priv,
 				   ice_dpll_pin_get_parent_num(p, parent_pin));
 unlock:
 	mutex_unlock(&pf->dplls.lock);
-	/* The core notifies this pin on success */
-	if (mux)
-		__ice_dpll_rclk_mux_ntf(mux, prev, ret ? NULL : p->pin);
 
 	return ret;
 }
@@ -2856,6 +2840,108 @@ static int ice_dpll_rclk_mux_mode_get(const struct dpll_device *dpll,
 	return 0;
 }
 
+/**
+ * ice_dpll_rclk_state_on_dpll_set - set a state of rclk pin on a mux
+ * @pin: pointer to a pin
+ * @pin_priv: private data pointer passed on pin registration
+ * @dpll: registered dpll pointer
+ * @dpll_priv: private data pointer passed on dpll registration
+ * @state: state to be set on pin
+ * @extack: error reporting
+ *
+ * Dpll subsystem callback. Route the recovered clock of the port to the
+ * output of a recovered clock mux, or stop routing it.
+ *
+ * Context: Acquires pf->dplls.lock
+ * Return:
+ * * 0 - success
+ * * negative - failure
+ */
+static int
+ice_dpll_rclk_state_on_dpll_set(const struct dpll_pin *pin, void *pin_priv,
+				const struct dpll_device *dpll,
+				void *dpll_priv, enum dpll_pin_state state,
+				struct netlink_ext_ack *extack)
+{
+	bool enable = state == DPLL_PIN_STATE_CONNECTED;
+	struct ice_dpll_rclk_mux *mux = dpll_priv;
+	struct ice_dpll_pin *p = pin_priv;
+	struct ice_pf *pf = p->pf;
+	struct dpll_pin *prev;
+	int ret = -EINVAL;
+
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+
+	/* Read again with the write of the mux, under cgu_synce_lock */
+	prev = READ_ONCE(mux->src);
+	mutex_lock(&pf->dplls.lock);
+	if ((enable && p->state[mux->idx] == DPLL_PIN_STATE_CONNECTED) ||
+	    (!enable && p->state[mux->idx] == DPLL_PIN_STATE_DISCONNECTED)) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "pin:%u state:%u on dpll:%u already set",
+				   p->idx, state, mux->idx);
+		goto unlock;
+	}
+
+	ret = ice_dpll_synce_update_e825c(&pf->hw, enable,
+					  pf->ptp.port.port_num, mux->idx,
+					  &prev);
+	if (ret)
+		NL_SET_ERR_MSG_FMT(extack,
+				   "err:%d %s failed to set pin state:%u for pin:%u on dpll:%u",
+				   ret,
+				   libie_aq_str(pf->hw.adminq.sq_last_status),
+				   state, p->idx, mux->idx);
+unlock:
+	mutex_unlock(&pf->dplls.lock);
+	/* The core notifies this pin on success */
+	__ice_dpll_rclk_mux_ntf(mux, prev, ret ? NULL : p->pin);
+
+	return ret;
+}
+
+/**
+ * ice_dpll_rclk_state_on_dpll_get - get a state of rclk pin on a mux
+ * @pin: pointer to a pin
+ * @pin_priv: private data pointer passed on pin registration
+ * @dpll: registered dpll pointer
+ * @dpll_priv: private data pointer passed on dpll registration
+ * @state: on success holds pin state on the mux
+ * @extack: error reporting
+ *
+ * Dpll subsystem callback. Get the state of the recovered clock pin on a
+ * recovered clock mux.
+ *
+ * Context: Acquires pf->dplls.lock
+ * Return:
+ * * 0 - success
+ * * negative - failure
+ */
+static int
+ice_dpll_rclk_state_on_dpll_get(const struct dpll_pin *pin, void *pin_priv,
+				const struct dpll_device *dpll,
+				void *dpll_priv, enum dpll_pin_state *state,
+				struct netlink_ext_ack *extack)
+{
+	struct ice_dpll_rclk_mux *mux = dpll_priv;
+	struct ice_dpll_pin *p = pin_priv;
+	struct ice_pf *pf = p->pf;
+	int ret;
+
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+
+	mutex_lock(&pf->dplls.lock);
+	ret = ice_dpll_pin_state_update(pf, p, ICE_DPLL_PIN_TYPE_RCLK_INPUT,
+					extack);
+	if (!ret)
+		*state = p->state[mux->idx];
+	mutex_unlock(&pf->dplls.lock);
+
+	return ret;
+}
+
 /**
  * ice_dpll_rclk_out_state_get - get a state of a recovered clock mux output
  * @pin: pointer to a pin
@@ -3078,6 +3164,12 @@ static const struct dpll_pin_ops ice_dpll_rclk_ops = {
 	.direction_get = ice_dpll_input_direction,
 };
 
+static const struct dpll_pin_ops ice_dpll_rclk_in_ops = {
+	.state_on_dpll_set = ice_dpll_rclk_state_on_dpll_set,
+	.state_on_dpll_get = ice_dpll_rclk_state_on_dpll_get,
+	.direction_get = ice_dpll_input_direction,
+};
+
 static const struct dpll_pin_ops ice_dpll_rclk_out_ops = {
 	.state_on_dpll_get = ice_dpll_rclk_out_state_get,
 	.direction_get = ice_dpll_output_direction,
@@ -4019,125 +4111,34 @@ static void ice_dpll_deinit_rclk_pin(struct ice_pf *pf)
 		dpll_pin_on_pin_unregister(parent->pin, rclk->pin,
 					   &ice_dpll_rclk_ops, rclk);
 	}
-	if (pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825)
-		ice_dpll_rclk_src_fini(pf);
 	if (WARN_ON_ONCE(!vsi || !vsi->netdev))
 		return;
 	dpll_netdev_pin_clear(vsi->netdev);
 	dpll_pin_put(rclk->pin, &rclk->tracker);
 }
 
-static bool ice_dpll_is_fwnode_pin(struct ice_dpll_pin *pin)
-{
-	return !IS_ERR_OR_NULL(pin->fwnode);
-}
-
-static bool ice_dpll_fwnode_eq(const struct fwnode_handle *a,
-			       const struct fwnode_handle *b)
-{
-	return a && a == b;
-}
-
-static void ice_dpll_pin_notify_work(struct work_struct *work)
-{
-	struct ice_dpll_pin_work *w = container_of(work,
-						   struct ice_dpll_pin_work,
-						   work);
-	struct ice_dpll_pin *pin, *parent = w->pin;
-	struct ice_pf *pf = parent->pf;
-	bool is_rclk_parent = false;
-	int ret;
-
-	wait_for_completion(&pf->dplls.dpll_init);
-	if (!test_bit(ICE_FLAG_DPLL, pf->flags))
-		goto out; /* DPLL initialization failed */
-
-	/* Decide which parent we are handling, defensively checking FWNs */
-	for (int i = 0; i < pf->dplls.rclk.num_parents; i++) {
-		if (ice_dpll_fwnode_eq(parent->fwnode,
-				       pf->dplls.inputs[i].fwnode)) {
-			is_rclk_parent = true;
-			break;
-		}
-	}
-
-	if (!is_rclk_parent)
-		goto out;
-
-	switch (w->action) {
-	case DPLL_PIN_CREATED:
-		if (!IS_ERR_OR_NULL(parent->pin)) {
-			/* We have already our pin registered */
-			goto out;
-		}
-
-		/* Grab reference on fwnode pin */
-		parent->pin = fwnode_dpll_pin_find(parent->fwnode,
-						   &parent->tracker);
-		if (IS_ERR_OR_NULL(parent->pin)) {
-			dev_err(ice_pf_to_dev(pf),
-				"Cannot get fwnode pin reference\n");
-			goto out;
-		}
-
-		/* Register rclk pin via on-pin relationship */
-		pin = &pf->dplls.rclk;
-		ret = dpll_pin_on_pin_register(parent->pin, pin->pin,
-					       &ice_dpll_rclk_ops, pin);
-		if (ret) {
-			dev_err(ice_pf_to_dev(pf),
-				"RCLK pin register failed: %pe\n",
-				ERR_PTR(ret));
-			goto drop_parent_ref;
-		}
-		break;
-	case DPLL_PIN_DELETED:
-		if (IS_ERR_OR_NULL(parent->pin)) {
-			/* We have already our pin unregistered */
-			goto out;
-		}
-
-		/* Unregister rclk pin */
-		pin = &pf->dplls.rclk;
-		dpll_pin_on_pin_unregister(parent->pin, pin->pin,
-					   &ice_dpll_rclk_ops, pin);
-drop_parent_ref:
-		/* Drop fwnode pin reference */
-		dpll_pin_put(parent->pin, &parent->tracker);
-		parent->pin = NULL;
-		break;
-	default:
-		break;
-	}
-out:
-	kfree(w);
-}
-
-static int ice_dpll_pin_notify(struct notifier_block *nb, unsigned long action,
-			       void *data)
+/**
+ * ice_dpll_deinit_rclk_pin_e825c - release rclk pin resources on E825
+ * @pf: board private structure
+ *
+ * Unregister the rclk pin from the recovered clock muxes and release it.
+ */
+static void ice_dpll_deinit_rclk_pin_e825c(struct ice_pf *pf)
 {
-	struct ice_dpll_pin *pin = container_of(nb, struct ice_dpll_pin, nb);
-	struct dpll_pin_notifier_info *info = data;
-	struct ice_dpll_pin_work *work;
-
-	if (action != DPLL_PIN_CREATED && action != DPLL_PIN_DELETED)
-		return NOTIFY_DONE;
-
-	/* Check if the reported pin is this one */
-	if (pin->fwnode != info->fwnode)
-		return NOTIFY_DONE; /* Not this pin */
-
-	work = kzalloc_obj(*work);
-	if (!work)
-		return NOTIFY_DONE;
-
-	INIT_WORK(&work->work, ice_dpll_pin_notify_work);
-	work->action = action;
-	work->pin = pin;
-
-	queue_work(pin->pf->dplls.wq, &work->work);
+	struct ice_dpll_rclk_mux *muxes = pf->adapter->rclk_mux;
+	struct ice_dpll_pin *rclk = &pf->dplls.rclk;
+	struct ice_vsi *vsi = ice_get_main_vsi(pf);
+	int i;
 
-	return NOTIFY_OK;
+	for (i = 0; i < ICE_SYNCE_CLK_NUM; i++)
+		dpll_pin_unregister(muxes[i].dpll, rclk->pin,
+				    &ice_dpll_rclk_in_ops, rclk);
+	/* No callback of the pin runs any more and can route the port again */
+	ice_dpll_rclk_src_fini(pf);
+	if (WARN_ON_ONCE(!vsi || !vsi->netdev))
+		return;
+	dpll_netdev_pin_clear(vsi->netdev);
+	dpll_pin_put(rclk->pin, &rclk->tracker);
 }
 
 /**
@@ -4168,17 +4169,8 @@ ice_dpll_init_pin_common(struct ice_pf *pf, struct ice_dpll_pin *pin,
 	for (i = 0; i < pin->num_parents; i++) {
 		parent = &pf->dplls.inputs[pin->parent_idx[i]];
 		if (IS_ERR_OR_NULL(parent->pin)) {
-			if (!ice_dpll_is_fwnode_pin(parent)) {
-				ret = -ENODEV;
-				goto unregister_pins;
-			}
-			parent->pin = fwnode_dpll_pin_find(parent->fwnode,
-							   &parent->tracker);
-			if (IS_ERR_OR_NULL(parent->pin)) {
-				dev_info(ice_pf_to_dev(pf),
-					 "Mux pin not registered yet\n");
-				continue;
-			}
+			ret = -ENODEV;
+			goto unregister_pins;
 		}
 		ret = dpll_pin_on_pin_register(parent->pin, pin->pin, ops, pin);
 		if (ret)
@@ -4228,43 +4220,6 @@ ice_dpll_init_rclk_pin(struct ice_pf *pf, int start_idx,
 	return 0;
 }
 
-static void
-ice_dpll_stop_fwnode_pin_activity(struct ice_dpll_pin *pin, bool flush)
-{
-	unregister_dpll_notifier(&pin->nb);
-	if (flush)
-		flush_workqueue(pin->pf->dplls.wq);
-}
-
-static void
-ice_dpll_release_fwnode_pin(struct ice_dpll_pin *pin)
-{
-	if (!IS_ERR_OR_NULL(pin->pin)) {
-		dpll_pin_put(pin->pin, &pin->tracker);
-		pin->pin = NULL;
-	}
-	fwnode_handle_put(pin->fwnode);
-	pin->fwnode = NULL;
-}
-
-static void
-ice_dpll_deinit_fwnode_pin(struct ice_dpll_pin *pin)
-{
-	ice_dpll_stop_fwnode_pin_activity(pin, true);
-	ice_dpll_release_fwnode_pin(pin);
-}
-
-static void
-ice_dpll_deinit_fwnode_pins(struct ice_pf *pf, struct ice_dpll_pin *pins,
-			    int start_idx)
-{
-	int i;
-
-	for (i = 0; i < pf->dplls.rclk.num_parents; i++)
-		ice_dpll_deinit_fwnode_pin(&pins[start_idx + i]);
-	destroy_workqueue(pf->dplls.wq);
-}
-
 static void ice_dpll_deinit_txclk_pins(struct ice_pf *pf)
 {
 	struct ice_dplls *d = &pf->dplls;
@@ -4349,14 +4304,16 @@ static void ice_dpll_deinit_pins(struct ice_pf *pf, bool cgu)
 	struct ice_dpll *de = &d->eec;
 	struct ice_dpll *dp = &d->pps;
 
-	ice_dpll_deinit_rclk_pin(pf);
 	if (pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825) {
 		if (ice_pf_src_tmr_owned(pf) &&
 		    test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags))
 			ice_dpll_deinit_tspll_pins(pf);
 		ice_dpll_deinit_txclk_pins(pf);
-		ice_dpll_deinit_fwnode_pins(pf, pf->dplls.inputs, 0);
+		ice_dpll_deinit_rclk_pin_e825c(pf);
 		ice_dpll_rclk_muxes_put(pf);
+		destroy_workqueue(pf->dplls.wq);
+	} else {
+		ice_dpll_deinit_rclk_pin(pf);
 	}
 	if (cgu) {
 		ice_dpll_unregister_pins(dp->dpll, inputs, &ice_dpll_input_ops,
@@ -4522,96 +4479,50 @@ static int ice_dpll_rclk_muxes_get(struct ice_pf *pf)
 	return ret;
 }
 
-static int
-ice_dpll_init_fwnode_pin(struct ice_dpll_pin *pin, const char *name)
-{
-	struct ice_pf *pf = pin->pf;
-	int ret;
-
-	pin->fwnode = ice_dpll_pin_node_get(pf, name);
-	if (IS_ERR(pin->fwnode)) {
-		dev_err(ice_pf_to_dev(pf),
-			"Failed to find %s firmware node: %pe\n", name,
-			pin->fwnode);
-		pin->fwnode = NULL;
-		return -ENODEV;
-	}
-
-	dev_dbg(ice_pf_to_dev(pf), "Found fwnode node for %s\n", name);
-
-	pin->pin = fwnode_dpll_pin_find(pin->fwnode, &pin->tracker);
-	if (IS_ERR_OR_NULL(pin->pin)) {
-		dev_info(ice_pf_to_dev(pf),
-			 "DPLL pin for %pfwp not registered yet\n",
-			 pin->fwnode);
-		pin->pin = NULL;
-	}
-
-	pin->nb.notifier_call = ice_dpll_pin_notify;
-	ret = register_dpll_notifier(&pin->nb);
-	if (ret) {
-		dev_err(ice_pf_to_dev(pf),
-			"Failed to subscribe for DPLL notifications\n");
-
-		if (!IS_ERR_OR_NULL(pin->pin)) {
-			dpll_pin_put(pin->pin, &pin->tracker);
-			pin->pin = NULL;
-		}
-		fwnode_handle_put(pin->fwnode);
-		pin->fwnode = NULL;
-
-		return ret;
-	}
-
-	return ret;
-}
-
 /**
- * ice_dpll_init_fwnode_pins - initialize pins from device tree
+ * ice_dpll_init_rclk_pin_e825c - initialize recovered clock pin on E825
  * @pf: board private structure
- * @pins: pointer to pins array
- * @start_idx: starting index for pins
  *
- * Initialize input pins for E825 RCLK support. The parent pins (rclk0, rclk1)
- * are expected to be defined by the system firmware (ACPI). This function
- * allocates them in the dpll subsystem and stores their indices for later
- * registration with the rclk pin.
+ * Get the recovered clock pin of the PF, register it with both recovered
+ * clock muxes and record the muxes that route its port. The clock ID of the
+ * pin is the clock ID of the muxes, so the pins of all PFs of the adapter
+ * share it. A clock ID based on the DSN would not tell the PFs apart either,
+ * as all PFs of a complex have the same DSN.
  *
  * Return:
  * * 0 - success
- * * negative - initialization failure reason
+ * * negative - registration failure reason
  */
-static int
-ice_dpll_init_fwnode_pins(struct ice_pf *pf, struct ice_dpll_pin *pins,
-			  int start_idx)
+static int ice_dpll_init_rclk_pin_e825c(struct ice_pf *pf)
 {
-	char pin_name[16];
-	int i, ret;
-
-	pf->dplls.wq = create_singlethread_workqueue("ice_dpll_wq");
-	if (!pf->dplls.wq)
-		return -ENOMEM;
+	struct ice_dpll_rclk_mux *muxes = pf->adapter->rclk_mux;
+	struct ice_dpll_pin *rclk = &pf->dplls.rclk;
+	struct ice_vsi *vsi = ice_get_main_vsi(pf);
+	int ret, i;
 
-	for (i = 0; i < pf->dplls.rclk.num_parents; i++) {
-		pins[start_idx + i].pf = pf;
-		snprintf(pin_name, sizeof(pin_name), "rclk%u", i);
-		ret = ice_dpll_init_fwnode_pin(&pins[start_idx + i], pin_name);
+	ret = ice_dpll_get_pins(pf, rclk, DPLL_PIN_IDX_UNSPEC, 1,
+				pf->adapter->index);
+	if (ret)
+		return ret;
+	for (i = 0; i < ICE_SYNCE_CLK_NUM; i++) {
+		ret = dpll_pin_register(muxes[i].dpll, rclk->pin,
+					&ice_dpll_rclk_in_ops, rclk);
 		if (ret)
-			goto error;
+			goto unregister_pin;
 	}
+	ret = ice_dpll_rclk_src_init(pf);
+	if (ret)
+		goto unregister_pin;
+	dpll_netdev_pin_set(vsi->netdev, rclk->pin);
 
 	return 0;
-error:
-	/*
-	 * A notifier worker may already be queued and blocked on dpll_init;
-	 * release it so the per-pin flush below does not deadlock.
-	 */
-	complete_all(&pf->dplls.dpll_init);
-	while (i--)
-		ice_dpll_deinit_fwnode_pin(&pins[start_idx + i]);
-
-	destroy_workqueue(pf->dplls.wq);
 
+unregister_pin:
+	while (i--)
+		dpll_pin_unregister(muxes[i].dpll, rclk->pin,
+				    &ice_dpll_rclk_in_ops, rclk);
+	ice_dpll_rclk_src_fini(pf);
+	ice_dpll_release_pins(rclk, 1);
 	return ret;
 }
 
@@ -4724,52 +4635,36 @@ static int ice_dpll_init_pins_e825(struct ice_pf *pf)
 {
 	int ret;
 
+	pf->dplls.wq = create_singlethread_workqueue("ice_dpll_wq");
+	if (!pf->dplls.wq)
+		return -ENOMEM;
+
 	ret = ice_dpll_rclk_muxes_get(pf);
 	if (ret)
-		return ret;
-
-	ret = ice_dpll_init_fwnode_pins(pf, pf->dplls.inputs, 0);
+		goto destroy_wq;
+	ret = ice_dpll_init_rclk_pin_e825c(pf);
 	if (ret)
 		goto put_muxes;
-
-	ret = ice_dpll_init_rclk_pin(pf, DPLL_PIN_IDX_UNSPEC,
-				     &ice_dpll_rclk_ops);
-
-	if (ret)
-		goto unregister_pins;
-
-	ret = ice_dpll_rclk_src_init(pf);
-	if (ret) {
-		ice_dpll_deinit_rclk_pin(pf);
-		goto unregister_pins;
-	}
-
 	ret = ice_dpll_init_txclk_pins(pf);
-	if (ret) {
-		ice_dpll_deinit_rclk_pin(pf);
-		goto unregister_pins;
-	}
-
+	if (ret)
+		goto deinit_rclk_pin;
 	if (ice_pf_src_tmr_owned(pf) &&
 	    test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags)) {
 		ret = ice_dpll_init_tspll_pins(pf);
-		if (ret) {
-			ice_dpll_deinit_txclk_pins(pf);
-			ice_dpll_deinit_rclk_pin(pf);
-		}
+		if (ret)
+			goto deinit_txclk_pins;
 	}
 
-unregister_pins:
-	if (ret) {
-		/* Inform DPLL notifier works that DPLL init was finished
-		 * unsuccessfully (ICE_DPLL_FLAG not set).
-		 */
-		complete_all(&pf->dplls.dpll_init);
-		ice_dpll_deinit_fwnode_pins(pf, pf->dplls.inputs, 0);
-	}
+	return 0;
+
+deinit_txclk_pins:
+	ice_dpll_deinit_txclk_pins(pf);
+deinit_rclk_pin:
+	ice_dpll_deinit_rclk_pin_e825c(pf);
 put_muxes:
-	if (ret)
-		ice_dpll_rclk_muxes_put(pf);
+	ice_dpll_rclk_muxes_put(pf);
+destroy_wq:
+	destroy_workqueue(pf->dplls.wq);
 
 	return ret;
 }
@@ -5146,7 +5041,7 @@ ice_dpll_init_info_direct_pins(struct ice_pf *pf,
 }
 
 /**
- * ice_dpll_init_info_pin_on_pin_e825c - initializes rclk pin information
+ * ice_dpll_init_info_rclk_pin_e825c - initializes rclk pin information
  * @pf: board private structure
  *
  * Init information for rclk pin, cache them in pf->dplls.rclk.
@@ -5154,7 +5049,7 @@ ice_dpll_init_info_direct_pins(struct ice_pf *pf,
  * Return:
  * * 0 - success
  */
-static int ice_dpll_init_info_pin_on_pin_e825c(struct ice_pf *pf)
+static int ice_dpll_init_info_rclk_pin_e825c(struct ice_pf *pf)
 {
 	struct ice_dpll_pin *rclk_pin = &pf->dplls.rclk;
 
@@ -5340,7 +5235,7 @@ ice_dpll_init_pins_info(struct ice_pf *pf, enum ice_dpll_pin_type pin_type)
 		return ice_dpll_init_info_direct_pins(pf, pin_type);
 	case ICE_DPLL_PIN_TYPE_RCLK_INPUT:
 		if (pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825)
-			return ice_dpll_init_info_pin_on_pin_e825c(pf);
+			return ice_dpll_init_info_rclk_pin_e825c(pf);
 		else
 			return ice_dpll_init_info_rclk_pin(pf);
 	case ICE_DPLL_PIN_TYPE_SOFTWARE:
@@ -5387,11 +5282,9 @@ static int ice_dpll_init_info_e825c(struct ice_pf *pf)
 	struct ice_dplls *d = &pf->dplls;
 	struct ice_dpll *tp = &d->tspll;
 	struct ice_dpll *dt = &d->txc;
-	int ret = 0;
-	int i;
+	int ret;
 
 	d->clock_id = ice_generate_clock_id(pf);
-	d->num_inputs = ICE_SYNCE_CLK_NUM;
 	dt->dpll_state = ice_txclk_lock_status(pf->ptp.port.tx_clk);
 	dt->mode = DPLL_MODE_MANUAL;
 	dt->dpll_idx = E825_DPLL_TXCLK_BASE_IDX + pf->ptp.port.port_num;
@@ -5400,33 +5293,11 @@ static int ice_dpll_init_info_e825c(struct ice_pf *pf)
 	tp->mode = DPLL_MODE_MANUAL;
 	tp->dpll_idx = E825_DPLL_TSPLL_BASE_IDX;
 
-	d->inputs = kzalloc_objs(*d->inputs, d->num_inputs);
-	if (!d->inputs)
-		return -ENOMEM;
-
-	ret = ice_get_cgu_rclk_pin_info(&pf->hw, &d->base_rclk_idx,
-					&pf->dplls.rclk.num_parents);
-	if (ret)
-		goto deinit_info;
-
-	for (i = 0; i < pf->dplls.rclk.num_parents; i++)
-		pf->dplls.rclk.parent_idx[i] = d->base_rclk_idx + i;
-
 	ret = ice_dpll_init_pins_info(pf, ICE_DPLL_PIN_TYPE_RCLK_INPUT);
 	if (ret)
-		goto deinit_info;
-
-	ret = ice_dpll_init_pins_info(pf, ICE_DPLL_PIN_TYPE_TXCLK);
-	if (ret)
-		goto deinit_info;
+		return ret;
 
-	dev_dbg(ice_pf_to_dev(pf),
-		"%s - success, inputs: %u, outputs: %u, rclk-parents: %u\n",
-		 __func__, d->num_inputs, d->num_outputs, d->rclk.num_parents);
-	return 0;
-deinit_info:
-	ice_dpll_deinit_info(pf);
-	return ret;
+	return ice_dpll_init_pins_info(pf, ICE_DPLL_PIN_TYPE_TXCLK);
 }
 
 /**
@@ -5615,7 +5486,6 @@ static void ice_dpll_init_e825(struct ice_pf *pf)
 	 */
 	INIT_WORK(&d->txclk_work, ice_dpll_txclk_work);
 	init_rwsem(&d->txclk_notify_rwsem);
-	init_completion(&d->dpll_init);
 
 	err = ice_dpll_init_info_e825c(pf);
 	if (err)
@@ -5626,17 +5496,6 @@ static void ice_dpll_init_e825(struct ice_pf *pf)
 					 DPLL_TYPE_GENERIC);
 		if (err)
 			goto deinit_info;
-		/* Start the periodic worker before registering fwnode pins. The
-		 * fwnode notifier path (ice_dpll_pin_notify_work()) blocks on
-		 * pf->dplls.dpll_init, which is only signalled on the success
-		 * return below. Starting the worker before any fwnode notifier
-		 * is registered means a subsequent init failure cannot leave
-		 * notifier work items queued on pf->dplls.wq, so the deinit
-		 * flush_workqueue() paths in ice_dpll_deinit_pins() cannot
-		 * deadlock. The E825 periodic worker only touches
-		 * pf->dplls.tspll (already registered above) and pf->ptp state,
-		 * so it is safe to run before pins.
-		 */
 		err = ice_dpll_init_worker(pf);
 		if (err)
 			goto deinit_tspll;
@@ -5648,7 +5507,6 @@ static void ice_dpll_init_e825(struct ice_pf *pf)
 	if (err)
 		goto deinit_txclk;
 	set_bit(ICE_FLAG_DPLL, pf->flags);
-	complete_all(&d->dpll_init);
 
 	return;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
index e0b48c8af3fbbb..73b0eed6774aa4 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -39,12 +39,6 @@ enum ice_dpll_pin_sw {
 	ICE_DPLL_PIN_SW_NUM
 };
 
-struct ice_dpll_pin_work {
-	struct work_struct work;
-	unsigned long action;
-	struct ice_dpll_pin *pin;
-};
-
 /** ice_dpll_pin - store info about pins
  * @pin: dpll pin structure
  * @pf: pointer to pf, which has registered the dpll_pin
@@ -64,8 +58,6 @@ struct ice_dpll_pin {
 	struct dpll_pin *pin;
 	struct ice_pf *pf;
 	dpll_tracker tracker;
-	struct fwnode_handle *fwnode;
-	struct notifier_block nb;
 	u8 idx;
 	u8 num_parents;
 	u8 parent_idx[ICE_DPLL_RCLK_NUM_MAX];
@@ -179,7 +171,6 @@ struct ice_dplls {
 	struct kthread_delayed_work work;
 	struct workqueue_struct *wq;
 	struct mutex lock;
-	struct completion dpll_init;
 	struct ice_dpll eec;
 	struct ice_dpll pps;
 	struct ice_dpll txc;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index ee945ce08eb72c..3c741aa97292f1 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -6220,14 +6220,6 @@ int ice_get_cgu_rclk_pin_info(struct ice_hw *hw, u8 *base_idx, u8 *pin_num)
 		else
 			ret = -ENODEV;
 		break;
-	case ICE_DEV_ID_E825C_BACKPLANE:
-	case ICE_DEV_ID_E825C_QSFP:
-	case ICE_DEV_ID_E825C_SFP:
-	case ICE_DEV_ID_E825C_SGMII:
-		*pin_num = ICE_SYNCE_CLK_NUM;
-		*base_idx = 0;
-		ret = 0;
-		break;
 	default:
 		ret = -ENODEV;
 		break;
-- 
2.56.1

