Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BE8C4332F
	for <intel-wired-lan@archiver.kernel.org>; Sat,  4 Nov 2023 13:30:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8C6A740127;
	Sat,  4 Nov 2023 13:30:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8C6A740127
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1699104611;
	bh=qbJa/8mqO19C6v+jESezvS6HrI9EDR8TE0yU9IjynPk=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=0fMx8eF1XAifem5CdSZMmrBbJcHXPH/BwGagQzxdPWjyNpCWe2bn+wayLCSQ2t2Uz
	 elS+TF+146xCNwFyTiTVxMftCr1vrN/VwVgpq96Vv7nlG+KM9A7j+CUO/E9N0VYkbm
	 NXO1bwa8nU0apOogKOs0ULklwb4TVceLU913EIhQIpRWGFldcfgbuuRn5IHNEcTv18
	 uOqxA9FLOHMHqaAkS3uK9tMf7t1uuyrgQUCdRE/t3XGPH/NxKmTpYTaZSGaQRGDdYW
	 pUNwvOerGuUooNN0jsM/QqGSu+H5Ted/Sf107aaXLw+f4l5Az6K9dRKr4MHSnZlFT0
	 HCQQjU/RH34sg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K89tkr01_CT9; Sat,  4 Nov 2023 13:30:10 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7D3904090E;
	Sat,  4 Nov 2023 13:30:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7D3904090E
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 7355E1BF30C
 for <intel-wired-lan@lists.osuosl.org>; Sat,  4 Nov 2023 13:30:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4AD3C817A4
 for <intel-wired-lan@lists.osuosl.org>; Sat,  4 Nov 2023 13:30:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4AD3C817A4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hYGiq4CAxkUq for <intel-wired-lan@lists.osuosl.org>;
 Sat,  4 Nov 2023 13:30:08 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BF71681775
 for <intel-wired-lan@lists.osuosl.org>; Sat,  4 Nov 2023 13:30:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BF71681775
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 0E825CE0229;
 Sat,  4 Nov 2023 13:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322F8C433C8;
 Sat,  4 Nov 2023 13:29:55 +0000 (UTC)
Date: Sat, 4 Nov 2023 09:29:47 -0400
From: Simon Horman <horms@kernel.org>
To: Michal Schmidt <mschmidt@redhat.com>
Message-ID: <20231104132947.GC891380@kernel.org>
References: <20231023105953.89368-1-mschmidt@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231023105953.89368-1-mschmidt@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1699104603;
 bh=HfpAese7HNiucJjcRMtNzyEWq/Bw/yqeBhgi075sAv0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d/jkbv8trJ9USolJjhEX4II5rBo0nPFIqmpLykt47y89Z1mnGhh+We1jMv9mt56jV
 D4LDzS+nHV6EO/XRdSwrLDDZuBCDQ4/6idCpsM/n64X98CtwiUSlxThLBdsduINUnG
 nW0E60HQtdQmArGIWPLy5KdKEEn5w4A6FBF8I/tW7o3FjK6tGymXhH+Fh0y+aNd/iY
 F5u61sCoy1E2JaPKpVk6VP4CSZ8FOYtdrmawyjkwJ5MlE5HZc5P3FknX/WbzEcL/f7
 A82NvatnYfWZ/qiU6K3XFFmnXyfd+G3C5I8OXA6K4m9p2YJOL0dVPwt87qI8ULnM4y
 agZscCiZ1FZ1w==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=d/jkbv8t
Subject: Re: [Intel-wired-lan] [PATCH net] ice: lag: in RCU,
 use atomic allocation
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
Cc: Daniel Machon <daniel.machon@microchip.com>, netdev@vger.kernel.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 intel-wired-lan@lists.osuosl.org, Dave Ertman <david.m.ertman@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Oct 23, 2023 at 12:59:53PM +0200, Michal Schmidt wrote:
> Sleeping is not allowed in RCU read-side critical sections.
> Use atomic allocations under rcu_read_lock.
> 
> Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support for SRIOV on bonded interface")
> Fixes: 41ccedf5ca8f ("ice: implement lag netdev event handler")
> Fixes: 3579aa86fb40 ("ice: update reset path for SRIOV LAG support")
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
