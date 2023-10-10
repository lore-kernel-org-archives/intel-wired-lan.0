Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962F5CD68F5
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Oct 2023 07:44:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 28A0960B13;
	Tue, 10 Oct 2023 07:44:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 28A0960B13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1696923851;
	bh=IHAffNqTxtxSBzGfZVW6U+e6tWhTlrQUufDC0RelEUI=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=kChudz16r2zkeay+Jr2w/bhxqV+vmbzWTxv4UcZtMVRPo2Hu+QPLRfrKsg8g1LxWd
	 ppO7Aw9gXwoImzGATv5F76DGKz161kfvAzddLfTm8O8Ls7trE/6wBzuzJUmwAxrv62
	 GJpv0vYc4XAs1GGDd+vlJGcwx3FYFXRQ4PWGMtrWSlMdqD33PkNXmEOydOi1lsOHVo
	 o0hGQg4lVvxBM306uy9S3GJQ+Jj4GpIldUuGYM1Nvf6cl/0eAxsroBd8k5DY0EoPQW
	 vKBJYOyVNBEdqUzOtZN27Ir0pAwPHar/naKwDbCHufASSEPGeKygkvrrzYIWB+/uz/
	 B2P0HyzR6bgNQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tu2tgfEM9n_S; Tue, 10 Oct 2023 07:44:10 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E528611A5;
	Tue, 10 Oct 2023 07:44:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2E528611A5
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id A2E6A1BF307
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Oct 2023 07:44:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7A32C81F98
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Oct 2023 07:44:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7A32C81F98
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0E5DWdLTbTcA for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Oct 2023 07:44:06 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 08D9F81FAA
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Oct 2023 07:44:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 08D9F81FAA
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5334d78c5f6so9183527a12.2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Oct 2023 00:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696923843; x=1697528643;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QVEQlE8CCIVwnGqK4YUqVY53iGiWzOI0vN++OTPijXI=;
 b=vUfCV/T/g5RSnbus9tJNUgLBpyCcTpRsATazlIS5E/QqGPrKyXwluwqvQAx0/QQQ4O
 9pzUod2lnKGAum71Zf+DvfyhEYm0cSbGw6P3XIL/gMqgQ355ghUSRIQWHpxDIjp8B+31
 r2QlYRCOuQvdxSz2bXeJ8UMEX7ZR+NCG2+864om9O/EGcLwea+wll9PYMHJaeYEuQT47
 NnubxgLHYpbbgCYCnAHz26ybwDGt+5clXShkbwK44g1NeLOtC32nF+KaTOVpVMM+D/hu
 3FdLH5G+VNG4IkM9eHs8t+hSjLM7Ct56AClvOY4DuX58fkBhD5Z8+OrtURdQob1Oq4wA
 MLZA==
X-Gm-Message-State: AOJu0YzjtUZd9EHFFeOLltH+oY5FAMUx040Ncy/Up8QwCLMAoLIsaVVn
 xuBRfwnHEuztzpkCCkjah1mtnw==
X-Google-Smtp-Source: AGHT+IFL1RLTSKOpPDsX7c9Y6kK6SnX0Eigk+JI0p0u06K7LwkxKxcdtMGpejJCVdqaTlJBwab2cTA==
X-Received: by 2002:a05:6402:1257:b0:530:c363:449c with SMTP id
 l23-20020a056402125700b00530c363449cmr13150716edw.40.1696923842725; 
 Tue, 10 Oct 2023 00:44:02 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net.
 [213.179.129.39]) by smtp.gmail.com with ESMTPSA id
 o14-20020aa7c50e000000b0052595b17fd4sm7153292edq.26.2023.10.10.00.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 00:44:02 -0700 (PDT)
Date: Tue, 10 Oct 2023 09:44:00 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Message-ID: <ZSUAwPOy8HAsB4+8@nanopsycho>
References: <20231009222616.12163-1-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231009222616.12163-1-arkadiusz.kubalewski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696923843; x=1697528643;
 darn=lists.osuosl.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QVEQlE8CCIVwnGqK4YUqVY53iGiWzOI0vN++OTPijXI=;
 b=FhCmdb2Ffj8eO4+twB6zDaolP6kAoxCZUFYCgKiJw3dPCEFfieV3IPaPd9pT10lYtZ
 MWvPQc4I0ohqovqMPicOyJXmqadybXot0bLJ3bP4z7iGhc4QbjYMYSh9tm4uJMv9dKOQ
 PZt3x1UQ4fKbfNwt3A815SHu6hTMZ6InJ09Mdimuzjlx2ZvC4/GxVIdslPqgXiTgWh/m
 jANqldp4bTXMbdorepAj3SqtXPR6iZXzxSq3ISc9OwwfVtjyar+xxeczaKnw4L/o5J/2
 G+c9onHfUYKvFJJwXw/tZvAuk5MKmEQEOscYujIWHE562wL0PQgzhik+KJOUKZ9R3ZR6
 iF1g==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com
 header.i=@resnulli-us.20230601.gappssmtp.com header.a=rsa-sha256
 header.s=20230601 header.b=FhCmdb2F
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 0/5] dpll: add
 phase-offset and phase-adjust
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
Cc: vadim.fedorenko@linux.dev, corbet@lwn.net, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Tue, Oct 10, 2023 at 12:26:11AM CEST, arkadiusz.kubalewski@intel.com wrote:
>Improve monitoring and control over dpll devices.
>Allow user to receive measurement of phase difference between signals
>on pin and dpll (phase-offset).
>Allow user to receive and control adjustable value of pin's signal
>phase (phase-adjust).
>
>v3->v4:
>- do not increase do version of uAPI header as it is not needed (v3 did
>  not have this change)
>- fix spelling around commit messages, argument descriptions and docs
>- add missing extack errors on failure set callbacks for pin phase
>  adjust and frequency
>- remove ice check if value is already set, now redundant as checked in
>  the dpll subsystem
>
>v2->v3:
>- do not increase do version of uAPI header as it is not needed
>
>v1->v2:
>- improve handling for error case of requesting the phase adjust set
>- align handling for error case of frequency set request with the
>approach introduced for phase adjust
>
>
>Arkadiusz Kubalewski (5):
>  dpll: docs: add support for pin signal phase offset/adjust
>  dpll: spec: add support for pin-dpll signal phase offset/adjust
>  dpll: netlink/core: add support for pin-dpll signal phase
>    offset/adjust
>  ice: dpll: implement phase related callbacks
>  dpll: netlink/core: change pin frequency set behavior


I'm fine with the set at is now. Thanks!
set-
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
