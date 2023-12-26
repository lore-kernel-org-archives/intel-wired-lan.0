Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92971C46CD3
	for <intel-wired-lan@archiver.kernel.org>; Tue, 26 Dec 2023 20:23:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 43EA780CC8;
	Tue, 26 Dec 2023 20:23:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 43EA780CC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1703622229;
	bh=BLliTISajJlRSyWREx9KaaHsKdXTEmO4wkxTJ/lMi6I=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=fKP0neoKX7aqWAW4VF16SJ3ipYTZlgvhxMOgwAfl2bi6yHFnns6zuWJHqvd+kERYi
	 2xXmQEd1D6L40aMmFY63n+spzUwT+Q5MIuaX+U+IqNbmYRXZMh7/I2kZ4M2XvFTcGU
	 mq+M+sjRdfh3QVQnpWevreUcTCyK49q3rOCMbuo+5KFiSyiMoPY4S8lsosu4/st8cI
	 1U4cxmzY4V3z0dETnZ9Uv9PQa2l0VXn8x5vTe7hf+4jLuI2YBjlRhtjJy4z7gIe3Gk
	 qKaWarIRl7vmZxUkDyE+CvXYMKeKFxazCe4TJC1CDdIHX/HRjMGLd8D0Z2XTTcAifL
	 m5cqxYVqND9+w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zPwu77NVP-i0; Tue, 26 Dec 2023 20:23:48 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44C4580CEA;
	Tue, 26 Dec 2023 20:23:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 44C4580CEA
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 2D4701BF591
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 Dec 2023 20:23:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 03C3280CEA
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 Dec 2023 20:23:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 03C3280CEA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ACWnjABPJM6a for <intel-wired-lan@lists.osuosl.org>;
 Tue, 26 Dec 2023 20:23:43 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1708380CC8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 Dec 2023 20:23:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1708380CC8
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3bb907d28fcso2267357b6e.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 Dec 2023 12:23:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703622222; x=1704227022;
 h=content-transfer-encoding:mime-version:subject:references
 :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BLliTISajJlRSyWREx9KaaHsKdXTEmO4wkxTJ/lMi6I=;
 b=xMTHfeFWS8TH0eO/Zam9JhNnM1PFV+j62LA5uRORMWIJaMeZ7X0tuRMH2YCi2Uu1A5
 64R1glR/Z4BiD4a0A0WYSKgn7Zx+OC5wmK0JPD6e7axsR6sbm9FiqNNFz1TOxHio6Qn6
 ds06/bh+4adGfqWIuX3ZBsfZMrQSkM9WSfrtOG/l+czkIoJGrdiUjEWgVEpKPCLCvQRN
 +BacZiKKUv9x92QfwPG1xmO2DmPyxwlpi1Oacsq2pTE3KIvWi0FgTA30MLIzXk0PZqDw
 NK2ABjtIrY7XzKwzNnISbvPDwLifEDmccZcIB2kgtsndvAZK6rQY/zlYMBZbdZoVQUay
 Ya8g==
X-Gm-Message-State: AOJu0YzmMvA087engoH1c7eEAOZ7nJD4GTY4FTLn49iiHeKW8X3xmrsK
 Hie5jHHSc9JPrEzBgAZmn/I=
X-Google-Smtp-Source: AGHT+IGHdHO4MvaKw9Ec59joEgXAcQSdbPp+Q4ALvPXKAMaHL79WMmb2N7zJXC7tqBqkQcVXjVY/fA==
X-Received: by 2002:a05:6808:3995:b0:3bb:bf36:12c with SMTP id
 gq21-20020a056808399500b003bbbf36012cmr1131080oib.24.1703622221988; 
 Tue, 26 Dec 2023 12:23:41 -0800 (PST)
Received: from localhost (48.230.85.34.bc.googleusercontent.com.
 [34.85.230.48]) by smtp.gmail.com with ESMTPSA id
 f15-20020ad442cf000000b0067f5ccd6e73sm4910195qvr.59.2023.12.26.12.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 12:23:41 -0800 (PST)
Date: Tue, 26 Dec 2023 15:23:41 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Message-ID: <658b364d56c6e_5c2a929468@willemb.c.googlers.com.notmuch>
In-Reply-To: <20231223025554.2316836-1-aleksander.lobakin@intel.com>
References: <20231223025554.2316836-1-aleksander.lobakin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703622222; x=1704227022; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:subject:references
 :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BLliTISajJlRSyWREx9KaaHsKdXTEmO4wkxTJ/lMi6I=;
 b=dXfcxhyO9W5yQ0mapRARQF+1KcZKu8P7OVt9I+qPNj8j2LiQhJyzKzTHSkMGRTIUjj
 gygpoHnFuEDAGP/6vHbN9Wx2T1cNTLSPtGWW8eeSJ+YFV5dI0RYIwpZOQfp+giqf60JG
 MgmoxkCdW7lgRiD1+tTrS2NdqGX2zYJ9M6n86lqI2pNsw7f8w+eylHdMlFCt3nUrWcj5
 SA7PefMLF3TMkVDrBzKk38C7jEFpIQqzITC5xThuwsiDo5hPVxScv5aEw2F3xaDKdjzS
 LqxIzlwXjhSaN4uHA5qiVP5n+LrN7IVaeS/7X/yo8s36sR9RwcutKSutH+Rfp1ufRgb4
 tcUQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20230601 header.b=dXfcxhyO
Subject: Re: [Intel-wired-lan] [PATCH RFC net-next 00/34] Christmas 3-serie
 XDP for idpf (+generic stuff)
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
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Larysa Zaremba <larysa.zaremba@intel.com>, netdev@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Michal Kubiak <michal.kubiak@intel.com>, intel-wired-lan@lists.osuosl.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Alexander Lobakin wrote:
> I was highly asked to send this WIP before the holidays to trigger
> some discussions at least for the generic parts.
> 
> This all depends on libie[0] and WB-on-ITR fix[1]. The RFC does not
> guarantee to work perfectly, but at least regular XDP seems to work
> for me...
> 
> In fact, here are 3 separate series:
> * 01-08: convert idpf to libie and make it more sane;
> * 09-25: add XDP to idpf;
> * 26-34: add XSk to idpf.
> 
> Most people may want to be interested only in the following generic
> changes:
> * 11: allow attaching already registered memory models to XDP RxQ info;
> * 12-13: generic helpers for adding a frag to &xdp_buff and converting
>   it to an skb;
> * 14: get rid of xdp_frame::mem.id, allow mixing pages from different
>   page_pools within one &xdp_buff/&xdp_frame;
> * 15: some Page Pool helper;
> * 18: it's for libie, but I wanted to talk about XDP_TX bulking;
> * 26: same as 13, but for converting XSK &xdp_buff to skb.
> 
> The rest is up to you, driver-specific stuff is pretty boring sometimes.
> 
> I'll be polishing and finishing this all starting January 3rd and then
> preparing and sending sane series, some early feedback never hurts tho.
> 
> Merry Yule!
> 
> [0] https://lore.kernel.org/netdev/20231213112835.2262651-1-aleksander.lobakin@intel.com
> [1] https://lore.kernel.org/netdev/20231215193721.425087-1-michal.kubiak@intel.com

This is great. Thanks for sharing the entire series.

Which SHA1 should we apply this to? I'm having a hard time applying
cleanly.

The libie v7 series applied cleanly on bc044ae9d64b. Which I chose
only based on the follow-on page pool patch.

But that base commit causes too many conflicts when applying this.
Patch 6 had a trivial one in idpf_rx_singleq_clean (`skb = rx_q->skb`).
But patch 14 has so many conflicts in page_pool.c, that I'm clearly
on the wrong track trying to fix up manually.



