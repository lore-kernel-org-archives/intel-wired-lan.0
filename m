Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3A7C021B5
	for <intel-wired-lan@archiver.kernel.org>; Mon, 24 Feb 2025 08:25:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE684404C3;
	Mon, 24 Feb 2025 08:25:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E_XudYFnwcfO; Mon, 24 Feb 2025 08:25:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EE8D4404DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1740385551;
	bh=X1EA7cv3/H0PiCRYNRxGjgDmwAn05ztfqNloQha39Ro=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cFMxKiviyFoTBi4hbJlqDZYXE6kPCLBBezpcM4hs77rQILfbXcRSMrqJ/ixigxytK
	 fy9hbI/NU4ytrmWEjQ1A/67A7DjoLKlbkOSF4PEEl80NlPSNzZTQXTxOYgveWs9l2X
	 CUfUH9bdt6uAC95kFbh+JnDbhXLxKu1L8d/396INBowf2ars9E0naRcbbUYMVufOJw
	 hL24alLZT5Gia5TG4buVsBFtASjRE8JMvI9HcjtzXaDgRiytiWsdK+Jz1+CAtCR3Tx
	 WR+1Saj2gCuNJ+DK5qkv4wsYecy7+2GbNOfUBQTSrEofrCMpJcd/n9QxVGGwlOsHdH
	 XYE8txkH5G8CQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE8D4404DC;
	Mon, 24 Feb 2025 08:25:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8FF6CB88
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Feb 2025 08:25:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 73886404DC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Feb 2025 08:25:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yF3UbUYzZgUK for <intel-wired-lan@lists.osuosl.org>;
 Mon, 24 Feb 2025 08:25:48 +0000 (UTC)
X-Greylist: delayed 471 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 24 Feb 2025 08:25:47 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7F3DF404C3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7F3DF404C3
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7F3DF404C3
 for <intel-wired-lan@osuosl.org>; Mon, 24 Feb 2025 08:25:47 +0000 (UTC)
Received: from [192.168.0.2] (unknown [95.90.242.117])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 87DAD61E64788
 for <intel-wired-lan@osuosl.org>; Mon, 24 Feb 2025 09:17:52 +0100 (CET)
Message-ID: <d59d4954-bd5d-442c-84ea-7787b0d55e28@molgen.mpg.de>
Date: Mon, 24 Feb 2025 09:17:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: intel-wired-lan@osuosl.org
References: <mailman.992.1740357492.862591.intel-wired-lan@osuosl.org>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <mailman.992.1740357492.862591.intel-wired-lan@osuosl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: [Intel-wired-lan] Mailman message about excessive bounces
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

Dear intel-wired-lan operators,


I received the message below:

Am 24.02.25 um 01:38 schrieb intel-wired-lan-request@osuosl.org:
> Your membership in the mailing list Intel-wired-lan has been disabled
> due to excessive bounces The last bounce received from you was dated
> 24-Feb-2025.  You will not get any more messages from this list until
> you re-enable your membership.  You will receive 3 more reminders like
> this before your membership in the list is deleted.

[…]

Looking at my logs, there were neither bounces yesterday nor today. I 
re-enabled delivery nevertheless.

Did somebody else receive this?


Kind regards,

Paul
