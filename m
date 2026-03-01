Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7004FD006A
	for <intel-wired-lan@archiver.kernel.org>; Sun,  1 Mar 2026 15:19:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80B1660BEA;
	Sun,  1 Mar 2026 15:19:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zdW_8Pm8cn0G; Sun,  1 Mar 2026 15:19:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6C2EE60BCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772378366;
	bh=b58ghfaM4uNUJEa26h7ZdH/Gd9xPEj04Xmb0dVPb63Q=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X1vy0070FtNjxYOEyjZX1z1f6s3lFUc5+4HpI7fok/eedx1jSaAda5xGURRBhME5K
	 fkl5OtM2ZCXRVnmOS/zxq7kJnpGt8WPMAbJA7mckgdmm5uH5271hH0fc751OsMxB2I
	 1bOymT8jUVab8mEhvRymEQVmPd6Wlg8vAZeNzhM/JemelbW/wjwwqf4USj12L+argt
	 UbGY483k2CGRwJTX2+pwJsQ15js6xlomnN58lwXIekfXnhn9XFiqDC49tbCmWze373
	 LBudclmfl0I//FFH1c3rxHEg1xBHh5nIfgGX40aj+Xe60sE8SB2tNgtONGyDyxVrwR
	 0NC+9Pz/xETXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C2EE60BCC;
	Sun,  1 Mar 2026 15:19:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DAD69231
 for <intel-wired-lan@lists.osuosl.org>; Sun,  1 Mar 2026 15:19:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C0456827CE
 for <intel-wired-lan@lists.osuosl.org>; Sun,  1 Mar 2026 15:19:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aa8Gn0iUUl8C for <intel-wired-lan@lists.osuosl.org>;
 Sun,  1 Mar 2026 15:19:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E2E4282796
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E2E4282796
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E2E4282796
 for <intel-wired-lan@lists.osuosl.org>; Sun,  1 Mar 2026 15:19:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1D92E60008;
 Sun,  1 Mar 2026 15:19:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58C5C116C6;
 Sun,  1 Mar 2026 15:19:18 +0000 (UTC)
From: Simon Horman <horms@kernel.org>
To: ynorov@nvidia.com
Cc: Simon Horman <horms@kernel.org>, intel-wired-lan@lists.osuosl.org,
 edumazet@google.com, pabeni@redhat.com, anthony.l.nguyen@intel.com,
 akpm@linux-foundation.org, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, david.laight.linux@gmail.com, yury.norov@gmail.com,
 linux@rasmusvillemoes.dk, netdev@vger.kernel.org, davem@davemloft.net,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Sun,  1 Mar 2026 15:19:11 +0000
Message-ID: <20260301151911.461034-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260225000007.255837-2-ynorov@nvidia.com>
References: <20260225000007.255837-2-ynorov@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1772378361;
 bh=hB707/+Ouy6yZ/tsRxs6mF6HK0lnz1ZcYlJIo3R+opo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qABzX0wG9YYwmJGjgyJ1WmDXMAlIE+uA66pUspO3Wah1T/gMpPmVxDqvJ7Q3x49RS
 /zUJ8mExjYuhVD9XCjeiLEIHMzx3uOSz0E4pQsKEzv/YGqAzNnwdslvFvAInep+Hwg
 4HbQo+qaJt3X3hcAa+PefeFJiUT7g8tV5knOeD33lF3inZxr5EiGoU9cfzvb3nwLP3
 H0lOoTEh3KeN3tNNgpmpTzgNE8h72Rm0zCVRinFIZH772xzQkrcindULVCrOffqhgj
 qXSmtTBpB7B9OgxRBCVZQouiinNQj8CzdLTr7X3k9aiiqF6DX/gvCgmgsi+c6e8UbN
 ZUjBmjv4nqBbg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=qABzX0wG
Subject: Re: [Intel-wired-lan] [RESEND,
 1/3] bitmap: introduce bitmap_weighted_xor()
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

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
bitmap: introduce bitmap_weighted_xor()

The function helps to XOR bitmaps and calculate Hamming weight of
the result in one pass.

> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index b0395e4ccf90..5485076bb2d0 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h

[ ... ]

> @@ -352,6 +354,18 @@ unsigned int bitmap_weighted_or(unsigned long *dst, const unsigned long *src1,
>  	}
>  }
>
> +static __always_inline
> +unsigned int bitmap_weighted_xor(unsigned long *dst, const unsigned long *src1,
> +				const unsigned long *src2, unsigned int nbits)
> +{
> +	if (small_const_nbits(nbits)) {
> +		*dst = *src1 ^ *src2;
> +		return hweight_long(*dst & BITMAP_LAST_WORD_MASK(nbits));
> +	} else {
> +		return __bitmap_weighted_xor(dst, src1, src2, nbits);
> +	}
> +}

Should bitmap_weighted_xor() be added to the API documentation block near
the beginning of this header file? The documentation lists bitmap_weighted_or()
at line 48 and bitmap_xor() at line 49. For consistency with the existing
pattern, bitmap_weighted_xor() could be documented similarly to:
"bitmap_weighted_xor(dst, src1, src2, nbits)  *dst = *src1 ^ *src2.
Returns Hamming Weight of dst".

[ ... ]
