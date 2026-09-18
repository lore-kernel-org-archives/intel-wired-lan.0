Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6E1C982DA
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Sep 2026 15:11:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B20A40B65;
	Fri, 18 Sep 2026 15:11:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JesKHDJJZeez; Fri, 18 Sep 2026 15:11:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8273A40B67
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789744292;
	b=AaaKpXagZ+IVrbaFfXHTB2pA/VlAK0PGfR9i1XIfoYhXCKCbh8ap0xYQHwiNQV+zhFe8
	 +ZlIUIo/BDRCEuCuT39og9PVSNInJoJQH9CvLvd5evybN6eUXpmajubMeCzsf+18FP5/Q
	 zv+i/8rVMmS3BwgHhOXQ+Ecbfd4TgfXFhjMyO4LMN6KTYc74gNEck2JNEOPIF+hKoz7+E
	 kwIr8c5fEoWGufaeK6rImCdDm6jg3N+SvQKxu6oVodYgjAKIrrexbedn4wfLNOMm0Ujcf
	 pmlmZHTpOJ6/idA7ao2EaTdlN1KZxArnAuo1NLAVI1UD0zBPThcADV2zSlaV4HiIY1A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789744292;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JXiKbnmtcf/cIsTGuRbVQ3ukx8D/M7r7CKQczwX+sKI=;
	b=OioZy6h274R7ES/qssmCoJOV1zloJxE4xIHMszKj8UzkEKwy6C0zuh8cOI3stDf8YMl/
	 N2vgnPvClKYgeAaOCCuB+t9LneTJdf5ab9KEzvttl77sxChTlay3lDXMfDFeGE9j5wt6m
	 owymAIb2CJkaUuOXyiZTwAkcEkk2PGSzuAV1nfwlNFD9FxZ6waUKUfdthew5p3S0+Vk4+
	 rnz5i2NsPCKN+kThJkp/VqV9U2nutF3beScWcGdmpU64kdHykNXtYoqkcWOCvIEMmqa4h
	 lnvhLObtdx8APhcrxfWM76PgbwgqoEiHw0WZ9lshcHodTZWTeFv19m2XyeYdMTe9LOA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789744292;
	bh=JXiKbnmtcf/cIsTGuRbVQ3ukx8D/M7r7CKQczwX+sKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hBLyI9glHGwYHBRBg5tlwvQYGPxZpY2p4IvjXlMvdQEEZy8eZJysCpA+Y8XvVF+lU
	 noYxJPts5bUvrRIMZx4zT/Y+AkcyDxfKIoUxH+lQdEfc1F39WmAD7Y7SfBJrXprLIq
	 0EqUmqN4LhJSRNkuWOIDTizzhU7QIwb4Zx5BEOsXRtA75fGLQruNKAbLIpfqqmsGAS
	 sr9sdVGR6W/vlM7I1Q+Z+QpI6nPxRgIaWFIEgKKUAsADCEkg1x+2IKSMWbYWWRACO0
	 fcSblskn437LiR8ZccY0WYBn5TxFhiP2CVZC5x0OaV0BGwObLVDtpjjBZzJBYuUtiZ
	 Ly1IxfX4h9fYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8273A40B67;
	Fri, 18 Sep 2026 15:11:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 544ED13D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 15:11:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E180C812F6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 15:11:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qo3gORviqQvP for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Sep 2026 15:11:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 56402812ED
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789744290;
 b=VdtoG2CLaJPGxTijGdebC7TGcM30N7fiou7rcSQ//seG1k+iDIXZf/mi0Ae49bwMg4gT
 Hi66z5MycSgyKFUC8af+bBOiS9DZWEl4t/SEB7RK/NXtBrKw8nX0nCDX3VE2sX30qVFtu
 0h6uLnV6lsFSmgN+NQ1prWm4La9RyF8gOVM2NroXsX2X6DhtmSA44piYj2+awUCbXZMrn
 LKi3hF17nMyEAAbFl/usQQHkyLpQKmeMRkJwRZ4JeAixH99fUKqo/6WjQtOo2Eiv8LL74
 kv/my59xV+IuGSQsxu3QB+/CEKHs0Ua4tlf2Kv8mxCXYRNFH7Mb9X7Pj0LLFYtcTgoQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789744290;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=JXiKbnmtcf/cIsTGuRbVQ3ukx8D/M7r7CKQczwX+sKI=;
 b=bOZ1aoSdGe7GHbfl/AlAMNlTbqdyFpZ+97/uP2QzoYri0aKS+rcChi72JKN/sfW+ALqU
 TON98lFasgf0kYxTsd+YpFAxddyCiW6DrZYDml2gEekAFVr32vLFTXbVhYvLuibAWXzGq
 CwB+HiNx8yw75ne6I+D2l+JtiEgwG9Q/laMAPoEuUcKE5poAvqwp7AbeAn/PGBDm55HPD
 3rIzc1xWbc3yny4htaD41PggKtsE+/i9pV/ju+cT3bLAorkbZmm7jNxjyNQ9LJ6WApaMj
 ESu9McppOSlcUe8EAND8wy3+o53En/d1krR2rAIZJEW4MJXNtWIziltoMEZwdOmGErQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WNsGfBKg; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WNsGfBKg
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 56402812ED
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 15:11:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 66B06412E3;
 Fri, 18 Sep 2026 15:11:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA7A1F000FF;
 Fri, 18 Sep 2026 15:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789744289;
 bh=JXiKbnmtcf/cIsTGuRbVQ3ukx8D/M7r7CKQczwX+sKI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=WNsGfBKgoz1ORupGnkyLLjQwPWP/k8VyZna4EIDHVqVcxJ4yOxlAS9n6ATTAnKHxA
 5uKLFazgTKPN5GruN1JqC+6p+cgE4Wc1mYhKZPafYWe+er9aaYZlL9yxjszct5S2SW
 tE6Bqqtj7DPUQJueRbt5V6mAkOqmnvKW0oeSSgO3sNS2jtlzi2odoWoBCGFLLzwoo9
 hVFFH8QUOWhEKhYxlJH38cpgflZVk32TGZdq2ukUrr1D68quGqockrXCuTE3nu4d/h
 rnILct2jB8BNKKGyxGQDYX7YX9CKdgeSNO3J953dJ1S/G9jC7PElLxaJgE/EnaXCon
 QtQ0dBnBHutRg==
Date: Fri, 18 Sep 2026 16:11:25 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Kiran Patil <kiran.patil@intel.com>
Subject: Re: [PATCH iwl-net v2 1/5] iavf: fix null pointer dereference in
 iavf_detect_recover_hung
Message-ID: <20260918151125.GK51261@horms.kernel.org>
References: <20260915125551.3976068-1-aleksandr.loktionov@intel.com>
 <20260915125551.3976068-2-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915125551.3976068-2-aleksandr.loktionov@intel.com>
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

On Tue, Sep 15, 2026 at 02:55:47PM +0200, Aleksandr Loktionov wrote:
> From: Kiran Patil <kiran.patil@intel.com>
> 
> iavf_watchdog_task() and iavf_reset_task() both run as work items on the
> same ordered adapter->wq, so they can't race with each other. However,
> iavf_set_ringparam() (and other ethtool ops) call iavf_reset_step()
> directly from process context under the netdev instance lock, without
> going through that workqueue at all. iavf_reset_step() can free and
> reallocate adapter->tx_rings and the q_vectors array via
> iavf_reinit_interrupt_scheme() while adapter->state still reads
> __IAVF_RUNNING, so the watchdog task can concurrently call
> iavf_detect_recover_hung() and dereference a NULL q_vector inside
> iavf_force_wb(), or index into a NULL tx_rings array, causing a crash.

I am concerned that iavf_reset_step() is also called from
iavf_set_channels(). And in that case the netdev instance lock is not held.

> 
> Guard against this by:
> - returning early if vsi->back->tx_rings itself is NULL, since
>   num_active_queues can still be nonzero while the array is being
>   reallocated;
> - skipping rings whose q_vector is NULL;
> - reading tx_ring->q_vector once with READ_ONCE() into a local variable
>   and reusing that same value for both the NULL check and the
>   iavf_force_wb() call, instead of re-reading the field right before
>   use, which would leave a window for the concurrent reset to swap it
>   from underneath us in between.
> 
> Also move the tx_ring declaration into the loop body and drop the
> redundant outer NULL initialisation, which the compiler can never
> observe since an array-element address is always non-NULL.
> 
> Fixes: 07d44190a389 ("i40e/i40evf: Detect and recover hung queue scenario")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

...
