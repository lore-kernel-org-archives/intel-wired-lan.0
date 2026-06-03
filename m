Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C65DCD6E55
	for <intel-wired-lan@archiver.kernel.org>; Wed,  3 Jun 2026 15:43:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 274DC84454;
	Wed,  3 Jun 2026 15:43:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PzjDR7ZUlvNz; Wed,  3 Jun 2026 15:43:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 053A784453
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1780501430;
	bh=ALxcJ38/KI+nrcVbIPqgS4dMUa9NwXNjv6BfuH3JzpQ=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6vSoc5y1ELZSGl0djJIbvWBxmbHBGdfyp9r9gmrd1mpwPHz7wQ0xH1KHHL2sIFQDu
	 G/fuMLMuHUoG20pfZCx/wuVFOr78pCr5FUOqPg/l8DEakvhfG0zyB8xZ36Ide55ddA
	 mgO+qzH+4euhyT1pYJvSC40LTfXB8KpZRJ7nFSE8N1WdJ2dSgwuPDPal7zpfiIq2e8
	 y6O4cbEfNLqd2f9/eEYKUeTL6YFTI8LbWu7vynR4xb3xuGO1eZlRIxl9uza+GjGDcv
	 tn2v8GJ9TPQ2OCuNNGsYDHLSbU4MuPcfBTm1dqnC23lMvRo4lDSHbzMjBZH78tGz0e
	 R24kTk2pToJEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 053A784453;
	Wed,  3 Jun 2026 15:43:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AD4C1192
 for <intel-wired-lan@lists.osuosl.org>; Wed,  3 Jun 2026 15:43:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9EEC1420FE
 for <intel-wired-lan@lists.osuosl.org>; Wed,  3 Jun 2026 15:43:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fg48OPcEQNDO for <intel-wired-lan@lists.osuosl.org>;
 Wed,  3 Jun 2026 15:43:47 +0000 (UTC)
X-Greylist: delayed 333 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 03 Jun 2026 15:43:47 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7473640027
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7473640027
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=51.81.61.66;
 helo=mta-102a.earthlink-vadesecure.net; envelope-from=sln@onemain.com;
 receiver=<UNKNOWN> 
Received: from mta-102a.earthlink-vadesecure.net
 (mta-102a.earthlink-vadesecure.net [51.81.61.66])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7473640027
 for <intel-wired-lan@lists.osuosl.org>; Wed,  3 Jun 2026 15:43:47 +0000 (UTC)
Received: from [192.168.0.23] ([50.47.159.51])
 by vsel1nmtao02p.internal.vadesecure.com with ngmta
 id c590d1c8-18b59c4657ae0029; Wed, 03 Jun 2026 15:37:52 +0000
Message-ID: <620a9c51-604b-4622-a9a3-40f6a54e7aa6@onemain.com>
Date: Wed, 3 Jun 2026 08:37:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dawei Feng <dawei.feng@seu.edu.cn>
Cc: aleksandr.loktionov@intel.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, zilin@seu.edu.cn
References: <eb74ae1c-3027-42f5-ad5b-a6f2c2cd6a98@onemain.com>
 <20260603032822.763195-1-dawei.feng@seu.edu.cn>
Content-Language: en-US
From: Shannon Nelson <sln@onemain.com>
In-Reply-To: <20260603032822.763195-1-dawei.feng@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256;
 bh=ALxcJ38/KI+nrcVbIPqgS4dMUa9NwXNjv6BfuH
 3JzpQ=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-unsubscribe-post:
 list-subscribe:list-post:list-owner:list-archive; q=dns/txt;
 s=dk12062016; t=1780501072; x=1781105872; b=YICi2Gl5iYhscsf53vglN3e1/uy
 47bOrYvxRnFxVBXT+OeCjYp81fx+t3MmqW3+NwGq/yiY+Hrk3OuN4U/oI7IVTOKIaMfm7j3
 2yvczT/p84E+vIiHUH0+MPWMPfqeuMIQXMuh3lVH+dmGbHOKHb6ilMuhMV61AFx7MNIfsWG
 hCL6vjiuRgHFY8dwkFMmLSiRAe1SLMj6YJ2Gjp3huX8TMPZRGcfd6Mn46F3sFKRFVaSYGRn
 HoghF60O8PFLLqBrwm7Tu/JTKgHpzVwVFAgc3k+pV4oeGDIgtyw5SkTQ2X3D2Xq0xOwGyTe
 Lo/4/4uGZOsPXN0j0/SaixuKLDNvttw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=onemain.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=earthlink.net header.i=@earthlink.net
 header.a=rsa-sha256 header.s=dk12062016 header.b=YICi2Gl5
Subject: Re: [Intel-wired-lan] [PATCH net] i40e: fix netdev leak in
 i40e_vsi_setup() error paths
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

On 6/2/26 20:28, Dawei Feng wrote:
> Hi Shannon,
>
> Thanks for the suggestion. I took a closer look at the cleanup paths, and
> I think the localized v1 fix is safer here.
>
> In particular, i40e_vsi_reinit_setup() has early failure paths that can
> reach i40e_vsi_clear() before unregister_netdev() is called. Moving
> free_netdev() into i40e_vsi_clear() could therefore free a
> still-registered netdev.
>
> So I plan to keep the current v1 approach for this fix, rather than moving
> free_netdev() into the common VSI teardown path.
>
> Best regards,
> Dawei

That sounds fine, thanks for looking.
sln

