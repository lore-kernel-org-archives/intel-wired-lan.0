Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA36D60A2616
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 12:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=q3sWTncB;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ct/xz2tH;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ct/xz2tH;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ct/xz2tH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 86C4F81287;
	Tue, 10 Nov 2026 12:24:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H-ZxXWvrReGi; Tue, 10 Nov 2026 12:24:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 863BC8128F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794313466;
	b=YvtXO2YixmJ1SLzsGAkSVAB0/7mz8GW0AprUerJQIqxaa6pGAXs7xNL7GJxE9r8gNv9V
	 3B2Q1fi7WJA1421rbeg9OSCAwRdF4lDxU+wj3MhxHpScM9sKM1LURVByuxP6FRj0WkZcU
	 KVI0Ki3llK5NLoAdItVZmNS6F4GyPI1p9Fak6aHnHEUXcHnG6IBA1zGUMFnEpSG0nzlad
	 TRlGPsYvnZOMNUXA33XrxZPxT0TUioxpvTmz3oRFb0HlsB7h52yl0oD8wGe7IWP8wPJTm
	 JKPgDdET1eGcRvzttUEPaWgetCw5HHzwO8yhEvEmTgBPCd8PX6e+0Uh2NLHEkmQl5wQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794313466;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:From:In-Reply-To:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yeAOOGb1lxkAjyxfUQEssqvLvFA7bPwutUunMyT967U=;
	b=Ae+zTamCEWAk2yu+gga46HdpHVSsyLsvufvXoIfTrWKU1Go3D8ohTjnH8GEN6ffQ08dq
	 //1DqHw4HVXb0cIY1kTwx70qoO094bgIbhQGXGC5XTRCbjW+vQXq8NgZWzEQDwPvjOTc4
	 wIScswG1jC4mzRy25/Qt846BAiKxpowKJuWQrz8opnX5KV2D57uJzFMYrf41DlBu8qLXR
	 2ojANF/H19j56SxdmPuNDMuBuRYHDttHIsMNGUEU2g9iBZ+xKBlTAgRCLTPONMYOlvyoh
	 Nki4+A5qkmtKESY7A+842ofYqMHWt0SuViCW4L1mJNSHXqlh/WI4nmU+0/MGHsRUiZA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Ct/xz2tH";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Ct/xz2tH";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Ct/xz2tH";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794313466;
	bh=yeAOOGb1lxkAjyxfUQEssqvLvFA7bPwutUunMyT967U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q3sWTncBiBahRvfi+uPLkGnglJ1RwuYJBd9xzINWZxaiYNRTpi3iLH3u47xehp/ij
	 iAKu/UwMfbQvZP78nu5mujKxziRo6a4mewyagR7lGha2doCj5DoXZokZSfzCvMT3TU
	 v91xzXMBkvqy6kmwio1cr4tEz3EKjKSKC5zDbv7CJu32e9gnc3U1pkiUwxVcj06MU6
	 JLGD7iUihTcsgbgWXffRtwxYoqhL3OxT0894FBu97dlFSgyiDxd8jZnH/fmCkVEqEs
	 NHWCFjIbsqFJKqoFoRHOv64oLMe5nHDVZcr2ezg4fTXUhO162K8aOPioPfrvpjpneq
	 gtHV14G/Uybcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 863BC8128F;
	Tue, 10 Nov 2026 12:24:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A3CDC731
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 12:24:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 663F58121E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 12:24:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pPEygWsEpebI for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 12:24:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6F0AA8115D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ct/xz2tH; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ct/xz2tH; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ct/xz2tH
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F0AA8115D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 12:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794313452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yeAOOGb1lxkAjyxfUQEssqvLvFA7bPwutUunMyT967U=;
 b=Ct/xz2tHIgD10iPk6TcPy6WdPpFSWySW332vmT4aoBs3HzQ1dSIX44C4efxzwkNIqjKyvC
 oZfCUYzdSctZxHmGmruwk4EjnqurYsYswYZokutI7e7CwKrIDNj8sRBTwXStvz22gx+zl6
 zDPQqX9Kl1YEnn/jwhqF2f1zDzQ+GkA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794313452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yeAOOGb1lxkAjyxfUQEssqvLvFA7bPwutUunMyT967U=;
 b=Ct/xz2tHIgD10iPk6TcPy6WdPpFSWySW332vmT4aoBs3HzQ1dSIX44C4efxzwkNIqjKyvC
 oZfCUYzdSctZxHmGmruwk4EjnqurYsYswYZokutI7e7CwKrIDNj8sRBTwXStvz22gx+zl6
 zDPQqX9Kl1YEnn/jwhqF2f1zDzQ+GkA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794313452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yeAOOGb1lxkAjyxfUQEssqvLvFA7bPwutUunMyT967U=;
 b=Ct/xz2tHIgD10iPk6TcPy6WdPpFSWySW332vmT4aoBs3HzQ1dSIX44C4efxzwkNIqjKyvC
 oZfCUYzdSctZxHmGmruwk4EjnqurYsYswYZokutI7e7CwKrIDNj8sRBTwXStvz22gx+zl6
 zDPQqX9Kl1YEnn/jwhqF2f1zDzQ+GkA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-Bonlj9KFNDWT4TmDe_FVdw-1; Tue, 10 Nov 2026 07:24:10 -0500
X-MC-Unique: Bonlj9KFNDWT4TmDe_FVdw-1
X-Mimecast-MFC-AGG-ID: Bonlj9KFNDWT4TmDe_FVdw_1794313450
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4925ef75fc4so1725837f8f.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 04:24:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794313449; x=1794918249;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yeAOOGb1lxkAjyxfUQEssqvLvFA7bPwutUunMyT967U=;
 b=1g2BYGJVWWBf90Mr7v4RTdreGBnor1EnUQ5hbcCnAUuO3D4dZPMyRw5wNuFlJRipSM
 UB9aH95pKsswZ2vcHZT18qqdXvGk1JuD+hKf8UDI52d4qg/MMt+AU/vNXBO0n15s0Buk
 I2t4B/oxmMF29SFsxfJL/EpkVPJtt55TTeEnYyJgHqG9IlvsMVvJKQ0qJ4RkLOf+PFjS
 W6fNhcAdBih9dJ3r2i9RATD7W4pTGXxuEJjKyzGAcFuKM1eVwV4txLAs2ujeScAWyHy0
 3yb2CMtuTgaMOXTTf7Z/ZFDJKRJVy/6vinDhKKcI075bphqLE6f8BzaJrj2wx9FN/QsX
 a6bQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEEtRu0hhPuwGDhve5F7zwh0iX/dCaVU53d9VyVKeIycuTvu5Op67vO9qVpEG5VooZMF1qw9m1WftePCMQTun0=@lists.osuosl.org
X-Gm-Message-State: APuU4Z+z1/R8d+ioOGX84shu0kWXwOLJCe+XVsDy63NJY78UtAsLsE/c
 IR1AAXgP7Abm8EVpNnf5Cp9QsSg0LdRwthFOfKDMUvP92xaemDfAYBa4W+0xT4L2e7t1kvqXbfQ
 9j56sCwybV4ttwGERqkxKh5CEMq84+X4VQtWJkHddb+62WLIBAzG/9xsiCcTvE3JMLUIfHYU=
X-Gm-Gg: AYBFou15Ge8ho8CovGZhmeapSI+fC4mIOyZyopjNf4bhtoVCpF/R7PTVVfTWZe3mzxn
 HLQ1FIC8QD3LRtK/A3V6yPz3EFAznkXGSu8kKQ9yc5zzWekynT7wUESvz2oL5Q1fxEJzx6KAyzW
 MO1pVCJwh8xb2Zqyy8anaQJ4Ene4feUkEWSqsUTACWVQkIj+7qzwYDa3Q4aM3ZBeKONZia4avFg
 uxv6zscr36hHSCbDVdmcK7yQnFBXWZctMA38UoHf41nF/22eT3H+jf44b2bZZJZ8kSWZoLqdJRF
 2FgtXCNU0+rzQANU99IUa/Jc0QwMr13aXeOUNXuJ4oL0QcYC2LRAbYR0tAq0zjPjQja0CkQLznG
 d9YnQBlK3VCUjyrkMbuCNPRSZt0+BKEu7TkA=
X-Received: by 2002:a05:6000:22c6:b0:48d:f36e:fbcb with SMTP id
 ffacd0b85a97d-4982e82c1b2mr4754514f8f.14.1794313449324; 
 Tue, 10 Nov 2026 04:24:09 -0800 (PST)
X-Received: by 2002:a05:6000:22c6:b0:48d:f36e:fbcb with SMTP id
 ffacd0b85a97d-4982e82c1b2mr4754440f8f.14.1794313448686; 
 Tue, 10 Nov 2026 04:24:08 -0800 (PST)
Received: from [10.43.3.161] ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498362eb14asm4534584f8f.34.2026.11.10.04.24.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 04:24:07 -0800 (PST)
Message-ID: <7f51beca-9045-4e3d-a97d-43e7a8a7557d@redhat.com>
Date: Tue, 10 Nov 2026 13:24:06 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/10] dpll: convert dpll_lock to rwsem
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Min Li <min.li@microchip.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
References: <20261106121005.1327603-1-ivecera@redhat.com>
 <20261106121005.1327603-6-ivecera@redhat.com>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20261106121005.1327603-6-ivecera@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TLP7OXgWbT_uIR4CzrpXnJrPhXvglJov6BbP1fR8Hb4_1794313450
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/6/26 1:10 PM, Ivan Vecera wrote:
> Driver callbacks are now serialized by domain locks, so dpll_lock only has
> to protect the topology and lifetime of devices and pins.
> 
> Convert it to an rwsem. Core functions changing the topology take it for
> write. Netlink requests, each part of a dump and change notifications take
> it for read, for their whole duration, so objects found by a lookup stay
> valid. This is the patch that lets callbacks of different domains run
> concurrently.
> 
> A callback running for long still blocks topology changes, and a waiting
> writer blocks new readers, so a stuck callback stalls the subsystem while
> a device is being probed or removed. This is no worse than the global
> serialization it replaces.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/dpll_core.c    | 93 +++++++++++++++++--------------------
>   drivers/dpll/dpll_core.h    |  3 +-
>   drivers/dpll/dpll_netlink.c | 32 ++++++-------
>   3 files changed, 61 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
> index dd09f528170994..8eb74682343156 100644
> --- a/drivers/dpll/dpll_core.c
> +++ b/drivers/dpll/dpll_core.c
> @@ -19,8 +19,12 @@
>   #include "dpll_core.h"
>   #include "dpll_netlink.h"
>   
> -/* Mutex lock to protect DPLL subsystem devices and pins */
> -DEFINE_MUTEX(dpll_lock);
> +/* Protects the topology and lifetime of DPLL devices and pins. Taken for write
> + * to change them and for read for the whole netlink request, part of a dump or
> + * change notification that uses them. Driver callbacks are serialized by domain
> + * locks, which are only taken under this lock.
> + */
> +DECLARE_RWSEM(dpll_lock);
>   
>   DEFINE_XARRAY_FLAGS(dpll_device_xa, XA_FLAGS_ALLOC);
>   DEFINE_XARRAY_FLAGS(dpll_pin_xa, XA_FLAGS_ALLOC);
> @@ -459,7 +463,7 @@ dpll_device_get(u64 clock_id, u32 device_idx, struct module *module,
>   	struct dpll_device *dpll, *ret = NULL;
>   	unsigned long index;
>   
> -	mutex_lock(&dpll_lock);
> +	down_write(&dpll_lock);
>   	xa_for_each(&dpll_device_xa, index, dpll) {
>   		if (dpll->clock_id == clock_id &&
>   		    dpll->device_idx == device_idx &&
> @@ -475,7 +479,7 @@ dpll_device_get(u64 clock_id, u32 device_idx, struct module *module,
>   			dpll_device_tracker_alloc(ret, tracker);
>   	}
>   
> -	mutex_unlock(&dpll_lock);
> +	up_write(&dpll_lock);
>   
>   	return ret;
>   }
> @@ -492,9 +496,9 @@ EXPORT_SYMBOL_GPL(dpll_device_get);
>    */
>   void dpll_device_put(struct dpll_device *dpll, dpll_tracker *tracker)
>   {
> -	mutex_lock(&dpll_lock);
> +	down_write(&dpll_lock);
>   	__dpll_device_put(dpll, tracker);
> -	mutex_unlock(&dpll_lock);
> +	up_write(&dpll_lock);
>   }
>   EXPORT_SYMBOL_GPL(dpll_device_put);
>   
> @@ -540,16 +544,16 @@ int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
>   	if (WARN_ON(type < DPLL_TYPE_PPS || type > DPLL_TYPE_MAX))
>   		return -EINVAL;
>   
> -	mutex_lock(&dpll_lock);
> +	down_write(&dpll_lock);
>   	reg = dpll_device_registration_find(dpll, ops, priv);
>   	if (reg) {
> -		mutex_unlock(&dpll_lock);
> +		up_write(&dpll_lock);
>   		return -EEXIST;
>   	}
>   
>   	reg = kzalloc_obj(*reg);
>   	if (!reg) {
> -		mutex_unlock(&dpll_lock);
> +		up_write(&dpll_lock);
>   		return -ENOMEM;
>   	}
>   	reg->ops = ops;
> @@ -559,13 +563,13 @@ int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
>   	first_registration = list_empty(&dpll->registration_list);
>   	list_add_tail(&reg->list, &dpll->registration_list);
>   	if (!first_registration) {
> -		mutex_unlock(&dpll_lock);
> +		up_write(&dpll_lock);
>   		return 0;
>   	}
>   
>   	xa_set_mark(&dpll_device_xa, dpll->id, DPLL_REGISTERED);
>   	dpll_device_create_ntf(dpll);
> -	mutex_unlock(&dpll_lock);
> +	up_write(&dpll_lock);
>   
>   	return 0;
>   }
> @@ -586,12 +590,12 @@ void dpll_device_unregister(struct dpll_device *dpll,
>   {
>   	struct dpll_device_registration *reg;
>   
> -	mutex_lock(&dpll_lock);
> +	down_write(&dpll_lock);
>   	ASSERT_DPLL_REGISTERED(dpll);
>   	dpll_device_delete_ntf(dpll);
>   	reg = dpll_device_registration_find(dpll, ops, priv);
>   	if (WARN_ON(!reg)) {
> -		mutex_unlock(&dpll_lock);
> +		up_write(&dpll_lock);
>   		return;
>   	}
>   	list_del(&reg->list);
> @@ -599,11 +603,11 @@ void dpll_device_unregister(struct dpll_device *dpll,
>   	kfree(reg);
>   
>   	if (!list_empty(&dpll->registration_list)) {
> -		mutex_unlock(&dpll_lock);
> +		up_write(&dpll_lock);
>   		return;
>   	}
>   	xa_clear_mark(&dpll_device_xa, dpll->id, DPLL_REGISTERED);
> -	mutex_unlock(&dpll_lock);
> +	up_write(&dpll_lock);
>   }
>   EXPORT_SYMBOL_GPL(dpll_device_unregister);
>   
> @@ -771,9 +775,9 @@ int register_dpll_notifier(struct notifier_block *nb)
>   {
>   	int ret;
>   
> -	mutex_lock(&dpll_lock);
> +	down_write(&dpll_lock);
>   	ret = raw_notifier_chain_register(&dpll_notifier_chain, nb);
> -	mutex_unlock(&dpll_lock);
> +	up_write(&dpll_lock);
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(register_dpll_notifier);
> @@ -782,9 +786,9 @@ int unregister_dpll_notifier(struct notifier_block *nb)
>   {
>   	int ret;
>   
> -	mutex_lock(&dpll_lock);
> +	down_write(&dpll_lock);
>   	ret = raw_notifier_chain_unregister(&dpll_notifier_chain, nb);
> -	mutex_unlock(&dpll_lock);
> +	up_write(&dpll_lock);
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(unregister_dpll_notifier);
> @@ -812,7 +816,7 @@ dpll_pin_get(u64 clock_id, u32 pin_idx, struct module *module,
>   	struct dpll_pin *pos, *ret = NULL;
>   	unsigned long i;
>   
> -	mutex_lock(&dpll_lock);
> +	down_write(&dpll_lock);
>   	xa_for_each(&dpll_pin_xa, i, pos) {
>   		if (pos->clock_id == clock_id &&
>   		    pos->pin_idx == pin_idx &&
> @@ -827,7 +831,7 @@ dpll_pin_get(u64 clock_id, u32 pin_idx, struct module *module,
>   		if (!IS_ERR(ret))
>   			dpll_pin_tracker_alloc(ret, tracker);
>   	}
> -	mutex_unlock(&dpll_lock);
> +	up_write(&dpll_lock);
>   
>   	return ret;
>   }
> @@ -844,9 +848,9 @@ EXPORT_SYMBOL_GPL(dpll_pin_get);
>    */
>   void dpll_pin_put(struct dpll_pin *pin, dpll_tracker *tracker)
>   {
> -	mutex_lock(&dpll_lock);
> +	down_write(&dpll_lock);
>   	__dpll_pin_put(pin, tracker);
> -	mutex_unlock(&dpll_lock);
> +	up_write(&dpll_lock);
>   }
>   EXPORT_SYMBOL_GPL(dpll_pin_put);
>   
> @@ -859,10 +863,10 @@ EXPORT_SYMBOL_GPL(dpll_pin_put);
>    */
>   void dpll_pin_fwnode_set(struct dpll_pin *pin, struct fwnode_handle *fwnode)
>   {
> -	mutex_lock(&dpll_lock);
> +	down_write(&dpll_lock);
>   	fwnode_handle_put(pin->fwnode); /* Drop fwnode previously set */
>   	pin->fwnode = fwnode_handle_get(fwnode);
> -	mutex_unlock(&dpll_lock);
> +	up_write(&dpll_lock);
>   }
>   EXPORT_SYMBOL_GPL(dpll_pin_fwnode_set);
>   
> @@ -885,7 +889,7 @@ struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode,
>   	struct dpll_pin *pin, *ret = NULL;
>   	unsigned long index;
>   
> -	mutex_lock(&dpll_lock);
> +	down_write(&dpll_lock);
>   	xa_for_each(&dpll_pin_xa, index, pin) {
>   		if (pin->fwnode == fwnode) {
>   			__dpll_pin_hold(pin, tracker);
> @@ -893,7 +897,7 @@ struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode,
>   			break;
>   		}
>   	}
> -	mutex_unlock(&dpll_lock);
> +	up_write(&dpll_lock);
>   
>   	return ret;
>   }
> @@ -950,7 +954,7 @@ dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
>   		      DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE)))
>   		return -EINVAL;
>   
> -	mutex_lock(&dpll_lock);
> +	down_write(&dpll_lock);
>   
>   	dev_ops = dpll_device_ops(dpll);
>   	if (WARN_ON(ops->measured_freq_get &&
> @@ -974,7 +978,7 @@ dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
>   
>   	ret = __dpll_pin_register(dpll, pin, ops, priv, NULL);
>   out_unlock:
> -	mutex_unlock(&dpll_lock);
> +	up_write(&dpll_lock);
>   
>   	return ret;
>   }
> @@ -1028,9 +1032,9 @@ void dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
>   	if (WARN_ON(!xa_empty(&pin->parent_refs)))
>   		return;
>   
> -	mutex_lock(&dpll_lock);
> +	down_write(&dpll_lock);
>   	__dpll_pin_unregister(dpll, pin, ops, priv, NULL);
> -	mutex_unlock(&dpll_lock);
> +	up_write(&dpll_lock);
>   }
>   EXPORT_SYMBOL_GPL(dpll_pin_unregister);
>   
> @@ -1064,7 +1068,7 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
>   	    WARN_ON(!ops->direction_get))
>   		return -EINVAL;
>   
> -	mutex_lock(&dpll_lock);
> +	down_write(&dpll_lock);
>   	ret = dpll_xa_ref_pin_add(&pin->parent_refs, parent, ops, priv, pin);
>   	if (ret)
>   		goto unlock;
> @@ -1076,7 +1080,7 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
>   		}
>   		dpll_pin_create_ntf(pin, parent->clock_id);
>   	}
> -	mutex_unlock(&dpll_lock);
> +	up_write(&dpll_lock);
>   
>   	return ret;
>   
> @@ -1089,7 +1093,7 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
>   		}
>   	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
>   unlock:
> -	mutex_unlock(&dpll_lock);
> +	up_write(&dpll_lock);
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(dpll_pin_on_pin_register);
> @@ -1111,7 +1115,7 @@ void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin *pin,
>   	struct dpll_pin_ref *ref;
>   	unsigned long i;
>   
> -	mutex_lock(&dpll_lock);
> +	down_write(&dpll_lock);
>   	xa_for_each(&pin->dpll_refs, i, ref) {
>   		reg = dpll_pin_registration_find(ref, ops, priv, parent);
>   		if (!reg)
> @@ -1120,7 +1124,7 @@ void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin *pin,
>   		__dpll_pin_unregister(ref->dpll, pin, ops, priv, parent);
>   	}
>   	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
> -	mutex_unlock(&dpll_lock);
> +	up_write(&dpll_lock);
>   }
>   EXPORT_SYMBOL_GPL(dpll_pin_on_pin_unregister);
>   
> @@ -1141,13 +1145,13 @@ int dpll_pin_ref_sync_pair_add(struct dpll_pin *pin,
>   {
>   	int ret;
>   
> -	mutex_lock(&dpll_lock);
> +	down_write(&dpll_lock);
>   	ret = xa_insert(&pin->ref_sync_pins, ref_sync_pin->id,
>   			ref_sync_pin, GFP_KERNEL);
>   	mutex_lock(&pin->domain->lock);
>   	__dpll_pin_change_ntf(pin);
>   	mutex_unlock(&pin->domain->lock);
> -	mutex_unlock(&dpll_lock);
> +	up_write(&dpll_lock);
>   
>   	return ret;
>   }
> @@ -1254,23 +1258,12 @@ const struct dpll_pin_ops *dpll_pin_ops(struct dpll_pin_ref *ref)
>   
>   static int __init dpll_init(void)
>   {
> -	int ret;
> -
> -	ret = genl_register_family(&dpll_nl_family);
> -	if (ret)
> -		goto error;
> -
> -	return 0;
> -
> -error:
> -	mutex_destroy(&dpll_lock);
> -	return ret;
> +	return genl_register_family(&dpll_nl_family);
>   }
>   
>   static void __exit dpll_exit(void)
>   {
>   	genl_unregister_family(&dpll_nl_family);
> -	mutex_destroy(&dpll_lock);
>   }
>   
>   subsys_initcall(dpll_init);
> diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
> index 630c5a1ca572c2..e212e53528e33b 100644
> --- a/drivers/dpll/dpll_core.h
> +++ b/drivers/dpll/dpll_core.h
> @@ -12,6 +12,7 @@
>   #include <linux/mutex.h>
>   #include <linux/refcount.h>
>   #include <linux/ref_tracker.h>
> +#include <linux/rwsem.h>
>   #include "dpll_nl.h"
>   
>   #define DPLL_REGISTERED		XA_MARK_1
> @@ -129,7 +130,7 @@ const struct dpll_pin_ops *dpll_pin_ops(struct dpll_pin_ref *ref);
>   struct dpll_pin_ref *dpll_xa_ref_dpll_first(struct xarray *xa_refs);
>   extern struct xarray dpll_device_xa;
>   extern struct xarray dpll_pin_xa;
> -extern struct mutex dpll_lock;
> +extern struct rw_semaphore dpll_lock;
>   
>   void dpll_device_notify(struct dpll_device *dpll, unsigned long action);
>   void dpll_pin_notify(struct dpll_pin *pin, u64 src_clock_id,
> diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
> index 1b4e3a0166a744..9d8f5d1ce97248 100644
> --- a/drivers/dpll/dpll_netlink.c
> +++ b/drivers/dpll/dpll_netlink.c
> @@ -910,11 +910,11 @@ int dpll_device_change_ntf(struct dpll_device *dpll)
>   {
>   	int ret;
>   
> -	mutex_lock(&dpll_lock);
> +	down_read(&dpll_lock);
>   	mutex_lock(&dpll->domain->lock);
>   	ret = __dpll_device_change_ntf(dpll);
>   	mutex_unlock(&dpll->domain->lock);
> -	mutex_unlock(&dpll_lock);
> +	up_read(&dpll_lock);
>   
>   	return ret;
>   }
> @@ -1004,11 +1004,11 @@ int dpll_pin_change_ntf(struct dpll_pin *pin)
>   {
>   	int ret;
>   
> -	mutex_lock(&dpll_lock);
> +	down_read(&dpll_lock);
>   	mutex_lock(&pin->domain->lock);
>   	ret = __dpll_pin_change_ntf(pin);
>   	mutex_unlock(&pin->domain->lock);
> -	mutex_unlock(&dpll_lock);
> +	up_read(&dpll_lock);
>   
>   	return ret;
>   }
> @@ -1795,7 +1795,7 @@ int dpll_nl_pin_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>   	unsigned long i;
>   	int ret = 0;
>   
> -	mutex_lock(&dpll_lock);
> +	down_read(&dpll_lock);
>   	xa_for_each_marked_start(&dpll_pin_xa, i, pin, DPLL_REGISTERED,
>   				 ctx->idx) {
>   		if (!dpll_pin_available(pin))
> @@ -1821,7 +1821,7 @@ int dpll_nl_pin_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>   		}
>   		genlmsg_end(skb, hdr);
>   	}
> -	mutex_unlock(&dpll_lock);
> +	up_read(&dpll_lock);
>   
>   	if (ret == -EMSGSIZE) {
>   		ctx->idx = i;
> @@ -2019,7 +2019,7 @@ int dpll_nl_device_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>   	unsigned long i;
>   	int ret = 0;
>   
> -	mutex_lock(&dpll_lock);
> +	down_read(&dpll_lock);
>   	xa_for_each_marked_start(&dpll_device_xa, i, dpll, DPLL_REGISTERED,
>   				 ctx->idx) {
>   		hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
> @@ -2038,7 +2038,7 @@ int dpll_nl_device_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>   		}
>   		genlmsg_end(skb, hdr);
>   	}
> -	mutex_unlock(&dpll_lock);
> +	up_read(&dpll_lock);
>   
>   	if (ret == -EMSGSIZE) {
>   		ctx->idx = i;
> @@ -2056,7 +2056,7 @@ int dpll_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>   	if (GENL_REQ_ATTR_CHECK(info, DPLL_A_ID))
>   		return -EINVAL;
>   
> -	mutex_lock(&dpll_lock);
> +	down_read(&dpll_lock);
>   	id = nla_get_u32(info->attrs[DPLL_A_ID]);
>   	dpll = dpll_device_get_by_id(id);
>   	if (!dpll) {
> @@ -2067,7 +2067,7 @@ int dpll_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>   	mutex_lock(&dpll->domain->lock);
>   	return 0;
>   unlock:
> -	mutex_unlock(&dpll_lock);
> +	up_read(&dpll_lock);
>   	return -ENODEV;
>   }
>   
> @@ -2077,14 +2077,14 @@ void dpll_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>   	struct dpll_device *dpll = info->user_ptr[0];
>   
>   	mutex_unlock(&dpll->domain->lock);
> -	mutex_unlock(&dpll_lock);
> +	up_read(&dpll_lock);
>   }
>   
>   int
>   dpll_lock_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>   	       struct genl_info *info)
>   {
> -	mutex_lock(&dpll_lock);
> +	down_read(&dpll_lock);
>   
>   	return 0;
>   }
> @@ -2093,7 +2093,7 @@ void
>   dpll_unlock_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>   		 struct genl_info *info)
>   {
> -	mutex_unlock(&dpll_lock);
> +	up_read(&dpll_lock);
>   }
>   
>   int dpll_pin_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
> @@ -2102,7 +2102,7 @@ int dpll_pin_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>   	struct dpll_pin *pin;
>   	int ret;
>   
> -	mutex_lock(&dpll_lock);
> +	down_read(&dpll_lock);
>   	if (GENL_REQ_ATTR_CHECK(info, DPLL_A_PIN_ID)) {
>   		ret = -EINVAL;
>   		goto unlock_dev;
> @@ -2119,7 +2119,7 @@ int dpll_pin_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>   	return 0;
>   
>   unlock_dev:
> -	mutex_unlock(&dpll_lock);
> +	up_read(&dpll_lock);
>   	return ret;
>   }
>   
> @@ -2129,5 +2129,5 @@ void dpll_pin_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>   	struct dpll_pin *pin = info->user_ptr[0];
>   
>   	mutex_unlock(&pin->domain->lock);
> -	mutex_unlock(&dpll_lock);
> +	up_read(&dpll_lock);
>   }

Reviewed-by: Petr Oros <poros@redhat.com>

