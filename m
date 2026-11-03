Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10F9606D834
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=nfXi7n73;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BS+lyWEt
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 81FB780C86;
	Tue,  3 Nov 2026 10:26:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dAWhFEmQUUdF; Tue,  3 Nov 2026 10:26:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E030580DEE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793701567;
	b=FgzS0YKcEekSI2COySNt9gqlkm0Nvpzo1eB11RsT8G6ZRUAZjQt07qteNb65qaSntcFC
	 Isdcxm0VNmZaR+eWGrcmC9RYvWgRjs+Pr1z+q+IS7N4/uIG9D8sHx7hh0C7U5UgztkV8S
	 Y5OG93uf6YDyacFD5+3oq3qXkbY8txJjflwZh481euZU+7y+mWS1Zc4NEuvu/zoIhUbPB
	 BhCUdZiyo6xUlTleU5DTJgQk+XEGMWhJVM4v1b+6P2GDsFKVCE+W8iieb4kubzEzQXN5H
	 xf3BYla+8MXi2p5XE5kPje6pCdHvYUvrSBpuRlFhuAvS0jZNe1DJsjK0VJtF0VmtVMQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793701567;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jGzIIOY4BFl8qf/2SZUl/Z8oABMX8e8gCsMY/rilcXg=;
	b=eejnx2Q1PHxaUWof9fPualLyAB52adIItGnVSjEib6GLKnIjnaXYiPpHV+CI3PQH5Cmc
	 hkxxi1znDUf0G4U09PZqGcVty8gpyqPcGxKBiG1JVaVXthQL9cEsD5tZjdDxVK92OK5/1
	 TXh0PKLN+nHMiEZ41bqKOQdT5IOOvwhMjN4QzR2+RlflMyZyXQrczO29KodhgXL4eLLPi
	 z3crnbVQ2mhxdGsZVEu15bsq9Oy/Ndt9hrJJe6xgcvWJp9SEBHkNQ5+2eAo2ZApkGBYR9
	 m6lEByvRWXFqJ/fx8agTDoUWkbsHUw0cfye3rOeiK4zaRMp0b2OKxxjTDWEPQkD8jEA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793701566;
	bh=jGzIIOY4BFl8qf/2SZUl/Z8oABMX8e8gCsMY/rilcXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nfXi7n73DEPC3566XCTMI+mvpo31u2qyiRxsVp1Y5Rj2bwCMepJlFRPIW8Aaqq9cQ
	 Z4Gf86+lY2/dXELN2zRYgygh3iNMiLG/qB3FwbDlIAq3UR9CtV4JtNA3ZJSM/Rl49q
	 PHRVs63t7RfyzJo0wWNTuG2dlHFe5fzGLCHiBRIOKi5O9i/mv/netb87+9J0t5nj6l
	 SN6MZKN5Eyduxo8O/LxiisKTeoKrgBbL0qorKGJwtc/ebMp0p8dNNJK2NRxujO9h7E
	 EhdlTumcCHi9CZAMmw9k//IKwc4YvCqIQW0z6eFi5A9gQoKoGKuSUPjsNTgB8rR67H
	 1RF4uOB/7GIjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E030580DEE;
	Tue,  3 Nov 2026 10:26:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E788CD3A
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:26:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CD56340514
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:26:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2V-B0BjSilmD for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 10:26:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 18FCD40507
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793701565;
 b=DmNZJgvU2oBLpmu13xCPIvFzJkdYqORSpCheFYYX4R8dnrou41k7NFnrKHrrtBhdPdxX
 I3C7CYtJ3GMOIRGarSVqlsT5hr1OLSXdOpNBCipl2CnrDP09WyTSacW7SNXKeLSsPaFU2
 W6qBB1EBSsCayG2L50dPWf0RKpnPPcBiTkfXsE0GFDpPOsf1fXJDoxVs/mqDfHmp83u4x
 si9UjjqkRluB/Fe13nMGu7MrDwSVwYg3VNIsf4p+u0f/KPilD+sNYT6SOhe2hyGzBJi0v
 oa6FhvEZwL7YGBOJGD3Zjkv3uvOHGVxzoLlaBKOCOULU1EkoP6+ypGaYQnKn7AdsFUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793701565;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=jGzIIOY4BFl8qf/2SZUl/Z8oABMX8e8gCsMY/rilcXg=;
 b=jAvfp8jHACiT+ltCjmEcqLMe16VLy27qk1x72CvK8jAum09GZb8bBlXBREiA8eq28x17
 dszTAU/3qFuCb3GQEaMvcejAZRc6022EZPbeB6mR5GD42KPrCyG+AVEltYim65O4ZJJK9
 MHrxTmGNRJqw6iu6f/FD6vvQ8zhqNZOsfoXi3Og4bR1WOg9rzxWuLqwDdLV8OwRk1Hzb0
 vaLniL3RmY14a6GIgsXLTC/MIom1J765ius/u0jlUn9VUAAQYojGeE38Y2GQnVB7iKjZE
 3JEgFbLWPDmSXVblE4G9lOmQ+NlHm0iMU9dt834jx0Y8OHeRnMjU6jqN2tWiktPqUzw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=BS+lyWEt; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=BS+lyWEt
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 18FCD40507
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:26:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 84079402D9;
 Tue,  3 Nov 2026 10:26:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33231F000C1;
 Tue,  3 Nov 2026 10:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793701564;
 bh=jGzIIOY4BFl8qf/2SZUl/Z8oABMX8e8gCsMY/rilcXg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BS+lyWEt7n3tadznwP0sZc4HKRay2BzPOdE0Q5AvqaoufOqIqXEoZwzRF16B11TRO
 wV0nVN0iKhuBh5tHsygc7PkXR2gW7dRXwIo2XC5Qx1fnu6r6WZqVTSyqADOixZuz2s
 ey97QkjQhig6Q1u0d9pCdFQA7mtsY+sOdyPBIH220aGNgjMb+olYPhRTcd0xol98zk
 CKzZQTwso+YBPDkHIEdA3wSjx7MJ50I34VerHcJPaSq058qipgnlxfDIsZkFbAPD9d
 T4JtkWlCqTJATfeJfgEfC/gtJRvBtqibwfErZU+PKM2+LgqlBcnbzWSruwQNyD86p9
 iGiIVpmjP5RXw==
Date: Tue, 3 Nov 2026 11:26:01 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, stable@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, 
 intel-wired-lan@lists.osuosl.org, Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH] net: ixgbe: drop the SA reference if secpath_set() fails
Message-ID: <20261103-arrogant-competent-jaguarundi-3c9472@quoll>
References: <20261103100534.1310039-1-vulab@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103100534.1310039-1-vulab@iscas.ac.cn>
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Tue, 03 Nov 2026 10:05:34 +0000, Wentao Liang wrote:
> ixgbe_ipsec_rx() takes a reference on the xfrm_state returned by
> ixgbe_ipsec_find_rx_state(). On success that reference is handed over
> to the skb's security path, which releases it when the skb is freed.
> When secpath_set() cannot allocate the extension it returns NULL, but
> the function returns without releasing the xfrm_state, so the SA
> reference is leaked.
> 
> Put the reference before bailing out.
> 
> Fixes: 92103199f10a ("ixgbe: process the Rx ipsec offload")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 



Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email address, thus I doubt that we
   speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document the issue discovery method and what was
or was not tested.

Best regards,
Krzysztof




