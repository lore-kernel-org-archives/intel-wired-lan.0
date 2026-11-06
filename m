Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15571606D80E
	for <intel-wired-lan@archiver.kernel.org>; Fri,  6 Nov 2026 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=AXyMj3i7;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ihesY/Ga;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ihesY/Ga;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ihesY/Ga
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ECF17406AF;
	Fri,  6 Nov 2026 12:11:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p8w95Cc2RwbS; Fri,  6 Nov 2026 12:11:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4B532406CF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793967091;
	b=FXVjt70OsResbnAN9Q95ylPcrM7TnNa7qywW9AeJWR01S6t9drJbMxu9Za+9pG4AK9dt
	 YYb837pek83Ie0nTLjkOXcWl3VWiK+Eb5xx60tEeKqYdGeOcgbqD2FVpp0WAeZKNF71Lf
	 q0MOUZi3KmApd4KElbtPtsG2lBEbQUWmi/6B1vo6fzJs2B6al8A4KJFRSSlNWHU4dhpah
	 y2LUYWntA/EsBVc/2MoIubXRnvkTWyVpMg1othjGc6sosEr3SEiNVsUDolvpySwsu3Vdd
	 kDCdOCr8QqAsUhYwLD/mU962WWO+RzzOtc/z848L9FDWAJ3igRLSYCjuelHjtmhG8Gg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793967091;
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
	bh=TVpanGIw2g4nYXoI3Lr8qP223FRJ1wL4lNRIegjpzew=;
	b=i8ccvP/bNGwVmM92HOxKvx4dUrzZmMBg+0pakVfJfUIfBxQyVsNAXsy+gps5IApKwkK1
	 9eASeA8NlhYgvMqiT2bKAOIDGVOqjY6FVtyr6zAkt13VMOpVo7B/E3d1Ap3sjX3NDW0XB
	 /C6GpBxITnyT2Nr41oxQudncCq7M7buzAuWrpZ+M+CowddzJPobiMMQhYqV+cyz/xXODZ
	 DXFMPqoIsk05Xkp8R05QfuP1eqYei9xmUj37uEDeuuKfqvoufRWBlNt4iQliajuKKR8TO
	 xP3q892kvSd2ApzEB8iIQga66IWPno/CSqh7tSW78J6KB+uno9GU7Qeg4e54VWCoq6A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793967091;
	bh=TVpanGIw2g4nYXoI3Lr8qP223FRJ1wL4lNRIegjpzew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AXyMj3i7t9OyAfi+sYmcdyi/VzDdcoDWYzD1/sCs4NIn46Qul5FPyMVo9eLayZsSL
	 Y62XPjgPMqFT2AlS8uP1WD2er+PVh13ISf0XjUXycq08Q93fE2UGFe59iSuzU8qayb
	 /+9oskElNAY2y80nCGkPN/Su7+U6xHri95TpeDuEW10AmEpTx+xufHrG1/0LIQ1FHA
	 2M2iji3zFzzRWYMCngVLqj26Ymr9Vmy+A3c4Vq3iX61JYGZCS705xc6ykomIgiXwQm
	 TPO8jjovgSleRGF2CF6hK9kXkrCB4fivyV2j16VX6gDUSX0M6n+4V6M3YZl7iK+ufV
	 Ew/ywjDSTzKbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B532406CF;
	Fri,  6 Nov 2026 12:11:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 62ADC235
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:11:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 54BD281217
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:11:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zsYiX8flDXXZ for <intel-wired-lan@lists.osuosl.org>;
 Fri,  6 Nov 2026 12:11:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 690DD81211
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ihesY/Ga; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ihesY/Ga; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ihesY/Ga
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id 690DD81211
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793967086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TVpanGIw2g4nYXoI3Lr8qP223FRJ1wL4lNRIegjpzew=;
 b=ihesY/GarOAh58R1Biga9G+Etcnw0SGKHH2cNbF15vt3wd4Vij9sN3jXxcuxtZJexlhPOI
 Im/FDSP0DxvxqynZcbtp1CzavhGo/GB3abHSsQ9qC+JCXFDGcQLdjsEpeJItXz9t4xWUfk
 Hq/IYQFFJkUfCBhMrJuKJhxmUkVNGKw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793967086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TVpanGIw2g4nYXoI3Lr8qP223FRJ1wL4lNRIegjpzew=;
 b=ihesY/GarOAh58R1Biga9G+Etcnw0SGKHH2cNbF15vt3wd4Vij9sN3jXxcuxtZJexlhPOI
 Im/FDSP0DxvxqynZcbtp1CzavhGo/GB3abHSsQ9qC+JCXFDGcQLdjsEpeJItXz9t4xWUfk
 Hq/IYQFFJkUfCBhMrJuKJhxmUkVNGKw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793967086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TVpanGIw2g4nYXoI3Lr8qP223FRJ1wL4lNRIegjpzew=;
 b=ihesY/GarOAh58R1Biga9G+Etcnw0SGKHH2cNbF15vt3wd4Vij9sN3jXxcuxtZJexlhPOI
 Im/FDSP0DxvxqynZcbtp1CzavhGo/GB3abHSsQ9qC+JCXFDGcQLdjsEpeJItXz9t4xWUfk
 Hq/IYQFFJkUfCBhMrJuKJhxmUkVNGKw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-A79W0gvCPi2jGt0n8R7u1Q-1; Fri,
 06 Nov 2026 07:11:21 -0500
X-MC-Unique: A79W0gvCPi2jGt0n8R7u1Q-1
X-Mimecast-MFC-AGG-ID: A79W0gvCPi2jGt0n8R7u1Q_1793967078
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37C4F18004BB; Fri,  6 Nov 2026 12:11:18 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E264718004D2; Fri,  6 Nov 2026 12:11:11 +0000 (UTC)
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
Subject: [PATCH net-next 10/10] dpll: document locking rules
Date: Fri,  6 Nov 2026 13:10:05 +0100
Message-ID: <20261106121005.1327603-11-ivecera@redhat.com>
In-Reply-To: <20261106121005.1327603-1-ivecera@redhat.com>
References: <20261106121005.1327603-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: trANPjY7QvBwob87W3NLHd2V-4492lRHVqUblgKMcMs_1793967078
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

Describe the lock levels of the subsystem, which domain a callback runs
under and the rules device drivers have to follow.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 Documentation/driver-api/dpll.rst | 44 +++++++++++++++++++++++++++++++
 drivers/dpll/dpll_core.c          |  9 +++++++
 2 files changed, 53 insertions(+)

diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
index 7c117ae37cc1bc..40d5037ff3bb0f 100644
--- a/Documentation/driver-api/dpll.rst
+++ b/Documentation/driver-api/dpll.rst
@@ -675,6 +675,50 @@ In the error path we have to rewind every allocation in the reverse order:
 
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
+
+Device drivers have to follow these rules:
+
+- A callback must not call dpll_device_change_ntf(), dpll_pin_change_ntf() or
+  any function changing the topology.
+- A callback notifies about objects of the domain it runs under with
+  __dpll_device_change_ntf() or __dpll_pin_change_ntf(). Other objects have to
+  be notified from a context that holds no domain lock, for example a work item.
+- A driver must not call dpll_device_change_ntf(), dpll_pin_change_ntf() or any
+  function changing the topology while holding a lock that its callbacks take.
+
 SyncE enablement
 ================
 For SyncE enablement it is required to allow control over dpll device
diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 84377f8ba16036..6ad40fb9eee855 100644
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
-- 
2.56.0

