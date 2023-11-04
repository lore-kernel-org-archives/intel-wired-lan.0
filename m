Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DDAC4332F
	for <intel-wired-lan@archiver.kernel.org>; Sat,  4 Nov 2023 15:24:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7802B40A54;
	Sat,  4 Nov 2023 15:24:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7802B40A54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1699111444;
	bh=WQ96Lo4oOZio9Oxj5UcxKU4wnZtzknuKHJuNhEUoWig=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=ZbHl/mVRG9bXJsh+kHlwwshCOpSQlExNH0qxHW2dnVvjM6MUQthisT4CJpzSG7umL
	 vQLAyD0Wk7hK5w0eFcAJW14IxWcKgt1XPAdjIsQXbjMPYZ3zmRlOvVYaB9YHJtYdG9
	 bHleTnxgvJffdrkpBbE+OtonHKHGN84zsICVeMrdtsZDQUDLEYxSPPoyqpnHB2E6up
	 T1H58ENADhONBDZVCv7DDgWt/hL99e+TaN0B8TgGot9tSjbsRrArhDGIczCe+3YyhY
	 SiWzMcAar2ZZoJ8aXlG/2hvBvAbZ76zLv668ms5zFdTTC43Lfm9263/7/Rz/fXZi+/
	 C+NrxAWrqxQEg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9Jdmx8WlBHJb; Sat,  4 Nov 2023 15:24:03 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2A432409C8;
	Sat,  4 Nov 2023 15:24:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2A432409C8
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id BDCD61BF584
 for <intel-wired-lan@lists.osuosl.org>; Sat,  4 Nov 2023 15:24:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9534041E78
 for <intel-wired-lan@lists.osuosl.org>; Sat,  4 Nov 2023 15:24:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9534041E78
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ra2_D1NHGC2r for <intel-wired-lan@lists.osuosl.org>;
 Sat,  4 Nov 2023 15:24:00 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4B0BB41E6A
 for <intel-wired-lan@lists.osuosl.org>; Sat,  4 Nov 2023 15:24:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4B0BB41E6A
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 3273EB80A39;
 Sat,  4 Nov 2023 15:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E70AC433C8;
 Sat,  4 Nov 2023 15:23:50 +0000 (UTC)
Date: Sat, 4 Nov 2023 11:23:41 -0400
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Message-ID: <20231104152341.GG891380@kernel.org>
References: <20231103234658.511859-1-jacob.e.keller@intel.com>
 <20231103234658.511859-2-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231103234658.511859-2-jacob.e.keller@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1699111436;
 bh=DkV5ol6LRvxR/zbp5+534rklJBjVe5TEcuyE8neuqcQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GMH+AFjqP8byr8zB/Dv7oDlyMhPwMC/JIXz24p3r9rvIVq+7I2fGQq3DfXXSJNdp9
 m6lgF2Sp0q3h3aOuzmH4NJPCyoiZORb9htvsBFZFSG+kQYjZUjo1mTBxhzKvFMjsDo
 YVdoDRXBU7yMQfV2RGSES6VxU61Iqr33edIetHAvKKZwOzQwlTd4s/pCm3lA4E26Tj
 sKimBe5o51EvBs3e1FnplEDXtBO6Jw6a3jDQWxT9WkhzeVgy9wyAXwT8Lfjwd2LVbi
 DPjCJBr/qpFzboWv8YrAS9IRoKxJ1ihii0mSQZnvvfr9Qo2+QRxjiDu+bJdC8U0Y3l
 Y7ph8B99rlcrQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=GMH+AFjq
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 1/3] ice: remove ptp_tx ring
 parameter flag
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
Cc: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
 Anthony Nguyen <anthony.l.nguyen@intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Nov 03, 2023 at 04:46:56PM -0700, Jacob Keller wrote:
> Before performing a Tx timestamp in ice_stamp(), the driver checks a ptp_tx
> ring variable to see if timestamping is enabled on that ring. This value is
> set for all rings whenever userspace configures Tx timestamping.
> 
> Ostensibly this was done to avoid wasting cycles checking other fields when
> timestamping has not been enabled. However, for Tx timestamps we already
> get an individual per-SKB flag indicating whether userspace wants to
> request a timestamp on that packet. We do not gain much by also having
> a separate flag to check for whether timestamping was enabled.
> 
> In fact, the driver currently fails to restore the field after a PF reset.
> Because of this, if a PF reset occurs, timestamps will be disabled.
> 
> Since this flag doesn't add value in the hotpath, remove it and always
> provide a timestamp if the SKB flag has been set.
> 
> A following change will fix the reset path to properly restore user
> timestamping configuration completely.
> 
> This went unnoticed for some time because one of the most common
> applications using Tx timestamps, ptp4l, will reconfigure the socket as
> part of its fault recovery logic.
> 
> Fixes: ea9b847cda64 ("ice: enable transmit timestamps for E810 devices")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
