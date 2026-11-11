Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C600606A33B
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Nov 2026 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=5vteCbBy;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gHdx0kW0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0764D813AA;
	Wed, 11 Nov 2026 16:40:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E2zzmuwypOFg; Wed, 11 Nov 2026 16:40:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 53681813AD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794415249;
	b=fjVEZlqk34OeMNRz/OeouFmyccONv3xyISJzySPuR181IqJFM41UoG7xKisWw0Qg91eN
	 KcDxR4Oyyyeqp7fbgEExaWs6vtckCE+UMcEE9rEByP3moFHq1W+rL8IQWioLWHBlNEgdz
	 qNNEL6vJI6TnrwiWVPgQ0ttPz3FwyH58+DRbco7ug/ZQWcW81VKgUlHQi6eGrQ6blSHPN
	 wSZkFWO3l9Km8hi2CVA2vpGc4grXR5y1Tx6rBk9pADVv8k14p8O/jTavIIyCh0MqAs8y+
	 KLXrVTmI1kskq42IfUZfl9qVHv51cBUMoHmANYEArCvSd8nf8dbSx009KmSoR01M1HQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794415249;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4UXdJhb2DeSA3nX65h3c9Ro7JbdiHIOP89nBTrO6qaY=;
	b=U1vkXzZ/mhYXx3N4Ya2mqYd4h6vlEgK/tddXPIhmgAFdi/9OA5z5e8BYg+qTlEXl/uv6
	 CA+5tGS5abf3fjFK4Dtv7BiCTKrUPLsWblEFOiM3cOmb4k3UyUlBGeE8ULDlDmBI1xwwd
	 1FJTh9CxuPZFHSnP7G6vMbFwqSueaum8ampEUmxD8ayUsFBuqPqZzZrThvGA4UnbTAWIc
	 +8WN7s2lrVq5AQl06Un9kwbm0VrtNOJUuB673Bo9TEQn4Lxq6ZEDYbu/5mL28q9bnIpNL
	 Eow3x++1PuocTlv7g2PEYBkHi7GK4bPl2xZEUztvcflzD15s+4YLFEH6RtnqfU4Q3UQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gHdx0kW0;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794415249;
	bh=4UXdJhb2DeSA3nX65h3c9Ro7JbdiHIOP89nBTrO6qaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=5vteCbBywC8kLW6JWd1XBZ/1jwv8cQmN7FydlWFE2zZ7EuYqgAVgAOyRb1hRD767A
	 E+xTEEzd0HM1SVHb1/mJGkSbWEqg9m6is1S7PYv+2o/0Im9AO53nOcq2LRUY+DnZ3Q
	 ulxGYiSmjrnem4Jn0XKnGzVBPzpURG8i2rgxiSGvzyE7Xyc0sBGK4bFyrPoRUXF5yk
	 jQ/KeWWgDxV5YHaYnwGYjC2wxVP8CZA9Ui740eUW4z8EQ3AOsdM1QItHlVDgwy33k8
	 /kY/YUSJEdBwUgmrTY/PWIEqTwVPVwW5NTvRx8ANdNvJUyT6AvpQiJf389MCOAMj+O
	 7ZeJtjWHyHR+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 53681813AD;
	Wed, 11 Nov 2026 16:40:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D4FB32FE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 16:40:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BAB17813AA
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 16:40:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f2Yoi54ZfM-E for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Nov 2026 16:40:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0377E813AD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gHdx0kW0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0377E813AD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 16:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794415245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4UXdJhb2DeSA3nX65h3c9Ro7JbdiHIOP89nBTrO6qaY=;
 b=gHdx0kW0hQOFQOKO1omkEfcBf6gdvSr2Hx40bL/EV74BVkwcJm1PCozPy9Aw/xz86CGxT0
 i+aPnmWXZ3RiskNzeYTGqSAh3F0QzCj8uP7kcsgFFlNqCgBB3TzqCqGDiHDiSOOe1UZiKD
 +3viRt+a0SuxNvL3YcII8yYlZ/EYBtE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-8oyxtDaRMGC08USG0k2hVg-1; Wed,
 11 Nov 2026 11:40:38 -0500
X-MC-Unique: 8oyxtDaRMGC08USG0k2hVg-1
X-Mimecast-MFC-AGG-ID: 8oyxtDaRMGC08USG0k2hVg_1794415235
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0ABF4180061D; Wed, 11 Nov 2026 16:40:35 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 15DB3410; Wed, 11 Nov 2026 16:40:28 +0000 (UTC)
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
Subject: [PATCH net-next v2 1/9] ice: dpll: notify TSPLL lock status from the
 periodic work only
Date: Wed, 11 Nov 2026 17:40:12 +0100
Message-ID: <20261111164021.273409-2-ivecera@redhat.com>
In-Reply-To: <20261111164021.273409-1-ivecera@redhat.com>
References: <20261111164021.273409-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: 3fuP7H7qRkMdvRth_DV5iyQJqd-NHboxw5rWF56I0Es_1794415235
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

ice_dpll_tspll_state_on_dpll_set() notifies the TSPLL device from a
callback of the TIME_REF pin. This pin belongs to an external DPLL and the
DPLL core is going to run its callbacks under a lock of the pin's owner,
which does not cover the TSPLL device.

Only update dpll_state in the callback, so a device get reports the new
state right away, and leave prev_dpll_state to
ice_dpll_periodic_work_e825(), which then sends the notification. It now
arrives up to 500 ms later and after the reply to the request.

Refresh dpll_state on every run of the work, as the state written by the
callback can be transient and the lock status can return to
prev_dpll_state before the next run. No notification is sent in this case.

Reviewed-by: Petr Oros <poros@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
Changes in v2:
- Merged the two comments in ice_dpll_tspll_state_on_dpll_set() (Sashiko)
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index ade1fb3dd06743..0877827a6521cc 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -2914,7 +2914,6 @@ ice_dpll_tspll_state_on_dpll_set(const struct dpll_pin *pin, void *pin_priv,
 	struct ice_dpll_pin *p = pin_priv;
 	struct ice_pf *pf = p->pf;
 	enum ice_clk_src clk_src;
-	bool changed = false;
 	struct ice_dpll *tp;
 	int ret;
 
@@ -2939,23 +2938,16 @@ ice_dpll_tspll_state_on_dpll_set(const struct dpll_pin *pin, void *pin_priv,
 
 		new_state = ice_dpll_tspll_lock_status_get(pf, false);
 
-		/* Sync the cached lock state to what we just observed from HW
-		 * so ice_dpll_periodic_work_e825() (cached path) does not emit
-		 * a spurious UNLOCKED notification between now and the next
-		 * PTP monitor tick.
+		/* Sync the cached lock state to what we just observed from HW.
+		 * ice_dpll_periodic_work_e825() reads it (cached path),
+		 * compares it with prev_dpll_state and sends the notification.
+		 * dpll_state lets a device get report it right away.
 		 */
 		WRITE_ONCE(pf->ptp.tspll_locked,
 			   new_state == DPLL_LOCK_STATUS_LOCKED);
-
-		if (tp->prev_dpll_state != new_state) {
-			tp->dpll_state = new_state;
-			tp->prev_dpll_state = new_state;
-			changed = true;
-		}
+		tp->dpll_state = new_state;
 	}
 	mutex_unlock(&pf->dplls.lock);
-	if (changed)
-		__dpll_device_change_ntf(tp->dpll);
 	/* TSPLL reconfiguration may complete before lock is reacquired.
 	 * PTP periodic monitoring tracks and restores the final lock state.
 	 */
@@ -3372,8 +3364,8 @@ static void ice_dpll_periodic_work_e825(struct ice_pf *pf)
 	mutex_lock(&pf->dplls.lock);
 	new_state = ice_dpll_tspll_lock_status_get(pf, true);
 
+	tp->dpll_state = new_state;
 	if (tp->prev_dpll_state != new_state) {
-		tp->dpll_state = new_state;
 		tp->prev_dpll_state = new_state;
 		changed = true;
 	}
-- 
2.56.0

