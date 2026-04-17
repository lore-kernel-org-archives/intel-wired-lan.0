Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DC8F436B5
	for <intel-wired-lan@archiver.kernel.org>; Fri, 17 Apr 2026 14:59:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A132880E0C;
	Fri, 17 Apr 2026 14:59:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id btPOs-vokVWY; Fri, 17 Apr 2026 14:59:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CE7BE80DFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776437988;
	bh=gbpFvcWrWZxCHOudUuz8MQpAoKeJ9RTgsaIS867Lomg=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=hWiM7pVGDTujqB8+DEFwaGriadTGbAvK3mkV1M59zNlYJXIFdTUj/RxVO2p/Am/om
	 MCNzNb4YgRoo5Vgkkhc1jEW6uN7ObvRmFXIqsVBq8ido+/zSSETU5AUkfFj4ikMGzF
	 Scn5vUsHQgLEl3DyQV0zjgDtMfORk3EqCyk6V6bvvokd4VTr8owt947jT+DUdFWS7U
	 RjOszniO4dd6h3l/283gCMpp6bTQWr6pKOWRtlmFhWyCbra5LPPp4c5NkfbhXcYlR3
	 jYKareHpGKg8GLI+YzYVDdSEXDixAbv5Rhrsu8paqJXXgng158WGOsennbHxIOYMut
	 aGfYTsw5gQf1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE7BE80DFF;
	Fri, 17 Apr 2026 14:59:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 526D4396
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Apr 2026 14:59:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 43D0460E00
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Apr 2026 14:59:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DcVAfNXLDXHZ for <intel-wired-lan@lists.osuosl.org>;
 Fri, 17 Apr 2026 14:59:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2830460DFF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2830460DFF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2830460DFF
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Apr 2026 14:59:45 +0000 (UTC)
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-ewrOrWXhNW-TpdYCXsSPuA-1; Fri,
 17 Apr 2026 10:59:38 -0400
X-MC-Unique: ewrOrWXhNW-TpdYCXsSPuA-1
X-Mimecast-MFC-AGG-ID: ewrOrWXhNW-TpdYCXsSPuA_1776437975
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C187119560B1; Fri, 17 Apr 2026 14:59:34 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.76])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F13E3000C1E; Fri, 17 Apr 2026 14:59:29 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Date: Fri, 17 Apr 2026 16:59:07 +0200
Message-ID: <20260417145907.696307-4-poros@redhat.com>
In-Reply-To: <20260417145907.696307-1-poros@redhat.com>
References: <20260417145907.696307-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: t0fTB0h0mmPAcCe_0kBFCB-wRm5PRMEOQT0H1iJPJmg_1776437975
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1776437985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gbpFvcWrWZxCHOudUuz8MQpAoKeJ9RTgsaIS867Lomg=;
 b=Nwhj2PQhcjEQlc0U5GIWsZriE1tQaNqxbkwvdPVcFtzsoW2sr8QdAg6HxXQ0uC5HQyUdjV
 fWPLp504+Vj4pjfO/y6LXJ6kReONOaEWJ39clr5QABK5LLOuvy4aFptUYfgsE+U+YXHReg
 g9sd4BKxpxoDIAyrHoFf+UkExA42mnI=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nwhj2PQh
Subject: [Intel-wired-lan] [PATCH iwl-net v7 3/3] ice: add dpll peer
 notification for paired SMA and U.FL pins
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
Cc: Ivan Vecera <ivecera@redhat.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jiri Pirko <jiri@resnulli.us>,
 Rinitha S <sx.rinitha@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Eric Dumazet <edumazet@google.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Simon Horman <horms@kernel.org>, intel-wired-lan@lists.osuosl.org,
 Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

SMA and U.FL pins share physical signal paths in pairs (SMA1/U.FL1 and
SMA2/U.FL2).  When one pin's state changes via a PCA9575 GPIO write,
the paired pin's state also changes, but no notification is sent for
the peer pin.  Userspace consumers monitoring the peer via dpll netlink
subscribe never learn about the update.

Add ice_dpll_sw_pin_notify_peer() which sends a change notification for
the paired SW pin.  Call it from ice_dpll_pin_sma_direction_set(),
ice_dpll_sma_pin_state_set(), and ice_dpll_ufl_pin_state_set() after
pf->dplls.lock is released.  Use __dpll_pin_change_ntf() because
dpll_lock is still held by the dpll netlink layer (dpll_pin_pre_doit).

Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 32 +++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 11b942b83500fb..be72a076f7a15c 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -1154,6 +1154,32 @@ ice_dpll_input_state_get(const struct dpll_pin *pin, void *pin_priv,
 				      extack, ICE_DPLL_PIN_TYPE_INPUT);
 }
 
+/**
+ * ice_dpll_sw_pin_notify_peer - notify the paired SW pin after a state change
+ * @d: pointer to dplls struct
+ * @changed: the SW pin that was explicitly changed (already notified by dpll core)
+ *
+ * SMA and U.FL pins share physical signal paths in pairs (SMA1/U.FL1 and
+ * SMA2/U.FL2).  When one pin's routing changes via the PCA9575 GPIO
+ * expander, the paired pin's state may also change.  Send a change
+ * notification for the peer pin so userspace consumers monitoring the
+ * peer via dpll netlink learn about the update.
+ *
+ * Context: Called from dpll_pin_ops callbacks after pf->dplls.lock is
+ *          released.  Uses __dpll_pin_change_ntf() because dpll_lock is
+ *          still held by the dpll netlink layer.
+ */
+static void ice_dpll_sw_pin_notify_peer(struct ice_dplls *d,
+					struct ice_dpll_pin *changed)
+{
+	struct ice_dpll_pin *peer;
+
+	peer = (changed >= d->sma && changed < d->sma + ICE_DPLL_PIN_SW_NUM) ?
+		&d->ufl[changed->idx] : &d->sma[changed->idx];
+	if (peer->pin)
+		__dpll_pin_change_ntf(peer->pin);
+}
+
 /**
  * ice_dpll_sma_direction_set - set direction of SMA pin
  * @p: pointer to a pin
@@ -1344,6 +1370,8 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 
 unlock:
 	mutex_unlock(&pf->dplls.lock);
+	if (!ret)
+		ice_dpll_sw_pin_notify_peer(&pf->dplls, p);
 
 	return ret;
 }
@@ -1462,6 +1490,8 @@ ice_dpll_sma_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 
 unlock:
 	mutex_unlock(&pf->dplls.lock);
+	if (!ret)
+		ice_dpll_sw_pin_notify_peer(&pf->dplls, sma);
 
 	return ret;
 }
@@ -1657,6 +1687,8 @@ ice_dpll_pin_sma_direction_set(const struct dpll_pin *pin, void *pin_priv,
 	mutex_lock(&pf->dplls.lock);
 	ret = ice_dpll_sma_direction_set(p, direction, extack);
 	mutex_unlock(&pf->dplls.lock);
+	if (!ret)
+		ice_dpll_sw_pin_notify_peer(&pf->dplls, p);
 
 	return ret;
 }
-- 
2.52.0

