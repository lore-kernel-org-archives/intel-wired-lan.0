Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CD6C982DA
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Sep 2026 15:12:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60D2E40BA5;
	Fri, 18 Sep 2026 15:12:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A1YmBBmqw4ET; Fri, 18 Sep 2026 15:12:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 80C4140B76
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789744369;
	b=Pn77mw/uc8wo925kL1oHfWBz+LHUK9d9qkmXiBVcCzGljeV+fum4W6Ufn/JU8sN6ayCQ
	 TPHw85FtK8aTFdwSju1XQBWtASHX3mJ8KWpv80hWHuaKeU51/msurWFQN3jdmMxUFbZ23
	 BqJjV9qjz295On03t1TKi7myD99wfP8qVVsUp/L3n2qXweQb9w8685MdDP8O/jDD8jmD3
	 du9RzZoL53nS4mY2VuYdyA04GIbHO52P6yxkUe9EsRvtOmn6yvtqlS3vX0n/g7v/Y69mG
	 Y9MArVp2kFR2m51L9k+/OouLB3HA720qd2h2j0CrC5DjcwK2n4D8zo31Quhj98OGkRA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789744369;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BDTa5eGNRHtyidtFIAbfYZfxCv24hJn3EuLA6apZr+A=;
	b=GVLiHIc/zeiEIQp78fXy7IHYLFi4lwAubIOt7YwcSgx88q6XH5FOaLtQIGLrj9o3v7X2
	 bmNHbIczo4CDCCh05SEp2BQAPDXi/rHgSIfDydys10xYBJb1HXsjgW1d0I0MgHimw/fEC
	 CZH9IJ4k0Q+QZkF/5Q1m7fKV44QEHSFv5h96ps1Ef7Gu6b/Fwn7OyjKSgnrGbVc4d0ShY
	 R+Po3ZVeQN4Iu36w1NCOI8pr53Gnpxzc0tY9z4QaUMi1Rw/D65m8rn1xdlLJ1L0mnfYXF
	 oBN9dIiMPSXwrmamFJpZwTi5sKI0E2ResnkdGjAIVlbKKzZvN5QrBE9So/fm9gMLH3Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789744369;
	bh=BDTa5eGNRHtyidtFIAbfYZfxCv24hJn3EuLA6apZr+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YdR0mXIVxKjt/OihUNJgo24kRRFnFLygrnXm2lAuaj42QW+fB41H8EroT28m3Jqp+
	 xQCJm0oiGRuEQGjOvuCMIeAiofL3G8TqVw+vt+QIocv5SyPKmDby7vnJFnMIkBZyJc
	 0hzO4MqeMkffCrQjT7HACK9s0g/u8Fne08c9ronbg3AOQc0rfyZ3vPsT0rYWEkUuYS
	 gbl4EmMgh3YCOOkRTvSkz5KImmgtlyY9CO+5tscUyFrmoQipvljDodLopVul+gudZy
	 KAUoWG3bkacgvsMkNeHyvxC4UYSyobuqWJeiOAYSZAxFwhj/SF6AMlpsCNFMwfoC9n
	 bkJAseDvp+HsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80C4140B76;
	Fri, 18 Sep 2026 15:12:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 66A9E13D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 15:12:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6484560D77
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 15:12:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kPxC7CYFGBts for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Sep 2026 15:12:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5BEAF60B54
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789744367;
 b=E8O0Nj4Y18RF36cEmlfy5ydq8QcMFH3UEDvSPyB3dS52nbV49h2x4z4sxhyiRUXIFQOY
 HOld2BN/KrSoP2LdMs6ZGEMLwGsGBZXwI5DBlGMwFgCPH7oHtbDySKhKl+A78da44YHnb
 0mG6MRwXTNP8ToCtvmmS6e7zxI/cO45JtLouGPP4X137DjMwrwrQVku5qfyMO9blA6od1
 YNWbsXIgfEREHT0XtKp9n3/TGsKacclY477x8imMqBqxcvM2XGqSVFoE8ggi7AJa4jkP+
 B151fA9e/WyiUC2semUrffQ9FMhe2D6wndLQ3pNN7JA0B3LU8n6VUawii/rJWgFEzGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789744367;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=BDTa5eGNRHtyidtFIAbfYZfxCv24hJn3EuLA6apZr+A=;
 b=qmfDLN1cWAbtQRKOvVHWg7Y0dzWR9obMXmdH51SQrYUYXKJjC5IcitS2/abASE1sV/9y
 JCGTYTPwIzdQ7FzX3ZyEMpDa9UQRjWr2IrOJ22e6IhdBes3mfYF5TMUL2wI/9iHSXcIzD
 7cm8cnDI8vdO9U/v8PAHvo4hEgB6W1Tmk3awXb7mpUCWZAHtH1onP63nhYcY3vRtHspNz
 /88KZoo0jaQvdSJir50U1tbRC9RlRTF/fb33WsMj7TXKo27uCkrGTUOaGPGFXPVU/+Wj5
 dLoUP0fBSjygTwureL9AhF5KZEcM9WYWald+UG8kzM2YQV2VqA6ioZCLcyIhs6ddLyw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Qpx0ZPZm; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Qpx0ZPZm
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5BEAF60B54
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 15:12:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E12C36022B;
 Fri, 18 Sep 2026 15:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F40E1F00898;
 Fri, 18 Sep 2026 15:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789744365;
 bh=BDTa5eGNRHtyidtFIAbfYZfxCv24hJn3EuLA6apZr+A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Qpx0ZPZmWDyphc2im9c0d6ZzVdP5wUuNmPQdKDAv0Lc6HC2ZtGwGxaT/m6w4y/rNL
 sjIBbfN4zXCWA7g/SMYe45da24D00KX9ovazOSG9UtvH+htUvBrg6gDb/dV09lbTnZ
 TD9FX/6Z+qE8LAsj+Pbk04qlVxQdTQTQnQJVbAxNRQA8tijq1RlRHbeGQC7ii4RVvm
 GfpFNCBRj4IO9414HBFjY+qV8oeUhQOMRaJAsF9Dq1ohgnY/JpAayWl8ObNpO3DHY3
 CWj3iqGqsFiXU3lBd/OCl8zm1Yv57b+BY9y5TKE8rvD2+FUMEimi0msi84w7YZV0Wj
 JxBEh9m4sbUeg==
Date: Fri, 18 Sep 2026 16:12:41 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org,
 Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
Subject: Re: [PATCH iwl-net v2 3/5] iavf: prevent VSI corruption when ring
 params changed during reset
Message-ID: <20260918151241.GM51261@horms.kernel.org>
References: <20260915125551.3976068-1-aleksandr.loktionov@intel.com>
 <20260915125551.3976068-4-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915125551.3976068-4-aleksandr.loktionov@intel.com>
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

On Tue, Sep 15, 2026 at 02:55:49PM +0200, Aleksandr Loktionov wrote:
> From: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> 
> Changing ring parameters via ethtool triggers a VF reset and queue
> reconfiguration. If ethtool is called again before the first reset
> completes, the second reset races with uninitialised queue state and
> can corrupt the VSI resource tree on the PF side.
> 
> Return -EAGAIN from iavf_set_ringparam() when the adapter is already
> resetting or its queues are disabled.
> 
> Fixes: fbb7ddfef253 ("i40evf: core ethtool functionality")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> index 1cd1f3f..3909131 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> @@ -495,6 +495,11 @@ static int iavf_set_ringparam(struct net_device *netdev,
>  	if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
>  		return -EINVAL;
>  
> +	if (adapter->state == __IAVF_RESETTING ||
> +	    (adapter->state == __IAVF_RUNNING &&
> +	     adapter->flags & IAVF_FLAG_QUEUES_DISABLED))
> +		return -EAGAIN;
> +
>  	if (ring->tx_pending > IAVF_MAX_TXD ||
>  	    ring->tx_pending < IAVF_MIN_TXD ||
>  	    ring->rx_pending > IAVF_MAX_RXD ||

I believe I reported this for v1 as well, but AI-generated review reports
a TOCTOU issue here. And I believe a similar, pre-existing, problem also
exists in iavf_set_channels.

Text from
https://sashiko.dev/#/patchset/20260915125551.3976068-1-aleksandr.loktionov%40intel.com
follows:

Could this state check introduce a time-of-check to time-of-use (TOCTOU) race
against the background reset task?

The background iavf_reset_task() relies on netdev_lock() to serialize, but
ethtool callbacks for drivers like iavf (which do not set request_ops_lock =
true) are executed under rtnl_lock() without holding netdev_lock().

Because they do not share a common lock, the background task can acquire
netdev_lock(), change the state to __IAVF_RESETTING, and tear down queues
immediately after iavf_set_ringparam() evaluates this condition to false.

Will this lock mismatch also cause a lockdep splat later in the same function?

iavf_set_ringparam() proceeds to call iavf_reset_step() directly:
drivers/net/ethernet/intel/iavf/iavf_ethtool.c:iavf_set_ringparam() {
...
	if (netif_running(netdev)) {
		adapter->flags |= IAVF_FLAG_RESET_NEEDED;
		iavf_reset_step(adapter);
	}
...
}

Looking at iavf_reset_step(), it asserts that netdev_lock() is held:

drivers/net/ethernet/intel/iavf/iavf_main.c:iavf_reset_step() {
...
	netdev_assert_locked(netdev);
...
}

Executing iavf_reset_step() from the ethtool callback without holding
netdev_lock() would trigger this lockdep assertion, and allow it to
concurrently step on any executing reset task.
