Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC079606A338
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 10:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=WyAl8Kb2;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NSx5z+Eg
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D8A76060A;
	Tue,  3 Nov 2026 10:25:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r86S3A-w9WpA; Tue,  3 Nov 2026 10:25:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 112FB60611
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793701547;
	b=ac2obuZ9DMOdlsKrVIfwYVC3AraoNAeE5iPpDrGOffOb4Y97JnEPxbN/prZlcIxu/b+V
	 iOiqbFiWmggW2snnlo6HJTOnzxq3fJp9pqgFCXq4hnxf4tQDBI1+Qseg7OwCN8VmDF/EV
	 bvO7+HyPSfwh7faX0lCYCejwHVyPwnY2LxVPzHet4/T6SwnqSsNHPxpO3i/aUFeRsFwZ7
	 gbzLZuTSUESHKB5uWdrybWRyy7vms0XO01Q+QyiIHN4Qnn7oIs1iaQfBLIrdvF3T9TUKW
	 k1lqkk4gWBghnKdJKOOYrHTgY9ucX8e7+RtJ0b1tatfcZ3ji6JVS32I2bbjCzQNkQPA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793701547;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=u2LnnysjiNlnAErgAFylACAxMV+BLUH6+e8OJM6PuFw=;
	b=TW3Vk+LeH+8fLh5imnPMGPWNg5Exfxc0SvXiJIKUOXHLppKd/+Kqb9gMCuxDk13z7fq7
	 w9pudgTj+TkmlcyYcnf6XzZI1GryuhfX4lzfJhJwF74uRKazL6hvW7TZ+AMQSckV+It2b
	 4rDOSjIH4X5iLCdqcjkxYtiiNJmbbnRNGzAUChFGnSUu9A3rNPVinPbZpJ3YQUdV4l+M5
	 mpl6oQk+9m3sLvNSIXEU5AfruEwhL80FSGMN0Dsq8s0UC+ZlqI41DuegwZMVrZhK0qZzK
	 aFg9Id0FKpk22QPCFX8cIb155jjuGWUZSP0HPdzUd4Hmq5fl61lXB653IGUIZPbLpxg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793701547;
	bh=u2LnnysjiNlnAErgAFylACAxMV+BLUH6+e8OJM6PuFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WyAl8Kb2isrvaYClw+CKk/b2qXu6rpLZW1DlD0rkQDYuX/7wEQQCn0jF+Oxr89jAy
	 gsyuYJLHRBZz7kTXxTI+2QnnUsmdRsXU3YcQQtXbgTrJpaI5wXSwdI2Izyz6ULLOpF
	 F6fY/qwCf8WOdlxeYPAPTqJxteQXgBxnHtnK3Y4cnTS1QTOWqCtvbO2szQDTn0jxx1
	 NiMHTDcbRgO8nYnNo7DM9A26al1HP3qsGWQ65qMeLpE0eF6gQLN27n3p2n1veZ+iA7
	 Ggfu8ErDnjwGaere33PcN7kZVMqvYTGUs9Wt2V7TmADQGgvCicS04AREQBZpFLDDDW
	 sLhMLb2cf9CMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 112FB60611;
	Tue,  3 Nov 2026 10:25:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4128BD3A
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:25:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 26D3C80DEE
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:25:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gsSe4LfQ3qhc for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 10:25:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6BEA180C86
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793701545;
 b=aylk8O2JpGC5+KZwjymChsjNm3QvuNes2aCcfzwkD/Ul1yq/XxM+VcXI7BRLQ9YcfRqJ
 W+nj3dBJhkuHV4u4bGIj7KM0fsghEkhdoZ7Xd4CU+OwzH8Nh4h7YnnwHK1H9fyOzVLemt
 b8nDZ9vW/ASdn7grCs4vSxff3P+Z0q5WZjDEIgktLKkHWbwwuDJ52e0MwHdJqHO4TtJsf
 anH6lHW08mFlZJlA0r0okre7Sb4YFe3+OYN/CUB9UARrSMp/s+MPQ8IEwU3p8RWqvbkZ8
 Y5fZKmYVxgcKx2/fwGVtvcZdUTmWYJiGABfp5CwebkWX/Wdao/HnsF3m8SJIPP/c+mA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793701545;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=u2LnnysjiNlnAErgAFylACAxMV+BLUH6+e8OJM6PuFw=;
 b=d7p84F0I6RrmnZv+fy15C0ttBCszoX1Rx6qhW6j2gom9nbs8pZF8yK5imcAVeHzhxv5B
 Z8+xdOgqXcItl8uEbiMP3xQO/6bOKKJykJGM8BEyRz6xKBnkuCFv5Hi+HQ82Z8HGXhCTL
 /v2ILkzPQNu1vcBjcFkzHpOIkYvOwCA3U4uimzJ+fTAk4IXo5lc2O+loHewLB8g4asWoR
 VqVOhx9yPv123ZQkYFJ+7iYITYKIpZcxWmkC01JuMSmVjAIcaLNQ8jtUOsKHB4tw6OlSE
 X8A436VuAxf7SDTFQSXLGgXsEymDWBRsYiac4H+aWFBbFKh1ZLJDvDdz7AABUIDG/oA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=NSx5z+Eg; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=krzk@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=NSx5z+Eg
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6BEA180C86
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:25:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A574543E66;
 Tue,  3 Nov 2026 10:25:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047651F00919;
 Tue,  3 Nov 2026 10:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793701544;
 bh=u2LnnysjiNlnAErgAFylACAxMV+BLUH6+e8OJM6PuFw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NSx5z+EgmJ/vqZbdQdsVGn57b8f6BhRgX4zf7ZogXfqYI/ouOgdCh3Jk/J06tb6wz
 lihMw8dP784rFojOlkRlOi3BeCiwQzV+X2B/qZ3HX3wEYwCJrD5xVbvb6/9Jo0rL3v
 x4hyIa73hXQE2Vbo2pFmEUrCFIcDuzAqg4kFcfHJR5hs5NkgQsS4lvp5JL++ECEnHl
 xLZDjCdkRWXbowhxVnRBMjJm3LbBS8DhZZYPDWK+XyxuUyNNdAU1pfzC8HG83wa3Cp
 n1kmcIchka8DV/BjwQnbK2sZhmPa3Ci3eAdIh4dvfZBJHxlagLe8rPf8M+l71EFyvD
 bMys7mWMgqzrQ==
Date: Tue, 3 Nov 2026 11:25:41 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: stable@vger.kernel.org, Eric Dumazet <edumazet@kernel.org>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH] net: ixgbevf: drop the SA reference if secpath_set() fails
Message-ID: <20261103-esoteric-hyena-of-penetration-223ea3@quoll>
References: <20261103100534.1310071-1-vulab@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103100534.1310071-1-vulab@iscas.ac.cn>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Tue, 03 Nov 2026 10:05:34 +0000, Wentao Liang wrote:
> ixgbevf_ipsec_rx() takes a reference on the xfrm_state returned by
> ixgbevf_ipsec_find_rx_state(). On success that reference is handed over
> to the skb's security path, which releases it when the skb is freed.
> When secpath_set() cannot allocate the extension it returns NULL, but
> the function returns without releasing the xfrm_state, so the SA
> reference is leaked.
> 
> Put the reference before bailing out.
> 
> Fixes: 0062e7cc955e ("ixgbevf: add VF IPsec offload code")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ipsec.c | 4 +++-
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




