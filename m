Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1203FCAC592
	for <intel-wired-lan@archiver.kernel.org>; Mon, 15 Sep 2025 16:11:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C18FB6073D;
	Mon, 15 Sep 2025 16:11:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5wB6jQ5ljcqh; Mon, 15 Sep 2025 16:10:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 934B46072B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1757952658;
	bh=uuoUKEJ54WCokBwecB679oiTZdyaVBTsIQZss3Tmj7k=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mxPAjYa7n2mSQPVI6FvznUBaI+/G3RYgqW8xNVp3Uh8yvW1vqf9E/fatfMrHFYJiJ
	 JyBrk6d0CYUIjN1Ep/UAig9yf60K92LXRWyiS3UGal3o+VT6PCV7wmAQ5zoanVJd68
	 loMCVMkgUJiQNR2ssZMeQny51Q9qanlZrETAMn3gcdoY/IIeBP25vTpWlBScfpVBHU
	 ARP48ANukySCqj7dczdtTaKrWY27OfY10RGYM633GN6TKawABq+wU5BED7fGrl5Eso
	 ibB6A8rQ+VqA0KNjiCa6zCDWq+OXSfQaz/0iqRxZCTXIenSMDgXu5zuYivbTd3IZPC
	 29mL31zeDHc5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 934B46072B;
	Mon, 15 Sep 2025 16:10:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AF1B012D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 15 Sep 2025 16:10:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 995CA4008C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 15 Sep 2025 16:10:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J_GNaKlXao7A for <intel-wired-lan@lists.osuosl.org>;
 Mon, 15 Sep 2025 16:10:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2A9F040052
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2A9F040052
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2A9F040052
 for <intel-wired-lan@lists.osuosl.org>; Mon, 15 Sep 2025 16:10:55 +0000 (UTC)
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8955A60288274;
 Mon, 15 Sep 2025 18:10:42 +0200 (CEST)
Message-ID: <89e50ff2-5382-4d5e-a121-167704ef5b1a@molgen.mpg.de>
Date: Mon, 15 Sep 2025 18:10:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Anton Nadezhdin <anton.nadezhdin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, richardcochran@gmail.com,
 Milena Olech <milena.olech@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20250829175734.175963-1-anton.nadezhdin@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250829175734.175963-1-anton.nadezhdin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] idpf: add HW timestamping
 statistics
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

Dear Anton,


Thank you for the improved patch.

Am 29.08.25 um 19:57 schrieb Anton Nadezhdin:
> From: Milena Olech <milena.olech@intel.com>
> 
> Add HW timestamping statistics support - through implementing get_ts_stats.
> Timestamp statistics include correctly timestamped packets, discarded,
> skipped and flushed during PTP release.
> 
> Most of the stats are collected per vport, only requests skipped due to
> lack of free latch index are collected per Tx queue.
> 
> Statistics can be obtained using kernel ethtool since version 6.10
> with:
> ethtool -I -T <interface>
> 
> The output will include:
> Statistics:
>    tx_pkts: 15
>    tx_lost: 0
>    tx_err: 0
> 
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> Co-developed-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
> Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> Changelog:
> v2: Add testing information
> v3: Add check for port status to resolve driver crash during statistic
>    read when port is down
> ---
>   drivers/net/ethernet/intel/idpf/idpf.h        | 17 ++++++
>   .../net/ethernet/intel/idpf/idpf_ethtool.c    | 56 +++++++++++++++++++
>   drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 11 +++-
>   .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  4 ++
>   4 files changed, 87 insertions(+), 1 deletion(-)

[…]

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
