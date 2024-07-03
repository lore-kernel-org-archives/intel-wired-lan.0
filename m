Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235A1C2BD09
	for <intel-wired-lan@archiver.kernel.org>; Wed,  3 Jul 2024 18:19:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A5C22401ED;
	Wed,  3 Jul 2024 18:19:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zRCFe8JOS8nz; Wed,  3 Jul 2024 18:19:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DF6054052F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1720030792;
	bh=cUrUz0ZfIJK2hE2xZihG0TmZfFOGh0/lLNVQvDMA4F8=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=G0xv/XOrrxxWs5kjfDD/9UcfUX9bm7vzBpxmK+QeD6yE6/sSYlr0xeHmQhy7m/PDs
	 AczTwxlrUwwsXYZMKZFN1Cs1LXA1+9g4M4GJNg1JpFkNfGmjsQk5ccwTellI8RuKWq
	 VjaMa+ecPuC3vCy7lmz/cSvbSgis+32UoeBcnbIBq2ehhXKhGLX7Q0HzKiRKIY+N9n
	 pM6xQlZO+/rjUSkyvd+kx4N5KZ2vWcSF5lCnciMb26rxgX+BlnhB+N7KqZsqFj9gE2
	 CK2yQ5M1wSkZFNPXk1Q9h4M5eTTQOrLOQ/EZYTY+5PM73A0XV02tV1po9efWMXDBbJ
	 gvcJLd0XmDqGg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id DF6054052F;
	Wed,  3 Jul 2024 18:19:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id BFBDB1BF2C7
 for <intel-wired-lan@lists.osuosl.org>; Wed,  3 Jul 2024 18:19:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B785C4198B
 for <intel-wired-lan@lists.osuosl.org>; Wed,  3 Jul 2024 18:19:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 54l46o7NYREO for <intel-wired-lan@lists.osuosl.org>;
 Wed,  3 Jul 2024 18:19:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org DA0484198A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DA0484198A
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DA0484198A
 for <intel-wired-lan@lists.osuosl.org>; Wed,  3 Jul 2024 18:19:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0B3A760C2D;
 Wed,  3 Jul 2024 18:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA0BC2BD10;
 Wed,  3 Jul 2024 18:19:48 +0000 (UTC)
Date: Wed, 3 Jul 2024 19:19:46 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Message-ID: <20240703181946.GJ598357@kernel.org>
References: <20240702134448.132374-9-karol.kolacinski@intel.com>
 <20240702134448.132374-10-karol.kolacinski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702134448.132374-10-karol.kolacinski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1720030789;
 bh=cF2H4jyUtOE6hWkWsSubltzoLKDLzna4vo4o5UYxqaI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lkGCeR2yOyw9KTbWKcsVYhlpS6U15CtYJEdNhdcnJFGeUU4Wup1M7MpvOlTZtZARM
 zYi39TdignhAs0G+t99rm48lTBbZk+pSJLI7AjTMKPOxgAsBCcvBnwUzyV7Slkq1SA
 UmgiNVAPO4d9b3NnbFxw1FDtryzG0YRgUw5BDBzB33rUDI91rIY5HC+YYfwRI57Zqj
 AbGj29g0j0YU4uI45M1jYx2uIGnhBM7rgmj6fA9Vzu6/6EadpQBTz708P8M8CSKm0y
 WINLlikU/5BW+toyfJrGABPGZTbc4NP+8vYiZ2OjoUJobFLsitWXMc6pmZe4gs693e
 wpG3y+FJoQUuQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=lkGCeR2y
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-next 1/7] ice: Implement
 ice_ptp_pin_desc
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
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 intel-wired-lan@lists.osuosl.org, przemyslaw.kitszel@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Jul 02, 2024 at 03:41:30PM +0200, Karol Kolacinski wrote:
> Add a new internal structure describing PTP pins.
> Use the new structure for all non-E810T products.
> 
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
> V1 -> V2: Removed unused err variable

Reviewed-by: Simon Horman <horms@kernel.org>

