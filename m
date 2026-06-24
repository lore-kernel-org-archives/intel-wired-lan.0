Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CB2CDB479
	for <intel-wired-lan@archiver.kernel.org>; Wed, 24 Jun 2026 15:30:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC236608EF;
	Wed, 24 Jun 2026 15:30:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dt2-0eBqth6Z; Wed, 24 Jun 2026 15:30:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D9328608FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1782315023;
	bh=RUcbvgmQZC5oKq764H4ENHHBEsmXURttubgifoaZF5I=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cdaykB6s0tPzFzN9hKxhVd1d550hgnOIQGMyZNzu3Ugx/feLFbcbOffMoV0vESreA
	 HZm5unq7XigWmLLA0Lm+Qck5uCsQe6WGGJY/AvXMA+097nXy1GuqDwV5FK0LQCY1zI
	 Q1hfXMIjhw7JIXH7qZdLY+2D1/duYRC3cveOawJ1NAPUG3zEp0tpuwE0I2T9MiUg30
	 A7ZvDqwLFC+uqX9+Kpt2Vt7kdrHM4VYhNvjvRmEPHwG1b6v64vjehJGc25wICqDZ0t
	 brOxXuxUxGYXauaYDOjN/TMoDpsu1YbQghrJPCE7sErvuZIs/M7wsGVvHlgKzxXVaP
	 bsSKgEnvtE39g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9328608FB;
	Wed, 24 Jun 2026 15:30:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E378256
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 Jun 2026 15:30:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1FA4940A00
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 Jun 2026 15:30:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wYEy_5YvGdwm for <intel-wired-lan@lists.osuosl.org>;
 Wed, 24 Jun 2026 15:30:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2C48B40A1E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2C48B40A1E
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2C48B40A1E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 Jun 2026 15:30:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6FEA0402F4;
 Wed, 24 Jun 2026 15:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245E41F000E9;
 Wed, 24 Jun 2026 15:30:21 +0000 (UTC)
Date: Wed, 24 Jun 2026 08:30:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Adrian Pielech <adrian.pielech@intel.com>, Przemyslaw Kitszel
 <przemyslaw.kitszel@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 intel-wired-lan@lists.osuosl.org
Message-ID: <20260624083020.131a75fe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1782315021;
 bh=RUcbvgmQZC5oKq764H4ENHHBEsmXURttubgifoaZF5I=;
 h=Date:From:To:Cc:Subject;
 b=NLbwuSVN9DmYytjs9Dlkf4Qe+kkPcBLajxXTBsLbn5Qx31QtNxtCPYLDyPWJBeHFJ
 JFb2RfEOQyUQ12log4GHmmRVXEG+qQo+ZkK9K9hvtUcRqrHoGG85jd/Tmr743v8gOn
 2tIH6+riCZzChAXEHmmn2TPbF7u21DTzjD7w7W06dDdaWrsyuiK+/DJYxvNXlPOfxJ
 WWZHREoD9CuZ4TFc/1a/4oFRDBRixgNvObU8g9nQO0CYZCkj1njSwuw3gpdcDXUnnk
 +pX1BtDCtEaZDc8SgUW98qG0olHWj5JyOD3ULg+E6MKt38gMPwBll7zGDhlAJH8y2W
 I9hvA69j1nQlg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=NLbwuSVN
Subject: [Intel-wired-lan] [TEST] Weird RSS state on ice
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

Hi!

I noticed in the netdev CI that the ice runner fails to run the
toeplitz tests because of the RSS config.

https://netdev-ci-results.intel.com/ice-results/net-next-hw-2026-06-23--00-00/ice-E810-CQ2/toeplitz.py/stdout

I added some extra debug on the branch:

net.lib.ynl.pyynl.lib.ynl.NlError: Netlink error: hash field config is not symmetric 16 304: Invalid argument {'bad-attr': '.input-xfrm'}

16, 304 means GTP flow, GTP_TEID field. So we are trying to disable
symmetric RSS, but the field configuration contains TEID. The problem
is this is an illegal configuration in the first place. We are
_disabling_ symmetric RSS, but the kernel tries to make sure that both
before and after states are correct (because the configuration involves
multiple calls to the drivers and may fail half-way-thru). If the
current config is illegal net/ethtool/ won't even let us restore it to
sane state.

So the question is how we got into this state. It does not happen
on netdev machines. And on Intel machines it happens randomly around
30% of the time.

I tried to look thru the driver code and I don't see how we could end
up with such a config.

Could y'all have a look and figure out / fix this? This has been
happening for a while back but I was waiting until the merge window 
to poke at it first.
