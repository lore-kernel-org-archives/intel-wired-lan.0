Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F441C25B75
	for <intel-wired-lan@archiver.kernel.org>; Fri, 31 May 2024 18:17:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34E67423B2;
	Fri, 31 May 2024 18:17:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z5BqadHqdF5T; Fri, 31 May 2024 18:17:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6CF7B42402
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1717179471;
	bh=vpLWcTk3HhGZ7gm1iwwIzA4U8o6PwIRz5v0RH10IDos=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=nwsofGIheZNaD+nDYfKFORXl8rLUFPxxG5Zwf+MW+fKJzItTUmMsQwTZ5QfR2QHxI
	 uYlaLsNGQ3FLkegW5WSL5SVe0YQK+uc0tW0FMoDthmk6XBUjIBz0YAKnUXdMO+5Ehi
	 Aj1k1qW3TNtM+CnqxptvGULOjnujNNjouPirk5L1HlwncjeKnqtu6ckFny58wX45Ts
	 mWo+H6QuGxBwACUA2PY90HCQdWr94Eao0Lh+K6/YI1hmzj9kjTKo3BB2oP58nAHjHJ
	 /xbAIbVGwPrvboEno4Ff5qdDZdDLtC+qaucMc2m7BqotiHmcMGzDdbNDDtRNNjkCMe
	 CbXQfLj8PQviw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CF7B42402;
	Fri, 31 May 2024 18:17:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 16F8B1BF36D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 May 2024 18:17:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0214F40210
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 May 2024 18:17:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qBqWGQTJ2Aui for <intel-wired-lan@lists.osuosl.org>;
 Fri, 31 May 2024 18:17:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=145.40.73.55;
 helo=sin.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 33D2A400D1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 33D2A400D1
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 33D2A400D1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 May 2024 18:17:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id C9C8BCE1B4D;
 Fri, 31 May 2024 18:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243CEC2BD10;
 Fri, 31 May 2024 18:17:42 +0000 (UTC)
Date: Fri, 31 May 2024 19:17:41 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Message-ID: <20240531181741.GN491852@kernel.org>
References: <20240528043813.1342483-1-michal.swiatkowski@linux.intel.com>
 <20240528043813.1342483-12-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528043813.1342483-12-michal.swiatkowski@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1717179466;
 bh=kZalsnTLkULIt/uoTSoEVR5Xcsq+eao/sF0mdh4bSUw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NeiSYwegPxhgwyKi9QkHsyhngUpyoSInWyP+jWgjHPH6dqTs3HnDVqKN9gpgb1xXY
 +r6lo59nFv7IM0Ddv+6nDR8xROVs/ZzJmR3NBAMQurb/oKdBq4D2DMsejfTNElLFqD
 PsaaB3XHgUuctooJBUUK0d/2tISSCDFJuF7Gdhlu0b3OWdSqUGTT+BsHgMR2poSq6g
 Q1VD1lb9KvpGcmhyngLc1dVZ1vkQvkHxAQmncdNywg6WYCot3/JfdSUbPpil1hcofV
 07tXSd39f+I5ILZJBfV/62GhmsgykNsFnUJwWYBYzkENgAn12Nye8I15J5TTf1SDRW
 nNjRwDNJbwLhQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=NeiSYweg
Subject: Re: [Intel-wired-lan] [iwl-next v3 11/15] ice: check if SF is ready
 in ethtool ops
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

On Tue, May 28, 2024 at 06:38:09AM +0200, Michal Swiatkowski wrote:
> Now there is another type of port representor. Correct checking if
> parent device is ready to reflect also new PR type.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

