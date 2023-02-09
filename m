Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F09C05027
	for <intel-wired-lan@archiver.kernel.org>; Thu,  9 Feb 2023 02:57:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 169ED4091F;
	Thu,  9 Feb 2023 02:57:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 169ED4091F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1675911475;
	bh=1ZepYvMyJOrPjxHtEr/JU5OqLJ3VtB5oaaYZj+QypAk=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=gS7Dw2GNZZ9aGSbVXvgUn/DsT8nE3i7QLXZ3qXiTsE1rNbK3Ff0UtvMpp1h/n3LDr
	 7e9KzSKXF4m0PpHGXrQhjTlLhhifLqLdqPFG4Vevhx3r36E6PRmnRDezUQD+Uwp/IO
	 J3ZEOLlR6lwHLXDCAi6lQqDOO7hzrEDD4zoBgXWnyJ+SRmvjLfWOu3BqUaU7PJqxfe
	 1FLy7S3cyqbyjhWUayil/NGuCUACdXIoRpEGdDFgaq5zMHBGXwpFjJeB8N3oKlpuTi
	 i7kVx8KyefrrjbbyJVjAK2x9za9lhMfq8kUVERpFBvptRRzYp9qioj6kf0ewr8Bwfy
	 2M5ZnDj4e66Wg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yNpZzwIMBGfF; Thu,  9 Feb 2023 02:57:54 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id E13A240929;
	Thu,  9 Feb 2023 02:57:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E13A240929
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id B76C41BF31B
 for <intel-wired-lan@lists.osuosl.org>; Thu,  9 Feb 2023 02:57:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8627640948
 for <intel-wired-lan@lists.osuosl.org>; Thu,  9 Feb 2023 02:57:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8627640948
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zaR-xkZFE_ic for <intel-wired-lan@lists.osuosl.org>;
 Thu,  9 Feb 2023 02:57:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 42CAC4091F
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 42CAC4091F
 for <intel-wired-lan@lists.osuosl.org>; Thu,  9 Feb 2023 02:57:51 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1C18861857;
 Thu,  9 Feb 2023 02:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B614FC4339B;
 Thu,  9 Feb 2023 02:57:48 +0000 (UTC)
Date: Wed, 8 Feb 2023 18:57:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Message-ID: <20230208185747.1266ff72@kernel.org>
In-Reply-To: <CAL+tcoBEv6tiAES-JPF4er_bkQWuqZ1m0ouVc19EARCOcaDidQ@mail.gmail.com>
References: <20230204133535.99921-1-kerneljasonxing@gmail.com>
 <20230204133535.99921-4-kerneljasonxing@gmail.com>
 <CAL+tcoD9nE-Ad7+XoshoQ8qp7C0H+McKX=F6xt2+UF1BeWXKbg@mail.gmail.com>
 <CAKgT0Uc7d5iomJnrvPdngt6u9ns7S1ismhH_C2R1YWarg04wWg@mail.gmail.com>
 <CAL+tcoBEv6tiAES-JPF4er_bkQWuqZ1m0ouVc19EARCOcaDidQ@mail.gmail.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1675911469;
 bh=a28hWGAgXHcKzAwvAl61mkMfOBl1pXY4hll/Ho3lNJU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=hFGueY1iBFTGzvoCXw8WuYMojfQ7hm/W72zRL2305nodv0mlftmUGZavHgrsI4p9c
 TG5mJ5zSKf6rzrUOpIIJN225l2j2nVRUoKxRulY6qucGkDe2QxVBBvQSOLt7ONNURk
 KXrFIoTiQRzoE2gSh9f90/8Qgke2CQMQV68kCVqLMcHb+//khyYuJ9iUmG28FQq1oI
 sEPqYWPur0GwmuZ8Fdy7H2L1Rw9gWCii0xeNTpmYrmDyuBXY3Ve05uqQjCn2IvxTEv
 z/exISKVOoMgyRHdC2rWmDW2eIQcMKLpPA8yEDhAC+8EmNjBdtHLqsth5lnn11BG4F
 9oHzLIq+aNUuA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=hFGueY1i
Subject: Re: [Intel-wired-lan] [PATCH net 3/3] ixgbe: add double of VLAN
 header when computing the max MTU
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
Cc: daniel@iogearbox.net, Jason Xing <kerneljasonxing@gmail.com>,
 intel-wired-lan@lists.osuosl.org, richardcochran@gmail.com,
 john.fastabend@gmail.com, jesse.brandeburg@intel.com, ast@kernel.org,
 edumazet@google.com, anthony.l.nguyen@intel.com,
 Jason Xing <kernelxing@tencent.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 linux-kernel@vger.kernel.org, hawk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, 9 Feb 2023 10:22:19 +0800 Jason Xing wrote:
> > It looks like this patch isn't in the patch queue at:
> > https://patchwork.kernel.org/project/netdevbpf/list/
> 
> I got it.
> 
> I have no clue on how patchwork works, I searched the current email,
> see https://patchwork.kernel.org/project/netdevbpf/patch/20230204133535.99921-4-kerneljasonxing@gmail.com/.
> 
> > I believe you will need to resubmit it to get it accepted upstream.

The patches are marked as Awaiting Upstream, that's why they don't show
up. We usually let Tony pick up patches for Intel's drivers rather than
applying directly.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
