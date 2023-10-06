Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8BCE81DE9
	for <intel-wired-lan@archiver.kernel.org>; Fri,  6 Oct 2023 12:49:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DEF4460B00;
	Fri,  6 Oct 2023 12:49:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DEF4460B00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1696596588;
	bh=nIx4bL1NZKynmqadC8V3nMQ+g0esAXB62Bfcx2Kh7DA=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=2Yqdpwa4ft97zA17JiSLidI+IA1tdc2RCXXnPH1gFwVtyDJt0oU9r9eTpKYIPmsAL
	 9G4xuUx8XvV41CQvEn8pgGDq3sKd079RqzL8H/E2fp7b4iQi2AI65idUvslSwWTDlr
	 fo7s0tQIt3lZyqKTfDuambJd8aDQmoJsWDZKPh2eHSZ9jlWdC4Bb3CaiLXjV9B31uw
	 XCneTyJRQUd4WGUSmYZirB0JosIOkHUZpYHZb8ugWlUxDYRJjT/4bIvdW7HAacRm5+
	 NK0YnGUbaperYyBpzsEynh656tEekkjKvSSSij8Bd075vqeJ8bJrei4Y1vFNc6zB9q
	 FoiDRqd8LVaQA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jc0XKY1I3LxF; Fri,  6 Oct 2023 12:49:47 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D1A460BEF;
	Fri,  6 Oct 2023 12:49:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9D1A460BEF
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 90EBD1BF2FF
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Oct 2023 12:49:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6399042C43
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Oct 2023 12:49:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6399042C43
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MB7ZI8-RgERg for <intel-wired-lan@lists.osuosl.org>;
 Fri,  6 Oct 2023 12:49:45 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D3C0E41932
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Oct 2023 12:49:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D3C0E41932
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40535597f01so18622725e9.3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 06 Oct 2023 05:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696596582; x=1697201382;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oHjBNst/lhil+UcE/qDI5coR6SVyilLvcP6sMcHytls=;
 b=d2N8DEdsOfNgz/wgUuo/hG2nYeeDHGuaf46fdMp8ryoAh/tQatn3F8mT/SqZlQCQo+
 RA1U09BuRic3eL8XzyQHxGLk9Z7WTIRVK4/2/yaygUrTdJXpz1S9XJks82VdkvxgyG2V
 TKGYNInmULxTHm2XySPmkfdO8q04h1bA6S9OIdGALt9VVbR85wE7l5U9gD52DTfr+Xgb
 o80jzbOYUEStZ3Ev6RMN337+gA0GYAzCG4wEmX5XXHgbv5AZlNhfkNw+Pn7jZfcmBk0c
 cpIC0GBYH1XGFsIEA5U2Ks84xAHhkfBOp4O7hxAfhV8XWyHgkYMthZ5CLigZY4xsJKfD
 KROw==
X-Gm-Message-State: AOJu0YziFQfMlC2qf8DfABXA6axKu8+ZeN+l+z/H/0OuxUCCU42YSv/7
 s6NCyhd3s25hyLlCx1TZtR52CQ==
X-Google-Smtp-Source: AGHT+IErZT4Z9JOnQab8/UPM9P5VYK8b44c4GNP61Z9e5SRanKoOeNOUL0LBngvKhNZHSCtY36Ax5g==
X-Received: by 2002:adf:ecd2:0:b0:317:e1fb:d57b with SMTP id
 s18-20020adfecd2000000b00317e1fbd57bmr6910194wro.56.1696596582480; 
 Fri, 06 Oct 2023 05:49:42 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 v7-20020adfedc7000000b003197efd1e7bsm1563290wro.114.2023.10.06.05.49.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 05:49:41 -0700 (PDT)
Date: Fri, 6 Oct 2023 15:49:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Message-ID: <569ba96b-2bc3-45ea-b397-36e7ef88ed8f@kadam.mountain>
References: <3cee09b8-4c49-4a39-b889-75c0798dfe1c@moroto.mountain>
 <ZR/si/di5IbSB9Gq@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZR/si/di5IbSB9Gq@kernel.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696596582; x=1697201382; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oHjBNst/lhil+UcE/qDI5coR6SVyilLvcP6sMcHytls=;
 b=rcynwYu3kyDs+rUrtha/TStmbUsuRlA1lxbReVV+Z0FAEkEDOdlatWwA2zqxftXccK
 jwoOzIUl9ji5gR+TXmQx8aTWxGYMBvDKTw2gPfstqQgNciRg7cxvAKEfUN+/vgIRxM5h
 y8aacOv9P6duXclemieCVx/yoKUgDmvNmmzm1gQVcJRypMTU341gij/Xi/Dh4pmjAa91
 d3C7UCPvON7Pu/Vd7dBfgevg6mPK7mY+XQ8ORoO1AIU4BJ0u/kD0ZgQ+F1e1zUVs5JAa
 xJqgFLU7CQeUSuu8mFUTNyApS1LRAQ9IPYHS5ipnbgOsypgFLtLXJmAACDa1LA/8quV3
 PL5A==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=rcynwYu3
Subject: Re: [Intel-wired-lan] [PATCH net] ixgbe: fix crash with empty VF
 macvlan list
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
Cc: intel-wired-lan@lists.osuosl.org, kernel-janitors@vger.kernel.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Greg Rose <gregory.v.rose@intel.com>, Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Jeff Kirsher <jeffrey.t.kirsher@intel.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Oct 06, 2023 at 01:16:27PM +0200, Simon Horman wrote:
> On Thu, Oct 05, 2023 at 04:57:02PM +0300, Dan Carpenter wrote:
> > The adapter->vf_mvs.l list needs to be initialized even if the list is
> > empty.  Otherwise it will lead to crashes.
> > 
> > Fixes: c6bda30a06d9 ("ixgbe: Reconfigure SR-IOV Init")
> 
> Hi Dan,
> 
> I see that the patch cited above added the line you are changing.
> But it also seems to me that patch was moving it from elsewhere.
> 
> Perhaps I am mistaken, but I wonder if this is a better tag.
> 
> Fixes: a1cbb15c1397 ("ixgbe: Add macvlan support for VF")
> 

Yeah.  You're right.  I'll resend.


> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> > index a703ba975205..9cfdfa8a4355 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> > @@ -28,6 +28,9 @@ static inline void ixgbe_alloc_vf_macvlans(struct ixgbe_adapter *adapter,
> >  	struct vf_macvlans *mv_list;
> >  	int num_vf_macvlans, i;
> >  
> > +	/* Initialize list of VF macvlans */
> > +	INIT_LIST_HEAD(&adapter->vf_mvs.l);
> > +
> >  	num_vf_macvlans = hw->mac.num_rar_entries -
> >  			  (IXGBE_MAX_PF_MACVLANS + 1 + num_vfs);
> >  	if (!num_vf_macvlans)
> > @@ -36,8 +39,6 @@ static inline void ixgbe_alloc_vf_macvlans(struct ixgbe_adapter *adapter,
> >  	mv_list = kcalloc(num_vf_macvlans, sizeof(struct vf_macvlans),
> >  			  GFP_KERNEL);
> >  	if (mv_list) {
> 
> I'm not sure it it is worth it, but perhaps more conventional error
> handling could be used here:
> 
> 	if (!mv_list)
> 		return;
> 
> 	for (i = 0; i < num_vf_macvlans; i++) {
> 		...

I mean error handling is always cleaner than success handling but it's
probably not worth cleaning up in old code.  I say it's not worth
cleaning up old code and yet I secretly reversed two if statements like
this yesterday.  :P
https://lore.kernel.org/all/d9da4c97-0da9-499f-9a21-1f8e3f148dc1@moroto.mountain/
It really is nicer, yes.  But it just makes the patch too noisy.

regards,
dan carpenter

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
