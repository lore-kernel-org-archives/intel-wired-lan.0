Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B66C41535
	for <intel-wired-lan@archiver.kernel.org>; Tue, 19 Dec 2023 11:05:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14E9D40993;
	Tue, 19 Dec 2023 11:05:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 14E9D40993
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1702983944;
	bh=U6hbUct/p7kmFOy9WyDqzofLH30zzvEJl39sLu9Odlk=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=TzNJApUbMATgNvh+mb5sgHumiyv+Qv72ahpojxLybULxXnz6Si9CDpiq/e5e98jfR
	 v2LwE987VGMJUnZEJTQtisAVWweFU5HA2Sbn/ZXBhKkXnrghw4/HNSolayrBAKkIx0
	 lpRv3jnDvBE2EavXPNTP1ZSolUV3HywtmOeO+fTKf6Pgn25R6G8lf9Cu5gAmb1gdUo
	 FkOb/7zqTR/U5hmTaO0dB8COcyA88ylhSc2IPV9q0gh0iJoEb1lZBOAwMFJyvpTtu4
	 MNq6bpHxMbm0q21eOcOy4d3CMw80J1Dqjz48KnGPGVyC6DLLMqj6VKLZ0keBC9FiCL
	 P5RutrUapkWOw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rxhX61rpz_IJ; Tue, 19 Dec 2023 11:05:43 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B7D94093E;
	Tue, 19 Dec 2023 11:05:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0B7D94093E
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id DC5921BF2B4
 for <intel-wired-lan@lists.osuosl.org>; Tue, 19 Dec 2023 11:05:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B7A3C4093E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 19 Dec 2023 11:05:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B7A3C4093E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cv4Xn56h5kQR for <intel-wired-lan@lists.osuosl.org>;
 Tue, 19 Dec 2023 11:05:40 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0EB864091A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 19 Dec 2023 11:05:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0EB864091A
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id C5969B80ED4;
 Tue, 19 Dec 2023 11:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0027CC433C7;
 Tue, 19 Dec 2023 11:05:35 +0000 (UTC)
Date: Tue, 19 Dec 2023 11:05:33 +0000
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Message-ID: <20231219110533.GH811967@kernel.org>
References: <20231218103926.346294-1-jedrzej.jagielski@intel.com>
 <20231218103926.346294-2-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231218103926.346294-2-jedrzej.jagielski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1702983937;
 bh=Xan9OqFnkjXD7ZpmSsIbY/MakraHLHQyHXooQOvJ+VI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UMDxoloAmp6IbL4Ssnizmw1K75UjMC4/XVE5DWuwRrllGiZ6BqcWpmXgpfTCnbyQ5
 w6IjTv3o57bfS0d67TZD3zYjz2rGMFpxjZdRFk1Kqp4r7M5Rejtlm8+RlhdKDlqs27
 qlimxIPBHnRjRtXJCbkQeY0AUy88YAqdyjMUNlT2aa7scc5IFa/g8qywEwUWOvTF4q
 E2zPQKmVDgDMiD6o8QspCWAn5pQ4m/1L1F4u1bycanABvUBbyM82mwKEVynZ97H8S/
 kphfPhHpGIGeC98UDPYoLkzeRs0qLXXtSceMjmDZBlb0lzQ51t1kNhVk7CnIYfmp0G
 M95CfCsnguQVQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=UMDxoloA
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5 1/2] ixgbe: Refactor
 overtemp event handling
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
Cc: anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Dec 18, 2023 at 11:39:25AM +0100, Jedrzej Jagielski wrote:
> Currently ixgbe driver is notified of overheating events
> via internal IXGBE_ERR_OVERTEMP error code.
> 
> Change the approach for handle_lasi() to use freshly introduced
> is_overtemp function parameter which set when such event occurs.
> Change check_overtemp() to bool and return true if overtemp
> event occurs.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v2: change aproach to use additional function parameter to notify when overheat
> v4: change check_overtemp to bool
> v5: adress Simon's comments

Hi Jedrzej,

Thanks for the updates, this version looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
