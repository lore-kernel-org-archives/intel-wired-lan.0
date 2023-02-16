Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C241C61DA4
	for <intel-wired-lan@archiver.kernel.org>; Thu, 16 Feb 2023 03:15:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E6E4C81FC6;
	Thu, 16 Feb 2023 03:15:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E6E4C81FC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1676517318;
	bh=IzOHv596CkmpUrt8f/MJE2TwCLpfPsBcHm6h1wab3Sk=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=ZnMKTQiK19zgNtvCyUEw+cCjfjB4/6eTIA/62cWG7lqFzkLblBGbIWpQ6mIJSNl5g
	 vf88Rk38Z4yeBAl2ige3c5gIWJiwtaSbSxWw0a3kjXr/33m/aXa3nJr5KXK4ZpUuJL
	 Hq56lnnPz4TVHpnRYt+Tt200fADO44Vtbbw4DgRZBp3FHEW66An8nqNWp6/nB1tQuz
	 X7IODax486Hk9rKVLff3iJNcq4jNIKuOjFlBJ5qUqUXtr4roKuMOKFHGsbTc7Br8lZ
	 IQGxTGCCNk5wJLN7iGXnF0hymeLMp9aKLQoNM3qpBW0HsRG9kXlfseXRzWs3+HEIZ+
	 eiDjtmmx0/zMw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bPIHm1UXy5d3; Thu, 16 Feb 2023 03:15:18 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0BC0F81FCD;
	Thu, 16 Feb 2023 03:15:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0BC0F81FCD
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id BB8091BF968
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Feb 2023 03:15:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 93D3D81FCD
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Feb 2023 03:15:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 93D3D81FCD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ckzo4EKynlLb for <intel-wired-lan@lists.osuosl.org>;
 Thu, 16 Feb 2023 03:15:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED49581FC6
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ED49581FC6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Feb 2023 03:15:15 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D248461C1E;
 Thu, 16 Feb 2023 03:15:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB96BC433D2;
 Thu, 16 Feb 2023 03:15:13 +0000 (UTC)
Date: Wed, 15 Feb 2023 19:15:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Message-ID: <20230215191512.569639f3@kernel.org>
In-Reply-To: <c78c5e12-1c5a-5215-812c-b10d4b892a1b@intel.com>
References: <20230215124305.76075-1-tirthendu.sarkar@intel.com>
 <20230215124305.76075-9-tirthendu.sarkar@intel.com>
 <Y+zxY07GZ8aI7LrV@lore-desk>
 <c78c5e12-1c5a-5215-812c-b10d4b892a1b@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1676517314;
 bh=SkTYB1myVSbqy2YH5q5kjvenigagS1i5+u22wEHO37I=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ul51m5MwAqXBaV/sRf0ie4VIlmiKstrEtuHlZ85bYxYCd/o1kljzWlbXjgmTMrxQ7
 dhyXFrJlDCfTk4R3f/FC+jHrU86mHpLdyJeCkhvlF4AChQ8U8sgwvCesD8F1V6YptL
 6ioKDO9tPBMlo2gDoi4sXdkuVWn3QdgqnQCCSdXqTkCu4AhgWYNX45VP9I7X1fm1xj
 OTFkmmwzA+ylxgrcVOAbV+Nb/oY+GzjpRap9rS/plullo/2tdA5wseSBxoTzuMcJVV
 wwsI6sI9lhuFUb5mH9W6sFoo6lfIuENaGhDzm5yIceeOGVBqBtbOWGH38mSu4qTspg
 8PI/HI+mm1YQQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=ul51m5Mw
Subject: Re: [Intel-wired-lan] [PATCH intel-next v4 8/8] i40e: add support
 for XDP multi-buffer Rx
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
Cc: Tirthendu Sarkar <tirthendu.sarkar@intel.com>, netdev@vger.kernel.org,
 jesse.brandeburg@intel.com, intel-wired-lan@lists.osuosl.org,
 bpf@vger.kernel.org, magnus.karlsson@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, 15 Feb 2023 16:02:45 -0800 Tony Nguyen wrote:
> I believe you are planning on taking Lorenzo's ice [1] and i40e [2] 
> patch based on the comment of taking follow-ups directly [3]?
> 
> If so, Tirthendu, I'll rebase after this is pulled by netdev, then if 
> you can base on next-queue so everything will apply nicely.

Yup, applied now!
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
