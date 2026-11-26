Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5E7606A31C
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 20:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=J0p+Edd8;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I9uMBDRW
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3242560A68;
	Thu, 26 Nov 2026 20:33:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ao5lpmBen15f; Thu, 26 Nov 2026 20:33:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7386A60AE4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795725193;
	b=hAwFVvSub0iXjtK8fTVTAYHFRaeP2A2lXJBOleDObqcEvtoXnCwb2Aaq+0aiNQ1lJeGs
	 /1VGPDF7KPlGo1dRw/aHw0A6GH+dTfuHUNHPS91Ej+bvdn8A5nkqknBJcNqReClOmYaz2
	 cyXXfvKyXvIm8vIJv4tGNvtmVdYckN3quXiV75AvTzC5gWlvClKp45eoNz1mJyo1lxNZy
	 B6FfnYEk7Dppi3Pq4OszAkt9CjnIXZGEcye+/m7eHuiLuMSrw+RxyRijOAlJ2ZHbvif/2
	 g1Xwdy2IKB32yJS6z9QpHxU8HMILm1VhIj5DJAxdEZqlm4SpxLAO5vUMhjgeZrElG1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795725193;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-MC-Rep:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uNjlnFFHs2yc3bElpWQbMGLuA2UYQGFca2rvsSqyvPs=;
	b=btkIEJbzfvcYh+lPp0vyrGGQAf1fQVFND0cWA/VIldm242kwt2aDuiwl45oVa9zcOryC
	 Ar30CwDIaXilr5jqAIMvQ5Zi4Pih6OYiWPN1N4KssC6XFV9YXJPem5cIAdv/do93Gbt5d
	 0fA39GHYfBpC2PXJfcPEGzrzqNpZ2hrLrK8PoiXNWuMLiWRsMN+NnrXfIvDaDlM5fOHh5
	 GQ/jvYsBFzMDprVJRD5L4ycacP4WaMMCstQJVsA61qulc1DMuJAw2XnMBcbWiipRdQQOo
	 d8dyjuLTnAzCxasG6PD0A+640e1mv6B+4WbwTMB33Qqk8pEHlBNKe4I0tLJ0aMQ60KA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795725193;
	bh=uNjlnFFHs2yc3bElpWQbMGLuA2UYQGFca2rvsSqyvPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J0p+Edd8ou664E8DQfz1ZgJ4LGzTjNVeVLm+gOGCHyGW0ZVXOlF5IcoD4tn/sPQJc
	 yMTfxkp25mHWQvmxuR3Ae3Wm2cY0JFsyf3sVvJN9Z2yXqbyxvMkYQLfyOLUM4kWojB
	 8yyfTTelNyeS87figzjN9tb3pJN6PwXh/WSu+2QJIQMsStgQc1Jg26psVhkGfunGjv
	 +tD4I5FDxPX+obzsY3dRByMbAlZYxhyVl05HkLUc1B0NnMNHeHvxSB2Iznpi0ivx0S
	 qwVwSjk2DEUXzroBFeplrzHKUMPYiwIfMGhUoDhxK8Pt90nBUc2ybXPhwOBE20wSRl
	 s3l5luLBFnVDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7386A60AE4;
	Thu, 26 Nov 2026 20:33:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 038FE1AB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:33:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DDF654054A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:33:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G6RmJAg7mqDs for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 20:33:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D1E83400CB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=I9uMBDRW
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D1E83400CB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795725191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uNjlnFFHs2yc3bElpWQbMGLuA2UYQGFca2rvsSqyvPs=;
 b=I9uMBDRW0cjUERK9WG1dxujdvE+RqF0qig8buwprPB9RM/OVv8IQFCHdAz2S395MuXDIRZ
 fjhpDbYQ496eovyVDQZnX+VfNPZP4osbtD8tmrTaAejJcYmgCDt8ukSpfMD77Hx8FIs9V0
 OxrXxDB8UaZlsio/L0dwcy1MR+RLSHI=
X-MC-Rep: binary re single
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-GKHbczCUNMyitkn9CvFwZQ-1; Thu,
 26 Nov 2026 20:33:04 +0000
X-MC-Unique: GKHbczCUNMyitkn9CvFwZQ-1
X-Mimecast-MFC-AGG-ID: GKHbczCUNMyitkn9CvFwZQ_1795725181
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 244261800620; Thu, 26 Nov 2026 20:33:01 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E36641801977; Thu, 26 Nov 2026 20:32:54 +0000 (UTC)
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
Subject: [PATCH RFC net-next 03/19] dpll: notify linked pins when a pin is
 registered or unregistered
Date: Thu, 26 Nov 2026 21:32:15 +0100
Message-ID: <20261126203231.934632-4-ivecera@redhat.com>
In-Reply-To: <20261126203231.934632-1-ivecera@redhat.com>
References: <20261126203231.934632-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: a3kz5G4Y3H5en0FwsfUda0NyyZDnhdS06WDvlw2Ewec_1795725181
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

A link is reported only while the pins at both ends are registered. When
a pin gets its first registration or loses its last one, send a change
notification for every registered pin linked with it, so user space sees
the link appear and disappear at both ends.

The notifications follow the registration of the pin. A link also
disappears from the report when the last registered dpll device of
the pin goes away, so a pin with a link or a firmware node has to be
unregistered before its dpll devices, as zl3073x and ice do. The
documentation says so.

The notifications are sent from one helper, under dpll_lock like the
other notifications. The message about a linked pin is built with the
callbacks of its owner, also when another driver registers the pin at
the other end.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 Documentation/driver-api/dpll.rst |  6 ++++++
 drivers/dpll/dpll_core.c          | 24 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
index aed92693d9e604..7b083a59f0122d 100644
--- a/Documentation/driver-api/dpll.rst
+++ b/Documentation/driver-api/dpll.rst
@@ -370,6 +370,12 @@ each of them with the id of the pin at the other end:
     ``DPLL_A_PIN_ID``            id of the pin at the other end
   ============================== ==========================================
 
+When a pin gets its first registration or loses its last one, the
+subsystem sends ``DPLL_CMD_PIN_CHANGE_NTF`` for the registered pins
+linked with it. A pin with a link or a firmware node has to be
+unregistered before the dpll devices it is registered with, otherwise
+its links disappear without a notification.
+
 For example, an output of a DPLL chip wired to an input of a network
 controller::
 
diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 6c61801a293b7e..58a5a4a41a0b72 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -929,10 +929,30 @@ int dpll_pin_link_add(struct dpll_pin *pin, struct fwnode_handle *peer)
 }
 EXPORT_SYMBOL_GPL(dpll_pin_link_add);
 
+/**
+ * dpll_pin_links_ntf - notify the pins linked with a pin
+ * @pin: pin that was registered or unregistered
+ *
+ * A link is reported only while the pins at both ends are registered, so
+ * send a change notification for every registered pin linked with @pin.
+ */
+static void dpll_pin_links_ntf(struct dpll_pin *pin)
+{
+	struct dpll_pin *pos;
+	unsigned long i;
+
+	if (list_empty(&pin->links) && !pin->fwnode)
+		return;
+	xa_for_each_marked(&dpll_pin_xa, i, pos, DPLL_REGISTERED)
+		if (pos != pin && dpll_pins_linked(pin, pos))
+			__dpll_pin_change_ntf(pos);
+}
+
 static int
 __dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 		    const struct dpll_pin_ops *ops, void *priv, void *cookie)
 {
+	bool registered;
 	int ret;
 
 	ret = dpll_xa_ref_pin_add(&dpll->pin_refs, pin, ops, priv, cookie);
@@ -941,8 +961,11 @@ __dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 	ret = dpll_xa_ref_dpll_add(&pin->dpll_refs, dpll, ops, priv, cookie);
 	if (ret)
 		goto ref_pin_del;
+	registered = xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED);
 	xa_set_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED);
 	dpll_pin_create_ntf(pin, dpll->clock_id);
+	if (!registered)
+		dpll_pin_links_ntf(pin);
 
 	return ret;
 
@@ -1035,6 +1058,7 @@ __dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
 	if (xa_empty(&pin->dpll_refs)) {
 		dpll_pin_ref_sync_pair_del(pin->id);
 		xa_clear_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED);
+		dpll_pin_links_ntf(pin);
 	}
 }
 
-- 
2.56.1

