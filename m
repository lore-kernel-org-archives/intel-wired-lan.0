Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FF1606A323
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 20:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=VuVjXAmr;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B90K2ofF
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED3BA60B04;
	Thu, 26 Nov 2026 20:33:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hN23ie2OmMSq; Thu, 26 Nov 2026 20:33:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 56B2B60B0C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795725216;
	b=LQHGFITNwmeZ/+2/RHmO8kEG7n9qt6eVE1ify4EwYL/LghbQF+xwTs+5kSm4EK4fx7er
	 wsbZYSAZre3R2S682ejcznG3iELDsISkDvdp+SW5a0AGLuYbx0aAjizLQI69zBLR3Mz2l
	 TeU+Wpt5bhiHmISaK7nOPzHG2kynV7maPp882tWFHQm4yjGKZ3EINkC+7/YOQEuYGairF
	 XoKe9oEdBsE/NCkC6B8wXVoBrvYSZXStBTnquXmWYjB0RbMs6l4AoB6sC7cqs7aNwUbbP
	 +dI6eBt6PFyQNOZP1srcYxXlGs5WMEXKL3Oc/fQa4hj/mKEK8o6KxbUHLgQyLBcuOBg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795725216;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gC34gMSRS9jwecTckCv4gD5v5wmtn6vJzIZIyuuibwc=;
	b=ek4w6gV5PrlZrbFi3XDCFBJshrq4701/rHay/a+wMgELT/bI1od+oIr/g8RR08YfUZkP
	 C10Me8vGUoclC2y9U1hYYhuT1wcCf0mB8lPAeuspj6xbRWYiuFYbxK9EaiFrIkZlZzh+O
	 NXbddoQyPHLJQZkaqfaroHZSlqiflncUD1cOdZejhluq88+Y2xGpiJz6pdaJ+4l5r4W3q
	 tMCMOodwBQdsnQp8qjrtnut7+R2V/zKvwjUJ9s9HMHJ/xUmBDVMr9ABl/BQA8VJBX0cyb
	 WxV5J7zs4237I/c57ip55ArYhPRLbz7JLYsnHpbe+6otiXpHIs3WeSyUUP7wXH6ha1w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795725216;
	bh=gC34gMSRS9jwecTckCv4gD5v5wmtn6vJzIZIyuuibwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VuVjXAmrEDVrORT7UDgt1qnA/CDRZs/6Ya2oyviuyKMRE3bd9FxjjyY61Ns2eHuwY
	 4XvUupTuGJEVYf6eZIwohrR7ICzEMnYyFhVA+cEADwAD0zxKMrBeZ2hZXCGWuTsS7Z
	 /D407ELwjQ4Szn7PM/zkpb3AjtBvbQ4q11KkW2SLxZsaT3opUpjY3zu6ujU+km4dSe
	 aa2BH2rUzmChn5k1VUFpCaRSFxSBE5awRifrGEHrW5v4jHVwv5Atv9ZZwTcGb/mX5K
	 wk0oOIp+APpwmHD/rTXqlWmle51WCPLUYo1OVXIQ5LdgW784BIRfGqdm1wzqQyZUGr
	 4AUkNdPWV0bbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56B2B60B0C;
	Thu, 26 Nov 2026 20:33:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A2151AB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:33:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F05B8409EB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:33:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XmVtQJMQSTfv for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 20:33:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3FB17409E4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=B90K2ofF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3FB17409E4
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795725213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gC34gMSRS9jwecTckCv4gD5v5wmtn6vJzIZIyuuibwc=;
 b=B90K2ofFlIz6P0qJGx7Ma93dzj9gO9kiYjkMUcjM1CoVw5zdUSIOJPyAfVlhohPZYyLLXx
 3BMWN9xlH/YXoP3NDpRHrIhU/+mP0hLPRNGc3U/VBeTKeGmQKcWb4T1hAPZWO27Eja2QPJ
 piNIpshwIpH/8ypq7q7iR5zsMmHav9Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-FKiK85zXP4G6HzIpTEhQxQ-1; Thu,
 26 Nov 2026 20:33:26 +0000
X-MC-Unique: FKiK85zXP4G6HzIpTEhQxQ-1
X-Mimecast-MFC-AGG-ID: FKiK85zXP4G6HzIpTEhQxQ_1795725202
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95C6319560B2; Thu, 26 Nov 2026 20:33:21 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 377521801977; Thu, 26 Nov 2026 20:33:15 +0000 (UTC)
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
Subject: [PATCH RFC net-next 06/19] ice: dpll: drop the filter of
 notifications from own registrations
Date: Thu, 26 Nov 2026 21:32:18 +0100
Message-ID: <20261126203231.934632-7-ivecera@redhat.com>
In-Reply-To: <20261126203231.934632-1-ivecera@redhat.com>
References: <20261126203231.934632-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: NmEgYMlbLNZSz-Q7cDCuO0A15vBWmTQ4H-PHbDDgoiA_1795725202
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

ice_dpll_pin_notify() ignored the pin notifications that the driver
itself caused when it registered the zl3073x pins with its TXC and
TSPLL DPLLs. The driver does not do that any more, and the recovered
clock pin that it registers under a zl3073x pin has no firmware node,
so no notification caused by the driver matches a watched firmware
node. Remove the filter.

Tested on a GNR-D platform with a dual NAC E825 and a ZL80132B DPLL,
with the rest of the series.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 34 -----------------------
 1 file changed, 34 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 15b5f4a15af915..ccbe34abf74661 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -3098,32 +3098,6 @@ static u64 ice_generate_dpll_clock_id(struct ice_pf *pf, struct ice_dpll *d,
 	return pf->dplls.clock_id;
 }
 
-/**
- * ice_dpll_is_own_dpll_clock_id - check if clock_id belongs to this pf's DPLLs
- * @pf: board private structure
- * @clock_id: clock_id from a DPLL notification
- *
- * Match info->src_clock_id from a DPLL pin notification against any DPLL
- * device this PF has registered. Used to suppress self-notifications
- * generated as a side effect of our own dpll_pin_register() and
- * dpll_pin_unregister() calls on the fwnode-backed SYNCE and TIME_REF pins,
- * whose DPLLs (TXC and TSPLL) use MAC-derived clock_ids on E825.
- *
- * Return: true if clock_id matches one of this PF's registered DPLL devices.
- */
-static bool ice_dpll_is_own_dpll_clock_id(struct ice_pf *pf, u64 clock_id)
-{
-	if (clock_id == pf->dplls.clock_id)
-		return true;
-	if (pf->hw.mac_type != ICE_MAC_GENERIC_3K_E825)
-		return false;
-	if (clock_id == ice_generate_dpll_clock_id(pf, &pf->dplls.txc,
-						   DPLL_TYPE_GENERIC))
-		return true;
-	return clock_id == ice_generate_dpll_clock_id(pf, &pf->dplls.tspll,
-						      DPLL_TYPE_GENERIC);
-}
-
 /**
  * ice_dpll_pin_ntf - notify pin change including any SW pin wrappers
  * @dplls: pointer to dplls struct
@@ -3877,14 +3851,6 @@ static int ice_dpll_pin_notify(struct notifier_block *nb, unsigned long action,
 	if (pin->fwnode != info->fwnode)
 		return NOTIFY_DONE; /* Not this pin */
 
-	/* Ignore notifications that are a side effect of internal pin
-	 * registration/unregistration calls. E825 uses per-device
-	 * MAC-derived clock_ids for the TXC and TSPLL generic DPLLs, so
-	 * info->src_clock_id may not equal pf->dplls.clock_id.
-	 */
-	if (ice_dpll_is_own_dpll_clock_id(pin->pf, info->src_clock_id))
-		return NOTIFY_DONE;
-
 	work = kzalloc_obj(*work);
 	if (!work)
 		return NOTIFY_DONE;
-- 
2.56.1

