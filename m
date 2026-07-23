Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91319C531CF
	for <intel-wired-lan@archiver.kernel.org>; Thu, 23 Jul 2026 13:02:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 30AA3608EE;
	Thu, 23 Jul 2026 13:02:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TpLx5YdszVYN; Thu, 23 Jul 2026 13:02:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6FE2C60792
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784811751;
	bh=3lMFDKKyt9GdKFeZbUjldfucgXKXS6SFWpdSFPP3BCA=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xw1TiyjNgwtz8Ignc+z+r936DFs3dDMy0ktimMtQG04yvIBrDqNFQb6d24bs7xFFN
	 sBxpnKp5SV1/9XQzaw79DZV2esclnl4Zx0pduhwrxOkvUx2s1Cs8luS2MbndaA9M7q
	 ZByLrpC332ybHnTZEs/JaEcNVpE9cJDo7YG6NM4H4sba+GA83sbEuONbwGQHZ2SfkN
	 B3VWkrctDoA8C022ps9zSNlbl4lVE9WE6OLgOwlpHZ1VBiX3BUyPFM4jzdzpf2acsZ
	 Opmz58HlgRAaE1VYtjp4eb6SSBskQLzG9aXbz2L+1TGFmdiX74HAcGRyBMiRTBdvoa
	 oxyqk5eDr5wkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6FE2C60792;
	Thu, 23 Jul 2026 13:02:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 766E942A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 13:02:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6801360792
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 13:02:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FCdIZWCEVdv4 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 23 Jul 2026 13:02:29 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com;
 envelope-from=joe@dama.to; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CB6BF6071E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB6BF6071E
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB6BF6071E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 13:02:28 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2ccf2360620so5639645ad.3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 06:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784811748; x=1785416548;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3lMFDKKyt9GdKFeZbUjldfucgXKXS6SFWpdSFPP3BCA=;
 b=itIaWXodRv/hK1QBwbeJY+LUna/Nd+ot7q7ewnoR6K1UxyYc96kBo7LRdd+fNerStZ
 QSIjUK4QGYhJPHhgabuEWCWb8KKY+oW8sIs1pofqzKtkFIRs3oyBWaRPuWKxu2fFktcQ
 Ok/AE8k4lptzCsihSUCJekJkq1+RKWoHOKs1BMe0aR330tW+giondY2p56Nji7w5E8HX
 KXlx33e96+bnHI55QHJoeGx0wurTAwu5mUy0rcJqecLawUlKrU4KjkVPxZnOJ1+o5A95
 pFKypFlUeisiuCvb+z1wwWIDvZdJFPuDL45SjpNRKfzeJ/ouMm4WacnMpyp5sg43QX68
 /V9A==
X-Forwarded-Encrypted: i=1;
 AHgh+Roim2m3c0NVwqlhIGNiIlF2drRf6zDYO0sQljkvB6/kSu15OwMaX2mEqpk+ui2k7bFnAq+yQELbnGkq4/jVEnE=@lists.osuosl.org
X-Gm-Message-State: AOJu0YyIg42zi8VVw1o+AsWRbuzRXrajB9mbNmvyB3XHvhGWlg6QnNHo
 0yDUQ88ghTUfAvPlPIcHAx0Z9zF9nmZqeolpdxabfapDTfoZYdenDH1bjbZUUq5+RVY=
X-Gm-Gg: AR+sD1137Jg6CXMA0JYMZfodVRIXv0l4J1UAXswVeK8fsYxSiS8pO5RLoM3IGAURWhP
 4xBMyMVCoThoVk2WIHtfiuWp5NnlkUOsRQJ0Lyj6I5z6241KWBialGt3ZPE3rmE0tGTWT0sx7N1
 LdSJWkxZptRZACsyT/nY/BadKBo5zwyNmtjkDVVWQtmHEtPuxgcXYUzHEwdauEQmJYvZvc5NJaF
 yzGXqxStSlzDQi5Yll6htP5TAUzyD2wT9i5KQW+q9unTyj4EQ8yFStLpDaHhMp5q11BiLZ7uUYN
 sKNN9VwSP9QJmHyUaMLgQa2aBvY6BYU4o6URA9RIH6S3wK4/K4zarZqhLqO0hEtvvuryzkayJ/3
 aV4Ugh6DPNl0FgjR5R5Il/FqEbaAeGdVpr8kNzmISnwQr+5j67ixYWdpRSqI=
X-Received: by 2002:a17:903:184b:b0:2cc:307c:51fc with SMTP id
 d9443c01a7336-2cfa6bb32a4mr34615355ad.21.1784811747711; 
 Thu, 23 Jul 2026 06:02:27 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:46::])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf8f350554sm33032095ad.66.2026.07.23.06.02.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 06:02:26 -0700 (PDT)
Date: Thu, 23 Jul 2026 06:02:25 -0700
From: Joe Damato <joe@dama.to>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <amIQ4QWie1boPvEk@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
 Hungyu Lin <dennylin0707@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260723070451.6545-1-dennylin0707@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723070451.6545-1-dennylin0707@gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dama-to.20251104.gappssmtp.com; s=20251104; t=1784811748; x=1785416548;
 darn=lists.osuosl.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:mail-followup-to:message-id:subject:cc:to:from:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3lMFDKKyt9GdKFeZbUjldfucgXKXS6SFWpdSFPP3BCA=;
 b=uTjr6tf1VWL5RqLJfQStArK2qyl60EDNwMH7AzhF/aPG/7PrINFrEUGaa9RnOXNVhL
 KiDRCrXAK+iDiycoRsBMlQl/l1TB4neBjDLvehyTAOj41dEuE2b4bG3xwKArQEXn4CXR
 SKsP/cuI4DTJLC0UkFdW0sdOTD8MYp2ieCHxil1HfHQwy9/WbJMSxHsizF5CzatJG53M
 BzKCKH/DDoWshoYraA6fbuYzYsq3vK0N8CWVArI8+xzFe4Ol9RZhwZgMplneIDaxELdU
 DLNN1UCE+L7kCbWDCfRX7L5G1qhM5TaYKibCoEZ/B4evsY8HjMy4ZO0d0ZI9xil729Vh
 j7zw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=dama.to
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=dama-to.20251104.gappssmtp.com
 header.i=@dama-to.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=uTjr6tf1
Subject: Re: [Intel-wired-lan] [PATCH] igc: Remove unreachable break after
 return
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

On Thu, Jul 23, 2026 at 07:04:51AM +0000, Hungyu Lin wrote:
> The break statement immediately following the return statement is
> unreachable and can never be executed.
> 
> Remove the redundant break statement.
> 
> No functional change intended.
> 
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 2c9e2dfd8499..6252d4b68f88 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -2528,7 +2528,6 @@ static int __igc_xdp_run_prog(struct igc_adapter *adapter,
>  		if (xdp_do_redirect(adapter->netdev, xdp, prog) < 0)
>  			goto out_failure;
>  		return IGC_XDP_REDIRECT;
> -		break;

Hm, from Documentation/process/maintainer-netdev.rst:

  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work.

I think this patch probably meets the definition of patches which are
discouraged.
