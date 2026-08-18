Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D69C5DF86
	for <intel-wired-lan@archiver.kernel.org>; Tue, 18 Aug 2026 17:03:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D7DE7408B0;
	Tue, 18 Aug 2026 17:03:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RiPjNYv7Vc4u; Tue, 18 Aug 2026 17:03:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 12738408BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787072638;
	bh=LARP5bmG64wd0GpLVR0nEMY/+zhPU+0Nmo0aQ8UdxmY=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RL+YLiXU8v0FcFSIPeKaSWwTy5OZhM46XMyMVyqlBSPUw6GWP7GGp7/eAC0xZOZZE
	 gPpHYPCh6wgcfu+tZNFk8x4NCIW5qgPi9kkNXFMOI7mYPtCiLB+Pg8Jh+eUYfAMGUp
	 fdCQU3dA91mZC6YReuHMq1kY4xRg9PxXX0tIxC1k83UGU3Af1oJTGASHYa0dQb0ynT
	 ef0jOREIIIdX1roP1B4y4x2MKs9cj2we7x7xIvKwlLRvr3/jy+CioWrXMHTFSRy9jq
	 h2rnPPipmOKcYf+l8leRxWp2ZQOyhQSAp+MOxqzh/omI58Y+mSPBRxd4lfcE20ZhRV
	 5NUouVJIELuAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12738408BD;
	Tue, 18 Aug 2026 17:03:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E02329B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Aug 2026 17:03:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F3D5D408AC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Aug 2026 17:03:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gJix19UQ3vom for <intel-wired-lan@lists.osuosl.org>;
 Tue, 18 Aug 2026 17:03:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=sdf.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3AB5F40892
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3AB5F40892
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=psgQHUfS
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3AB5F40892
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Aug 2026 17:03:56 +0000 (UTC)
Received: by mail-pg1-x541.google.com with SMTP id
 41be03b00d2f7-ca80d708489so1004302a12.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Aug 2026 10:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787072635; x=1787677435; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LARP5bmG64wd0GpLVR0nEMY/+zhPU+0Nmo0aQ8UdxmY=;
 b=psgQHUfS72oB3noa7cFF7ebS0uxyu1FZNGdquGRNjwlEUAu+19nwkZNUIh9U9DU+rY
 Iji0t4QyfMoiYFU3THSADqblWjV2wJjj85yiLiRZQhFmRRI8zbLY1HmlVYvehFJ+pe38
 anraknlCC+9sXi0pxSk7qLavoyxeDhq1kUy2pQhQz+RtfTlhT8ZZO1+W2jwGloj5A24B
 otihLS0luhZeba+n7uAxIvMG3H21M3nKHaZXiF7uFvYYSvY416RdPog9hA8FT41OLQnj
 WtevnC5msES4vGw9x9wcwJiCGkvb8tgNS+KL6wgDMko3E+0UqUcCV8LIhbMXgksAs2SQ
 hgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072635; x=1787677435;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LARP5bmG64wd0GpLVR0nEMY/+zhPU+0Nmo0aQ8UdxmY=;
 b=PVBwqCdTDuQYkmwH84zXZX9patj9O6avqH0zLXrDmnq7cdjYqikk/NRw0Qijlqn9SZ
 9uGxyjxMRcAuvVG+AEVYYXe+lR6q0KO0GWp2bRy5JJPHIliq1zouCVKmjFE9Bu6Z9xyE
 6IBZTOO5d1pOVQERuGPqzPLrqDcS9ksU5dDnq71rENWKADHQJ9TFEYligFtkjwlMrxlg
 12EeVDtY9zzhnvdb7aGaFdquE8NHLUvNA2sHEdfpWQbzpxvwnt5K3PCduCdYXppo2f5S
 57LMO2BTno7noqtl7OBKtwiYfDyevfzklLzwl9Z3XHJpuFUPGXMeL0SzDCKHsqgCkNaY
 HTPw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpmgAnnAQ/1h4kUw+3YycLn9xIkXWLWnSvCkFrMNo7NQ3dH20XraNybLa4tbavxyi95sjcpKnbXrPNvf8I1RFo=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yz9oNLb+xJ0sA5izarkEIEExIdCveLmse21nfZei+DvjGsAgJ3o
 BUs8xvAxmnI/pKiOnW7YmULYDaZAw8qL5XZFQrJweUbUC1MjeJVlABFn
X-Gm-Gg: AR+sD12C5lFs0/28E96fLErcmCQKhGKMXoUyTQqc1vq1SjGYTKRlxAutDKH1ZGDZTGF
 q9A2HTP+OWcXDVSSCRFiU/m5EueWZV5Ssb0U+Phx5LSQI1Ij+DWu5m0+8jOPnH3Gn5Ja/cwMnJd
 0/pp2MS2lYgbI4HxNJHOCpdJ5q6tWHw+BsAGmnzv5g6o3QgiMy5tyKQEZloNmRU34zBw6oaOyfj
 VC6S9HGe7I5yvbRrpsGmIjVrYBgrcw6O9KgLW+mDaC3NY9x5pgG5hpdnrrV4jEfw8FPFiWIk2T/
 4H91EJUm/G5fWvHq1YrlqUT6yQjKrq6VClZGoDB7L53YLoptsLJaWh+gSHRsyOCNyEBsm158sWW
 R2AWyxjU69saQ1gW9qc1R0MS8aDDOZJVXfC/a9lqwyjLCKKUspIdQQtJCRBB1D97NvVYEAbf2IF
 r0JGruYiop2JakBkHHEgdGRqT3qFSsxHIVrKhOfLlksUr5nYgHrFXtj03ktePhFojs
X-Received: by 2002:a05:6a20:2446:b0:39b:bc11:9ec5 with SMTP id
 adf61e73a8af0-3ccded40c3emr7581611637.13.1787072635279; 
 Tue, 18 Aug 2026 10:03:55 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:56::])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc13c0445c6sm2311742a12.32.2026.08.18.10.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:03:54 -0700 (PDT)
Date: Tue, 18 Aug 2026 10:03:38 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Netdev <netdev@vger.kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Anthony L Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 andrew+netdev@lunn.ch, Saeed Mahameed <saeedm@nvidia.com>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Simon Horman <horms@kernel.org>, magnus.karlsson@intel.com, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Stanislav Fomichev <sdf@fomichev.me>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, witu@nvidia.com, 
 Martin KaFai Lau <martin.lau@kernel.org>, yoong.siang.song@intel.com,
 rohan.g.thomas@intel.com, 
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org,
 bpf@vger.kernel.org, Leon Romanovsky <leon@kernel.org>
Message-ID: <aoSQWPGrYEBfZUnP@devvm7509.cco0.facebook.com>
References: <20260813190800.222527-1-sdf@fomichev.me>
 <20260813190800.222527-2-sdf@fomichev.me>
 <06f8153d-2156-4e7d-9d49-006db4b2cec4@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <06f8153d-2156-4e7d-9d49-006db4b2cec4@app.fastmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net v2 1/3] xsk: align TX metadata
 layout across ABIs
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

On 08/17, Arnd Bergmann wrote:
> On Thu, Aug 13, 2026, at 21:07, Stanislav Fomichev wrote:
> > Add explicit padding before launch_time so xsk_tx_metadata has the same
> > layout on 32-bit and 64-bit systems.
> >
> > On i386 and m68k, the old native 32-bit layout put launch_time at offset 12
> > and had a natural size of 20 bytes. Using sizeof(struct xsk_tx_metadata) as
> > tx_metadata_len was already rejected because the length must be a multiple
> > of eight, so the straightforward use of the interface was broken on those
> > ABIs. Userspace could still register a padded length of 24 bytes, though;
> > mixing the old and new layouts then silently reads launch_time from the
> > wrong offset and misprograms packet launch times. This intentionally
> > replaces that incompatible layout while the interface is still new.
> >
> > Fixes: ca4419f15abd ("xsk: Add launch time hardware offload support to 
> > XDP Tx metadata")
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> This is probably the right approach, given lack of alternatives.
> In the changelog text, it may be worth noting a few more points:
> 
> - A few additional architectures have the same issue: csky,
>   nios2, openrisc and sh.
> - the commit that introduced the mistake was part of linux-6.15,
>   so the 6.18-lts release also needs an ABI change. I don't
>   think the "while the interface is still new" wording
>   makes sense here.
> - what actually saves us here is that none of the affected
>   architectures are likely to have notable use cases for
>   xdp that would care about the ABI break.
>   The one that is most likely to have affected users
>   is x86-compat, and that is also the only one that is
>   broken right now.

Will try to add that to the commit description, thanks!
