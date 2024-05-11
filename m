Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0B8C04FFE
	for <intel-wired-lan@archiver.kernel.org>; Sat, 11 May 2024 16:57:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9AE4F4245F;
	Sat, 11 May 2024 16:57:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mxO5WN9ZdY73; Sat, 11 May 2024 16:57:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B32F742462
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1715446630;
	bh=WGW2O5nCKDOn9ZcP23vtMrGgiVIQbR71OoNmbKk2Lno=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=mRuuWK+NFnaqUQT9KQgiWvBA0p6WQWmhnk8wICM6TWCTyNDxIZkEe6eEqaveAo4R4
	 98auXHNcJjidVoI8XtxvoAlhY+QTDV53V42pRvDMX377GQSmrmZw1Sacoqqk7tikVu
	 k55nbEHruJvISxlHTLl87evhpXAjB2+LncHmksVE6qrX6yvLcMU2Rk+3WI7yDjryar
	 NVginBs/3h+Q2/mCQtQwO4i1N/hfQj/Cn91DyY+Akv54cLnPRCel/I+hJjvQzvYl8r
	 /hLKu6zY5ZfaN8T7NG8y/z/RHFfEH/UIK8XxDbhKxNtL9Bm7SpTUi5+UcfLYKjF3C5
	 lUjk/Q+H5Zm/g==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id B32F742462;
	Sat, 11 May 2024 16:57:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 60A021BF4D7
 for <intel-wired-lan@lists.osuosl.org>; Sat, 11 May 2024 16:57:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 598DD40189
 for <intel-wired-lan@lists.osuosl.org>; Sat, 11 May 2024 16:57:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4YgvwDLsCkcQ for <intel-wired-lan@lists.osuosl.org>;
 Sat, 11 May 2024 16:57:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 94C1F40168
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 94C1F40168
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 94C1F40168
 for <intel-wired-lan@lists.osuosl.org>; Sat, 11 May 2024 16:57:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 734A26105D;
 Sat, 11 May 2024 16:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E2BC2BBFC;
 Sat, 11 May 2024 16:57:04 +0000 (UTC)
Date: Sat, 11 May 2024 17:57:01 +0100
From: Simon Horman <horms@kernel.org>
To: Anil Samal <anil.samal@intel.com>
Message-ID: <20240511165701.GP2347895@kernel.org>
References: <20240510065243.906877-1-anil.samal@intel.com>
 <20240510065243.906877-3-anil.samal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510065243.906877-3-anil.samal@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1715446627;
 bh=H9A3Ifmn4o4ZDOqzHZ3u3zYShj8DYerAWEvvBW8wdVI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hrDidNXyLK6HS9YBaqsuCfTV5Qf3UfpQXI+jcdtzzyzeRgs5PrkuD49JH/PGh7SXY
 utpj9/cAl0im0Rn0tuxx9gzI3leZ14BmXhuV83Ajzcq0M4zpm1LJndnH68KQ44t+1e
 bSWSnSH7YArEZUIl9OqZPz2ZJk9lwbAnYGoxpTrUQZnkrFMcwtakvciQo+KCH/ZY0c
 70UL41+HZR4OvgzJxu/k+/pO7XKOs/cQPKX62bOpwyvB39V0NnBh1jzgLDSl0RdUxU
 xe6M9JkHOd28zSvRwCwA0yj+dBa6o3ScfZeCspWDt093b57IFLtyhlKCxoAmmtpSns
 3Gmfc76YXWP8A==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=hrDidNXy
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 2/3] ice: Implement driver
 functionality to dump fec statistics
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
Cc: netdev@vger.kernel.org, lukasz.czapnik@intel.com, leszek.pepiak@intel.com,
 Anthony L Nguyen <anthony.l.nguyen@intel.com>, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

[ Fixed CC list by dropping '--cc=' from start of addresses. ]

On Thu, May 09, 2024 at 11:50:41PM -0700, Anil Samal wrote:
> To debug link issues in the field, it is paramount to
> dump fec corrected/uncorrected block counts from firmware.
> Firmware requires PCS quad number and PCS port number to
> read FEC statistics. Current driver implementation does
> not maintain above physical properties of a port.
> 
> Add new driver API to derive physical properties of an input port.
> These properties include PCS quad number, PCS port number, serdes
> lane count, primary serdes lane number.
> 
> Extend ethtool option '--show-fec' to support fec statistics.
> The IEEE standard mandates two sets of counters:
>  - 30.5.1.1.17 aFECCorrectedBlocks
>  - 30.5.1.1.18 aFECUncorrectableBlocks
> 
> Standard defines above statistics per lane but current
> implementation supports total FEC statistics per port
> i.e. sum of all lane per port. Find sample output below
> 
>  # ethtool -I --show-fec ens21f0np0
> FEC parameters for ens21f0np0:
> Supported/Configured FEC encodings: Auto RS BaseR
> Active FEC encoding: RS
> Statistics:
>   corrected_blocks: 0
>   uncorrectable_blocks: 0
> 
> Reviewed-by: Anthony L Nguyen <anthony.l.nguyen@intel.com>
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Anil Samal <anil.samal@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

