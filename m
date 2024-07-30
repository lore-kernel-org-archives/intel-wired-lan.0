Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EDCC3DA49
	for <intel-wired-lan@archiver.kernel.org>; Tue, 30 Jul 2024 10:28:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 718C181140;
	Tue, 30 Jul 2024 10:28:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vVuEE9kTJZvm; Tue, 30 Jul 2024 10:28:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DF23D81155
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1722335322;
	bh=ftwnyNoTAYhYQxiI7Rech1h2g0bGdjCdnyCW+7pRQoA=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=kUvEMrlhwzhja61R2Z66mgg0/RGzssoPMSkOhx2R9ESz0C25k5/H3to9MA25tX0us
	 FW9stRpf1MMYedZEYEYxTVsRfilgoLk8S2GcA+jkP/YKZzLkvnGYgB/Dn/1WDnar19
	 rGH5EmM4oH1KWTmRqNqFEA3VGKucRnwNXKolGuuOd3Wztiex0OiMd/fBFktmGeTQAD
	 9Td5AqgzuK4w8d8g+pGyrKm7O/0kE882EjHAGbM9dkbMoOWxToV0H0WdKNickwczdJ
	 c87fFukF0LVNOVP0zIlII2Uvo5pIGfY7ou6GArfCdxToXWKEPw7OLnUx7qiI5uRO95
	 eemkeOhqqV4lg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF23D81155;
	Tue, 30 Jul 2024 10:28:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 3DFB81BF5DA
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jul 2024 10:28:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2A4B34062A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jul 2024 10:28:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4obYbMwk8WFQ for <intel-wired-lan@lists.osuosl.org>;
 Tue, 30 Jul 2024 10:28:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5190840609
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5190840609
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5190840609
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jul 2024 10:28:41 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9765C61C5D;
 Tue, 30 Jul 2024 10:28:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B68C32782;
 Tue, 30 Jul 2024 10:28:38 +0000 (UTC)
Date: Tue, 30 Jul 2024 11:28:36 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Message-ID: <20240730102836.GX97837@kernel.org>
References: <20240725220810.12748-1-ahmed.zaki@intel.com>
 <20240725220810.12748-12-ahmed.zaki@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725220810.12748-12-ahmed.zaki@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1722335320;
 bh=SZ4c15f7l1jB8rzYdsQuU2R5Kome+64Aq5Sa2WoTqmc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eyj+z7OTSqx00XpnL7l3F6uy1U1NdX/OPvPq+WAGw4TFek5aOw78lRfNei4PjiJmt
 idr07II31dRY0TAElAAQf9mwsFQTkTb4JJFFmjBqejJWwaeXgM+4jKkP4vD5+SGlUn
 /F+dK5GMzD8gu3ttC5aFh850lgJlW3XpP1EpgKucNo1Qk14EsIdEQDRxQmeMo2XzLL
 meDFYHqSWy/oQXy4GSZuZZrDNB8WD2YXdUcthgsZgzcav/c4CHWfh3chxsH5nouxkO
 jLyEPZEUZrDVXEk42n6TE2nDiwUocYRv0C/nT11p+x9FwrYkYrt3maHB3IrkMESrCI
 vNvyRAqNSTRbQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=eyj+z7OT
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5 11/13] ice: enable FDIR
 filters from raw binary patterns for VFs
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
Cc: netdev@vger.kernel.org, hkelam@marvell.com,
 Marcin Szycik <marcin.szycik@linux.intel.com>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, Junfeng Guo <junfeng.guo@intel.com>,
 intel-wired-lan@lists.osuosl.org,
 Rafal Romanowski <rafal.romanowski@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Jul 25, 2024 at 04:08:07PM -0600, Ahmed Zaki wrote:
> From: Junfeng Guo <junfeng.guo@intel.com>
> 
> Enable VFs to create FDIR filters from raw binary patterns.
> The corresponding processes for raw flow are added in the
> Parse / Create / Destroy stages.
> 
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Co-developed-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

