Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163D6C4332F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 12 Dec 2023 10:02:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C7C2460B69;
	Tue, 12 Dec 2023 10:02:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C7C2460B69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1702375333;
	bh=aX7xGw0G37PRUob4L1/o+YV6+n6RKKGXZi9SM8exRc8=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Cw0c96OxS9xGILa7QnhMX/OwteVLcNGPRFm0/y3gsxcRVFyxXesbdodKRgZCtDSV/
	 fWkKDCREbc/D3RAU7YAX35sGbtWKRterkq4YO16CPWVwqBvy+E7MklfIj2yVrknRLv
	 cyo3ASJ/yyj0XNVLDop4EyRJ+Ob5zJ7c88Xh3+stVAzrBpLsGN4F8gd9sox2PEHyxv
	 K6k2HLZL4AdVKVwjxw0C+4M3+Ppp5dnB4gaaQ6Xaa8nN64CTHIw9aYVCzjyE7pXt7d
	 uhOed/o63gH7NQtD1eZUNgQa6GzAh+jkWsBajETxznIS+nUjE8wNgldCFV9sSxw/5I
	 E5eQFAnFazm4w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MpvfitFC90qw; Tue, 12 Dec 2023 10:02:13 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id C36D760E13;
	Tue, 12 Dec 2023 10:02:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C36D760E13
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id A0DDA1BF383
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 Dec 2023 10:02:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 86E98817AC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 Dec 2023 10:02:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 86E98817AC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mKSOpN1yrL0W for <intel-wired-lan@lists.osuosl.org>;
 Tue, 12 Dec 2023 10:02:11 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F16A080ACF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 Dec 2023 10:02:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F16A080ACF
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 29ED761774;
 Tue, 12 Dec 2023 10:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89F1C433C8;
 Tue, 12 Dec 2023 10:02:08 +0000 (UTC)
Date: Tue, 12 Dec 2023 10:02:06 +0000
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Message-ID: <20231212100206.GW5817@kernel.org>
References: <20231206192919.3826128-1-grzegorz.nitka@intel.com>
 <20231206192919.3826128-4-grzegorz.nitka@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231206192919.3826128-4-grzegorz.nitka@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1702375329;
 bh=XAmy2BovHe8P4ggR+oAdUOnvdaVfRCZbV3Eb2Hl3vYE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jN5VnVoh82Y9VxLFu6nQ5jKfTM/Ak9HYCZgi8Zce1OPqBxuhv8aVzwbGYhC1/zRIA
 IqC8rXwcf8ckyR9d19PV8sKPkvigPOzqHxsfKMDr0UKVW7gWYKoLyNs+zS1bhbBfhX
 aV6a0BZZz0kAXBur2DLy8zCeKCa8v9j12J42T/QwsJyhyI8bcdg4SzQh+zUYRfMm2E
 IMhWPOY01TqJvwy1wWwivGuWflqn1v4c6Gl0dnXv/z4TTw3Zpjqq6dYVLEs5BtpmYV
 K0/fkTnHQ3i2PhjX+CEOmINW4cqzFUofeHoCA1Ov9Wqm9w/bo94P4Ov//QTSmQg+mM
 VLSKExuHp49qg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=jN5VnVoh
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 3/3] ice: add support for
 3k signing DDP sections for E825C
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
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Dec 06, 2023 at 08:29:19PM +0100, Grzegorz Nitka wrote:
> E825C devices shall support the new signing type of RSA 3K for new DDP
> section (SEGMENT_SIGN_TYPE_RSA3K_E825 (5) - already in the code).
> The driver is responsible to verify the presence of correct signing type.
> Add 3k signinig support for E825C devices based on mac_type:
> ICE_MAC_GENERIC_3K_E825;
> 
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
