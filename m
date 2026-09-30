Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB09ECA5FAD
	for <intel-wired-lan@archiver.kernel.org>; Wed, 30 Sep 2026 00:48:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7756660842;
	Wed, 30 Sep 2026 00:48:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G8jwS4HrqNpl; Wed, 30 Sep 2026 00:48:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org ADAA76081F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790729281;
	b=sYK0+8236ya+WwrbUR/Wnc9LHWONWouDcGD9lLFci/6WIjGH3Y4KCqMI0hJkbmRfUjVG
	 BCGOFJ3SINBsKmuOMD/Tl6lxJ4Vk1lsbVpYn0acvyWC2A7nGi3rXqvX4QKLz/e8kFTLMW
	 q6PhtXOZmIrxoKa4nodBY0VoHsHBeSQyx46daycKG3+HHiROBLpYumUCQOevO2+8maL3V
	 ZNYmQEw/A41GFHx5Ws4JpZCTLG9PR4t+APU6bEGOGkTdfVmPjkE//4uT/BQybtVoZ38+p
	 V2QGMSTIK04svAIvxjZsjYU2AwwXuU94w8DnOQG4y5Ktj83lc0gpDOAk+HJ6AJPsQqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790729281;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:Mail-Followup-To:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=40g7gQiOI5yVws2P9bf3jH4EWpMijZlz7/Un3g1hMDI=;
	b=MFSWzUnbFb4fD4beDAS6JMlCQ+71z6INI1MvA3QQTFI7QyZa8bhAgnDxz086w81pEH/p
	 Yf6OHjXzho9tIyVUH4l+1S/ZiAOJ3Ll6THRlgHjAGNSIUcZhofwEBE5GNSpryRjdHzLnV
	 OEdS8DVPYBvpmAm1PuWjka910nQWQ7RvEm5fSSwMkubolXuLa0wItIOotThUxEG7PDl7W
	 zrWSWr/2T4/a8OfWvyqkVK7XJLJCgTjn4rAoKGyEpQv+2w6byNybIyB3mGwf1oPRjWy93
	 Rl7cICoL/vrSHArVb409I9EHgT7HeefKYGUDVouYFSbL/qccalYPpa27bo7v6tKvUlg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=dama.to;
	dkim=pass header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=HanThFfa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790729281;
	bh=40g7gQiOI5yVws2P9bf3jH4EWpMijZlz7/Un3g1hMDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QFwwKZmGhRmzBjD4KWu/hhAwR7Vr7L+v9uCWNgddCOUCBJ5N+EByvK6/Zc8l9uwB7
	 ltdIMm219CVFmN96b6BKZ75yf71X7sYBjd4TkdO92QnxbjxZhRL9S65JAXm/XaITc3
	 neo5bFj/xmHRf6jA4yWBAD4ikzaKnvd9kqSCUOYEF30oJ8+gsAMJDHAv0bXv9azl9L
	 Izpdaj6IVhCZwy7KL1hPiWQskdz4B+5yhoinzX8LGZniI8WG51Sk7zWyLQmDzptdso
	 hh/0tJ1f0XB6GrOTIxLyWDG2PeTwzcRdyFPkkLdlOoo9ByU9VOyKiK+f5KGHuDZxnm
	 h13EauICL/paQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ADAA76081F;
	Wed, 30 Sep 2026 00:48:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 752032E5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 00:47:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6650C6081F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 00:47:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gr7EF5hA0mwa for <intel-wired-lan@lists.osuosl.org>;
 Wed, 30 Sep 2026 00:47:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AF5186081D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:3b::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790729278;
 b=VCoYSkUfz8lxsi0hBQMeHIb9dlim/B7w2eUGZIiq3VMitYBOgfwaoXwGiYOMDWGinR90
 QHmvcKnhwdF5iZcqePIMYWSJzbG4/GE+yiv276mR9YBMQemprEkpRRDLpH7w6OVkaNlB2
 5nF4PAuBHXt7mYa7P9vKtOeSBt19JEI/eQCCRiv4wLaNJ6Fcw1QoLZR2LLJlLlsoO+jy0
 F2pyjX1Wy8f9t4onwbzlAAfqTyu9QgDQqwi0kIlrF5yCvp/QgCsGmDbG0HJwqtmVdrX0U
 HZPiJDdNk6NAMnGeAB1YpDjpnare1ritfTD4ij6M3oSR+dMYrqgM5tDteDoKxRf7iQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790729278;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=40g7gQiOI5yVws2P9bf3jH4EWpMijZlz7/Un3g1hMDI=;
 b=CIZ+6d3SpavzjtYTXPXKfivamOiioSAr95DPQmJuPI/TTGMU0fD5XHMODdBXqfDxgtbe
 FhEixa7c1tYgW95CWxnT3pfop5zc0T/ykdGsNZkBgFP3xh7dEk31DQKjp9P3MTD3PtHsB
 Tjy/kSKGuubbabCCh0N2giqHCX2rzMp0TOfUY3eoXkRfy+s01WCMDxvKEhR8aU0B624F3
 rNxLJCgve2P9ccGYWJHCZ9TfkRUhOdV0hLS0PfxWWBK0OhdKEDFpXewVeUsf1rW6wvLB7
 H+RT8+1uia5pCggXJYBFVS+Vz4LtP2bFfuxXljxwP/7sCT9FKeyJW48in+ZF425EImQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=dama.to; 
 dkim=pass header.d=dama-to.20251104.gappssmtp.com
 header.i=@dama-to.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=HanThFfa; 
 arc=none smtp.remote-ip="2607:f8b0:4864:3b::d"
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:3b::d;
 helo=mail-pz2-x0d.google.com; envelope-from=joe@dama.to; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dama-to.20251104.gappssmtp.com
 header.i=@dama-to.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=HanThFfa
Received: from mail-pz2-x0d.google.com (mail-pz2-x0d.google.com
 [IPv6:2607:f8b0:4864:3b::d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AF5186081D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 00:47:56 +0000 (UTC)
Received: by mail-pz2-x0d.google.com with SMTP id
 d2e1a72fcca58-86efece610cso2397578b3a.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 17:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790729276; x=1791334076;
 darn=lists.osuosl.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:mail-followup-to:message-id:subject:cc:to:from:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=40g7gQiOI5yVws2P9bf3jH4EWpMijZlz7/Un3g1hMDI=;
 b=HanThFfaEqS4nVllHj0RuObl+lcl8VjqAAMNBYZjFG+Ayxd4YYW6IQ7sjEMudzGr9K
 WkjAJqd91ZoOyM3lTIYWhkCB2AikwCsZTJCDmuGArD4EXdir3moB/6deYIesZNCmFEc7
 UOdE3sp/EO7iVEYc/LygSQ68dc7gl/x0seocNep/1iN1X//bEjUGywX4emaQxicqHoNZ
 LavB/Prv6/9zLm46pdxEc4ryOwob7niHDNUIyDOW74cpAsTlKR8lglrmV7j9K1ZzjHiD
 xYB4TDfRwYwk/uyx+32irfFSTxATwMLVlLoQaO89lVaOq7r/0anlRFiWmHx18X/kOGOd
 EsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790729276; x=1791334076;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=40g7gQiOI5yVws2P9bf3jH4EWpMijZlz7/Un3g1hMDI=;
 b=WNxSwRKq3i9JTv95uAd/DHgT2aNi72RoPzk9w2JYyAE2RiYef9Z+b53vGfu3Z5gqaV
 GQjc/5B7iOm6xQo8HrFQ+wlQstE6Thnoyhi3JZADxv9kNpG5RLijau5TIeflRnt9peQH
 SFs8DfAQ+JGgt/g3q8m0J8uOYcS5QjUGa8F5I6K/vo7+kc5GMvIPxyncviJIU4bHIfv1
 H+xV8PHShd2lQpglmf4/oh2Kx4mCeWi8aiA+/EIcFRPrfjz1qN1wfs8fOGjmus/bBWIh
 Wdq70p7WR8K6OO+D6g5o3/piNRIO+JNzMi4EhE1A+7UuyajSvHZwRZT8u8JwrZfKKgZA
 DhdQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByO2HzCMAVaJLkLJvFH9Bi+FGNiTjbucw/XLW0yWHyCA+ybeZyeUty4g7DSIbSjjFwCDmTfkRGX6ix8Cf49oko=@lists.osuosl.org
X-Gm-Message-State: AFuF++nizcnVXYvZCngRVEotbWWn/ibXU7n1cXkqyBiMPCizo7fDqdLI
 0gYMdsxxYMdz4mPEpmn5c88ymy/AEyLwuhKYN9XsDmw3pfTLN6KSP0nTTF+oKmOpSLY=
X-Gm-Gg: AYBFou3v/QkPzB8tn9Mkg5qM3gsLmaHzgxxH3NmfV5WvezXYioXQHZlqu27Oq9knAeK
 2L+N118FEwRBqwq1ycnwWeXPLmEl6PFvVLcyQI/iAsGrvhgT3gYI+lTXQl9ZwauPsL7yC9ROfPK
 FzqbmukFO3q99qfb7V7cSGsYJB5wudOohYr2kb/zJML6Eyaw2UJpryAP4Yg4BKTVtT9lREwpM5N
 IL4Z9LdklVI9v86vCYuIU/i0VzvEc2BR/FFVul46PDU4vxQeyYG4bO2ay9afS157tfgAtlz+ipp
 7Mb892QsZaVSTOGKeCkrs9huHFSh8PDpU5o4vKKtRURzFwzHLuOzCQsc23GZtqS+wBhRLi67siC
 /eOyePjfbrqp3cLCaAdyY7h5NQH4DC/SbQhYctAJUh0Eyq4jtEEDMPBBBDN2AhC+j8VqhwzqUhw
 UFWJha0zS7lnitoSed5V6gdAOilPGCghwmnSw+sdXK12ST1Spg84dWr7acNTAA8B5TYLnYGePQo
 y/3IO8waBx0Y3CUodWUC5w=
X-Received: by 2002:a05:6a00:1906:b0:869:f065:f499 with SMTP id
 d2e1a72fcca58-886c3eb14a7mr659287b3a.25.1790729276326; 
 Tue, 29 Sep 2026 17:47:56 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:48::])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm560259b3a.21.2026.09.29.17.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 17:47:55 -0700 (PDT)
Date: Tue, 29 Sep 2026 17:47:54 -0700
From: Joe Damato <joe@dama.to>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net,
 edumazet@google.com, intel-wired-lan@lists.osuosl.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com,
 przemyslaw.kitszel@intel.com, sln@onemain.com, stable@vger.kernel.org
Subject: Re: [PATCH] ixgbevf: fix xfrm_state reference leak in
 ixgbevf_ipsec_rx()
Message-ID: <arxcOtu89COHAncp@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
 Wentao Liang <vulab@iscas.ac.cn>, andrew+netdev@lunn.ch,
 anthony.l.nguyen@intel.com, davem@davemloft.net,
 edumazet@google.com, intel-wired-lan@lists.osuosl.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com,
 przemyslaw.kitszel@intel.com, sln@onemain.com,
 stable@vger.kernel.org
References: <20260917111418.2148632-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917111418.2148632-1-vulab@iscas.ac.cn>
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

On Thu, Sep 17, 2026 at 11:14:18AM +0000, Wentao Liang wrote:
> ixgbevf_ipsec_find_rx_state() returns the state with an extra reference,
> which is handed over to the secpath on the success path. When
> secpath_set() fails, the state has not been stored anywhere yet and the
> reference is dropped on the floor.
> 
> Release it before returning.
> 
> Fixes: 0062e7cc955e0 ("ixgbevf: add VF IPsec offload code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ipsec.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Joe Damato <joe@dama.to>
