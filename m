Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66016CA5FE6
	for <intel-wired-lan@archiver.kernel.org>; Sun,  4 Oct 2026 18:13:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A5EE8098A;
	Sun,  4 Oct 2026 18:13:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XXV6NOulp5k9; Sun,  4 Oct 2026 18:13:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9FC6A80966
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791137597;
	b=kqAFMU6ybKsLc3bLTU9khU/vudRPGGiIvYyCrskkS9c3tIBujnqg+jzSp4iFCY5IWDBL
	 rnimNEylUPEd/AUZJieIWedegBWVIHKHsmryHU013NezIuAspV66KxEDgcQEiupZLnMhA
	 J5+R8go/ZH0YU/TQmLY935l5YWMvp9xn6JLJO0Sc05RhbLAcul56UxeiK+gDvZss1Dpl0
	 2z6py4Bjui+04l5f+wtBHVHLmrnl2260Z2U3y0Gc/Ke3UZocaCVxqXZDOJJOQtdKN9M3Q
	 NqLEBPC1gmkhF+xwAobWfgoY864AO9Nc9AUy4YVSH+zW3ALqS3G2AQv5dv7w66XfMkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791137597;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=OxQGcUOv9w1YvEHVz4zdzGmUfQBD/zmk+a4Q3newBHL5G0xVXadKEM+K8sosOm/On7CL
	 vls48mtarKijNYruFrjk2IE1Z29jrDt9fOqLMG/Hu77eRRVxhQE1vtcToXZzhBTlie3NC
	 TLtbXLLcdbB8h8Nh2kiFgYQeMLmJ0doyUDAALqKoLSoAufnDC9v1okTiNNk8w6rWTWuHb
	 o7AquhDSnMmuV0PfcdZ5HM+PU9GNYuaVC48TeD4L69X6vTQiC7KEWzAi+QzaBmTyVHFF3
	 ovO4m9MPDSTlwLl0ltYlv3S+wfNcN+dAFSabNBE/V4EOSKwfkkJe04fBY+TS2gojbzQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791137597;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HR34pQFDGUixCM2A8q7/JTs4qkapn1XzQHyA1jc7IpCWUjqo7AlAUwrWpH/cKH7hq
	 x/0WgwZKXZgiP/YGNhFkHS4vF9wmN331zTobTVw1hLJURmLQ21yuFg8GAcYQf6izTV
	 /qTPk5QXjjLapmP0SadIMPoAeRFcC2UcpzP/W7XujFrgVoQxgZynpg/PMkl82oWSA6
	 ls6xp7Zj0HeRLYhySs2UXuYxqnhHBf/Y+bCYPEKMFf7HKn9iSfJa6zSTEg9BqItVFy
	 6oXPQoV8+MY3RbKfVX+OgJFihgNSi52iCJaR9KpyO7LNSMJVmF2tMyv+rcdTpILfPa
	 gCxHUsubVhRKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9FC6A80966;
	Sun,  4 Oct 2026 18:13:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 00B4332F
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 18:13:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E60A140401
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 18:13:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8KRB7G86q0nD for <intel-wired-lan@lists.osuosl.org>;
 Sun,  4 Oct 2026 18:13:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 541C6403FF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791137596;
 b=RMwMPKByiGPY7pRvrRhMlWGDf69QQjaxkPwmRmXsWFVyWtrtn13scOpRyoBx7q9iVfQJ
 rP1lL++maTf5fKwLEd/UUJqw3EsTi/UhqET9Y3sdo0hhpdcpSPBVngrIBvMLhhkFMyTzJ
 WneY0f57OUfABkvz+iin409cqtiLw4mgsoYMarYSUOvDicWeH04ls0dxgQ0fbAktthhvG
 uji8sMJx3A1c1+h0+bwCpS+tE1BzyeiRoBPBygLkkmz4YyHyhEqnglaLDS+W2p2G3vPrT
 N5/rqTxURVT5YMLIRTUFKE/Ywgjx/pxp9pJLGBWfOnq+hGfeYKfYAAs4cm9LZXjTTFg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791137596;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:Auto-Submitted:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
 b=HOF1n+eVZxH+hbYkTW4xBJ29mJgERjYqSkDm4p48HQlRA4QR/MDNOkLmFVMXRMc3Cggb
 JM59b7aKoLqxMd0G9jlhbWlvqaBt4WFTu+EizBWnbO6igcKLSM/7O3jJD/+ETm2w3tbWd
 XCx/lQIWv0Lz2A59vJ67t1eCneEP/LirYRLwtoejlJyiRn0otvSemybuEcg/4sO8oL4LJ
 ZJg2TC+5dSryQ0+ZGExYTSnVoHOp1vAKdLs7aCTDt1vVwVvdH1uRZK+pAM6XZXTW9xe+N
 ik1SrpR/QKQ6yymD1sqkgQmziSSQCy7lA83ebWwgIYeOULEGTZdzWmD8ZpNqSqGnTEQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=cpJmr8CT; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=netdev-bot+sinfo@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=cpJmr8CT
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 541C6403FF
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 18:13:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7A69542AED;
 Sun,  4 Oct 2026 18:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7892B1F000FF;
 Sun,  4 Oct 2026 18:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791137593;
 bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cpJmr8CTE0PdWh06MbDRHqKw5+t5tZbi5D+A/Q1wY/Zg6sjFoYDF63fAHdyyWTs9Z
 ApJchU1wtNxHVbp0dS7RQ2Kda3P6ebvRNOlxcNyaWxf3/O+am9cBkr5vYuH+oVIwgB
 AWmqmXd57h4fVWU+Cod7YD8MhVZ1FmFXrNGwH75T1FP4C8zH+lYyTaCr7JNYRwtoyR
 DFZCOcVZPW+VuEW3el+R4zuGh32kkNjFTryKC3S0qJUtP6fCBI7bCiWl5m993LPnd2
 jj3+D/Qt7GbdskNDPbd8Gb4ZQkfu5c5GgjmdY8guMJyvjrTT74dmxP/6AfBV0d/6Gf
 D8bf+YKPFEivA==
From: netdev-bot+sinfo@kernel.org
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Simon Horman <horms@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Joshua Hay <joshua.a.hay@intel.com>, Alan Brady <alan.brady@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Phani Burra <phani.r.burra@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] idpf: Fix vport IRQ name leak on request failure
Date: Sun, 04 Oct 2026 18:13:12 +0000
Message-ID: <179113759201.1402591.11539090671130836335@kernel.org>
In-Reply-To: <20261004180954.163789-1-oss.patchbox@gmail.com>
References: <20261004180954.163789-1-oss.patchbox@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
