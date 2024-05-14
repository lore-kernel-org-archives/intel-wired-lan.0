Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72431C04FFE
	for <intel-wired-lan@archiver.kernel.org>; Tue, 14 May 2024 09:48:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 24557416FD;
	Tue, 14 May 2024 09:48:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0x76Xli7SA0D; Tue, 14 May 2024 09:48:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 865C6409DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1715680117;
	bh=OftvRN5FYOGb0QnfwZasmhuCm52IoMGg8swzhWcgK/0=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=gQFTlvjbHm8/61MZK1ja84itEvBlpbJPVIMxlNk8dbZKxaFktEqzGGbV4aZyoQYDw
	 wW0wL8Y+YTgY9L9RI5Zo1CoGvGUWWBR4Q3hQ0YA7LAN33yG8u5AwVaBUTF4wP9l2K7
	 9aR686tw0PgA6eJ6P6glm4i/kv/lGtXidLH3jpUTIPF/l0Gedxft+Mw/G/4Ydvmzg4
	 pZichuwX9Pe4R4zxYm0o4ZmdOoTr/lCFFaNBfH83qZ0IfpDrAizDIIG/3UdH+bIFnj
	 4Uzwy0jG+TmCROo97DOJOxjb9e4uBsiql2VdZjJspLD7JFmbnGWMmm6At9g4o7suLR
	 56hzsfdir/T8g==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 865C6409DB;
	Tue, 14 May 2024 09:48:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 11C931BF293
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 May 2024 09:48:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 09817402DE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 May 2024 09:48:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BSb7o2Yvx8Yd for <intel-wired-lan@lists.osuosl.org>;
 Tue, 14 May 2024 09:48:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.237.130.52;
 helo=wp530.webpack.hosteurope.de; envelope-from=regressions@leemhuis.info;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8F205401B1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8F205401B1
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [80.237.130.52])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8F205401B1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 May 2024 09:48:30 +0000 (UTC)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1s6olk-0001jy-TO; Tue, 14 May 2024 11:48:24 +0200
Message-ID: <ce8b63da-8bc0-456d-8fff-23e937871246@leemhuis.info>
Date: Tue, 14 May 2024 11:48:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Bagas Sanjaya <bagasdotme@gmail.com>, Andrew Lunn <andrew@lunn.ch>
References: <ZkHSipExKpQC8bWJ@archie.me>
 <b2897fda-08e8-40de-b78a-86e92bde41db@lunn.ch>
 <56463a97-eb90-4884-b2f5-c165f6c3516a@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <56463a97-eb90-4884-b2f5-c165f6c3516a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1715680110;
 7436098a; 
X-HE-SMSGID: 1s6olk-0001jy-TO
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
 Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
 References; bh=OftvRN5FYOGb0QnfwZasmhuCm52IoMGg8swzhWcgK/0=; t=1715680110;
 x=1716112110; b=IOGPRYlMNs96EVaXdY+NLEl9HXYKvvy1zfzwIDvVCp6W8n/VtQg8oWyAFA0ZV
 1yWJYG66ck40o1N3iO+wYZabLtSqmLnT+2bWkU4Bqqu9uQ5NSJyksXFs7TNxhdAcF9PUuuVkciC06
 qiYhi/rTErb7/RxknVnM/Q9d5Xxt/dFHy/dqwXQYHdimmXiGP1YyIWT75L+U0C+8IW8HjSU0TnEuG
 HIsAHLZq7/SrwTYbtWZYipuqxaqNDTd4oXn9sw5oQhV2wQX5USXZLKEC3GEJqwzVTMF50b1/EtAGp
 jsbpsCeaf/aHbsDFtM9/CZAH6dI7FuAdowFkuEdaYeWTjtMN2A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=leemhuis.info
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=leemhuis.info header.i=@leemhuis.info
 header.a=rsa-sha256 header.s=he214686 header.b=IOGPRYlM
Subject: Re: [Intel-wired-lan] Regression of e1000e (I219-LM) from 6.1.90 to
 6.6.30
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
Cc: Linux Regressions <regressions@lists.linux.dev>,
 lukas.probsthain@googlemail.com, Linux Networking <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, intel-wired-lan@lists.osuosl.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 14.05.24 06:34, Bagas Sanjaya wrote:
> On 5/14/24 00:17, Andrew Lunn wrote:
>> On Mon, May 13, 2024 at 03:42:50PM +0700, Bagas Sanjaya wrote:
>>>
>>> <lukas.probsthain@googlemail.com> reported on Bugzilla
>>> (https://bugzilla.kernel.org/show_bug.cgi?id=218826) regression on his Thinkpad
>>> T480 with Intel I219-LM:

Bagas, why did you start forwarding these bugs by mail yourself again
after we had agreed you forward them to me, so I can handle it from there?

Yes, you forwarded that particular bug to me a few days ago and I didn't
do anything. But that was on purpose: I usually wait at least two
working days before doing so, as some subsystem are active in bugzilla
and might feel annoyed by starting a separate thread on the mailing list.

Side note: you also apparently make it not obvious enough that you are
just forwarding the bug, as both here and in the other bug your
forwarded today the developer apparently thought it was a bug you face.

Please lets avoid all of that again and switch back to the model we
agreed on a few months ago.

>>>> After updating from kernel version 6.1.90 to 6.6.30, the e1000e driver exhibits a regression on a Lenovo Thinkpad T480 with an Intel I219-LM Ethernet controller.
>>
>> Could you try a git bisect between these two kernel versions? You
>> might be able to limit it to drivers/net/ethernet/intel/e1000e, which
>> only had around 15 patches.
>
> The BZ reporter (Cc'ed) says that bisection is in progress. You may
> want to log in to BZ to reach him.

Side note: you should not assume every developer has a BZ account (or is
willing to create one).

Ciao, Thorsten
