Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA99C108B8FF
	for <intel-wired-lan@archiver.kernel.org>; Sat, 21 Mar 2026 07:13:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5EFC9847DD;
	Sat, 21 Mar 2026 07:13:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IC7gP4KlrZgo; Sat, 21 Mar 2026 07:13:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 90E39847DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774077223;
	bh=uLHqQj34n75qO7wvSMbuHtDwvogwxolNUwo4NK7ta/8=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NPVTySgz8XNsF3cvpiyidsNKJr654QvJWXHROKMbAT4rHIy/rxeX4aHeU936xHNuK
	 gAMbg8Zw+7u5Oszn55cgmar7rGlTFcbaiOT/0DAjwPCY8zVHNMD989qj90jXdljk1Q
	 TEN7UZnIubyvOXg1ESm2YOcWRWKt88isZhUh6qucv4wh4A3484qSrNpZM6glEXwRfZ
	 SFkGpTcL1vwjq+YjqjBgcoZpmi8gb0JIru8FM2b7xd6iM9Q1OyoRT7M4Q27/QIn0fd
	 9VaVqIAb4mzmZSI6DyCHn+zsdxo0DiIBZI8l9sVf5+zA4HS8cHjIgxPGsa77GvaHy5
	 BrxOzGboOHdfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 90E39847DA;
	Sat, 21 Mar 2026 07:13:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 13263265
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Mar 2026 07:13:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC92040590
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Mar 2026 07:13:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RB_9ahGvhhNb for <intel-wired-lan@lists.osuosl.org>;
 Sat, 21 Mar 2026 07:13:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=49.212.198.91;
 helo=www2881.sakura.ne.jp; envelope-from=kohei@enjuk.jp; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BF60540107
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF60540107
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BF60540107
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Mar 2026 07:13:40 +0000 (UTC)
Received: from x1 (122.24.31.150.dy.iij4u.or.jp [150.31.24.122])
 (authenticated bits=0)
 by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62L7D5sQ089997
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 21 Mar 2026 16:13:06 +0900 (JST) (envelope-from kohei@enjuk.jp)
Date: Sat, 21 Mar 2026 16:13:05 +0900
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
Message-ID: <ab5EzGyepRd8paKm@x1>
References: <20260317062205.39406-1-kohei@enjuk.jp>
 <20260319161140.GI1753385@horms.kernel.org> <abzhZsk5FdB2eWeN@x1>
 <02552c4b-e4ba-4750-afc9-aaa2a671f964@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02552c4b-e4ba-4750-afc9-aaa2a671f964@intel.com>
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 bh=uLHqQj34n75qO7wvSMbuHtDwvogwxolNUwo4NK7ta/8=; 
 c=relaxed/relaxed; d=enjuk.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20251215; t=1774077187; v=1;
 b=JtUb3ghTj8Ha7O9mQq0ln+SFa8s+LDZ6sqhDGYPYRCThvtIHq1s7BPV4oGxLVCSu
 9ZhdJVH6Z8g0romwv0kGHa3Yn4tOComdMh3+tppz5xwxLKzJuDfeyrplmIWaQJMe
 NMcnnkgLnJHQMmG0PQehgDgpsiy9jznFTfRjkkGtt17sLx/2uWJtFD6Sl0Zt2zV8
 xAp2fBRtGxIYzeBgUoNDOWYYtac187lGT683XJC0edMnEZwkcNhauiVhATFyigVB
 rhECiTCaonWgNuRol7JZWILWGki+7G2HrMF3OwbCwqxOdtjOldBUmDDPkVcnrJvT
 6y5k+tk26L8Vqyn/x319ew==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=enjuk.jp
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=enjuk.jp header.i=@enjuk.jp header.a=rsa-sha256
 header.s=rs20251215 header.b=JtUb3ghT
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

On 03/20 13:30, Tony Nguyen wrote:
> 
> 
> On 3/19/2026 11:05 PM, Kohei Enju wrote:
> > On 03/19 16:11, Simon Horman wrote:
> > > On Tue, Mar 17, 2026 at 06:21:44AM +0000, Kohei Enju wrote:
> > > > This series enables the build_skb RX path in igc, which is currently not
> > > > enabled in any configuration.
> > > > 
> > > > Patch 1/2 adds missing RX hardware timestamp handling in the build_skb
> > > > path.
> > > > Patch 2/2 enables the build_skb path when XDP is inactive and other
> > > > conditions are met.
> > > > 
> > > > Tested on Intel Corporation Ethernet Controller I226-V (rev 04).
> > > > 
> > > > Changes:
> > > >    v2:
> > > >      - don't insist on reverse christmas tree, reducing net diff in the
> > > >        patch 1/2 (Dima)
> > > >    v1: https://lore.kernel.org/intel-wired-lan/20260307182808.155027-1-kohei@enjuk.jp/
> > > > 
> > > > Kohei Enju (2):
> > > >    igc: set RX hardware timestamps in igc_build_skb()
> > > >    igc: enable build_skb on the non-XDP small-frame RX path
> > > 
> > > For the series:
> > > 
> > > Reviewed-by: Simon Horman <horms@kernel.org>
> > 
> > Hi Tony, thanks for applying this series to next-queue.
> > I have a question about the process of patch submission.
> > 
> > Sometimes reviewers give RB tags for a whole series like this, but I
> > think that those tags on the cover letter are not collected
> > automatically, right?
> > 
> > In this case, should I add RB tags to each patch if I respin for other
> > reasons, or what is the recommended way to handle this?
> 
> Hi Kohei,
> 
> If you need to respin, feel free to carry the tags over. If you don't, I'll
> bring them over.
> 
> Thanks,
> Tony
> 

I understand. Thanks for explanation!

Regards,
Kohei
