Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8AD606A31D
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Oct 2026 23:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=jwpTkvPa;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TYda7JoK
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2435160710;
	Wed, 28 Oct 2026 23:40:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SzB5dQAipgBU; Wed, 28 Oct 2026 23:40:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5D547606E1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793230812;
	b=IXWFVfDb9wkYFgDgeMRNlMMZjX6PvM1WwQ2vW8EgAQn8KVwdXuYGaoYw9TVwbUrnsCC+
	 FjVMjXPW4LIaqGvyqbM3BrWe4+oCG7BG2kyzbg2kpRwYazRszlDYE5Sef+2n+YGhyWLa/
	 wI/esbBdLolLSlm4FclgIw2bhKtAf9Vs+jk/6TQnCtNej9DcoInfVfhpr6UegealVNUha
	 n7Q6vW51TzwAZL+AlFM/4VltqqX0IpiSEVZfWYvYvGSzCqUgpxGcUY7d6LqPh56sjBBB1
	 jwuXA0hpPadjSaIIDC6oehcG0kuFkiMuqn8jlag3efHnWHTNBoeRS/ly3hncYh0I44g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793230812;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=eSBje7ne27VllfT95Jt8SmIZ4PCn+iHIMvYclQHKX28=;
	b=jZjR2rVV9HD+s1h4g5yYQX1OddKUz3NdxhjebrVo3M1j564xqvFFuosEjX3nxM7A/yn0
	 gZH7TsFYd1RZxbB+fHQFExUt1TaJkzHKXScPJpMwWBVxyydjrcY5wQ6YMvjZi50s1Sis4
	 RK+C40g9mswwjh6iD+DhraEZJJY8keUe7HG44Ovqrd3DvWQGPNBJAyDn4Dk16GiAsGkhL
	 /4bGv59Tv1dSFflTTtqyql2GnAVTBs4bOEq9pms1Cej2pdH7liGtHKJYJmh1103j1mjZV
	 STI2vtEHkHoPlt+VLD4ybkHbB3MPSkuYPiyjv//FFrFTJEnw7mJEHAx1d2piHHH4/Dw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TYda7JoK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793230812;
	bh=eSBje7ne27VllfT95Jt8SmIZ4PCn+iHIMvYclQHKX28=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jwpTkvPa3cdZ1wJxYJ42f9QeGHjAFx2tuXxqhT7on+wlkwqslqzpgClI31gAJw/EQ
	 jd7WXxuV1vFKkPeEnhwj8GzAfMrISiFwk5fp6lVAnUcKPeE4g+USL4So79Ea/Ijm4u
	 +K2lPCWv/k2ijRNi1bQMZ8VowTXy5FZXvhQbwZAxnsT/jyx869IDMMdz6U7RVkhW+Z
	 kypJg9WeyirlaqodqRcvt9r9ajv/adgwiH6pHu5jM9oH4HluX/s25SH+EWjmoOCwon
	 wlU8KoU2HjtnTcxC+vt61XmFLJA0sGGOnJbqYC6W4yUMm6lfI4XedAYVFbk6xtLBGQ
	 dvX2hP352alIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D547606E1;
	Wed, 28 Oct 2026 23:40:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 69E242A8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 23:40:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 537BF606E1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 23:40:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d9nDbVCVmRe5 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Oct 2026 23:40:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 52D36606CA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793230809;
 b=XDbbUff4eQKIyYxKWKnLYKq+hjazgCIlr57oNr1PUxF4yW3sCwrmhBrQ+Z2ZD6E71TrS
 yihNXZK0FbL501Oc29FueKeaSQSMtNSgNC0kU4NX//XhB+5WhNxYZU7+ZFdSoUBIXUAUm
 9Fw+AJ8gsWmJJROOcyxzwhRHDDkBM4z2PurcGH5+WMN0oTGCKLSsjmMNI6jAeSfl4tXvQ
 8VzcAa7dvJtIB1pPnKAYosWrjgd58KkzD+gdyAyWVJ04B2+q1SYLRiQPkgXD+uG782Vv+
 q4RA0lIS7UibVcqcbxFSg/HFbuK+zVbV7yUr7z8YHNLJPxZuHNMgicyDbn1YqRpt/AQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793230809;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:Content-Type:
 MIME-Version:Content-Transfer-Encoding:Subject:From:Message-Id:Date:
 References:In-Reply-To:To:Cc;
 bh=eSBje7ne27VllfT95Jt8SmIZ4PCn+iHIMvYclQHKX28=;
 b=m4SdFwiLbbYRdI+FuHvCAwFhlr3Z+qIT3uUXDVh6gIhwTl9K/X0pzQ2yub54Dq4SOWFD
 z3jomXl8CfLFg4wm8bjYQmlMOQ/oL8bhKgFsCPEaS7OmBTpXmMjidqxgksHl6UL4airzP
 S8OmFVrTvHKJXLLTaeSQPR0s7PvhG5ZWWPHvYeLN+d//vBsLhafPUzrj7TQ8ybUdFnZtX
 lgoJjGxYYttEbowlTtYsn/jPkSVw0eGRHJkPpVikE5q//2dO9EfzGzxtE+X8bNdf+bL5z
 OgbLgKlw8p+UVs0QXlYduAAswvoQO5fbDDMiAeMGp3FhvAu3Uzn1BeOsK/gUrLFmREw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=TYda7JoK; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=TYda7JoK
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 52D36606CA
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 23:40:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E69254074B;
 Wed, 28 Oct 2026 23:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B921F01828;
 Wed, 28 Oct 2026 23:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793230807;
 bh=eSBje7ne27VllfT95Jt8SmIZ4PCn+iHIMvYclQHKX28=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=TYda7JoKvtil9ssL1fslNDIQ5ntctsBf/lt8a7R+CnlDMBd1CMWXShIZSI+liyXw8
 EUu9IR2T7NJzBG/ScEcdkjFXLsA2HZ22qx0WCf6cWIAufbCv1Ttv/w8V9Glb0ZrDuc
 M3JqT5dwuuA+d+4c7pN2KSGIbLowNxBRJESVu055SBqAjQftrNkrVqCA22/wngNeDH
 qzL3obrRVIZavsGHeZ940y7n+M5E6K++1YYD0QEs5UwqGq9XiQGfXdFjhxagU9d/UT
 EyXFfTh++3Z1TEYWwqLCdbJopHqQrX+Jii/YIFz1PCzE0z6teKT7tq20jATNveps6j
 79VcOV1xULSXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 BE6953AAFC4C; Wed, 28 Oct 2026 23:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dcb: initialize PFC value before calling
 getpfccfg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <179323080631.1480461.17695620852598790529.git-patchwork-notify@kernel.org>
Date: Wed, 28 Oct 2026 23:40:06 +0000
References: <179289284460.50470.572724041164324949@gmail.com>
In-Reply-To: <179289284460.50470.572724041164324949@gmail.com>
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 24 Oct 2026 22:47:24 -0300 you wrote:
> dcbnl_getpfccfg() and dcbnl_cee_fill() pass the address of an
> uninitialized stack u8 to the driver's getpfccfg() op and then put it
> into the netlink reply unconditionally.  The op returns void, so the
> core cannot tell whether the driver wrote the value.
> 
> i40e_dcbnl_get_pfc_cfg() and ice_dcbnl_get_pfc_cfg() return without
> writing *setting unless the DCBX agent is host managed and in CEE mode.
> Both drivers normally run with firmware managed DCBX
> (DCB_CAP_DCBX_LLD_MANAGED), and i40e with FW LLDP disabled runs host
> managed in IEEE mode, so on a DCB capable i40e/ice port the PFC values
> in DCB_CMD_PFC_GCFG and DCB_CMD_CEE_GET replies, and in the CEE part of
> RTNLGRP_DCB notifications, come from uninitialized stack.  The same u8
> is reused for all eight priorities, so this is one byte per reply.
> 
> [...]

Here is the summary with links:
  - [net] net: dcb: initialize PFC value before calling getpfccfg
    https://git.kernel.org/netdev/net/c/ca87a2dffbb5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


