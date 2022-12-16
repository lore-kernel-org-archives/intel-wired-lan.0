Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184BFC4332F
	for <intel-wired-lan@archiver.kernel.org>; Fri, 16 Dec 2022 11:20:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 847BD8213C;
	Fri, 16 Dec 2022 11:20:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 847BD8213C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1671189656;
	bh=ixox0Ra57DVs/t0A1fukoewxkq4/sSCtzxmuujIdEQA=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=jOq/H42yujg6pxdctdKGUjJ/lYB0i1n790M+2aS68YGTTMLvgHhkqTYJpmNkq7BQr
	 09P+yI0X7iFPEFiluvS79BO5gNw75Mrw0AVQ8kn9GQU2a3HfOnHIYsR2R+k/QdtBju
	 y+Acx91Ka0ubQmGoU41ZU+ExCw/ApPwkLKKJRWX9q8jD8QvADGnfnYUzi5phsRn1vc
	 DpOTuJtaO+XV9NsxUdrLe43ZgvWDANO62Rghkzf7CAtx8IbN3UHvbDVwYmCYeXg2oj
	 I58yYG82MVIS82zzXSfYgM2t/Fs/IkNE//MSh5dljGbj2jvaX1iMH0ccE4Zy2/k7lL
	 s9FYrf6Bd36rg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ETwgZZAtr0gz; Fri, 16 Dec 2022 11:20:55 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82E388213E;
	Fri, 16 Dec 2022 11:20:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 82E388213E
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id B9A3F1BF2EC
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Dec 2022 11:20:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 928B741B30
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Dec 2022 11:20:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 928B741B30
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8_3hHiaY3urT for <intel-wired-lan@lists.osuosl.org>;
 Fri, 16 Dec 2022 11:20:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EC7E54192E
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EC7E54192E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Dec 2022 11:20:51 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id f18so2165912wrj.5
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Dec 2022 03:20:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c8zJd904+IXjpPodDBXcpzzovSChRn9dgEg89jVdTTc=;
 b=PPyqAL2FiqcyddDTexi7VxPsnNprXbm0g0CyLnOt7R8bjhGY/vkW0a3rmc2blMz0wQ
 19Mmpcxv4JOb0v6KnRrGJi8YYw8lRuV6Dug9IqUxk3idsusjUtaGM/IYEzXLUmtiw4F2
 em0uag+8wLGkNbOX9RwdlNVYvz+guaOcG4Trwf0gJNV2SaIXEgu1II1R6qzmy2WlyqFA
 wrTDmDluVbxkz9lNuDKSf0HE3OUswRG+ladpAuZY52fP3CgwrRvKH8sqZtPvM1LJ6fG9
 P23+4b3SsXePVXXZtUyoD8wVJQUymah4iH1uCl/47moUqvanHg3EwayQcrHupvcTNwYl
 Hcmw==
X-Gm-Message-State: ANoB5pk/R9WvWxvj3GwL5GpLYx8hsss/4vXfvrpYyfDd/UMhKj7mxUZ+
 DEpDr0Lgl/34UXH0rD+yDbof3A==
X-Google-Smtp-Source: AA0mqf5FTRHlnyovbIiVic0ZLreeNyr+YqX6ewUwMmrnndfqEH8iic7W9jiQeCVaZIQ65MZg/fR77Q==
X-Received: by 2002:a05:6000:1d9c:b0:242:7eb8:37bf with SMTP id
 bk28-20020a0560001d9c00b002427eb837bfmr21996245wrb.32.1671189649772; 
 Fri, 16 Dec 2022 03:20:49 -0800 (PST)
Received: from localhost ([86.61.181.4]) by smtp.gmail.com with ESMTPSA id
 1-20020a05600c228100b003d23928b654sm9042343wmf.11.2022.12.16.03.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Dec 2022 03:20:48 -0800 (PST)
Date: Fri, 16 Dec 2022 12:20:48 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Message-ID: <Y5xUkA1WlFX4UhzR@nanopsycho>
References: <20221216091326.1457454-1-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221216091326.1457454-1-d-tatianin@yandex-team.ru>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20210112.gappssmtp.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c8zJd904+IXjpPodDBXcpzzovSChRn9dgEg89jVdTTc=;
 b=rwC753FZsDUgTG4iIcy926S69sXY8sUHPwYod7qj6vcU/Aab3GdkOxs2e0mkNILo40
 EuzGZWQSs+t9TFGViBP0HMSn2f5NA0pEON7drTGWJabe53fS/hClSpNaQd2IHD68Ljri
 XQ/yG4C+pacM8BubKRno+Iln+lJnd55/H7dKp2pflYml8XZ6pfUDA3JQyAy6+Pml3p/7
 uEfIi7EiShHzKM5HwFWYeDR7ipOt1A3fcUuDkVoUp6vj6GKvo3I+3nNSrapQ++X7Sj4l
 A750lg4s57z9KiCUEsre4OyU1xmWg45pt/SAMR5e2IEFGSrA6pE2EsZrcueaM+CZeXSP
 7Q6Q==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=resnulli-us.20210112.gappssmtp.com
 header.i=@resnulli-us.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=rwC753FZ
Subject: Re: [Intel-wired-lan] [PATCH v1] iavfs/iavf_main: actually log
 ->src mask when talking about it
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
Cc: intel-wired-lan@lists.osuosl.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Jeff Kirsher <jeffrey.t.kirsher@intel.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Fri, Dec 16, 2022 at 10:13:26AM CET, d-tatianin@yandex-team.ru wrote:
>This fixes a copy-paste issue where dev_err would log the dst mask even
>though it is clearly talking about src.
>
>Found by Linux Verification Center (linuxtesting.org) with the SVACE
>static analysis tool.
>
>Fixes: 0075fa0fadd0a ("i40evf: Add support to apply cloud filters")
>Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
