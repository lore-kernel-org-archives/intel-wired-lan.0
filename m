Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9C2C44527
	for <intel-wired-lan@archiver.kernel.org>; Mon, 20 Jul 2026 10:20:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 53C4380C10;
	Mon, 20 Jul 2026 10:20:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZQQmXSub5Ai6; Mon, 20 Jul 2026 10:20:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BAE7680C3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784542848;
	bh=flOputq0F1qDtEH4RgZe2aKJKIjg+JYbpkOo9KKbYTU=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LCoXR+sxUnRdK2OVBamLEUCOMBSWnRm+TV5yC0d8s3u7aJr7Hjz3nTQOWTBoICPC8
	 J9zo4Zw9r28SKTw1/KX+Jb/uu6vS5thNhA4d6p+Q7MvLfVhalMyYaiBGzT93fA66aC
	 Pg3JZc+vHNHFMLekPMktXdYE8VJ/kLTVN1Kwy5ODhEpVs3ljZEY0Dg7MFtVJitVm4I
	 yfbwgWMrTWqE+8fXrJeZAnl8rW9esKI+minhmPA2Yfv/m99G2cprDtJotkpuHvrb67
	 YaPRDQ/KTiBOEjMG4VDCEkJHAtf1Tu5D9GLC/FgYJJzMEpgYHAgf05lSP8u2A4Ja+N
	 azH1CAwThw6XA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BAE7680C3B;
	Mon, 20 Jul 2026 10:20:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CFFEE1F6
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 10:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C1B67405A6
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 10:20:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kBEBut3aIuT9 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 20 Jul 2026 10:20:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 233D340595
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 233D340595
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 233D340595
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 10:20:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 85A5C42A0E;
 Mon, 20 Jul 2026 10:20:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705FC1F000E9;
 Mon, 20 Jul 2026 10:20:44 +0000 (UTC)
Date: Mon, 20 Jul 2026 11:20:42 +0100
From: Simon Horman <horms@kernel.org>
To: Takashi Kozu <takkozu@amazon.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 kohei.enju@gmail.com
Message-ID: <20260720102042.GE19108@horms.kernel.org>
References: <20260711133239.29270-2-takkozu@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711133239.29270-2-takkozu@amazon.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784542846;
 bh=flOputq0F1qDtEH4RgZe2aKJKIjg+JYbpkOo9KKbYTU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Mjh+DFYbdkU0Qkrb3ZH/TZZARuS5ejj2Bk02pjrHoRe9WBRXqtIc6gOopPc8WU3Ct
 KMKzrh3JxJhaO4rb3r4UGi99i8o6tRsE8PlcP5Kcrg6UJ1qqAAoV8eTXUG+d2F3YJo
 6A1OZHIzfIgXK2CS4YT8OJ5Bs171ifWkMMF8pMmQD2eeouwBee6N37aev83WOUaUxm
 AU9Nfy+ELaMpNwscTgtP2RRuvYIWYXhmfHLITDd6QtMf+lgCtQP+oFNXl8s73N5MrU
 PbkhogmG59HNp0QggiLn5U8+/K0oOHRvqDuSmlD05WKG7gTI//GiXYqsd4nFcx1yL5
 pAbTl7TScS9rQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Mjh+DFYb
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] igb: remove ASSERT_RTNL()
 from igb_write_rss_key()
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

On Sat, Jul 11, 2026 at 10:32:15PM +0900, Takashi Kozu wrote:
> igb_runtime_resume() calls __igb_resume() with rpm=true, which
> skips rtnl_lock() to avoid deadlocks. On that path __igb_open()
> -> igb_configure() -> igb_setup_mrqc() -> igb_write_rss_key()
> runs without rtnl held, so ASSERT_RTNL() fires a false-positive
> WARN on every runtime resume. Drop it.

Hi Takashi,

I think this patch description needs to explain why
it is safe to run igb_write_rss_key() without holding RTNL.

> 
> Fixes: dfaf57ef99cf ("igb: prepare for RSS key get/set support")
> Signed-off-by: Takashi Kozu <takkozu@amazon.com>

...
