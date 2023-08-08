Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE1DC001DF
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Aug 2023 12:46:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A727481DF0;
	Tue,  8 Aug 2023 12:46:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A727481DF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1691498793;
	bh=P+71EjSI1t2bBpK/pV9w7UI2E0cf1t+r4fcBqacdIc4=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=WBKksBYjUCJiMqSODaCa+U0EfmUwhb41NbTrFBJJf6HOHTr88mKUaydnrCzvQg6ZY
	 A/fDJzDQpWT1N+nJ3tDA3aHQA5ECJ3L3cUcszx4ye9X/Qc8IwZnC+5fd67pWEi0TgR
	 G+051GgzssaX6hhPKgQFNATcftOsMuMHcqIe7vpB0UivFrnefi/Djm11LGGSOBmPZE
	 YlYe8iAAOwEd0nzPcCYCdw6f3SAnWtqjzZTJPulKfAErsWtdwLG3yl3c1dMmuj1vKh
	 BQJn8P+gd5JVlVNw8W1bIjHB9eoTRke+lDssRUtBpj7yo/W/8iWLtuV9Bx2epvLrO/
	 f+NaWLFzZF5SQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3YpyFyWZNpbw; Tue,  8 Aug 2023 12:46:33 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id C4B9181DF6;
	Tue,  8 Aug 2023 12:46:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C4B9181DF6
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 299A91BF5A7
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Aug 2023 12:46:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0F04B81DF6
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Aug 2023 12:46:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0F04B81DF6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id alMO0ux4TzV6 for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Aug 2023 12:46:31 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6F97A81DF0
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Aug 2023 12:46:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F97A81DF0
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 468226252C;
 Tue,  8 Aug 2023 12:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B258C433C8;
 Tue,  8 Aug 2023 12:46:25 +0000 (UTC)
Date: Tue, 8 Aug 2023 14:46:23 +0200
From: Simon Horman <horms@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Message-ID: <ZNI5H4OY1DrFOcq6@vergenet.net>
References: <20230807091347.3804523-1-linma@zju.edu.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230807091347.3804523-1-linma@zju.edu.cn>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1691498789;
 bh=bwqg+nZJaOp58U9gLi7+hIbzVoD6HWVrHABj3u2osQ0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Bv6idbcnou7dvWv3pfCSTobSlZ8fXVeIw2yMmJVRggQHuTlgeo+lUsF5L8mUAfrxw
 Fb2BkRhuXr61SboC+ZUEBawjWZCulZnmjCs4zf47NOf4EXTLrZlZdXPLIYTdZ5kBGA
 YdPp9jZSZ0hSZQYFhhy0b4/5OT6RjvfsYvu4qaZ1cKuY54iLY8SbN3WArnkfzPxntX
 PsuYgLY/tsgFrUsjKdyt/eicIpeXIqk1sy66Iw0BblMhZoNn9tCT4MJJr1JexQSgfA
 dd1N2mGvCM08nCLESVFn3n3+mWH9CqCwu/xITCIqguMtve2XtiLfah+dEHIN/rNpJw
 l1P1t+mmv4g1w==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=Bv6idbcn
Subject: Re: [Intel-wired-lan] [PATCH net-next v2] rtnetlink: remove
 redundant checks for nlattr IFLA_BRIDGE_MODE
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
Cc: ajit.khaparde@broadcom.com, somnath.kotur@broadcom.com,
 oss-drivers@corigine.com, anthony.l.nguyen@intel.com,
 michael.chan@broadcom.com, louis.peens@corigine.com, leon@kernel.org,
 linux-rdma@vger.kernel.org, jesse.brandeburg@intel.com,
 intel-wired-lan@lists.osuosl.org, kuba@kernel.org, pabeni@redhat.com,
 huanhuan.wang@corigine.com, tglx@linutronix.de, yinjun.zhang@corigine.com,
 na.wang@corigine.com, sriharsha.basavapatna@broadcom.com,
 netdev@vger.kernel.org, edumazet@google.com, linux-kernel@vger.kernel.org,
 saeedm@nvidia.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Aug 07, 2023 at 05:13:47PM +0800, Lin Ma wrote:
> The commit d73ef2d69c0d ("rtnetlink: let rtnl_bridge_setlink checks
> IFLA_BRIDGE_MODE length") added the nla_len check in rtnl_bridge_setlink,
> which is the only caller for ndo_bridge_setlink handlers defined in
> low-level driver codes. Hence, this patch cleanups the redundant checks in
> each ndo_bridge_setlink handler function.
> 
> Suggested-by: Hangbin Liu <liuhangbin@gmail.com>
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
