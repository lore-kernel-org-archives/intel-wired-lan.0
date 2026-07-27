Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F741C531D0
	for <intel-wired-lan@archiver.kernel.org>; Mon, 27 Jul 2026 17:39:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4071E40729;
	Mon, 27 Jul 2026 17:39:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uAW1cOWzLMJ4; Mon, 27 Jul 2026 17:39:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BEB7F40608
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785173960;
	bh=ZxVdhROmsZCB22C0ul9NS5T6lEUR3SmKQdrqPP+L6gg=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=loZUenI9XJe5qhHYn7vT4x+0D22xixNfL2ML201m79QRA5AD1nkrBaYqa/glc2jQ6
	 UPbdrPHPNBhqW+N/Vx0MIkVtNS5tFLaU8nFQ1y5trj7wYPPLShOgSNUr7w/58c/DOh
	 uNdXXwXyurpCiJax2uPuq5ZqZAjEdgVRJlHnP7I7xK6rf2A5c5Kfjnk0P0W1pjmPpX
	 aST2RL6rFF5GYKJYUyFuHcgxs0xwAyeKljpkZ1HWW4/xBgMtz6AZTuzSMcasAZC7ys
	 8eoMwqP/8DXWT5IvYbYDI/U/hbDKZjGkHNlA9Y4Yu6fba7tvpe3M3wN1L59eDl7m/f
	 OVcza9/i6283Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BEB7F40608;
	Mon, 27 Jul 2026 17:39:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BFB5D4C4
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 17:39:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A61A74009A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 17:39:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GlGEI_lyr3Hf for <intel-wired-lan@lists.osuosl.org>;
 Mon, 27 Jul 2026 17:39:18 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com;
 envelope-from=joe@dama.to; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 723A44007B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 723A44007B
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 723A44007B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 17:39:17 +0000 (UTC)
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-cbb973e6749so3370939a12.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 10:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785173956; x=1785778756;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZxVdhROmsZCB22C0ul9NS5T6lEUR3SmKQdrqPP+L6gg=;
 b=Wd0l9XTB51hH/1PMR+c4Tch4qq3PP7hZSkBnT/0yjQOdS5uFWZwCx/LmTNbsL4lm80
 /ODGPEpQyzJBD+68ljHPnh1MI5FXfDcZr+VbjbKc1m5aFSmZG/UvXHXLHpiimp1yTg47
 wwfuXWz3yyGwknZ9AeIpsnpDzkb8e8qnShLh8NteJLFNvT/7fxi8jBGnruLSAZ2CIQbl
 m5ZrasRFT/0TXJEI7/LhUEQVmorEZEXw2crJrpL0+PWHwvYvPHyYCIXP62I64bGuSdP1
 xShEBINL8aNUhFVOfYAuFppz8jZoE6rNK9bhvUDqzUTv2SzFh7GVgPb9fhj/A9PnyeBI
 6BFg==
X-Gm-Message-State: AOJu0YzWbQPZlFP4pgBJEnQ3I8jHQ4/+2++fii9UFDrOjVzNyYwgld3r
 xn0yQgwj7UrYtIKynGgg40DPnWCcDmzhmgjXsyefPTuUMy4k9uPOiGRtQvT4ruxIUl0=
X-Gm-Gg: AR+sD12TS7y4ixG5oO4u9E8veJXhBHXDKG40Mhv0fh+B1GpwkKojI9BnC4SO4nTvdny
 SjpiCRlSjYyBNOsq+VB5uRo5ToJMMETG55Jhr5huge7cLlXR1pzJdVFpp4nz1LvI1f55GCSfBX/
 v0WR/kJVqQZXAHQ0C7aIyYMiUO8dl0jmrY12BWzD/3IqSqycFdunZP2gCsXopkdkZBm/KvleVTl
 OKuTIM2x07O8uyZPgqnvvEZpT9kq5BagW02T3g/IgAQ/7P3ZY9iIL4QCIt4uMWu6EB3Hn9a7Om8
 OqWbkDJMvx4L+piP9+twRkfh8reSb0YaKmLvKaM9HFHH+loc9PQ6cItF4iXwuWMtU+rEi5ejSvp
 B4f7qEA99ukJAL+S7jusnNlUPlauY1zfYUXFJyfHPXGdbIX7qIv/tfkqR9c8=
X-Received: by 2002:a05:6a20:6a09:b0:3c3:935a:af2c with SMTP id
 adf61e73a8af0-3c67d9b3f83mr8904886637.3.1785173956413; 
 Mon, 27 Jul 2026 10:39:16 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5e::])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbbb660daf6sm3541156a12.2.2026.07.27.10.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 10:39:15 -0700 (PDT)
Date: Mon, 27 Jul 2026 10:39:15 -0700
From: Joe Damato <joe@dama.to>
To: mheib@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sln@onemain.com, jbrandeb@kernel.org
Message-ID: <ameXw+HOp25Q68R5@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, mheib@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sln@onemain.com,
 jbrandeb@kernel.org
References: <20260727115756.105038-1-mheib@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727115756.105038-1-mheib@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dama-to.20251104.gappssmtp.com; s=20251104; t=1785173956; x=1785778756;
 darn=lists.osuosl.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:mail-followup-to:message-id:subject:cc:to:from:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZxVdhROmsZCB22C0ul9NS5T6lEUR3SmKQdrqPP+L6gg=;
 b=TPC/TLlSmSqQ5OvZUhoBaYEE0xQIWMzJ/T3MuWe7PL7Sz8Y5Pe2uWMNvaVnYZgx12j
 6jdJEReYWxx7aOM2QLDCIV6Fy82qeKBEMnJnbuidO6xOk7LKGYaBlEjidPKnnLFv4b2d
 7LO4Fo9q9GvOu4ekfMLcSnfVCihnt/7bXVPtArUzUFdOG6vz7RbT4p62Vxle4NBzYAvU
 n2JoTgZeowaXbmjpsTA6zBR+8RViPpOHsL+uJufZ9/To3BmZwHr2sJJVrRTH7CzrzHfn
 gi/aTvLcKIOHL1pjHqnod+MaHh1AYiC8gq/gi3QYW9f0CqYjadBCHYAZnw/8BFuBLK7i
 eTcQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=dama.to
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=dama-to.20251104.gappssmtp.com
 header.i=@dama-to.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=TPC/TLlS
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] i40e: fix napi_disable hang
 in i40e_down() during firmware update
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
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Jul 27, 2026 at 02:57:56PM +0300, mheib@redhat.com wrote:
> From: Mohammad Heib <mheib@redhat.com>
> 
> i40e_down() expects its caller to set __I40E_VSI_DOWN before calling it,
> as noted in the comment at the top of the function. All callers do this
> except i40e_vsi_reinit_locked(), which calls i40e_down() directly
> without setting the flag.
> 
> Normally this doesn't cause problems because NAPI drains cleanly on its
> own. But when the hardware is in a bad state, like during an NVM
> firmware update, the ring descriptors can contain garbage that
> i40e_napi_poll() sees as real work. Since __I40E_VSI_DOWN isn't set, the
> poll function has no reason to bail out. It keeps returning budget,
> napi_disable() keeps waiting, and the whole thing hangs. The thread
> stuck in napi_disable() is usually NetworkManager, and because it holds
> the RTNL lock, the system can end up completely frozen.
> 
> Set __I40E_VSI_DOWN in i40e_vsi_reinit_locked() before calling
> i40e_down(). i40e_up_complete() already clears the flag when the VSI
> comes back up, so no additional cleanup is needed.
> 
> Fixes: 41c445ff0f48 ("i40e: main driver core")
> Signed-off-by: Mohammad Heib <mheib@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Joe Damato <joe@dama.to>
