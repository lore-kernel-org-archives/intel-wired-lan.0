Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78275E6BF2A
	for <intel-wired-lan@archiver.kernel.org>; Fri, 30 Jan 2026 16:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4962740D31;
	Fri, 30 Jan 2026 16:54:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pv_3Dx--QF5o; Fri, 30 Jan 2026 16:54:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AAD3E40DB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769792072;
	bh=uTBTj4DoaFmkqsXx1XgP6uN+/m2jHUuaY9pESwmHTHk=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iwBEHM6g8vBBe7kYtQ4lnkzlIMdTKCXVhcR60ZtBsYRBzWnZIt5xXDwKEcoEO7l7+
	 ynsL9nZIks39xmjjg0b1qB4U9dQi8AoZDLS6OWbsw4fey/p0zjoynqkFeeYiy96vcq
	 QK5TUJ+5kBDhpaunl/N2lYnTYgQzg1L6fCuu5pKXAuBGUEsQYv+114EsV67FNjof1d
	 +ty1Bygc/Cj7nShk6x5SkAglEme7sUKKsLLHs50wG45piAhoEvcIq7jPo2mTU1ekxC
	 KfsZmtgqx0w1SUeaSRGY0GP4AgFAUtldFprFOYZsk1f5lcD8TCzMZijgMowKQcUZP4
	 6s4aWlapBH8sw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AAD3E40DB5;
	Fri, 30 Jan 2026 16:54:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 76B1D69
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Jan 2026 16:54:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5A77680E7B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Jan 2026 16:54:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F4NViLM6SgHU for <intel-wired-lan@lists.osuosl.org>;
 Fri, 30 Jan 2026 16:54:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 474C180E20
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 474C180E20
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 474C180E20
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Jan 2026 16:54:29 +0000 (UTC)
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-TDGkagajNgixYmPMPWSmgQ-1; Fri,
 30 Jan 2026 11:54:27 -0500
X-MC-Unique: TDGkagajNgixYmPMPWSmgQ-1
X-Mimecast-MFC-AGG-ID: TDGkagajNgixYmPMPWSmgQ_1769792064
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6236F180035D; Fri, 30 Jan 2026 16:54:24 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.226.27])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A9EBF18009BC; Fri, 30 Jan 2026 16:54:18 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
Date: Fri, 30 Jan 2026 17:53:35 +0100
Message-ID: <20260130165338.101860-7-ivecera@redhat.com>
In-Reply-To: <20260130165338.101860-1-ivecera@redhat.com>
References: <20260130165338.101860-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1769792068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uTBTj4DoaFmkqsXx1XgP6uN+/m2jHUuaY9pESwmHTHk=;
 b=KV9GREhXHlKKzP4WHv122Mj6F6rr/ACcazI1ehFxZ0X1+47mbFofQhRp6Vj9JR+TTyohfe
 kMdOpNzaTRSS6AARibb+Z+W9f0NxfOi12pzYTxULGYl7nRNIBLZ+eab7kAID5T8HRrEiN2
 4WHdCRwhChyZ6UicTg0ATPZZ7XVKEeU=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KV9GREhX
Subject: [Intel-wired-lan] [PATCH net-next v3 6/9] dpll: Enhance and
 consolidate reference counting logic
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
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Refactor the reference counting mechanism for DPLL devices and pins to
improve consistency and prevent potential lifetime issues.

Introduce internal helpers __dpll_{device,pin}_{hold,put}() to
centralize reference management.

Update the internal XArray reference helpers (dpll_xa_ref_*) to
automatically grab a reference to the target object when it is added to
a list, and release it when removed. This ensures that objects linked
internally (e.g., pins referenced by parent pins) are properly kept
alive without relying on the caller to manually manage the count.

Consequently, remove the now redundant manual `refcount_inc/dec` calls
in dpll_pin_on_pin_{,un}register()`, as ownership is now correctly handled
by the dpll_xa_ref_* functions.

Additionally, ensure that dpll_device_{,un}register()` takes/releases
a reference to the device, ensuring the device object remains valid for
the duration of its registration.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_core.c | 74 +++++++++++++++++++++++++++-------------
 1 file changed, 50 insertions(+), 24 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index b91f4dc6bb972..33333bc2f0cc8 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -83,6 +83,45 @@ void dpll_pin_notify(struct dpll_pin *pin, unsigned long action)
 	call_dpll_notifiers(action, &info);
 }
 
+static void __dpll_device_hold(struct dpll_device *dpll)
+{
+	refcount_inc(&dpll->refcount);
+}
+
+static void __dpll_device_put(struct dpll_device *dpll)
+{
+	if (refcount_dec_and_test(&dpll->refcount)) {
+		ASSERT_DPLL_NOT_REGISTERED(dpll);
+		WARN_ON_ONCE(!xa_empty(&dpll->pin_refs));
+		xa_destroy(&dpll->pin_refs);
+		xa_erase(&dpll_device_xa, dpll->id);
+		WARN_ON(!list_empty(&dpll->registration_list));
+		kfree(dpll);
+	}
+}
+
+static void __dpll_pin_hold(struct dpll_pin *pin)
+{
+	refcount_inc(&pin->refcount);
+}
+
+static void dpll_pin_idx_free(u32 pin_idx);
+static void dpll_pin_prop_free(struct dpll_pin_properties *prop);
+
+static void __dpll_pin_put(struct dpll_pin *pin)
+{
+	if (refcount_dec_and_test(&pin->refcount)) {
+		xa_erase(&dpll_pin_xa, pin->id);
+		xa_destroy(&pin->dpll_refs);
+		xa_destroy(&pin->parent_refs);
+		xa_destroy(&pin->ref_sync_pins);
+		dpll_pin_prop_free(&pin->prop);
+		fwnode_handle_put(pin->fwnode);
+		dpll_pin_idx_free(pin->pin_idx);
+		kfree_rcu(pin, rcu);
+	}
+}
+
 struct dpll_device *dpll_device_get_by_id(int id)
 {
 	if (xa_get_mark(&dpll_device_xa, id, DPLL_REGISTERED))
@@ -152,6 +191,7 @@ dpll_xa_ref_pin_add(struct xarray *xa_pins, struct dpll_pin *pin,
 	reg->ops = ops;
 	reg->priv = priv;
 	reg->cookie = cookie;
+	__dpll_pin_hold(pin);
 	if (ref_exists)
 		refcount_inc(&ref->refcount);
 	list_add_tail(&reg->list, &ref->registration_list);
@@ -174,6 +214,7 @@ static int dpll_xa_ref_pin_del(struct xarray *xa_pins, struct dpll_pin *pin,
 		if (WARN_ON(!reg))
 			return -EINVAL;
 		list_del(&reg->list);
+		__dpll_pin_put(pin);
 		kfree(reg);
 		if (refcount_dec_and_test(&ref->refcount)) {
 			xa_erase(xa_pins, i);
@@ -231,6 +272,7 @@ dpll_xa_ref_dpll_add(struct xarray *xa_dplls, struct dpll_device *dpll,
 	reg->ops = ops;
 	reg->priv = priv;
 	reg->cookie = cookie;
+	__dpll_device_hold(dpll);
 	if (ref_exists)
 		refcount_inc(&ref->refcount);
 	list_add_tail(&reg->list, &ref->registration_list);
@@ -253,6 +295,7 @@ dpll_xa_ref_dpll_del(struct xarray *xa_dplls, struct dpll_device *dpll,
 		if (WARN_ON(!reg))
 			return;
 		list_del(&reg->list);
+		__dpll_device_put(dpll);
 		kfree(reg);
 		if (refcount_dec_and_test(&ref->refcount)) {
 			xa_erase(xa_dplls, i);
@@ -323,8 +366,8 @@ dpll_device_get(u64 clock_id, u32 device_idx, struct module *module)
 		if (dpll->clock_id == clock_id &&
 		    dpll->device_idx == device_idx &&
 		    dpll->module == module) {
+			__dpll_device_hold(dpll);
 			ret = dpll;
-			refcount_inc(&ret->refcount);
 			break;
 		}
 	}
@@ -347,14 +390,7 @@ EXPORT_SYMBOL_GPL(dpll_device_get);
 void dpll_device_put(struct dpll_device *dpll)
 {
 	mutex_lock(&dpll_lock);
-	if (refcount_dec_and_test(&dpll->refcount)) {
-		ASSERT_DPLL_NOT_REGISTERED(dpll);
-		WARN_ON_ONCE(!xa_empty(&dpll->pin_refs));
-		xa_destroy(&dpll->pin_refs);
-		xa_erase(&dpll_device_xa, dpll->id);
-		WARN_ON(!list_empty(&dpll->registration_list));
-		kfree(dpll);
-	}
+	__dpll_device_put(dpll);
 	mutex_unlock(&dpll_lock);
 }
 EXPORT_SYMBOL_GPL(dpll_device_put);
@@ -416,6 +452,7 @@ int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
 	reg->ops = ops;
 	reg->priv = priv;
 	dpll->type = type;
+	__dpll_device_hold(dpll);
 	first_registration = list_empty(&dpll->registration_list);
 	list_add_tail(&reg->list, &dpll->registration_list);
 	if (!first_registration) {
@@ -455,6 +492,7 @@ void dpll_device_unregister(struct dpll_device *dpll,
 		return;
 	}
 	list_del(&reg->list);
+	__dpll_device_put(dpll);
 	kfree(reg);
 
 	if (!list_empty(&dpll->registration_list)) {
@@ -666,8 +704,8 @@ dpll_pin_get(u64 clock_id, u32 pin_idx, struct module *module,
 		if (pos->clock_id == clock_id &&
 		    pos->pin_idx == pin_idx &&
 		    pos->module == module) {
+			__dpll_pin_hold(pos);
 			ret = pos;
-			refcount_inc(&ret->refcount);
 			break;
 		}
 	}
@@ -690,16 +728,7 @@ EXPORT_SYMBOL_GPL(dpll_pin_get);
 void dpll_pin_put(struct dpll_pin *pin)
 {
 	mutex_lock(&dpll_lock);
-	if (refcount_dec_and_test(&pin->refcount)) {
-		xa_erase(&dpll_pin_xa, pin->id);
-		xa_destroy(&pin->dpll_refs);
-		xa_destroy(&pin->parent_refs);
-		xa_destroy(&pin->ref_sync_pins);
-		dpll_pin_prop_free(&pin->prop);
-		fwnode_handle_put(pin->fwnode);
-		dpll_pin_idx_free(pin->pin_idx);
-		kfree_rcu(pin, rcu);
-	}
+	__dpll_pin_put(pin);
 	mutex_unlock(&dpll_lock);
 }
 EXPORT_SYMBOL_GPL(dpll_pin_put);
@@ -740,8 +769,8 @@ struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode)
 	mutex_lock(&dpll_lock);
 	xa_for_each(&dpll_pin_xa, index, pin) {
 		if (pin->fwnode == fwnode) {
+			__dpll_pin_hold(pin);
 			ret = pin;
-			refcount_inc(&ret->refcount);
 			break;
 		}
 	}
@@ -893,7 +922,6 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 	ret = dpll_xa_ref_pin_add(&pin->parent_refs, parent, ops, priv, pin);
 	if (ret)
 		goto unlock;
-	refcount_inc(&pin->refcount);
 	xa_for_each(&parent->dpll_refs, i, ref) {
 		ret = __dpll_pin_register(ref->dpll, pin, ops, priv, parent);
 		if (ret) {
@@ -913,7 +941,6 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 					      parent);
 			dpll_pin_delete_ntf(pin);
 		}
-	refcount_dec(&pin->refcount);
 	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
 unlock:
 	mutex_unlock(&dpll_lock);
@@ -940,7 +967,6 @@ void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin *pin,
 	mutex_lock(&dpll_lock);
 	dpll_pin_delete_ntf(pin);
 	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
-	refcount_dec(&pin->refcount);
 	xa_for_each(&pin->dpll_refs, i, ref)
 		__dpll_pin_unregister(ref->dpll, pin, ops, priv, parent);
 	mutex_unlock(&dpll_lock);
-- 
2.52.0

