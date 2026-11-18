Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4552B606A334
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 15:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=H6q9aBah;
	dkim=pass (2048-bit key) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=IlaAHwEA
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1FD4440873;
	Wed, 18 Nov 2026 15:05:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SWbuYtI33bnC; Wed, 18 Nov 2026 15:05:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 44DF7408CB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795014335;
	b=KeXRWRvnl3UR8hTomheSOv6YpWb7g1L+Y6DDqLK2HQ8tKJMabcpiUV2LpHdHYFNOmqQo
	 urfqlvOM3U4Poxn05os8NokDohyst9QhVkkawImY/l9F0uFVj8dHaLqxPTDNmMnZbcDO3
	 Ihh6ts+fDsaTGIzkXRyxqPg/P7RJ/Akxp9qTk9fYAluBAGO6PMXINbqc8Thlep8//4J+9
	 YAeQCo8SbHhqAHSwp836heXK+ewxZ18pNqMo4uNtFWUSE8XPVA/IuD5M3IUGCKhKa7mkq
	 /TSQCqzYTlPkB9r0h3eA3aFBUgAcHZbFv2hsGzeh2Ou+NKxRHpdumfNSxL7aFNoR+zA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795014335;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uHGZ+xOdJx3Zm8UTHiozAvdnroVoplilsdHtzudcbVI=;
	b=D9r78zAYI9F82wisLBMr/dIa5AD6cslzv36YZa71iIKSwyigdJU4ylKbIQW81Q3JB0uf
	 sZdp0lb0HVCTSZAtg6gmLaPZI9dF33qv4nr7i0HNxze0G5l1asDbbR+FerQ99d+QKa3T5
	 bBYtaF0s8XPpreBK5anrsI7DIH/C0GFkHHiKSZzee7Y2ZjDiMftzsmRkmuD/IPgVlCCI/
	 FEW8EpilOJ+yD+TwRwurd/t+9ADolWlfdwV1hkZrJNvdyymc9z7IN9UA6rW8xY4P9LJe6
	 sgtgUCIxMoqzw6rGV6ybYgjjCSbSUyfn1p7uTMBaCmT49L7c1vwXFfNEwFQkTmoIu4A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=none header.from=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=IlaAHwEA;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795014335;
	bh=uHGZ+xOdJx3Zm8UTHiozAvdnroVoplilsdHtzudcbVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H6q9aBahxSGGhUXDPvcl08LRAcf206IRKZdFZ05/hMIvDgoiZNyYEZFKjea2wowUr
	 /TaBPd2PYyfMGyrW9bVDv2Zcq59zXPkuHOJvEMaiSMshxpc8xjKZQyFmqhydXWzZUw
	 4BOOPeMBJeLmdqQ08BQxT5FouamhRBgfB633SGBjAgnMbMEypOFLyM3b/M0Rb8RzHJ
	 JAdSTLBVnze7K23Pa9NynatLc4NR6kaZAPFPkVTQhciVGfylx0ghjwpz86I5fXFNEM
	 P0PRU2xH/k1puQgVX/1zyO2D0ERjXAF0M8PVJ+5xtvyfZJFx00yeP5JLAKuCMWcWWq
	 qzzTAgS5mlUxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 44DF7408CB;
	Wed, 18 Nov 2026 15:05:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 07F819F8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 15:05:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E9D12408CB
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 15:05:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id noyVn5zoM5ms for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 15:05:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5D2A640873
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com;
 envelope-from=joe@dama.to; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dama-to.20260707.gappssmtp.com
 header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256
 header.s=20260707 header.b=IlaAHwEA
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5D2A640873
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 15:05:31 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2efd824d492so5423005ad.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 07:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dama-to.20260707.gappssmtp.com; s=20260707; t=1795014331; x=1795619131;
 darn=lists.osuosl.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:mail-followup-to:message-id:subject:cc:to:from:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uHGZ+xOdJx3Zm8UTHiozAvdnroVoplilsdHtzudcbVI=;
 b=IlaAHwEATqjHzTdml+tpXFtOQwd8fCYA9/ub8xYli4xV5NrWDt9ZiRkTghZ4VmTBz2
 PQK9Kx9TI+dUqwkcM+lu2s6XAuFbJxzmzpo/m/JNxIu6ctvgU+XZLgbS2JqtH4BCIXmz
 QbzXfe9yIC80dzFICXTNFq3PZO55DPxJK8njMPdL4CBoghSfWyFNAJOCmcNSWa6f5naj
 kz0kubif1xgtVqT/yZGWD6+1BdZvUwR4jO4wAK40/LBpPpVLfg06sR9dLTufPhd9Mt+P
 4Kc7KbyNga4ZReyYp5Fc23MoKA1TzQrg1cO+bduN3I1tdQ4mHlapv0kmA36eS1ffZFgA
 P6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795014331; x=1795619131;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uHGZ+xOdJx3Zm8UTHiozAvdnroVoplilsdHtzudcbVI=;
 b=E8jgRK96JWYChq2yOeIvsL5/Y7dLuMkNl5WCWx3YNEiXcws/xp/TuKxc1vmuIFDeZM
 u/SnKdeuDW+wjspFGR3YOFvbDu7f/oW/iXpmm31cgwoBI6ksMO9Y9gUFhwhw+O9PDMr0
 IY0wI09xDh3H5E3Hd/UuF0qZOaWqaB3zoCuPr7JbQf9e7F0z1e+z0vszvmbYs6iKhOB8
 7AVnirQi6KQdU5xvjCGwyo5chyqw2fkYRI7EgYelP5REXbQZxQy7r2g/uoqZyntq6ngy
 vLxv5PXqO5n6eRxJOn1iE4rcOAH2GtVtQjuHC5KY6Gp3V82+saleVfeRto/s6Uulxwph
 j90Q==
X-Gm-Message-State: APuU4Z/ULxO0zO6+ceYs+rOXFLTH1CwnOkaWHVb1P1xcVK5kh+jmZFjM
 HqHEnKvVfa1ul+oMnWL6arTa02JQ+Fzv4ZkP+6R+jzbjLo/A3dWcbbN3yTMY0jB8IBs=
X-Gm-Gg: AZFdTZcWmeDWwXT8+c42khrpMrLeB9dnBz1nPPkeGFzvBE97vxaHVYMBpZJ9DCGAMQ/
 xac/yoWZkJxY3TJU3BLNPzdg6v2ZrZoxIK8ZMVmdVhB3Rx/yVKzu9/lR3uEkucwpsoJVVZiKVe9
 59ZHdW3fBEVh96//zEWT5EVVgvcbU5AjeaDt2DHNcDaJIQdUZJZiu9Gi+GHSARfxQPSzIOfcGJH
 VnkbfIu35JltMsvcRFgjv36TTgeAVgEFMKKs8Bd+yO4wETpaignWwSBBa1vApW42pohs79v1so2
 HUCsviuwsNim40o5gTLH4vUX6RIlI1r7DI4tJIckkHeqzTpAhEUr6BJ/QqWtwgbYX3KHuLCoMoX
 SX24LNyQCfBRcCcI/6EfM32BoqATiFfrVuweP3oWmz6E3fHkqUGUbZxwiLT2uK3y5rZfB0bpywl
 GoaftDZ8M5upGY6eDAkcjj1DTIXfyxVkp8LoaFA5CqwSSiBZXGaIw8mFkS48w62WoyT4kc1NkOa
 GM31F6qO4+XswxOY1iISU+piqOaNTPryRS00bc15RG2TunMxRSWKLBYx8GQVqdr5Fm8iiL5JObq
 XIwSeU07r4E6Lhi8xK7xUkUGF5qk8PxGsPNY4+j1bXWRT7rfWhVXVmpSaTUHX3nm
X-Received: by 2002:a17:902:ce10:b0:2ed:2104:9a6f with SMTP id
 d9443c01a7336-2eff73f1e64mr28760675ad.22.1795014330948; 
 Wed, 18 Nov 2026 07:05:30 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:46::])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eff6115f28sm15446135ad.19.2026.11.18.07.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 07:05:30 -0800 (PST)
Date: Wed, 18 Nov 2026 07:05:29 -0800
From: Joe Damato <joe@dama.to>
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Kurt Kanzenbach <kurt@linutronix.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2 2/3] igb: link queues to NAPIs under RTNL after
 runtime resume
Message-ID: <av2+uVOytr5BDs5P@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
 Antonio Quartulli <antonio@mandelbit.com>,
 intel-wired-lan@lists.osuosl.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Kurt Kanzenbach <kurt@linutronix.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261116153041.3002666-1-antonio@mandelbit.com>
 <20261116153041.3002666-3-antonio@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116153041.3002666-3-antonio@mandelbit.com>
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 04:30:38PM +0100, Antonio Quartulli wrote:
> __igb_open() links queues to NAPIs with netif_queue_set_napi(), which
> requires RTNL, but RTNL isn't held when resuming from runtime suspend:
> this triggers "RTNL: assertion failed".
> 
> Don't link them in __igb_open() when resuming: do it right away on
> system resume (RTNL held) and from a work item taking RTNL on runtime
> resume. The links can't be kept across a suspend, because
> __igb_shutdown() frees the q_vectors. These are only freed under RTNL
> with __IGB_DOWN set, so the work item checks __IGB_DOWN under RTNL.
> 
> Tested with the 82576 emulated by QEMU.
> 
> Fixes: b75a1dea500f ("igb: Link queues to NAPI instances")
> Cc: stable@vger.kernel.org # 6.16+
> Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
> ---
> v2: no code changes; mention the tested hardware.
> 
> Note: igc may have the same issue: __igc_open() also links queues to NAPIs
> (igc_set_queue_napi()) on the RTNL-less runtime resume path. We didn't
> have igc hardware to test a fix with, so no igc patch is sent for now.

I have an igc I can test on if you want to send me the script you used to test
this. Feel free to message me off list if you like.

>  drivers/net/ethernet/intel/igb/igb.h      |  1 +
>  drivers/net/ethernet/intel/igb/igb_main.c | 38 +++++++++++++++++++++--
>  2 files changed, 37 insertions(+), 2 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>
