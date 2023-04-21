Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57006C77B71
	for <intel-wired-lan@archiver.kernel.org>; Fri, 21 Apr 2023 14:53:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E7E386FF7A;
	Fri, 21 Apr 2023 14:53:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E7E386FF7A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1682088784;
	bh=WQhsAeyAlrZ/5MsLcvvk0EFzl4Y3Yh6/0Bz464Ycuk4=;
	h=To:References:From:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=OYSJz8WOkcWp2aMJGK/VW4kbpSLss+JRyuvEthIcIKPLHdV4ezzF09rwIKxwjTK0z
	 YV9iuW2GCFjK5BdxTxe8+Zp2y+3y6h1KNiQqHm5oIPzcPSMPn4yv7lGstn3qHJHBlb
	 Qkqmi8ydZWjPAWhUxCStAiE4TeyaQllw37Bp81KqMwnZGziMogn5+Qa8IJCSws1a9I
	 WLJ6xfmLezyqm0HfhiSnXaJlVC9GCMlMe3FiNFO5dATzyUQL+Cx32RQpmxfEvxQVVL
	 BHFXfr8RnV9JisBWOMC4RcHdJhvtrK+cQ9QUv1ZUTsaM2/ULPia6nBXJ2W9MojIdXK
	 vJWJSgKHwXVSw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ppRYs0kNO7MI; Fri, 21 Apr 2023 14:53:04 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id F0A6E6FF76;
	Fri, 21 Apr 2023 14:53:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F0A6E6FF76
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id E52A01C279D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Apr 2023 14:53:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C824B41D96
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Apr 2023 14:53:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C824B41D96
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6uBmCG83wkHH for <intel-wired-lan@lists.osuosl.org>;
 Fri, 21 Apr 2023 14:53:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4F6B141D85
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4F6B141D85
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Apr 2023 14:53:00 +0000 (UTC)
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <daniel@iogearbox.net>)
 id 1pps7r-000NGA-SA; Fri, 21 Apr 2023 16:52:39 +0200
Received: from [85.1.206.226] (helo=linux.home)
 by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <daniel@iogearbox.net>)
 id 1pps7r-000VNF-7l; Fri, 21 Apr 2023 16:52:39 +0200
To: "Song, Yoong Siang" <yoong.siang.song@intel.com>,
 "Brouer, Jesper" <brouer@redhat.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 Stanislav Fomichev <sdf@google.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vu?=
 =?UTF-8?Q?sen?= <toke@redhat.com>
References: <168182460362.616355.14591423386485175723.stgit@firesoul>
 <PH0PR11MB583075A0520F8760657FC4BED89D9@PH0PR11MB5830.namprd11.prod.outlook.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f134a734-c67e-b546-b1ef-53da676acaf4@iogearbox.net>
Date: Fri, 21 Apr 2023 16:52:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <PH0PR11MB583075A0520F8760657FC4BED89D9@PH0PR11MB5830.namprd11.prod.outlook.com>
Content-Language: en-US
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26883/Fri Apr 21 09:25:39 2023)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=J9qyPU+PVnsNsWzTVs4DoiCRroFoofUuOFvtJinm82Q=; b=YRhhNtQVDz+1hX//XCxHP/YsIP
 9aAfbEclTj5/QSEk7AnKYOgmGBgADCYIyheaW8eJemBmSlEQ/2vSW5shnHyPr40uhHjhs1Y7yPj9X
 eXVO44Y187UjR54YHjwaSCNXHsAIAuXvc/nnWXKdvIl/3UoERRRBRJPwwtbfm7zgOPQx762hcbPM7
 UXTAamIUsT7dwHO32xHlzi6LsFKJbjB7qBtLfmeEt6ArG0mbfx6VDLPTMVKvaS4eP+BC9beqI0aDN
 eVF1lQCdtwgro4fzD2bBqdEuW7NcLgLmm+r9CLBW23p0KBpf5bgnj6HpICEWibmPRqyWRhzF9J/B5
 /xXEvWfA==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net
 header.a=rsa-sha256 header.s=default2302 header.b=YRhhNtQV
Subject: Re: [Intel-wired-lan] [xdp-hints] Re: [PATCH bpf-next V2 0/5]
 XDP-hints: XDP kfunc metadata for driver igc
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
Cc: "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
 "martin.lau@kernel.org" <martin.lau@kernel.org>, "Zaremba,
 Larysa" <larysa.zaremba@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "ast@kernel.org" <ast@kernel.org>, "Brandeburg,
 Jesse" <jesse.brandeburg@intel.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "hawk@kernel.org" <hawk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 4/18/23 4:53 PM, Song, Yoong Siang wrote:
> On Tuesday, April 18, 2023 9:31 PM, Jesper Dangaard Brouer <brouer@redhat.com> wrote:
>> Implement both RX hash and RX timestamp XDP hints kfunc metadata for driver
>> igc.
>>
>> First patch fix RX hashing for igc in general.
>>
>> Last patch change test program xdp_hw_metadata to track more timestamps,
>> which helps us correlate the hardware RX timestamp with something.
>>
>> ---
>> To maintainers: I'm uncertain which git tree this should be sent against. This is
>> primary NIC driver code (net-next), but it's BPF/XDP related (bpf-next) via
>> xdp_metadata_ops.
>>
>> Jesper Dangaard Brouer (5):
>>       igc: enable and fix RX hash usage by netstack
>>       igc: add igc_xdp_buff wrapper for xdp_buff in driver
>>       igc: add XDP hints kfuncs for RX hash
>>       igc: add XDP hints kfuncs for RX timestamp
>>       selftests/bpf: xdp_hw_metadata track more timestamps
>>
>>
>> drivers/net/ethernet/intel/igc/igc.h          |  35 ++++++
>> drivers/net/ethernet/intel/igc/igc_main.c     | 116 ++++++++++++++++--
>> .../selftests/bpf/progs/xdp_hw_metadata.c     |   4 +-
>> tools/testing/selftests/bpf/xdp_hw_metadata.c |  47 ++++++-
>> tools/testing/selftests/bpf/xdp_metadata.h    |   1 +
>> 5 files changed, 186 insertions(+), 17 deletions(-)
>>
>> --
> 
> This patchset lgtm.
> Thanks for the changes.

Siang, can I take this into the patches as your:

Acked-by: Song Yoong Siang <yoong.siang.song@intel.com>

?

Thanks,
Daniel
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
