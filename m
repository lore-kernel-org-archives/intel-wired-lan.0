Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6842C77B7A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 16 May 2023 19:01:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4FB7D40BDF;
	Tue, 16 May 2023 19:01:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4FB7D40BDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1684263700;
	bh=AXqGvoo5rBjKiD+01Wx+Oo69Nk64VGO3XTGm+1RXQYs=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=3RhkVLj6Vj1ZQQFKqcrH/nvdESDpHZcysB+M7yZ4OKtw88RcOKvSx+rqQZQUDHY2h
	 vJEGrD2voAhAAWWA8hsSnr8c3Vof92Fm1MVeIXCMp1lo3cVHY1ad58/LiNcyNdx4j2
	 sGSCwTFGIEJo45XXkGD9GgNmxJEvMe3d+SZp6mE06Od5qNNuZjdBge57xnLHKgnDEY
	 Zoa94yuhIK9tMCf/ZGW0CwrX8ODQjJG9whwGBooeg+66RX2HrMaNoibhVETuAe7TQE
	 7MerXh19dS2vS4xGiWD4Z2mKOxx/TcpuBisJ+Dw7QZAHX+990TCKzMyI1+PYHnl4do
	 EIY3lDfB/q5Ag==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XfLGgsJefcuv; Tue, 16 May 2023 19:01:39 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6920440BB6;
	Tue, 16 May 2023 19:01:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6920440BB6
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 37EF81BF295
 for <intel-wired-lan@lists.osuosl.org>; Tue, 16 May 2023 19:01:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1CD3E61338
 for <intel-wired-lan@lists.osuosl.org>; Tue, 16 May 2023 19:01:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1CD3E61338
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o1Uv-fISeybv for <intel-wired-lan@lists.osuosl.org>;
 Tue, 16 May 2023 19:01:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5C8AC60F2A
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5C8AC60F2A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 16 May 2023 19:01:36 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1ae4be0b1f3so208465ad.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 16 May 2023 12:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684263696; x=1686855696;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kUkmmpx1M4MtXHMNNv8IRyExX8PTEgvpMh/addFkD4o=;
 b=EGbltzSutOFcdYK34rmEbDm6zPBQ6roLnM/2SvSQfiNR/w0Nx5e5DZXPnKQO0XKWtG
 dNyQistdxWwFIsb2uJ/shN5EqOPep+EHqkDf48XTn1jBzCRQ1g7LaDYVszuMbmHquXYX
 VSm10L5aHyGvRxj7I1TZ1SM8dd34Prdw+N4nGNrkkqGsZv9OdqRRGy26MNj7ETfVmZLB
 B9yL/3bxAV7QxGnE77pBs8A2AJHNTV3dzeESISfONofm6Bzcqk9dGUSgXbsgFmwUc6UI
 1YXSJdNwpG2zJvI+UN2gUGA/pUuRidtIT6ZjVZJLFrjmCPtTM4+tUOj5jJsuvk/i2tuI
 DQNw==
X-Gm-Message-State: AC+VfDxbA0pn3HZN0XEx2yiaGMjyznuAAFxMa/htKvJB9syqKPbXmFr9
 0ZrXmBuiXkUEDoASClICSJZ1Fg==
X-Google-Smtp-Source: ACHHUZ5ZLD7j3APDOySoMJHuE3aU18Lrbi+vh403ZC/xZCJwhn9YLHMEtvqEWZXDOHofmDlW+yYTpA==
X-Received: by 2002:a17:903:2452:b0:1ad:bc86:851 with SMTP id
 l18-20020a170903245200b001adbc860851mr29197280pls.45.1684263695791; 
 Tue, 16 May 2023 12:01:35 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net.
 [198.0.35.241]) by smtp.gmail.com with ESMTPSA id
 d15-20020a170902728f00b001a69c1c78e7sm15783248pll.71.2023.05.16.12.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:01:35 -0700 (PDT)
Date: Tue, 16 May 2023 12:01:34 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Message-ID: <202305161201.4AF77552@keescook>
References: <ZGLR3H1OTgJfOdFP@work>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZGLR3H1OTgJfOdFP@work>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1684263696; x=1686855696;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kUkmmpx1M4MtXHMNNv8IRyExX8PTEgvpMh/addFkD4o=;
 b=YTcgXElpvGt3LVfiNgl5PSEl/rBXxtslgzs1wn0AulV9NHy7s3dRPgUgymNAKMd4u5
 dobM79MDBBTmVDF8lrKoENPSGJIbzl032aZ+Ie0w8hNTx80kVCt54FdiVcZ6LR+4YxjA
 L6PuoiBV9Q/FJUVAooL5QT+66KDs7lg3YwX/g=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=YTcgXElp
Subject: Re: [Intel-wired-lan] [PATCH][next] iavf: Replace one-element array
 with flexible-array member
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
 linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, May 15, 2023 at 06:44:12PM -0600, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element array with flexible-array
> member in struct iavf_qvlist_info, and refactor the rest of the code,
> accordingly.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/289
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
