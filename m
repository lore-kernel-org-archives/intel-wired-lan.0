Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF20E7E37D
	for <intel-wired-lan@archiver.kernel.org>; Fri,  3 Apr 2026 11:57:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ADFE640F09;
	Fri,  3 Apr 2026 11:57:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mKfuHQBw5q4d; Fri,  3 Apr 2026 11:57:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C069640EF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775217444;
	bh=u/xERvOijy7uTZ/odx6DtJPiqOajXMKgHMrHWCgxZ+A=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=3mz81Bp2QS2TvtAVXQfA5daPUJXLtFog9EmHamIs1O5QXLb5PvVAPt2FAwVeCMEYr
	 chlfWuKXhRZoB/Gj9u7hUpqCTdmPSneRc6jPpRmGmbqU5AFHDz3LgmA++9qkZDG/Rf
	 6w1YZZcCSfvQXoxRwYoHbBiQO4P63b9Jx75i3UrqmklLCFkC0o+hzMnQwned+uIgVR
	 JGVpEFVtsgbHdVUmyYnFmB3MUK/wllO4iW76xmAEKgzVFYGs6yUzBdx5AGnorF6DnP
	 vInLOaUo4/S+FRbDxRIlibdMLz6f08US46xeDroWEp+u9FRBsJQGWut0l4rTswAKYD
	 gO11dQN/bmqCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C069640EF1;
	Fri,  3 Apr 2026 11:57:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F87D2CC
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 11:57:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6CA6181C18
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 11:57:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WhKoxhYuY5IA for <intel-wired-lan@lists.osuosl.org>;
 Fri,  3 Apr 2026 11:57:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C621E81BF5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C621E81BF5
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C621E81BF5
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 11:57:22 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2A52343975;
 Fri,  3 Apr 2026 11:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8BAC4CEF7;
 Fri,  3 Apr 2026 11:57:20 +0000 (UTC)
Date: Fri, 3 Apr 2026 12:57:18 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Message-ID: <20260403115255.GA60103@horms.kernel.org>
References: <20260327072236.129802-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327072236.129802-1-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1775217442;
 bh=VjgFV8db6btXlJMtpaJs6zrS/uJaw/zYgbIK73hXvps=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eBbJLO8IEdoKJxNnlOMVdrMotFMVpBMsS6PHYVY+Ck2Yji9VjL59JSBa7d7rZQTmB
 XsKVpS1GHyu9BcOwiDoTvPSrEJRLlYyhAdoioK3clbFjyIak1L7mGLFYubMHyfnuhN
 UMSU8B4l0jC9RzJOSC1LLk4egMIVAkdlAPsZIF4YJfSo7LTYqbnBMl054qrhddHXJ2
 JaVGQB0hfxOFBsSwBq1wIbFdACbzF0Z5Fr6MCAjA+Ru2t1qUABukP18Pm1fvdtCJuW
 fec+B/ls6K8R/G20oNpmEEhKIxIFn4qFQ+DaSpUy+Dn+b+NPdswf/356zdtnR0R1YY
 9Y3GUw5ZVDVuw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=eBbJLO8I
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: fix FDIR CTRL VSI
 resource leak in ice_reset_all_vfs()
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

On Fri, Mar 27, 2026 at 08:22:32AM +0100, Aleksandr Loktionov wrote:
> From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> 
> Resetting all VFs causes resource leak on VFs with FDIR filters
> enabled as CTRL VSIs are only invalidated and not freed. Fix by using
> ice_vf_ctrl_vsi_release() instead of ice_vf_ctrl_invalidate_vsi() which
> aligns behavior with the ice_reset_vf() function.
> 
> Reproduction:
>   echo 1 > /sys/class/net/$pf/device/sriov_numvfs
>   ethtool -N $vf flow-type ether proto 0x9000 action 0
>   echo 1 > /sys/class/net/$pf/device/reset
> 
> Fixes: da62c5ff9dcd ("ice: Add support for per VF ctrl VSI enabling")
> Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>
