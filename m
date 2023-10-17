Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C773CDB474
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Oct 2023 23:49:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2BB244056B;
	Tue, 17 Oct 2023 23:49:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2BB244056B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1697586566;
	bh=JHoC/c6ZHS7u0hTIdzJ2/H1pUwSn3D6NbJa+AsUNxQc=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=d73LoAtRBOgN0KQ1LCz2gIvYaeNlH5CIeFGWbcLP3ZWmqnDzETnWEpD3QhME8FpES
	 sqSD84WXsFHJ5vp4FBBoDhHWfzbS79xJCFo+YwK6kWuoadkC6LrNeQw/fy+8atTFUP
	 j7rUjTklOluy53KKc+4EBU7UOLqTZxUaTk4ZkSnNqbi69sLte8bOBC3ORRjZkpq5yV
	 etUNOQeL5lg01IhA29L8nrrfBRs9VuKoc9JD7Gse13FA82vikA7WJU5zX8R7tkdAvm
	 ooImGqdwk+fBc8F9p6gky9F7YY2JEgv2A6IB9YV/vhJj3myAkpFhYiyrLXRziCo0M8
	 3hY1D1kCZDn1A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uJCY-sJCHiZq; Tue, 17 Oct 2023 23:49:25 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id E5E20402A8;
	Tue, 17 Oct 2023 23:49:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E5E20402A8
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 7F5C01BF3EB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Oct 2023 23:49:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 57854402A8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Oct 2023 23:49:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 57854402A8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vxozB7bmrmzT for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Oct 2023 23:49:22 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2D08640273
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Oct 2023 23:49:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2D08640273
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 0E01DCE2255;
 Tue, 17 Oct 2023 23:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A9EC433C8;
 Tue, 17 Oct 2023 23:49:16 +0000 (UTC)
Date: Tue, 17 Oct 2023 16:49:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: takeru hayasaka <hayatake396@gmail.com>
Message-ID: <20231017164915.23757eed@kernel.org>
In-Reply-To: <CADFiAcLiAcyqaOTsRZHex8g-wSBQjCzt_0SBtBaW3CJHz9afug@mail.gmail.com>
References: <20231012060115.107183-1-hayatake396@gmail.com>
 <20231016152343.1fc7c7be@kernel.org>
 <CADFiAcKOKiTXFXs-e=WotnQwhLB2ycbBovqS2YCk9hvK_RH2uQ@mail.gmail.com>
 <CADFiAcLiAcyqaOTsRZHex8g-wSBQjCzt_0SBtBaW3CJHz9afug@mail.gmail.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1697586556;
 bh=MexSOo1RTu4wqGyRDUVunJf4jvcyJayGmORQAzJv3BI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=TmosqRnw6eYeeXCKHLlI4Ha9QwUDZ0FCf/QHS5J6lcI3sc5Qt7K1S8XD+tg5oYavu
 gFfkFP7t71Sh88xpMOHcpb3Uq5JXj9z32qjyQbrvOWqD9druQj25COP9M6ZkNXDPWn
 WVN3HYot/sNCESgGIzNowAg286q6+rt9zWRsVde5jkgytaogrlkv7hZUuzjrdwJvWo
 y5tnaWZjkx9p4piM7Vsd2337+EaWGvlFO9RXh6RK8EjIYi4j3BrGwUcVENL7pmr4Ib
 CGs2cokr8yjW/G7KuHnSWsg54rwvE+vteaojzMqlpVGbkMYPdszV+qgtV7I94zQCBL
 yyUPTor2FuwLA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=TmosqRnw
Subject: Re: [Intel-wired-lan] [PATCH net-next v2] ethtool: ice: Support for
 RSS settings to GTP from ethtool
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
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org,
 osmocom-net-gprs@lists.osmocom.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Harald Welte <laforge@gnumonks.org>, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Pablo Neira Ayuso <pablo@netfilter.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, 17 Oct 2023 23:37:57 +0900 takeru hayasaka wrote:
> > Are there really deployments where the *very limited* GTP-C control  
> I also think that it should not be limited to GTP-C. However, as I
> wrote in the email earlier, all the flows written are different in
> packet structure, including GTP-C. In the semantics of ethtool, I
> thought it was correct to pass a fixed packet structure and the
> controllable parameters for it. At least, the Intel ice driver that I
> modified is already like that.

I may be wrong (this API predates my involvement in Linux by a decade)
but I think that the current ethtool API is not all that precise in
terms of exact packet headers.

For example the TCPv6 flow includes IPv6 and TCP headers, but the
packet may or may not have any number of encapsulation headers in place.
VLAN, VXLAN, GENEVE etc. If the NIC can parse them - it will extract
the inner-most IPv6 and TCP src/dst and hash on that.

In a way TCP or IP headers may also differ by e.g. including options.
But as long as the fields we care about (source / dst) are in place,
we treat all variants of the header the same.

The question really is how much we should extend this sort of thinking
to GTP and say - we treat all GTP flows with extractable TEID the same;
and how much the user can actually benefit from controlling particular
sub-category of GTP flows. Or knowing that NIC supports a particular
sub-category.

Let's forget about capabilities of Intel NICs for now - can you as a
user think of practical use cases where we'd want to turn on hashing
based on TEID for, e.g. gtpu6 and not gtpc6?
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
