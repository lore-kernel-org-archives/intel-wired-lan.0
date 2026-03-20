Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962BE1099B53
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Mar 2026 23:09:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4CF3260E7C;
	Fri, 20 Mar 2026 23:09:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cUS6IcBpiuLE; Fri, 20 Mar 2026 23:09:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C2D9860DE0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774048186;
	bh=MUUqCiT6aXukS9SwL9hysllV86yLA5FmYEzwznGMHeY=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fOHPALfSh2fMcjnnEr6LuKlNv/dlFPRi53AdquhNdTfLAUBiOEoxFitgrWdbGDYbj
	 RuEvm0BHcO2pOAvt5nsbLnvLhJwt98Sqho01JFK9rlbG9fWdQsKZJWWyQj0LVhysZC
	 VgnIH41WzxcLYmLn+iogYTd/3KnP6YBQchmifDS+V9KEPQNAmFifcTtsIzRRpLv+dv
	 xAsoKmGtXzcCwwS0C7D/ym63yomh9XBDXjBtleJ4Ip8q4HbHWCXWPO4uaUQogiepp5
	 RSeT2+BMe3BHgfGu6HDeRWDz94iKIqf52auIlzwdkmthkGDhEKfiVmy0rB7qi6C0An
	 enb0wi4jNgVtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2D9860DE0;
	Fri, 20 Mar 2026 23:09:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CF4BD21F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 23:09:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C07CC4188D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 23:09:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2SbTtcCZsuWF for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Mar 2026 23:09:44 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com;
 envelope-from=joe@dama.to; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3FB61417F9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3FB61417F9
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3FB61417F9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 23:09:43 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-35a1d4a095bso1455645a91.0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 16:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774048183; x=1774652983;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MUUqCiT6aXukS9SwL9hysllV86yLA5FmYEzwznGMHeY=;
 b=mgG987UkqfJ6xWbt3oZNGxxpOF0GkxTYW2aRrD6HU0dgFW0Rqi9M4CTqn3HmqJNldr
 xvbkPVOaJ1p81T+dqBLen+j3ClKhBNFd1wRrZNeuhrdEY4HrYvYK+OoIN7mtpwkZLajy
 dR33KQHXNSWdOFWnPJJzDVC6S1sr6SwNhYCTTwMCCNOmSum7LQviDbVnunNzO8f1EdQa
 5X2E1gAESFLVrK6tGMtl92RRLmuppmcRu938zWFtJiSye5cyrEdpwYbO/E29gWGYmp1q
 94co6itKhn2jYS6l8xFGGFzoOKsKtAjQm4fETCQF24NgELr5ICyFhpsE7AXjgt1ZbFk0
 Qrsw==
X-Gm-Message-State: AOJu0YyBb5LbDe8bZx/1sd2AKuGf2/NZvuhcAgy/El3d0Y/Rbykeag3A
 BmsfXcwBFdJ0y8D4itU0QetYZ6+jvsjPVIB8PWWHgTMK9+evr1n+V0J2v7CJu3OJfTg=
X-Gm-Gg: ATEYQzwzK59J58Ki6w6mUjK6CAEMaG5o0iwt0AY9cLwLmgzmHyXsNXf6pL9Af2+sfef
 dSyOYrS3zZ7WthuVNPtzua9sKtB3YvMAbQEUDqwn3Y5BHoqVtrRBVxKRxceKUPccbOhnZoiTy1C
 EdfWXANp79HOImzwzt31tJOxyIgrj4jUrt+7SbqgbGQSOcKyv56NvkPgEN6YbdYlUFeFJebNc/b
 s7GwPfFvmHcge+GD6T/MJnShM/28ujwFI5NV7P9fnvIDOcTHEkG1GwHGvMDOmNgVJCuJRh/PZXE
 Dhiq+M3CVv0m0zKsO1goiYY0VGgacdl3MZ/PID1hjgijWbL8yqL0qrFpN25aLr59N6Pu3MxMRVk
 /rXlFPkqrNjHM1DQghirBENyVYoKU7joULQ1dHKF6leAKnuCNJSFwCVR78VwrC2VISjAFruLATF
 ATjDanudBcGJmp0g==
X-Received: by 2002:a17:90b:510f:b0:35b:8d89:719d with SMTP id
 98e67ed59e1d1-35bd2749cb6mr3212601a91.6.1774048183415; 
 Fri, 20 Mar 2026 16:09:43 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bd262cb35sm1574549a91.1.2026.03.20.16.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 16:09:43 -0700 (PDT)
Date: Fri, 20 Mar 2026 16:09:42 -0700
From: Joe Damato <joe@dama.to>
To: Kohei Enju <kohei@enjuk.jp>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kohei.enju@gmail.com
Message-ID: <ab3TtpEKY5Pg+uQt@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, Kohei Enju <kohei@enjuk.jp>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kohei.enju@gmail.com
References: <20260319171650.5815-1-kohei@enjuk.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319171650.5815-1-kohei@enjuk.jp>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774048183; x=1774652983;
 darn=lists.osuosl.org; 
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MUUqCiT6aXukS9SwL9hysllV86yLA5FmYEzwznGMHeY=;
 b=PSchjG5I3T5QVPZtM1SBql/FvBHKTWA5eirBUSmvBQSu/iKA/VgbORYZ4zFb6uFeQn
 JLQx0+eae6oNV5+ifu20aNKZPsryKvmKVAVvyK6UCouFMRrP7gZuAtHoVGwaZV06xl0n
 3TBD1+EUX7+m/0AJSYMV6n5rlhHG/lD4GcKucVGl6Rb9bFQkasYhhp3RPNMnD71cJ2ly
 y+PgLhPv4Of01gWM67vXolQxg07vypnc5W7sHFbGHf+O3ERdjDaIL+E55tJrbw7sFl8e
 Q5wnZ8275/uzRByBeg+LsrvisRupDTbcaJN+2f8SjqpJApwcbdObkBrY/tST/4E025In
 FPFg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=dama.to
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=dama-to.20230601.gappssmtp.com
 header.i=@dama-to.20230601.gappssmtp.com header.a=rsa-sha256
 header.s=20230601 header.b=PSchjG5I
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 0/3] i40e: support XDP
 metadata ops (RX
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

On Thu, Mar 19, 2026 at 05:16:41PM +0000, Kohei Enju wrote:
> This series adds support for XDP metadata ops. Since the i40e RX
> timestamps are not available from the RX descriptor in the XDP path,
> this series doesn't implement bpf_xdp_metadata_rx_timestamp().
> 
> Patch 1/3 prepares i40e_xdp_buff for subsequent patches.
> Patch 2/3 and 3/3 introduce bpf_xdp_metadata_rx_hash() and
> bpf_xdp_metadata_rx_vlan_tag() respectively.
> 
> Tested on Intel Corporation Ethernet Controller X710 for 10GbE SFP+ with
> ./tools/testing/selftests/bpf/xdp_hw_metadata.
> Since i40e doesn't support HWTSTAMP_FILTER_ALL as an rx_filter, I
> locally changed the selftest to use HWTSTAMP_FILTER_NONE instead.
> 
> Kohei Enju (3):
>   i40e: prepare for XDP metadata ops support
>   i40e: add support for bpf_xdp_metadata_rx_hash()
>   i40e: add support for bpf_xdp_metadata_rx_vlan_tag()
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 51 ++++++++++++++++++++-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c |  5 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h |  7 ++-
>  drivers/net/ethernet/intel/i40e/i40e_type.h |  5 ++
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c  | 12 +++++
>  5 files changed, 77 insertions(+), 3 deletions(-)

For the series:

Reviewed-by: Joe Damato <joe@dama.to>
