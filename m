Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65663C77B61
	for <intel-wired-lan@archiver.kernel.org>; Mon,  1 May 2023 07:51:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 029BB8210C;
	Mon,  1 May 2023 07:51:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 029BB8210C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1682927507;
	bh=lVzzCCQtnczIYthGjMR/+800T+92j6DCCxu95NaD+Os=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:Cc:From;
	b=gr3pcLSUT2nZkQ5OAJLJc8R8fofadVUK/DcuGaBzVAx9L91X3CcMZ/+gTdYk3iNkL
	 CZ8sdAnyjpLm2/m4FjFaKhlRb7aehnpidn8EdxIlkE/D/NpA3p4diN7y5oVCZECsTN
	 ChyHvcRXXoT25Fp87YNxJs615wI/lesPGhAQvh7kEC09PgeZ79WBnhCKVYJG6+tL1X
	 htZYca9Ashn6Rov7F9j0Cq4gBnDyh/ml0+g79oWZFaBXst5YA6QorQiP70z3TGdjL/
	 xY8slsu9kZ++rRlgxupQ/66TOdSDtWphE8pya4r4gsnS/Dd46o68IuVZjnhw/GDohx
	 Igb55CMV1Fhyg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qPh9P_uCe1E2; Mon,  1 May 2023 07:51:46 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A00C8210E;
	Mon,  1 May 2023 07:51:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0A00C8210E
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 14E941BF2EF
 for <intel-wired-lan@lists.osuosl.org>; Mon,  1 May 2023 07:51:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E04E9606B0
 for <intel-wired-lan@lists.osuosl.org>; Mon,  1 May 2023 07:51:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E04E9606B0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AsJVspsQgh-y for <intel-wired-lan@lists.osuosl.org>;
 Mon,  1 May 2023 07:51:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A527A60625
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [80.237.130.52])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A527A60625
 for <intel-wired-lan@lists.osuosl.org>; Mon,  1 May 2023 07:51:43 +0000 (UTC)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1ptOJu-0005vr-8r; Mon, 01 May 2023 09:51:38 +0200
Message-ID: <a1e13fdc-c19c-b937-c33a-784071bec9df@leemhuis.info>
Date: Mon, 1 May 2023 09:51:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, de-DE
To: Ian Kumlien <ian.kumlien@gmail.com>,
 intel-wired-lan <intel-wired-lan@lists.osuosl.org>
References: <CAA85sZuTsq4cKMV0=pTP_=mgb5CxYXGxNDpmF1NCfrmpvCpJdQ@mail.gmail.com>
From: "Linux regression tracking #adding (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <CAA85sZuTsq4cKMV0=pTP_=mgb5CxYXGxNDpmF1NCfrmpvCpJdQ@mail.gmail.com>
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1682927503;
 cd5bce79; 
X-HE-SMSGID: 1ptOJu-0005vr-8r
Subject: Re: [Intel-wired-lan] [ixgbe] regression: jumbo frames not working
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
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 28.04.23 23:13, Ian Kumlien wrote:
> 
> Since upgrading to kenel 6.3, I've hit an issue...
> 
> I historically use 9k jumboframes on my network as such:
> 3: eno1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP
> group default qlen 1000
> 
> But now the largest frame i can send is 2030 bytes (ie ping -s 2002)...
> 
> I don't see any warning from the XDP subsystem so I almost assume
> that's not it...

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced v6.2..v6.3
#regzbot title net: ixgbe: jumbo frames stopped working
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
