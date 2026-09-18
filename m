Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C0FC982DA
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Sep 2026 15:12:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B5D981240;
	Fri, 18 Sep 2026 15:12:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OOs3OgqvQWxW; Fri, 18 Sep 2026 15:12:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8B6BA81194
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789744342;
	b=QkLrtf/S4Z1bVsoIoVzJ1cI1509q0g4xnsYkJ3u0lYDT54oWyasBCSqp1Vj6xlIxAGGd
	 G411CW37PNmeAj7EUi6qYXzvtm6RzD8BEGYW4pe0kCEGwhXDSTfhWsEHY+CWKLDM6ysuk
	 J3KNKfZ96YIwCM80gsph4jONYwAdoQs27XBVVm+9RsKm8J+/WotSyXkakoKfUJCD8EHoc
	 Hvc55ePXVFh3un9oZDSLyejO2OG74n+/gk/SC0FwqVE8g+S0slMv17B8lUgYI3jzM5nvR
	 vAyXZ+aiPHlzcqt6KGkM1BA25mttEUEUu1NngK6DfDPscurERou1JcfpV2R3tNKQ8wQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789744342;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WpPQDLa8Sx4nTL+45DH3ON+KwEYm1nCt597VX4vcAhI=;
	b=hWDpvgAh+W8Y8K4bynxxNfnXg84vrTOBQi1iKCA7+fXSK7095xK7BUU4d8BiKNSZ4FoD
	 njo7rK+mpOQE8RIa9CoWb5htrABhaH52GlB1NVZDV1gWujN7FgcBdNJm7gO4ovqgXr9UC
	 Ik281Kzs/S2x5VNxzI2Z+bAH5B1WWPjvSuys3Q05Gw89IotTONkh19UspeLjyfqaf34op
	 ceJ1qzJ+kFTmsZeyyMD+W6kgvdjNX2LPWRLLBvHk+OU/FjJ3kuAX7+K6Jej0BS8ASjqj3
	 f57VFg2DGrW45/tR85DqxB42hLURoos34DzznwRgwPHi1YxmDJgcBiKIfaMKdFs5EmA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eOgqaXpu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789744342;
	bh=WpPQDLa8Sx4nTL+45DH3ON+KwEYm1nCt597VX4vcAhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I2e0NqXwnJ7DQBgocP1qhIX+Clfc3PFhziUkNUOavvvb68P+MRWq8Eiosi6LAYlVp
	 A6yG+8QMqi/09BVmgo273ow6Lhw+s/IM0gLt40V5ZLBXcopcxMM3/Q38MHMsTFJG/X
	 SGUIq2Vpink5JY+lm60JNLouxBbjXfzQmiVwt2hkESrJUwPiEH76/aPUNpAbEMVYJb
	 RVS5daKnnUMlaPHfoK9fWtkB7ZybSSVPiNxYcvHQDsAChQ5wruVkw/eLWtVpu7qn8B
	 F5rBwT0XzPvYTWsm01CPwLBfSLJq+QUtYHLIEmbMESg40YK3us1MVXvysxsjxDhVXe
	 Er30o1wZPCdnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B6BA81194;
	Fri, 18 Sep 2026 15:12:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BC82D13D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 15:12:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ADF3481194
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 15:12:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id brA7936RHVf6 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Sep 2026 15:12:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1B4D181181
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789744340;
 b=Nmbe7sgzmWmHW5nPkH71UhkUFEXrJm/vT04fE4qGfyLaCcbN6/QJWloetKaQ6beG6BCn
 Kav8byFdi0lmEz03BvQdsHQDof/8fSrQi92MATwRzAM0DAmiatX6Y66+2WMdpRobkZmmw
 R1JTPMb67vW2v+9PgVVJhVnlaJS87wBWFU/EnkE+khOPTRJpo9oSYy1/SoBlQLYiTOPCy
 +Pb4uwAR4/7n5YxSPjJenLEXXbLuRHP1FCIVYNfIeXh3q9rDhL/wOHFronCJhcRWCiaXd
 YxIaJVJKAYv5RgpKwDDOZ2Y7UMdl3gYdlQGErBxqFMnXoAHLLz8BkRZ4flcpX2IbNgA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789744340;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=WpPQDLa8Sx4nTL+45DH3ON+KwEYm1nCt597VX4vcAhI=;
 b=r56I6PGxedy54k/NrOF3Zi7dmT5kIRHQNIG9MKl52lAsLEbHrKhzQWBojams9REiteKF
 qWbMoFJDvu65/5HoqrGWrg0D8ExFb4Xt7Vl3da24agFQoe+ZJuxv/Mwky5kJBSnAi2Af4
 oW+tvCTin9gQZB4l/6t36X9XoemKkZYhQMlayebvYCHDPp/vg+sJFCuzlyKx3MXGM69qD
 iQ6R3buEc/sOXUI9VcewUzHFuT70BmC6445oV0OeZ6K5MI0Vrh8dwnZpvDlAoeTewD00Q
 DaSgnbsJQxuC4vxWhTQevSbhG7eEsC0bnP5+OIxgeCoWyrIDMVkAdLUAv5mxRgnHMgA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=eOgqaXpu; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=eOgqaXpu
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1B4D181181
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 15:12:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 79DF14144C;
 Fri, 18 Sep 2026 15:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C6A1F000FF;
 Fri, 18 Sep 2026 15:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789744339;
 bh=WpPQDLa8Sx4nTL+45DH3ON+KwEYm1nCt597VX4vcAhI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=eOgqaXpuTj41ftCt3KrPUfqyvTdxXCP0X7O2eMaNvS0ACAyHPW0QVXjudfHi+AZbN
 ho0CbBfcNaU3Pxu+EbUz+QZHQvvsmywL2KZNqyQZzF5lQALqBNVpkcIKI+jjRLSj9K
 C8Gnr9PcK10DAxSrWMcqm13ufHsH/Qb+4/ZlDDkZB2lN12HS5NYSmcKVYgB3ZD8yYt
 DTD8BAiNYXH1DLqRcZlvCzyaEEAhYkw9APsHWl86hT3a218sB1maRrTIUyvifMQM/V
 qgIsAh5gnSObCXYwCr7TAIlYsjoD71LC75mrwKS4/9ITjiO6eiT5UqPRKs3bkQa8rG
 lcYqflJPZCsHQ==
Date: Fri, 18 Sep 2026 16:12:16 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net v2 2/5] iavf: fix error path in
 iavf_request_misc_irq
Message-ID: <20260918151216.GL51261@horms.kernel.org>
References: <20260915125551.3976068-1-aleksandr.loktionov@intel.com>
 <20260915125551.3976068-3-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915125551.3976068-3-aleksandr.loktionov@intel.com>
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

On Tue, Sep 15, 2026 at 02:55:48PM +0200, Aleksandr Loktionov wrote:
> From: Piotr Gardocki <piotrx.gardocki@intel.com>
> 
> When request_irq() fails the interrupt vector was not registered for
> the driver. Calling free_irq() on a vector that was never successfully
> requested triggers a kernel warning. Drop the erroneous free_irq()
> call from the error path.
> 
> Fixes: 5eae00c57f5e ("i40evf: main driver core")
> Cc: stable@vger.kernel.org
> Signed-off-by: Piotr Gardocki <piotrx.gardocki@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

This feels more like a clean-up than a bug fix.

But regardless, the change itself looks good to me:

Reviewed-by: Simon Horman <horms@kernel.org>

...
