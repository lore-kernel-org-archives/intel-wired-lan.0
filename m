Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB82FD064E
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Mar 2026 08:07:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2EF0740697;
	Wed, 11 Mar 2026 08:07:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AtXxzCxKpOQ2; Wed, 11 Mar 2026 08:07:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 597474065F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773216427;
	bh=p21/qdwRf9qM7V0Cw60Ky+izhgH1DEXH8damJx0k6yU=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=3k+MOzA31ody6EjhbM9Jdu0+ToCZRtch6spOA8n+7uf2WF5yUnmCovl4+OA2oR86I
	 MVNR19hyluGzYDLcc5jQ2BAGTPJRPnik82PbcJNyHKcm0LBSkaX+i5o7IaHEJAkYFk
	 Oq2KGmsRE+01Im5KpAv5gGY6SAq4mBDij/4kr2OxV4qYxQ3C5XJwr3FQ8RTJbnjR2Y
	 7Ln7Yz9Y3gjcNIrJhjwBstx+4Uujv5QK2NeTs8Hk79N6W8rHllmpD4zOgIPecsIsMe
	 /1uOprbISIG2O9APELwG2RI+B9UpDegd7Ii6ebbIaDO5IXTQVtOHpX2KfnPPI7NjUs
	 DPBbX+GkEKtHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 597474065F;
	Wed, 11 Mar 2026 08:07:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A0FDF33A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Mar 2026 08:07:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8C7514028F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Mar 2026 08:07:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h3f4OuP7EvGL for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Mar 2026 08:07:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=dawid.osuchowski@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D236B40198
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D236B40198
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D236B40198
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Mar 2026 08:07:04 +0000 (UTC)
X-CSE-ConnectionGUID: Uk65Vs1jR1O6NXOT9bhAfA==
X-CSE-MsgGUID: T25aEWaBR5SQ/uBAswFxRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="78132162"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="78132162"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 01:07:05 -0700
X-CSE-ConnectionGUID: H2DSZ0kATH+1VvirJcfyWw==
X-CSE-MsgGUID: FqND9zNTRKu8IZxEKqH2oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="216667246"
Received: from mikolajn-mobl1.ger.corp.intel.com (HELO [10.94.252.226])
 ([10.94.252.226])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 01:07:02 -0700
Message-ID: <d8a70780-3490-473d-9641-fc015c7993cf@linux.intel.com>
Date: Wed, 11 Mar 2026 09:06:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Przemyslaw Korba <przemyslaw.korba@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com
References: <20260310110700.345904-1-przemyslaw.korba@intel.com>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20260310110700.345904-1-przemyslaw.korba@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773216425; x=1804752425;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=BGG9Bg7/RT2Mpno5T2cu2+Tw3wtXTUw6iRza8NOvjuU=;
 b=V5Vt3bQAehkxV/nYxMxS5vUFvTCU8LFa58s5K9vSfHZxoJ5aHihOT2RY
 ejBsWqXkUom9zT4dCWrd8YfFw51FpMvWihRY2mbwl4Uvw2ZooZ3uCxQbF
 Q7QSH82QmFx7gIe+fSqlleB+Gv7q5NosFE6/iFbdPv3JEQmVBO1UwywQZ
 DO/b3NqOwd+XCmdPMM0osXQ6WE9RW+zBjLs0LLbdT3VQa8svtlqp4GNLd
 syu2U92t+aaPZz8gC+jluTNW2+BZHjg4U+y9ZOVq/nU/FT1L5Lom0m2ap
 GdjA1Iq8NYZ4tEQWgdtPbc4dsG0b+W1SxZCc1kgzfovF2Wu26Lq+jUypw
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=V5Vt3bQA
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: fix posted write support
 for sideband queue operations
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
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
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 2026-03-10 12:06 PM, Przemyslaw Korba wrote:
> On E830, PTP time adjustment commands sent via
> SBQ don't generate completion responses, causing the driver to
> timeout waiting and return -EIO, when trying:
> 
> phc_ctl eth8 get adj 2 get
> dmesg: ice 0000:1a:00.0: PTP failed to adjust time, err -5
> 
> Add support for posted mode not to wait for completion response.
> 
> Fixes: 8f5ee3c477a8 ("ice: add support for sideband messages")
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>

Hey Przemek,

Similarly to what I posted in response to your patch "[PATCH iwl-next] 
i40e: PTP: set supported flags in ptp_clock_info", you are missing 
Reviewed-by tags from internal review. I see you did send for internal 
review but nobody actually provided an RB tag (at least not directly on 
the internal list).

-Dawid
