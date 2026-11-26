Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A8F606A323
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 20:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=6UMBaNnQ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mh/UemT9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 47CA260A68;
	Thu, 26 Nov 2026 20:32:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id orI0ySyXJvSJ; Thu, 26 Nov 2026 20:32:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6B08A60AE4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795725177;
	b=cqAMRUHItXh+sOXoZztGXqZHj8CGdu6Qz6s7Pw0m7BcGJugMWNiJb+GquDKrNAEgmJUJ
	 AnSddggKSwjReEYQNWzZtmk/3vVFA6tbryyQUNfp5no13F8eO5ppK3aqnU70CHUk+UlSK
	 Hj4i6wwdhBtNswHl83NUhs1i9Gjv9EetGcd5sthHgL+onqPbPP0r6HHCzgFuezzQ4sMHl
	 NHu3xTPXH4poQAjq3zK5ARrF2/8MqaO49wVcVJ/vtg2pBuA8y1wrWoT7G8bAvjTt5nn7n
	 dN9XgNtfOyI8EkVDEshNu3dZ7Rqj/KJ629E6m54ZsFl9cZcdvTDRhBYkpIgugewdcsA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795725177;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-MC-Rep:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NIxE4m8l1izRwK6ahSUGuo2vdx0Q2NKrDP6SB3rfqu0=;
	b=iZI+OtilMzqBr50Za+S6KwVMiHSJnaEVlR3oMXWL6SBk+aKbHNgP2VeozIHhniTS8Dho
	 sFW5/nSK4y5fJI1d/GFhcdt1+X4NcSXT99AaBsjsDhRd9qM9dVMMX9AxkPaNUBQU60HQT
	 WJJFRQsvugs7Fo6rBk7xWhMlhhvG4l/4L7eIj5O7F6YdKsUzcP0l1KEtxlbJZMK51loJk
	 8eWN0KXYhm65dAp687DKXtiKoqLo+RQcmFnytA/1IjEbai+uRlOFWR42NBSj9TeubTz7G
	 hRsL8Ei9/Pt3CQ+0zl4VsyHH62PGmFDiEZ70JnV7NusEOx4YW18dQFb1Y1q4W1YoCtA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Mh/UemT9";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795725177;
	bh=NIxE4m8l1izRwK6ahSUGuo2vdx0Q2NKrDP6SB3rfqu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6UMBaNnQgYgbyaPVpKqsVDoBxbt02vNwd1U5t5v7cB6G32EnWfjxbV6x+q0KXTAZq
	 KXYv3sLcdOgqpVOhdaeHZxv59QioPVHnRTCLpkFXwCHOOdE5L7UABh9qIs4bYdYtaH
	 8sYuISY9IGBtgjrtPdUOh9Mi2LS83ot5pHORqi6XL6z2HDVvoNj7nNC9bliUsapxyY
	 6AAbGXWQODBAfwVsG3+pDxX9NjoJo8ODX4OLqDc9j+nx9HTciTdTn/DonqiyV89gW3
	 F3xB0dIxlCFaHi3JPWaN0+C9/vyFWOwsKskSbnlC5wzGsxNOTStW1aUNP5RVRNAVrk
	 RdgW95GK9uHdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B08A60AE4;
	Thu, 26 Nov 2026 20:32:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 509E51AB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:32:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 36BB960AE4
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:32:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Azq9KHI_NEg6 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 20:32:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0DEB860A68
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Mh/UemT9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0DEB860A68
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795725175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NIxE4m8l1izRwK6ahSUGuo2vdx0Q2NKrDP6SB3rfqu0=;
 b=Mh/UemT9CFh0E5diKxznJBklmJrtJmr28nn9fqal1AqpfP6Z7htDjUjv6fTx59GthaQ1jF
 MQdi0vBPH06DVfesjhbsA3VJjFnY3H7cg4FcAgKkOM73zyPOzvl8NRziD0dYBuONjE78n0
 Ls07P374I4Tv0DM/VZXzDZU8niooEoQ=
X-MC-Rep: binary re single
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-wPBfipf-POCTfNY6iEcjow-1; Thu,
 26 Nov 2026 20:32:50 +0000
X-MC-Unique: wPBfipf-POCTfNY6iEcjow-1
X-Mimecast-MFC-AGG-ID: wPBfipf-POCTfNY6iEcjow_1795725168
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D032180057E; Thu, 26 Nov 2026 20:32:47 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DD006180197A; Thu, 26 Nov 2026 20:32:40 +0000 (UTC)
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
Subject: [PATCH RFC net-next 01/19] dpll: add pin links
Date: Thu, 26 Nov 2026 21:32:13 +0100
Message-ID: <20261126203231.934632-2-ivecera@redhat.com>
In-Reply-To: <20261126203231.934632-1-ivecera@redhat.com>
References: <20261126203231.934632-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: V6rf1ICC5-DSdFDcweWvWwLoFx1jDS0gi8Idk3lcnxM_1795725168
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

A pin is a pad of the chip whose driver registers it. When a board wires
a pad of one chip to a pad of another, for example an output of an
external DPLL to the TX reference input of a network controller, a
driver now registers the pin of the other driver with its own DPLL. The
pin then has two owners and a request about it runs callbacks of both
drivers.

Add a link that describes such a wire instead. A driver adds it to its
own pin with dpll_pin_link_add() and names the pin at the other end by
its firmware node, which the driver of that pin sets with
dpll_pin_fwnode_set(). The link holds only the firmware node, so the
driver needs no pointer to a pin of another driver and that pin does not
have to exist yet.

Links are added before the pin is registered and are released together
with the pin. Adding an existing link returns -EEXIST, also on a
registered pin, so each user of a shared pin can add the same link. The
next patch reports links to user space.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_core.c | 71 ++++++++++++++++++++++++++++++++++++++++
 drivers/dpll/dpll_core.h | 12 +++++++
 include/linux/dpll.h     |  2 ++
 3 files changed, 85 insertions(+)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 277692d12d3d1e..4d871542ddf762 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -147,6 +147,16 @@ static void __dpll_pin_hold(struct dpll_pin *pin, dpll_tracker *tracker)
 static void dpll_pin_idx_free(u32 pin_idx);
 static void dpll_pin_prop_free(struct dpll_pin_properties *prop);
 
+static void dpll_pin_links_free(struct dpll_pin *pin)
+{
+	struct dpll_pin_link *link, *tmp;
+
+	list_for_each_entry_safe(link, tmp, &pin->links, list) {
+		fwnode_handle_put(link->peer);
+		kfree(link);
+	}
+}
+
 static void __dpll_pin_put(struct dpll_pin *pin, dpll_tracker *tracker)
 {
 	dpll_pin_tracker_free(pin, tracker);
@@ -155,6 +165,7 @@ static void __dpll_pin_put(struct dpll_pin *pin, dpll_tracker *tracker)
 		xa_destroy(&pin->dpll_refs);
 		xa_destroy(&pin->parent_refs);
 		xa_destroy(&pin->ref_sync_pins);
+		dpll_pin_links_free(pin);
 		dpll_pin_prop_free(&pin->prop);
 		fwnode_handle_put(pin->fwnode);
 		dpll_pin_idx_free(pin->pin_idx);
@@ -665,6 +676,7 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
 	if (ret)
 		goto err_pin_prop;
 	refcount_set(&pin->refcount, 1);
+	INIT_LIST_HEAD(&pin->links);
 	xa_init_flags(&pin->dpll_refs, XA_FLAGS_ALLOC);
 	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);
 	xa_init_flags(&pin->ref_sync_pins, XA_FLAGS_ALLOC);
@@ -838,6 +850,65 @@ struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(fwnode_dpll_pin_find);
 
+static bool dpll_pin_has_link(const struct dpll_pin *pin,
+			      const struct fwnode_handle *peer)
+{
+	struct dpll_pin_link *link;
+
+	list_for_each_entry(link, &pin->links, list)
+		if (link->peer == peer)
+			return true;
+
+	return false;
+}
+
+/**
+ * dpll_pin_link_add - add a link from a pin to another pin
+ * @pin: pointer to a dpll pin
+ * @peer: firmware node of the pin at the other end
+ *
+ * Describe a fixed board connection between @pin and the pin of another
+ * device that its driver associates with @peer by dpll_pin_fwnode_set().
+ * The other pin does not need to exist yet. The link is kept until @pin is
+ * released. An existing link is reported also when @pin is registered, so
+ * each user of a shared pin can add the same link.
+ *
+ * Context: Acquires a lock (dpll_lock). Must be called before @pin is
+ *	    registered.
+ * Return:
+ * * 0 on success
+ * * -EEXIST if @pin already has a link to @peer
+ * * -EBUSY if @pin is already registered
+ * * -ENOMEM if the link cannot be allocated
+ */
+int dpll_pin_link_add(struct dpll_pin *pin, struct fwnode_handle *peer)
+{
+	struct dpll_pin_link *link;
+	int ret = 0;
+
+	mutex_lock(&dpll_lock);
+	if (dpll_pin_has_link(pin, peer)) {
+		ret = -EEXIST;
+		goto unlock;
+	}
+	if (WARN_ON(xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED))) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+	link = kzalloc_obj(*link);
+	if (!link) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+	link->peer = fwnode_handle_get(peer);
+	list_add_tail(&link->list, &pin->links);
+unlock:
+	mutex_unlock(&dpll_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dpll_pin_link_add);
+
 static int
 __dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 		    const struct dpll_pin_ops *ops, void *priv, void *cookie)
diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
index da8a369556ed11..26a16df2b6410d 100644
--- a/drivers/dpll/dpll_core.h
+++ b/drivers/dpll/dpll_core.h
@@ -47,6 +47,7 @@ struct dpll_device {
  * @module:		module of creator
  * @module_name:	module name of creator
  * @fwnode:		optional reference to firmware node
+ * @links:		links to other pins (struct dpll_pin_link)
  * @dpll_refs:		hold referencees to dplls pin was registered with
  * @parent_refs:	hold references to parent pins pin was registered with
  * @ref_sync_pins:	hold references to pins for Reference SYNC feature
@@ -62,6 +63,7 @@ struct dpll_pin {
 	struct module *module;
 	char module_name[MODULE_NAME_LEN];
 	struct fwnode_handle *fwnode;
+	struct list_head links;
 	struct xarray dpll_refs;
 	struct xarray parent_refs;
 	struct xarray ref_sync_pins;
@@ -71,6 +73,16 @@ struct dpll_pin {
 	struct rcu_head rcu;
 };
 
+/**
+ * struct dpll_pin_link - wire between a pin and another pin
+ * @list:		entry in the links list of the pin
+ * @peer:		firmware node of the pin at the other end
+ **/
+struct dpll_pin_link {
+	struct list_head list;
+	struct fwnode_handle *peer;
+};
+
 /**
  * struct dpll_pin_ref - structure for referencing either dpll or pins
  * @dpll:		pointer to a dpll
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index 7a6f8796cda2ad..e252d3c6b4334a 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -301,6 +301,8 @@ void dpll_pin_put(struct dpll_pin *pin, dpll_tracker *tracker);
 
 void dpll_pin_fwnode_set(struct dpll_pin *pin, struct fwnode_handle *fwnode);
 
+int dpll_pin_link_add(struct dpll_pin *pin, struct fwnode_handle *peer);
+
 int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 			     const struct dpll_pin_ops *ops, void *priv);
 
-- 
2.56.1

