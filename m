Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23118C4707C
	for <intel-wired-lan@archiver.kernel.org>; Mon, 15 Jan 2024 10:37:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA3F04167B;
	Mon, 15 Jan 2024 10:37:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AA3F04167B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1705315029;
	bh=twN1HzUMzTS/P8qgkp9L/g/7CYt9eF3sWcOoF69TZn8=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=OeBZ1kiHoIGoUY9Mami0aZrs5JIzn0CDHmvvXryOcNM0/EKtFsjA4g2her80Bbsv9
	 GM1hPw+2sqfJ1DH3UYtV95Xzmhf2tBhg0ftizbTYtnocloih/+WYSPNRsMq7eRHV5c
	 6HKn4UqhS+HGdVd1DEjlerzEyUZoNN7lqvcf1pCPuKpmcRXwPl9LvjRJqLA9USKwSZ
	 O1C/nStRtKBCbMR9lWMFemMDHlyBF5MMJHYytJI5HAddkh/cWswKkUTMl5+sHW71eZ
	 n5Nm6m0GSA0YfFx7NE2Sruj2BvNG41klZ85gAO+MRYhmg4W4+VL5LQIZJO1ZeAA2cD
	 wnJRzuM3avmgg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nTdJF4VKbG2b; Mon, 15 Jan 2024 10:37:09 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id E0C8F4167C;
	Mon, 15 Jan 2024 10:37:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E0C8F4167C
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 1FD621BF41C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 15 Jan 2024 10:37:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EAD1660F4C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 15 Jan 2024 10:37:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EAD1660F4C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U-4u1cksSM8F for <intel-wired-lan@lists.osuosl.org>;
 Mon, 15 Jan 2024 10:37:05 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8EE7860F10
 for <intel-wired-lan@lists.osuosl.org>; Mon, 15 Jan 2024 10:37:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8EE7860F10
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 5143BB80BA1;
 Mon, 15 Jan 2024 10:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F97EC433C7;
 Mon, 15 Jan 2024 10:37:00 +0000 (UTC)
Date: Mon, 15 Jan 2024 10:36:57 +0000
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Message-ID: <20240115103657.GM392144@kernel.org>
References: <20240108124717.1845481-1-karol.kolacinski@intel.com>
 <20240108124717.1845481-4-karol.kolacinski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108124717.1845481-4-karol.kolacinski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1705315021;
 bh=AlH6m7R+pm2ANeZNg+yynW5ldbUyIDy0PRzHaQ7Crjw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JthXMycCwnQoGXYaQeJSQ30+M/hffZh9vt3N41WuJWUUkEFSgFOT7PTyIYLbRlgJ0
 VYRWtKjG3boPbR2OyMb5JGdGkMoPGpxafGwjZ0cZJRbVYPwXkF67q8t6W8aQQ8np1l
 lsJgBKAYeUt1JvgtT2PpTGdowKdsHTYsYXbUsLMFMhZUcEuJkNi6aAIGUqGYilJ22T
 i64bYnHXcj8Yln7aP06wd/6DKjAJviXVP+UKoFJOYqBKnyLmF5ghwf1mhAyi6aGbHV
 gIDKVSNEEWcWDN5/UDt5w/Pprhgs6QY/TQchReb8aojIkNq0h/C/NTnAiFDtLkovvj
 6bMCOIcw7saBw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=JthXMycC
Subject: Re: [Intel-wired-lan] [PATCH v5 iwl-next 3/6] ice: rename
 verify_cached to has_ready_bitmap
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
Cc: Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 jesse.brandeburg@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Jan 08, 2024 at 01:47:14PM +0100, Karol Kolacinski wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The tx->verify_cached flag is used to inform the Tx timestamp tracking
> code whether it needs to verify the cached Tx timestamp value against
> a previous captured value. This is necessary on E810 hardware which does
> not have a Tx timestamp ready bitmap.
> 
> In addition, we currently rely on the fact that the
> ice_get_phy_tx_tstamp_ready() function returns all 1s for E810 hardware.
> Instead of introducing a brand new flag, rename and verify_cached to
> has_ready_bitmap, inverting the relevant checks.

From the above I understand what this patch does.
But not why this change is desirable.
I think it would be useful to state that.

Also, perhaps it just me, but it seems that
renaming verify_cached and weeding out assumptions
about the return value of ice_get_phy_tx_tstamp_ready()
are separate, albeit related changes:
I might have gone for two patches instead of one.

> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

...
