Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B84C25B75
	for <intel-wired-lan@archiver.kernel.org>; Fri, 31 May 2024 18:16:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9596B4243D;
	Fri, 31 May 2024 18:16:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DLMZF0CJ5zFc; Fri, 31 May 2024 18:16:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B4F4A42402
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1717179405;
	bh=8bS8XJEbJ9+0H7Wuw/Na+pTKWscsLZPetZFJZ50k6J8=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=PvqdXyLaCVd9Vpx827p03+LQ5gMi59jQBpnIaAQ5mI5UT8KIQBOFKJAB1DWhFaOc4
	 FImrdPWWALA/G/7Siao8+CMiKXS4TGTc1xS7QA/Rl4CmLTjZmu6Tztf2HqaYiFsAvd
	 ITF46sYt6nP1JwXtKovzufXKruUoopVhAXv7Hj+K6IClTsAV3+I6FZwCvQ63okdSLq
	 /Q+HcWGnu5PbGlXGlrif5j+tjs3RM32wVXA4rPWxi1zgQj7blvIFzx/FPJhvGOFaWd
	 H7PRVRMNw3JMeqSxFDYzkEFje9C6xIbwjO1yqMRrOBEUjxCmyP4rC4t2J5fXGjdHYJ
	 e4K/rRECjyE1w==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4F4A42402;
	Fri, 31 May 2024 18:16:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 2486C1BF36D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 May 2024 18:16:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0F61140210
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 May 2024 18:16:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RNA-eAJMSVDr for <intel-wired-lan@lists.osuosl.org>;
 Fri, 31 May 2024 18:16:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 739F4400D1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 739F4400D1
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 739F4400D1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 May 2024 18:16:43 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B7BC861A77;
 Fri, 31 May 2024 18:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFD6C116B1;
 Fri, 31 May 2024 18:16:39 +0000 (UTC)
Date: Fri, 31 May 2024 19:16:37 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Message-ID: <20240531181637.GJ491852@kernel.org>
References: <20240528043813.1342483-1-michal.swiatkowski@linux.intel.com>
 <20240528043813.1342483-8-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528043813.1342483-8-michal.swiatkowski@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1717179402;
 bh=c2AhUU9SBSyXJlvKJgqsryat+Qx3wrELjVaj15yK1E0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aHGj21nE+zlXJptMysLaRE+UNnSkYVMg+J4JtiWMbY5Mthp/Ugd6PdEEA5DYzfh0E
 OEmgg0uLlP7wAyup2wNyiiwxFLUeVlGwQ3bqVnXn2Q/wMlCH8LDG2HGIIFeSHCOEo/
 AAcPJE6C81dWzyxjplre9T+TAYmUESuugfT/hlojXC2IQOWBNtHp7Iv+H2UCkT48aV
 CcQjfZ1ZkMM+Os/Z6MzGAP/dDKUe8+1sFSEm5N3tYBvoN6opSrnjbx0HQQJPt42a8X
 3gKRHTEnmYdCCUaFTfJKxjVl/iTm/a4YUNqyqL8hegtIeHQfAHeLMfOtljOAO9FKyE
 WjyEGLUtmUNOg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=aHGj21nE
Subject: Re: [Intel-wired-lan] [iwl-next v3 07/15] ice: implement netdev for
 subfunction
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
Cc: shayd@nvidia.com, maciej.fijalkowski@intel.com,
 mateusz.polchlopek@intel.com, netdev@vger.kernel.org, jiri@nvidia.com,
 kalesh-anakkur.purayil@broadcom.com, michal.kubiak@intel.com,
 intel-wired-lan@lists.osuosl.org, pio.raczynski@gmail.com,
 sridhar.samudrala@intel.com, jacob.e.keller@intel.com,
 wojciech.drewek@intel.com, przemyslaw.kitszel@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, May 28, 2024 at 06:38:05AM +0200, Michal Swiatkowski wrote:
> From: Piotr Raczynski <piotr.raczynski@intel.com>
> 
> Configure netdevice for subfunction usecase. Mostly it is reusing ops
> from the PF netdevice.
> 
> SF netdev is linked to devlink port registered after SF activation.
> 
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

