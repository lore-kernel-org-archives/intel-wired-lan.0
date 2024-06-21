Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1CBC27C4F
	for <intel-wired-lan@archiver.kernel.org>; Fri, 21 Jun 2024 11:04:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E51061666;
	Fri, 21 Jun 2024 11:04:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KIoYyKVLav95; Fri, 21 Jun 2024 11:04:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9F3A461684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1718967869;
	bh=qTd0yQb3Z/n0/3K7DZhMXpRHaBLqMvTJ+wAnwC7Hm3I=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=AjGs6c6urxN83a594AZLw4Ta0FMwv2v5ZI6WU+kJ8V+ePi4HuywnLWrDJDNjZ8Uq3
	 ur/2sVz+ysbrCA+kHylTUMGxfATsw5PLndIc2jq0Pxq6+ktahzCQSRrZmfDryAxDjp
	 HubuE3zEuqN24etHWqo8Rrr7aPQAdPNi6K5X4l51YtC/mfQ77xli+4r+hQOBAns9c7
	 O76DySJYCP9F6QO4U25ThLuwN1jiPAJBTNFzKFGEY9xwGEBCytbFo9J1kWyvpjHTyY
	 AESoRGy1d5Ss3kE2s/ax9iLFssekCVJOtY/Ron2hWV3Oup0upxPfxXnVKaYvsJDkYw
	 KpSRs1XfcEYxw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F3A461684;
	Fri, 21 Jun 2024 11:04:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 841BF1BF33B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Jun 2024 11:04:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F8F081068
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Jun 2024 11:04:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1gvs5KX2aqqe for <intel-wired-lan@lists.osuosl.org>;
 Fri, 21 Jun 2024 11:04:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5C8C781067
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C8C781067
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5C8C781067
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Jun 2024 11:04:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 8953DCE2C01;
 Fri, 21 Jun 2024 11:04:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893C6C2BBFC;
 Fri, 21 Jun 2024 11:04:21 +0000 (UTC)
Date: Fri, 21 Jun 2024 12:04:19 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Message-ID: <20240621110419.GA1098275@kernel.org>
References: <20240620123141.1582255-1-karol.kolacinski@intel.com>
 <20240620123141.1582255-4-karol.kolacinski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620123141.1582255-4-karol.kolacinski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1718967862;
 bh=S+CGCWOmRP1HnS/TT7MbigFXpa5jS1nfcPciaPTJef8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uVpcLNQRUkb+RhW4FFiB9nrTyYW1tluc1GGn4r0WYXwGq+fvTmyd9iVXGRVfiCgNp
 UtYPi8ecjKl5Cu2jNuxToEKJ5DCHd2LkKz8urwgAstl5c9KdaZG9SJe8KbaKuWi2TH
 /ZLZVCFExXVBKmuqn7NcsR3Q/C5yzrVNj5cC/kvysjHAiSFRqsOMMtDUncPoXhAyxL
 1pOdiDuIi3u2FhX0gWfvwzhL9RkPW5hTrNJ7klG5yF7w2hsofr69ZpacXpwPYiPDXa
 98v6EpSkqcUjUNrFGRfQDgJCdDElR8PgA9Gkpo50Z2okB5x8ROsj8SIq3P7cvkbhKc
 pouRSb7AhFn1Q==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=uVpcLNQR
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-net 3/3] ice: Reject pin
 requests with unsupported flags
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
 przemyslaw.kitszel@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Jun 20, 2024 at 02:27:10PM +0200, Karol Kolacinski wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The driver receives requests for configuring pins via the .enable
> callback of the PTP clock object. These requests come into the driver
> with flags which modify the requested behavior from userspace. Current
> implementation in ice does not reject flags that it doesn't support.
> This causes the driver to incorrectly apply requests with such flags as
> PTP_PEROUT_DUTY_CYCLE, or any future flags added by the kernel which it
> is not yet aware of.
> 
> Fix this by properly validating flags in both ice_ptp_cfg_perout and
> ice_ptp_cfg_extts. Ensure that we check by bit-wise negating supported
> flags rather than just checking and rejecting known un-supported flags.
> This is preferable, as it ensures better compatibility with future
> kernels.
> 
> Fixes: 172db5f91d5f ("ice: add support for auxiliary input/output pins")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
> V1 -> V2: adjusted indentation and added NULL config pointer check

Thanks for the update, this version looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

