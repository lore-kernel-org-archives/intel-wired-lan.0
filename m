Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C424D606A336
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Nov 2026 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=QT6E9bSD;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PZdqXfq5;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QM/KRGTQ;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PZdqXfq5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A78048134A;
	Wed, 11 Nov 2026 16:41:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DjxK0vpYl9KE; Wed, 11 Nov 2026 16:41:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8976D813D8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794415268;
	b=SL9V0RLh3Prt+U7Nb8bjQ9fUpPAqor1KO9xd2BUkQWUp4NrGgLCu4wKMASFnXv0Cbmxc
	 xSgCt4k3sbX1fCxidP7nwTQtnPXI4aNe5ZatbD7BWiVFHSMgiZb7H5gIRNWoJYpTVTvBV
	 IhjinHErTDVaFUeF4GTt5FXPmDP7dltMhUqJtDOlDwGMP0DL7/RDrRnbxCr5JBaTM9k+s
	 jKzl6ZaaIRn4FbZN3b8BkRWEeEfqNZb+rgvytANsgFpyY7K5JKhtEdD7nrAoxLz4gDbky
	 sNuBaR5imIyMBYhhd0FoFhs19+n//l3l6cX9QYcpTYogVGFNq1iKL7QPtsj5aSrmGlQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794415268;
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
	bh=lRqsjk0A3D+1SinYrhqnbnjoAOHbhQtms1itlFQ68EE=;
	b=a3XuAWZVevBlEK20Np37QjdIkzxQDSKmsWTnYoH81taWcX7SVQi+nC/j2ljbFtNbCb0w
	 3Kl4Ld/rqwPZWXvFf+BfYM9kqX3V83QQq3LM6ppr1rm97kS4eCwenJCEotpuNjnaUF3Ra
	 Fv3U56e1Fi+zsxHWxoNKHlOrr1/T/5Oh6oTSNeNGiRH+Ky8MdIyHGr4cSLlS8H6DsgchM
	 jTusWhfcZfPIo6ZTJWvYGfSXJXa6SI59UW/LDms0FmD1Kh2/6QCGf5DIA2RJgrdHmF5/d
	 9gPieqJkoa0+ginSWvO/7a6Uf9ld3D1TYW0OiRilTL/JjjvF9RFdl9vbQLXk8Jmiocg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794415268;
	bh=lRqsjk0A3D+1SinYrhqnbnjoAOHbhQtms1itlFQ68EE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QT6E9bSD6IGvaLCKO3bk14vpPQuWV0xqosdAadRFPV5YBoSJlNry+bkOP4Hov09DB
	 KojX2Z4aYrqCmruOOPnvPQW9bvr3Pa4SvMbExQbeGfYfp/v/aBZcr0pHY1i2/g7x+S
	 KoNoGn/jkKI4H/iKRP1M+CFlDeh95bm4SfY75K+CZVWHp4qoNnf27+pu6pgOByphwO
	 caWqQAAJ7H+FIaGSdBvhaxwKHL0+wGcvcoDvl6ukAgP4rGr6dU3GLTTTvZOZApPBmh
	 fEtFeQA8i9emcCMJt2KKC+hFyJgxcaAo2r2BetIAouVWIHe8oj4HuEH7bDo1+/7p4U
	 WvWPbTqw4QG/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8976D813D8;
	Wed, 11 Nov 2026 16:41:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2ACDD731
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 16:41:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2827B4016D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 16:41:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BjMKRgF3xNkb for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Nov 2026 16:41:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C23874006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PZdqXfq5; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QM/KRGTQ; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PZdqXfq5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTP id C23874006F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 16:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794415263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lRqsjk0A3D+1SinYrhqnbnjoAOHbhQtms1itlFQ68EE=;
 b=PZdqXfq5f7JJe9p2gsfdjAoJyUVa0IgzyIpERXpx59JSxFPw67Q+b7RN2lDX/SVpcScRDw
 LZzLcUtKd/LcVkhV3egZEDZG/HB1sMUS2zksEpbBhm3anm99ApAOfG8IgFZAFGRl+ib2e2
 2y6Ujma7BY1t2/M89Drv2nDNx3Y9MpE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794415264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lRqsjk0A3D+1SinYrhqnbnjoAOHbhQtms1itlFQ68EE=;
 b=QM/KRGTQBqgEdxSsR2CvUpbZ9BjtHpuo/CADHiEo6FDRisq4bh4gGK7n8lahY7qXwNywRs
 TS33vpWbKylWdgPQUErkjyXtVOqsHHOdMbEi3vpiWPLjXjds0RbqwQem2TjBLVekAaKYYy
 AUJ/SbQuJEDRPugNvpJp/XN4rMWcbZQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794415263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lRqsjk0A3D+1SinYrhqnbnjoAOHbhQtms1itlFQ68EE=;
 b=PZdqXfq5f7JJe9p2gsfdjAoJyUVa0IgzyIpERXpx59JSxFPw67Q+b7RN2lDX/SVpcScRDw
 LZzLcUtKd/LcVkhV3egZEDZG/HB1sMUS2zksEpbBhm3anm99ApAOfG8IgFZAFGRl+ib2e2
 2y6Ujma7BY1t2/M89Drv2nDNx3Y9MpE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-BkJZ6L9CMAijsIC7z7N7qg-1; Wed,
 11 Nov 2026 11:40:57 -0500
X-MC-Unique: BkJZ6L9CMAijsIC7z7N7qg-1
X-Mimecast-MFC-AGG-ID: BkJZ6L9CMAijsIC7z7N7qg_1794415254
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCD8319540F2; Wed, 11 Nov 2026 16:40:53 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0BD0E421; Wed, 11 Nov 2026 16:40:47 +0000 (UTC)
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
Subject: [PATCH net-next v2 4/9] dpll: convert dpll_lock to rwsem
Date: Wed, 11 Nov 2026 17:40:15 +0100
Message-ID: <20261111164021.273409-5-ivecera@redhat.com>
In-Reply-To: <20261111164021.273409-1-ivecera@redhat.com>
References: <20261111164021.273409-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: FDdEuVu1bILACImm9gLYskvCaTWN1GwxJ2iFJ8HrEHk_1794415254
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

Driver callbacks are now serialized by domain locks, so dpll_lock only has
to protect the topology and lifetime of devices and pins.

Convert it to an rwsem. Core functions changing the topology take it for
write. Netlink requests, each part of a dump and change notifications take
it for read, for their whole duration, so objects found by a lookup stay
valid. This is the patch that lets callbacks of different domains run
concurrently.

A callback running for long still blocks topology changes, and a waiting
writer blocks new readers, so a stuck callback stalls the subsystem while
a device is being probed or removed. This is no worse than the global
serialization it replaces.

Reviewed-by: Petr Oros <poros@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
Changes in v2:
- lockdep_assert_held_write() in dpll_domain_get() and
  dpll_domain_put() (Sashiko)
---
 drivers/dpll/dpll_core.c    | 97 +++++++++++++++++--------------------
 drivers/dpll/dpll_core.h    |  3 +-
 drivers/dpll/dpll_netlink.c | 32 ++++++------
 3 files changed, 63 insertions(+), 69 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index b4b2b2dc449aec..2b1dfe2929647e 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -19,8 +19,12 @@
 #include "dpll_core.h"
 #include "dpll_netlink.h"
 
-/* Mutex lock to protect DPLL subsystem devices and pins */
-DEFINE_MUTEX(dpll_lock);
+/* Protects the topology and lifetime of DPLL devices and pins. Taken for write
+ * to change them and for read for the whole netlink request, part of a dump or
+ * change notification that uses them. Driver callbacks are serialized by domain
+ * locks, which are only taken under this lock.
+ */
+DECLARE_RWSEM(dpll_lock);
 
 DEFINE_XARRAY_FLAGS(dpll_device_xa, XA_FLAGS_ALLOC);
 DEFINE_XARRAY_FLAGS(dpll_pin_xa, XA_FLAGS_ALLOC);
@@ -95,7 +99,7 @@ static struct dpll_domain *dpll_domain_get(u64 clock_id, struct module *module)
 	unsigned long i;
 	int ret;
 
-	lockdep_assert_held(&dpll_lock);
+	lockdep_assert_held_write(&dpll_lock);
 
 	xa_for_each(&dpll_domain_xa, i, domain) {
 		if (domain->clock_id == clock_id && domain->module == module) {
@@ -124,7 +128,7 @@ static struct dpll_domain *dpll_domain_get(u64 clock_id, struct module *module)
 
 static void dpll_domain_put(struct dpll_domain *domain)
 {
-	lockdep_assert_held(&dpll_lock);
+	lockdep_assert_held_write(&dpll_lock);
 
 	if (refcount_dec_and_test(&domain->refcount)) {
 		xa_erase(&dpll_domain_xa, domain->id);
@@ -459,7 +463,7 @@ dpll_device_get(u64 clock_id, u32 device_idx, struct module *module,
 	struct dpll_device *dpll, *ret = NULL;
 	unsigned long index;
 
-	mutex_lock(&dpll_lock);
+	down_write(&dpll_lock);
 	xa_for_each(&dpll_device_xa, index, dpll) {
 		if (dpll->clock_id == clock_id &&
 		    dpll->device_idx == device_idx &&
@@ -475,7 +479,7 @@ dpll_device_get(u64 clock_id, u32 device_idx, struct module *module,
 			dpll_device_tracker_alloc(ret, tracker);
 	}
 
-	mutex_unlock(&dpll_lock);
+	up_write(&dpll_lock);
 
 	return ret;
 }
@@ -492,9 +496,9 @@ EXPORT_SYMBOL_GPL(dpll_device_get);
  */
 void dpll_device_put(struct dpll_device *dpll, dpll_tracker *tracker)
 {
-	mutex_lock(&dpll_lock);
+	down_write(&dpll_lock);
 	__dpll_device_put(dpll, tracker);
-	mutex_unlock(&dpll_lock);
+	up_write(&dpll_lock);
 }
 EXPORT_SYMBOL_GPL(dpll_device_put);
 
@@ -540,16 +544,16 @@ int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
 	if (WARN_ON(type < DPLL_TYPE_PPS || type > DPLL_TYPE_MAX))
 		return -EINVAL;
 
-	mutex_lock(&dpll_lock);
+	down_write(&dpll_lock);
 	reg = dpll_device_registration_find(dpll, ops, priv);
 	if (reg) {
-		mutex_unlock(&dpll_lock);
+		up_write(&dpll_lock);
 		return -EEXIST;
 	}
 
 	reg = kzalloc_obj(*reg);
 	if (!reg) {
-		mutex_unlock(&dpll_lock);
+		up_write(&dpll_lock);
 		return -ENOMEM;
 	}
 	reg->ops = ops;
@@ -559,13 +563,13 @@ int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
 	first_registration = list_empty(&dpll->registration_list);
 	list_add_tail(&reg->list, &dpll->registration_list);
 	if (!first_registration) {
-		mutex_unlock(&dpll_lock);
+		up_write(&dpll_lock);
 		return 0;
 	}
 
 	xa_set_mark(&dpll_device_xa, dpll->id, DPLL_REGISTERED);
 	dpll_device_create_ntf(dpll);
-	mutex_unlock(&dpll_lock);
+	up_write(&dpll_lock);
 
 	return 0;
 }
@@ -586,12 +590,12 @@ void dpll_device_unregister(struct dpll_device *dpll,
 {
 	struct dpll_device_registration *reg;
 
-	mutex_lock(&dpll_lock);
+	down_write(&dpll_lock);
 	ASSERT_DPLL_REGISTERED(dpll);
 	dpll_device_delete_ntf(dpll);
 	reg = dpll_device_registration_find(dpll, ops, priv);
 	if (WARN_ON(!reg)) {
-		mutex_unlock(&dpll_lock);
+		up_write(&dpll_lock);
 		return;
 	}
 	list_del(&reg->list);
@@ -599,11 +603,11 @@ void dpll_device_unregister(struct dpll_device *dpll,
 	kfree(reg);
 
 	if (!list_empty(&dpll->registration_list)) {
-		mutex_unlock(&dpll_lock);
+		up_write(&dpll_lock);
 		return;
 	}
 	xa_clear_mark(&dpll_device_xa, dpll->id, DPLL_REGISTERED);
-	mutex_unlock(&dpll_lock);
+	up_write(&dpll_lock);
 }
 EXPORT_SYMBOL_GPL(dpll_device_unregister);
 
@@ -771,9 +775,9 @@ int register_dpll_notifier(struct notifier_block *nb)
 {
 	int ret;
 
-	mutex_lock(&dpll_lock);
+	down_write(&dpll_lock);
 	ret = raw_notifier_chain_register(&dpll_notifier_chain, nb);
-	mutex_unlock(&dpll_lock);
+	up_write(&dpll_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(register_dpll_notifier);
@@ -782,9 +786,9 @@ int unregister_dpll_notifier(struct notifier_block *nb)
 {
 	int ret;
 
-	mutex_lock(&dpll_lock);
+	down_write(&dpll_lock);
 	ret = raw_notifier_chain_unregister(&dpll_notifier_chain, nb);
-	mutex_unlock(&dpll_lock);
+	up_write(&dpll_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(unregister_dpll_notifier);
@@ -812,7 +816,7 @@ dpll_pin_get(u64 clock_id, u32 pin_idx, struct module *module,
 	struct dpll_pin *pos, *ret = NULL;
 	unsigned long i;
 
-	mutex_lock(&dpll_lock);
+	down_write(&dpll_lock);
 	xa_for_each(&dpll_pin_xa, i, pos) {
 		if (pos->clock_id == clock_id &&
 		    pos->pin_idx == pin_idx &&
@@ -827,7 +831,7 @@ dpll_pin_get(u64 clock_id, u32 pin_idx, struct module *module,
 		if (!IS_ERR(ret))
 			dpll_pin_tracker_alloc(ret, tracker);
 	}
-	mutex_unlock(&dpll_lock);
+	up_write(&dpll_lock);
 
 	return ret;
 }
@@ -844,9 +848,9 @@ EXPORT_SYMBOL_GPL(dpll_pin_get);
  */
 void dpll_pin_put(struct dpll_pin *pin, dpll_tracker *tracker)
 {
-	mutex_lock(&dpll_lock);
+	down_write(&dpll_lock);
 	__dpll_pin_put(pin, tracker);
-	mutex_unlock(&dpll_lock);
+	up_write(&dpll_lock);
 }
 EXPORT_SYMBOL_GPL(dpll_pin_put);
 
@@ -859,10 +863,10 @@ EXPORT_SYMBOL_GPL(dpll_pin_put);
  */
 void dpll_pin_fwnode_set(struct dpll_pin *pin, struct fwnode_handle *fwnode)
 {
-	mutex_lock(&dpll_lock);
+	down_write(&dpll_lock);
 	fwnode_handle_put(pin->fwnode); /* Drop fwnode previously set */
 	pin->fwnode = fwnode_handle_get(fwnode);
-	mutex_unlock(&dpll_lock);
+	up_write(&dpll_lock);
 }
 EXPORT_SYMBOL_GPL(dpll_pin_fwnode_set);
 
@@ -885,7 +889,7 @@ struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode,
 	struct dpll_pin *pin, *ret = NULL;
 	unsigned long index;
 
-	mutex_lock(&dpll_lock);
+	down_write(&dpll_lock);
 	xa_for_each(&dpll_pin_xa, index, pin) {
 		if (pin->fwnode == fwnode) {
 			__dpll_pin_hold(pin, tracker);
@@ -893,7 +897,7 @@ struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode,
 			break;
 		}
 	}
-	mutex_unlock(&dpll_lock);
+	up_write(&dpll_lock);
 
 	return ret;
 }
@@ -950,7 +954,7 @@ dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 		      DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE)))
 		return -EINVAL;
 
-	mutex_lock(&dpll_lock);
+	down_write(&dpll_lock);
 
 	dev_ops = dpll_device_ops(dpll);
 	if (WARN_ON(ops->measured_freq_get &&
@@ -974,7 +978,7 @@ dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 
 	ret = __dpll_pin_register(dpll, pin, ops, priv, NULL);
 out_unlock:
-	mutex_unlock(&dpll_lock);
+	up_write(&dpll_lock);
 
 	return ret;
 }
@@ -1028,9 +1032,9 @@ void dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
 	if (WARN_ON(!xa_empty(&pin->parent_refs)))
 		return;
 
-	mutex_lock(&dpll_lock);
+	down_write(&dpll_lock);
 	__dpll_pin_unregister(dpll, pin, ops, priv, NULL);
-	mutex_unlock(&dpll_lock);
+	up_write(&dpll_lock);
 }
 EXPORT_SYMBOL_GPL(dpll_pin_unregister);
 
@@ -1064,7 +1068,7 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 	    WARN_ON(!ops->direction_get))
 		return -EINVAL;
 
-	mutex_lock(&dpll_lock);
+	down_write(&dpll_lock);
 	ret = dpll_xa_ref_pin_add(&pin->parent_refs, parent, ops, priv, pin);
 	if (ret)
 		goto unlock;
@@ -1076,7 +1080,7 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 		}
 		dpll_pin_create_ntf(pin, parent->clock_id);
 	}
-	mutex_unlock(&dpll_lock);
+	up_write(&dpll_lock);
 
 	return ret;
 
@@ -1089,7 +1093,7 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 		}
 	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
 unlock:
-	mutex_unlock(&dpll_lock);
+	up_write(&dpll_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dpll_pin_on_pin_register);
@@ -1111,7 +1115,7 @@ void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin *pin,
 	struct dpll_pin_ref *ref;
 	unsigned long i;
 
-	mutex_lock(&dpll_lock);
+	down_write(&dpll_lock);
 	xa_for_each(&pin->dpll_refs, i, ref) {
 		reg = dpll_pin_registration_find(ref, ops, priv, parent);
 		if (!reg)
@@ -1120,7 +1124,7 @@ void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin *pin,
 		__dpll_pin_unregister(ref->dpll, pin, ops, priv, parent);
 	}
 	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
-	mutex_unlock(&dpll_lock);
+	up_write(&dpll_lock);
 }
 EXPORT_SYMBOL_GPL(dpll_pin_on_pin_unregister);
 
@@ -1141,13 +1145,13 @@ int dpll_pin_ref_sync_pair_add(struct dpll_pin *pin,
 {
 	int ret;
 
-	mutex_lock(&dpll_lock);
+	down_write(&dpll_lock);
 	ret = xa_insert(&pin->ref_sync_pins, ref_sync_pin->id,
 			ref_sync_pin, GFP_KERNEL);
 	mutex_lock(&pin->domain->lock);
 	__dpll_pin_change_ntf(pin);
 	mutex_unlock(&pin->domain->lock);
-	mutex_unlock(&dpll_lock);
+	up_write(&dpll_lock);
 
 	return ret;
 }
@@ -1253,23 +1257,12 @@ const struct dpll_pin_ops *dpll_pin_ops(struct dpll_pin_ref *ref)
 
 static int __init dpll_init(void)
 {
-	int ret;
-
-	ret = genl_register_family(&dpll_nl_family);
-	if (ret)
-		goto error;
-
-	return 0;
-
-error:
-	mutex_destroy(&dpll_lock);
-	return ret;
+	return genl_register_family(&dpll_nl_family);
 }
 
 static void __exit dpll_exit(void)
 {
 	genl_unregister_family(&dpll_nl_family);
-	mutex_destroy(&dpll_lock);
 }
 
 subsys_initcall(dpll_init);
diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
index 630c5a1ca572c2..e212e53528e33b 100644
--- a/drivers/dpll/dpll_core.h
+++ b/drivers/dpll/dpll_core.h
@@ -12,6 +12,7 @@
 #include <linux/mutex.h>
 #include <linux/refcount.h>
 #include <linux/ref_tracker.h>
+#include <linux/rwsem.h>
 #include "dpll_nl.h"
 
 #define DPLL_REGISTERED		XA_MARK_1
@@ -129,7 +130,7 @@ const struct dpll_pin_ops *dpll_pin_ops(struct dpll_pin_ref *ref);
 struct dpll_pin_ref *dpll_xa_ref_dpll_first(struct xarray *xa_refs);
 extern struct xarray dpll_device_xa;
 extern struct xarray dpll_pin_xa;
-extern struct mutex dpll_lock;
+extern struct rw_semaphore dpll_lock;
 
 void dpll_device_notify(struct dpll_device *dpll, unsigned long action);
 void dpll_pin_notify(struct dpll_pin *pin, u64 src_clock_id,
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 1b4e3a0166a744..9d8f5d1ce97248 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -910,11 +910,11 @@ int dpll_device_change_ntf(struct dpll_device *dpll)
 {
 	int ret;
 
-	mutex_lock(&dpll_lock);
+	down_read(&dpll_lock);
 	mutex_lock(&dpll->domain->lock);
 	ret = __dpll_device_change_ntf(dpll);
 	mutex_unlock(&dpll->domain->lock);
-	mutex_unlock(&dpll_lock);
+	up_read(&dpll_lock);
 
 	return ret;
 }
@@ -1004,11 +1004,11 @@ int dpll_pin_change_ntf(struct dpll_pin *pin)
 {
 	int ret;
 
-	mutex_lock(&dpll_lock);
+	down_read(&dpll_lock);
 	mutex_lock(&pin->domain->lock);
 	ret = __dpll_pin_change_ntf(pin);
 	mutex_unlock(&pin->domain->lock);
-	mutex_unlock(&dpll_lock);
+	up_read(&dpll_lock);
 
 	return ret;
 }
@@ -1795,7 +1795,7 @@ int dpll_nl_pin_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	unsigned long i;
 	int ret = 0;
 
-	mutex_lock(&dpll_lock);
+	down_read(&dpll_lock);
 	xa_for_each_marked_start(&dpll_pin_xa, i, pin, DPLL_REGISTERED,
 				 ctx->idx) {
 		if (!dpll_pin_available(pin))
@@ -1821,7 +1821,7 @@ int dpll_nl_pin_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 		}
 		genlmsg_end(skb, hdr);
 	}
-	mutex_unlock(&dpll_lock);
+	up_read(&dpll_lock);
 
 	if (ret == -EMSGSIZE) {
 		ctx->idx = i;
@@ -2019,7 +2019,7 @@ int dpll_nl_device_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	unsigned long i;
 	int ret = 0;
 
-	mutex_lock(&dpll_lock);
+	down_read(&dpll_lock);
 	xa_for_each_marked_start(&dpll_device_xa, i, dpll, DPLL_REGISTERED,
 				 ctx->idx) {
 		hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
@@ -2038,7 +2038,7 @@ int dpll_nl_device_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 		}
 		genlmsg_end(skb, hdr);
 	}
-	mutex_unlock(&dpll_lock);
+	up_read(&dpll_lock);
 
 	if (ret == -EMSGSIZE) {
 		ctx->idx = i;
@@ -2056,7 +2056,7 @@ int dpll_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 	if (GENL_REQ_ATTR_CHECK(info, DPLL_A_ID))
 		return -EINVAL;
 
-	mutex_lock(&dpll_lock);
+	down_read(&dpll_lock);
 	id = nla_get_u32(info->attrs[DPLL_A_ID]);
 	dpll = dpll_device_get_by_id(id);
 	if (!dpll) {
@@ -2067,7 +2067,7 @@ int dpll_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 	mutex_lock(&dpll->domain->lock);
 	return 0;
 unlock:
-	mutex_unlock(&dpll_lock);
+	up_read(&dpll_lock);
 	return -ENODEV;
 }
 
@@ -2077,14 +2077,14 @@ void dpll_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 	struct dpll_device *dpll = info->user_ptr[0];
 
 	mutex_unlock(&dpll->domain->lock);
-	mutex_unlock(&dpll_lock);
+	up_read(&dpll_lock);
 }
 
 int
 dpll_lock_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 	       struct genl_info *info)
 {
-	mutex_lock(&dpll_lock);
+	down_read(&dpll_lock);
 
 	return 0;
 }
@@ -2093,7 +2093,7 @@ void
 dpll_unlock_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 		 struct genl_info *info)
 {
-	mutex_unlock(&dpll_lock);
+	up_read(&dpll_lock);
 }
 
 int dpll_pin_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
@@ -2102,7 +2102,7 @@ int dpll_pin_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 	struct dpll_pin *pin;
 	int ret;
 
-	mutex_lock(&dpll_lock);
+	down_read(&dpll_lock);
 	if (GENL_REQ_ATTR_CHECK(info, DPLL_A_PIN_ID)) {
 		ret = -EINVAL;
 		goto unlock_dev;
@@ -2119,7 +2119,7 @@ int dpll_pin_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 	return 0;
 
 unlock_dev:
-	mutex_unlock(&dpll_lock);
+	up_read(&dpll_lock);
 	return ret;
 }
 
@@ -2129,5 +2129,5 @@ void dpll_pin_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 	struct dpll_pin *pin = info->user_ptr[0];
 
 	mutex_unlock(&pin->domain->lock);
-	mutex_unlock(&dpll_lock);
+	up_read(&dpll_lock);
 }
-- 
2.56.0

