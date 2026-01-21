Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96903D262AD
	for <intel-wired-lan@archiver.kernel.org>; Wed, 21 Jan 2026 00:19:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E19982560;
	Wed, 21 Jan 2026 00:19:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KttIdiCJjYPv; Wed, 21 Jan 2026 00:18:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 03D7282542
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1768954739;
	bh=83eTm/eVuh3vEgsZN2wFNOaupTltCKQ9yAr4TfcZmpI=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=iSZEkm2s5Khkengz3f4/AaCP6ySl4YYoYRJJEVR1nm7FTAvFmo6AI2KQxyh1DbR8S
	 c42OCFwXPBKQo0dL198fZL76hgeJsIn7aGxiEgEjp9WKRrEZghz/ZH0Fx6x63VJWEK
	 G3XM9hnvVONm5Z0MFT/m7qRDaXlygPWFy5ZrQWEHbQezcBio/ebdvBIXlAk6ohrBj9
	 S6P2zRrV6rEaglj6lSbEIb7/pEoyufQQWOzBgl18dq4ochUHb8QwMyHobrcdU4qyZo
	 LAo+V1S4GgOUnB652Qv5eDwKFdCrpaFS5JGqaaDzhmRgg7wdv31V9HmaVBQB/SgrQK
	 7Os2EwzvFrfeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03D7282542;
	Wed, 21 Jan 2026 00:18:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 53353169
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Jan 2026 00:18:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4102140D65
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Jan 2026 00:18:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DR_HfuXRN-oK for <intel-wired-lan@lists.osuosl.org>;
 Wed, 21 Jan 2026 00:18:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 58F8F40D62
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 58F8F40D62
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 58F8F40D62
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Jan 2026 00:18:55 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8747044307;
 Wed, 21 Jan 2026 00:18:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00ABAC16AAE;
 Wed, 21 Jan 2026 00:18:52 +0000 (UTC)
From: Jakub Kicinski <kuba@kernel.org>
To: ivecera@redhat.com
Date: Tue, 20 Jan 2026 16:16:51 -0800
Message-ID: <20260121001650.1904392-2-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116184610.147591-9-ivecera@redhat.com>
References: <20260116184610.147591-9-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1768954734;
 bh=nIteDBTn2kAmgBvtRuDy38cJr4xlonSC8wjke3vr638=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SvXaxdYGqxzhDl4dlVgxDbHwn2ArnJYr1SHXf4bO+g9xDUPPXzUwTzGch79P8hiAm
 vJRWW0Q27ZnkuqCa8D0+e4oC6WIvAlaGbHoWoqeY6ecYlNW+bT3LYKjcxlH9EgbNo7
 MKA/0HmG2iU3dVeBqcbYUlqHCvlVue37XUicvgeU5587Q9sFqomwXcYPx1hthyeqOd
 kfMfFTl/8qonrKdrVPRydWSMVMJrcnyypokRo0BHIKoUjnHMxK7xtLkGtKrU6GdU1i
 ttYt2SvGkYb6SjMlZZb78IfxzoHK1QNbGO61ACekjv0iTQNgHhN+EifBPEuvYD+Y5I
 PnvLP5a3+70Ew==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=SvXaxdYG
Subject: Re: [Intel-wired-lan] [net-next, v2,
 08/12] dpll: Enhance and consolidate reference counting logic
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Cc: edumazet@google.com, anthony.l.nguyen@intel.com, robh@kernel.org,
 leon@kernel.org, andrew+netdev@lunn.ch, linux-rdma@vger.kernel.org,
 przemyslaw.kitszel@intel.com, arkadiusz.kubalewski@intel.com,
 aleksandr.loktionov@intel.com, intel-wired-lan@lists.osuosl.org,
 Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com,
 devicetree@vger.kernel.org, conor+dt@kernel.org, jiri@resnulli.us,
 richardcochran@gmail.com, saravanak@kernel.org, Prathosh.Satish@microchip.com,
 vadim.fedorenko@linux.dev, netdev@vger.kernel.org, mbloch@nvidia.com,
 linux-kernel@vger.kernel.org, tariqt@nvidia.com, aleksander.lobakin@intel.com,
 jonathan.lemon@gmail.com, krzk+dt@kernel.org, saeedm@nvidia.com,
 davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

This is an AI-generated review of your patch.

Dunno if there's a reason for having this fixed by a later patch,
if not let's fix. I'm sending the review mostly because of the
comments on patch 12.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
dpll: Enhance and consolidate reference counting logic

This commit refactors DPLL reference counting by introducing centralized
__dpll_{device,pin}_{hold,put}() helpers and updating dpll_xa_ref_*
functions to automatically manage references when adding/removing entries.

> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
> index 156f95de8e8e..f2a77eb1b991 100644

[ ... ]

> @@ -155,6 +194,7 @@ dpll_xa_ref_pin_add(struct xarray *xa_pins, struct dpll_pin *pin,
>  	reg->ops = ops;
>  	reg->priv = priv;
>  	reg->cookie = cookie;
> +	__dpll_pin_hold(pin);
>  	if (ref_exists)
>  		refcount_inc(&ref->refcount);
>  	list_add_tail(&reg->list, &ref->registration_list);

The new __dpll_pin_hold(pin) call is added here for the success path, but
looking at the context above this hunk, there is an early return path when
a duplicate registration is found:

    reg = dpll_pin_registration_find(ref, ops, priv, cookie);
    if (reg) {
        refcount_inc(&ref->refcount);
        return 0;
    }

This early return path increments ref->refcount and returns success, but
does not call __dpll_pin_hold(pin). Meanwhile, dpll_xa_ref_pin_del() always
calls __dpll_pin_put(pin). Could this cause a refcount underflow if a caller
attempts duplicate registration and then later unregistration is attempted?

Note: This appears to be addressed by 934c22045c2a ("dpll: Prevent duplicate
registrations") later in the series, which changes this early return to
return -EEXIST instead of success.

[ ... ]

> @@ -236,6 +277,7 @@ dpll_xa_ref_dpll_add(struct xarray *xa_dplls, struct dpll_device *dpll,
>  	reg->ops = ops;
>  	reg->priv = priv;
>  	reg->cookie = cookie;
> +	__dpll_device_hold(dpll);
>  	if (ref_exists)
>  		refcount_inc(&ref->refcount);
>  	list_add_tail(&reg->list, &ref->registration_list);

The same pattern exists in dpll_xa_ref_dpll_add(): the early return path for
duplicate registrations increments ref->refcount without calling
__dpll_device_hold(dpll), while dpll_xa_ref_dpll_del() always calls
__dpll_device_put(dpll). The same fix in 934c22045c2a addresses this.
-- 
pw-bot: cr
