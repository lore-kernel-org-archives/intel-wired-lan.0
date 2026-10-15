Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6EBCC6B30
	for <intel-wired-lan@archiver.kernel.org>; Thu, 15 Oct 2026 10:45:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 74E6260794;
	Thu, 15 Oct 2026 10:45:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3_iVi1cqz2vb; Thu, 15 Oct 2026 10:45:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 63AE260745
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792061127;
	b=ko8wVxL4k+3LxjTVho0ZGUHLmuF09MSDM24OXguk2gdvy3Ngn+aGBvYcMfsKOw9h69v1
	 ak3+laDP7HmYWjHAeTNKgekeMM8V4ZMAMBS+tZFOa95annDwLxBGMVzSUVhHSWe5n2gVS
	 fiZ4a3M1DMI8nCde6v6U58ig91msF2AtPqot/YFjV1k1a+FMQtS1K55lvJ28lccEjjJma
	 KGMeKr1O3drbhTBJh7C4uHARYpJAxmzwlLRUWcSffIfSv8SRvzP7KHn67SGf1WZr1JJc9
	 PP9jvTMmQwbBwodTHszDI1P237Sqwh+gjZgppJXQk0fZlEddYn1ZMsODWoe1eN+isbg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792061127;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PumgwUShW0Ti66999o4MOz7EzuUWkWq1+rwo9Lx2ykE=;
	b=BTxmhzR9sl00D5NJ9A+CNtWohZ69bEmDWJurUhRlQPOWI9RDHlz2yw+tZUvgrpmPX725
	 PmjMhUCPrYDi8Otey+mDfKkASSSFlpTTSJSG08O+oNr/2i9epbglwMctGL3oUwFUlkAsS
	 aScuMGKFx6SgU52TvnSCmq+jw+txx6g8a+IAaqPpJfsGD1FSqx1bnuYe66uWYYK4ow9Pb
	 X2+y2YCYvTEpkQ7H2GioPRAGt3jQuPofQRc69luj+Vv4X5VDI6WBPzinAzfIsz3mZQjOo
	 Z59CA5UDo4kIYICVu2yUMr2LX9XMxvKXSlrpbzVaWMbFHObumbu5tSvGMTIfq46l55g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792061127;
	bh=PumgwUShW0Ti66999o4MOz7EzuUWkWq1+rwo9Lx2ykE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vkRcQIGdyWP0ciWyhJeQxVhV1f7QlmuMNE/ksFCT4klmbYnXSjLI4ZCM3fbuvr71B
	 QdEQAQI9JApcSwC8qYjI8p56SBN3NqAyXo5wCo8p9f4KIoU7soyisRdjj1Rwa5gkAq
	 gVYI6NMozoAaYadvWV70QmNYjwycGXyQtH0VwzdoBnUE52ulDJfJl9+R81xxDyp0jY
	 BjtjSmrEGcd340OB8lYmnQ5+pAEv7LyfywQQ5c/8MWch+90vLk95NSZ6Fr03BEE2dV
	 95e+m8PR2Zsc0K4Qe9Ef1uiOdCwhBVIdUrO5sWsupI2Bj7H/xOsicEZCg1CK2I5Vrl
	 IRfPBlt7ZG1Hw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 63AE260745;
	Thu, 15 Oct 2026 10:45:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DF00D49D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 10:45:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D10964084B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 10:45:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s95w0y5HHMrq for <intel-wired-lan@lists.osuosl.org>;
 Thu, 15 Oct 2026 10:45:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 55B46405BA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a0a:51c0:0:237:300::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792061124;
 b=o3WIzTNtv/s54pbiNAM7H7kzoUGhZhUK3Ak9cjjHL56RfgQ7e/ZdyWih2Yl9lTwccVBY
 V+UFRg2hP0AJEp5PzvfaiRqDsX5Vpl9eDHf3EVnLGeWVUwNMnlzSp6XB8FR2ORhxDv08m
 FJ3gJpevdPbDiM+YUo75OI4kSPWMc89yVczAJF7RbNcYpaAlUaEzQLgxWaBYhKatrH9kw
 yzGumhtu2YxitxMKU0+mJHT3rXG49wSWGx/1UfFnvvedKKxoYV2t+xFj0QZPapAFOQgdw
 RRbVXoZZ4gp/HQUoUaAKPe/smKrNk8xW35pM9dHBDTL7uHI5K3L3mHRgU2dbWlX/vPg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792061124;
 h=X-Greylist:Received-SPF:Received:Date:From:To:Cc:Subject:Message-ID:
 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=PumgwUShW0Ti66999o4MOz7EzuUWkWq1+rwo9Lx2ykE=;
 b=lQHd9DwTQNMpnWbs+myFzZRa5JsGaircAyponkTT1m5dUwE1d/wVtBy/Ftdl9sVgTLs7
 RRmuTZSC4Uce2+1LMMZy5Fx9/8t2GkjhMDWWOXMsH/DXgdiTq+2BUEEtjGqsjnnvjTHH+
 05pQ30A37ozUp0tEjQOvXuA2+pbGItvoXfRqPZu4bILXnAuBcy5ZvTQE2YdUmBzNf5ZxF
 GCNNvGKRLGcFk9SBqOc1h18k27PMsobtnTPKmiR8NiEYilPT2OHqUhSl8JI5jGc1aZnTO
 1GdaFDRxW4k//NwM47dDYL8GJ6nP3T1kyX7pEvYsm1fY4FYsS2OKNiuhlyFJ0Q3sqnw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=strlen.de;
 arc=none smtp.remote-ip="2a0a:51c0:0:237:300::1"
X-Greylist: delayed 359 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 15 Oct 2026 10:45:24 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=strlen.de
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a0a:51c0:0:237:300::1; helo=chamillionaire.breakpoint.cc;
 envelope-from=fw@strlen.de; receiver=<UNKNOWN> 
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
 [IPv6:2a0a:51c0:0:237:300::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 55B46405BA
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 10:45:21 +0000 (UTC)
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
 id 13087606E2; Thu, 15 Oct 2026 12:39:13 +0200 (CEST)
Date: Thu, 15 Oct 2026 12:39:12 +0200
From: Florian Westphal <fw@strlen.de>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netfilter-devel@vger.kernel.org, virtualization@lists.linux.dev,
 intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org,
 pablo@netfilter.org, phil@nwl.cc, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kaber@trash.net, jengelh@medozas.de, andrew+netdev@lunn.ch,
 mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com,
 xuanzhuo@linux.alibaba.com, aleksander.lobakin@intel.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 willemb@google.com, alice.kernel@fastmail.im,
 eilaimemedsnaimel@gmail.com, imv4bel@gmail.com,
 shiming.cheng@mediatek.com, sd@queasysnail.net, vega@nebusec.ai,
 root@tr0jan.top
Subject: Re: [PATCH nf v8 0/3] netfilter: bound asynchronous packet duplication
Message-ID: <atCtUFcG9b4ykXY3@strlen.de>
References: <cover.1792048855.git.zihanx@nebusec.ai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1792048855.git.zihanx@nebusec.ai>
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

Zihan Xi <zihanx@nebusec.ai> wrote:
> Hi Linux kernel maintainers,
> 
> We found and validated an issue in netfilter packet duplication. The bug
> is reachable by an unprivileged user in user and network namespaces.
> Bounded tests exercised the fixes. Non-duplication packet semantics are
> intended to remain unchanged. MIRRED flow offload for affected netdev dup
> rules is rejected because it cannot enforce the duplication-depth limit.
> 
> We will provide detailed information about the bug
> in this email, along with a PoC to trigger it.

Series makes no sense to me, sorry.  I dislike the 2nd patch, I see no
reason why we need to make changes all over the place for this...?

Also, if we go with 2nd patch, why do we still need the first?

> The IPv4 and IPv6 duplication helpers use a task-local guard while a cloned
> packet traverses output hooks. If NFQUEUE suspends that traversal, the
> output call can return and clear the guard before a later verdict resumes
> the remaining hooks. The resumed packet can reach another duplication
> consumer without the original guard. This can cause repeated packet
> processing and consume CPU and network resources.

"Don't do that, then"?

I think the kernel should not crash when misused, but I don't think
kernel should have to do extreme stunts to detect such loops.

There are probably many other ways to make kernel allocate lots of
memory or waste cpu cycles.

E.g. via create use of veth and bridges, sched plug, teql, ...

> Patch 1 records the
> guard in the queue entry and restores it during reinjection. It keeps
> bottom halves disabled during the reinjection traversal, restoring the
> verdict task state before reenabling them.

Its small enough, so I have no objections to this patch.

> The netdev nft dup path has a separate synchronous transmit recursion
> counter. It does not accompany a duplicated skb through asynchronous
> software receive paths. Patch 2 carries a bounded duplication depth through
> skb and supported XDP conversions, resets it on reused buffers, and rejects
> MIRRED flow offload where the software depth cannot be enforced. This scope
> covers software skb/XDP continuity, not packet loops through physical
> hardware or userspace device round trips.

I think it would be better to first go to the drawing board and make ONE
facility that governs the recursion part.

From a quick glance, the difference is historical from time when
per-module pcpu counters were used, so nf_dup netdev could not see the state
of nft_dup toggle.  Now that its in task struct anyway, maybe its time to
just zap the egress recursion counter and first make a patch that
uses the bool toggle for both egress and normal dup?

I would like to remove code, not add more.

> At PRE_ROUTING and LOCAL_IN, the IPv4 and IPv6 helpers decrement TTL or
> hop limit on the copy. Patch 3 stops creating copies when the value is
> <= 1, so the decrement cannot reach zero or wrap a zero value to the
> maximum.

Thats unrelated problem.  There are other places that do TTL/HL
decrements.  I think it makes sense to clean this up in -next and
add common helpers and then use those.
