Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44B3C9830E
	for <intel-wired-lan@archiver.kernel.org>; Thu, 24 Sep 2026 13:29:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 954D840B03;
	Thu, 24 Sep 2026 13:29:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fV4QzPxo8fRH; Thu, 24 Sep 2026 13:29:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EE99740DBE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790256573;
	b=ks1pf7w+D5jK4FX4xws/pgeqibKIA+U4WinC29sAEXL0IQZ/tkgvGJKODDCBNXn8y6c/
	 fCPcFauBEszv5KapOsGwCe0qyvfco89fc6Ft0Qzn8dXg5K7i+pUZhDCQ05v6w8McMHWSv
	 KfaT0k7JMFziebWyvCPvlwhwfxRJZzq5Tn7lNYoK9B0FeEMUakPFYLuslZtne3DLMTXCJ
	 1rmHq8dJasSx18UTVYlQ893OhmoWhj1dOVe12/i064RECZKvgkL4JIeAEFQI1kdSL7TeT
	 PKayW7AqZtp87Uj69lXn+wuMsDfevu/1/4bPj/64hsngm4DWbQH8jPW2DdfpJqQrqUA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790256573;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=67y9kaimjq2VniwiKCMsp2XrFz2PUat4wCUfkM8Rkeo=;
	b=PmwTUxrnBovIFt65UQMmUPTvwZDetX7l5T3oxYFIV8URmUmkxXH78xjUNCL617YUrej1
	 0DpWcI5ajiyR7YPyymB7lCcBJemgxbhdpiNOEAEDoPyf6a8goAaitOYYhLgg+b6rDRaBu
	 qkzF7VqEjvfYDPjI3c87d5qEIyQ9TRXAsfpiSFtbt2RoF2SFLPgXHRcKNTSjP5up1vv5K
	 Tvfhbq9o+YzCz5cjRaX6468Y7IErJSpZmY4iMP1sV71tB+u9bnF14uBaylYb1Byw1d/uR
	 N3g11+v8iavQr7w1NNgJD1yX/sZAFMhVvG5lWtAH/kho2aHgE4TLEyi7vpyHm+W5UeQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790256573;
	bh=67y9kaimjq2VniwiKCMsp2XrFz2PUat4wCUfkM8Rkeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=24dAFSB+PB0FRsNJoZtX5hlZc9S0o5ZzB8u6heHj/+EUaW2rW6LJbuOMWiHaN72RB
	 4zSj6BsaXtkliKEOVmmoz5bQiFaUD47LoLT3dh1qHyaIfimszuhC2M+EnUQX2pZmzE
	 s8iMYsc5b47fAylkKjPKkZsOgcViiPOPGCCugNRTSJ5qCxKuwQ7SBwPdDhQuuY/G54
	 r62orEbDMtYNcNKjQJIvi5FWqx/4mSojzgnkRXWZsMrZJxtcQuWO7uBmkYrZ/EX8b9
	 +Jh1ePgWyGvyLeice3bjzQfpbuEAUytrDQrRZJ6KiWdVtjO/mIT+Fbb7fpQrFeNJ3Z
	 y9S/N6kqQlUPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE99740DBE;
	Thu, 24 Sep 2026 13:29:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C3D1713B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 13:29:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B54D381B8A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 13:29:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FXBDINp9cy7d for <intel-wired-lan@lists.osuosl.org>;
 Thu, 24 Sep 2026 13:29:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2169181AEA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790256571;
 b=ZSPGRZC781AzhY4Vi2fBCMhJjTp7jPoOFuzJMnHikgPTXvnWoPxbVSqwP/4+dl/h+q6C
 xS1PJUBFDZ0aSg7XjdxQlN+06xt46wWqLNKTm0N+zwWJN7l063myn0KSX48N73m2/MQeC
 wP2/C9EkKMO/5n1dxz07c3A03oNX2e5wFFejWz6ExCWfCxyfCzEeFWKyLuSVjs6FP+LyU
 jP3TdWd/zIywDUaZ8pfKfXHelQd/tuvs1HmB5GHn6fBjuy3f8k9JKs7qQ6uUw60lxlb0y
 atREypxRcHxA7OUGsDKkDZxT9oU4SLXQ124lTznrG0lGUyUmRzsbUjD2LpwUjZ2dyUQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790256571;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=67y9kaimjq2VniwiKCMsp2XrFz2PUat4wCUfkM8Rkeo=;
 b=pSg5j4BXICUfIHXcpCqrtJBWaPIvUv1+Nfct9L1ZSmQz3U842wNRg1xv+wWUPn6Jtq6E
 AOt+kSWC+WgFNdNHPVS+s8YGCxBs+NCtXliEtO4Jc1dkyqucWSPUGKb9xN7KMyDhkWrG+
 AQEYsrHsg22gAOfucdH0g+zLX6hiLwQ8G89YB3LCVba5IF2XaYTBNngsAURoocynNiZOa
 ZHQXGSfdkhOBvDSqPY0G7Ibt5jGPM3Yal7/geTjAeua1xkqZ6BQRfjr4Wk+AdVT1pjmxh
 2rNvd71piTGJoMGjs52g7/XUd4r/D/X21fYrlKupCrjjAi0N+4DnAKPTTvH/xB55S5w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Zk1XZmo6; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Zk1XZmo6
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2169181AEA
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 13:29:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1054643971;
 Thu, 24 Sep 2026 13:29:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABABA1F000FF;
 Thu, 24 Sep 2026 13:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790256569;
 bh=67y9kaimjq2VniwiKCMsp2XrFz2PUat4wCUfkM8Rkeo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Zk1XZmo6es6B2zCBtqV6RxhHUZZsHXE6DUuDA5K67pSDuVndyy+xpfJd3mPO3P0dV
 hHkKhUyB9kPa9surDnpm9sCcJKBYd7t2y0O41oktqo90Piwy3UynTdsew7AJjhQ/pE
 1cLgDrGftxtuzSCBbVClWva9S2zN3By8ao8CbL9rgTOhhsb0qVGY6IQ1KjM66SWxET
 d05diY8fZaDyN6dSPS/iJq7p2Eu3Df0gLj+b+Y20Jyb93ePQH/t4dTCnLZddbkTIx4
 mxl+/YwcikHh1Nv3HE09OMo3dl8pVzwUFtCCZwlTr7xGpbwhx101IDyED8mqSDxOCB
 xWPtzjBQ5KMbQ==
Date: Thu, 24 Sep 2026 14:29:25 +0100
From: Simon Horman <horms@kernel.org>
To: Linkui Xiao <xiaolinkui@126.com>
Cc: aleksandr.loktionov@intel.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: Re: [PATCH net v3] i40e: limit the DDP profile count returned by the
 firmware
Message-ID: <20260924132925.GF13925@horms.kernel.org>
References: <20260922091123.506598-1-xiaolinkui@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922091123.506598-1-xiaolinkui@126.com>
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

On Tue, Sep 22, 2026 at 05:11:23PM +0800, Linkui Xiao wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> i40e_aq_get_ddp_list() writes into a I40E_PROFILE_LIST_SIZE buffer, which
> is sized for I40E_MAX_PROFILE_NUM (16) i40e_profile_info entries plus the
> 4 byte p_count header. i40e_ddp_does_profile_exist() and
> i40e_ddp_does_profile_overlap() then loop over profile_list->p_count
> without bounding it, so a firmware reporting more than 16 profiles makes
> both helpers walk past the end of the on-stack buff[] and compare against
> whatever happens to follow it on the stack.
> 
> The same buffer is handed to the firmware as an indirect admin queue
> buffer, and the admin queue code copies all of it into the DMA bounce
> buffer before submitting the command, so its uninitialized contents were
> visible to the device as well.
> 
> Zero initialize buff[] and reject the list when the firmware reports more
> profiles than the buffer can hold, instead of answering from a list that
> was only partially read. Both helpers already report errors to
> i40e_ddp_load(), which aborts the operation.
> 
> Fixes: cdc594e00370 ("i40e: Implement DDP support in i40e driver")
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
> Changes in v3:
> - Zero initialize buff[] in both helpers: the whole buffer is copied into
>   the admin queue DMA bounce buffer and copied back afterwards, so its
>   contents were exposed to the device, and entries the firmware never
>   wrote were compared against. (Sashiko AI review)
> - Reject the list when the firmware reports more profiles than buff[] can
>   hold, instead of silently clamping the scan and then answering from a
>   list that was only partially read. (Sashiko AI review)
> - Dropped the Reviewed-by tag, as the code changed after the review.

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>

