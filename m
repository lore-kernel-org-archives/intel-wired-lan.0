Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71566EA4FCF
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Feb 2026 15:02:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2AC6840C78;
	Mon, 23 Feb 2026 15:02:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yYxsHj510t7Z; Mon, 23 Feb 2026 15:02:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6939E40BA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771858935;
	bh=uNGo1sx9Ki+w096sWaEIkC6IKo4fwwadEMyWfut8oEA=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ui+2aivRufGVUsYVdGkkQKY2yUO6pj+eS0TejNpXbNdRms58XwxRhjwYyKzYm3FuC
	 nJhZw84maf2oSfEZZx0ydskMT4l36s/BWpruunRLPsjm2McBML4jXmzbAIL6yDfba7
	 FNwmu2p/gP65YgY9cQw0nfb2j08l5Ww+D2vHOnzsoqF+o4NgrwFq9TwNvaxYS5ityf
	 23KS+KrMtFJNPG64nHb755nq3jt8+mfP2UVqFgf1v5vfqJ7MPLIw2fpZbvg5qYr2lC
	 Ny7f5t03/8b3SLE1D3ic/xmjN2lSoFugfRnmrbgtXrdOyK8hmnKr1ZHLjptGjWhKX9
	 6XK2JZR0JALBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6939E40BA9;
	Mon, 23 Feb 2026 15:02:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 54932249
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Feb 2026 15:02:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 45DFD40BA9
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Feb 2026 15:02:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kksku8CGxfi1 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Feb 2026 15:02:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c01:e000:3a1::42; helo=ms.lwn.net;
 envelope-from=corbet@lwn.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9087D40B92
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9087D40B92
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9087D40B92
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Feb 2026 15:02:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 36B9640C6F
Received: from localhost (c-71-229-227-126.hsd1.co.comcast.net
 [71.229.227.126])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1)
 server-digest SHA256) (No client certificate requested)
 by ms.lwn.net (Postfix) with ESMTPSA id 36B9640C6F;
 Mon, 23 Feb 2026 15:02:12 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Jani Nikula <jani.nikula@linux.intel.com>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Kees
 Cook <kees@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Randy Dunlap
 <rdunlap@infradead.org>, Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <33d214091909b9a060637f56f81fb8f525cf433b@intel.com>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
 <33d214091909b9a060637f56f81fb8f525cf433b@intel.com>
Date: Mon, 23 Feb 2026 08:02:11 -0700
Message-ID: <878qcj8pvw.fsf@trenco.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lwn.net; s=20201203; 
 t=1771858932; bh=uNGo1sx9Ki+w096sWaEIkC6IKo4fwwadEMyWfut8oEA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=pmyRjEdODIjeAipqFcXYuUUMrCqulImfJMdvpChSX4o/WEBWx/D9iIlWRpC28MpMR
 qVDCmq+hq0AkV08Ab8WKXCSn3jVSTe44fDZpyszr6qmMY8FVvxyKZSG4VIFau2YsLd
 6HmQreBiYMLctEplPjUNpkQHDtzx90LkD1LwYV6ym6ZGVr2QfWgD8ASD79pfZpssJm
 6jsdZ7c9cQC8TcmBk0h3GmT35iZy0vd2tpZL0AmNvmaqMWI1Q7BnfoIBzCZR5JfsDI
 1+Hnuvb8/6/Nn5MLCnkYX2noN97MOig+H33SStCdhDKoh1Zib9BjIAcfdAoKMAPONc
 fVwEGo2bWGoog==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=lwn.net
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256
 header.s=20201203 header.b=pmyRjEdO
Subject: Re: [Intel-wired-lan] [PATCH 00/38] docs: several improvements to
 kernel-doc
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

Jani Nikula <jani.nikula@linux.intel.com> writes:

> There's always the question, if you're putting a lot of effort into
> making kernel-doc closer to an actual C parser, why not put all that
> effort into using and adapting to, you know, an actual C parser?

Not speaking to the current effort but ... in the past, when I have
contemplated this (using, say, tree-sitter), the real problem is that
those parsers simply strip out the comments.  Kerneldoc without comments
... doesn't work very well.  If there were a parser without those
problems, and which could be made to do the right thing with all of our
weird macro usage, it would certainly be worth considering.

jon
