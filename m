Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10167C4452B
	for <intel-wired-lan@archiver.kernel.org>; Wed, 22 Jul 2026 00:47:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC45280DEE;
	Wed, 22 Jul 2026 00:47:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ObpdnE57ZJNp; Wed, 22 Jul 2026 00:47:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 83F0180DDD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784681246;
	bh=PEQWfYOLeykuy6ki2YoiRUIpNjq1QI9iucu8Yn0Xugw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RpOvXB492BdLKn6xIqswxEiG4dFjCoDoV4YfgbnWl7I6xV56HM3Bpxk/o3sqZ9GYU
	 tCyJk4l5j1ByJGIvHLxYbDDo9S90lHKRWQnvTnca6PFsrH0+NeFMzGt1v4DBcw2uGT
	 J/Tgi08UV9uYu6g6y6LZ9SPWEZJ3t4iBPXzBUhZ9Cocy8jRqj1UkE15jBv6fb2Nq3P
	 YasYgBgHtjM8IAY0Cl94ChMb3JiZdwmTWSrtmasiQP27qwyE3l44c486OdrQo7XqGu
	 +AKhauF7l1wgcFFC5MnsFvfOIjzMsLChOHqKjpX0cAxfU3y88V8meJHeiimWxu8+xX
	 LxVme3UJ1fbvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 83F0180DDD;
	Wed, 22 Jul 2026 00:47:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C13F42A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jul 2026 00:47:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 528D6406DB
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jul 2026 00:47:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KGvLY9WtoNJg for <intel-wired-lan@lists.osuosl.org>;
 Wed, 22 Jul 2026 00:47:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A2C1F406DA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A2C1F406DA
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A2C1F406DA
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jul 2026 00:47:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DE45B600FC;
 Wed, 22 Jul 2026 00:47:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F32B1F000E9;
 Wed, 22 Jul 2026 00:47:22 +0000 (UTC)
Date: Tue, 21 Jul 2026 17:47:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, intel-wired-lan@lists.osuosl.org, Milena
 Olech <milena.olech@intel.com>, Emil Tantilov <emil.s.tantilov@intel.com>,
 Mina Almasry <almasrymina@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ijae Kim
 <ae878000@gmail.com>
Message-ID: <20260721174721.3db8fe7d@kernel.org>
In-Reply-To: <20260721174642.7749143e@kernel.org>
References: <20260720143511.43408-1-mhun512@gmail.com>
 <20260721174642.7749143e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784681242;
 bh=PEQWfYOLeykuy6ki2YoiRUIpNjq1QI9iucu8Yn0Xugw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Fml/eVm1yChZeI9rwx5PjIZq99m1GTTM73+DsBc2iaC60Ey8VsxCwd/ZQmoTnpjmN
 JOdL9DZqHAT3+jNHlT/YCmMwunzDIE3Tjz4dom7uOwvFY670oILDzAbndAJ95dU4X6
 5BBwiLdWAVzfZd3mpMqqwgFSUVfd4quGmbsH7CEztjMAQ8OBVI3RGXdC7vD2ZvcxiR
 wXy3tQaP1GXs9vj5xkBIU/U3IPyyAS1vBBgFKQww19rQdbevjhdut+c5uYufRg31vX
 6m8VOrrp8MiMCkdMp+2kdSr8tyCJ+h/TpTj7LccnXTdHRf+rIwOFPQHZarZLxLyGoJ
 jdTa8kutixoxQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Fml/eVm1
Subject: Re: [Intel-wired-lan] [PATCH v3 net] idpf: disable PTM on probe
 failure and on remove
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

On Tue, 21 Jul 2026 17:46:42 -0700 Jakub Kicinski wrote:
> On Mon, 20 Jul 2026 23:35:10 +0900 Myeonghun Pak wrote:
> > Subject: [PATCH v3 net] idpf: disable PTM on probe failure and on remove  
> 
> Please try not to change the subject of your patches when you respin.
> It breaks version tracking. Ideally you'd tag this as iwl not net.
> We don't apply intel NIC patches directly.

Of course this is for future reference. Do not repost this unless
someone gives you real feedback.
