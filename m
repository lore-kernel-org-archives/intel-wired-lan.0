Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3314C6FD1D
	for <intel-wired-lan@archiver.kernel.org>; Mon, 20 Mar 2023 18:07:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E14060ABB;
	Mon, 20 Mar 2023 18:07:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3E14060ABB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1679335643;
	bh=zdhfo5zaOSa+N6yeQ7tMcnM+fQCfnYhPLVfYmhyxTyQ=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=kyri6f29BZMRegaQfzhYgdliwo9fnZkCML+FFvIXP5CSdps63SE2urNSa8uYPSyRs
	 wUwUuGAi53e6qfUDpVCCZD3PvgqzWyxhk+Rg0TXC96fWBZU6Z9i4DWCYTGky+mR4c+
	 Zc4VAWH6+dd8FAbGVDYRYMNL10zlGq0Qq2ZrI5jxCabw+hHuNZe7fv8wgE/5e7ii0N
	 aTbu5NBGu/LkdakDo69LC8GFXm6b9RtubNiOo9LgWfKjblrYm2c1GqnTAHRBZuwOzr
	 ryM2OSDXpTKSOcSyQq3REJ9quHyyGvxgHl5nxjMAsf+z/xG87Ci/Y27ZQsPrQjTnpn
	 ll3BNEDcoET1g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IYCVfdEVtNbw; Mon, 20 Mar 2023 18:07:22 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6680A60E6F;
	Mon, 20 Mar 2023 18:07:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6680A60E6F
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 117E91BF263
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Mar 2023 18:07:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DDF188141B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Mar 2023 18:07:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DDF188141B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cQHKIObwbwaV for <intel-wired-lan@lists.osuosl.org>;
 Mon, 20 Mar 2023 18:07:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 76D1881413
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 76D1881413
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Mar 2023 18:07:18 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 5EFA9B8105F;
 Mon, 20 Mar 2023 18:07:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2642C4339B;
 Mon, 20 Mar 2023 18:07:13 +0000 (UTC)
Date: Mon, 20 Mar 2023 11:07:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Message-ID: <20230320103103.22488dc7@kernel.org>
In-Reply-To: <20230317200904.3796436-1-anthony.l.nguyen@intel.com>
References: <20230317200904.3796436-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1679335634;
 bh=36zZJaP15lU/DAfQXwCuDp6WzbDW9TdMEQ5YISr/ta0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=TvJFUgOV4+CjcznHX3ztiMjH4e1finCQbN4ubA88P8XpXoh7G1XLJpawCFwIHDJKs
 06gvdS20jkoYFWDEC9N0qg0LbYj+9D6vmHcRxeBLXJ9uqptVnJ4xAL43CX3sVfhyPx
 neCJ3+G5mMfKBJs7Tn/3Hm7aFd75p7D/dT9B+2VFM0SpyoehCghdtpLG3d0CtmKTM0
 WJQqZiQzvHYkOgQzbvbY/KoNCokLIT4I7FSXxVzovEn3Pf6kiVaqBWVeo/4khFUuQm
 HkHEeAZEbjg/LlhuuhFOzNSazc61NOyZD/16dz0v0noC/8kQ/7oLgM09C14nl/FtPB
 bzczjO08Gi0kw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=TvJFUgOV
Subject: Re: [Intel-wired-lan] [PATCH net-next] ixgb: Remove ixgb driver
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 jesse.brandeburg@intel.com, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org, pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

T24gRnJpLCAxNyBNYXIgMjAyMyAxMzowOTowMyAtMDcwMCBUb255IE5ndXllbiB3cm90ZToKPiBU
aGVyZSBhcmUgbGlrZWx5IG5vIHVzZXJzIG9mIHRoaXMgZHJpdmVyIGFzIHRoZSBoYXJkd2FyZSBo
YXMgYmVlbgo+IGRpc2NvbnRpbnVlZCBzaW5jZSAyMDEwLiBSZW1vdmUgdGhlIGRyaXZlciBhbmQg
YWxsIHJlZmVyZW5jZXMgdG8gaXQKPiBpbiBkb2N1bWVudGF0aW9uLgoKVGhhbmsgeW91ISDwn6e5
77iP8J+nue+4jwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpJbnRlbC13aXJlZC1sYW4gbWFpbGluZyBsaXN0CkludGVsLXdpcmVkLWxhbkBvc3Vvc2wub3Jn
Cmh0dHBzOi8vbGlzdHMub3N1b3NsLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLXdpcmVkLWxh
bgo=
