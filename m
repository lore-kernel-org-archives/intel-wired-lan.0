Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DF3FF886D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 28 Apr 2026 14:19:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 33C3483C6A;
	Tue, 28 Apr 2026 14:19:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eMpbs4GeMX1K; Tue, 28 Apr 2026 14:19:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A837983C54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777385976;
	bh=phN5F8mLcoCvE/uTX/spuQix6+rfPB7/DUcXpG7XTqI=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SNBWr9It8bcN8zgOeSCO+aQUM42pxZYVDbIdifjlTQL5rpjiJawGFR/wYSSoaMOox
	 BsLVWmlkSCdgijovnr1wDYxRJfNVvF0YWJUwG6ywRQqsXKE/xgXSgykNDuDKGt5qQt
	 e+urMWYd1EE/aCIr2QBzV47ZvFBlNJlxu/4DbCIuxipizbyaLObdCV7z5ZaF+DcYAn
	 8dvnhPRWef668WJp1wjrxPvqRdP8JwGVnJuw6VxbE5uXmcDOOVQg2BR3tzMt0PZcXt
	 KcR1ZofKZSZQKcZIWayHM3NIKrDFNR9qyi52uyNt55jwgC5ikwwvQo0J8M74Qv2Ef8
	 Kp34h43JJgaIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A837983C54;
	Tue, 28 Apr 2026 14:19:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DFB76231
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 14:19:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C57114046C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 14:19:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 02595052K3Xm for <intel-wired-lan@lists.osuosl.org>;
 Tue, 28 Apr 2026 14:19:33 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=jiri@resnulli.us; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 916E4403C3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 916E4403C3
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 916E4403C3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 14:19:30 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48374014a77so148581865e9.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 07:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777385968; x=1777990768;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=phN5F8mLcoCvE/uTX/spuQix6+rfPB7/DUcXpG7XTqI=;
 b=PpnBv4K0J3tF+45KITCPvESpZgdfb7fFxdbr9/aFQrBpCTYbSHmEf5gV0StC3vCnWj
 TUBCa1iq/WVfKqTCdC14syGcgGwT8mh4nXrl3JvGGLB+Taw7YwQ+gPrx/fz6523UwCqB
 pEA6MoIzQjfE30dzDjEPh0DsfQDJEBX7TylIb/NQumycGYVrQ+Ue4F6mHaQKhoCO8GpL
 X7BbsjKim+aeCGjBtqs8cG+YQzYBiz6a5IZ+bKnidPd7VjCAEWswWJiJa9vbv6ZnDVG9
 3v87nXQVJKFU0lpaSTepozuP7M/pFPyiulfvCalpVXTLvUDxntP0IZrwH6a088cMw6RZ
 515A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+znFfg43b9ZxxUYhBcgZrBE0c995xWrpAwTvwtP0FHda1hm468Q0LBEnfCYHxG1mAZ4HBB+nFymgQSZipW998=@lists.osuosl.org
X-Gm-Message-State: AOJu0YzNY24RkwRfI0e+9uCoybnC0ypFhhml5NpCb/iCiydsNRVVut/x
 dv5C20Dep38LB8Ps8hSpswk204nNdxjodXHVYmfKYYJbeuC9RkhkWWfdQYgzAnTdLlo=
X-Gm-Gg: AeBDiev3zofKy1TAaNWpqGrQ52zBHfQyNN11neGIPNkPTn1qiCQNCFRcCBKpP45kXmN
 ZVe986g1dN0pDowIqChYpgkADg95x7YTrS+wVXgQoq8goh7riz79LZGANExeiJqWDQ4Id5TE3Wj
 GZHABMVjkXtyJh46ZvGApfOuO8UMLMREAdBe2oLS6osGxbjSkJSphqZaYItrl72KEtbfGM9s3eD
 CyNT3CK9iYIUQIi70DO3DaJS3v13jYGN+qDWQQe/Nu3U816wxzJCmo57cMqd8oblUykAiPdVN+W
 0FVzwtGRzh44lPddejTDriN44EnO8XJaZKa22tGBNp9y/r0FtA8zybghMUf9RdSw8wK/PRe/gsA
 QRZaInnxjJFUwe/qeF/nPZIoRGSDrij0vO4On8gdoabhdvgNjllYblaJMJRuQ2Pl01IIerT37TU
 wefvHPXFjul142pW32Be33/mv9WX3Rtjkohco4SG8UpQ==
X-Received: by 2002:a05:600c:3b8a:b0:48a:56de:d640 with SMTP id
 5b1f17b1804b1-48a77b0a367mr58817265e9.16.1777385967866; 
 Tue, 28 Apr 2026 07:19:27 -0700 (PDT)
Received: from FV6GYCPJ69 ([85.163.81.98]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a77af1b86sm53550275e9.5.2026.04.28.07.19.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 07:19:27 -0700 (PDT)
Date: Tue, 28 Apr 2026 16:19:24 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
 intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>,
 Lukasz Czapnik <lukasz.czapnik@intel.com>, 
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Simon Horman <horms@kernel.org>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Message-ID: <afDBiwauIoLhhCcj@FV6GYCPJ69>
References: <20260428090912.3461-1-przemyslaw.kitszel@intel.com>
 <20260428090912.3461-2-przemyslaw.kitszel@intel.com>
 <afCU-3Xmole6v4X4@FV6GYCPJ69>
 <b94a55c7-3d86-47bf-8acc-b82e31766116@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b94a55c7-3d86-47bf-8acc-b82e31766116@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1777385968; x=1777990768;
 darn=lists.osuosl.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=phN5F8mLcoCvE/uTX/spuQix6+rfPB7/DUcXpG7XTqI=;
 b=ha47LhwxY6n8mITizoL3m2e1Wzso4xoqz2UQNt+IqhlTfvJ2KGiwbYbvoJQQ2wzPvS
 4xky4LuROdL/DE88UoKEwnCFAcS6gzRiQ0evVgosdh6J9qMEiFIWojEwbE9DINpTC0T/
 15xvxh2ZsYc6qYD/8NlsHMhwDc/qPFJUw6jCDOkr7CAwrEZXTNDlpxFMf/m+tOzWbuvl
 vmXWLb/i5JhMYObBTy+I4oYTkuR2y3A2ac7itzeBKCcZn1uJpPWTTgQ8wbgzd5YmImJV
 8l0xElgmUQdohWOEMDWb7LQr+DLx+KcXSHeannefWwZRbBw9lckzV/2PTFtRwqGN1eRg
 fSWA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=resnulli.us
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=resnulli-us.20251104.gappssmtp.com
 header.i=@resnulli-us.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=ha47Lhwx
Subject: Re: [Intel-wired-lan] [PATCH net-next 1/2] devlink,
 mlx5: add init/fini ops for shared devlink
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

Tue, Apr 28, 2026 at 03:44:54PM +0200, przemyslaw.kitszel@intel.com wrote:
>On 4/28/26 13:10, Jiri Pirko wrote:
>> Tue, Apr 28, 2026 at 11:09:11AM +0200, przemyslaw.kitszel@intel.com wrote:
>> > Add .shd_init() and .shd_fini() ops, that will be called for the first
>> > devlink_shd_get() (to initialize driver' priv data) and on the last
>> > devlink_shd_put() (to allow for the cleanup). Both ops are optional.
>> > 
>> > .shd_init() could return an error, which will stop creation of shd
>> > instance. The initializer also gets an additional, optional param,
>> > that driver could use for any needs.
>> > 
>> > If any of the callbacks will need to get devlink instance, it could
>> > be accessed by shd_priv_to_devlink().
>> > 
>> > Both callbacks are called with devl_lock held and devlink registered.
>> > 
>> > Next commit will make use of the callbacks, another one will make use also
>> > of the non-null additional param (outside of this series).
>> > 
>> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>> > Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> > ---
>> > first discussed at:
>> > https://lore.kernel.org/netdev/20260325063143.261806-3-przemyslaw.kitszel@intel.com
>> > 
>> > Sashiko suggested to convert devlink_shd_create() to return ERR_PTR(),
>> > and propagate that up to the driver. It think it will just make code more
>> > verbose for not much benefit. And drivers could just store err if they
>> > want in the passed @init_param.
>> > 
>> > ---
>> > include/net/devlink.h                         | 26 +++++++++++++
>> > .../ethernet/mellanox/mlx5/core/sh_devlink.c  |  2 +-
>> > net/devlink/sh_dev.c                          | 39 ++++++++++++++++++-
>> > 3 files changed, 64 insertions(+), 3 deletions(-)
>> > 
>> > diff --git a/include/net/devlink.h b/include/net/devlink.h
>> > index bcd31de1f890..5d3a1337bfa1 100644
>> > --- a/include/net/devlink.h
>> > +++ b/include/net/devlink.h
>> > @@ -1586,6 +1586,30 @@ struct devlink_ops {
>> > 				    struct devlink_rate *parent,
>> > 				    void *priv_child, void *priv_parent,
>> > 				    struct netlink_ext_ack *extack);
>> > +
>> > +	/**
>> > +	 * shd_init: Shared devlink instance initializer
>> > +	 * @priv: shd_devlink' priv
>> > +	 * @init_param: additional param to pass to driver callback
>> > +	 *
>> > +	 * Called once when the shared instance is first created (by the first
>> > +	 * devlink_shd_get() call).
>> > +	 * Should initialize the driver's private data embedded in the shared
>> > +	 * devlink. May be NULL.
>> > +	 *
>> > +	 * Return: 0 on success, negative to prevent shared instance usage.
>> > +	 */
>> > +	int (*shd_init)(void *priv, void *init_param);
>> 
>> 1. "param" has specific meaning in devlink context
>> 2. You don't use the arg in driver
>> 
>> Care to drop it?
>
>I have a user for it, but it will be a separate series
>(I have already 15 patches there), will post RFC to link here
>to the user, will that work?

Add it when/if you need it, no? I still believe there might be a better
way instead of this.


>
>my intention was to not tie touching mlx code with big series for intel
>
>> 
>> Otherwise, this looks fine to me. Thanks! (small nitpick below)
>
>ack for the nit
