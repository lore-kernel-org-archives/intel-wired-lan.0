Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B89606EEA9
	for <intel-wired-lan@archiver.kernel.org>; Fri,  6 Nov 2026 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=sOdhjghz;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QFnsni86
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 336DB40931;
	Fri,  6 Nov 2026 12:11:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id daanWhZqtyEZ; Fri,  6 Nov 2026 12:11:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A614A40934
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793967074;
	b=JglkNqabsqUQVHiQ+atv/pbGVHO0kd+b9r4T8yxZoFAOexCi4OKDoMybxW49TZtphn+A
	 f/pVOtkFU67yOZy+Zv4slM6Dy+d7f4JRL2D4qDPaoin9hTGim8bSgQxwaf4egAg6v5/JE
	 Kd88Fu89fErt9aGlFUcyEL4UPPQUeE1s8V39yo/Gp1EJJ6NljIy5F8KcCxySPqqORX1Ku
	 NJqneIDBr7gydBKXWUk8OvqJMiVqLMAv6GiYMFtDTr7+7dzWqQdXJ9r3HduSb+iUiXZ83
	 jQtgNAK3VkcSfIdDqyanHxaHERWxk4XTnJwx6LsnRczCHvYmjvoxroKtJ3QwlM4dFaw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793967074;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CqzvkiWtRdQoyPnwLGmA6uklwfqUTxrXWbNrA55o22M=;
	b=h6Rq6sKePEcB60jkyX22iCSamgTwfxHi6XhLg538q6kk2JhNl2npdHOjtDRILAsh2dQ5
	 Qp7N9nBxWnDe49b/eTBYGGkos20L3RWsns/SQoJXDw9noOnwgqA+V+bu9OzJx8c5A3Zge
	 VrlecdWiry+9UCx6VXrWevp2FgAVJYo0M09Ll1PmyKogBek3GAjwtSCbVlPs3rnDBl1Dv
	 sbjI7ByQmOep/e+27TL+IHNwbFpgtapSyTy3f98636eS8umELMBMpxwg0Kxmf2cIyqUrl
	 e/tJdOVfsufh5bH+2lu2hRdSv1GYnB5wDL5Rrpo2cl62SjptkNXIYF3016p1SYkwT3w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793967074;
	bh=CqzvkiWtRdQoyPnwLGmA6uklwfqUTxrXWbNrA55o22M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sOdhjghzJAfYLX52r0G8sEtmLSpcKwgD8YnoaK8f0bluaWsxRtAcQLM/TV2lfoj50
	 5sXZjS4FBCPKGrs6/1+PBbMXsTWoMti4NfWUgRZYFz+FcITyeL4tmVR05eyD0Y+fk9
	 t0p8g41CVlNapavwJ5V7Et+opszlBHlNBV6cVvkCwq+DVUlbXDizsFRLOuOidxlN5h
	 ja5UKv0PZsoMO+++1mKiSgvlM4Ak2MOOsR6On2m78IWM8ASx9sG1B70ojNUvgCwT82
	 ZZvt4hhKKdi0Oc6Qj7RQy1SvzAe1ZcQkwDG/9cPKcswHHuU/sr7K8fipv9/bBHIVW2
	 2S1D42V29Yd3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A614A40934;
	Fri,  6 Nov 2026 12:11:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 79148362
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:11:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5EB91607C3
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:11:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mG9oBF02Aymd for <intel-wired-lan@lists.osuosl.org>;
 Fri,  6 Nov 2026 12:11:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 981B26061F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QFnsni86
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTP id 981B26061F
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793967071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CqzvkiWtRdQoyPnwLGmA6uklwfqUTxrXWbNrA55o22M=;
 b=QFnsni86ntW5Y6dwJyTaXVOAJomt03fb2f2Cid/vEQ57UUfNcABVYui9RXS2sTf0Be2z/D
 Z/4YxIowDvmwRMq06BOjRh9rkQo4hhoIHcyDG5jcQZnkHiX850Ukp9+e++NmGlqxjtfVgS
 XX8x6ekWlpfEsKrfeXQEkiRLrUOK8t8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-TkqlzppsO5ah20ZZgY_oIw-1; Fri,
 06 Nov 2026 07:11:08 -0500
X-MC-Unique: TkqlzppsO5ah20ZZgY_oIw-1
X-Mimecast-MFC-AGG-ID: TkqlzppsO5ah20ZZgY_oIw_1793967065
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4360519560B8; Fri,  6 Nov 2026 12:11:05 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 623A3187C368; Fri,  6 Nov 2026 12:10:59 +0000 (UTC)
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
Subject: [PATCH net-next 08/10] dpll: zl3073x: update locking comments
Date: Fri,  6 Nov 2026 13:10:03 +0100
Message-ID: <20261106121005.1327603-9-ivecera@redhat.com>
In-Reply-To: <20261106121005.1327603-1-ivecera@redhat.com>
References: <20261106121005.1327603-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: Nbamo6oeH8SGZsyqdyFBc3o-PCcwWpFmjIRL2dlA0qk_1793967065
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

Callbacks are serialized by the DPLL core domain lock instead of dpll_lock.
All channels of a chip belong to one domain, so what the comments rely on
still holds.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 1cdadb8e46fb2d..6e5e2bb41f55d6 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -349,9 +349,10 @@ zl3073x_dpll_input_pin_ref_sync_set(const struct dpll_pin *dpll_pin,
 	if (rc)
 		goto unlock;
 
-	/* All code paths accessing per-channel reference priorities are
-	 * serialized by the subsystem dpll_lock, so it is safe to release
-	 * our lock here before iterating over the other channels.
+	/* All callbacks accessing per-channel reference priorities are
+	 * serialized by the DPLL core domain lock shared by all channels of
+	 * the chip, so it is safe to release our lock here before iterating
+	 * over the other channels.
 	 */
 	mutex_unlock(&zldpll->lock);
 
@@ -2401,7 +2402,7 @@ zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
 	mutex_unlock(&zldpll->lock);
 
 	/* Send notifications outside the lock to avoid ABBA deadlock
-	 * with dpll_lock taken by notification functions.
+	 * with the DPLL core domain lock taken by notification functions.
 	 */
 	if (dev_changed)
 		dpll_device_change_ntf(zldpll->dpll_dev);
-- 
2.56.0

