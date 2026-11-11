Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D7060A5BC1
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Nov 2026 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=IiJskmR0;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ApBvRBaO
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6A9E8149C;
	Wed, 11 Nov 2026 16:41:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ggf50fdJ3wfR; Wed, 11 Nov 2026 16:41:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4699F8146B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794415289;
	b=TvR0tvNlttRl43QeTzDn0QcNWM+/ZagQrTHcCF8KADHV8wWRySA/Mx3uj1342aLeh+pP
	 JeBuusSi8EMcCFil+r55c0fOk0g2+7pbTGZsJnpB0t/+iee44/gc+/flCgB7HJSSA+E4Z
	 Be4+zlKSRPHRVhRZqVB+PTlPmOEmay/T6QwoVxBq9TsCQJGM+oAXVfePrV9hjRNRkL++e
	 VEEZXdZwvcS6GaO8fKNeVhYsAz6dVni5g6FO0Xdb+GkHV6W2TuQwaD6P1EmFHYAUYZdqm
	 liRLw58IPRgmVfZJLgrWsfdvh++sbfC+qbf6RH16umKGNeLljrupHKa8qec5TupjcWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794415289;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NX9FKH6K+UEomRB8px05FQHC/CI9W13+rfvS8/4IDW0=;
	b=Y6xLJPpm6OmC3O83sNcenqnbSvJzixzV9R+oGFxa+kFIPxYrBdEtyl4iH5U9qgMi4aUd
	 vYhNB99ZUjWbA3M3szY2XBl6GuYEoX2oF/pLhXT5DkU8mfdEYMXBOUjjmIqhkj3ky/Cy9
	 +E0o1wrpUZAxJCisrfjXWiBMa2rcRyw5SLxp+1jrVNJhWMpmLHNnxefo9qkpOG9uVXhrN
	 fMANmNsj4ByyadKuEuvXaj8Zbb2UIYMgPPhuRSOtLHHsZdVJZxBDg1KicR6Z8ho+TSuKp
	 fqbyrE1etmhCJoMQilPxMMXULX2YUiaDAA/V+uc9hVBl7fjN9TkKVoPe55tfVhD4KUw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ApBvRBaO;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794415289;
	bh=NX9FKH6K+UEomRB8px05FQHC/CI9W13+rfvS8/4IDW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IiJskmR0Tk9l7f9JtEAK0T4/OpoxH05FG18GMT4hCcn9NB5PgNz93okz7jG/u8wOM
	 oKR0FpYA2Que7rvS2imcHPU0K//MBMKYJrG/U4K4Y+oGpXbrZ2rDOgVQ/FuGTcih8A
	 nVsp85kHlYCCnTwL3CsT3FCkK0i5YNWJA1vpOZtuUvUDnHbrbHMOG3U3OxzU4aImuc
	 rkmAMeWis+XpWCKw/w2kAcI6YkH2TafFXLQ9QkpWwxnYSKj2qHBG7bLAAU/9Z303RX
	 dtJLbk+aoYUu+Q+MMGR804sKf8gvqqqEuz+HvrnK6uo2kS6RC5927vo5x0wUorX7xY
	 +EWaH2Za5DUWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4699F8146B;
	Wed, 11 Nov 2026 16:41:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 69CC3731
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 16:41:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4F8D18146B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 16:41:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v5Ai0NSDWoJm for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Nov 2026 16:41:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 83AFC81456
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ApBvRBaO
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id 83AFC81456
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 16:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794415285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NX9FKH6K+UEomRB8px05FQHC/CI9W13+rfvS8/4IDW0=;
 b=ApBvRBaOBJkyz+Xwy43r08mOa8B6GbeOJ+xRbE8Mm57lVKieZr2VTVetM7o+za34xo6/Hz
 ej+mrgrC46tApHlAKJZFeLCq7KreXgndOeUigxY2TCGD0KIB6yrnmZuI+NQDgmSgZuYlBP
 ZuJHyhFOoMY2wvOlHSI0Px8K+wMkuC8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-udOd2yd0Nz--KgahitOCoA-1; Wed,
 11 Nov 2026 11:41:20 -0500
X-MC-Unique: udOd2yd0Nz--KgahitOCoA-1
X-Mimecast-MFC-AGG-ID: udOd2yd0Nz--KgahitOCoA_1794415278
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9C981955E7E; Wed, 11 Nov 2026 16:41:17 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 593AD410; Wed, 11 Nov 2026 16:41:12 +0000 (UTC)
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
Subject: [PATCH net-next v2 8/9] ice: dpll: update locking comments
Date: Wed, 11 Nov 2026 17:40:19 +0100
Message-ID: <20261111164021.273409-9-ivecera@redhat.com>
In-Reply-To: <20261111164021.273409-1-ivecera@redhat.com>
References: <20261111164021.273409-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: 3OOkbLf90dUCZYpwIy5xpdGl1D1-UWWIvdJRVyy5oKg_1794415278
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

Callbacks run under the DPLL core domain locks instead of dpll_lock. On
E825 the TXC DPLL, the TSPLL DPLL and the other objects of a PF are in
three domains, and callbacks of pins of an external DPLL run under the
domain of that DPLL, so only pf->dplls.lock serializes them with each
other.

Reviewed-by: Petr Oros <poros@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
Changes in v2:
- Described the three domains of an E825 PF (Sashiko)
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 4 ++--
 drivers/net/ethernet/intel/ice/ice_dpll.h | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 0877827a6521cc..5d0a52d86f03e8 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -1178,8 +1178,8 @@ ice_dpll_input_state_get(const struct dpll_pin *pin, void *pin_priv,
  * peer via dpll netlink learn about the update.
  *
  * Context: Called from dpll_pin_ops callbacks after pf->dplls.lock is
- *          released.  Uses __dpll_pin_change_ntf() because dpll_lock is
- *          still held by the dpll netlink layer.
+ *          released.  Uses __dpll_pin_change_ntf() because the domain lock
+ *          is still held by the dpll core.
  */
 static void ice_dpll_sw_pin_notify_peer(struct ice_dplls *d,
 					struct ice_dpll_pin *changed)
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
index bce0bea9a664bc..c522c5fcbcce52 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -164,6 +164,11 @@ struct ice_dpll {
  *     tx_refclks usage map), acquire pf->dplls.lock first, then
  *     ctrl_pf->dplls.lock. Skip the second acquire when pf == ctrl_pf
  *     to avoid recursive locking.
+ *   - The DPLL core serializes callbacks per (module, clock_id) domain. On
+ *     E825 the TXC DPLL, the TSPLL DPLL and the other objects of a PF, such
+ *     as the RCLK pin, use three different clock_ids, and callbacks of the
+ *     SYNCE and TIME_REF pins of an external DPLL run under the domain of
+ *     that DPLL, so only @lock serializes all of them with each other.
  *   - @txclk_notify_rwsem is held for read across
  *     ice_txclk_update_and_notify(), including the out-of-lock
  *     dpll_*_change_ntf() calls. ice_dpll_deinit() takes the write side
-- 
2.56.0

