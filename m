Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309F9606A690
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 20:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=UGsU04fl;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L5aNt8XV
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1106540A0A;
	Thu, 26 Nov 2026 20:34:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0PbfnNfO_Bfl; Thu, 26 Nov 2026 20:34:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 45A56409EB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795725273;
	b=r7EjAI5IRdOccZ11VZwn1N/cOEE/z8DOdOzYqeF/uH27eFFQLmvzOmNNeBV5iX/QSYeU
	 GoTzZb+MgvOLCNx9rVnWTxYTckkUl21lhB5XbI+TIXIRxC1AuRl/qTYvYDVpfRiX6J3Eq
	 LosOXN7mc7NmpWLqXTwNOD8/FUCDqnnIrxczZ9boHUXayhtpSD0NbGvEjjVu67cf5q6Ms
	 XTqTTTcfX+DfZENQGn/TEY9S/k55jMwLS3DTDMz93c08OOcYUCCOQYCbL4HW5m9uWU+EI
	 itNPy00JUDV1JKqcBgTtqY4ciUUXN19TO2fRfv/qOT9XnlCjFkV+cfGJ1J3P/9tzoVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795725273;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TpW/aO2pRUW8vCTqx+Lq5/2TghrPoKWcvdPUdPz/mZw=;
	b=J+KkLt5r6XT94gejGUQ8AfgP+ImnrNKbRYVUqIRtSqE+OKSiM/wMhfx/I9OjWjDOswuM
	 ZFE31mz15ck2eDKyVqh2DOrJnP5E21pqib5JQtw14o5UHVMFTT3aw3ynbIE2TGeeDwlQi
	 DvIeLcS4F2YZbgV4vO6SvOYF+C0sYnEe2PJWTIpzEzMJwjZ9QQXGsdz3E+sN/bQV01o6l
	 D4kkRdNsHkeN2iQi7yXZsUsVuPo59u4ED7wSQeVJ+sva/ucKSkMxRgFMgQ2/ctkmz/tKI
	 luilP2qTmPbjq/MUzUMh44cpq16RW6QBxYLEuR2Ub4NNNbT3T4+XTf46EYqHwW7Jb0w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795725273;
	bh=TpW/aO2pRUW8vCTqx+Lq5/2TghrPoKWcvdPUdPz/mZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UGsU04fljH5IHsz/nzGzd5pgZhwTc+0xdWrJHWY1cddhqz8w9+vp8bqfDqq0SQkZC
	 R0RSosnMXnYswIYKGnVM60hK4yMwZNcQ9nUm50P2s6DVnEur+1iA8T3KciYSMMyp7F
	 oGJRCCMIvpLD/ANcxjRbv0MW2rZV8tAeO/+Yw3gkyhjIFP8Du2hpJSbmccdsTr2M6N
	 jLdv+cFSonVjSG5RXTiKnZ/FErKwl94hi0VQyMQXVMj9YSKlJuJJMmExN8v7MGRtEg
	 79xLS5PZWYAMZNmA8n84D6aEm+Su5hDh1YOpk5yam209RXhP+i8dV2atwqQrgpK654
	 JtvjoreiphBgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 45A56409EB;
	Thu, 26 Nov 2026 20:34:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E5B41AB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:34:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5468F810DE
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:34:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w5iMPzF7aL75 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 20:34:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 76CA1810D3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=L5aNt8XV
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 76CA1810D3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795725269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TpW/aO2pRUW8vCTqx+Lq5/2TghrPoKWcvdPUdPz/mZw=;
 b=L5aNt8XVEQzTdowGHUv15d5ZX6X+UtCPO9CJxxNgHoLvfaZd6LcaClMERp6xaSMHPqn2ng
 6CYX2e/wAavZ9idoX6yTmGUQWhk9SDCX2TgAaQ8P64TtMhZ2zWBqKhpeCvcIuGN5uJ1zq8
 f1QfOP7tNkQ7NxCTYT82rG85NCgkV2A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-xc2boAwVMticbVqR9qHsJQ-1; Thu,
 26 Nov 2026 20:34:25 +0000
X-MC-Unique: xc2boAwVMticbVqR9qHsJQ-1
X-Mimecast-MFC-AGG-ID: xc2boAwVMticbVqR9qHsJQ_1795725262
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A769D1955F74; Thu, 26 Nov 2026 20:34:22 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6A41A1801977; Thu, 26 Nov 2026 20:34:16 +0000 (UTC)
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
Subject: [PATCH RFC net-next 15/19] dpll: register pins only with a parent pin
 of their owner
Date: Thu, 26 Nov 2026 21:32:27 +0100
Message-ID: <20261126203231.934632-16-ivecera@redhat.com>
In-Reply-To: <20261126203231.934632-1-ivecera@redhat.com>
References: <20261126203231.934632-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 0AQ66_bXPdtdxbYaA7MC_9UhGX3ETp4kIZiP7R2Cyq4_1795725262
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

dpll_pin_on_pin_register() accepts a parent pin of another owner and
then registers the pin with the DPLLs of that owner. Its only user was
ice on E825, which now describes its recovered clock muxes with its own
DPLL devices linked with the zl3073x pins.

Require the same owner for the parent pin, as dpll_pin_register() does
for the DPLL, and document how to describe a mux in front of an input of
another device.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 Documentation/driver-api/dpll.rst | 7 +++++--
 drivers/dpll/dpll_core.c          | 9 +++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
index 90c88fcf21b385..bc34fc83882fac 100644
--- a/Documentation/driver-api/dpll.rst
+++ b/Documentation/driver-api/dpll.rst
@@ -355,7 +355,8 @@ Pin ownership and links
 
 The owner of a dpll device or a pin is identified by the module and the
 clock_id passed to dpll_device_get() or dpll_pin_get(). dpll_pin_register()
-accepts only a dpll device of the same owner as the pin.
+accepts only a dpll device and dpll_pin_on_pin_register() only a parent pin
+of the same owner as the pin.
 
 A pin represents a pad of the device whose driver registers it. When the
 board connects a pad of one device to a pad of another one, for example an
@@ -364,7 +365,9 @@ the driver of one of them describes the connection with
 dpll_pin_link_add() on its own pin. The link names the pin at the other
 end by its firmware node, which the driver of that pin sets with
 dpll_pin_fwnode_set(). Each driver registers only its own pins and the
-drivers may probe in any order.
+drivers may probe in any order. A mux of one device that feeds an input of
+another device is a dpll device of its own driver, with the selectable
+signals as input pins and an output pin linked with that input.
 
 While both pins are registered, ``DPLL_CMD_PIN_GET`` reports the link for
 each of them with the id of the pin at the other end:
diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 7440b174c3de2b..9b48d289ec7330 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -1081,6 +1081,8 @@ EXPORT_SYMBOL_GPL(dpll_pin_unregister);
  *
  * Register a pin with a parent pin, create references between them and
  * between newly registered pin and dplls connected with a parent pin.
+ * The @parent and the @pin must have the same owner, they must be created
+ * with the same module and clock_id.
  *
  * Context: Acquires a lock (dpll_lock)
  * Return:
@@ -1097,6 +1099,13 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 	if (WARN_ON(parent->prop.type != DPLL_PIN_TYPE_MUX))
 		return -EINVAL;
 
+	/* A pin of another owner is connected by a link, see
+	 * dpll_pin_link_add().
+	 */
+	if (WARN_ON_ONCE(parent->module != pin->module ||
+			 parent->clock_id != pin->clock_id))
+		return -EINVAL;
+
 	if (WARN_ON(!ops) ||
 	    WARN_ON(!ops->state_on_pin_get) ||
 	    WARN_ON(!ops->direction_get))
-- 
2.56.1

