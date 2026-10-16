Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FC8CCA46C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 16 Oct 2026 16:20:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9830A60B15;
	Fri, 16 Oct 2026 16:20:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Ots4dP5Ij4G; Fri, 16 Oct 2026 16:20:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B7CD460ADD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792167632;
	b=D/glc0ouoTnYPLBsYLl47VI13tqKMhvTd8mly+w6/zW7OgvyPNXDzD3kSgjjtdRdXxcj
	 yX7bIu9O3glZbvmdxq6Zw07YbP7RRSi+u6v4ZVkaeqmGkOaVVVcSu52F9zgOW4XBNPXRm
	 fUhA/e7Hvwz7Rb9a9lz7w3LGu6iFEaLtnUIypdS/bJ2qlC2/VSFcvk14LxFW3u2Dcwb3q
	 UpaHe8pDIxsx3qUTkFCB9eg7cXatPWFS7VSmggqBTB6v1oOTGa/leNgxf3X26U98HM5Vl
	 NBb0HNNlJOEnmuA2mC9OM4hlnL5sZnlNg1Fm+mufBjaAbpF26d2oUx9PV81C1VY/Jcw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792167632;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=h2VtlyQh8P+LO9nN6/lenuqctdjkpkvcErfDdP/bz1Y=;
	b=WA/1i91sT7RD98+oS7gkgCBpsDxuswaz96vmqkvMJFcB30aQMPTYT8aNxL6In7piwOyB
	 PqLkr4BDRVyEcJjFPPPioj3x84JQj+yFGR3SdCu4Ga486UXo0EhM3we88VuhC1kX6Fohg
	 T1ilJe6QytvAX/gp7W2o6Z1/K3/pWxqzGoPUN7QxU0PhT8U6kgFSicWfLRvKJP9QREUOH
	 /6yS3Y6lET6wlqKetJZZrQdpcFP+BrYCtwzBsrpxJ0juCIpjZIdJI5EWicobSzM2oV/aS
	 epzx9Rm3JHq6TWcxTaD28SJxn2e8xaXUEq3evnLhHslWM+2kMrrwy/Qn7ZRjfjkp2eQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792167632;
	bh=h2VtlyQh8P+LO9nN6/lenuqctdjkpkvcErfDdP/bz1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vkFN1EuXAgY35RDslmJnRU6DmQPWZ//L3sqnThpRsJBKgoRZVVAwa2CTWtdzHGRxd
	 iEY1Gq+WSlFOjUzH9iSTNonoTjmabiw5N+B2wwZ/flSQSUQ2SzDA6Rmy1pTUf+Cvvw
	 gRx21QmtvBsvmlf1WEyexNGZjQcdOFPbewnQhVw3dOAQk1ZSRLo0d+q2UTssk5PekV
	 bXyAnoPtjDhQv21tqVAi54Ui7G2hK5rMMFDhMOsLpRCQ+zaebsiVwzAp1rcsI8Bcy7
	 fNt1x7ah5LKwKLjtplBTO8/x7qFhdonb8xAbafJ+V9xFQvqhKDl4O8lCoJYwYnW/p4
	 GrHnLeyVxEEnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B7CD460ADD;
	Fri, 16 Oct 2026 16:20:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 08A177AD
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Oct 2026 16:20:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 048DE40A39
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Oct 2026 16:20:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qtu6dhZ6NI-n for <intel-wired-lan@lists.osuosl.org>;
 Fri, 16 Oct 2026 16:20:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5345A40A38
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a0a:51c0:0:237:300::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792167630;
 b=jZhVr14oaviYJGRGVAp6FU8DEv/ZfdH/P3aDHNTgZ71PxKLuY/VA3MEJ+ba9IeQYJ6n2
 JKmgOj4YlNfm0bGufIRLZABbHELFcbyGiOJJqfzUPisJEZ154vfT7of0jzQy7HiDwWo5n
 3AVvvBsTayMHXiKZdNOSgPCwGg3Rws4th1DGBLnDL4zDbwEiK3s0SxGoummK3S0F8PiyO
 b4SYQZXC9sEFOQBfj7F241OUE6sEpkAPj4GOidznQbXLsOB5xqF2SdN4YDq/c5S93vLig
 dA2nZlwdtwr2DYWG9CRD6huFyPerH15X30WsxqUkvm6MNPwBeJzscdgNk8AzcNb9jPQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792167630;
 h=Received-SPF:Received:Date:From:To:Cc:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=h2VtlyQh8P+LO9nN6/lenuqctdjkpkvcErfDdP/bz1Y=;
 b=I441hqjBB7qtocWptntkFZ8vF/XspqvXjqiNPyNghGtKD+LvSGIr32B2b8OChZOMs66V
 kwwZSQBJZAADk/J6UeS00alEkJ8JsThcwVwzI2nCJlyKHOWGlEKZYITycsJOAUC4N5Ka2
 HN5OO4LV8K1WilZxIWJNCAcf49qcmkXc2tFbwCj8HF8OEhyhn/7tzyBommTDsB2Y5FT/P
 bl/oVJPxG8kCrmzUJhIfEVufrpWLPZI/68Iqr967iuuIJVfR5FTLCELaJWzCURTggGYwQ
 Bv+Od8mqHvQaayzeW+iA1JDJnuxqGwcM/ORyokWxs3eBpoYNjq7x2peYmZsL5mQpBlw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=strlen.de;
 arc=none smtp.remote-ip="2a0a:51c0:0:237:300::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a0a:51c0:0:237:300::1; helo=chamillionaire.breakpoint.cc;
 envelope-from=fw@strlen.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=strlen.de
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
 [IPv6:2a0a:51c0:0:237:300::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5345A40A38
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Oct 2026 16:20:28 +0000 (UTC)
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
 id 4E86A60327; Fri, 16 Oct 2026 18:20:24 +0200 (CEST)
Date: Fri, 16 Oct 2026 18:20:23 +0200
From: Florian Westphal <fw@strlen.de>
To: zihan xi <zihanx@nebusec.ai>
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
Message-ID: <atJOxy1Q4twlJSJB@strlen.de>
References: <cover.1792048855.git.zihanx@nebusec.ai>
 <atCtUFcG9b4ykXY3@strlen.de>
 <CAANe3eTSz3-EE0=9JNFBMFDqZ9NUfScHdi8EN30UVaTiRq0vcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAANe3eTSz3-EE0=9JNFBMFDqZ9NUfScHdi8EN30UVaTiRq0vcg@mail.gmail.com>
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

zihan xi <zihanx@nebusec.ai> wrote:
> I will send a one-patch v9 series for the NFQUEUE guard preservation
> only. It does not address netdev duplication or claim to provide a
> general facility for bounding every asynchronous duplication path.

makes sense to me, thanks!
