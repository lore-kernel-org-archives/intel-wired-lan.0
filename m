Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B92860A260C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Nov 2026 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=pSW65Mo8;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gMQ4FYzH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F7DA81456;
	Wed, 11 Nov 2026 16:41:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IznrViOpmW-t; Wed, 11 Nov 2026 16:41:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7A84081499
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794415294;
	b=pC3J+91dUiNCKzzSCLkvL2JvyzOlzZBD2lJaXKn6j+Nnnj5pW27j7T6PBbnRYgxgbcDe
	 iOzH72k7pXXqDt7ul+m+fJYzD4HwgAr8do1s2p9ziTUiHbih9xhd8nmxuWcJXGT3xFIPf
	 nfRFAV6f1zPisxqvT4+41EsN+Nifh5qf6hIyORXPSo8GQzxbk5CKrUIJ7FOBP2Z/Q3+ll
	 xxRLmRVzSb5/8lD2oMy4cIox4ctiDGeoIPCW2MKez2r6vWdwu8jEn3dVlL/EyHSVJ5aBe
	 /aPdcHve6TaWhEq9zj+oj95XQx/xiCvvayfg2Zjv3dh+pre/w7tJE+tGsVkJirwPb2Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794415294;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TC/qzi0GwbwJRPe4iytsw8ARC/xSRyQXvSanD2vms5g=;
	b=so3Ds0e2nc0oe74H9kfj1WeCaxs7/T0vOM/R0UXDzWeblIuhoigO+Yg70+U1RO1ibAeB
	 k7+kVJ5Kza6m93k6f1cr4boZRLbiLv/bKNPVgNVPcLhMDrkHuQL8F7qPLh5qmqo1zYPSw
	 nVvh/M5zs4NEh6g6rSebEYJrid1v7U7aA0RIHd8DXR7JutX7svZKAtDJYHkIkYtg8tix+
	 voBPIIHmBUmOxWb6OFp9wl/GTvDx1hN4R1bB7quh2UBKhqAHU+mjGgKmu47FRS/Ad/4HR
	 nxmcwp0NBOnCXcl1uBkV6DPAVI7AFFMRjL2aNSJh0hmk64KXTrFtbf0rd181uCu4aYw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794415294;
	bh=TC/qzi0GwbwJRPe4iytsw8ARC/xSRyQXvSanD2vms5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pSW65Mo8XhMqSNROxvCkTcxWYK3CLTBgmMBs+TpkBQlF7DNcPVFQi/93kYSwYh1IA
	 ybGxkpYJoyrUZn197lG82+PK3+TLUhdJV5DimhE49pnpdhILMf4HCusxLgEyKtlH0Z
	 hpg/kkAndXuYokdTOcHrJNdSFcmLBP0psi+jn9rFoR3up3k1yovLCdLQspICRJ++7D
	 KuzdJQCuBynFl9wjRGkH1tUayt9wNKtq5igoj5yBtlJ38I9kc2se1vkA9o0s1227Kf
	 10w/sWQluHk31VXR5G8M/agd+ZBJtNdNNU9y1KEdoZFpVdLHzlGP0s6gWFjwGPpqWh
	 E9BQdWSAd9xrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A84081499;
	Wed, 11 Nov 2026 16:41:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C613731
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 16:41:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7E05A4016D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 16:41:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5PWMt_MgSgqu for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Nov 2026 16:41:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org ABBA14006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gMQ4FYzH
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTP id ABBA14006F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 16:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794415291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TC/qzi0GwbwJRPe4iytsw8ARC/xSRyQXvSanD2vms5g=;
 b=gMQ4FYzHdubnrarcQYHqFUbnymZxm+G2siBkT24FF9maCNH6yJQbahpmloAorbylEULjFB
 jt6CyhNnqI61VGmrdMYERFU9lWYYhjpB4BYYR72Ab9HKsZqt1zrxjdYRMykb3nohjSQtx9
 FzD1ETOCcMKKjk6xwkYFmsSMNpJCPvg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-QeALwB0-N6OvZSh1l3qmTg-1; Wed,
 11 Nov 2026 11:41:27 -0500
X-MC-Unique: QeALwB0-N6OvZSh1l3qmTg-1
X-Mimecast-MFC-AGG-ID: QeALwB0-N6OvZSh1l3qmTg_1794415284
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 337721955DE4; Wed, 11 Nov 2026 16:41:24 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 47E5A410; Wed, 11 Nov 2026 16:41:18 +0000 (UTC)
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
Subject: [PATCH net-next v2 9/9] dpll: document locking rules
Date: Wed, 11 Nov 2026 17:40:20 +0100
Message-ID: <20261111164021.273409-10-ivecera@redhat.com>
In-Reply-To: <20261111164021.273409-1-ivecera@redhat.com>
References: <20261111164021.273409-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: Dr3ITt2Uzl8fx4seM3n90IxS85JHwlrFGjLKEEEpxIU_1794415284
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

Describe the lock levels of the subsystem, which domain a callback runs
under and the rules device drivers have to follow.

Reviewed-by: Petr Oros <poros@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
Changes in v2:
- Added a rule for reference sync pairs (Sashiko)
- Rules 1 and 3 also forbid waiting for a work item that notifies
  (Sashiko)
---
 Documentation/driver-api/dpll.rst | 48 +++++++++++++++++++++++++++++++
 drivers/dpll/dpll_core.c          | 13 +++++++++
 2 files changed, 61 insertions(+)

diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
index 7c117ae37cc1bc..9cc6a912c58913 100644
--- a/Documentation/driver-api/dpll.rst
+++ b/Documentation/driver-api/dpll.rst
@@ -675,6 +675,54 @@ In the error path we have to rewind every allocation in the reverse order:
 
 More complex example can be found in Intel's ICE driver or nVidia's mlx5 driver.
 
+Locking
+=======
+
+The subsystem uses two levels of locks, always taken in this order:
+
+- ``dpll_lock`` protects the topology of dpll devices and pins and their
+  lifetime. Functions changing the topology, for example dpll_pin_register(),
+  take it for write and send the create and delete notifications under it.
+  Netlink requests, each part of a dump and change notifications take it for
+  read for their whole duration.
+- A domain lock serializes driver callbacks. All dpll devices and pins created
+  with the same module and ``clock_id`` belong to one domain, in practice to
+  one chip or card.
+
+A netlink request addressing a device or a pin by its ID holds the domain lock
+of that object from start to end. A notification holds it while its message is
+built and sent, so messages of one object are sent in the order they were
+built. Only one domain lock is held at a time, so domains have no lock order,
+and callbacks of different domains can run concurrently.
+
+Callbacks of a dpll device run under the domain of the device. Callbacks of a
+pin run under the domain of the pin, whichever driver registered them:
+
+- A driver registering a pin of another driver with its dpll device has these
+  callbacks serialized with the driver that created the pin, not with the other
+  callbacks of its device, so it has to protect the state they share by itself.
+  A callback stuck in such a registration stops the domain of the pin.
+- The parent pin of a pin registered with dpll_pin_on_pin_register() and its
+  dpll devices can belong to another driver, so the callback must not
+  dereference their private data.
+- The frequency monitor belongs to the dpll device, so only callbacks of a pin
+  of the same domain registered with dpll_pin_register() can include
+  ``.measured_freq_get``.
+- The reference sync callbacks of a pin get the private data of the other pin
+  of the pair, so both pins of a pair added by dpll_pin_ref_sync_pair_add()
+  have to belong to one domain.
+
+Device drivers have to follow these rules:
+
+- A callback must not call dpll_device_change_ntf(), dpll_pin_change_ntf() or
+  any function changing the topology, nor wait for a work item that calls them.
+- A callback notifies about objects of the domain it runs under with
+  __dpll_device_change_ntf() or __dpll_pin_change_ntf(). Other objects have to
+  be notified from a context that holds no domain lock, for example a work item.
+- A driver must not call dpll_device_change_ntf(), dpll_pin_change_ntf() or any
+  function changing the topology, nor wait for a work item that calls them,
+  while holding a lock that its callbacks take.
+
 SyncE enablement
 ================
 For SyncE enablement it is required to allow control over dpll device
diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index a73abb0772cc6b..9a0843bba184af 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -932,6 +932,10 @@ __dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
  * @ops: ops for a dpll pin ops
  * @priv: pointer to private information of owner
  *
+ * The callbacks run under the domain of @pin. If @pin belongs to another domain
+ * than @dpll, they are not serialized with the callbacks of @dpll and @ops must
+ * not include .measured_freq_get.
+ *
  * Context: Acquires dpll_lock and domain locks
  * Return:
  * * 0 on success
@@ -1049,6 +1053,11 @@ EXPORT_SYMBOL_GPL(dpll_pin_unregister);
  * Register a pin with a parent pin, create references between them and
  * between newly registered pin and dplls connected with a parent pin.
  *
+ * The callbacks run under the domain of @pin. The parent pin and its dplls can
+ * belong to another driver, so @ops must not dereference their private data.
+ * The frequency monitor belongs to a dpll, so @ops must not include
+ * .measured_freq_get.
+ *
  * Context: Acquires dpll_lock and domain locks
  * Return:
  * * 0 on success
@@ -1137,6 +1146,10 @@ EXPORT_SYMBOL_GPL(dpll_pin_on_pin_unregister);
  *
  * Once pins are paired, the user-space configuration of reference sync pair
  * is possible.
+ *
+ * The reference sync callbacks of each pin get the private data of the other
+ * one, so both pins must belong to one domain.
+ *
  * Context: Acquires dpll_lock and domain locks
  * Return:
  * * 0 on success
-- 
2.56.0

