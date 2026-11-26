Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A4C606A31C
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 20:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=GnrtD/+3;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VXCrVuD+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A12A560A68;
	Thu, 26 Nov 2026 20:33:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5pa-H-1jL8Xi; Thu, 26 Nov 2026 20:33:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7E10660AE4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795725210;
	b=MwMaDcVrI/mVxSxmVxIX1SwGNHEcc5UUqL6LdtsEThLrg77pNoWOdY+P0kj5nLh1Dnvw
	 EgmWs2MaoCbyYSRp5oT1L1cgF/6Gd0bxTFOR9SvGYfBWEXZRbtzlH+8+bHRKhZuXd84P9
	 +GwzGp5zI/lqfhkOc8AxibntEu3o/ChUIQY5t4Zdcywh14o3q6eACKhfGjVPxWyQ69tEg
	 tGn2e7tNv9D1xoDnb3ZtJrh20CG/WkMdM7S/JNK3zPpy7XoKbTuM3HGjD0WqbWHR0cyDW
	 A9W1fafCMmbnGBOCks1FBS4/svmhGkgXH5B9Lci2zrhQAFIzW2ZmuzgmGC8V1bgXkMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795725210;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JqGgfS1UYwh29myYKdlnX7yCh7x8p4QHXJzQWaApX+M=;
	b=gEe1z+Ve90Yh2rUheDrtx9ytUQ2Z1q43x9Otwo5xKvepTThP9+hwPIWD6FzEYwBkLS5A
	 EVxbjEZDfMvx7keAMmy9iUftWbNH1wLFid3HfciGb0cf+gHINZjoGoUvqNCLixJS+HMVU
	 OwLrhHvmnu+zsBywxiq5jCao+cBjoYCuz/gB/BaBIH6mSsOuk7w0KbbFiU0B8c5YhfyxT
	 knbKxsyE87lC18S65yzm5wTAX7LBEumrIv+z+M/oCqMmrD26uqU0O8uEjF01kInB+2LYU
	 qVrtwzQD92hHvWJB5pqw1/HaN7YznXdcZigllDVAaP72BRTpRWov3nEPVYPTf4PUKOw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795725210;
	bh=JqGgfS1UYwh29myYKdlnX7yCh7x8p4QHXJzQWaApX+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GnrtD/+3CDZhUpMaeSUX323vq6RNf6KluTT2SMOD3tBIicfP6YFII/wZc0ISDtv8n
	 YNxHt3DEGQ2Fvxv5VBTNEPdvb/HXGd0ZVU1sA2dTjgOmMq47p7HBrz1zNfEvPZVe52
	 p4/eMJK+D0Sd6W8ewkwaXkEQH+g2GBlcdiHJBRK+/iRUsfOjcDQQasu9Q+vSfQIESI
	 ga6uWimolFk+ZZiE3peodMSyQJE3W81jv5Mb4+9NoaqGInDCiRl6infORt3bAzU38i
	 xmquhEJEZlO57aB1SnCuv7kYrRrsrfUlVnM9XhgkhMS1zPxA0iHG4kz3Az+MkzQxf/
	 Q/L7E+PoYPzCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E10660AE4;
	Thu, 26 Nov 2026 20:33:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 19D4A311
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:33:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0BF1180BC0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:33:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 37hXZNpGzntW for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 20:33:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 602B780BB9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VXCrVuD+
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 602B780BB9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795725204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JqGgfS1UYwh29myYKdlnX7yCh7x8p4QHXJzQWaApX+M=;
 b=VXCrVuD+0fMenCYgNKDErivQsCUgmq6yGZUIimiQr8Dq5DeWPSG89jYjxzwvcSy7Ir3bnw
 N7hNU7Y0zc7oFcBADbA4ISS18CW4wPqUlnxNCrO0DxIL0h/SHuWIFvJxaiG9ESbjO5Vyuq
 MsMfSpPGqoWjcdkogh2hCIC360yl7Oc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-L4glwJpxM2mDEbujmbGR7Q-1; Thu,
 26 Nov 2026 20:33:18 +0000
X-MC-Unique: L4glwJpxM2mDEbujmbGR7Q-1
X-Mimecast-MFC-AGG-ID: L4glwJpxM2mDEbujmbGR7Q_1795725195
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C96E2195608B; Thu, 26 Nov 2026 20:33:14 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 900521801977; Thu, 26 Nov 2026 20:33:08 +0000 (UTC)
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
Subject: [PATCH RFC net-next 05/19] ice: dpll: use own pins for the TX and
 time references
Date: Thu, 26 Nov 2026 21:32:17 +0100
Message-ID: <20261126203231.934632-6-ivecera@redhat.com>
In-Reply-To: <20261126203231.934632-1-ivecera@redhat.com>
References: <20261126203231.934632-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: _VeCR37NfMwxedX0oI2YZJeuV6SQg4IY-1-dhkmCzlE_1795725195
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

On E825 the TXC DPLL of each PF uses the zl3073x output pin wired to its
SyncE TX reference input, and the TSPLL DPLL of the PF that owns the
source timer uses the zl3073x output pin wired to its time reference
input. The driver finds these pins by firmware node, registers them with
its own DPLLs and uses the DPLL notifier to wait for them and to follow
their removal.

Register own pins instead, EXT_SYNCE next to EXT_EREF0 with the TXC DPLL
and TIME_REF with the TSPLL DPLL, and link each of them with the zl3073x
pin through the same firmware node. The pins keep the callbacks they had,
so the hardware is programmed as before. The notifier now serves the
recovered clock pin only.

The pins and EXT_EREF0 get dynamic pin indices. Without a valid MAC
address the TXC and TSPLL DPLLs fall back to the clock_id of the PF, and
fixed indices would make TIME_REF the EXT_EREF0 pin and EXT_SYNCE a pin
shared by the PFs of a NAC.

What user space sees on E825 changes:
- the zl3073x pins list only zl3073x DPLLs as parent devices and report
  a link to EXT_SYNCE of each PF or to TIME_REF
- the SyncE TX reference is selected by the state of EXT_SYNCE on the
  TXC DPLL and the time reference by the state of TIME_REF on the TSPLL
  DPLL, instead of the state of the zl3073x pins on those DPLLs
- EXT_SYNCE and TIME_REF report no frequency
- both pins exist also when the zl3073x driver is not loaded

Tested on a GNR-D platform with a dual NAC E825 and a ZL80132B DPLL: the
EXT_SYNCE pins of the eight PFs and the TIME_REF pin report their links
to the zl3073x outputs and stay without them while zl3073x is unloaded,
and connecting EXT_SYNCE on the TXC DPLL of a PF locks the DPLL.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 276 ++++++++++------------
 drivers/net/ethernet/intel/ice/ice_dpll.h |   2 +-
 2 files changed, 121 insertions(+), 157 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 5148e419f49a07..15b5f4a15af915 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -85,6 +85,8 @@ static const char * const pin_type_name[] = {
 static const char * const ice_dpll_sw_pin_sma[] = { "SMA1", "SMA2" };
 static const char * const ice_dpll_sw_pin_ufl[] = { "U.FL1", "U.FL2" };
 static const char * const ice_dpll_ext_eref_pin = "EXT_EREF0";
+static const char * const ice_dpll_ext_synce_pin = "EXT_SYNCE";
+static const char * const ice_dpll_time_ref_pin = "TIME_REF";
 static const char * const ice_dpll_fwnode_ext_synce = "clk_ref_synce";
 static const char * const ice_dpll_fwnode_time_ref = "time_ref";
 
@@ -3792,8 +3794,6 @@ static void ice_dpll_pin_notify_work(struct work_struct *work)
 						   struct ice_dpll_pin_work,
 						   work);
 	struct ice_dpll_pin *pin, *parent = w->pin;
-	bool is_tx_synce_parent = false;
-	bool is_tspll_time_ref = false;
 	struct ice_pf *pf = parent->pf;
 	bool is_rclk_parent = false;
 	int ret;
@@ -3811,14 +3811,7 @@ static void ice_dpll_pin_notify_work(struct work_struct *work)
 		}
 	}
 
-	is_tx_synce_parent =
-		ice_dpll_fwnode_eq(parent->fwnode,
-				   pf->dplls.txclks[E825_EXT_SYNCE_PIN_IDX].fwnode);
-
-	is_tspll_time_ref =
-		ice_dpll_fwnode_eq(parent->fwnode, pf->dplls.tspll_in.fwnode);
-
-	if (!is_rclk_parent && !is_tx_synce_parent && !is_tspll_time_ref)
+	if (!is_rclk_parent)
 		goto out;
 
 	switch (w->action) {
@@ -3837,40 +3830,15 @@ static void ice_dpll_pin_notify_work(struct work_struct *work)
 			goto out;
 		}
 
-		if (is_rclk_parent) {
-			/* Register rclk pin via on-pin relationship */
-			pin = &pf->dplls.rclk;
-			ret = dpll_pin_on_pin_register(parent->pin, pin->pin,
-						       &ice_dpll_rclk_ops, pin);
-			if (ret) {
-				dev_err(ice_pf_to_dev(pf),
-					"RCLK pin register failed: %pe\n",
-					ERR_PTR(ret));
-				goto drop_parent_ref;
-			}
-		} else if (is_tx_synce_parent) {
-			/* Register TX-CLK SYNCE pin directly to TXC DPLL */
-			pin = &pf->dplls.txclks[E825_EXT_SYNCE_PIN_IDX];
-			ret = dpll_pin_register(pf->dplls.txc.dpll, pin->pin,
-						&ice_dpll_txclk_ops, pin);
-			if (ret) {
-				dev_err(ice_pf_to_dev(pf),
-					"TX SYNCE pin register failed: %pe\n",
-					ERR_PTR(ret));
-				goto drop_parent_ref;
-			}
-		} else if (is_tspll_time_ref) {
-			/* Register TIME_REF pin directly to TSPLL DPLL */
-			ret = dpll_pin_register(pf->dplls.tspll.dpll,
-						parent->pin,
-						&ice_dpll_tspll_in_ops,
-						parent);
-			if (ret) {
-				dev_err(ice_pf_to_dev(pf),
-					"TSPLL TIME_REF pin register failed: %pe\n",
-					ERR_PTR(ret));
-				goto drop_parent_ref;
-			}
+		/* Register rclk pin via on-pin relationship */
+		pin = &pf->dplls.rclk;
+		ret = dpll_pin_on_pin_register(parent->pin, pin->pin,
+					       &ice_dpll_rclk_ops, pin);
+		if (ret) {
+			dev_err(ice_pf_to_dev(pf),
+				"RCLK pin register failed: %pe\n",
+				ERR_PTR(ret));
+			goto drop_parent_ref;
 		}
 		break;
 	case DPLL_PIN_DELETED:
@@ -3879,22 +3847,10 @@ static void ice_dpll_pin_notify_work(struct work_struct *work)
 			goto out;
 		}
 
-		if (is_rclk_parent) {
-			/* Unregister rclk pin */
-			pin = &pf->dplls.rclk;
-			dpll_pin_on_pin_unregister(parent->pin, pin->pin,
-						   &ice_dpll_rclk_ops, pin);
-		} else if (is_tx_synce_parent) {
-			/* Unregister TX-CLK SYNCE pin from TXC DPLL */
-			pin = &pf->dplls.txclks[E825_EXT_SYNCE_PIN_IDX];
-			dpll_pin_unregister(pf->dplls.txc.dpll, pin->pin,
-					    &ice_dpll_txclk_ops, pin);
-		} else if (is_tspll_time_ref) {
-			/* Unregister TIME_REF pin from TSPLL DPLL */
-			dpll_pin_unregister(pf->dplls.tspll.dpll,
-					    parent->pin,
-					    &ice_dpll_tspll_in_ops, parent);
-		}
+		/* Unregister rclk pin */
+		pin = &pf->dplls.rclk;
+		dpll_pin_on_pin_unregister(parent->pin, pin->pin,
+					   &ice_dpll_rclk_ops, pin);
 drop_parent_ref:
 		/* Drop fwnode pin reference */
 		dpll_pin_put(parent->pin, &parent->tracker);
@@ -4067,43 +4023,36 @@ ice_dpll_deinit_fwnode_pins(struct ice_pf *pf, struct ice_dpll_pin *pins,
 	destroy_workqueue(pf->dplls.wq);
 }
 
-static int ice_dpll_deinit_txclk_pins(struct ice_pf *pf, bool flush)
+static void ice_dpll_deinit_txclk_pins(struct ice_pf *pf)
 {
-	struct ice_dpll_pin *synce_pin = &pf->dplls.txclks[E825_EXT_SYNCE_PIN_IDX];
-	struct ice_dpll *dt = &pf->dplls.txc;
+	struct ice_dplls *d = &pf->dplls;
+	int i;
 
-	ice_dpll_stop_fwnode_pin_activity(synce_pin, flush);
-	ice_dpll_unregister_pins(dt->dpll, pf->dplls.txclks,
-				 &ice_dpll_txclk_ops,
-				 ARRAY_SIZE(pf->dplls.txclks));
-	ice_dpll_release_pins(&pf->dplls.txclks[E825_EXT_EREF_PIN_IDX], 1);
-	/* ice_dpll_release_pins() puts the pin but does not clear the slot,
-	 * unlike ice_dpll_release_fwnode_pin() used for SYNCE below. NULL it
-	 * so a late ice_txclk_get_pin() returns NULL rather than a dangling
-	 * pointer.
+	ice_dpll_unregister_pins(d->txc.dpll, d->txclks, &ice_dpll_txclk_ops,
+				 ARRAY_SIZE(d->txclks));
+	ice_dpll_release_pins(d->txclks, ARRAY_SIZE(d->txclks));
+	/* ice_dpll_release_pins() puts the pins but does not clear the slots.
+	 * Clear them so a late ice_txclk_get_pin() returns NULL rather than a
+	 * dangling pointer.
 	 */
-	pf->dplls.txclks[E825_EXT_EREF_PIN_IDX].pin = NULL;
-	ice_dpll_release_fwnode_pin(synce_pin);
-	return 0;
+	for (i = 0; i < ARRAY_SIZE(d->txclks); i++)
+		d->txclks[i].pin = NULL;
 }
 
 /**
- * ice_dpll_deinit_tspll_pins - deinitialize TSPLL fwnode pin
+ * ice_dpll_deinit_tspll_pins - deinitialize TSPLL pin
  * @pf: board private structure
  *
- * Stop notifier activity and release the TIME_REF fwnode pin, unregistering
- * it from the TSPLL DPLL if it was registered.
+ * Unregister the TIME_REF pin from the TSPLL DPLL and release it.
  */
 static void ice_dpll_deinit_tspll_pins(struct ice_pf *pf)
 {
 	struct ice_dpll_pin *time_ref = &pf->dplls.tspll_in;
-	struct ice_dpll *tp = &pf->dplls.tspll;
 
-	ice_dpll_stop_fwnode_pin_activity(time_ref, true);
-	if (!IS_ERR_OR_NULL(time_ref->pin))
-		dpll_pin_unregister(tp->dpll, time_ref->pin,
-				    &ice_dpll_tspll_in_ops, time_ref);
-	ice_dpll_release_fwnode_pin(time_ref);
+	ice_dpll_unregister_pins(pf->dplls.tspll.dpll, time_ref,
+				 &ice_dpll_tspll_in_ops, 1);
+	ice_dpll_release_pins(time_ref, 1);
+	time_ref->pin = NULL;
 }
 
 /**
@@ -4129,7 +4078,7 @@ static void ice_dpll_deinit_pins(struct ice_pf *pf, bool cgu)
 		if (ice_pf_src_tmr_owned(pf) &&
 		    test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags))
 			ice_dpll_deinit_tspll_pins(pf);
-		ice_dpll_deinit_txclk_pins(pf, true);
+		ice_dpll_deinit_txclk_pins(pf);
 		ice_dpll_deinit_fwnode_pins(pf, pf->dplls.inputs, 0);
 	}
 	if (cgu) {
@@ -4173,6 +4122,34 @@ ice_dpll_pin_node_get(struct ice_pf *pf, const char *name)
 	return fwnode_find_reference(fwnode, "dpll-pins", index);
 }
 
+/**
+ * ice_dpll_pin_link_add - link a pin with the pin wired to it
+ * @pf: board private structure
+ * @pin: pin of the driver
+ * @name: name of the firmware node of the pin at the other end
+ *
+ * Return:
+ * * 0 - success
+ * * negative - failure reason
+ */
+static int ice_dpll_pin_link_add(struct ice_pf *pf, struct dpll_pin *pin,
+				 const char *name)
+{
+	struct fwnode_handle *fwnode;
+	int ret;
+
+	fwnode = ice_dpll_pin_node_get(pf, name);
+	if (IS_ERR(fwnode)) {
+		dev_err(ice_pf_to_dev(pf),
+			"Failed to find %s firmware node: %pe\n", name, fwnode);
+		return -ENODEV;
+	}
+	ret = dpll_pin_link_add(pin, fwnode);
+	fwnode_handle_put(fwnode);
+
+	return ret;
+}
+
 static int
 ice_dpll_init_fwnode_pin(struct ice_dpll_pin *pin, const char *name)
 {
@@ -4266,77 +4243,58 @@ ice_dpll_init_fwnode_pins(struct ice_pf *pf, struct ice_dpll_pin *pins,
 	return ret;
 }
 
-static int ice_dpll_init_txclk_pins(struct ice_pf *pf, int start_idx)
+/**
+ * ice_dpll_init_txclk_pins - init and register TX reference clock pins
+ * @pf: board private structure
+ *
+ * Get the EXT_EREF0 and EXT_SYNCE pins, link EXT_SYNCE with the pin wired to
+ * it and register both pins with the TXC DPLL.
+ *
+ * Return:
+ * * 0 - success
+ * * negative - initialization failure reason
+ */
+static int ice_dpll_init_txclk_pins(struct ice_pf *pf)
 {
-	struct ice_dpll_pin *ref_pin = pf->dplls.txclks;
+	struct ice_dpll_pin *pins = pf->dplls.txclks;
 	struct ice_dpll *txc = &pf->dplls.txc;
 	u64 clock_id;
-	int ret;
+	int ret, i;
 
-	/* EXT_EREF0 is a non-fwnode pin; its clock_id must match the TX-CLK
-	 * DPLL device clock_id (see dpll_pin_register()).
+	/* The clock_id of the pins must match the TXC DPLL device clock_id
+	 * (see dpll_pin_register()). Without a valid MAC address it is the
+	 * clock_id of the other DPLLs of the NIC, so the pin indices are
+	 * dynamic to keep the pins distinct.
 	 */
 	clock_id = ice_generate_dpll_clock_id(pf, txc, DPLL_TYPE_GENERIC);
-
-	/* Configure EXT_EREF0 pin */
-	ret = ice_dpll_get_pins(pf, ref_pin, start_idx, 1, clock_id);
+	ret = ice_dpll_get_pins(pf, pins, DPLL_PIN_IDX_UNSPEC,
+				ICE_DPLL_TXCLK_NUM_MAX, clock_id);
 	if (ret)
 		return ret;
-	ret = dpll_pin_register(txc->dpll, ref_pin->pin, &ice_dpll_txclk_ops,
-				ref_pin);
+	ret = ice_dpll_pin_link_add(pf, pins[E825_EXT_SYNCE_PIN_IDX].pin,
+				    ice_dpll_fwnode_ext_synce);
 	if (ret)
-		goto err_release_ext_eref;
-
-	/*
-	 * Configure EXT_SYNCE pin (fwnode-backed).
-	 * The pin may not yet be available; in that case registration
-	 * will be deferred via the notifier path.
-	 */
-	ref_pin++;
-	ret = ice_dpll_init_fwnode_pin(ref_pin, ice_dpll_fwnode_ext_synce);
-	if (ret)
-		goto err_unregister_ext_eref;
-
-	if (IS_ERR_OR_NULL(ref_pin->pin)) {
-		dev_dbg(ice_pf_to_dev(pf),
-			"Tx-clk SYNCE pin not registered yet\n");
-		return 0;
-	}
-
-	ret = dpll_pin_register(txc->dpll, ref_pin->pin, &ice_dpll_txclk_ops,
-				ref_pin);
+		goto release_pins;
+	ret = ice_dpll_register_pins(txc->dpll, pins, &ice_dpll_txclk_ops,
+				     ICE_DPLL_TXCLK_NUM_MAX);
 	if (ret)
-		goto err_deinit_synce;
+		goto release_pins;
 
 	return 0;
 
-err_deinit_synce:
-	/*
-	 * Avoid deadlock against notifier workers blocked on dpll_init.
-	 * The outer init error path will complete dpll_init and flush the
-	 * shared workqueue before destroying it.
-	 */
-	ice_dpll_stop_fwnode_pin_activity(ref_pin, false);
-	ice_dpll_release_fwnode_pin(ref_pin);
-err_unregister_ext_eref:
-	dpll_pin_unregister(txc->dpll,
-			    pf->dplls.txclks[E825_EXT_EREF_PIN_IDX].pin,
-			    &ice_dpll_txclk_ops,
-			    &pf->dplls.txclks[E825_EXT_EREF_PIN_IDX]);
-
-err_release_ext_eref:
-	ice_dpll_release_pins(&pf->dplls.txclks[E825_EXT_EREF_PIN_IDX], 1);
-
+release_pins:
+	ice_dpll_release_pins(pins, ICE_DPLL_TXCLK_NUM_MAX);
+	for (i = 0; i < ICE_DPLL_TXCLK_NUM_MAX; i++)
+		pins[i].pin = NULL;
 	return ret;
 }
 
 /**
- * ice_dpll_init_tspll_pins - init and register TSPLL TIME_REF fwnode pin
+ * ice_dpll_init_tspll_pins - init and register TSPLL TIME_REF pin
  * @pf: board private structure
  *
- * Initialize the fwnode-based TIME_REF input pin for the TSPLL DPLL on E825.
- * If the pin is not yet available in the dpll subsystem, registration will
- * be deferred via the notifier path.
+ * Get the TIME_REF input pin of the TSPLL DPLL on E825, link it with the pin
+ * wired to it and register it with the TSPLL DPLL.
  *
  * Return:
  * * 0 - success
@@ -4346,26 +4304,36 @@ static int ice_dpll_init_tspll_pins(struct ice_pf *pf)
 {
 	struct ice_dpll_pin *time_ref = &pf->dplls.tspll_in;
 	struct ice_dpll *tp = &pf->dplls.tspll;
+	u64 clock_id;
 	int ret;
 
 	time_ref->pf = pf;
-	ret = ice_dpll_init_fwnode_pin(time_ref, ice_dpll_fwnode_time_ref);
+	time_ref->prop.type = DPLL_PIN_TYPE_EXT;
+	time_ref->prop.capabilities = DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
+	time_ref->prop.board_label = ice_dpll_time_ref_pin;
+
+	/* The clock_id of the pin must match the TSPLL DPLL device clock_id
+	 * (see dpll_pin_register()), the pin index is dynamic as for the TX
+	 * reference pins.
+	 */
+	clock_id = ice_generate_dpll_clock_id(pf, tp, DPLL_TYPE_GENERIC);
+	ret = ice_dpll_get_pins(pf, time_ref, DPLL_PIN_IDX_UNSPEC, 1, clock_id);
 	if (ret)
 		return ret;
-
-	if (IS_ERR_OR_NULL(time_ref->pin)) {
-		dev_dbg(ice_pf_to_dev(pf),
-			"TSPLL TIME_REF pin not registered yet\n");
-		return 0;
-	}
-
+	ret = ice_dpll_pin_link_add(pf, time_ref->pin,
+				    ice_dpll_fwnode_time_ref);
+	if (ret)
+		goto release_pin;
 	ret = dpll_pin_register(tp->dpll, time_ref->pin,
 				&ice_dpll_tspll_in_ops, time_ref);
-	if (ret) {
-		ice_dpll_stop_fwnode_pin_activity(time_ref, false);
-		ice_dpll_release_fwnode_pin(time_ref);
-	}
+	if (ret)
+		goto release_pin;
+
+	return 0;
 
+release_pin:
+	ice_dpll_release_pins(time_ref, 1);
+	time_ref->pin = NULL;
 	return ret;
 }
 
@@ -4394,7 +4362,7 @@ static int ice_dpll_init_pins_e825(struct ice_pf *pf)
 	if (ret)
 		goto unregister_pins;
 
-	ret = ice_dpll_init_txclk_pins(pf, 0);
+	ret = ice_dpll_init_txclk_pins(pf);
 	if (ret) {
 		ice_dpll_deinit_rclk_pin(pf);
 		goto unregister_pins;
@@ -4404,12 +4372,7 @@ static int ice_dpll_init_pins_e825(struct ice_pf *pf)
 	    test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags)) {
 		ret = ice_dpll_init_tspll_pins(pf);
 		if (ret) {
-			/* Avoid flushing pf->dplls.wq here: notifier work
-			 * items block on pf->dplls.dpll_init which is
-			 * completed by the unregister_pins path below.
-			 * destroy_workqueue() there drains queued items.
-			 */
-			ice_dpll_deinit_txclk_pins(pf, false);
+			ice_dpll_deinit_txclk_pins(pf);
 			ice_dpll_deinit_rclk_pin(pf);
 		}
 	}
@@ -4964,6 +4927,7 @@ static int ice_dpll_init_info_txclk_pins_e825c(struct ice_pf *pf)
 			tx_pin->prop.board_label = ice_dpll_ext_eref_pin;
 			tx_pin->tx_ref_src = ICE_REF_CLK_EREF0;
 		} else if (i == E825_EXT_SYNCE_PIN_IDX) {
+			tx_pin->prop.board_label = ice_dpll_ext_synce_pin;
 			tx_pin->tx_ref_src = ICE_REF_CLK_SYNCE;
 		}
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
index 3f9a993129acef..e0b48c8af3fbbb 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -138,7 +138,7 @@ struct ice_dpll {
  * @outputs: output pins pointer
  * @rclk: recovered pins pointer
  * @txclks: TX clock reference pins pointer
- * @tspll_in: TSPLL TIME_REF fwnode input pin (E825 only)
+ * @tspll_in: TSPLL TIME_REF input pin (E825 only)
  * @num_inputs: number of input pins available on dpll
  * @num_outputs: number of output pins available on dpll
  * @cgu_state_acq_err_num: number of errors returned during periodic work
-- 
2.56.1

