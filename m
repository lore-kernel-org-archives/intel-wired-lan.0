Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B94C52D7B
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Aug 2024 00:17:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0623A81307;
	Wed, 14 Aug 2024 00:17:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yxa3bl5P2v8p; Wed, 14 Aug 2024 00:17:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 59555812D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1723594640;
	bh=pAYKiISv6wl68aJN4AwlbTi88MyEYMKFybMyQY8oMTI=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=9eER8tPqwOWY9Elh+0LdZkA+zBfREKdL8zb2xk1H+1Pb9CSuJcUedp2gSPfayiDtH
	 6SD1pHJtcyQkZ8YoHzhP8FJ1+SZo6oDokGgesxYqhlE/2Otv85OGUvvaW7uuXUG9Nz
	 rYlTE7zyDqn7HKeT7gN2ZH+fj30+wJhgpHvlvZsYrLBmBVcucAXgvshhkflyDa625q
	 xpchMUOxSJq5LIpxou1/5KV41OtvKIxbVVLt91MojswluYJliUsIUshLqDAxbUpoW9
	 0fu+Rtggb54sF4UcGYr2qNyg1eEzN+AfB6nKSRs9tGmhMMeqKsV3JqV7x+tfCcKHVj
	 qKzIcme19rUtg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 59555812D5;
	Wed, 14 Aug 2024 00:17:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 9B6C61BF97A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Aug 2024 00:17:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 864AB8126D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Aug 2024 00:17:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VaUwhU9OD4h8 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Aug 2024 00:17:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9B76681264
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9B76681264
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9B76681264
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Aug 2024 00:17:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 6995ACE166B;
 Wed, 14 Aug 2024 00:17:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB95C32782;
 Wed, 14 Aug 2024 00:17:11 +0000 (UTC)
Date: Tue, 13 Aug 2024 17:17:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Message-ID: <20240813171710.599d3f01@kernel.org>
In-Reply-To: <20240812145633.52911-1-jdamato@fastly.com>
References: <20240812145633.52911-1-jdamato@fastly.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1723594632;
 bh=pAYKiISv6wl68aJN4AwlbTi88MyEYMKFybMyQY8oMTI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=SeOzVbpBsLYgf5HSBmlDL8qPjt3IGht8r5ZlHpIUVFX8LA3ObJ67q/eVE20wgIA1t
 XqQk+uIHIIa/kBKv95DVmti4IKikq3bvB0CPr/nm2U0q9li8FGd4TJanDcrgbrxv9K
 QQP34uAKdsOQxaicDxjI5f41mb3sbQh6tlYbKMGtsCBejgjdGsNEfzF+BOrh1z87b+
 mD3oXGKX3qUHkbVAGagPfuVpHni+hljbJoxlr2LGP5Qjo7sIzZKxBuWxMb3d+ZHC1A
 rb/Ys/l/Qwxu1bu5XuCplVIPPuh1FcOa7ltcfHM7CcdrTamyKHp5vy+z+U4ip/bbUr
 O4gwFpCPnWdMw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=SeOzVbpB
Subject: Re: [Intel-wired-lan] [RFC net-next 0/6] Cleanup IRQ affinity
 checks in several drivers
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
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Ziwei Xiao <ziweixiao@google.com>, Jeroen de Borst <jeroendb@google.com>,
 Leon Romanovsky <leon@kernel.org>,
 "open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
 Paolo Abeni <pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Willem de Bruijn <willemb@google.com>, Yishai Hadas <yishaih@nvidia.com>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Saeed Mahameed <saeedm@nvidia.com>, "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, 12 Aug 2024 14:56:21 +0000 Joe Damato wrote:
> Several drivers make a check in their napi poll functions to determine
> if the CPU affinity of the IRQ has changed. If it has, the napi poll
> function returns a value less than the budget to force polling mode to
> be disabled, so that it can be rescheduled on the correct CPU next time
> the softirq is raised.

Any reason not to use the irq number already stored in napi_struct ?
