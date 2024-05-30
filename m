Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5997C25B74
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 May 2024 07:56:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6226F61049;
	Thu, 30 May 2024 07:56:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MxxmggVoeTXl; Thu, 30 May 2024 07:56:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9FFFA61047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1717055772;
	bh=mzh/UiHdl5hzkg2InsW3LfBL/uIYipnNKCWbnh02pdg=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=RFq54+NIHldjhTt2aq5klh9fKtXCbWk+9fEw/bxz3btnO9TrTcBcrt+yFT3QcjtmO
	 mAPWhbAZIXT/xM/hQvT7MtmcHTSeRaSnTzaPaAYqurvTkahKcM3+17w7/Nu2CK1sg7
	 0zC25EFcDRPjFHNkHzRcj5SEfA1LjfdHPabuby7ULDxUm1kSRHLpn4K34bIU8BA5DP
	 s/EOP/GyKlBmoEtlbe8zHnQw6o8rB/BezvGPdVUshF6ewwxLd3gtdLARn6mIl+GiSG
	 l8eGXl1d04SndqhxxTmrkTF6lXw4V81R+xrmqEITHLYPRe6Bs5ec2F9tSjHE1NTtnA
	 TOoJEDY7JuwOQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9FFFA61047;
	Thu, 30 May 2024 07:56:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id AC6A01D43A9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 May 2024 07:56:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8729983B32
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 May 2024 07:56:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3SUb_QYm0jeX for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 May 2024 07:56:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5C45983B2D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C45983B2D
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5C45983B2D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 May 2024 07:56:08 +0000 (UTC)
Received: from [141.14.13.3] (g258.RadioFreeInternet.molgen.mpg.de
 [141.14.13.3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8BF5D61E5FE01;
 Thu, 30 May 2024 09:55:33 +0200 (CEST)
Message-ID: <8d61678f-7494-4c26-a039-f5db633ab140@molgen.mpg.de>
Date: Thu, 30 May 2024 09:55:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: En-Wei WU <en-wei.wu@canonical.com>
References: <20240528100315.24290-1-en-wei.wu@canonical.com>
 <88c6a5ee-1872-4c15-bef2-dcf3bc0b39fb@molgen.mpg.de>
 <CAMqyJG0uUgjN90BqjXSfgq7HD3ACdLwOM8P2B+wjiP1Zn1gjAQ@mail.gmail.com>
 <971a2c3b-1cd9-48c5-aa50-e3c441277f0a@molgen.mpg.de>
 <CAMqyJG13Q+20p5gPpLZ1JYBS6yt5HZox0=gaT87vDyxN1rxRyA@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAMqyJG13Q+20p5gPpLZ1JYBS6yt5HZox0=gaT87vDyxN1rxRyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH] ice: irdma hardware init failed after
 suspend/resume
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
Cc: wojciech.drewek@intel.com, netdev@vger.kernel.org, rickywu0421@gmail.com,
 linux-kernel@vger.kernel.org, edumazet@google.com, anthony.l.nguyen@intel.com,
 kuba@kernel.org, intel-wired-lan@lists.osuosl.org, pabeni@redhat.com,
 davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Dear En-Wei,


Thank you for your quick reply.

Am 30.05.24 um 09:08 schrieb En-Wei WU:

>> Sorry for being unclear. I meant, does resuming the system take longer
>> now? (initcall_debug might give a clue.)
> I've tested the S3 suspend/resume with the initcall_debug kernel
> command option, and it shows no clear difference between having or not
> having the ice_init_rdma in ice_resume:
> Without ice_init_rdma:
> ```
> [  104.241129] ice 0000:86:00.0: PM: pci_pm_resume+0x0/0x110 returned 0 after 9415 usecs
> [  104.241206] ice 0000:86:00.1: PM: pci_pm_resume+0x0/0x110 returned 0 after 9443 usecs
> ```
> With ice_init_rdma:
> ```
> [  122.749022] ice 0000:86:00.1: PM: pci_pm_resume+0x0/0x110 returned 0 after 9485 usecs
> [  122.749068] ice 0000:86:00.0: PM: pci_pm_resume+0x0/0x110 returned 0 after 9532 usecs
> ```

Thank you for verifying this. Nice to hear, it has no impact.

[…]


Kind regards,

Paul
