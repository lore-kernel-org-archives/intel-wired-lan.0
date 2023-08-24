Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7552CC3DA6F
	for <intel-wired-lan@archiver.kernel.org>; Thu, 24 Aug 2023 07:04:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 141E24182B;
	Thu, 24 Aug 2023 07:04:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 141E24182B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692860698;
	bh=D5NUm70MH0gQN1B3HF3HqJPURMDomBX4XMTSBZhwbeM=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=JZQ5kvBpPdN7Nga6FCThsCI+u8qtAPJiT6R7k2nO12SkBF25fAI9XobAr9nVO3vhR
	 D0rC3QGHdgpd7jBzrS1EHhQTadPJsbb1hF7UzdTnwbvG59aqMdeFca8stAb1xLo0Wm
	 7z1373WSI1VsRve0NqzHj87yILuB2iXtjhjrCsroadtmxqfTsBxB362WEko2dkEm36
	 z3T6Oo2ND545zWJcdKZqZj5I695h6Bedz1efRU3TnOGRPZCD0QU93CNAZTJ1Bs6eKK
	 Q6V4SGz31vIw4vvscS85Chst60ZUML9GeA8Gp6SgvqHUf0/Nn4i7kZ3kkqkl4XKVmA
	 cEVJclPLZ0uDg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eLGE2DLFMSEy; Thu, 24 Aug 2023 07:04:57 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 120494182C;
	Thu, 24 Aug 2023 07:04:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 120494182C
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id E0A981BF32A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Aug 2023 07:04:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C688C4119B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Aug 2023 07:04:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C688C4119B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nlt1_YeUzjcT for <intel-wired-lan@lists.osuosl.org>;
 Thu, 24 Aug 2023 07:04:55 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 06D984118A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Aug 2023 07:04:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 06D984118A
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31aec0a1a8bso338724f8f.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Aug 2023 00:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692860692; x=1693465492;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wRx019sADz7VrVAreOpz8rm5QxkCuZQY4e51+r3JkRk=;
 b=YWObqscCOj/UcLkLpWf84u+TcaArj5kV6MdPwRZoILUQHyBDPwIJIvGTJDbd3GGFLa
 pspYtO8GkpZ0eHm3orgi4oCLAOdbipNXHAi3PKxAZzKaLwCQUAY6NNqEJsAo0CQoc+kI
 R4sb0C/Wpjv17b8R/a69DhTmjK0Mroo/qeEq6ULUvp4fsUKJkK8Ugho8ALYVOEe59UEj
 0AqOW1h0qPYIPdxj1Jtlb6o4Emu5GoXheSL47XzNUeTyNAnKvGz5L2zmcu95Zyrbhp+y
 1EdQF/376cl7+gKwEx4g+ZKjT/geGO3Bp4v3z7IbzXYOofFRajkdW3rm32+MA7zboNeW
 dRLA==
X-Gm-Message-State: AOJu0YxwrLPGeyUDlaau9AjXhOXW/QrcPwzU2gpkmfzUk4A0VsGvhzBh
 P03fKYCXlPZMnMm2arzRBGZp3w==
X-Google-Smtp-Source: AGHT+IFF7Be7qvROB9L70bjLXpNnOgB18klQfnMIlbAvECf66L417p5FccYryK4pwK44TfpU+4NugQ==
X-Received: by 2002:adf:ffc4:0:b0:319:8161:bfed with SMTP id
 x4-20020adfffc4000000b003198161bfedmr10994255wrs.33.1692860692514; 
 Thu, 24 Aug 2023 00:04:52 -0700 (PDT)
Received: from localhost ([212.23.236.67]) by smtp.gmail.com with ESMTPSA id
 d17-20020adfef91000000b0031ad5fb5a0fsm21453629wro.58.2023.08.24.00.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 00:04:51 -0700 (PDT)
Date: Thu, 24 Aug 2023 09:04:50 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Zhang, Xuejun" <xuejun.zhang@intel.com>
Message-ID: <ZOcBEt59zHW9qHhT@nanopsycho>
References: <20230727021021.961119-1-wenjun1.wu@intel.com>
 <20230822034003.31628-1-wenjun1.wu@intel.com>
 <ZORRzEBcUDEjMniz@nanopsycho> <20230822081255.7a36fa4d@kernel.org>
 <ZOTVkXWCLY88YfjV@nanopsycho>
 <0893327b-1c84-7c25-d10c-1cc93595825a@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0893327b-1c84-7c25-d10c-1cc93595825a@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692860692; x=1693465492; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wRx019sADz7VrVAreOpz8rm5QxkCuZQY4e51+r3JkRk=;
 b=n7CR6BAIKD4TFgNebeZTFxDwEsVeuvdI0zZ/xNGKhti2LdQ/GsdwIwOdb98IqryNrH
 37ML2bkBR1C91bkNgHYjiJ6txR9WZqTKgRKst9xtMu76NxJuvgip2LwINFKQgQMB8Dy7
 b/TpcepHMSV8ArhN0k8THPdPKte0dfMaNKm5H6ukfi18CS7le+tCvmlkjeZAy81eSSId
 WAieSnxC/mDQ6M7INCVzY9qxjqAiNKMu4byF4n3E8yLnkBu09qH9kr7cX82rNYNfYMmN
 54cn3CP+g+63dPhcsXW7g4e2T0sB/9opumFDoOQf5KMcIh4Sv+pE97mXAduX8HHxTfOp
 S5cA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=resnulli-us.20221208.gappssmtp.com
 header.i=@resnulli-us.20221208.gappssmtp.com header.a=rsa-sha256
 header.s=20221208 header.b=n7CR6BAI
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 0/5] iavf: Add devlink and
 devlink rate support'
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
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org, qi.z.zhang@intel.com,
 Jakub Kicinski <kuba@kernel.org>, Wenjun Wu <wenjun1.wu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Wed, Aug 23, 2023 at 09:13:34PM CEST, xuejun.zhang@intel.com wrote:
>
>On 8/22/2023 8:34 AM, Jiri Pirko wrote:
>> Tue, Aug 22, 2023 at 05:12:55PM CEST,kuba@kernel.org  wrote:
>> > On Tue, 22 Aug 2023 08:12:28 +0200 Jiri Pirko wrote:
>> > > NACK! Port function is there to configure the VF/SF from the eswitch
>> > > side. Yet you use it for the configureation of the actual VF, which is
>> > > clear misuse. Please don't
>> > Stating where they are supposed to configure the rate would be helpful.
>> TC?
>
>Our implementation is an extension to this commit 42c2eb6b1f43 ice: Implement
>devlink-rate API).
>
>We are setting the Tx max & share rates of individual queues in a VF using
>the devlink rate API.
>
>Here we are using DEVLINK_PORT_FLAVOUR_VIRTUAL as the attribute for the port
>to distinguish it from being eswitch.

I understand, that is a wrong object. So again, you should use
"function" subobject of devlink port to configure "the other side of the
wire", that means the function related to a eswitch port. Here, you are
doing it for the VF directly, which is wrong. If you need some rate
limiting to be configured on an actual VF, use what you use for any
other nic. Offload TC.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
