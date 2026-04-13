Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD31F34C52
	for <intel-wired-lan@archiver.kernel.org>; Mon, 13 Apr 2026 13:43:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24FAC8475C;
	Mon, 13 Apr 2026 13:43:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CvvCvyz2fCs4; Mon, 13 Apr 2026 13:43:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5488D846E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776087821;
	bh=JZRbzp28INPhxUNdsYLMyoaBffxpzsTwUo9FanaDUQk=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P/oEFost/ciFp+dJLW8I21S5zt5hMKFrbf7ygGPvAx6i5gEXMOGL5hyd3rMa3rp1S
	 IeIBFAEloNx4R2nDEzh746bORT0uC3Hl/mZ2Erc1DXbjk4r/hJNauUYzwqEdpREcWo
	 Aua0E9nUrY3iYczn/8w2p3c8tB/Z2L0zYZ758Vwndg0NZQyRpo8x87ORJ6DcPXeBh6
	 tHmb2gRSCfDlBMtpJllY5dghAty+t8RN+W3aQxHVhoIcbAOc8toGV6Y5I0dDZECIIg
	 qFdvKRp3tHaGUVlYL/Vwnq72aeZmTI6nHSt+kSrvmmJrxcO1atS3ItTuc3tYLNJuij
	 JpZC7hf1VycpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5488D846E6;
	Mon, 13 Apr 2026 13:43:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 04C87237
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Apr 2026 13:43:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EA7C042325
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Apr 2026 13:43:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QT49qVs4Iuvc for <intel-wired-lan@lists.osuosl.org>;
 Mon, 13 Apr 2026 13:43:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4DC934229C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4DC934229C
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4DC934229C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Apr 2026 13:43:39 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 17A1D6091C;
 Mon, 13 Apr 2026 13:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A04C2BCB4;
 Mon, 13 Apr 2026 13:43:36 +0000 (UTC)
Date: Mon, 13 Apr 2026 14:43:34 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org
Message-ID: <20260413134334.GP469338@kernel.org>
References: <20260408131154.2661818-1-aleksandr.loktionov@intel.com>
 <20260408131154.2661818-7-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408131154.2661818-7-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1776087817;
 bh=ZFAMrSY8jw7Ij+knpPaJsB0Cm3Po6aQaaQ3IiLfQUog=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oUoG8juz+ZV1bFSwY92yONhOy4d/ti0+M/1zb31HvLm6g16/O1wIDHFZiCIG2VG0Y
 /us+KqUkPoMCCHTTPVYI7Xxay43OefA5cRgFJLG/PEHil7xCbvu6fM3z1trgq2I3pe
 LEXfALQd5ZOqRMYrdZmuGsaNqGl2XMGuYJKLapES5rLxWmCkAk3egTZam5mSCilxcA
 8uexhE7jAF0Z/46Y22oiKXROxwL8OF2CBtELixs11prlorUcgZcZuqeQ6sDg0Ol1Ac
 ZB0srmiOvhhpxkFFV0YlpajtzdjW3A2bXRzu2T5ad392Kp0chl4c7VNI8zjuOfnBmi
 lK3BHjwEuDYhg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=oUoG8juz
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2 6/6] ixgbe: fix integer
 overflow and wrong bit position in ixgbe_validate_rtr()
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

On Wed, Apr 08, 2026 at 03:11:54PM +0200, Aleksandr Loktionov wrote:
> Two bugs in the same loop in ixgbe_validate_rtr():
> 
> 1. The 3-bit traffic-class field was extracted by shifting a u32 and
>    assigning the result directly to a u8.  For user priority 0 this is
>    harmless; for UP[5..7] the shift leaves bits [15..21] in the u32
>    which are then silently truncated when stored in u8.  Mask with
>    IXGBE_RTRUP2TC_UP_MASK before the assignment so only the intended
>    3 bits are kept.
> 
> 2. When clearing an out-of-bounds entry the mask was always shifted by
>    the fixed constant IXGBE_RTRUP2TC_UP_SHIFT (== 3), regardless of
>    which loop iteration was being processed.  This means only UP1 (bit
>    position 3) was ever cleared; UP0,2..7 (positions 0, 6, 9, ..., 21)
>    were left unreset, so invalid TC mappings persisted in hardware and
>    could mis-steer received packets to the wrong traffic class.
>    Use i * IXGBE_RTRUP2TC_UP_SHIFT to target the correct 3-bit field
>    for each iteration.
> 
> Swap the operand order in the mask expression to place the constant
> on the right per kernel coding style (noted by David Laight).
> 
> Fixes: e7589eab9291 ("ixgbe: consolidate, setup for multiple traffic classes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v1 -> v2:
>  - Add Fixes: tag; reroute to iwl-net (wrong bit positions cause packet
>    mis-steering); swap to (reg >> ...) & MASK operand order per David
>    Laight.

Reviewed-by: Simon Horman <horms@kernel.org>

