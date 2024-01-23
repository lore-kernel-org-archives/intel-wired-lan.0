Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E2FC47258
	for <intel-wired-lan@archiver.kernel.org>; Tue, 23 Jan 2024 16:52:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5A570402C3;
	Tue, 23 Jan 2024 16:52:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5A570402C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1706028730;
	bh=fKkPXYL3FNnhn+hL1f0oBESt/lxKyO/aJg0yusUvHpQ=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=mxZ3wgAvzWdkGNKuwf3dYjLae/6egk4U8cuDQgl3byqHY77jexQXFlSOBu4xvj3FJ
	 q6wzuGU2mzNPT8D9NQJE7LCsE1NsVlVGCAhfcvjAQ/riujmWykWplc1ToiKnuWQW7n
	 8xtubp0kxBUtg4NJKJuKPJk+7gQ6FfGDu5K++PKZxWlghCS3I1W18mQX+XAtz6J4Ly
	 TZR6JKFWb7cjGPFxubNP0vTLJFjWWuDGwOR7tNUc1EqfXu1zsRQMVc+DdlIwZcqm3G
	 wLCXXpJxvkUxFdk7VOXMCcMU1eWklhD7KaHPRQaVa0nuWVUB/JCs4eP4oVQQk5xTFM
	 FFpJdbS27NkVg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A7Fgo179IXg2; Tue, 23 Jan 2024 16:52:09 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3CC05403E5;
	Tue, 23 Jan 2024 16:52:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3CC05403E5
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 0AD6B1BF3A6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jan 2024 16:52:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D64F4418E6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jan 2024 16:52:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D64F4418E6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QpmLxxGMGi0z for <intel-wired-lan@lists.osuosl.org>;
 Tue, 23 Jan 2024 16:52:07 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 482AF418E8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jan 2024 16:52:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 482AF418E8
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7FE5961E65;
 Tue, 23 Jan 2024 16:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C93C433F1;
 Tue, 23 Jan 2024 16:52:04 +0000 (UTC)
Date: Tue, 23 Jan 2024 16:52:02 +0000
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Message-ID: <20240123165202.GJ254773@kernel.org>
References: <20240123105131.2842935-1-karol.kolacinski@intel.com>
 <20240123105131.2842935-5-karol.kolacinski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123105131.2842935-5-karol.kolacinski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1706028726;
 bh=/XFOUY3sTDjdatmqc3J67Iy1LW8Lxb4uwFo2mgAnqxo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=K9c+ekZYEe+Z5rDBPfYCTslbfEdLlvx0LzFLRD3hAs0T+xFconZOe9k6Lodf1Sj2m
 id1nYStVKBBWQPDFwjzFF2VroeZXAodMN+s1PHHpEeZv49keFkkxNvN+r6anzpiXvl
 33Ftdwq5jf9/zY2bfHXPFc/MdLrhPpbGoP3aLQ7JFvS1DwZlsUjkRowRUU5hFGGxS1
 hllCCImUAnHaiEv41NyAtaF3Kg9kFDBzzTeRV80NLTMKLYtxF3X31QilnSQ6tdd2Du
 KHEKiYsJGpo9mcBoy5tBa8IluYlP3llpxNVHO8oECzfcynrrVhTedOJh78Qbg+FKnZ
 lZHA+nJD+aVPA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=K9c+ekZY
Subject: Re: [Intel-wired-lan] [PATCH v7 iwl-next 4/7] ice: don't check
 has_ready_bitmap in E810 functions
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
 jesse.brandeburg@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Jan 23, 2024 at 11:51:28AM +0100, Karol Kolacinski wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> E810 hardware does not have a Tx timestamp ready bitmap. Don't check
> has_ready_bitmap in E810-specific functions.
> Add has_ready_bitmap check in ice_ptp_process_tx_tstamp() to stop
> relying on the fact that ice_get_phy_tx_tstamp_ready() returns all 1s.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

