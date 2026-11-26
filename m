Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369D2606A337
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 20:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=IpGsWJYS;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iHF7gFg7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A21660B0C;
	Thu, 26 Nov 2026 20:33:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GV3sFb1XO-dL; Thu, 26 Nov 2026 20:33:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6201060AF4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795725227;
	b=nHCSjg4RH4h8EqumrUGrd4oKMYGOxMZhSpBga7AsJ69Si81KEPfwAhzKogpF5RhiM1Vm
	 u3B/nf/2iFlbmV2hkXOOz+z9V+cTvc4sqrZxlrFpY3Rf4u+LzXn7P4JJ8o0uPm4RpULn/
	 Vux45mPBJwUJHm5lElrzO2Tp36ShSnBveWjNk3lqmEpqVwzWpZd/CUGV8podFgpJPh6pY
	 99ugtnV+hrJfyfLpERzr6nXuwG3WiqQHiTGaqvFDpizCwcQY6fbzb/zjVyyInwzpgu8Tm
	 WDqJ6VU61M0SD1jFFZ3kW9aEwh8SmfgKLriP87/14DssZnpUPgPMiRBtLHHQ48X7gZg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795725227;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6+IvshoIOnpz5rdUCHpe36q5hslcK32E1hpH+6SscWk=;
	b=b4vNNapSxS/HIa1zoPh1VVOu1Qm5HgjJaeaWDnYw52Nyd3AVA30xc1qCEj8hd1s/lLH8
	 Wx1R5weyYOq5Nij41NsVdJboC6w6DfTm96DjWyrU1ihV5sVSm/oMUA7YtQRNI8Rugs8p3
	 eEyDCvMBsYGhuyuUa279MDV2CPRZUudQofT0Apk39ZmLG4j0xJ0i4lnGvHMO7jWtRVlzG
	 jTFshTRY+kpV1QbF1QYs0/H7z/VGfjDOY6i0EJQZu+zKCq/eDX/1H40QOoao6SXBzVVjy
	 DU/rorcoE+nWevbUb+Ch1Fl84Qjd6uxtZ7jMQZEq7bkIk7KpWVedejpXE0HW6+qJSCw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795725227;
	bh=6+IvshoIOnpz5rdUCHpe36q5hslcK32E1hpH+6SscWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IpGsWJYSZ8bf6QCGHYzqt/sdHIKVjVwb7OEBu1N/K08B7zRygZZm6/oUdOE0XL4NG
	 DnxuAHWwqjKSarP8nzmZ4l4T0h58uzeLIS8UqDjRbznx7I7kROrdYlgSs8Sf9FZPke
	 ulhsXanBP8koQBrJX3d94munJ4YunFOvZvkdKGTh8gMiDIgbJ4I/pZVU6Qe8EOw8CN
	 baVYPNxP2IbejHW6629YmLpenBblB0ReinLBoVxyW6IzSp2tPkx4sRTgG4lCc+NkhZ
	 YIBYmOPqKfwP0/SrlIxH+B47Tc4JsvvsWNG5K1eR1V7pC1GXuVO+AhFt54nIBNmCXb
	 TpE+1bIX1uhsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6201060AF4;
	Thu, 26 Nov 2026 20:33:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D5883311
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:33:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BBCCA409EB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:33:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ivizjl4Cb-HX for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 20:33:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DE4E2409E4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iHF7gFg7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DE4E2409E4
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795725223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6+IvshoIOnpz5rdUCHpe36q5hslcK32E1hpH+6SscWk=;
 b=iHF7gFg7LieIWWdatiWrJcTE1o+6ZENvdPWkYsYBJ9dJip6diQEAKaoDPO4elEAQXpsIHN
 p+6mV+rNs1rLzxxmaczDV5QzoDrkty2AiolXYRx3i5tv+Pzz34sxXwPPHBSE1c1UVknYkq
 DQCklbPSoZLaouec5f4HGcz7BO2ohcU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-HfJwxuRLNPWteVoBnAXBug-1; Thu,
 26 Nov 2026 20:33:38 +0000
X-MC-Unique: HfJwxuRLNPWteVoBnAXBug-1
X-Mimecast-MFC-AGG-ID: HfJwxuRLNPWteVoBnAXBug_1795725215
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30D2219541A6; Thu, 26 Nov 2026 20:33:35 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0195D1801977; Thu, 26 Nov 2026 20:33:28 +0000 (UTC)
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
Subject: [PATCH RFC net-next 08/19] dpll: drop the state change exception for
 pins with a firmware node
Date: Thu, 26 Nov 2026 21:32:20 +0100
Message-ID: <20261126203231.934632-9-ivecera@redhat.com>
In-Reply-To: <20261126203231.934632-1-ivecera@redhat.com>
References: <20261126203231.934632-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: KP6Wwt2vGKl-_Z6xpjbq3V9bSO8_8C4_ai_Ba66raQ0_1795725215
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

Commit 521b6d5de08d ("dpll: allow fwnode pins to attempt state change
without capability bit") let user space try to set the state of a pin
with a firmware node also without DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE.
It was needed for the zl3073x output pins that ice registered with its
TXC and TSPLL DPLLs. ice now uses its own pins, which have the
capability, and zl3073x, the only driver that sets a firmware node, gives
it to every pin whose state can be set.

Check the capability for all pins again.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_netlink.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 931ea2027cf68f..fab234553b422a 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -1328,11 +1328,8 @@ dpll_pin_on_pin_state_set(struct dpll_pin *pin, u32 parent_idx,
 	unsigned long i;
 	int ret;
 
-	/* fwnode pins may not set the capability bit upfront; let the ops
-	 * layer return -EOPNOTSUPP if the operation is unsupported.
-	 */
 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
-	      pin->prop.capabilities) && !pin->fwnode) {
+	      pin->prop.capabilities)) {
 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
 		return -EOPNOTSUPP;
 	}
@@ -1367,11 +1364,8 @@ dpll_pin_state_set(struct dpll_device *dpll, struct dpll_pin *pin,
 	struct dpll_pin_ref *ref;
 	int ret;
 
-	/* fwnode pins may not set the capability bit upfront; let the ops
-	 * layer return -EOPNOTSUPP if the operation is unsupported.
-	 */
 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
-	      pin->prop.capabilities) && !pin->fwnode) {
+	      pin->prop.capabilities)) {
 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
 		return -EOPNOTSUPP;
 	}
-- 
2.56.1

