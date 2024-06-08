Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691FBC27C55
	for <intel-wired-lan@archiver.kernel.org>; Sat,  8 Jun 2024 12:57:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1005481F78;
	Sat,  8 Jun 2024 12:57:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qrq225pJOODS; Sat,  8 Jun 2024 12:57:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7164A81F85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1717851476;
	bh=RRx7UaWERYl+ZDETnP+rAoAItPQVTLsA11t1xyGGbao=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=jmKRHarGd79JEMwVKDvFVldgbbQo/H2iyICUSPFTyStzisDwruPG/4EZzaMijfanH
	 lKudt4MVD25vv2eYZd2o6nkyuzILs5rXMf4YIUJq/hqjOvmZwQ3LuUVXQF5+B93ZAF
	 +tWvXglBHVVA7gDg1LNELlPrBYJTgbfXi2RHvU39FSCAOjH6tsJxh0yTyIsEzeYn0V
	 jvppSLkCeNDx7k/3BM9Je50+B8J8+m4IXSmrupeJMjvZ3OeuNOug4ld/sKXaGakWA7
	 H6xXzWrJhVc0QVHgS/vJKQfdZwuarU7Mcu/LNnaCD2Gmr/qX0FiI6r24UsdZwURyYD
	 dPF21OLX2gJIg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7164A81F85;
	Sat,  8 Jun 2024 12:57:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id AD1D01BF47E
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Jun 2024 12:57:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A5E64401EB
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Jun 2024 12:57:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DdceDWA-l3JM for <intel-wired-lan@lists.osuosl.org>;
 Sat,  8 Jun 2024 12:57:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=145.40.73.55;
 helo=sin.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9FEC7400D8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9FEC7400D8
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9FEC7400D8
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Jun 2024 12:57:53 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 5B87BCE1EA7;
 Sat,  8 Jun 2024 12:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59EA2C2BD11;
 Sat,  8 Jun 2024 12:57:49 +0000 (UTC)
Date: Sat, 8 Jun 2024 13:57:47 +0100
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Message-ID: <20240608125747.GV27689@kernel.org>
References: <20240604131400.13655-1-mateusz.polchlopek@intel.com>
 <20240604131400.13655-4-mateusz.polchlopek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604131400.13655-4-mateusz.polchlopek@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1717851470;
 bh=udIIL34H/KnoLM4gnyOrsBM8rLUatCzup1YtpQ5MNr8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SyVkMvGSuZWY2B/9ImWjiLF0Rtc0o6IrVxotRo4yjttEEVlE/NCPjOwVTbrTpjBEj
 qbUF7Q1duJO+EzzIrCe1P5KcNqarV9VJrA6g38dcZ8URQOc3DRtx8b2o8XSixEzxWL
 6syLQ6oaZyLIBPLv/ujTPaBM8weMklyKG8jiiC0AdQD9xbwbnA/IeLdNRMwRXcXlmV
 FttuW//YenNdwyt3PDmhAo+FFx5HIeOx64bupY02ETo6P3gJmROJaMq81JTGqkrOFQ
 2JdyUVh4L3RQ6adnwTFS2tRyfwYUqZOyrjTfMb3jeeR7yokU2r5DGN8JKXrrNCxPLC
 3ENJHTJBTsAxA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=SyVkMvGS
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v7 03/12] virtchnl: add
 enumeration for the rxdid format
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
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, intel-wired-lan@lists.osuosl.org,
 Wojciech Drewek <wojciech.drewek@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Jun 04, 2024 at 09:13:51AM -0400, Mateusz Polchlopek wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Support for allowing VF to negotiate the descriptor format requires that
> the VF specify which descriptor format to use when requesting Rx queues.
> The VF is supposed to request the set of supported formats via the new
> VIRTCHNL_OP_GET_SUPPORTED_RXDIDS, and then set one of the supported
> formats in the rxdid field of the virtchnl_rxq_info structure.
> 
> The virtchnl.h header does not provide an enumeration of the format
> values. The existing implementations in the PF directly use the values
> from the DDP package.
> 
> Make the formats explicit by defining an enumeration of the RXDIDs.
> Provide an enumeration for the values as well as the bit positions as
> returned by the supported_rxdids data from the
> VIRTCHNL_OP_GET_SUPPORTED_RXDIDS.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

