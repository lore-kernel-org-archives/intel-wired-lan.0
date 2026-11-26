Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4813606A32A
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 20:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=k54ekMwx;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WA4VDw8k
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A5E9E60A68;
	Thu, 26 Nov 2026 20:34:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IqHzw41kVIlX; Thu, 26 Nov 2026 20:34:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1380B60AA1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795725287;
	b=UOTsM9jRvYcPmdgg4Tm5nqdKe8IJKBSyr+bGcHWGQsUyyRQyNeeB3QpqumrLmqVepxot
	 YOdMLa0nbi9eF42uBPve6eHLaBiIfXXQwNVF7pxPa3m8TI+pJlA0GTMVz3lpaklcr7GnK
	 h42d8cHleZGRKX1NzbzPVUkPYFNkosqG6xgjXyRelSWzVarbn8/j+SYJ9G96kTS2zE6tw
	 gMNN9/c5uTXtt36f3ak6mhr/Ap0LwXJMfmG1f3KX3Dn/x2zAltnXUJ7Nbm+DzYGaarhUj
	 YzbZTfzHS+1qShjTFTrhuP1uq2JA7Gi0Xo8GtAc87OzXhnKR/yNKCdspnWRuvEOf6fA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795725287;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GuGdWNAUUamhyAvRSygUN7vwSXLvTQpL3xsjy8x1md8=;
	b=M7ApQPvHklK7rU98x4ErddviArAT91FQvkU2m+l82hrVCLTkHkZZhTATbXi6P9tAazlg
	 NNy1YP34Ol1l3c/arNqQXi+6LgJE2vGuDiqcjE7PlczhiSs6ajUT8/TxV2bL/sajN+qUw
	 GvlkQQeh8SXzwYukzwBRa9JDAYJA9MNX2ws3287Yc2sm8oGdW+h4nuek2lWhTeqlPTZyJ
	 eBrMSywpWbzOWMhSEn4us5w925N2kixRT9qv6b1kqSXvMBi2RVt54xgB44SSgS4f5msLY
	 fzIrP+0PjjAhvMllujFvgx1O9+IXKrc1kMnIFBCGzP853+4Ug15V/hnTviYnpd/21EA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795725287;
	bh=GuGdWNAUUamhyAvRSygUN7vwSXLvTQpL3xsjy8x1md8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k54ekMwxcjoe/3jfJ8GrURtTUy+OyeP0/s20BVkIika2EiK2lGfY43cAo/aYqjEB2
	 /oZsh8CuXpXKLJW9Ga8VpgCJP/OG/G8H9PQoCZtttZSq8HbbMQA/ruh82Yh/pbJUp+
	 bs9DDr30/041QntwwqwAHXSq28KxOkxTYkC+/xV54MpP/eVqZdzeY5EWKburVVwp52
	 tor+lT0dbhTZxdI9byaOo+0InJ5Jnx6TrsndLQDvo0uwmYYAhIpC1A8s/VXNERz4oF
	 N+kRPSTpQrhyvStugxBkd2wwOj2WEHLjk9Kn7K/Q4m5YumJY9SfrY7woT6LYhfz+S3
	 NNkcSbUmG+aAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1380B60AA1;
	Thu, 26 Nov 2026 20:34:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D147311
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:34:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5342440A01
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:34:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P0yWtlyy-lrQ for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 20:34:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8620A405C8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WA4VDw8k
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8620A405C8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795725283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GuGdWNAUUamhyAvRSygUN7vwSXLvTQpL3xsjy8x1md8=;
 b=WA4VDw8k6AZnZTNE+zCqj/a2Dw1Y2Y/wBloJyPg4GxD0ds4yV4nQJCV8h2JD1KSq/EMEde
 HcvFf8u/b++4pjh7Q8OCVSc7le9vPsmTBrOug65ON5Uc4hbZmZTvmP2wcv34HlzBuKop2/
 LAxmaEhbVsmRemXb8vio1LFYH7cKeXE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-SRtIgN-oM0KY7fSWuT2aaA-1; Thu,
 26 Nov 2026 20:34:38 +0000
X-MC-Unique: SRtIgN-oM0KY7fSWuT2aaA-1
X-Mimecast-MFC-AGG-ID: SRtIgN-oM0KY7fSWuT2aaA_1795725275
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB9D8195604C; Thu, 26 Nov 2026 20:34:35 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8E6B81801971; Thu, 26 Nov 2026 20:34:29 +0000 (UTC)
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
Subject: [PATCH RFC net-next 17/19] dpll: require a registered DPLL for pin
 registration
Date: Thu, 26 Nov 2026 21:32:29 +0100
Message-ID: <20261126203231.934632-18-ivecera@redhat.com>
In-Reply-To: <20261126203231.934632-1-ivecera@redhat.com>
References: <20261126203231.934632-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: JUqYWeALyGsenDzvChCiMXCv2GgsgvQJ7XyZtyYJRCU_1795725275
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

Since commit 33f016b23a21 ("dpll: fix NULL deref in dpll_device_ops()
during teardown race"), dpll_pin_register() accepts a DPLL without
registrations unless the pin has measured_freq_get, and
dpll_pin_on_pin_register() registers a pin with the DPLLs of the parent
pin without a check.

The drivers register a DPLL before its pins. Reject a DPLL that is not
registered in dpll_pin_register() before its ops are requested, and a
parent pin with such a DPLL in dpll_pin_on_pin_register(), and document
the order.

The pin paths keep the tolerance for a DPLL without registrations from
that commit. On E810, ice registers the recovered clock pin of a PF
without the CGU under the input pins of the PF with the CGU, and so with
its DPLLs. The pin stays registered with them when that PF goes first.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 Documentation/driver-api/dpll.rst |  2 ++
 drivers/dpll/dpll_core.c          | 17 +++++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
index bc34fc83882fac..75ebed0bb95e96 100644
--- a/Documentation/driver-api/dpll.rst
+++ b/Documentation/driver-api/dpll.rst
@@ -634,6 +634,8 @@ of pin callbacks, and private data pointer for calling them:
 - dpll_pin_register() - register pin with a dpll device,
 - dpll_pin_on_pin_register() - register pin with another MUX type pin.
 
+A dpll device is registered before its pins.
+
 Notifications of adding or removing dpll devices are created within
 subsystem itself.
 Notifications about registering/deregistering pins are also invoked by
diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index e199342652d163..af61c4882c2b6f 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -925,7 +925,7 @@ __dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
  * @priv: pointer to private information of owner
  *
  * The @dpll and the @pin must have the same owner, they must be created with
- * the same module and clock_id.
+ * the same module and clock_id. The @dpll must be registered.
  *
  * Context: Acquires a lock (dpll_lock)
  * Return:
@@ -951,9 +951,13 @@ dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 
 	mutex_lock(&dpll_lock);
 
+	if (ASSERT_DPLL_REGISTERED(dpll)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
 	dev_ops = dpll_device_ops(dpll);
 	if (WARN_ON(ops->measured_freq_get &&
-		    (!dev_ops || !dev_ops->freq_monitor_get ||
+		    (!dev_ops->freq_monitor_get ||
 		     !dev_ops->freq_monitor_set))) {
 		ret = -EINVAL;
 		goto out_unlock;
@@ -1039,7 +1043,8 @@ EXPORT_SYMBOL_GPL(dpll_pin_unregister);
  * Register a pin with a parent pin, create references between them and
  * between newly registered pin and dplls connected with a parent pin.
  * The @parent and the @pin must have the same owner, they must be created
- * with the same module and clock_id.
+ * with the same module and clock_id. The dpll devices of the @parent must
+ * be registered.
  *
  * Context: Acquires a lock (dpll_lock)
  * Return:
@@ -1073,7 +1078,11 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 	if (ret)
 		goto unlock;
 	xa_for_each(&parent->dpll_refs, i, ref) {
-		ret = __dpll_pin_register(ref->dpll, pin, ops, priv, parent);
+		if (ASSERT_DPLL_REGISTERED(ref->dpll))
+			ret = -EINVAL;
+		else
+			ret = __dpll_pin_register(ref->dpll, pin, ops, priv,
+						  parent);
 		if (ret) {
 			stop = i;
 			goto dpll_unregister;
-- 
2.56.1

