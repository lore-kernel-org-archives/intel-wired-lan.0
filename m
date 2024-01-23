Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C97C47258
	for <intel-wired-lan@archiver.kernel.org>; Tue, 23 Jan 2024 16:40:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A4321404B6;
	Tue, 23 Jan 2024 16:40:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A4321404B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1706028013;
	bh=BGIvp4IscK0LSr3K0JeRJFzYnN5fS3aA7zuQKTnZWCc=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=l9RmLkc6OWTkHljj04OBBhAf00sdjeB/V93GoTCK6m0IwnKWXVmNfIMwmkGLSXuCY
	 3XIu62bJItO4FKXF5Nq3OpIR7bY2vTkzJmq43KCM+lhpShVE5K1NkavtJ30wW/Qf07
	 GfeAfL0gD8Lvdbeu+j+Zc0rLK2ylRKCmLCZ6WlAun5/Kcav24B20ZIrnLOzVmjbcrI
	 qKIc+swWb3UqXki1xRDjuMuIZWVvSqU3duRQqkC63WdQnzDl1igAIAvSi/0d4Z+mcZ
	 i0x7hVw/Nsb+SWcfnb7Q5/EDEqNjJvgVQZkuMGLEsMqvw3IrpBgssBvNqmHGJIllgb
	 016PojLgK/vmg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vZc5lJ9FE0Vh; Tue, 23 Jan 2024 16:40:13 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id ABBFF402C3;
	Tue, 23 Jan 2024 16:40:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ABBFF402C3
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 41C131BF3A6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jan 2024 16:40:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2601281B48
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jan 2024 16:40:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2601281B48
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ffJeO5tZvb8q for <intel-wired-lan@lists.osuosl.org>;
 Tue, 23 Jan 2024 16:40:10 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6A36D81ADE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jan 2024 16:40:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6A36D81ADE
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 4A910CE2E02;
 Tue, 23 Jan 2024 16:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B54AC433F1;
 Tue, 23 Jan 2024 16:40:05 +0000 (UTC)
Date: Tue, 23 Jan 2024 16:40:03 +0000
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Message-ID: <20240123164003.GF254773@kernel.org>
References: <20240118174552.2565889-1-karol.kolacinski@intel.com>
 <20240118174552.2565889-3-karol.kolacinski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118174552.2565889-3-karol.kolacinski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1706028007;
 bh=RbtmtZYSYDADDdWeocLTVE5+NrBKegBej5TUanerSfg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oDE5fP4WgkoVYZ4rwd+hPaHNq98G0ick68GU1U0IgQeAMRnjlkZGkJeD7gNiz7SU/
 8JJg38MHREHLV8PXYBIMJGpfGUI/oGWOHfAGXajWkFy+/lwKIAU1bo8jvE5i0zlfpN
 jeKm36MKLbp72nS3khN/Nmwfw/x4OnV3R8MLnUGRolqnti05F9QDVDf2ohHlniKZOU
 0lXw1mPd6DcpAi8c+/03f29TPxETDEkdcRO3jkjTH9DOKu23jfngjjt162xH1EMwf7
 nKoElupQm1vQxJORCd+KzWhT092r1Mnwo5Z5GUeSJBcETjVYJwFf47sbGVtCD+IVWT
 Q1Ev1izcF9Z7g==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=oDE5fP4W
Subject: Re: [Intel-wired-lan] [PATCH v6 iwl-next 2/7] ice: pass reset type
 to PTP reset functions
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

On Thu, Jan 18, 2024 at 06:45:47PM +0100, Karol Kolacinski wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The ice_ptp_prepare_for_reset() and ice_ptp_reset() functions currently
> check the pf->flags ICE_FLAG_PFR_REQ bit to determine if the current
> reset is a PF reset or not.
> 
> This is problematic, because it is possible that a PF reset and a higher
> level reset (CORE reset, GLOBAL reset, EMP reset) are requested
> simultaneously. In that case, the driver performs the highest level
> reset requested. However, the ICE_FLAG_PFR_REQ flag will still be set.
> 
> The main driver reset functions take an enum ice_reset_req indicating
> which reset is actually being performed. Pass this data into the PTP
> functions and rely on this instead of relying on the driver flags.
> 
> This ensures that the PTP code performs the proper level of reset that
> the driver is actually undergoing.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

