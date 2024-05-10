Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E477BC25B10
	for <intel-wired-lan@archiver.kernel.org>; Fri, 10 May 2024 11:03:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 83EA042396;
	Fri, 10 May 2024 11:03:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id edMxI-Z3uquR; Fri, 10 May 2024 11:03:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 72D284238F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1715338981;
	bh=vm4ZmrFjbRrNwHxMB4FO31TpTv5SSe/UL8HKhec7Rf0=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=9ub4LHkQ6iDxup/59RVzqKz1QLtpNhpY9iTkzZpIb2R/nsqJW2MiqWqRAzGEDhJYl
	 3+Xg7tAv2g84xAdwPde0EQrJWNDjBXJpZItEE34Cd5spFEP2Y0tm2/vBH7OLy3fXhi
	 PrcWijQdibZsvDjsG6TMTqs4TT0Viw1QItW/CoAcbfzGXQwNe4eS6k6k5wugr86DPk
	 Ev5DaiQUyvCK7qrmCHDIgi/qoWNwB5lGugo97pFmU3VIsfmEfH5LoAa7JZ04S4Q+B+
	 6/+dIErQ0ohktJCNHCSePQB4uGe4d1n4OWLBzGC8EUHfGRfKzbIaN5v7Ahu8EkYj/f
	 UTIgW4DQ4UbRA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72D284238F;
	Fri, 10 May 2024 11:03:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 468FE1BF35C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 May 2024 11:03:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 312FC4238F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 May 2024 11:03:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YKWLPAXFLBVv for <intel-wired-lan@lists.osuosl.org>;
 Fri, 10 May 2024 11:02:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4313442389
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4313442389
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4313442389
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 May 2024 11:02:59 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 17083611B9;
 Fri, 10 May 2024 11:02:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E49C2BD11;
 Fri, 10 May 2024 11:02:54 +0000 (UTC)
Date: Fri, 10 May 2024 12:02:51 +0100
From: Simon Horman <horms@kernel.org>
To: Hui Wang <hui.wang@canonical.com>
Message-ID: <20240510110251.GB2347895@kernel.org>
References: <20240508120604.233166-1-hui.wang@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508120604.233166-1-hui.wang@canonical.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1715338977;
 bh=7ci1fi03lER3M3a1LyWlHm8KKCSQMYM3V05XcAPPy1A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pjPn21aloWccCKcZ/MWF7bTwo0cjFhTBSQAy3TjoKNpuB2a5UhmyWSGj+zKgc4ldd
 zCgdRikeXXCDgJ6Ww4oj+G132XJ1StDsbebiHCBA1+ThiK5Q7V5I9SYnzb7ahnYktl
 yIOSdyMZqZGQaF4r9ZEd9aNdrSDPJ1QScmR1w5Ky3x/ccIduN2s8lqJXLcuSrTzt2N
 HFFCPi0OJwHIgsPXAiWjehvHtme03XAtr4rkp3E++72jzi13XpMfsOLospcQL9keHX
 FDMnkE7VWzCUA+EjLMqT0MdkToincCpfBLaHjrcipKFV31I8usAdEFRFgaKCk4WxYR
 0yNn0pRhgRs4w==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=pjPn21al
Subject: Re: [Intel-wired-lan] [PATCH v2] e1000e: move force SMBUS near the
 end of enable_ulp function
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
Cc: pabeni@redhat.com, naamax.meir@linux.intel.com, netdev@vger.kernel.org,
 kuba@kernel.org, edumazet@google.com, sasha.neftin@intel.com,
 anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 vitaly.lifshits@intel.com, dima.ruinskiy@intel.com, davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, May 08, 2024 at 08:06:04PM +0800, Hui Wang wrote:
> The commit 861e8086029e ("e1000e: move force SMBUS from enable ulp
> function to avoid PHY loss issue") introduces a regression on
> CH_MTP_I219_LM18 (PCIID: 0x8086550A). Without the referred commit, the
> ethernet works well after suspend and resume, but after applying the
> commit, the ethernet couldn't work anymore after the resume and the
> dmesg shows that the NIC Link changes to 10Mbps (1000Mbps originally):
> [   43.305084] e1000e 0000:00:1f.6 enp0s31f6: NIC Link is Up 10 Mbps Full Duplex, Flow Control: Rx/Tx
> 
> Without the commit, the force SMBUS code will not be executed if
> "return 0" or "goto out" is executed in the enable_ulp(), and in my
> case, the "goto out" is executed since FWSM_FW_VALID is set. But after
> applying the commit, the force SMBUS code will be ran unconditionally.
> 
> Here move the force SMBUS code back to enable_ulp() and put it
> immediate ahead of hw->phy.ops.release(hw), this could allow the
> longest settling time as possible for interface in this function and
> doesn't change the original code logic.
> 
> Fixes: 861e8086029e ("e1000e: move force SMBUS from enable ulp function to avoid PHY loss issue")
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> Acked-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> Tested-by: Naama Meir <naamax.meir@linux.intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> In the v2:
>  Change "this commit" to "the referred commit" in the commit header
>  Fix a potential infinite loop if ret_val is not zero

Reviewed-by: Simon Horman <horms@kernel.org>

