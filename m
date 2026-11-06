Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4C3606D82E
	for <intel-wired-lan@archiver.kernel.org>; Fri,  6 Nov 2026 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=8PeGgrvx;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HqM0R/yc
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62E7E40934;
	Fri,  6 Nov 2026 12:10:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jlUGeo0ExuiM; Fri,  6 Nov 2026 12:10:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 865FA40993
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793967045;
	b=B66AqAny0ypfKME+XCNcolFg5eyjBasqaJHkbb9hUCQFhpfzuD28KD9bzoBiFN7jyMIA
	 Se9wdeMQOMI16BWa08okj0kSZtwwEnCgM5fStG4hDsmE4rK24dWU5O8ewVMGfn5eAu/h2
	 pZxpulj3URIxDfZ4hyJf4sO/fFRdAILd77UhpkjOEJMEBlSdUObJGsd98a+ZcesiefFjq
	 CfGw2b+Dr3PbVauAnZ2xSwCrappvEKvSarapnLUtXxLrcvnNemwe9gtb4GC1wz8nz1NzY
	 xBI18EtUgZ7FT9AMKCEcTwyfUsbgwwMfz7dMAa4vP2zRwZc5ZMmnHAMrQ1voniJz8BQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793967045;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DNMrUoJjtebq02qUQke1dSqKE2bqVQchCGuYtctyfYk=;
	b=A1GSQlO30Yb9wJ+z52RnASmcdvSdDqeCKuZEyGGJgfmAf7I5j5U1cYDVeOldk8wcfOol
	 FlDufq4LlVsOjoRCAxICFt7cUOVA72KYKggcNdlAuhAMoa1aBtQs7po0wI32W2ToUR8il
	 v7IXz2NXJqDZSmUxbe0LLlrfZPAsXtRfcRCpOLoe4rE5/DVanMWYGCsof6BfEmmMi0Bk8
	 PFB6uWUAshlOkqG6GosguhUWkXpj8/SnoE3sEYzlqtrZyoYaVZI1JK+pBYXwAsY7Hr0YU
	 BV+cLz0HhH6NKDaGY2y55ThlyXyBa5weA5sz32h/MbokaJpxBxXX0uA7aPL0oXRgtfg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793967045;
	bh=DNMrUoJjtebq02qUQke1dSqKE2bqVQchCGuYtctyfYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=8PeGgrvxCXcElOieU8CCh5KcvA71yLj4W12szOhxrYsPa/WwlNHI4yW//KQCzmAq8
	 hHDq0obmxeTkiol7FSadKhi4NDfr+va0w4zh4B9fduaNdF8dIKsUgwxbtgYVBd00Ee
	 +C1XTYZzZKFC9+A2QhlX4km5zWB0VyceWJEjwRIVP4VQYFHrcTsMgLVeT/2EHuggEX
	 9ax2m3RYZykWD7oYDQ4FCM1/cwi8MF9O/+WQT5Ap8VTdosRSIYGkds960jDk+B2ZeW
	 f63pIAA32GhhEqpKlsAM4fLFUsp58eCaDms9JOu3FY8B7S1oOo0rW04FcpX7llsvAd
	 HEO6qZ/OO1StA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 865FA40993;
	Fri,  6 Nov 2026 12:10:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 731A5362
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:10:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 58C4C403A9
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:10:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aWN3xPLeLN5r for <intel-wired-lan@lists.osuosl.org>;
 Fri,  6 Nov 2026 12:10:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4D274400FF
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HqM0R/yc
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4D274400FF
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793967041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DNMrUoJjtebq02qUQke1dSqKE2bqVQchCGuYtctyfYk=;
 b=HqM0R/ycTO212kWDEnDFa/PsVAKsxwlo8tVrmARQidK81yFQUDggRpgKFn4BPwpVIktO00
 tV/M3fOYUJoj7sTQwnytqzi4KR3P9uRE4RiGow2Wo17RJwZoN6SWCtKO28fUSSMSSCn760
 UftESDM6rwBRxPM11LdlBfbxFZUUVzk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-4YJlmD3jNNuPK9NrCRiFRQ-1; Fri,
 06 Nov 2026 07:10:36 -0500
X-MC-Unique: 4YJlmD3jNNuPK9NrCRiFRQ-1
X-Mimecast-MFC-AGG-ID: 4YJlmD3jNNuPK9NrCRiFRQ_1793967034
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99CAE1955F6D; Fri,  6 Nov 2026 12:10:33 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8B0A7187C36C; Fri,  6 Nov 2026 12:10:27 +0000 (UTC)
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
Subject: [PATCH net-next 03/10] dpll: add domain object
Date: Fri,  6 Nov 2026 13:09:58 +0100
Message-ID: <20261106121005.1327603-4-ivecera@redhat.com>
In-Reply-To: <20261106121005.1327603-1-ivecera@redhat.com>
References: <20261106121005.1327603-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: MtSMULdwAhnDNy_IcyaqtI6KBfASvUS6epvfzZfATk0_1793967034
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

All dpll device and pin callbacks are serialized by the global dpll_lock,
so a slow device stalls all others, whichever driver they belong to.

Add struct dpll_domain as a preparation for serializing callbacks per
driver instance. A domain groups all devices and pins created with the
same (module, clock_id) pair, which is in practice one chip or card. The
same pair already identifies the owner of a pin in
dpll_pin_own_dpll_ref_first().

Domains are kept in an xarray, like devices and pins, and they live only as
long as their objects.

No functional change.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_core.c | 61 ++++++++++++++++++++++++++++++++++++++++
 drivers/dpll/dpll_core.h | 27 ++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 8389983f425695..d39c4905172f2d 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -24,6 +24,7 @@ DEFINE_MUTEX(dpll_lock);
 
 DEFINE_XARRAY_FLAGS(dpll_device_xa, XA_FLAGS_ALLOC);
 DEFINE_XARRAY_FLAGS(dpll_pin_xa, XA_FLAGS_ALLOC);
+static DEFINE_XARRAY_FLAGS(dpll_domain_xa, XA_FLAGS_ALLOC);
 
 static RAW_NOTIFIER_HEAD(dpll_notifier_chain);
 static DEFINE_IDA(dpll_pin_idx_ida);
@@ -88,6 +89,50 @@ void dpll_pin_notify(struct dpll_pin *pin, u64 src_clock_id,
 	call_dpll_notifiers(action, &info);
 }
 
+static struct dpll_domain *dpll_domain_get(u64 clock_id, struct module *module)
+{
+	struct dpll_domain *domain;
+	unsigned long i;
+	int ret;
+
+	lockdep_assert_held(&dpll_lock);
+
+	xa_for_each(&dpll_domain_xa, i, domain) {
+		if (domain->clock_id == clock_id && domain->module == module) {
+			refcount_inc(&domain->refcount);
+			return domain;
+		}
+	}
+
+	domain = kzalloc_obj(*domain);
+	if (!domain)
+		return ERR_PTR(-ENOMEM);
+	domain->clock_id = clock_id;
+	domain->module = module;
+	refcount_set(&domain->refcount, 1);
+	mutex_init(&domain->lock);
+	ret = xa_alloc(&dpll_domain_xa, &domain->id, domain, xa_limit_32b,
+		       GFP_KERNEL);
+	if (ret) {
+		mutex_destroy(&domain->lock);
+		kfree(domain);
+		return ERR_PTR(ret);
+	}
+
+	return domain;
+}
+
+static void dpll_domain_put(struct dpll_domain *domain)
+{
+	lockdep_assert_held(&dpll_lock);
+
+	if (refcount_dec_and_test(&domain->refcount)) {
+		xa_erase(&dpll_domain_xa, domain->id);
+		mutex_destroy(&domain->lock);
+		kfree(domain);
+	}
+}
+
 static void dpll_device_tracker_alloc(struct dpll_device *dpll,
 				      dpll_tracker *tracker)
 {
@@ -120,6 +165,7 @@ static void __dpll_device_put(struct dpll_device *dpll, dpll_tracker *tracker)
 		xa_erase(&dpll_device_xa, dpll->id);
 		WARN_ON(!list_empty(&dpll->registration_list));
 		ref_tracker_dir_exit(&dpll->refcnt_tracker);
+		dpll_domain_put(dpll->domain);
 		kfree(dpll);
 	}
 }
@@ -159,6 +205,7 @@ static void __dpll_pin_put(struct dpll_pin *pin, dpll_tracker *tracker)
 		fwnode_handle_put(pin->fwnode);
 		dpll_pin_idx_free(pin->pin_idx);
 		ref_tracker_dir_exit(&pin->refcnt_tracker);
+		dpll_domain_put(pin->domain);
 		kfree_rcu(pin, rcu);
 	}
 }
@@ -366,6 +413,12 @@ dpll_device_alloc(const u64 clock_id, u32 device_idx, struct module *module)
 	dpll = kzalloc_obj(*dpll);
 	if (!dpll)
 		return ERR_PTR(-ENOMEM);
+	dpll->domain = dpll_domain_get(clock_id, module);
+	if (IS_ERR(dpll->domain)) {
+		ret = PTR_ERR(dpll->domain);
+		kfree(dpll);
+		return ERR_PTR(ret);
+	}
 	refcount_set(&dpll->refcount, 1);
 	INIT_LIST_HEAD(&dpll->registration_list);
 	dpll->device_idx = device_idx;
@@ -374,6 +427,7 @@ dpll_device_alloc(const u64 clock_id, u32 device_idx, struct module *module)
 	ret = xa_alloc_cyclic(&dpll_device_xa, &dpll->id, dpll, xa_limit_32b,
 			      &dpll_device_xa_id, GFP_KERNEL);
 	if (ret < 0) {
+		dpll_domain_put(dpll->domain);
 		kfree(dpll);
 		return ERR_PTR(ret);
 	}
@@ -664,6 +718,11 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
 	ret = dpll_pin_prop_dup(prop, &pin->prop);
 	if (ret)
 		goto err_pin_prop;
+	pin->domain = dpll_domain_get(clock_id, module);
+	if (IS_ERR(pin->domain)) {
+		ret = PTR_ERR(pin->domain);
+		goto err_domain;
+	}
 	refcount_set(&pin->refcount, 1);
 	xa_init_flags(&pin->dpll_refs, XA_FLAGS_ALLOC);
 	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);
@@ -678,6 +737,8 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
 	xa_destroy(&pin->dpll_refs);
 	xa_destroy(&pin->parent_refs);
 	xa_destroy(&pin->ref_sync_pins);
+	dpll_domain_put(pin->domain);
+err_domain:
 	dpll_pin_prop_free(&pin->prop);
 err_pin_prop:
 	kfree(pin);
diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
index da8a369556ed11..6705e81bc11de9 100644
--- a/drivers/dpll/dpll_core.h
+++ b/drivers/dpll/dpll_core.h
@@ -9,18 +9,42 @@
 
 #include <linux/dpll.h>
 #include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/refcount.h>
 #include <linux/ref_tracker.h>
 #include "dpll_nl.h"
 
 #define DPLL_REGISTERED		XA_MARK_1
 
+/**
+ * struct dpll_domain - group of dpll objects sharing a lock
+ * @id:			index of the domain in dpll_domain_xa
+ * @clock_id:		clock_id of the objects in the domain
+ * @module:		module of the objects in the domain
+ * @refcount:		number of dpll devices and pins in the domain
+ * @lock:		lock of the domain
+ *
+ * All dpll devices and pins created with the same (module, clock_id) pair
+ * belong to one domain, in practice to one chip or card.
+ **/
+struct dpll_domain {
+	u32 id;
+	u64 clock_id;
+	struct module *module;
+	refcount_t refcount;
+	/* Serializes the driver callbacks of all DPLL devices and pins
+	 * that share one (module, clock_id) pair.
+	 */
+	struct mutex lock;
+};
+
 /**
  * struct dpll_device - stores DPLL device internal data
  * @id:			unique id number for device given by dpll subsystem
  * @device_idx:		id given by dev driver
  * @clock_id:		unique identifier (clock_id) of a dpll
  * @module:		module of creator
+ * @domain:		domain the device belongs to
  * @type:		type of a dpll
  * @pin_refs:		stores pins registered within a dpll
  * @refcount:		refcount
@@ -32,6 +56,7 @@ struct dpll_device {
 	u32 device_idx;
 	u64 clock_id;
 	struct module *module;
+	struct dpll_domain *domain;
 	enum dpll_type type;
 	struct xarray pin_refs;
 	refcount_t refcount;
@@ -46,6 +71,7 @@ struct dpll_device {
  * @clock_id:		clock_id of creator
  * @module:		module of creator
  * @module_name:	module name of creator
+ * @domain:		domain the pin belongs to
  * @fwnode:		optional reference to firmware node
  * @dpll_refs:		hold referencees to dplls pin was registered with
  * @parent_refs:	hold references to parent pins pin was registered with
@@ -61,6 +87,7 @@ struct dpll_pin {
 	u64 clock_id;
 	struct module *module;
 	char module_name[MODULE_NAME_LEN];
+	struct dpll_domain *domain;
 	struct fwnode_handle *fwnode;
 	struct xarray dpll_refs;
 	struct xarray parent_refs;
-- 
2.56.0

