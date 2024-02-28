Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7810AC5478C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Feb 2024 02:36:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 15AB782211;
	Wed, 28 Feb 2024 02:36:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jUIx1B4ECWkr; Wed, 28 Feb 2024 02:36:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 781B18210E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1709087764;
	bh=Ek3LqEIfeG4BDwet58uL83ElhHvr9R1dDhtAMM8b5XM=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=tZM0MGtxq7Q/rr6IID+0FctUDm511S0UmD9HEr/zsKerUWlkUImeIFc+N6uhLkizm
	 D7wMdLXrldRSQgrwy8Qzys4KKV3OBA8IBUYFfgSZWVysjuZa6Cf/dFt0itrahCEBzi
	 uohPPz4AL/RtzWXN104ZQ+i1SjgGhR+cuL0E08S6VsLjYt65lhIlanh5DlGT7L2as8
	 tPW+GRXOZ+pqoEZBpLVPIHCkOz3CZ8RSTnH2xxJChl4Excd5370kBaFaC37On0jA4z
	 mpmIWBo+GGy4ZBIFs3LLJvfSyhSSGwCmhQ+5eSjkhV0TMXrLcOzj376iggfqf/1zH1
	 sCSsYhmxEehhA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 781B18210E;
	Wed, 28 Feb 2024 02:36:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 334701BF314
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Feb 2024 02:36:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1F7D7608C9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Feb 2024 02:36:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8KSXkeKaRTuq for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Feb 2024 02:36:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A02D660790
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A02D660790
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A02D660790
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Feb 2024 02:36:01 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 1F307CE1F7C;
 Wed, 28 Feb 2024 02:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0213CC433F1;
 Wed, 28 Feb 2024 02:35:55 +0000 (UTC)
Date: Tue, 27 Feb 2024 18:35:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Schmidt <mschmidt@redhat.com>
Message-ID: <20240227183555.01123eb7@kernel.org>
In-Reply-To: <20240226151125.45391-2-mschmidt@redhat.com>
References: <20240226151125.45391-1-mschmidt@redhat.com>
 <20240226151125.45391-2-mschmidt@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1709087756;
 bh=55xwUWFspAVlGcKw+GAnaKAavDfKol9w4CrzXxRxf4c=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ai6GEFp1xYU8vcxMOLc319xHH1ub41Nj1RMCJG1hTYBZo9NLTjM/4/jBAiRiQ0NGz
 HhzG3AMcl694LkiaRMFxs0n0aBYyrUk3Ojo29w0PoECD+lQRfMeu7ZDiLEvnHyqD3C
 5K3R1a64PKoeRwoRoBAE4NupRQ26mu+xJWSOWwY7WxHvJf329rGlvHgQ1I73iWI5o9
 v5MjPu+uKdFdECjDhNKfjkABzH92O4P0B4MWfm8t0L5sbql2q+zE/L7pT06y3HYSkk
 pNOLG5aVnc9uYlAsRN0pmPamcsPPXXS1j5EjSYRvUq+u1+13jL6dOjvCw3//BuhjZ3
 ZVDPf0tAcGj4w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ai6GEFp1
Subject: Re: [Intel-wired-lan] [PATCH net-next 1/3] ice: add ice_adapter for
 shared data across PFs on the same NIC
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
Cc: netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 intel-wired-lan@lists.osuosl.org, Jacob Keller <jacob.e.keller@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, 26 Feb 2024 16:11:23 +0100 Michal Schmidt wrote:
> There is a need for synchronization between ice PFs on the same physical
> adapter.
> 
> Add a "struct ice_adapter" for holding data shared between PFs of the
> same multifunction PCI device. The struct is refcounted - each ice_pf
> holds a reference to it.
> 
> Its first use will be for PTP. I expect it will be useful also to
> improve the ugliness that is ice_prot_id_tbl.

ice doesn't support any multi-host devices?
