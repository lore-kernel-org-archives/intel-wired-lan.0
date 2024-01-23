Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC042C47258
	for <intel-wired-lan@archiver.kernel.org>; Tue, 23 Jan 2024 16:48:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 54BD2402C3;
	Tue, 23 Jan 2024 16:48:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 54BD2402C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1706028488;
	bh=zwYoN4OnpprA91xBuaEPvfgZQ11TM8xE/D00v9Thcj4=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=ud1ilqgTB7p7/eaZAa/wpt+CIZ3Xzt/7e2qN5HI0+odjFQ4eg5Wz/Azk6ekb2zDOC
	 zqYJu2inZz6RHukJ72P18wE6FWYjNtQAfAfa7fZMIp1EKb68+gP9h3KYxiIbxF81A1
	 r5Zn/ndvS0NsPIeqvvdlVGPLNxHNzFsN9p1/vs5YOuVq3/k9HJWRQX3R+i/zbvSSBa
	 3L44g5SnYJ6GQrZ5hVphCxTc1dbz10hlsXSD503EPzKD335ZzPFSDmbz+s9ENF/ISK
	 AyQMzYpsiPobOP41Dp8PH6OA1U4OwOyIB5AMY3OVWWFySFFTRNLJIbYvKJZ43Uu82B
	 fLyHOuHP7AAFg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mejueVjfCOWc; Tue, 23 Jan 2024 16:48:07 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 68E19403E5;
	Tue, 23 Jan 2024 16:48:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 68E19403E5
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id C21911BF3A6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jan 2024 16:48:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9979D607E3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jan 2024 16:48:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9979D607E3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xa7fsUStJ0zp for <intel-wired-lan@lists.osuosl.org>;
 Tue, 23 Jan 2024 16:48:05 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 13173607A1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jan 2024 16:48:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 13173607A1
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D2BD161DE3;
 Tue, 23 Jan 2024 16:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203C0C433C7;
 Tue, 23 Jan 2024 16:48:01 +0000 (UTC)
Date: Tue, 23 Jan 2024 16:47:59 +0000
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Message-ID: <20240123164759.GG254773@kernel.org>
References: <20240123105131.2842935-1-karol.kolacinski@intel.com>
 <20240123105131.2842935-2-karol.kolacinski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123105131.2842935-2-karol.kolacinski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1706028483;
 bh=s2MvNDMwQDf6Fks/boYZD731v1ByeIuexIheT6lCcUw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tZnYjD3wm28FB0uRiRR/EZsHVoYUvKbtuKWwbSV5dU9NHnf4oz+ZVuQceGvl6a4Bs
 mu1M6LhEsXNXzJkItEiMAej44VkLiAVMr198cWcrWo8MzXQjnFO2PGL21kxjqzy2sn
 jIXmd3wkTEF62iBbjIDjZUoO5b6Za50/xfyCzYufIEyHixWULyNLxVCznwxFFYFVG1
 WAZF9dc1+ET59kqurJVXUqMQc55lkBsc/ugUwu/3HmmtyrZAPT4OnF5MTlYszo2dCL
 PowXyq33GEWDVEkfI5OaQpI07R6PlEEzO9JuSzvqpmw+iDbvQDOix70FOFEQcTm96N
 9Xr5vp88oxUCg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=tZnYjD3w
Subject: Re: [Intel-wired-lan] [PATCH v7 iwl-next 1/7] ice: introduce PTP
 state machine
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

On Tue, Jan 23, 2024 at 11:51:25AM +0100, Karol Kolacinski wrote:
> Add PTP state machine so that the driver can correctly identify PTP
> state around resets.
> When the driver got information about ungraceful reset, PTP was not
> prepared for reset and it returned error. When this situation occurs,
> prepare PTP before rebuilding its structures.
> 
> Co-authored-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Sorry, I sent this just now for v6, not realising that v7 had been posted.

Reviewed-by: Simon Horman <horms@kernel.org>
