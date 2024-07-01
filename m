Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66271C2BD09
	for <intel-wired-lan@archiver.kernel.org>; Mon,  1 Jul 2024 07:17:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 300668145A;
	Mon,  1 Jul 2024 07:17:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l68GkiddX9ZK; Mon,  1 Jul 2024 07:17:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9CB8E81772
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1719818222;
	bh=16URafNW8IDGUEwCB1eTs6xV7gkTuxH0IN0/Lk4BzYE=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=hHH3o3jgW6NYBeVur5PpWz9M9+ay/h1/oef5528SfRYjqE+w1kDLDmD67qCpjTkp3
	 6xvFvEoXvR1qI8kRZP3LFFc7fy13PwiL3TE7LCQHXFa6xz6eb/7mLWFC3SQe7x7WGE
	 SGwBleye4/rPM2Y+xZlTLA110+SEUTVtAAwcLkaxYqgzK9yflSl84+QE0glF0fupuT
	 Xm5WTv5+JPeZS0okEeBffCQnkzyQPmghB4GsXSNKYoCG9G8PrhqZSm0S4QDm6YFQEq
	 +gyTRPHq1r5QAqF5WfnzM4MJT9hJmf45ShkQQmasXGgrC6soFbe3EP0wMwe5B/R0Kc
	 kQe/Lkpv0jr/A==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9CB8E81772;
	Mon,  1 Jul 2024 07:17:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 007F21BF340
 for <intel-wired-lan@lists.osuosl.org>; Mon,  1 Jul 2024 07:17:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E1FDD81772
 for <intel-wired-lan@lists.osuosl.org>; Mon,  1 Jul 2024 07:17:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XfNsdC4UNOyb for <intel-wired-lan@lists.osuosl.org>;
 Mon,  1 Jul 2024 07:17:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5C29A8145A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C29A8145A
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5C29A8145A
 for <intel-wired-lan@lists.osuosl.org>; Mon,  1 Jul 2024 07:17:01 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8EDB861152;
 Mon,  1 Jul 2024 07:17:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E0FC32781;
 Mon,  1 Jul 2024 07:16:59 +0000 (UTC)
Date: Mon, 1 Jul 2024 08:16:57 +0100
From: Simon Horman <horms@kernel.org>
To: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Message-ID: <20240701071657.GG17134@kernel.org>
References: <20240626125456.27667-1-sergey.temerkhanov@intel.com>
 <20240626125456.27667-2-sergey.temerkhanov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626125456.27667-2-sergey.temerkhanov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1719818220;
 bh=9cDqavuTSkImX+ZtaQXd+6KkjQZ9VbqXdBMopZkDkBQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZVNZO45Q7dKbdSeH6ynUrvs01H08z4Fg40rLA3Ial7XXpClLTp/CrBU2pFtfPbiY1
 s86cvhHEOleOqr33FWEvbBNGSGtVJKhfSlMeO8IDPaqJgYbt0HWXV0J6Q4z3HyVT3K
 2j1dz+cqvonxjLxYOiAGm37Ibth2CkuXIy2l2T+YZbVIvT5qP+qdHAQbw2FI2KKMbB
 jCU/35MegUS4FoAfwQc3Da0YoY5Snz5anbL4VKY3wsGnx9JzwECDf8MpPSK2TGEWEF
 KHh+yhlv2AllqKxGCwG2wucA6niRw86kHCyUDwi1CrIgbLKIhH+v3AYfSL63+9Dhhb
 SdDic4f7a4xHQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ZVNZO45Q
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 1/4] ice: Introduce
 ice_get_phy_model() wrapper
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
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Jun 26, 2024 at 02:54:53PM +0200, Sergey Temerkhanov wrote:
> Introduce ice_get_phy_model() to improve code readability
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

