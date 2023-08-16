Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEA5C25B4F
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Aug 2023 20:38:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E5FBB60D89;
	Wed, 16 Aug 2023 20:38:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E5FBB60D89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692218285;
	bh=ExUGBayvjm+Tmbqic4dKAtaDpsajNAcslGMm4TVjupg=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=VVzQjUHb7xtSwvL5wHYIWcXnF5nViTL+5j+dcX+/7f9M8uQTsPRHtT64YHdTi1oQp
	 e83Ki3qfbFsum7ttgOEH4EwRe2/Irs64Tc0AfKuGvPKe7fffP1cZ15IBiEHPMUFT8F
	 6YgYI9de2XWpq3BLHzDpjAY7llM4Kvic7jT3hZWxlXntfhcERMC+N0DoeZQcYCcDZ3
	 nwBSkAxOU4gIE4bc8Akc/Ma/QgpYpE2pPbdsUxCMaO50f7dxYPWuM69FTEKGaNYSBW
	 AR88CtlLZj8sEG24rcr7tZ/l5o/mDu78a9radO9NKu+xcEfUIkupBArA5iZNV85C65
	 F9t+InVS5iJQg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dSzdYJYGiyNq; Wed, 16 Aug 2023 20:38:05 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 07DDF613F7;
	Wed, 16 Aug 2023 20:38:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 07DDF613F7
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 1D3571BF381
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Aug 2023 20:38:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E876642118
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Aug 2023 20:38:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E876642118
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 18cR17Uc8omJ for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Aug 2023 20:38:03 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1D68C42115
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Aug 2023 20:38:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1D68C42115
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68878ca7ca0so1289164b3a.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Aug 2023 13:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692218282; x=1692823082;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cJIlP+1/qA6fcDc2Mru+2eZCt7jBZOXqJQckio1X6xc=;
 b=mHMYkcPjMQ1QtYcF/0IoEihw+9O0UjdnqQ6qUVkhbsBBeHIOUHloUOozNTLzMsUJW9
 Yommm84iWj6Oivq5PBmitOEsUIJkuVqQ7E1YcUL8imuZDKjh2ONQ7eIYc9MdlnFM2Nhp
 M00rhejPmDMCHuFSVYZdUnp8GlCEPhcGvIAbfL7fdaAMLdXECrZedQR7YXxBfhdCSyNc
 AzCGKPNd3mX8RdjktT44IWKOkgZjLHU0TNe3Bd22jesqnl71Vi8nP2D/agD4IURXWqqB
 Hnetp0Gje6ekxIG07jRgStAwSysd5yp0Z5kBGpECGPacul1Wbra3YxKFMdRiSZYMNzRZ
 Emmg==
X-Gm-Message-State: AOJu0YxgyEJxcHpON3FIQ0d1+RQNyHKqLRdrO7V/l51psVdaBUI7YUB+
 oJf+gICDMpJHICm9HtF0dq55WQ==
X-Google-Smtp-Source: AGHT+IGD+Plh3BsUd0TQTpVgaXEavYIMr8Q2oQgh+U/utLjGSkkg77n0HL7nHAFnesuGqd5CBWellg==
X-Received: by 2002:a05:6a00:3a03:b0:679:bc89:e5b with SMTP id
 fj3-20020a056a003a0300b00679bc890e5bmr2845336pfb.19.1692218282505; 
 Wed, 16 Aug 2023 13:38:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net.
 [198.0.35.241]) by smtp.gmail.com with ESMTPSA id
 24-20020aa79218000000b00682d79199e7sm11427546pfo.200.2023.08.16.13.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 13:38:01 -0700 (PDT)
Date: Wed, 16 Aug 2023 13:38:01 -0700
From: Kees Cook <keescook@chromium.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Message-ID: <202308161337.975C93F163@keescook>
References: <20230816140623.452869-1-przemyslaw.kitszel@intel.com>
 <20230816140623.452869-2-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230816140623.452869-2-przemyslaw.kitszel@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692218282; x=1692823082;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cJIlP+1/qA6fcDc2Mru+2eZCt7jBZOXqJQckio1X6xc=;
 b=IQAAyoMIMRMlYm4RH2Fzi0XDoBtqTCbmQjx89YHvHuV4+MfX7axqYeLaL+9hO0U0Ue
 v1EkYDflL9QccT+IKePO0WZ/Hqy7WO3phw96Xo2MEp8AqDkuie8yKmXorIiCu+WuNbb3
 H6g0i7Udm+oGcKdpmnwMLhRnccBHsLiaQvkI4=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=IQAAyoMI
Subject: Re: [Intel-wired-lan] [PATCH net-next v3 1/7] overflow: add
 DEFINE_FLEX() for on-stack allocs
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: netdev@vger.kernel.org, Steven Zou <steven.zou@intel.com>,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Aug 16, 2023 at 10:06:17AM -0400, Przemek Kitszel wrote:
> Add DEFINE_FLEX() macro for on-stack allocations of structs with
> flexible array member.
> 
> Expose __struct_size() macro outside of fortify-string.h, as it could be
> used to read size of structs allocated by DEFINE_FLEX().
> Move __member_size() alongside it.
> -Kees
> 
> Using underlying array for on-stack storage lets us to declare
> known-at-compile-time structures without kzalloc().
> 
> Actual usage for ice driver is in following patches of the series.
> 
> Missing __has_builtin() workaround is moved up to serve also assembly
> compilation with m68k-linux-gcc, see [1].
> Error was (note the .S file extension):
> In file included from ../include/linux/linkage.h:5,
>                  from ../arch/m68k/fpsp040/skeleton.S:40:
> ../include/linux/compiler_types.h:331:5: warning: "__has_builtin" is not defined, evaluates to 0 [-Wundef]
>   331 | #if __has_builtin(__builtin_dynamic_object_size)
>       |     ^~~~~~~~~~~~~
> ../include/linux/compiler_types.h:331:18: error: missing binary operator before token "("
>   331 | #if __has_builtin(__builtin_dynamic_object_size)
>       |                  ^

Looks good to me! Thanks for working on this. :)

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
