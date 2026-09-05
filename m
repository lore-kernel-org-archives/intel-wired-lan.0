Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B47C624D3
	for <intel-wired-lan@archiver.kernel.org>; Sat,  5 Sep 2026 14:31:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C328810BE;
	Sat,  5 Sep 2026 14:31:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VCGJeIwtKnrC; Sat,  5 Sep 2026 14:31:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9392D810C0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788618694;
	b=rWjHQmRyRRvBtIiEHq93Z0PQU8mVyVOapUJgfTtRWElmICFuohFOqZPUjKY/RU5K3emE
	 oAqaWS2v/voGLVxCtZPHjUZnkKc21odBCA2TjspEQoFS/ZHTx2SitejRWs4rAL3zX/uno
	 p91Gg5dDMqt8evlDg3sTGxa+qQrNi+bS77HB42aABZ6R0aYjIlrzT1CwuqTg7t8eyBI47
	 kqXT2Z+FJHWu9nOp2u8OAnnGMHzuFooNBWvJYPMksEWNivsBbuwf88SJaofe0NOWP6G8d
	 soBdqDBAY9o7SeNgGdiWvs6AvVhjfW0kdvTZkoasTmd6kpuxvnszlIRfuJz0ZE/OM7Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788618694;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dRHE6qYK0eP1GXLINqod/DdD0uGr2ElpFVT/sLFwC2Q=;
	b=luHml8wL3JZf4q447uFkLAU/aABUNW9kJvIOXK9mTF+ewf4Nko/nu8mPoZObmF82EBcC
	 Kq6UPCJu2W7cbqVHtnv3bgFKXMn9S0WNi9YOYmJjeHIt8sFU03jl0PI1vJb14i5YHNIFz
	 e6JdCzoEz6heXXEO3qoeScvTlgzXn+b495CjUvMQhqHBHBXzqUtIplEk1cpc+B9tga7ws
	 RfpLFMU9ex9KRccRcYvDZg56sEJwvKaWq/lHOGOvaQ7vm01h+dPW0qi99x08ejo5b8O6j
	 dLnC1i4L3qpe57SqFDaW6Hba5L9nePlUyTxwP1n8E8k9Jv/EVFlVfCG7uJvlmPHoY8Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788618694;
	bh=dRHE6qYK0eP1GXLINqod/DdD0uGr2ElpFVT/sLFwC2Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EzVc02rJwMiR5i2PWwj4tvNlxugiViEuo1hfcSmOWA9PBDPFhr5tgksiUftnhj1Zw
	 tafWvyJelrYJsfGUXvHp++gEzdba+Oajdx5Gr6JbKOIMAShhhF8rtGo5FB5l25i5hj
	 NKnty2k7j1EMBov0Fub8WBOgTsXvIg7hbALoBGbfFDkIcR+2ZA8KQb64dE6/e7/VJP
	 GG7KPf1oe1P99A006x38Q3LXg+0WNaFZeVVxBlxg+XBSTNFKYcYpRTNV6Rt/DAwmOR
	 WsnQ8xhhcu0mJHZCefj82ErOW262ICZdGWq4gIb2/t7yRiWG4ynRjkqjsEplHc5uIu
	 bNqZMSnSXUSNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9392D810C0;
	Sat,  5 Sep 2026 14:31:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0DD7549D
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Sep 2026 14:31:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E817F40051
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Sep 2026 14:31:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gbkmIuaRDPF3 for <intel-wired-lan@lists.osuosl.org>;
 Sat,  5 Sep 2026 14:31:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A7FEE4004C
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788618691;
 b=dfolrvawcFJ3aZt3jylpHJ3s7qEKa3RdYlMsvBwBsIPX3ipTCaH6lL//oOFxCnf/rev9
 Bs9sYBMbqyeURGI0pnsxG5yMiSErtDpuCcSO9zVBa7BgBxxwSoTH+AAD4UPIXrlytKgL0
 YmzhXFMaqSsqCrcw3bbc+k/4v+vAw86B7earYh3iS4ARRdcaOoa/VBim+plNrymER1Xvh
 cjxyiLw16CI80b5jZEeDig9k/rkVAXkYIq4B7Vnpnz0UiYpU/hXPzF4k44NmUnZYRM7N+
 G9ni1eRFhZ6t7UwWqbK/GV+C1f2uvYLLI0ruHsODg3KWDdrihUoUXlLc+xP9GRvIxEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788618691;
 h=Received-SPF:Received:Message-ID:Date:MIME-Version:User-Agent:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=dRHE6qYK0eP1GXLINqod/DdD0uGr2ElpFVT/sLFwC2Q=;
 b=MZ8wS0ZPYGembjnAfhv/IpXIyENjfloVm7wgZawr0TMYx64XjWEkAHbXlpBzQoHe/RWJ
 4dNP4s4zaHzJGSTLgeUBASoKLXLyEvTJzsc0APRBxQLgUkM6OVYMGwkNCSyEy9BfyXvgS
 8f0b+KQGKAAmduFRyD5rQrzsBXYk5n5BY85UMVGUruQZQLERIWSbpVmfu65LV2y4CPdED
 xLUt7FYSQtcRgctWhF9rUwTom1bl7HVQeYKVDRD+Y0V/5pV1jXYJRJiHI83a6HMVp6PV5
 K56LFkKzH6nohrVL7uNjr98KBWlwSxeFwCo/eM8GVOK57G3ncy9vuhIGDMhqUYtwtJg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=molgen.mpg.de; 
 arc=none smtp.remote-ip=141.14.17.11
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A7FEE4004C
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Sep 2026 14:31:29 +0000 (UTC)
Received: from [192.168.0.51] (p54848e1f.dip0.t-ipconnect.de [84.132.142.31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id E5F694C2C37F34;
 Sat, 05 Sep 2026 16:31:22 +0200 (CEST)
Message-ID: <e476b66d-c027-4d31-8da0-5f1088055452@molgen.mpg.de>
Date: Sat, 5 Sep 2026 16:31:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i40e: fix integer overflow in i40e_dbg_command_write()
To: Rivaldi Hormat <rivaldihormat@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
References: <20260904062554.18628-1-rivaldihormat@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260904062554.18628-1-rivaldihormat@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Dear Rivaldi,


Thank you for your patch.

Could you please write a commit message for this addition of 1855 lines?

Am 04.09.26 um 08:25 schrieb rivaldihormat-debug:
> Signed-off-by: rivaldihormat-debug <rivaldihormat@gmail.com>

Please configure your full name:

     git config --global user.name "Rivaldi Hormat"

> ---
>   .../net/ethernet/intel/i40e/i40e_debugfs.c    | 1855 +++++++++++++++++
>   1 file changed, 1855 insertions(+)
>   create mode 100644 linux-6.6/drivers/net/ethernet/intel/i40e/i40e_debugfs.c

[…]


Kind regards,

Paul
