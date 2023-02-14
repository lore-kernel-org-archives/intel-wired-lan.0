Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87900C636CC
	for <intel-wired-lan@archiver.kernel.org>; Tue, 14 Feb 2023 01:39:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 251734023D;
	Tue, 14 Feb 2023 01:39:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 251734023D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1676338798;
	bh=FjdNzui2i1NP7gBZCuGkEaGAgleq7p7RcFxSNqiR2b4=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=91nnJM79fWzvOeu66GTM6szJywCKZN9EobmamoN4uNOey48bNwV32kk+2C9NgFfll
	 AkdF+QwnnBEthO05OXFBHVgzYjIGFC0I0TzM0cbTy2hQPvS8NrgM7XGJTf3R6h/ZqA
	 IHbfpGZvDSloRj8qhb+asGp61pyPDqcwLTWkLtTQngcMzepg2Ln84/xGUrfjv6Jrkw
	 sxHNv7ChcE3Kbc6blL0JCd4y+FpymhEmANqkjZDSFCn/ZHGsVdzN5kXTCjRsMSOWa/
	 c9SAw7MsiOrEg+Yrwc53Gdw3xzi3jqZQlFVW5jm//wLLZ+uKypXIuFHjlByHHEYMoj
	 0317ivgMwWChw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M9gathhVO5P7; Tue, 14 Feb 2023 01:39:57 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2014640A82;
	Tue, 14 Feb 2023 01:39:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2014640A82
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 9FA561BF2FD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Feb 2023 01:39:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8218661100
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Feb 2023 01:39:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8218661100
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3DyxE3Qdymul for <intel-wired-lan@lists.osuosl.org>;
 Tue, 14 Feb 2023 01:39:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D37C1610DC
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D37C1610DC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Feb 2023 01:39:49 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 32958B818F7;
 Tue, 14 Feb 2023 01:39:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2FAC433EF;
 Tue, 14 Feb 2023 01:39:45 +0000 (UTC)
Date: Mon, 13 Feb 2023 17:39:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>, anthony.l.nguyen@intel.com
Message-ID: <20230213173944.19906fbc@kernel.org>
In-Reply-To: <20230213172358.7df0f07c@kernel.org>
References: <b564473cdefc82bda9a3cecd3c15538a418e8ad2.1675941199.git.lorenzo@kernel.org>
 <20230213172358.7df0f07c@kernel.org>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1676338785;
 bh=n2dCccgVW7WTs9nqgRd36PyepOB/ImZe8OFrZeSf8/w=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=V2ZFzNRcvPdTCQrBMF+CgmtmKI4WsbEES8Z2/YBgmLYQKnddu5APgvgcW86ixi/kz
 SfPSzbhIXpHhWmRFyPjmlJmu8vBzR1U6IxKe7pygf8g6A+fOnE+iLjeo40kA3yxez1
 begGrLYrkp2OVJnzOPl39Z8Wd5prU5CTE+NvadpEnnOA3nGhVbX2kgiOd3PKTjivLL
 3OJzYIhkKKA5uS0qF6YBP4E9n1TvNek13IWbriKKZgZIO7RfGLZVcKM0JNqLS16qOB
 P3RQfLt28DbbQ2riEWKe2M+v0jWXjX7eSducgu1sJ2cSyMSkuVSnkcwvu69RwsJc68
 ZaTiS2MXdW/9A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=V2ZFzNRc
Subject: Re: [Intel-wired-lan] [PATCH bpf-next] ice: update xdp_features
 with xdp multi-buff
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
Cc: daniel@iogearbox.net, netdev@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, jesse.brandeburg@intel.com, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org, pabeni@redhat.com,
 davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, 13 Feb 2023 17:23:58 -0800 Jakub Kicinski wrote:
> On Thu,  9 Feb 2023 12:17:25 +0100 Lorenzo Bianconi wrote:
> > Now ice driver supports xdp multi-buffer so add it to xdp_features.
> > 
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>  
> 
> Let me take this one in directly the same as the other xdp_feature
> follow ups.

Ah, this one is where we had a conflict in the bpf-next PR.
You'll need to rebase.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
