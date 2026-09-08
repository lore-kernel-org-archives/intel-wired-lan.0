Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBC7C79F99
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 06:01:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B46060609;
	Tue,  8 Sep 2026 06:01:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id excTol1Yz1Vz; Tue,  8 Sep 2026 06:01:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0BBC860608
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788847267;
	b=auCpxHRK1l32pKtxLG8ebTw4x9ada9CLBzBtxyNryTa6pqmffn1fJmNRymhTTEhdXTiX
	 NkobslZubRGNgpwyHvp56rqbz1ZukkaMAKYEikF+D2TOX3St2/ZRcD1xpHyzyaShhtZnn
	 e65WkkF93wRfSLZu9G7VGipFvUu7gGqyluLnJyQUwUsRW2AmiK3BCbjgwDQQsVdDcpzVG
	 fBvN1F9GNs6bUbH/QghS0cU9dHNxdBxB3PXS3xuCyVbDowCaokVDhLPfNRHQVCcqIwH8Q
	 rsBkVtkjM85peWf2glAaMvik1OF1m4r2hmBjO+9wNauTiaGDkt2BXEObKPaeWeBVtqA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788847267;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=UdN27yuarFJ0bS6RZN4qrHEQI6SbOy4cMG40wpZ62V0=;
	b=SwgB8tEFDsUzDYHSN0RDd/P/8HUmwWS+bwBhUvdIp8M/iBq9WuHgLvaA50nZ3ACN4Irp
	 a/B1/7lWND8wa6SV8sExTAn4FHTAJr7bl5RHdnuZvcSFY3Wp9laMXcLOGrBZHX22vFrAp
	 USbT1v6E2Dg1Ig4JmvfV1z4geWufdQUew4m9w7Yoj7sBmW8n9slF0UflRHa12eBPp/6Tz
	 0p/lldDFfORoDHuRx58tfdqLzcyrYdYsq+IuPv25IONu09Qq29Ti0vmZBtn1XCHCgZO1P
	 5cfVK45rU+1m2PnOw0neuL3nqcO6as9c4bgzKEHfsk3ppY7HPLTirlS5VNY1Rf+hglw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788847267;
	bh=UdN27yuarFJ0bS6RZN4qrHEQI6SbOy4cMG40wpZ62V0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FZLA0b6eUiGXHljOmas5tPMgHXPegTkZlfmRX8n31uDBdJlmqg21sDKeQ70l5VGk5
	 TtaGl5DbkcwzObzACjIaN9BMw0IxkXlkKjq1MO254SAMkGnwjxrwkks2pvH/Z1dN4z
	 3WAJT5O2vFiGNocrlG1YH98lFEhBliUBwB5oE7YwYff73ULVGKc1o0wVEe6kc2wAu9
	 YNm7It5SP3EPENx/nW8GzzdD5xRIXEiKCjPAekMQMbNbCm+kYi8zU1Rp5hxQajhDsL
	 NtGeKRN+8Qj68zUccxGG11E9IQW57ZyOj69NA5/pB+aICA+htV+wrDuetA6cZ75POe
	 g7umYdJhinKzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0BBC860608;
	Tue,  8 Sep 2026 06:01:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E06FCAEB
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 06:01:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D1E65808A6
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 06:01:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ljOjm1ZO_TxA for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 06:01:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 234E98089D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788847261;
 b=XtS00iQZExHlA+KoE4/Vh+Oz36XijanFp25HgHVsL1eqoncj+jy7are6d7uss8Z7C8Rb
 /29AbX2sNTu+u1+NEGyUjpuiHnV9JvP7Gmmcx2d5tS5Zu1y5Xl9eKAd/XdzpvcX/h5Gdg
 RYzG16EuDGWBTGjUijW32nUYbvL/OegwburqRIeBKVEg2PEtdHLQMT9PMFRtgRULNExEy
 +gS8o73OX3K1HujdX2G/KuUQ59AAGiL4InNPfsN8iWJ2CDMtHKoX/XhUxlF1/xo8+OLA2
 GeMQTGGHxH2SLMqEujw4sPLb1u/g3wFBnpr6o4HkczoQziVBlJL0wancWdRYJffxdag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788847261;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=UdN27yuarFJ0bS6RZN4qrHEQI6SbOy4cMG40wpZ62V0=;
 b=bzzyDWsPwNPNcTGwgXrC8PYTil2EnjnGiQZiARIZXj+hdiuhD2nu8p8tVypDJiU94WFI
 GLh5ArNf21zcinzkEXPPwTI9UziJj/p2ydLvXqJk2/ypncmvSTcOqI/8t7E3ASb+XppQZ
 1Uz7R/6htKh1aSuEo6A/zS9eJQsOvxMz3/1/bpIA9A7jE7OYe8Y3PpHJxXkoOX5VuM+Yd
 eukHnm1FvbAjCjTQDkvg/GshXRWY7F23MWp3+M33PHzSiiKyLrhMRlMsPN05vyMsXJXpZ
 107PzucRn+aIY4aeAk48fi2h4lbMv7iMOVlKcP6z/DRVMLymWI2XCx6ompc2NFICjJw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=infradead.org; 
 dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=bombadil.20210309 header.b=KL2M8MXH; 
 arc=none smtp.remote-ip="2607:7c80:54:3::133"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:3::133;
 helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KL2M8MXH
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 234E98089D
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 06:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=UdN27yuarFJ0bS6RZN4qrHEQI6SbOy4cMG40wpZ62V0=; b=KL2M8MXHvjrx5fgGwmm7ZEEQKh
 nqS5WzlK0dCIcTetr0hiJo/XTEFKRck8OwZpNkqGc4MDp3xjeZfbwim0XvpYxbxWn/23UHdw8UYE6
 tqoJyNURI49wNqflHfO6ofAKwTycKaahYsF2BH1KUjMzx+g5r5Q3iJGHdXGzb+buXUAP8Fi37YkLX
 bTfUgfASYTCK20HI6bfb7MCINfcBkSOwuuM2sTHtDp1IaEFAgITpaWz5e1i3MPArJ3G1CdkSoWSuu
 ANxMIo/PMhGfjv25wLeu2Er0blhZ1jbx21gkOn2NmyMpF1ptXQaPlQTXaLNbm8C4Tfmnj5s7RfVxO
 0HQLivIA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1x3ot7-000000087Ke-1m4N; Tue, 08 Sep 2026 06:00:57 +0000
Message-ID: <a33355f3-3295-4aab-8e37-b176d477ddc4@infradead.org>
Date: Mon, 7 Sep 2026 23:00:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 0/4] intel: fix typos in comments
To: Hemanth Selam <hemanth.selam@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260907095446.27290-1-hemanth.selam@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260907095446.27290-1-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 9/7/26 2:54 AM, Hemanth Selam wrote:
> Comment typos across the Intel ethernet drivers, split per driver.  Found with scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Comments only, no code
> changes.
> 
> v1 went out with a bare [PATCH] and a "net:" subject prefix.  As
> maintainer-netdev.rst asks, v2 designates the patches to a tree, and
> each subject now names the component it touches instead of "net:".  The
> series is rebased onto that tree; the diff is unchanged.
> 
> v1: https://lore.kernel.org/all/20260907064528.6602-1-hemanth.selam@gmail.com/
> 
> 
> Hemanth Selam (4):
>   i40e: fix typos in comments
>   ice: fix typos in comments
>   ixgbevf: fix typo "enble" in comment
>   Documentation/eth/intel: fix repeated words in comments
> 
>  Documentation/networking/device_drivers/ethernet/intel/i40e.rst | 2 +-
>  Documentation/networking/device_drivers/ethernet/intel/iavf.rst | 2 +-
>  drivers/net/ethernet/intel/i40e/i40e_common.c                   | 2 +-
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c                  | 2 +-
>  drivers/net/ethernet/intel/ice/ice.h                            | 2 +-
>  drivers/net/ethernet/intel/ice/ice_main.c                       | 2 +-
>  drivers/net/ethernet/intel/ice/ice_sriov.c                      | 2 +-
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c               | 2 +-
>  8 files changed, 8 insertions(+), 8 deletions(-)

For the series:

Acked-by: Randy Dunlap <rdunlap@infradead.org>

thanks.
-- 
~Randy
