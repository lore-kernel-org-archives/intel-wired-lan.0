Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2FCCD343F
	for <intel-wired-lan@archiver.kernel.org>; Thu,  7 May 2026 12:58:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04AC141113;
	Thu,  7 May 2026 12:58:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wToaorwMH269; Thu,  7 May 2026 12:58:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3C8E941110
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778158693;
	bh=76R3vnZ6x747dl29vgm2RvvdX/IZbVFK4/0RUO0M6Yk=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=es5t178gbvDrUnGzoUjeG0vjwUxCvRrolV4h2ZZ2ZvuZ616Uwmd1Dk0PurTlTdrDz
	 9y+5AUHPeUEgkhX1KhKu8BDeKyE6eUK9Tl+DF7iJkW2wqAWnQ21hKyz65LH/AhXcrK
	 coFZueOEyA2aBgIkf9k/RjMALOIIj+KlLRfnuZcm6aBJhUxPa1ZamoDZWQ13IDxtqA
	 dOEmzYUG8FLVgpGV8GF+x1mZEsL1uWDbmiLJYzjSGuh+D8Th9d11CD5+T9C06V+eCi
	 5dKZIKhzvVviOt+oqbX4AhGLx2DplYV0io+k3H7Y0uKpxLioXPYMVRRwsq5PDENAnt
	 sbwkBwCzNnxpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3C8E941110;
	Thu,  7 May 2026 12:58:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D5048280
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 May 2026 12:58:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C6F9541110
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 May 2026 12:58:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MDjz1RFR6SMr for <intel-wired-lan@lists.osuosl.org>;
 Thu,  7 May 2026 12:58:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0ECB741047
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0ECB741047
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0ECB741047
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 May 2026 12:58:10 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F1A6141A31;
 Thu,  7 May 2026 12:58:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6BDC2BCB2;
 Thu,  7 May 2026 12:58:06 +0000 (UTC)
From: Simon Horman <horms@kernel.org>
To: larysa.zaremba@intel.com
Cc: 'Simon Horman' <horms@kernel.org>, intel-wired-lan@lists.osuosl.org,
 jacob.e.keller@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, joshua.a.hay@intel.com,
 willemb@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 aleksandr.loktionov@intel.com, anthony.l.nguyen@intel.com
Date: Thu,  7 May 2026 13:54:32 +0100
Message-ID: <20260507125431.947371-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504144345.293219-1-larysa.zaremba@intel.com>
References: <20260504144345.293219-1-larysa.zaremba@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1778158689;
 bh=WDjhH006pjr7DO1odgRVIbkbsVw1XbJABURX23J9bC8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MC5yDTjVffa9Vy/D/mKcZft6etWRgTFNpxHsSa0fT7lqvB3QMgusLbDCsNCtSg0EB
 gSb87FVTAcrr+15ntAazrE5yIZhnLooOS6iakT9MpNTPWg2hOnaLsrHKltGCh9hRaa
 DCWNCqjrUgPK6WCGspntCMOxg+52vSM5n/ZkQ29NgTeOPBGy+ztBrCWZSxR4PWyyaX
 6ML3pW0OnLGr7//mffaVCCzcdDGx7r4L1FYpZjb8/AaQPYWjnuXlj0cHozXbt2tGNh
 VHMvXJSO50Y9W4H7UjKo1bmNuOZxVgaX08zSw34NhZmdq+2rVa2FlCWEfQxW393Ggz
 2MQlN2Ap+VCyQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=MC5yDTjV
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] idpf: fix RSS LUT memcpy
 size
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

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
idpf: fix RSS LUT memcpy size

This commit increases the memcpy size when retrieving the RSS lookup table
to account for the full buffer size rather than just the number of entries.
It also adjusts the required Rx buffer size check to include the structure
size.

Link: https://sashiko.dev/#/patchset/20260323174052.5355-1-larysa.zaremba%40intel.com?part=8

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index be66f9b2e101c..0fc7c68447f83 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -2915,8 +2915,9 @@ int idpf_send_get_set_rss_lut_msg(struct idpf_adapter *adapter,
>  	if (reply_sz < sizeof(struct virtchnl2_rss_lut))
>  		return -EIO;
>  
> -	lut_buf_size = le16_to_cpu(recv_rl->lut_entries) * sizeof(u32);
> -	if (reply_sz < lut_buf_size)
> +	lut_buf_size = flex_array_size(recv_rl, lut,
> +				       le16_to_cpu(recv_rl->lut_entries));
> +	if (reply_sz < lut_buf_size + sizeof(struct virtchnl2_rss_lut))
>  		return -EIO;

Could this cause an out-of-bounds read if the message size exceeds the
allocated buffer?

Looking at the allocation of recv_rl earlier in this function, it has a
fixed size:

    recv_rl = kzalloc(IDPF_CTLQ_MAX_BUF_LEN, GFP_KERNEL);

If the hardware-controlled recv_rl->lut_entries yields a calculated structure
size larger than IDPF_CTLQ_MAX_BUF_LEN, reply_sz may also exceed
IDPF_CTLQ_MAX_BUF_LEN.

While this check ensures reply_sz is large enough for lut_buf_size, does it
ensure we don't read past the end of the IDPF_CTLQ_MAX_BUF_LEN allocation
during the memcpy?

[ ... ]
> @@ -2933,7 +2934,7 @@ int idpf_send_get_set_rss_lut_msg(struct idpf_adapter *adapter,
>  	}
>  
>  do_memcpy:
> -	memcpy(rss_data->rss_lut, recv_rl->lut, rss_data->rss_lut_size);
> +	memcpy(rss_data->rss_lut, recv_rl->lut, lut_buf_size);

Does this copy skip necessary byte-order conversions?

The hardware response recv_rl->lut contains __le32 (little-endian) values,
but the destination rss_data->rss_lut is an array of host-order u32
integers.

The set path correctly applies cpu_to_le32() to elements before sending
them:

    rl->lut[i] = rxhash_ena ? cpu_to_le32(rss_data->rss_lut[i]) : 0;

On big-endian architectures, copying little-endian bytes directly with
memcpy() will result in byte-swapped queue indices. Does the driver need to
iterate over the entries and convert each using le32_to_cpu() instead?
