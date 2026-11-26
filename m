Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08535606A337
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 20:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ZKKYnUnZ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MPwcb+MB
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD6B260A68;
	Thu, 26 Nov 2026 20:34:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aJ0WaPmM-zdG; Thu, 26 Nov 2026 20:34:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 31DA260A8F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795725293;
	b=iXdY+yzq3ZGqcdCcSz6hrn+ZULFO/+O6A9kn+3ZsAMcyM2gwv93HQk7nMiZkH8wQ11of
	 oSMd1bh+C2amGplMMslHCFvfpmwK+TncPK81t8lwfyys0XiTs5aAwxl4GnzNBSRaZzHzr
	 2izaQyX+IKY3VCl8+wHvR7PPiY4pz+VMV+4wM/ajZTYLW4f2b8LyP/o+nPu4vbxpQrLty
	 l8Pxue8X+MOVRZfQcpkOjbFrNV9rUv4veuRj6LBBLMB9BHP+ln8BtePE3TEnPpv48KU3T
	 X8yfNWBJXRgVw1Adxyf1SMUdJDYMe9jjfuNo9KyR6yO7dK0KAzY63aomEFpmoMdj8iQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795725293;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XCoP2lR9dWoXQubbwuHi5uO9EefUEvGruaOQqElQJIQ=;
	b=Otxm/wsqPFZZUekI1+eH6KfEgnNbkJaC5y4cAQ/nyudmDu0D05BvAsGux/ex9wBviJKK
	 T3KYYw+LpoPQHerLsd8uPnJz2xBJUAZNNHWYt4RSdbqjEUpata9t2BFjKuVFax1hJPQ2b
	 kKvH3ODy+RtzO6qVPjIt9mqgMGIyk+Dz8uHms591Fhnf+7dcZ9d7UDwOgRnzwdYdYJbjc
	 nNmZ8JGa24tUKFT6jc3wNVmPuS2TIrn0FnwukQKk/ZDbYqbkRB62dVUSv41BrZTcacdYf
	 7+YFpDGvePTE5ydiufGbKDmEy3a4sCmhmu0UqwyQDvht89fe2naQSwO+i2LGD2V9xyQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795725293;
	bh=XCoP2lR9dWoXQubbwuHi5uO9EefUEvGruaOQqElQJIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZKKYnUnZtcNI0n/UERejzog0hv/VaeoLsjRxuGu/HjnTHrkHoFwSwbX7O2nbML0N4
	 M+x+vbbqam3OxRa0DemMdGKBcs4EsV5+E84AAZ6ARAjpnnUSyTkfz4fUz9Z4vP8Y8P
	 SODi5lYYhfhj5Jto1NvSyeD5ZmJrQM164fR1R2IFKOJU1fcidK4SD9GQ3UCadJtBWK
	 XkWSP5YKTgUGV9EZ7E66BAzGeBoW9jCy+TlVk2DGWMa7Nd6HDMYWMEb9fdfGLQu8qD
	 PGYkRXCp/rqzMWxRqpqZ6yThel0oR01xNtQmLVdzaRx6BrY8WD9PaVNW+TXnmhYFz/
	 yfdVW4AvFgTcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31DA260A8F;
	Thu, 26 Nov 2026 20:34:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id ECD141AB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:34:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D34294054A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:34:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0ozOJJf3-FVy for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 20:34:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E6855400CB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MPwcb+MB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E6855400CB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795725289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XCoP2lR9dWoXQubbwuHi5uO9EefUEvGruaOQqElQJIQ=;
 b=MPwcb+MBrTck17mipHFRzmxfIExsulHdIIR62CaaoQWryZPt1E93A3T5WaQ9sww1a9xEHI
 Zy2bz7Rmq0k0oN8Jrmq5C4b1Z1nVJ5P8sHFFGVFOp+bUcZcBQrpnFg6ZzHMeXAL9qVVN0W
 v6RNoT7mdqHVvNP4IsmvQPep5zWVKPc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-ztZ9ANb3NOyqu-W7-jAr4g-1; Thu,
 26 Nov 2026 20:34:45 +0000
X-MC-Unique: ztZ9ANb3NOyqu-W7-jAr4g-1
X-Mimecast-MFC-AGG-ID: ztZ9ANb3NOyqu-W7-jAr4g_1795725282
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 345001800471; Thu, 26 Nov 2026 20:34:42 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 19AAF1801977; Thu, 26 Nov 2026 20:34:35 +0000 (UTC)
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
Subject: [PATCH RFC net-next 18/19] dpll: drop the owner reference selection
 of pins
Date: Thu, 26 Nov 2026 21:32:30 +0100
Message-ID: <20261126203231.934632-19-ivecera@redhat.com>
In-Reply-To: <20261126203231.934632-1-ivecera@redhat.com>
References: <20261126203231.934632-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 1JRODsN4mmmTrNkY2eVCNrwa2FcjYpjNtczRhMMzSEI_1795725282
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

Commit 2c1bd78dc8e2 ("dpll: use pin owner's dpll ref for pin-level
attribute reporting") and commit 84e85c325e5e ("dpll: use pin owner's
dpll ref for pin-level attribute setting") made the pin-level paths look
for the reference of a DPLL of the pin's owner, because a pin could also
be registered with DPLLs of other owners.

Every DPLL a pin is registered with now has the owner of the pin. Use
the first reference of a registered DPLL and drop
dpll_pin_own_dpll_ref_first().

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_core.c    | 27 ---------------------------
 drivers/dpll/dpll_core.h    |  1 -
 drivers/dpll/dpll_netlink.c | 20 +++++++++-----------
 3 files changed, 9 insertions(+), 39 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index af61c4882c2b6f..a58cd22164f0be 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -1229,33 +1229,6 @@ void *dpll_pin_on_pin_priv(struct dpll_pin *parent,
 	return reg->priv;
 }
 
-/**
- * dpll_pin_own_dpll_ref_first - find the first owner dpll ref of a pin
- * @pin: pointer to a dpll pin
- *
- * Search pin's dpll_refs for a ref whose dpll matches the pin's
- * (module, clock_id) tuple, i.e. the dpll registered by the driver
- * that created the pin. This ensures pin-level attributes are
- * reported and modified using the owner's ops even when the pin is
- * also registered with dplls from other drivers.
- *
- * Return: pointer to the owner's dpll_pin_ref, or NULL if no
- * owner ref is found.
- */
-struct dpll_pin_ref *dpll_pin_own_dpll_ref_first(struct dpll_pin *pin)
-{
-	struct dpll_pin_ref *ref;
-	unsigned long i;
-
-	xa_for_each(&pin->dpll_refs, i, ref) {
-		if (ref->dpll->module == pin->module &&
-		    ref->dpll->clock_id == pin->clock_id)
-			return ref;
-	}
-
-	return NULL;
-}
-
 const struct dpll_pin_ops *dpll_pin_ops(struct dpll_pin_ref *ref)
 {
 	struct dpll_pin_registration *reg;
diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
index 6e10aadd2123d9..add518fef295d8 100644
--- a/drivers/dpll/dpll_core.h
+++ b/drivers/dpll/dpll_core.h
@@ -103,7 +103,6 @@ void *dpll_pin_on_pin_priv(struct dpll_pin *parent, struct dpll_pin *pin);
 
 const struct dpll_device_ops *dpll_device_ops(struct dpll_device *dpll);
 struct dpll_device *dpll_device_get_by_id(int id);
-struct dpll_pin_ref *dpll_pin_own_dpll_ref_first(struct dpll_pin *pin);
 const struct dpll_pin_ops *dpll_pin_ops(struct dpll_pin_ref *ref);
 struct dpll_pin_ref *dpll_xa_ref_dpll_first(struct xarray *xa_refs);
 bool dpll_pins_linked(const struct dpll_pin *a, const struct dpll_pin *b);
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 6a46130fc687eb..ac341e3eba61ac 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -745,9 +745,7 @@ dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
 	struct dpll_pin_ref *ref;
 	int ret;
 
-	ref = dpll_pin_own_dpll_ref_first(pin);
-	if (!ref || !dpll_device_registered(ref->dpll))
-		ref = dpll_pin_first_registered_ref(pin);
+	ref = dpll_pin_first_registered_ref(pin);
 	if (!ref)
 		return -ENODEV;
 
@@ -1134,8 +1132,8 @@ dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
 		return -EINVAL;
 	}
 
-	ref = dpll_pin_own_dpll_ref_first(pin);
-	if (!ref || !dpll_device_registered(ref->dpll)) {
+	ref = dpll_pin_first_registered_ref(pin);
+	if (!ref) {
 		NL_SET_ERR_MSG(extack, "pin owner dpll not found");
 		return -ENODEV;
 	}
@@ -1180,8 +1178,8 @@ dpll_pin_esync_set(struct dpll_pin *pin, struct nlattr *a,
 	bool supported = false;
 	int ret, i;
 
-	ref = dpll_pin_own_dpll_ref_first(pin);
-	if (!ref || !dpll_device_registered(ref->dpll)) {
+	ref = dpll_pin_first_registered_ref(pin);
+	if (!ref) {
 		NL_SET_ERR_MSG(extack, "pin owner dpll not found");
 		return -ENODEV;
 	}
@@ -1245,8 +1243,8 @@ dpll_pin_ref_sync_state_set(struct dpll_pin *pin,
 		NL_SET_ERR_MSG(extack, "reference sync pin not available");
 		return -EINVAL;
 	}
-	ref = dpll_pin_own_dpll_ref_first(pin);
-	if (!ref || !dpll_device_registered(ref->dpll)) {
+	ref = dpll_pin_first_registered_ref(pin);
+	if (!ref) {
 		NL_SET_ERR_MSG(extack, "pin owner dpll not found");
 		return -ENODEV;
 	}
@@ -1458,8 +1456,8 @@ dpll_pin_phase_adj_set(struct dpll_pin *pin, struct nlattr *phase_adj_attr,
 		return -EINVAL;
 	}
 
-	ref = dpll_pin_own_dpll_ref_first(pin);
-	if (!ref || !dpll_device_registered(ref->dpll)) {
+	ref = dpll_pin_first_registered_ref(pin);
+	if (!ref) {
 		NL_SET_ERR_MSG(extack, "pin owner dpll not found");
 		return -ENODEV;
 	}
-- 
2.56.1

