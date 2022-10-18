Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D401FC4332F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 18 Oct 2022 11:45:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6068081323;
	Tue, 18 Oct 2022 11:45:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6068081323
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1666093523;
	bh=ccB0AVOqPa+YyH7waxMgfw57M4DGpZyTHf2B8IDJ4r0=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=K0r8SCpRRyGQG/fyun/8x3Q4K8rywU5eFw9GNx5G1uNj1kKFqpSihtUpKO5tXWg5U
	 D0+uDIp8J39OkgCoDfkuFozu+b2ap57kLR/UYazIUYws0cL584cA0tryS6qYTHQe2x
	 Dj/VhFTmHIr4HihJbDaGN7QGJng/2i/C8Du2iN23wI5xCh83fV0mQyynU7TzQa3eFb
	 WEPi7vXjQMdKmG651/i0sMYBTGeceaSFOnAsYdDvWzzQ74bi3mt05zswsRq9XqqEdl
	 G34h1WWRQPPZ1eCmAD1qL5q5+Rdse6mJgewOl4QBPCc10CDh9yVs9W+ajYwKUUjShW
	 lPxTzXOoAxdSw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zD2Aftc8ElIs; Tue, 18 Oct 2022 11:45:22 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6AABD81348;
	Tue, 18 Oct 2022 11:45:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6AABD81348
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 93E851BF37F
 for <intel-wired-lan@osuosl.org>; Tue, 18 Oct 2022 11:45:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6DDED61079
 for <intel-wired-lan@osuosl.org>; Tue, 18 Oct 2022 11:45:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6DDED61079
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pj7ciBfO1Vgo for <intel-wired-lan@osuosl.org>;
 Tue, 18 Oct 2022 11:45:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C6FEB61078
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C6FEB61078
 for <intel-wired-lan@osuosl.org>; Tue, 18 Oct 2022 11:45:20 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id k9so13136326pll.11
 for <intel-wired-lan@osuosl.org>; Tue, 18 Oct 2022 04:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KmUOEFAcwSq6OQXtBtquZZQSnsbd4alRNXkQKRMCI/0=;
 b=OQfyiD4ncCdLy951YTOiDFKUbkzt2cPAUFxbgua8eeBkrRdSX3gw+VBpR6tRYE5hYd
 M9MiPmnWC85J9aBuE1ZREYIjdS5fV13zHI0Q7IyOb6G1eA8whcoRL1C4RYi9SsH0VZw5
 n/XveBaNndo2tSDTcKMVFfrGjj7oPAWcac7i0v2YyCasqPCqrIw1PrNeEa84VCUdIcxl
 vJoJhDP4Qaq/qQdFI44Jx7DsqQv2nU4fnhgZW/y1TvPPFMFb9v9f9Jd8EVfCxPAgsNcP
 jyhw6rLxxw6m9OIHbqb2GnmJLaU+/jJvO3zRHTwK89wVX3LXPWvt9z5RhiB8Q+CzoXHK
 FqbA==
X-Gm-Message-State: ACrzQf1xhbJ6B69oUyKKMrrqv2Ycp+juPPkqqMn8jIYeY5z6vnyZszWo
 B0qfoaNjsB3RkM76IhU9cTI=
X-Google-Smtp-Source: AMsMyM7N8hSUH2rfjW6RDLm/Dtz30cxXxdzcerAlSbR/+hHzynKLq5GnDxUsYw6Ln7QuCydn5kA+xw==
X-Received: by 2002:a17:902:c209:b0:17f:7da5:b884 with SMTP id
 9-20020a170902c20900b0017f7da5b884mr2615993pll.26.1666093520246; 
 Tue, 18 Oct 2022 04:45:20 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8200:33:e2d5:5eff:fea5:802f])
 by smtp.gmail.com with ESMTPSA id
 m3-20020a62a203000000b0053e38ac0ff4sm9009013pff.115.2022.10.18.04.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Oct 2022 04:45:19 -0700 (PDT)
Date: Tue, 18 Oct 2022 04:45:17 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Message-ID: <Y06RzWQnTw2RJGPr@hoboy.vegasvil.org>
References: <20221018010733.4765-1-muhammad.husaini.zulkifli@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221018010733.4765-1-muhammad.husaini.zulkifli@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KmUOEFAcwSq6OQXtBtquZZQSnsbd4alRNXkQKRMCI/0=;
 b=YTSaMKeVYIDgsLpMNYnAcqk+pOukfV1BoTlI2JEUwUsW3jtw4U2FDI7fZlpX/iGYns
 fFEdMxBZC3yRUFj+bXsLVZXQ9j+pEcR23ythctNjYgBlWwtvz0alG8Dfn7voIcqApt1l
 dVq2PwtykIFbz5fFtpBDdod4o/xybRexFlB+EEJQ4VJz00A+LbopCQamkAhI4Nx/dyww
 x+Hm1Tv3YM4k82e8/hM3zRsXBPM3IKxPKdDFcGNG8N2N2RSQV1pajKenMqRRhIkFiOqm
 N6yI2aIJVMrrDvfYclqB6giSE4zOWivF14Y1gSZQ+DxrzbIh5AapcYetIgfZptM5VARy
 Zyvw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=YTSaMKeV
Subject: Re: [Intel-wired-lan] [PATCH v2 0/5] Add support for DMA timestamp
 for non-PTP packets
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
Cc: leon@kernel.org, intel-wired-lan@osuosl.org, gal@nvidia.com,
 saeed@kernel.org, edumazet@google.com, netdev@vger.kernel.org, kuba@kernel.org,
 michael.chan@broadcom.com, davem@davemloft.net, andy@greyhouse.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Oct 18, 2022 at 09:07:28AM +0800, Muhammad Husaini Zulkifli wrote:

> With these additional socket options, users can continue to utilise
> HW timestamps for PTP while specifying non-PTP packets to use DMA
> timestamps if the NIC can support them.

What is the use case for reporting DMA transmit time?

How is this better than using SOF_TIMESTAMPING_TX_SOFTWARE ?


Thanks,
Richard
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
