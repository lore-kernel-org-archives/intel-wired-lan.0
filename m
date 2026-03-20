Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181901093177
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Mar 2026 06:06:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C031F41C94;
	Fri, 20 Mar 2026 06:06:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w6QiHkSNKF8G; Fri, 20 Mar 2026 06:05:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EF82F41C93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773986759;
	bh=pzYpIbPQzLRmoVZlDhNsuUG/czPwk1YNqqtzPT/dJxg=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0Pk4g1wGEHwJA4hF4wtYdOY2Ipltfxd7vdVrqGvV9iSVxlUq4CTyVQaDH0v+uGnIM
	 X9qoFB31eKWW+/X9n34YgtlHLONZpSl5HT/rV8XYGV5x8JPEWIaPB6WlSstBlMYe5W
	 cxAZT7XlMbB5yOB35mify8rmCgvfZ0JXEH6sl/BskJc91GGW60IbSTyr1ggmqSEqFq
	 2Niqy+3J64WA2CD78vqEQpxt7Bj+HUP5hcL1iTVtGJNhV7vh/V90iSg8PNi0MAhE76
	 9c0//5zQdNPpcoObzAmGMNQiocpRLlXHsdS7ujeR/+9MiXZs2QNVCRcoMk78bLuPoE
	 lU0IQTAZlccMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF82F41C93;
	Fri, 20 Mar 2026 06:05:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8722425C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 06:05:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6C69641C93
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 06:05:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x3sBLoRI-PV7 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Mar 2026 06:05:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=49.212.198.91;
 helo=www2881.sakura.ne.jp; envelope-from=kohei@enjuk.jp; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7056441C8F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7056441C8F
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7056441C8F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 06:05:55 +0000 (UTC)
Received: from x1 (122.24.31.150.dy.iij4u.or.jp [150.31.24.122])
 (authenticated bits=0)
 by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62K65Nak002627
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 20 Mar 2026 15:05:25 +0900 (JST) (envelope-from kohei@enjuk.jp)
Date: Fri, 20 Mar 2026 15:05:23 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Simon Horman <horms@kernel.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, dima.ruinskiy@intel.com,
 kohei.enju@gmail.com
Message-ID: <abzhZsk5FdB2eWeN@x1>
References: <20260317062205.39406-1-kohei@enjuk.jp>
 <20260319161140.GI1753385@horms.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260319161140.GI1753385@horms.kernel.org>
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 bh=pzYpIbPQzLRmoVZlDhNsuUG/czPwk1YNqqtzPT/dJxg=; 
 c=relaxed/relaxed; d=enjuk.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20251215; t=1773986725; v=1;
 b=lZx4xLIUMlFm6VvvIcjQMDAwFDO6xfzJHhgAN1JZKocAiGrvKB95zon25WEawmoC
 kXOgFIX3ds5c9IUSx43WNIo2gfse8JSHJ0P7SIHH55CyxVsbyjO4EucWlZAiBrB7
 Y/LbvS07zdGnILzZ0pLYp6vejzPIIqh8Tm9kgWZayHbBoXxTUt+uD/oTCil9ylsb
 CIkHI2HVwa19jAQ4HORh8g3ZCxAmXKWzrdQ8IEO7y4vCZKyjsCUQ/rJyq754gYr8
 ALGUq3r50UKWo1kBXu44yNhNhx0GYvg7ey9D1zicQyHX+HHjyboqAsEJyv8M3IoI
 bX3UNSNWkZSfItW7ycg3ng==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=enjuk.jp
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=enjuk.jp header.i=@enjuk.jp header.a=rsa-sha256
 header.s=rs20251215 header.b=lZx4xLIU
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 0/2] igc: enable build_skb
 path
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

On 03/19 16:11, Simon Horman wrote:
> On Tue, Mar 17, 2026 at 06:21:44AM +0000, Kohei Enju wrote:
> > This series enables the build_skb RX path in igc, which is currently not
> > enabled in any configuration.
> > 
> > Patch 1/2 adds missing RX hardware timestamp handling in the build_skb
> > path.
> > Patch 2/2 enables the build_skb path when XDP is inactive and other
> > conditions are met.
> > 
> > Tested on Intel Corporation Ethernet Controller I226-V (rev 04).
> > 
> > Changes:
> >   v2:
> >     - don't insist on reverse christmas tree, reducing net diff in the
> >       patch 1/2 (Dima)
> >   v1: https://lore.kernel.org/intel-wired-lan/20260307182808.155027-1-kohei@enjuk.jp/
> > 
> > Kohei Enju (2):
> >   igc: set RX hardware timestamps in igc_build_skb()
> >   igc: enable build_skb on the non-XDP small-frame RX path
> 
> For the series:
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Hi Tony, thanks for applying this series to next-queue.
I have a question about the process of patch submission.

Sometimes reviewers give RB tags for a whole series like this, but I
think that those tags on the cover letter are not collected
automatically, right?

In this case, should I add RB tags to each patch if I respin for other
reasons, or what is the recommended way to handle this?
