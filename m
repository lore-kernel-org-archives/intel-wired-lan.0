Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A383606A682
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 20:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=gQFohhsR;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SDoKYyeQ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F346A60A68;
	Thu, 26 Nov 2026 20:33:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KbMEomdm9S-t; Thu, 26 Nov 2026 20:33:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6A9A160AF4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795725219;
	b=qbSJdDTYQd2zoslhTzOSmch83S4PJzetprpXf9j+nRzyTgSHAcc+38Xe5HKXY1GclL3R
	 qnks7/I2pFIpkBfLuzwCv04ikBCCiHbLWf1G3t8Atw9SvOMLaMXaqZzT3XkucGUQnuumO
	 QIR/ZMkDIDQXR7fPWheRXBEs1btYJBh1ceqEiN8U8T5YcU1jixZ4wxC+Ms6xVZUhM3DTW
	 ScpKvHVrUpkqgwnKT6uBCkXtPDOUQlhD3I84cTyefVwEdmRZnfbKfEbYbX9iyOHwWYpaN
	 R3S4hMwK3oAliI+tBoAIGfrXU8IEQkEMW5I021DxXFaUomBWx4Z5xYDoKzdmxInMwwg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795725219;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YNczEMn85iEzJ9tHP2sIt8DhX+H62qmfbpLilMNh1DQ=;
	b=cXONnDbldDZhDqedP0sTmnuzfXqIdTgGbAZdi/3eE3fOnpVxXQmqG8zSaVZ1Qae9LtBi
	 2qi8ztwom5RRvvTKxBTRf2Ig3iW6SYcNnKSSxSZdYSw/S67OXKZ+WHUgD0+wjGlOjnvmj
	 /c5TN8iuNV3+n7pbz4oA0sLMZj5u3/LJrUj/GGicON81EOGHzK5KKppJiwdoZim6iN/9G
	 M3EqW4S/D+bwE3MwlQgXGPpCvBco2CwZRukEkdrEUNxVcWVbHkPp8ZhMHSaOgLTTHYLUP
	 zzCpyIUzYm97A4aSUwOv0f3XiHo3b/L0cgg9ni7bljNbWexUPaQV7D9zohgoCQRNtZA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795725219;
	bh=YNczEMn85iEzJ9tHP2sIt8DhX+H62qmfbpLilMNh1DQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gQFohhsRHWH/mFHUm2G8HNny90nZAHLo36b7F8qk6SjZJtsNHgA5gFTQqPnTLyyuh
	 McUSArWhIxxQRrp9k8nKsL0VPG6A1Cm5ZotekHQ+8WmvGk7ewYcKyRIWlPvSfZs0V7
	 Okj1sywTcf++KKZAEXu5eqB3BQI/rrJY8u5TQGJjo1g1LCca911xktYCdr94m3ydrV
	 xXBOsB4OwoXP3UsmOUY26tmehr+oWuJChv8jESzlkUFs/YiM01vRj52y7Jo0kzs2G6
	 pRuVXETF0ErRA3OXZzdaxHZ3y60jcL5UQ8mPD1tVWnUOPhOLjTF3ASn8LfKuSp17zm
	 onprjUi8AuD+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A9A160AF4;
	Thu, 26 Nov 2026 20:33:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B1E3A311
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:33:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A383980BC0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:33:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VP1-mbBiYv0V for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 20:33:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E23B180BB9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SDoKYyeQ
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E23B180BB9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795725215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YNczEMn85iEzJ9tHP2sIt8DhX+H62qmfbpLilMNh1DQ=;
 b=SDoKYyeQ15sPbK3ubezoBYzujj7MwVWRhUlKmC+320mvHJQePXbx9C4az7lixzCw0EWr8w
 2zaaAT6en4Nfev4FzOYo/iX6mueoIV0bjACQCtRZJq7kBxGWdVxfAe7/OCDzq3nfl6Hywj
 3cmRvzcV4wBhxc1r32iN3os22/jzhi0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-C6c1jGXPN4mtFHbqkoWlpQ-1; Thu,
 26 Nov 2026 20:33:31 +0000
X-MC-Unique: C6c1jGXPN4mtFHbqkoWlpQ-1
X-Mimecast-MFC-AGG-ID: C6c1jGXPN4mtFHbqkoWlpQ_1795725208
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 93432195605F; Thu, 26 Nov 2026 20:33:28 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 037F51801A6D; Thu, 26 Nov 2026 20:33:21 +0000 (UTC)
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
Subject: [PATCH RFC net-next 07/19] dpll: register pins only with a DPLL of
 their owner
Date: Thu, 26 Nov 2026 21:32:19 +0100
Message-ID: <20261126203231.934632-8-ivecera@redhat.com>
In-Reply-To: <20261126203231.934632-1-ivecera@redhat.com>
References: <20261126203231.934632-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: BRhfy9krJwYowl1ph0Zf599XYV7cjjkC2X4fsmdhFIc_1795725208
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

Commit c191b319f208 ("dpll: allow registering FW-identified pin with a
different DPLL") allowed a pin with a firmware node to be registered
with a DPLL of another owner. Its only user was ice on E825, which now
links its own pins with the zl3073x pins instead.

Require the same owner for every pin again and document the rule.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 Documentation/driver-api/dpll.rst |  8 ++++++--
 drivers/dpll/dpll_core.c          | 12 ++++++------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
index 7b083a59f0122d..90c88fcf21b385 100644
--- a/Documentation/driver-api/dpll.rst
+++ b/Documentation/driver-api/dpll.rst
@@ -350,8 +350,12 @@ bound to only one other pin at any given time.
     ``DPLL_A_PIN_STATE``         state of Reference SYNC connection
   ============================== ==========================================
 
-Pin links
-=========
+Pin ownership and links
+=======================
+
+The owner of a dpll device or a pin is identified by the module and the
+clock_id passed to dpll_device_get() or dpll_pin_get(). dpll_pin_register()
+accepts only a dpll device of the same owner as the pin.
 
 A pin represents a pad of the device whose driver registers it. When the
 board connects a pad of one device to a pad of another one, for example an
diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 7fd84b0e90e993..57eb4ff2c320e5 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -983,6 +983,9 @@ __dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
  * @ops: ops for a dpll pin ops
  * @priv: pointer to private information of owner
  *
+ * The @dpll and the @pin must have the same owner, they must be created with
+ * the same module and clock_id.
+ *
  * Context: Acquires a lock (dpll_lock)
  * Return:
  * * 0 on success
@@ -1015,13 +1018,10 @@ dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 		goto out_unlock;
 	}
 
-	/*
-	 * For pins identified via firmware (pin->fwnode), allow registration
-	 * even if the pin's (module, clock_id) differs from the target DPLL.
-	 * For non-fwnode pins, require a strict (module, clock_id) match.
+	/* A pin of another owner is connected by a link, see
+	 * dpll_pin_link_add().
 	 */
-	if (!pin->fwnode &&
-	    WARN_ON_ONCE(dpll->module != pin->module ||
+	if (WARN_ON_ONCE(dpll->module != pin->module ||
 			 dpll->clock_id != pin->clock_id)) {
 		ret = -EINVAL;
 		goto out_unlock;
-- 
2.56.1

