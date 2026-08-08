Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A45C55174
	for <intel-wired-lan@archiver.kernel.org>; Sat,  8 Aug 2026 16:14:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D67980E9C;
	Sat,  8 Aug 2026 16:14:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y_FWJR0QOg8M; Sat,  8 Aug 2026 16:14:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0FAB280E30
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786205645;
	bh=TjlojJqpqwFBXJccLpfHW5A7HL5tc1lsm4KFxaoLpJE=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C3Cd1Narfz4fe7vujBLTDZVxMnVGVTRanVJ9eTOi7Z+THBrwkbc7I/BImh8hfb+Dv
	 CGiOmV+eplQnA0+etTmUjo/1kCyQRk6zWF2DN5+xzDh4A3fRsVvkU9SYLFiqqozNPX
	 nFN9EUv1cNUu/7ZcC5WDC12Xv2LnMgrnk6M4SVJZbwrIddggwDpxzsRQXvgUTxpYS6
	 DQ2Za1VHSnEcGoMDPBAeMEggwzzM0DTlr7RspmTGpEqAEPrTItjo9vQR7QcEVFwO2U
	 YijM5xxab/wYuj6cpkJOa/bUxWrBa9v7F9GG65EiLU6cqLHT3QcXoBZF7fot7Eq20G
	 Cp/y3vHKBz5hA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FAB280E30;
	Sat,  8 Aug 2026 16:14:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 80FB0282
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Aug 2026 16:14:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 72CD76068D
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Aug 2026 16:14:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gmk9L3zrApeu for <intel-wired-lan@lists.osuosl.org>;
 Sat,  8 Aug 2026 16:14:03 +0000 (UTC)
X-Greylist: delayed 3663 seconds by postgrey-1.37 at util1.osuosl.org;
 Sat, 08 Aug 2026 16:14:03 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4457260667
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4457260667
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=49.212.198.91;
 helo=www2881.sakura.ne.jp; envelope-from=kohei@enjuk.jp; receiver=<UNKNOWN> 
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4457260667
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Aug 2026 16:14:02 +0000 (UTC)
Received: from x1 (M106072126074.v4.enabler.ne.jp [106.72.126.74])
 (authenticated bits=0)
 by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 678FCVZu064188
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 9 Aug 2026 00:12:33 +0900 (JST) (envelope-from kohei@enjuk.jp)
Date: Sun, 9 Aug 2026 00:12:31 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: pavankumaryalagada@gmail.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org,
 syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
Message-ID: <andBqsDhcLG9vDmn@x1>
References: <20260807145626.52692-1-pavankumaryalagada@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260807145626.52692-1-pavankumaryalagada@gmail.com>
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 bh=TjlojJqpqwFBXJccLpfHW5A7HL5tc1lsm4KFxaoLpJE=; 
 c=relaxed/relaxed; d=enjuk.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20251215; t=1786201953; v=1;
 b=AIPdSLIMrRGjJTKSYcEQr2lhWm6XhlxNCVHz80VszqlWMfoESsQf2PHqKSIDQMwy
 fcXsw2g3YL6JEsTHcpPQ7Z0wUlxhDoQe3Ezqkpw09ULOGe9wpppACDbxbHvuUjnd
 c3BXXO9JJKg9LpKLx4dASklq9dRTOVZslFKlktvkDzFKfHkBXBD98FMHvzihMAdi
 WO8ciQqmNxxQ0rSUAeKRRqvpHg7GsO3ciI6tWrSa9ABwtOEjQSGXSZ1ieXyzsTVk
 8Zdm/hl76j7qcUq3G8/mCtnCOLKWp76bFqdEFAa+F44kEKe6rcvTqqEokBvb97kh
 516vWAiMtUHXsDfGWQERPw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=enjuk.jp
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=enjuk.jp header.i=@enjuk.jp header.a=rsa-sha256
 header.s=rs20251215 header.b=AIPdSLIM
Subject: Re: [Intel-wired-lan] [PATCH] e100: prevent shift out-of-bounds in
 e100_eeprom_load
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

On 08/07 20:26, pavankumaryalagada@gmail.com wrote:
> From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
> 
> When reading the EEPROM address length, e100_eeprom_read() can return
> an invalid length (0 or >= 16). Passing an invalid addr_len to bit-shift
> operations causes a shift out-of-bounds, triggering a kernel panic or
> UBSAN warning.
> 
> Validate addr_len after reading it from EEPROM and return -EINVAL if
> the value is out of bounds. Additionally, use 1U to prevent
> signed integer overflow when calculating eeprom_wc.
> 
> Reported-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
> Tested-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e0abb1d45ac291ebebeb
> Signed-off-by: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
> ---
> Tested using syzbot c reproducer.
> ---
>  drivers/net/ethernet/intel/e100.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
> index 29960762e64a..1de5cd41ea0c 100644
> --- a/drivers/net/ethernet/intel/e100.c
> +++ b/drivers/net/ethernet/intel/e100.c
> @@ -744,7 +744,12 @@ static __le16 e100_eeprom_read(struct nic *nic, u16 *addr_len, u16 addr)
>  		 * complete address.  Use this to adjust addr_len. */
>  		ctrl = ioread8(&nic->csr->eeprom_ctrl_lo);
>  		if (!(ctrl & eedo) && i > 16) {
> -			*addr_len -= (i - 16);
> +			u16 len = i - 16;
> +
> +			if (len > *addr_len)
> +				*addr_len = 0;
> +			else
> +				*addr_len -= len;
>  			i = 17;
>  		}
>  
> @@ -765,7 +770,15 @@ static int e100_eeprom_load(struct nic *nic)
>  
>  	/* Try reading with an 8-bit addr len to discover actual addr len */
>  	e100_eeprom_read(nic, &addr_len, 0);
> -	nic->eeprom_wc = 1 << addr_len;
> +
> +	if (!addr_len || addr_len >= 16) {
> +		netif_err(nic, probe, nic->netdev,
> +			"Invalid EEPROM address length %u\n",
> +			addr_len);
> +		return -EINVAL;

An invalid address length here appears to indicate an unexpected
response from the EEPROM, rather than an invalid argument. Therefore,
-EINVAL seems somewhat misleading. Would -EIO be more appropriate here?

Also, e100_eeprom_save() seems to have the same pattern. Shouldn't we
fix that as well?

> +	}
> +
> +	nic->eeprom_wc = 1U << addr_len;

The commit message says that the U suffix prevents signed integer
overflow. However, after the validation addr_len is in [1, 15], so 1 <<
addr_len cannot overflow an int. I think what prevents the out-of-bounds
shift is the validation, not the U.

>  
>  	for (addr = 0; addr < nic->eeprom_wc; addr++) {
>  		nic->eeprom[addr] = e100_eeprom_read(nic, &addr_len, addr);
> -- 
> 2.43.0
> 
