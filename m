Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1308EA7188
	for <intel-wired-lan@archiver.kernel.org>; Sun, 19 Apr 2026 04:55:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4065C81EA3;
	Sun, 19 Apr 2026 04:55:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pE4CBL11uxmj; Sun, 19 Apr 2026 04:55:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5EBB981399
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776574533;
	bh=+miTzbzmAeJTvCc4KYsQeM1c0jUtDrPE4GIVDyvf1jY=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CbYaQpT1MnYmFNwjCoF73QT2owMu8r2TY1JC7eeK/dIxPrt/WjsPthhwsqBVXka9C
	 UQvWk0U+d3ei/2js6l/2NXRkae+S8Xq9mU6l37kz5MtK1AK8VnLt/sZiv3StGerDgt
	 KEEn6zlVxSEMg/i6hiN2k47IEIojr83gIWBRad6ISdmn9YzeuMzPalPzejs306i+AC
	 57BuWs28ZcS5axp0jnVVjoWvobAVoEsoMnfwq00g51uUePbH6C7DmldI1ZG0uwPzCU
	 zzrXZHeH0Jqd4TDFfb9DN/pTKWADTMT56ozw6qSHPD0QiRcQl8qmS+LmaeWJInmLGQ
	 1a/C01kO7Iq8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5EBB981399;
	Sun, 19 Apr 2026 04:55:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 064F22B8
 for <intel-wired-lan@lists.osuosl.org>; Sun, 19 Apr 2026 04:55:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E02C360FA2
 for <intel-wired-lan@lists.osuosl.org>; Sun, 19 Apr 2026 04:55:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id itwjngLu6z4p for <intel-wired-lan@lists.osuosl.org>;
 Sun, 19 Apr 2026 04:55:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=49.212.198.91;
 helo=www2881.sakura.ne.jp; envelope-from=kohei@enjuk.jp; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B88596076D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B88596076D
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B88596076D
 for <intel-wired-lan@lists.osuosl.org>; Sun, 19 Apr 2026 04:55:31 +0000 (UTC)
Received: from x1 (232.154.13.160.dy.iij4u.or.jp [160.13.154.232])
 (authenticated bits=0)
 by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63J4sw77096849
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 19 Apr 2026 13:54:59 +0900 (JST) (envelope-from kohei@enjuk.jp)
Date: Sun, 19 Apr 2026 13:54:57 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, dima.ruinskiy@intel.com,
 kohei.enju@gmail.com
Message-ID: <aeRejyttAu4EO0HW@x1>
References: <20260317062205.39406-1-kohei@enjuk.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260317062205.39406-1-kohei@enjuk.jp>
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 bh=+miTzbzmAeJTvCc4KYsQeM1c0jUtDrPE4GIVDyvf1jY=; 
 c=relaxed/relaxed; d=enjuk.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20251215; t=1776574499; v=1;
 b=jW8akn7lx0SeR4Xr8DtlFzFOUiNqna7GBvGf3ZTAeuOoq/fd1Af+xjsziN0xcavV
 d981jL2tYemcz/Gujawl5SaTI1crHME0d4RRbBs3i4spsDYEMwAG8v9aHF4qL+MH
 N393zTl83fltpAlR9CBDFrY7hWLuzWEK/N+maX3b2r3ZD/FoWf+7lH8C1HtoQQnI
 VwvhTxf/BqwrA3+bOOTrtc/LUcaf5FIzTbKGDXiBO+baTCi7XS9VO88ARtuZo/8n
 o87GiN/W021spC2dG0nGzurGC48Xs7fFhkVkjdiaJFaUhuGt9blBj6PwcMzUfpyQ
 in38zhSL1TTGEKkboA+H/A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=enjuk.jp
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=enjuk.jp header.i=@enjuk.jp header.a=rsa-sha256
 header.s=rs20251215 header.b=jW8akn7l
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 0/2] igc: enable build_skb
 path
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

On 03/17 06:21, Kohei Enju wrote:
> This series enables the build_skb RX path in igc, which is currently not
> enabled in any configuration.
> 
> Patch 1/2 adds missing RX hardware timestamp handling in the build_skb
> path.
> Patch 2/2 enables the build_skb path when XDP is inactive and other
> conditions are met.
> 
> Tested on Intel Corporation Ethernet Controller I226-V (rev 04).
> 
> Changes:
>   v2:
>     - don't insist on reverse christmas tree, reducing net diff in the
>       patch 1/2 (Dima)
>   v1: https://lore.kernel.org/intel-wired-lan/20260307182808.155027-1-kohei@enjuk.jp/
> 
> Kohei Enju (2):
>   igc: set RX hardware timestamps in igc_build_skb()
>   igc: enable build_skb on the non-XDP small-frame RX path

Hi Tony,

Could you drop this series from Intel's queue?

Sashiko pointed out a potential use-after-free when dereferencing RX
hardware timestamps with build_skb enabled, and I believe this concern
is valid.
https://sashiko.dev/#/patchset/20260317062205.39406-1-kohei%40enjuk.jp

I'm working on a new series to address this problem.

Thanks,
Kohei
