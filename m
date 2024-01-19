Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FD7C4725D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 19 Jan 2024 11:06:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 07BCF42C6D;
	Fri, 19 Jan 2024 11:06:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 07BCF42C6D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1705662385;
	bh=mqGE8/V8zgG3PeWrPUc6QzHMY48GdktqfSRMTBZU6aM=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Et0DHAHj0Pzx903PqoT7keXJN3N2T9gVvYHDngvfCQqnBNT3I706cXGLvQvIXVZYA
	 b8RrGAPT4dPiwF6jCiia8Bcs1gVo4WpWU7e8b7IVKecVa5P3nzbyqwfWyzVo2y+yMN
	 5TugsTUeI39yJ+q034C/1MmcSusmMvtk2T4kFaTOXIm61TDGiDexHNK3CmwlKfV6uW
	 YxNPYsjCgkHKP/ojClMp+GdgrvgvPBGVCWqBGsbPDxGpmdMK8qMClRMphqZ0F9i3LT
	 vtIVZDwhpYuy7PTJLIqOuJc7H4AUfiJuyQ9Of6mWBGl2aPaTh9uJchmTbm3H4i/fSH
	 gbhhv/GNWT3jA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eCWSvDtqygGS; Fri, 19 Jan 2024 11:06:24 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id F242042C77;
	Fri, 19 Jan 2024 11:06:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F242042C77
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 159621BF5A6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 19 Jan 2024 11:06:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DD7E56F76F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 19 Jan 2024 11:06:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DD7E56F76F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VFA0wgSTu_fg for <intel-wired-lan@lists.osuosl.org>;
 Fri, 19 Jan 2024 11:06:21 +0000 (UTC)
X-Greylist: delayed 2584 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 19 Jan 2024 11:06:21 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B1CDB60BA0
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [80.237.130.52])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B1CDB60BA0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 19 Jan 2024 11:06:21 +0000 (UTC)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1rQm1q-0005M4-8D; Fri, 19 Jan 2024 11:23:14 +0100
Message-ID: <0489bb44-c21d-4a90-b7e3-300b2313dc3a@leemhuis.info>
Date: Fri, 19 Jan 2024 11:23:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: intel-wired-lan@lists.osuosl.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <CAK8fFZ7Xi3=1HFY400firmpRWzHDPsi90cUU5bjOkF00KNZWeA@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <CAK8fFZ7Xi3=1HFY400firmpRWzHDPsi90cUU5bjOkF00KNZWeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1705662381;
 43607038; 
X-HE-SMSGID: 1rQm1q-0005M4-8D
Subject: Re: [Intel-wired-lan] [REGRESSION] Intel ICE Ethernet driver in
 linux >= 6.6.9 triggers extra memory consumption and cause continous
 kswapd* usage and continuous swapping
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
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 08.01.24 11:49, Jaroslav Pulchart wrote:
> 
> I would like to report a regression triggered by recent change in
> Intel ICE Ethernet driver in the 6.6.9 linux kernel. The problem was
> bisected and the regression is triggered by
> fc4d6d136d42fab207b3ce20a8ebfd61a13f931f "ice: alter feature support
> check for SRIOV and LAG" commit and originally reported as part of
> https://lore.kernel.org/linux-mm/CAK8fFZ4DY+GtBA40Pm7Nn5xCHy+51w3sfxPqkqpqakSXYyX+Wg@mail.gmail.com/T/#m5217c62beb03b3bc75d7dd4b1d9bab64a3e68826
> thread.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 4d50fcdc2476ee
#regzbot title net: ice: extra memory consumption and cause continous
kswapd* usage and continuous swapping
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
