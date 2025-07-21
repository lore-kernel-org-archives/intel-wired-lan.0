Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3BFC83F25
	for <intel-wired-lan@archiver.kernel.org>; Mon, 21 Jul 2025 15:37:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0DD2141014;
	Mon, 21 Jul 2025 15:37:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NpOtkFzM9ot0; Mon, 21 Jul 2025 15:37:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C488F40F8E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1753112266;
	bh=SDh6f89OtCRQRfeV7TsPgYDLKkybdTNwjOtD8a9eZwA=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ejMiRb1XWZRuNIYP/CScq3uV1QGjSuzMOkqaXOMMLavBMpqCWJNOF2XccuGA0RFV5
	 jJ4n/Q8/tJJjNtZc+Yd1OsKNlS7dJBIbXzPX8+mjYWASwxosFVga6Qg8NvbNs5as8D
	 jmdIAUp2jwzog05qb1Y7VDB1m5+NTrCuK6a29hM0reI5rj9aG06XOv8N8hLO8Bge6I
	 XbzShRvVrYHU8m/NjWxuuipaKKtA/JLgGyKMwpB+0A79XhcrxZ8im5FEuB4ZM8z7FJ
	 c5C0+RApO5ZYd4OE18Hn3z900iUjxN/YOHLA/xBijbPADm1dICnDGYKkUPruway+pm
	 ZomZGRF9BPp9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C488F40F8E;
	Mon, 21 Jul 2025 15:37:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C09DDA
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Jul 2025 15:37:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8E1E660E52
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Jul 2025 15:37:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4i7IbqhkBbBl for <intel-wired-lan@lists.osuosl.org>;
 Mon, 21 Jul 2025 15:37:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com;
 envelope-from=stfomichev@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B2922610AE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B2922610AE
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B2922610AE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Jul 2025 15:37:43 +0000 (UTC)
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-748feca4a61so2480760b3a.3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Jul 2025 08:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753112263; x=1753717063;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SDh6f89OtCRQRfeV7TsPgYDLKkybdTNwjOtD8a9eZwA=;
 b=SzLHLdJNKa7e/zY85wV8MnIy4vn+JGWO5Ye3LYkIzacf2WWTvN6qnjz2Ws4dbwe1p+
 oxW0LHNSX6slmzAmwzervX3wHI1fEsX5Nxa9rjxxbknoKjEUgOVncqzFf0vP14opqcb0
 AS3kOfvLoys7/FVrLJqvA+EsiIBsq1TaG7vdjkcuZPQBKMKRJFwn7CYhX6H54rbklxT8
 d9uQC5HBCFMIvb3h9j9t02zrwaIUSQysrm148shuBQ99BZZ7YhzqoFGnBK4Z4p9FIPdw
 /5rvWGAQDu99SOpJU15BFAwoLGT/r5JKAg4Co83smcLmFgusqr7/a6IxDF+oCeXQd396
 Gy5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVBYabcieTqFNDsoNjQgPvQMmES4cdgeDfxq5xl7ibVbfAJ1nimabPgBcX65z8BEQlEtZoEbwbqI6kNu93zKQ=@lists.osuosl.org
X-Gm-Message-State: AOJu0YzzCUmX0a4YLjwKGh/RPM5KJ/mPn/or26fDO3iqyblNC0gMshBU
 VdWfDZitCxGoieOGyd0P7kPw1zgc950WyLu9il77tQLVJqz1CdCI+QU=
X-Gm-Gg: ASbGncsrbwTtRIKRNVAgw6ZR4ysMIv/Em/jO5yabT2utzpFZPG9jfkcR3MF9Hqq7zfT
 zJvC+LZuWl8irQBzfEXhAMZhUxTijL+uayLnA6y+wmYS8Bir2Unoaa1hUhcahkpqY33sHQlccBL
 fkyqVfvwExwgh+jE4pWTcFyPOe2HkesjsH2Pb71Ros3XogWUQYjldVD+RfjEtwzwNhFiL3rKNtl
 hpaclLlUKxsvx2TUoLfLkLQc4SciiovUpHTtksIfEdwPp2xAJM5jUNnuKQzhLf2hN5DLttxe4dN
 16jMa65ygoyqlTlioeV1qLsfLqg2Bp3EDMUsOfJirRGI/+Bg/ZUTQxZz6QjZDBz0FWnf1BAQmFb
 s33XrOQVb9lGajwQWMvq5oyAVEcrBWv8221fZXi9XbzrY8fi9PriYWp8saTm+L5BHutCELQ==
X-Google-Smtp-Source: AGHT+IEaIspNuv99Qrfx4sC4q4Y93JQlnVL5ZHYgom/rDGQzYOHx3souBPvCEmbOTJYWppBnuW8WRw==
X-Received: by 2002:a05:6a00:856:b0:748:f1ba:9b0d with SMTP id
 d2e1a72fcca58-75723e74318mr31994730b3a.11.1753112262692; 
 Mon, 21 Jul 2025 08:37:42 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net.
 [73.158.218.242]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-759cb155de8sm6048908b3a.84.2025.07.21.08.37.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 08:37:42 -0700 (PDT)
Date: Mon, 21 Jul 2025 08:37:41 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux-stm32@st-md-mailman.stormreply.com, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
Message-ID: <aH5exXo_BdonTfmf@mini-arch>
References: <20250721083343.16482-1-kerneljasonxing@gmail.com>
 <20250721083343.16482-2-kerneljasonxing@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250721083343.16482-2-kerneljasonxing@gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753112263; x=1753717063; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SDh6f89OtCRQRfeV7TsPgYDLKkybdTNwjOtD8a9eZwA=;
 b=bDzLDnlZ0kxrnYWtwc7ghHXktvbMAq2CKEjG6u8PPCYDlyBbBEWwJviTJ0Wj+0yjvW
 bFrSk8GhpgUbBI0k+yZz9BSAjFeLvBtZi9jW9ez8GPR6U7sPDDSibVn7EuEfa3hiL2Se
 O7C604kEQ89DNg5YXmdpiFFKpnj8wRdME+mj5kvgKHZA7ci4c8DMLzzZd8ooxXbQw8u7
 2uLZAHcfHhq1naxq55woUGtSYbEPegxSGk8d7NBtd0MY/TOP7sNa7VcyKufdiCr0N50S
 4m+GHnTo8JcdNc7vQkqLf/lYawbOwkLfkRON6owRBM3R2R1yVN7rw69S7sf5gqFiFdRy
 RYpg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20230601 header.b=bDzLDnlZ
Subject: Re: [Intel-wired-lan] [PATCH net-next 1/2] stmmac: xsk: fix
 underflow of budget in zerocopy mode
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

On 07/21, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> The issue can happen when the budget number of descs are consumed. As
> long as the budget is decreased to zero, it will again go into
> while (budget-- > 0) statement and get decreased by one, so the
> underflow issue can happen. It will lead to returning true whereas the
> expected value should be false.
> 
> In this case where all the budget are used up, it means zc function
> should return false to let the poll run again because normally we
> might have more data to process.
> 
> Fixes: 132c32ee5bc0 ("net: stmmac: Add TX via XDP zero-copy socket")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index f350a6662880..ea5541f9e9a6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2596,7 +2596,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
>  
>  	budget = min(budget, stmmac_tx_avail(priv, queue));
>  
> -	while (budget-- > 0) {
> +	while (budget > 0) {

There is a continue on line 2621. Should we do 'for (; budget > 0; budget--)'
instead? And maybe the same for ixgbe [0]?

0: https://lore.kernel.org/netdev/20250720091123.474-3-kerneljasonxing@gmail.com/
