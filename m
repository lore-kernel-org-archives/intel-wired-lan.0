Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA94606A32D
	for <intel-wired-lan@archiver.kernel.org>; Fri,  6 Nov 2026 12:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Doa7b9KB;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b60BOURW;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b60BOURW;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b60BOURW
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 732EC408FB;
	Fri,  6 Nov 2026 12:11:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G5Sulr4ENNoV; Fri,  6 Nov 2026 12:11:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 881C9406CF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793967069;
	b=WTPxwyHmJ/Ai50/hyp20WF/RO5mjuhVDT2pjJPGusUeVaRl3x/QkKxbC/XQc466rrCZW
	 mFNhU37lHoQ9lGGv6i0GwhEWvSIxMDw8dd/NTTYpl4rm72BFa7w+LRZj2dRXPr1L22C0a
	 MEwTh6Fzqb1ewkTKMqVew0pLYPUnYuZmPcs6gCTjvgcZKLLLR3/mNkIK7KzrghhF7MQBS
	 7y6wb5YDjj9NNRYKjJo/wxGMYsS6eWMl6fms+gqMjq3o7MPwNfhyS0n7n29u2UZy+toeS
	 Qb8CRQWNww7nAOSt0Hiw1E5/JtRk8I2yD/PjrETL/aMxam1yQI6PM3c2pnDTrT5n+ng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793967069;
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
	bh=TW5mE6iiOZJtS2RkCKMpELaHbzgGKLsCi9L8Y4flFK0=;
	b=R9vzg9pFpVCIE2aL/gmbK33OCFmxKXIhZw47enreBdIttg3FJqum8JJP4hDBGazM+DsJ
	 NU1CkEtTePdxDvt3nkY+awzAY5smS8yKHZbWC1eXAfMSNe/wqRp0hDST/nbNEKnhyX4hA
	 0o3PyxKStTthWPmIzo1lCpRNw43qZA7z7igq15i9ccy+tVDEsVCQNRhr3jGtRLMvBHxXp
	 iWJp+f5u2QWwwgKNU5Sm5q2Hl7wol7bqUDkiYjTI73ZesdAJIGYyxZ+ls5D9PQHuPhtMY
	 on4ndoVcd4oHwdcfHYY+F59AHPkp9youWRFMT5J9TjrOjEEeD5jPPdhFwAXAdlmbEKA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793967069;
	bh=TW5mE6iiOZJtS2RkCKMpELaHbzgGKLsCi9L8Y4flFK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Doa7b9KBYZBDerpmxXD9P2MKmIs4fr4k2PvxLvFf0aenJXL4rSfZXVx1mfnnxMQAo
	 Ta/6dpSwDK0mK3fGMFmiQrwtJp5u4M2uuH2wlHoaiBnQ+SSXOiB7PUDzXgGucGIYk5
	 mzeo2Fk8iboJiEM79G9ouoU/neTBWJRv/hI+bn6l+TbLJ4gIUD/FvmLk4POBUEy4X/
	 JvLpNhDmewqTISf71nQVy4Jne/KU93kPLz7lzE4uV2HV++0HTJp96Z/hWp/+o+khZc
	 47eqtZWQIlRA5hst/UI93H0lkZbLuGxdQAuaUPcTgyxBY6xLqwkdUaI/UqVFVcsTAW
	 6J3EiH+t089xA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 881C9406CF;
	Fri,  6 Nov 2026 12:11:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B525362
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:11:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F1F7B8118E
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:11:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XYjnpNe1nyeh for <intel-wired-lan@lists.osuosl.org>;
 Fri,  6 Nov 2026 12:11:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 04F6781211
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=b60BOURW; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=b60BOURW; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=b60BOURW
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id 04F6781211
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793967065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TW5mE6iiOZJtS2RkCKMpELaHbzgGKLsCi9L8Y4flFK0=;
 b=b60BOURWdRXGcFr0K4DGr1lAqrW3JJ9wjzQ2kCEUEVBsMVIVCLP0WhqgRebl5QC+DCRKqo
 PUWOiQDIpHGSHqVtrJJFwboZDRfK+YHZyir9EHfAGAl1Lz8FBGEL2ETYd5sOrXnSgapmzj
 HIJG0P8uPVQv0O8p9Ec8Sb3aD3HTgJo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793967065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TW5mE6iiOZJtS2RkCKMpELaHbzgGKLsCi9L8Y4flFK0=;
 b=b60BOURWdRXGcFr0K4DGr1lAqrW3JJ9wjzQ2kCEUEVBsMVIVCLP0WhqgRebl5QC+DCRKqo
 PUWOiQDIpHGSHqVtrJJFwboZDRfK+YHZyir9EHfAGAl1Lz8FBGEL2ETYd5sOrXnSgapmzj
 HIJG0P8uPVQv0O8p9Ec8Sb3aD3HTgJo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793967065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TW5mE6iiOZJtS2RkCKMpELaHbzgGKLsCi9L8Y4flFK0=;
 b=b60BOURWdRXGcFr0K4DGr1lAqrW3JJ9wjzQ2kCEUEVBsMVIVCLP0WhqgRebl5QC+DCRKqo
 PUWOiQDIpHGSHqVtrJJFwboZDRfK+YHZyir9EHfAGAl1Lz8FBGEL2ETYd5sOrXnSgapmzj
 HIJG0P8uPVQv0O8p9Ec8Sb3aD3HTgJo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-l2uv8tpePBmNyEnXVqVf7w-1; Fri,
 06 Nov 2026 07:11:01 -0500
X-MC-Unique: l2uv8tpePBmNyEnXVqVf7w-1
X-Mimecast-MFC-AGG-ID: l2uv8tpePBmNyEnXVqVf7w_1793967059
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0460E18002FE; Fri,  6 Nov 2026 12:10:59 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 37064187C368; Fri,  6 Nov 2026 12:10:53 +0000 (UTC)
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
Subject: [PATCH net-next 07/10] dpll: reject measured_freq_get for foreign and
 on-pin registrations
Date: Fri,  6 Nov 2026 13:10:02 +0100
Message-ID: <20261106121005.1327603-8-ivecera@redhat.com>
In-Reply-To: <20261106121005.1327603-1-ivecera@redhat.com>
References: <20261106121005.1327603-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: _M_mRvDuN6HzINC1Rx6uCvAoP5HVegeYd-LSQ13HmYI_1793967059
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

A message about a pin with .measured_freq_get calls .freq_monitor_get of
a dpll of the pin. For a pin of another domain, this device callback
would run outside the domain of the dpll, so dpll_pin_register() now
rejects such ops.

dpll_pin_on_pin_register() checks nothing about them. The message would
call .freq_monitor_get with no NULL check, on a dpll of the parent pin
that can belong to another driver, so reject them there as well.

No in-tree driver passes such ops. Add KUnit tests: the ops work on a dpll
of the domain of the pin, and are rejected on a dpll of another domain and
under a parent pin.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_core.c       |   6 +-
 drivers/dpll/dpll_core_kunit.c | 112 +++++++++++++++++++++++++++++++--
 2 files changed, 111 insertions(+), 7 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 8eb74682343156..84377f8ba16036 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -958,7 +958,8 @@ dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 
 	dev_ops = dpll_device_ops(dpll);
 	if (WARN_ON(ops->measured_freq_get &&
-		    (!dev_ops || !dev_ops->freq_monitor_get ||
+		    (pin->domain != dpll->domain || !dev_ops ||
+		     !dev_ops->freq_monitor_get ||
 		     !dev_ops->freq_monitor_set))) {
 		ret = -EINVAL;
 		goto out_unlock;
@@ -1065,7 +1066,8 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 
 	if (WARN_ON(!ops) ||
 	    WARN_ON(!ops->state_on_pin_get) ||
-	    WARN_ON(!ops->direction_get))
+	    WARN_ON(!ops->direction_get) ||
+	    WARN_ON(ops->measured_freq_get))
 		return -EINVAL;
 
 	down_write(&dpll_lock);
diff --git a/drivers/dpll/dpll_core_kunit.c b/drivers/dpll/dpll_core_kunit.c
index a58800eda5ff51..84c405f855d8cb 100644
--- a/drivers/dpll/dpll_core_kunit.c
+++ b/drivers/dpll/dpll_core_kunit.c
@@ -87,6 +87,7 @@ struct dt_reg {
 	struct dt_dev *dev;
 	struct dt_pin *parent;
 	struct dt_pin *notify;
+	const struct dpll_pin_ops *ops;
 	struct dpll_domain *forbid;
 	enum dpll_pin_state state;
 	enum dpll_pin_direction direction;
@@ -276,11 +277,33 @@ static int dt_lock_status_get(const struct dpll_device *dpll, void *priv,
 	return 0;
 }
 
+static int dt_freq_monitor_set(const struct dpll_device *dpll, void *priv,
+			       enum dpll_feature_state state,
+			       struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static int dt_freq_monitor_get(const struct dpll_device *dpll, void *priv,
+			       enum dpll_feature_state *state,
+			       struct netlink_ext_ack *extack)
+{
+	struct dt_dev *dev = priv;
+
+	dt_dev_enter(dev, dpll);
+	*state = DPLL_FEATURE_STATE_ENABLE;
+	dt_leave(dev->dom);
+
+	return 0;
+}
+
 static const struct dpll_device_ops dt_dev_ops = {
 	.mode_get = dt_mode_get,
 	.mode_set = dt_mode_set,
 	.supported_modes_get = dt_supported_modes_get,
 	.lock_status_get = dt_lock_status_get,
+	.freq_monitor_set = dt_freq_monitor_set,
+	.freq_monitor_get = dt_freq_monitor_get,
 };
 
 static int dt_frequency_get(const struct dpll_pin *pin, void *pin_priv,
@@ -433,6 +456,21 @@ static int dt_ref_sync_get(const struct dpll_pin *pin, void *pin_priv,
 	return 0;
 }
 
+static int dt_measured_freq_get(const struct dpll_pin *pin, void *pin_priv,
+				const struct dpll_device *dpll, void *dpll_priv,
+				u64 *measured_freq,
+				struct netlink_ext_ack *extack)
+{
+	struct dt_reg *reg = pin_priv;
+
+	dt_pin_enter(reg, pin);
+	atomic_inc(&reg->freq_gets);
+	*measured_freq = 1;
+	dt_leave(reg->dom);
+
+	return 0;
+}
+
 static const struct dpll_pin_ops dt_pin_ops = {
 	.frequency_get = dt_frequency_get,
 	.state_on_dpll_get = dt_state_on_dpll_get,
@@ -446,6 +484,13 @@ static const struct dpll_pin_ops dt_pin_ops = {
 	.ref_sync_get = dt_ref_sync_get,
 };
 
+static const struct dpll_pin_ops dt_pin_ops_measured = {
+	.measured_freq_get = dt_measured_freq_get,
+	.state_on_dpll_get = dt_state_on_dpll_get,
+	.state_on_pin_get = dt_state_on_pin_get,
+	.direction_get = dt_direction_get,
+};
+
 static const struct dpll_pin_properties dt_prop = {
 	.type = DPLL_PIN_TYPE_EXT,
 	.capabilities = DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE |
@@ -570,9 +615,9 @@ static void dt_reg_release(void *data)
 
 	if (reg->parent)
 		dpll_pin_on_pin_unregister(reg->parent->pin, reg->pin->pin,
-					   &dt_pin_ops, reg);
+					   reg->ops, reg);
 	else
-		dpll_pin_unregister(reg->dev->dpll, reg->pin->pin, &dt_pin_ops,
+		dpll_pin_unregister(reg->dev->dpll, reg->pin->pin, reg->ops,
 				    reg);
 }
 
@@ -588,12 +633,14 @@ static void dt_reg_add(struct kunit *test, struct dt_reg *reg,
 	reg->parent = parent;
 	reg->state = DPLL_PIN_STATE_SELECTABLE;
 	reg->direction = DPLL_PIN_DIRECTION_INPUT;
+	if (!reg->ops)
+		reg->ops = &dt_pin_ops;
 
 	if (parent)
-		ret = dpll_pin_on_pin_register(parent->pin, pin->pin,
-					       &dt_pin_ops, reg);
+		ret = dpll_pin_on_pin_register(parent->pin, pin->pin, reg->ops,
+					       reg);
 	else
-		ret = dpll_pin_register(dev->dpll, pin->pin, &dt_pin_ops, reg);
+		ret = dpll_pin_register(dev->dpll, pin->pin, reg->ops, reg);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dt_reg_release,
 							reg), 0);
@@ -1432,6 +1479,59 @@ static void dt_test_ref_sync_pair(struct kunit *test)
 	dt_expect_events(test, (void *[]){ ctx->p.pin }, 1);
 }
 
+/* A pin with a measured frequency must be in the domain of its dpll */
+static void dt_test_measured_freq_foreign(struct kunit *test)
+{
+	struct kunit_suppressed_warning *w;
+	struct dt_ctx *ctx = test->priv;
+	struct dt_reg *reg;
+	int ret;
+
+	dt_dev_add(test, &ctx->e0, &ctx->dom_e, DT_CLOCK_ID_E, 0,
+		   DPLL_TYPE_PPS);
+	dt_dev_add(test, &ctx->f0, &ctx->dom_f, DT_CLOCK_ID_F, 0,
+		   DPLL_TYPE_PPS);
+	dt_fwnode_pin_add(test, &ctx->x, DT_CLOCK_ID_E, DT_PIN_IDX_X);
+
+	reg = &ctx->reg_x_e0;
+	reg->ops = &dt_pin_ops_measured;
+	dt_reg_add(test, reg, &ctx->dom_e, &ctx->x, &ctx->e0, NULL);
+	atomic_set(&reg->freq_gets, 0);
+	KUNIT_EXPECT_EQ(test, dt_run(test, dt_pin_ntf, &ctx->x), 0);
+	KUNIT_EXPECT_GT(test, atomic_read(&reg->freq_gets), 0);
+
+	w = kunit_start_suppress_warning(test);
+	ret = dpll_pin_register(ctx->f0.dpll, ctx->x.pin, reg->ops, reg);
+	kunit_end_suppress_warning(test, w);
+
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+	if (!ret)
+		dpll_pin_unregister(ctx->f0.dpll, ctx->x.pin, reg->ops, reg);
+}
+
+/* A pin under a parent pin cannot have a measured frequency */
+static void dt_test_measured_freq_on_pin(struct kunit *test)
+{
+	struct kunit_suppressed_warning *w;
+	struct dt_ctx *ctx = test->priv;
+	struct dt_reg *reg;
+	int ret;
+
+	dt_on_pin_add(test);
+	dt_pin_add(test, &ctx->y, DT_CLOCK_ID_G, DT_PIN_IDX_Y, &dt_prop);
+	reg = &ctx->reg_c_m;
+
+	w = kunit_start_suppress_warning(test);
+	ret = dpll_pin_on_pin_register(ctx->m.pin, ctx->y.pin,
+				       &dt_pin_ops_measured, reg);
+	kunit_end_suppress_warning(test, w);
+
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+	if (!ret)
+		dpll_pin_on_pin_unregister(ctx->m.pin, ctx->y.pin,
+					   &dt_pin_ops_measured, reg);
+}
+
 static struct kunit_case dt_cases[] = {
 	KUNIT_CASE(dt_test_domain_sharing),
 	KUNIT_CASE(dt_test_domain_per_module),
@@ -1456,6 +1556,8 @@ static struct kunit_case dt_cases[] = {
 	KUNIT_CASE(dt_test_set_on_pin),
 	KUNIT_CASE(dt_test_device_set_ntf),
 	KUNIT_CASE(dt_test_ref_sync_pair),
+	KUNIT_CASE(dt_test_measured_freq_foreign),
+	KUNIT_CASE(dt_test_measured_freq_on_pin),
 	{}
 };
 
-- 
2.56.0

