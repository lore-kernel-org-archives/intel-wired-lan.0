Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370E1C3ABB2
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 May 2025 07:22:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C960280B9A;
	Wed, 28 May 2025 07:22:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0b9ojgoYF7l3; Wed, 28 May 2025 07:22:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C78D2812BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1748416921;
	bh=WaGWCYscG2gJE/9BxI7p6wq8i7SRMLbgQxHuw11S4oM=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bkU75FpMrG9JxtdvqV2tqSnIB84C7roDDiaxFR4FDgH6MyBvlyhRHdKaYnR+1t66n
	 ubgB9rzS7h4hogpbiiq5rjckqMFGZGiRxYmgTsXJe6P7QLygfQbx9/suTtPwccLzxK
	 LlEt8PtFHzWpsB3rUucvI5x2d/FkZALCZ3CPxTvFNNXJSOPobnKableQI+y2z3jrzA
	 LWaS6khj73mREJN2c/5gQfp6WhI/eWyAvPRZK+951ho3UjMO3EndJWKnck6hwr+r2v
	 YyM4YuwnUqcfjJcNslG4H5VQ/YirTDP9fo5/ff2gtyToyGEVadAgPqGWsIUP/wWj/b
	 twuFRCqkFMwWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C78D2812BD;
	Wed, 28 May 2025 07:22:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E968B66
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 May 2025 07:22:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6FF7D4076E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 May 2025 07:22:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UBR_oTcvzich for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 May 2025 07:22:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=pabeni@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C2BF540227
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C2BF540227
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C2BF540227
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 May 2025 07:21:59 +0000 (UTC)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-o2Y8fdi8OuSVHJAUMqyZMA-1; Wed, 28 May 2025 03:21:56 -0400
X-MC-Unique: o2Y8fdi8OuSVHJAUMqyZMA-1
X-Mimecast-MFC-AGG-ID: o2Y8fdi8OuSVHJAUMqyZMA_1748416915
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-442fda1cba7so19501125e9.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 May 2025 00:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748416915; x=1749021715;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WaGWCYscG2gJE/9BxI7p6wq8i7SRMLbgQxHuw11S4oM=;
 b=ho0ZwiTetFTx6q88UrwaN3ThBQI/qPRuUKngcKT5qVtk7Glx8G5Be1EqKf7s9TPwW2
 JPQLFt6bYqV/ORkcYzINado84Wo/DpD03pTOXEo5k/s2iC9Y4iXOFZqMtWXa7U4minKT
 2gNa/ZLkSIhtozdrafaQKCQ2fzRsTdfSKJHe4LKTN59KipSkmxqqq/ImF6gfB8e256OM
 uQ11IYGY68fnerzXB75qYRl0Lr24uBpz2FpFpuNoG0i8ptcwJlg89lp1Fdos32/WbIEf
 wb5hk1FU7bw5AFPegIPDGJOdObCxEUSZ+ytcBgmPYacZSfxzhe3cd79ECchtRrpuv7hr
 su1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPGiv6oyCVwf1P6pyMJCvdXcriXX4Q35u74B4g2tEmEV1QWOWrXzvxrRSVqGB2ZboMGOqGbsxXqv2ZKgN/Zps=@lists.osuosl.org
X-Gm-Message-State: AOJu0YyeSdhRID5QhHcSmRVA+a5OsVphbo4Q7pM4TP2tCoyfmecP3qxo
 /5jOYHIeeRfY0fHIYdpb/bKQ0mnw8t7CTGiXv2tJLLc6R2/g3KHnbSs+T6XkV0J7ICAmujp3iX7
 1mpFFcv6laV0VfWKlXf48lwkvdoyqdumDBsW3+LqddFNujBStYy22PUvNOr2kSRf3UG6vUB8=
X-Gm-Gg: ASbGncuolZh2BuC87gFs3V90AMYZmWXMv6++ix8uVgRMNjCaSORNp7prlIJK9VXoHns
 xrduzujFCGd9V/ZSp9J0j5aNqlbwHJyw2ul+bVzfEc4BI175X4hjMbecxP53UMhE02hOJLE2s1N
 0MZtZjZmHMPo/YosjJ5hc+LCd+lAKRGtABATK3y3qErSUDkG0VVVt6p5H4Ett18R28QW2haHhkQ
 mzwoiNClKFw+MpvdXCcTEpnbcsk+1X2RVglQ78irbFwfJWEtJs3HwF/ndEOkhsiJQj8/HJaYuhO
 Sdv+fsz/nHb5jL4CFdfW3TMifN652YzRXtyB8sMYLK4TPMP0oo2D3aGK9jM=
X-Received: by 2002:a05:600c:5011:b0:43d:fa58:8378 with SMTP id
 5b1f17b1804b1-44c94c2afbbmr135543675e9.33.1748416915216; 
 Wed, 28 May 2025 00:21:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9fCAeAfcUeAKLwTnP6W7JttQB6exfEvg0cHvk7Qq1JvXftAAhGkUc468XOpjRQE7kLJI4xQ==
X-Received: by 2002:a05:600c:5011:b0:43d:fa58:8378 with SMTP id
 5b1f17b1804b1-44c94c2afbbmr135543155e9.33.1748416914639; 
 Wed, 28 May 2025 00:21:54 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810:827d:a191:aa5f:ba2f?
 ([2a0d:3344:2728:e810:827d:a191:aa5f:ba2f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4507253b902sm8490115e9.1.2025.05.28.00.21.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 00:21:54 -0700 (PDT)
Message-ID: <0a23a584-0aac-4c6a-bca4-3e220607cae6@redhat.com>
Date: Wed, 28 May 2025 09:21:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, vadim.fedorenko@linux.dev,
 jiri@resnulli.us, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, aleksandr.loktionov@intel.com,
 milena.olech@intel.com, corbet@lwn.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org
References: <20250523154224.1510987-1-arkadiusz.kubalewski@intel.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250523154224.1510987-1-arkadiusz.kubalewski@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _gYbaw2aEO8IGhQtNexybpNdcqrlauier5AiQ6Xb938_1748416915
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1748416918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WaGWCYscG2gJE/9BxI7p6wq8i7SRMLbgQxHuw11S4oM=;
 b=fMcSmsxWj03XO8nq+n5mtc6BFVHY84T/S1uK+GvWACgJApIz94aw+s9HdXdBJWsmKmVrUz
 l0FYZarICScdFLw58i3+BUvuW7qbfPWzdDhJ8eUUurbTMhquxJr7BD1uTdu3kTe9USiEwy
 kf7ww+rU0ceizkI5Cmgvw/4ESbSzSqs=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=fMcSmsxW
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 0/3] dpll: add all inputs
 phase offset monitor
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

On 5/23/25 5:42 PM, Arkadiusz Kubalewski wrote:
> Add dpll device level feature: phase offset monitor.
> 
> Phase offset measurement is typically performed against the current active
> source. However, some DPLL (Digital Phase-Locked Loop) devices may offer
> the capability to monitor phase offsets across all available inputs.
> The attribute and current feature state shall be included in the response
> message of the ``DPLL_CMD_DEVICE_GET`` command for supported DPLL devices.
> In such cases, users can also control the feature using the
> ``DPLL_CMD_DEVICE_SET`` command by setting the ``enum dpll_feature_state``
> values for the attribute.
> 
> Implement feature support in ice driver for dpll-enabled devices.
> 
> Verify capability:
> $ ./tools/net/ynl/pyynl/cli.py \
>  --spec Documentation/netlink/specs/dpll.yaml \
>  --dump device-get
> [{'clock-id': 4658613174691613800,
>   'id': 0,
>   'lock-status': 'locked-ho-acq',
>   'mode': 'automatic',
>   'mode-supported': ['automatic'],
>   'module-name': 'ice',
>   'type': 'eec'},
>  {'clock-id': 4658613174691613800,
>   'id': 1,
>   'lock-status': 'locked-ho-acq',
>   'mode': 'automatic',
>   'mode-supported': ['automatic'],
>   'module-name': 'ice',
>   'phase-offset-monitor': 'disable',
>   'type': 'pps'}]
> 
> Enable the feature:
> $ ./tools/net/ynl/pyynl/cli.py \
>  --spec Documentation/netlink/specs/dpll.yaml \
>  --do device-set --json '{"id":1, "phase-offset-monitor":"enable"}'
> 
> Verify feature is enabled:
> $ ./tools/net/ynl/pyynl/cli.py \
>  --spec Documentation/netlink/specs/dpll.yaml \
>  --dump device-get
> [
>  [...]
>  {'capabilities': {'all-inputs-phase-offset-monitor'},
>   'clock-id': 4658613174691613800,
>   'id': 1,
>  [...]
>   'phase-offset-monitor': 'enable',
>  [...]]

I'm sorry, even if this has been posted (just) before the merge window,
I think an uAPI extension this late is a bit too dangerous, please
repost when net-next reopen after the merge window.

Thanks,

Paolo

