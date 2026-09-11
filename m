Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C9CC88E53
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Sep 2026 16:56:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 616D06068C;
	Fri, 11 Sep 2026 16:56:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a9up8E6mQ-dG; Fri, 11 Sep 2026 16:56:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C229360635
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789145773;
	b=YmASlAhQtORG2w1VZPuVXzWWdjphexBaKNnXqqN5ifUyvDRXMOeRKFuceYqxXPkdLz8B
	 c22rvBJuZfKHqEDVW8DmaFwuwvK5uiuXVj8M9FZh06Vbvo1clb74uzyqsewaP4q16GvLX
	 tsiGK2PJROZ+4MvKwRUM2I0ELc1FUxawhpdhubT0Qw/DpXQHHELBZFIcJc0u+LA+Sh9Tg
	 7BMiI0RgZ+e06ZwytO4VVO+vyWEkpDC1YOmvHWmsxroG07faeBh/bxGq4bIfhPYcj6JGO
	 XqXSTw3JjlFWjgb7NeJQcFPELCTacUHcSkNrvg3NvtqhwdPGfk9QQRirPD5u9t8c0ng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789145773;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cAOXb7qhIq41yioL6pt4QjCvwD5SX2w0/KFd+4/OEKg=;
	b=UjMFK15nPV1TFs5vaEQJSTxLvyDpBZvuS8ZOgkL+KqoMS6VVoGGP8C02mq86woyYOfUQ
	 3eC8XBAUW+H/fHpLeD6ecc+zkXluYVNEDmghIiGoxlTOpzUMa22+UwwJlgtdt5kSq3Gd4
	 KjXYMJap6xQKcllkRQ7n78pAj2uEERJsP9RYPa2BVhDRklKr6c500n1b8OovZnuS6hY3H
	 FHf/SnF28OevlhY3Ljp1SzH2jeai/Nz1tCZ1I9E66xUtPjr5baE473eHbmiHr9T1aNomD
	 8a6JI0GlSuTKZwY6eDXeVwZ0Z3uHaqYipgmFxSDn/wmZBPFzenBLvSnS6y2le+WI6mw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789145773;
	bh=cAOXb7qhIq41yioL6pt4QjCvwD5SX2w0/KFd+4/OEKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EdwRvuW3tlZ6RUxLDBFErKdA7eLxKvPZnlFxwMMB+q9OzpUMZjtakpYzcrmfg643Y
	 qxTj93AP98Cvi0p5C2fXF93mHWucgDnOfX237anPi/DgN5d9PF3JZUSHyXyS6UkaLk
	 Gw4n6tG0ctf5e3SVljffvfra0s0ZnpDKCgjHDhEdoeAi9dMS8NyKW4xwyaakoawTcD
	 izYyH0CXErcW/bZ1gCa97Zqj5QBv5Rh30fMj6TbYKApNNqNm8hB0tsNHWANzkT7Kf0
	 fSwlFvVmKPhQwNQvzFZ/eOKasIxoSrKsI9+7/7G9CmdUOwGFK9zuEGVW4RPg7xaOu4
	 T1SreFhMjTH4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C229360635;
	Fri, 11 Sep 2026 16:56:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 15C55701
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 16:56:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 06FED40177
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 16:56:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LMzf4NK40ZF4 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Sep 2026 16:56:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6A1F94006B
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789145772;
 b=B2zx+IJtOA+B5/JBdBqeEZ0Tn8tU0UzoUhlUW+ndIg9toxp1n0Grv8ijAb5ywMe0Gmsw
 yVWZhNXG151UjowhuyBAb8ZC8JA+gmemQuIOYO2bMb4MJykO2PW69OvbL+dgkCaxlfzrx
 OfGGrDJJXKfemuO0j7lAvEBS4OPLLE6SFRAuqqewA494DaU8qg592gQj22xJUQ9TVP2zf
 JvB5OLvc0mALJSJ3PftyIVsyp9luJIxnQCrvqTAjT/s/iPxzop3MaPOmEaEFzM1Uc9aXl
 0rLAWTR9AmW+alEIFgM+S7WS3e3FoMDoEV7B0dyYn3u3L4jiULmiLJZAYJdjXViIq3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789145772;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=cAOXb7qhIq41yioL6pt4QjCvwD5SX2w0/KFd+4/OEKg=;
 b=qZl+H3oF1lU8cONxt2C/kh5NO5OzBPxql+NKCFksdAZhIHqAHX5t9BvsqpbUe5JjqMB1
 feldENjMyCWrWAcpTudEQhj8d8W42YWIbGK7dxKIj5NBVp1GfaTJ7DbaKoC+cE53EcX1r
 QslLxW33/HQ7EzV9hQeByHPi38NVWkPevhpF4v3z5ZJAhZW7N8Y0ed5sIsDz+jOoCB4xL
 BEhnGTyZOivGLiQZypes7idt0ROGCeBEZT9OhkzElDR9pQF45dXYm0I8GYpzw/KEx+uI2
 gNTU3fzHZ+ckcpvR08cdjHspHvay+n4lGfIwETHWhQYXhRlEzv4O/0L8/V6Xz8p4BnA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=SVDNkId4; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=SVDNkId4
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6A1F94006B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 16:56:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 62C3641B16;
 Fri, 11 Sep 2026 16:56:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CEB1F000FF;
 Fri, 11 Sep 2026 16:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789145771;
 bh=cAOXb7qhIq41yioL6pt4QjCvwD5SX2w0/KFd+4/OEKg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=SVDNkId4FFCNDp+vnY3hw+1ceZ6J9WiEIHdlPJjysAS+0VLXBW+XdrmPe5S78BuIL
 YXiI/yAYUSNvjAQKtXPBLLCepgiCd0wq/LT8fqUCP+Xr8qO+c/18mv1VsEfOdXPMvH
 PWxUPrphGCWdBcwXvhyQ3iDeabP8NFD3OOQKLCYQYCoYEFafJDDcpfEz7CrvksM1Bt
 5rO4WW30rVu9JRtsFBObpobUcw6Mn2sdPDel3G66XVNaNdEXsV4/c0EIlBMnRHAd+Y
 aH6lJqyTPcuqXAi21au6r4Blp5ZlYN5wzWs+sKIgEtCJd4P4XmNCjTY//kDuB5qIf9
 TaGYu1JMYDnPA==
Date: Fri, 11 Sep 2026 09:56:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Michal Schmidt
 <mschmidt@redhat.com>, intel-wired-lan@lists.osuosl.org,
 edumazet@google.com, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net
Subject: Re: [PATCH net v3 0/5] ice: fix stats array overflow via proper
 realloc
Message-ID: <20260911095610.73a17e0e@kernel.org>
In-Reply-To: <20260911095237.243ab37b@kernel.org>
References: <20260911113848.44086-1-przemyslaw.kitszel@intel.com>
 <20260911095237.243ab37b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 11 Sep 2026 09:52:37 -0700 Jakub Kicinski wrote:
> On Fri, 11 Sep 2026 13:26:15 +0200 Przemek Kitszel wrote:
> > Fix OOB access to the stats arrays.  
> 
> I'm going to assume you mean this for iwl-net, there are already 15
> patches from Tony in the queue for net.

FWIW at a glance LGTM code-wise, there are some kdoc warnings tho
