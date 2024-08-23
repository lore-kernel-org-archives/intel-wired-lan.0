Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2FBC52D7C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 23 Aug 2024 08:39:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 609CD410BC;
	Fri, 23 Aug 2024 08:39:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5hot3sLBqPks; Fri, 23 Aug 2024 08:39:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8847141244
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1724402398;
	bh=+e7QJLLu5Urr6Z2iktLhxsbbPJOrAtGSxxMTBcyUzm0=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=epMkLwMX26hRNgYlHuCf+JqWU+Cf2zaPK7d6VT65TpfkLckZwXnvZdA4LpI6D30pf
	 5xt66R7Dshme6aDMv/+CtOao3r1hcRfBuSvov7vcNm0CuGqtIi+55alSQh2j1QGlyo
	 bRkmvLb2OXhQE/nO1X0UGoFJxG+fECxgpGMzyLu7z6G/CxZaTYSX2jZB5THdlearA4
	 7uYv9UQyakyRVeXGGMw9aLwbagNIxouxiT7Nvjojam8nhpDw73BnXTHgzvVyawZjmG
	 jQB5qd2N1yGiVTJMUnvlda64KiBMP4ZScyNuhe8XSo0o2nDYiJdFfhmjTK608tTuq5
	 jgv9/COwImrCg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8847141244;
	Fri, 23 Aug 2024 08:39:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 70BC81BF366
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Aug 2024 08:39:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 68F9B4028D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Aug 2024 08:39:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sU5AAdhiDPq2 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 23 Aug 2024 08:39:55 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::130; helo=mail-lf1-x130.google.com;
 envelope-from=jiri@resnulli.us; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2000440217
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2000440217
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2000440217
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Aug 2024 08:39:49 +0000 (UTC)
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5334adf7249so2209300e87.3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Aug 2024 01:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724402387; x=1725007187;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+e7QJLLu5Urr6Z2iktLhxsbbPJOrAtGSxxMTBcyUzm0=;
 b=l1Gmed5tpYnT/fdTmPnUtA1HJJywZ4u79TehyYqtl5MPcQUzqDtfPaHIruViCqglVQ
 7rVk8hP/VcbQ64G8Bg7jYJyEKvEyzu56vJ/IK7uTr+xZe8Jk/WCzfDHAEN8FKbEVa1df
 Lp5PpGMePOWDBtiiJM2Qc3bxyCwIDJ5Ox5ZnpW58wq/CPKFfUkhxVYV5+aWF64OyEWjQ
 9bckpSFKMOdB78k5IblU9MrmFOnnACCqqqkp9FLsizcaVdCf7AkGdlJFnc8xxgHseHCY
 1uA5x+cabYuQH5C5+sVnZw77MeIw6dN/ApflLoOKrEP9Wh+ORdJUrkgD31I12RB26j02
 64GA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzbqqzwjTIsq/j0OnhZjOLsS5q1BFSH7HtjvTVexKagHTDXmN6LoiTDGGLvj/o0EiIlNDpEQRfo5P4bESKddc=@lists.osuosl.org
X-Gm-Message-State: AOJu0YywdvJQ7K7Hi2UVA4u56+j/6z4J2il0XvV31eLwuxj/0nfNrirZ
 lGxvvGgnflDOpu7ns+ZNBfFjib4vq+UiP4NvpYnDYfFxgCAg2/mjNsQXZvzWJlo=
X-Google-Smtp-Source: AGHT+IGOWVuOC9yeeKp5mZ4UlpcTLScCESsqL86DkbvcGyGbBm1D6i4r/hzXl4SKazXPEZkY4narSw==
X-Received: by 2002:a05:6512:ba2:b0:533:3223:df91 with SMTP id
 2adb3069b0e04-53438773a9emr1136975e87.24.1724402386504; 
 Fri, 23 Aug 2024 01:39:46 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868f2e74bbsm229799366b.95.2024.08.23.01.39.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 01:39:45 -0700 (PDT)
Date: Fri, 23 Aug 2024 10:39:44 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Message-ID: <ZshK0IEblXbjNKMh@nanopsycho.orion>
References: <20240822222513.255179-1-arkadiusz.kubalewski@intel.com>
 <20240822222513.255179-2-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822222513.255179-2-arkadiusz.kubalewski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724402387; x=1725007187;
 darn=lists.osuosl.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+e7QJLLu5Urr6Z2iktLhxsbbPJOrAtGSxxMTBcyUzm0=;
 b=Yj4tCgtTtJwtNvmhiRYz3GEwA1RyPwubiX64/N9jwW8kn57EF+EEoakj4iq412BxZr
 dOqxKWSNXzJf6hdW0FHR5ZdJHMjakG9LsAYH6YNLgK95yl7d33lIZ4gGwK09gi+Vbefs
 WvEIXVATWtTrkKo7dgIfmTd4T3ylS33vaHST6Xqxq1qlATOQrAMzcQFD+POjNVhof3LT
 gtLRXGkdIAwweK/+nPpBDGrtzZhT4FkSyCSpKv4qSMufnXqaoVf2wPZcDei6pj8Hx5ik
 cK3u9qp1kAgaoWJnW21Su54TWMDclU7ezIoVCOKNdlulGVYsm7IZPEKqV2u6LodpD10n
 NaWQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=resnulli.us
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=resnulli-us.20230601.gappssmtp.com
 header.i=@resnulli-us.20230601.gappssmtp.com header.a=rsa-sha256
 header.s=20230601 header.b=Yj4tCgtT
Subject: Re: [Intel-wired-lan] [PATCH net-next v3 1/2] dpll: add Embedded
 SYNC feature for a pin
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
 donald.hunter@gmail.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, edumazet@google.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, intel-wired-lan@lists.osuosl.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Fri, Aug 23, 2024 at 12:25:12AM CEST, arkadiusz.kubalewski@intel.com wrote:
>Implement and document new pin attributes for providing Embedded SYNC
>capabilities to the DPLL subsystem users through a netlink pin-get
>do/dump messages. Allow the user to set Embedded SYNC frequency with
>pin-set do netlink message.
>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
