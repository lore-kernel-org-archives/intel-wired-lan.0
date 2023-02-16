Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954C2C636CC
	for <intel-wired-lan@archiver.kernel.org>; Thu, 16 Feb 2023 10:33:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 30C4140C9F;
	Thu, 16 Feb 2023 10:33:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 30C4140C9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1676543630;
	bh=SvebKbW5/TnIug/zMNbKZ406Issg7ix5jNaZu35qkzg=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:Cc:From;
	b=88qVUHX0gabtUlhwgtBoy9lby91aoDFtsk05DWB+wvyYH04w/OXAm7u/9v3+1vVOC
	 +a9QCVbFfyo8919Xwv09UQ2zVR4j1cHfo2Z807N1b4UyFPN5P5UFrPBptjBGPOffzx
	 HU0HXpcfQdns8xEIz6hlDN7jV1Xoj35rwFulMvOoCLeCSXnhW2EzNmIeYEtNLGVUM0
	 axMsAfDFWh367P8fKAScskZ0JbxSfXX+Y9KjuMcisufHVCkf/s2WCKBogdAi/ULy4w
	 KsjepllOWCd09ZZjDfQQqpvTcwutXn6cXhIuo1tI8OQ0BFqUJNZBgjOVL7iNVsBjEk
	 oFqV9fH8iu+TA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aFNHUMbUQ4EK; Thu, 16 Feb 2023 10:33:48 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 51D5A40C9D;
	Thu, 16 Feb 2023 10:33:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 51D5A40C9D
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 0EFBE1BF333
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Feb 2023 10:33:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D747981F28
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Feb 2023 10:33:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D747981F28
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id slzf85dv2PsO for <intel-wired-lan@lists.osuosl.org>;
 Thu, 16 Feb 2023 10:33:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2773181F1F
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [80.237.130.52])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2773181F1F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Feb 2023 10:33:44 +0000 (UTC)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1pSba8-0001qa-HS; Thu, 16 Feb 2023 11:33:40 +0100
Message-ID: <eca2d453-5b0b-b012-dcf8-be6e197536db@leemhuis.info>
Date: Thu, 16 Feb 2023 11:33:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Content-Language: en-US, de-DE
To: Dave Ertman <david.m.ertman@intel.com>, intel-wired-lan@lists.osuosl.org
References: <20230215191757.1826508-1-david.m.ertman@intel.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <20230215191757.1826508-1-david.m.ertman@intel.com>
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1676543625;
 9ba394cf; 
X-HE-SMSGID: 1pSba8-0001qa-HS
Subject: Re: [Intel-wired-lan] [PATCH net v2] ice: avoid bonding causing
 auxiliary plug/unplug under RTNL lock
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
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 15.02.23 20:17, Dave Ertman wrote:
> RDMA is not supported in ice on a PF that has been added to a bonded
> interface. To enforce this, when an interface enters a bond, we unplug
> the auxiliary device that supports RDMA functionality.  This unplug
> currently happens in the context of handling the netdev bonding event.
> This event is sent to the ice driver under RTNL context.  This is causing
> a deadlock where the RDMA driver is waiting for the RTNL lock to complete
> the removal.
> 
> Defer the unplugging/re-plugging of the auxiliary device to the service
> task so that it is not performed under the RTNL lock context.

Thanks for taking care of this.

> Reported-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
> Link: https://lore.kernel.org/linux-rdma/68b14b11-d0c7-65c9-4eeb-0487c95e395d@leemhuis.info/

FWIW, that should be

Link:
https://lore.kernel.org/netdev/CAK8fFZ6A_Gphw_3-QMGKEFQk=sfCw1Qmq0TVZK3rtAi7vb621A@mail.gmail.com/

instead, as that's Jaroslav's report

> Fixes: 5cb1ebdbc434 ("ice: Fix race condition during interface enslave")
> Fixes: 425c9bd06b7a ("RDMA/irdma: Report the correct link speed")
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> [...]

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
