Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE70CA5FAA
	for <intel-wired-lan@archiver.kernel.org>; Mon, 28 Sep 2026 15:13:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98D7080F4E;
	Mon, 28 Sep 2026 15:13:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Aca8jubkfofx; Mon, 28 Sep 2026 15:13:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0A41380F55
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608424;
	b=Dx+b29ujbwJjWPRcBZBZ4ETuqrCLN3nd6p5a6jl8ni+TJZxY2HqBR1Z+/ArvcvZW44EV
	 uoAnSIZIm1YLWhtauaDJJ3F7rEzn6p2IrGuKBgGua4rSQN2aCNro5cA5ZaWvnTYTW8xNq
	 oiNArVsMbKtJBnq2unDIQtWdZvK9yjkc+RZGFOFXyOQOuu33Q68YvDl5csRir2OEpBIDI
	 4R1uEeiNtewwvWzhFnc2fw6U4byEpMk4xy1O71RnCAl5M4iSlE6W0qXL8xFiik9h6q0Qh
	 DzcDIAWNylmioWGUMRh3Ntzp2cUgiaS3FV7MZaJr/o5nJZLTiCLFASbWPow486kDZLg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608424;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=Hc5jgktwUVpvw4CumUwbF6Ayva4vvEs5ssEBV7HqpII6+lnsuTTmx/l06cHyLNPVp7Pf
	 hRMS+vwTuXxQuhkBYyjx51PiBFVAsTnTymA6ymclhX0cMnPNnyqXxmlmFhbpDPczGP2Ep
	 VeFNFSbO7/epxZQJZTCLTGlVroFL8Pxs1eZkY578lWh6/Sm0aO6KDwXP4PTgTin2i8xtH
	 I7UZhg2of9jSCUnTB5dRmpbBMIgJHiFOTGrlqNVsV/55cOTT6ke43ufs6eNGwLW6Vjn7n
	 dSkVgx+wGLDsJG3A0Wqvw9fzya+Jl7r5T2J+5kI0PuIZsGVIdzZJBlm8xe1aOzV9hMA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790608424;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hDqpeeGJqbRogECnBHq5KTWri/qrmWMvG8bCU/7RPh3DHP6XoQSkx0CWv/34CGfVf
	 OHZhv8H5MdzNXlOPbs634Rd1Omswln6cwHkBf2S+DqNzeUfwUhaWZFJQMxQhQQwHm1
	 8xiDNcYJiRKVl7gryJLERm2skbfKkLDZNml+lbsCBSaUiasYd9IUMudkty/p2fdGi6
	 m+A9gbXaGQjqu8PjFn/M69P4IbPaDI6YWKa0lhU210hPHbNwvzuWyawjm8H07w7yFB
	 cmvJIVFmv/bC0tmJLyt0BkfI2HuFxdIeUuKOuVsbNLRBruJOLjSS/ksC/Wgc6Z8OAk
	 hERmXFQMVrXsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A41380F55;
	Mon, 28 Sep 2026 15:13:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BA5E13A0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 13:45:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ABE0D606B1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 13:45:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MAMECE4l6AiA for <intel-wired-lan@lists.osuosl.org>;
 Mon, 28 Sep 2026 13:45:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 099B7606AE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790603149;
 b=nd/y/DA8HxQ+SVBkrLyFW5XngVmM6dfSULx4KjDAuO5P8a4nV2pnDuWo7TPHJ+Ph6tlp
 7xkrvUe2DESAdl1sEZV5unrFSELGddkRsPasJyFy5+cSsIpwscXK9r8hXeidXNmiUlVlt
 YmZ6EVGLaVEqaxDEOABovyOgM3a9KJf7+pYz3GU2XEezWj2P9zc3G1WzgfeCkI+wBxy+5
 OinRCtmuewe1qO6oBFwXU8QxiH74ynhEWnb4OfpzoVkYgbOzItvqBQOUjuNp9BTn1xfEo
 D9lCvmTxCBOrgtuVdpplJv9IdQyOrTqU4616+DzStwb8i7ERq+wVSMeaw4lcu7pY9Xg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790603149;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:Auto-Submitted:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
 b=FxS6YWoGQVPN2m9/b+UK5rsI29YHYgMIVIoss3T9eSzSt7pwYdNJ2NTtp0Ydd3wHcSB0
 LWRr0C4XmlMgHkfHQO7aGUuOLnN0TDJYJiah3WfVpSz3nSQwCtqNbgEnLKfHgTq8OJNf9
 q4V+YGOJ6FAb6CIP7hpb6kVwibiHnMaEl7PBVtP1czsU7VjTzaw54UePn/UcUdfrupFDL
 eZUEZ568B58olyMOQVtX4HUJeHUUVuogEBpxVI1i8VGAnAPUU3eJuFmJ5owB1xW+FbVS2
 BHAd0l/sZIALlrwSFgY0FJM/65mCVsFNRf7V2ekq4Kefxw4Xx0o8MvPW0lxaP7xn0kA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=cKQN+XVw; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=netdev-bot+sinfo@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=cKQN+XVw
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 099B7606AE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 13:45:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E898760052;
 Mon, 28 Sep 2026 13:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DFC1F000FF;
 Mon, 28 Sep 2026 13:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790603146;
 bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cKQN+XVwQ7UCa7EZC6kUj6mdDWB+hQhAfBNO5Nfmfmdh66dQKbPvE/znUP6VtZlex
 hl/+Wkaujhw24epzUCk+BSn/zlzUKIMKHYhGJIU12qlez++CPFcyfKnkvnCrNd6Lw8
 RqxcxNmsywmwUrRJDpTO5iTLSIoAMKJPLFlMsk63oAx1Vy5wMwp2t6FKchS9rS3rhK
 hpL9DkakzAEW05a3y5nBgPlcsPY8utsfG+T6qafh53jaDVOY5T43y3j1A4+yVcIJEt
 SVTojjjLeyEx4pmm6uP+DTYSc+835nRYuCH4VK/hOVbxNwb+Le6EnxJDD084uuDJo1
 6rPm820UriOKQ==
From: netdev-bot+sinfo@kernel.org
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: [PATCH net] net: e100: cancel timeout work during removal
Date: Mon, 28 Sep 2026 13:45:45 +0000
Message-ID: <179060314551.31693.4640700550731578626@kernel.org>
In-Reply-To: <20260928134121.826-1-getshell@seu.edu.cn>
References: <20260928134121.826-1-getshell@seu.edu.cn>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 28 Sep 2026 15:13:41 +0000
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

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
