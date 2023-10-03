Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C924E7AD58
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Oct 2023 14:34:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1316402EF;
	Tue,  3 Oct 2023 14:34:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B1316402EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1696343696;
	bh=pmUXViCwArGdnNrNHcg5wF1JgJ8IOX1Z9TXCJ4fP5Qk=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=10goGaKuRwQDE2UkmJtFq5zowTwtPls8B0hKF/I6H6d2FH5Fpd28JMDc5SYMi2zrj
	 Z7lXNG/XoBFZM87ohpLWBdzs4NSq1hFrWNL+6TdNzEnhgtpwWVy4tUYF+E9ux4RxtI
	 LZdiR4JVpT3+QC0X4lTqkTgZz1jYWEAH3wgn04530ujvf6D+BtVVbOFNQKKPiN+Zms
	 Ce0+k41UsT//QNgrFOU3KR8c/CddYSgUadS8aeXIBndquzpCl8vcMhZrm9ex2Q4AM/
	 1vfEubH/LPUAqaTnyZwT7gT+6NDMxbvyVrlLN242MiGxnv7cvPIt7Dj0vjSkCzP+wn
	 deu+EB5yPqJsA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id huICYgSYAwlD; Tue,  3 Oct 2023 14:34:55 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id E706640240;
	Tue,  3 Oct 2023 14:34:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E706640240
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id BE79B1BF393
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Oct 2023 14:34:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8F38A401AD
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Oct 2023 14:34:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F38A401AD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7gK-ALGzHJhL for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Oct 2023 14:34:53 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CEA33400FE
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Oct 2023 14:34:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CEA33400FE
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id C9EFCCE1811;
 Tue,  3 Oct 2023 14:34:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A95C433C8;
 Tue,  3 Oct 2023 14:34:46 +0000 (UTC)
Date: Tue, 3 Oct 2023 16:34:44 +0200
From: Simon Horman <horms@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Message-ID: <ZRwmhINftLVQ8EnU@kernel.org>
References: <20231003053110.3872424-1-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231003053110.3872424-1-jesse.brandeburg@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1696343687;
 bh=D3JHpbuUCsOPCV2/Kb8gL0Xp3qFkbADEWPSvE7cDcFQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CsN5Yq+OBWTY57OCo7MXg9a79vV07FR0Zcnz/xaLUM/UwZNKIkQY1q1j9+Fy4j59R
 xWkkVeb5CuVkZZ+1hltxiCElnEXtUonqGJcsLb4zbnekw3nAaR2Eiu+k03P5Ib38/t
 SiAPoFF3f+snBIefeoy9fKh8LpcpKHENGsAYRxdinjp73fWPwzbmUelbceDtkuVAXc
 8eS8eqtIWszZYyc5/ZXkXxLU7eXtM5y9lRHzVH8hpwybchZCpnWUxF3661v0TDY8Q+
 tu01g1zFJ0nxXihMD8oknPEutZTC07dm4qIoIlQsaQMkbbyxwfItG/i7yAdqtOCoHh
 8o4Im3mWwqgDQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=CsN5Yq+O
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] ice: fix over-shifted
 variable
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
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 stable@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Oct 02, 2023 at 10:31:10PM -0700, Jesse Brandeburg wrote:
> Since the introduction of the ice driver the code has been
> double-shifting the RSS enabling field, because the define already has
> shifts in it and can't have the regular pattern of "a << shiftval &
> mask" applied.
> 
> Most places in the code got it right, but one line was still wrong. Fix
> this one location for easy backports to stable. An in-progress patch
> fixes the defines to "standard" and will be applied as part of the
> regular -next process sometime after this one.
> 
> Fixes: d76a60ba7afb ("ice: Add support for VLANs and offloads")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> CC: stable@vger.kernel.org
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
