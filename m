Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E8C606A31C
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Nov 2026 01:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=dct8boNB;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SidTa3oo
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 49D7C81426;
	Thu, 12 Nov 2026 01:41:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1-3gL4It9TNS; Thu, 12 Nov 2026 01:41:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C2C1A81603
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794447703;
	b=td855htVGRbiJGM4P/1eJc6C7KVIWpHk2/o374p0SgyBCBsP+UiQKf3v4LOQs8ctvSIx
	 mNwZB2Z6n+Yr6ODCgwsy0UMSjSNngu2Yxnyu+HXtGpHoajjQXDfG5DaqY+vWw0D1NDkzP
	 hLhAMmWuASgmZ6AYKjOZnbXH3cGq5oZChZkQpZnL3OaXBkwQjIYlO9LLv2jZGKmvpq2Km
	 uHPmR6NdEQNrdCdgUuxAkW5LXTrMpALm2snmrfmTsoZtqJxRHTNXtC5LNM+ZI0ByZNB+J
	 szHBGKheBc2mw2TGL+prF5BXlVFp1HPExnbVk4XjWMJ9FBwk11zhKUndH5MNPJw9aAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794447703;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=M6mis5Crtg2nfuQYMPJqEji2MMxutnnmazBqS/anePlSXcEK+fZ58IyWDVt5JU+jYnXQ
	 wZQTiIoqPHYbYV4uqTWRZRN6Npku4QE8Ou+nwmSi0GwviSn4Yzi5/QHd4Wz8mF6+7KN8A
	 od6ERrCI0ArA0xBdCkDnQlZEHwVzT8ONvii0RgKIoTMZ+4sgzCkcbHuCdsa7pjjpynint
	 fXn5xY0DUkKa8XfzXrog1WzCbbxXL+5m+3+/Bbuvlmryc48N9zPp82TxoimLlf1k43zXQ
	 Ddt4FlGp7XdngkAHmGFmTywMfxqMZIONhMOwlBSxYGFqwOMgMcG34HXxIqI4wqwVGgA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794447703;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dct8boNBgTeqdPv2/cACQTKOinAAkSff3RCKrHlBVC/iV94jFFrm3/rwUlVTOt4mZ
	 YXyiCWyUfLpMUQJOGU4F4OwWkv1mpiMDSHcd7nMcjlAM9aJDIGR+JMOreU8gBuD7TJ
	 Xb7CejD5TkuKigJbNujmBf2kh5Teq3XrttYzYTQhQurFb73h9Mcoa1dDFq29/+OwKA
	 TWqWReNXHstg1rl9RvF3lff+RBOCIjUd8aop8m0p+o0ZmPkzj0oUXalIx5lUfNGIls
	 xNnm9u/bmDkwRSLjSnYnveJqMzkrHEx7EVzH97xyn2mm24m7H6lt5/YlDgPkop65Zm
	 Yo8yt+5WiB2dw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2C1A81603;
	Thu, 12 Nov 2026 01:41:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 96DEF2E5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 01:41:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 88880403A6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 01:41:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y2dRUQqgkkSo for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Nov 2026 01:41:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CCD5840217
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=netdev-bot+sinfo@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=SidTa3oo
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CCD5840217
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 01:41:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D526B61242;
 Thu, 12 Nov 2026 01:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE58E1F00A05;
 Thu, 12 Nov 2026 01:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794447699;
 bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SidTa3ooh+dDUnsw65X63uLxzNg/ez+yu4ozqE3le3/IDWgcdcqL0/n2ratb+n8nP
 vo+vko1f74c+izxVAtj0XWZTMqu2fxi3eKDLfmIlKX0No3e/tXWTGSqma4B5F2kUG+
 kdGAUgQIk221C1D072hw5Y/2LzUbXFU+lJm/m1b+RZhUOYHlQBIz/GS82ZLN6NZUUT
 HLj4983t7tgbwAQiej98FzUjBuGlCbUGl6DDkHdujavx2FCS8JSPJVM93FAyHe49H5
 3kvB80B4hWWpzPIKg2E/k3utsQEK7IHkcgRpsoBj0YniVxUR0XbEDeXhixR7bk/Xjl
 FrHWDfNh+lsmw==
From: netdev-bot+sinfo@kernel.org
To: Jiaming Fan <fan.jiaming@hotmail.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH iwl-net] e1000: report RX checksum offload as on when it
 is enabled
Date: Thu, 12 Nov 2026 01:41:38 +0000
Message-ID: <179444769837.2168702.18320155804189818970@kernel.org>
In-Reply-To: =?utf-8?q?=3COS3PR01MB10251F4C0DDF4A1AA90095494E7702=40OS3PR01M?=
 =?utf-8?q?B10251=2Ejpnprd01=2Eprod=2Eoutlook=2Ecom=3E?=
References: =?utf-8?q?=3COS3PR01MB10251F4C0DDF4A1AA90095494E7702=40OS3PR01MB?=
 =?utf-8?q?10251=2Ejpnprd01=2Eprod=2Eoutlook=2Ecom=3E?=
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
