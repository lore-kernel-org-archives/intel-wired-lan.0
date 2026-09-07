Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89415C79FA0
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Sep 2026 17:27:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 262E560609;
	Mon,  7 Sep 2026 17:27:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A0mpSK-dbzz8; Mon,  7 Sep 2026 17:27:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 757906060D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788802044;
	b=OZuKtK7KMk+HANBUfSBRvTSIbxBnMD0SnewBU7kZSqXS1P0PMa2rn4B3+sFcHMq82qfO
	 wfIBy1TKmUH+8hzzagTwF60W4y5lbS/NMjPcHmHeVxNpmiJY7qAjwZXPHfCDpY4ATSH56
	 e0fxdvx8g4LlZ2vjzgSi1/gyhKhLqrOz0Vn3hKQQkQFSq9PUKxDURerRhHFHl+8W6y0QA
	 HU+rA1gNDaoEmGJXd4sZ5VJDefsuT82y9rG16crEYtQkLxtrOLid9QUGLULpvl6eLAkms
	 WjtLAvGl2/1Jf4Z5bCrIsuP+ISKBeOAqtSuGd2MR4PvnIDqWPtef+OFVT5BDvAqhStg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788802044;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qc3L0xLUv/lYkUXmkoozru40b0Kewh1PPsm8nRO1ZD4=;
	b=Rr/HuDJEzTgFblbm/ANV3cOMkmqzIOrDTSZGGMrhCmBKuXYXbXYvjYtm94SWppL+upDO
	 eIXA2nIl/oR7d84Um5R91yrs6xdzJn5zH04bqzOE+A01lneU/8Dx2kFO4bFQgMM4btVgK
	 L1yNkznD5H+viGzmx4HTIPx7pOw9s49uZxMNoAgRqAmnmv0mt96vr2mQcDygpCOfcVKIT
	 nDYoPryUimQWfepiKv71FTeQnEPZcjlQNB3r9Ue8A1aCzAVoAGqfEz5I1xWXAHQgTPiMI
	 xEHRfghoXy+bZFZOnOxrVKEbVhucq2JTGLi3wnC/4+zvM82CE2o/d2//HWAKS2TKwdQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788802044;
	bh=qc3L0xLUv/lYkUXmkoozru40b0Kewh1PPsm8nRO1ZD4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KbfP6JsgenEzfrZQaMkmOVKG76zCpH70IjXnghGjhxm5j2aaxbAT46VKjCCMZ58pe
	 +llms4B2/Qz4jqh9kDhzS7ZGjDXPHdl7h3E4wUc8/tH+hvs7fUykl+Z8CpJxt83Nhn
	 COCJh5R4V3s9xZfpfzG7l8hRH58Y8TkQ5SsZhR9X8qlcn0L9S3RXv3HKiBdu3yGWc4
	 olPjFpupn5bWGS6Qa9HkCoHSybR9dgtZ6TQ7iHGLDCNo6In2d0R8DCZqxxVNbjlU+l
	 PAGwBtSWQgdNbttsY9T6y66giwFTKhpp3/EdetL1A9qVW8rav8H65mZ1HdYE+0pIod
	 f3nYIg1RF4vcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 757906060D;
	Mon,  7 Sep 2026 17:27:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D046534E
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 17:27:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B66EA404F2
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 17:27:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1ulhcQ4FlHc5 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 17:27:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1593140441
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788802039;
 b=rj0gQrDu9eM9g9mPmfBI+2ZkCAfMiq4z8XjKI0lGp5+U3vPW9y6FcOJUsj/4bIABRzZA
 DMkM8XfJj4vothCQNT4tujbnGa6tf+S/Uzxmufe7K+AmX7jxb2TKjLgNy8NzbtcYvw/9I
 jOKK55jFot7TSo1PRqNcwX8NOOycVQNaWtB7XrzjbmLriDRn1hjY29DSgr3vYQa5fqgxt
 cybKb0z2mfMYflB5MyaUjJ3WkjC94Xt5ZOUyyAqochqKA+S/FzeOAquuwfl5iq4CpRGec
 WRFJWU01Gwelgwld192iI1OHdgmWyIVk8RbjytkzLcpoKQs2lf1UnpF2/0LeZPeFzDg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788802039;
 h=X-Greylist:Received-SPF:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=qc3L0xLUv/lYkUXmkoozru40b0Kewh1PPsm8nRO1ZD4=;
 b=j95xKHGG2gLakYeZ3whtRN1yj7kC4eH27Gdcx70IM93X9Us0Py+Eib525c/2T7auGmgi
 HRy4FO9RoyQ5xbUjEx7S8iDkbD1bBUHZkr0Fwdic9j6MMzm3BqiZTSW3/TG5R4xiRz9Us
 y91CpZj6Rn2uLhOtBR4liBpg66jgFTBQ9wTrc7kHMjM8xC5gwic2/thC96yg5Hvctao8y
 lBgZW2Qs9kiroRBOzhqMHRbiel2gluUsa39X3TUlEaorx+zj35Cy+pVhca9bipVphh+t2
 xUFZPR12C9/syBmHmDM1ewpnOV28oqtddr9LzgD0sCbg54JTIlkX57W5CFapLH6rXTQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=infradead.org; 
 dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=bombadil.20210309 header.b=rTDLpUlr; 
 arc=none smtp.remote-ip="2607:7c80:54:3::133"
X-Greylist: delayed 1160 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 07 Sep 2026 17:27:19 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rTDLpUlr
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:3::133;
 helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org;
 receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1593140441
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 17:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=qc3L0xLUv/lYkUXmkoozru40b0Kewh1PPsm8nRO1ZD4=; b=rTDLpUlrNypoqlRiGdfc6rSdrD
 7LMWqUrifhoBnTBkTzyguZFMXg4SZNtEBOdrWhgb1kARZGfyeisRwe3vCycBxDHupw2RyaWP2N8/Q
 VyU731ksk/MEbR4l0f43b7Y/taRTNzRrP1tVpEJgWfw548UFtPFEUuF+CjudzOu6sAN/o6KmMzIp+
 QFdsTZiGTySzpyKIY4yJ9XaIpbvSnRluuD0uG55oxPI3lK2bu7AVyXncklODhy/ho4qHkVHM87weO
 Hn19XFG75rCZSP2kNXfK5pfIzbmS1epLZajgUXCYmm4e0AVL+mJsegz47JMQ9AAj3iGe3riRyyQbo
 tpUe3XQQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1x3d7j-00000007UPc-3zwW; Mon, 07 Sep 2026 17:27:15 +0000
Message-ID: <45869dba-955b-425c-88b5-a9793ab2717a@infradead.org>
Date: Mon, 7 Sep 2026 10:27:14 -0700
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

Hi,

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

How did you choose iwl-next as the target tree?

The closest match to that in the MAINTAINERS file is this:
INTEL WIRELESS WIFI LINK (iwlwifi)
M:	Miri Korenblit <miriam.rachel.korenblit@intel.com>
L:	linux-wireless@vger.kernel.org
S:	Supported
W:	https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi
T:	git https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git/
F:	drivers/net/wireless/intel/iwlwifi/

but the patches don't touch any of the Intel wifi drivers.

I expect that you want net-next there, but I could just be confuzed.

thanks.
-- 
~Randy

