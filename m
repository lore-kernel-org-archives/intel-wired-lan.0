Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C332606A88A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Nov 2026 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=cSqtSSIM;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WgxaxXZT;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WgxaxXZT;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K31aN9NG;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WgxaxXZT;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WgxaxXZT;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WgxaxXZT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E5968146D;
	Wed, 11 Nov 2026 16:41:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fwr5LFyr6qr9; Wed, 11 Nov 2026 16:41:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 74B3B8145C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794415283;
	b=NpbuNo5rkDHeofqqjlpxVVRyyVrV3Ih7URShXP0jlsELZpWY6SvCBiAubZVhdh0WAbNJ
	 +Id/txm7bkyrHxwNlr989jE+ZuHTcw+3E3I7bWcdUgxlJs7BXxgUwBlsBjLDPyQnkzP8C
	 qkZnoc9FHZowVZI3Ji7q233hU5G//eJzZavLMHgJx4xYQPltNCR7KMA7HCC+2yeXD5Zg4
	 FLx7SVtVM89KxJAB786bcGh25oCFCWxXn7pqKrNu44MOvdozB4wipWYRPe7uUYInze88O
	 VXYxloWvgBMa0/lt9JG4BM27Xa23x+kAocQJrFIr2iEHSW/4Jf0xPHRJo4a6iPxzFNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794415283;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jOxpAWZEDjh6YuLzUFmhUB+/S4//KD7ZYS5impIWXLs=;
	b=QRDbKIakKdxAeHZlFo1JR7UDCxa4CG5gdlRulkY5O3V8vxr0JHZ0Gk9XtjvaFVHEg+vO
	 DQz/veuOuqkxkfpCptOkF/QJSIcWcSMBT0CvlCdEkRC81MGFeVFuueEMYiT1y7TgHWG+a
	 MCAV6tGwTGAzfEktRbE5YrjvXDJ3OVsXqEBcE1FMv5BgA1LqYW2Zr3FtBG66wP114bXr5
	 dD6FxWWwFUCtsThliB+XJdPKB87v763lpaPekL0W3p/WWA3ocGvSWEfco/jpbRtfEp92L
	 Hyj4+X9uE4HQ5n2Ju3gvMu563EC4Ih8xJx3XZ9VIN8hycc+J2S3vl1kYW6byreD1i+Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794415283;
	bh=jOxpAWZEDjh6YuLzUFmhUB+/S4//KD7ZYS5impIWXLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cSqtSSIMm82nWyFRQiJ8zh0ptg2HkobRAU5fEJGUXor8eMi052GAJitEVAhGeRJiI
	 ZIxHI8dxZyJJf0xJ7nr9JZhosrY5RGbwS6M7GY+KM3mC9B4ObFTFVXP718fljkCcoM
	 nZ37Q7cNHnVZiucp51qvJ6McOdFl3ZyN+TxAWBR+itGr0rqTu8VpFN7JxAhAfGDERd
	 iF0umPFKIIARRcPLKL7NupbJmpeZWNZK4dm7q6qW0XMavPeR6/EYxQm9xjrcrDAhVd
	 Ss3fNWlGXdTxEljSu74k3T5dT8ErvfeR23HESdXz20hO7o9fHQyNtiAzivo2GzOboe
	 sY4VKKH++giKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 74B3B8145C;
	Wed, 11 Nov 2026 16:41:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7ABBC731
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 16:41:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 605F24016D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 16:41:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G6Lk0-_JSy5c for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Nov 2026 16:41:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AB3514006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WgxaxXZT; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WgxaxXZT; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=K31aN9NG; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=WgxaxXZT; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=WgxaxXZT; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=WgxaxXZT
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTP id AB3514006F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 16:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794415278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jOxpAWZEDjh6YuLzUFmhUB+/S4//KD7ZYS5impIWXLs=;
 b=WgxaxXZTJnxa7bpLzByNmNzva/WUQWkrbnFLFGZjwWou2yZMxK7cfB2sh2Htye+c8fOzr8
 d1sHKiXCs6/mvbtALHJ6C5nWmzkZ8aZ6L6D8l4cy+nS0TaKsO5I7ZcovbUeLDORsa8Ueyd
 yDjK+K5g/maqYV8TK/FgF5Mw9lY6gcQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794415278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jOxpAWZEDjh6YuLzUFmhUB+/S4//KD7ZYS5impIWXLs=;
 b=WgxaxXZTJnxa7bpLzByNmNzva/WUQWkrbnFLFGZjwWou2yZMxK7cfB2sh2Htye+c8fOzr8
 d1sHKiXCs6/mvbtALHJ6C5nWmzkZ8aZ6L6D8l4cy+nS0TaKsO5I7ZcovbUeLDORsa8Ueyd
 yDjK+K5g/maqYV8TK/FgF5Mw9lY6gcQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794415279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jOxpAWZEDjh6YuLzUFmhUB+/S4//KD7ZYS5impIWXLs=;
 b=K31aN9NG+EAecXYb+9pqTkT3DqqsB7EO/LD07l19Ak4NJbeKSmFePG2hIiX/2lT64LuXip
 H236b1VPFT2GSu36b9qKexERoxCu9hvnPVN4gjJBi5gFyJjvHRtKqv67svc733zGnBPNHm
 hycxXcJZrrTqC32wPpi3BI8FUKG9zBY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794415278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jOxpAWZEDjh6YuLzUFmhUB+/S4//KD7ZYS5impIWXLs=;
 b=WgxaxXZTJnxa7bpLzByNmNzva/WUQWkrbnFLFGZjwWou2yZMxK7cfB2sh2Htye+c8fOzr8
 d1sHKiXCs6/mvbtALHJ6C5nWmzkZ8aZ6L6D8l4cy+nS0TaKsO5I7ZcovbUeLDORsa8Ueyd
 yDjK+K5g/maqYV8TK/FgF5Mw9lY6gcQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794415278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jOxpAWZEDjh6YuLzUFmhUB+/S4//KD7ZYS5impIWXLs=;
 b=WgxaxXZTJnxa7bpLzByNmNzva/WUQWkrbnFLFGZjwWou2yZMxK7cfB2sh2Htye+c8fOzr8
 d1sHKiXCs6/mvbtALHJ6C5nWmzkZ8aZ6L6D8l4cy+nS0TaKsO5I7ZcovbUeLDORsa8Ueyd
 yDjK+K5g/maqYV8TK/FgF5Mw9lY6gcQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794415278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jOxpAWZEDjh6YuLzUFmhUB+/S4//KD7ZYS5impIWXLs=;
 b=WgxaxXZTJnxa7bpLzByNmNzva/WUQWkrbnFLFGZjwWou2yZMxK7cfB2sh2Htye+c8fOzr8
 d1sHKiXCs6/mvbtALHJ6C5nWmzkZ8aZ6L6D8l4cy+nS0TaKsO5I7ZcovbUeLDORsa8Ueyd
 yDjK+K5g/maqYV8TK/FgF5Mw9lY6gcQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-jlDh60aTO8q3L_Wbnk2pqg-1; Wed,
 11 Nov 2026 11:41:14 -0500
X-MC-Unique: jlDh60aTO8q3L_Wbnk2pqg-1
X-Mimecast-MFC-AGG-ID: jlDh60aTO8q3L_Wbnk2pqg_1794415272
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EAA7A1955DC5; Wed, 11 Nov 2026 16:41:11 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 61D1D410; Wed, 11 Nov 2026 16:41:06 +0000 (UTC)
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
Subject: [PATCH net-next v2 7/9] dpll: zl3073x: update locking comments
Date: Wed, 11 Nov 2026 17:40:18 +0100
Message-ID: <20261111164021.273409-8-ivecera@redhat.com>
In-Reply-To: <20261111164021.273409-1-ivecera@redhat.com>
References: <20261111164021.273409-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: jyRj6OTRe65WwVI06ifmtbzYGV09_SxahzukpOemflk_1794415272
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

Reviewed-by: Petr Oros <poros@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
No changes since v1
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

