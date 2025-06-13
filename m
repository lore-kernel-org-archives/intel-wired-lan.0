Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE21EC71135
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Jun 2025 07:21:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 722BB810C6;
	Fri, 13 Jun 2025 07:21:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x2us_Svz9uGM; Fri, 13 Jun 2025 07:21:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9AE1683E08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1749799304;
	bh=zZfT8ZIgNcM10FReAzynE7C28ZioTdqEGD6LtVuRNuk=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kbqBVEibqTQUQQx5zUz0QqzjyV7qlEPXPwUCFmwFlIkgFFk0GEcz3D4GosG3md1Fl
	 ogEEXGIfTL5zJAAZ8jNR3b2RrtBu4nR1CdUQEZHGNR3V9hjDC2rtwQcqyG7Ef5cKRz
	 IzWYcK/0zlWrVn7oXfBValQZr3GCDqq6IgRFWyfFnARhrVRuHX5sTouXTcsGEM84h2
	 DsttFxDBrF+CWdTLxzH3drGjmgAyci24pb/34DFXtNcMVY/sbsjucJzs+TlR/nhxyS
	 /2Dg4SosCBngPUAkzxUglcBkImw9MxrZhitY7OYJCmZr8JkX6JYcF6o1610h04UnPO
	 cmbaGeZ9ZMTVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9AE1683E08;
	Fri, 13 Jun 2025 07:21:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 33D88115
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Jun 2025 07:21:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 24C034071C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Jun 2025 07:21:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZuA1iBr1VW5q for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Jun 2025 07:21:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 31659404E6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 31659404E6
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 31659404E6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Jun 2025 07:21:40 +0000 (UTC)
Received: from [192.168.2.111] (p57bd96bf.dip0.t-ipconnect.de [87.189.150.191])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9B75561E647A3;
 Fri, 13 Jun 2025 09:21:09 +0200 (CEST)
Message-ID: <1dbe36d4-c272-4af0-a83b-0ab7ff0464c3@molgen.mpg.de>
Date: Fri, 13 Jun 2025 09:21:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, jgg@nvidia.com, leon@kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org
References: <20250612220002.1120-1-tatyana.e.nikolova@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250612220002.1120-1-tatyana.e.nikolova@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [iwl-next v2 0/6] Add RDMA support for Intel
 IPU E2000 in idpf
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

Dear Tatyana,


Thank you for this patch series.


Am 12.06.25 um 23:59 schrieb Tatyana Nikolova:
> This idpf patch series is the second part of the staged submission
> for introducing RDMA RoCEv2 support for the IPU E2000 line of products,
> referred to as GEN3.
> 
> To support RDMA GEN3 devices, the idpf driver uses
> common definitions of the IIDC interface and implements
> specific device functionality in iidc_rdma_idpf.h.

This could be re-flowed for longer lines.

> The IPU model can host one or more logical network endpoints called
> vPorts per PCI function that are flexibly associated with a physical
> port or an internal communication port.
> 
> Other features as it pertains to GEN3 devices include:
> * MMIO learning
> * RDMA capability negotiation
> * RDMA vectors discovery between idpf and control plane
> 
> These patches are split from the submission
> "Add RDMA support for Intel IPU E2000 (GEN3)" [1]
> and are based on 6.16-rc1. A shared pull request for net-next and
> rdma-next will be sent following review.

Still mention the datasheet?

Also, it’d be great to have a paragraph on how this was tested.

> Changelog:
> 
> v2:
> * Minor improvements like variable rename, logging,
> remove a redundant variable, etc.
> * A couple of cdev_info fixes to properly free it in
> error path and not to dereference it before NULL check.
> 
> Changes since split (v1) at [4]:
> * Replace core dev_ops with exported symbols
> * Align with new header split scheme (iidc_rdma.h common header
> and iidc_rdma_idpf.h specific header)
> * Align with new naming scheme (idc_rdma -> iidc_rdma)
> * The idpf patches are submitted separately from the ice and
> irdma changes.
> 
> At [3]:
> * Reduce required minimum RDMA vectors to 2
> 
> At [2]:
> * RDMA vector number adjustment
> * Fix unplugging vport auxiliary device twice
> * General cleanup and minor improvements
> 
> [1] https://lore.kernel.org/all/20240724233917.704-1-tatyana.e.nikolova@intel.com/
> [2] https://lore.kernel.org/all/20240824031924.421-1-tatyana.e.nikolova@intel.com/
> [3] https://lore.kernel.org/all/20250207194931.1569-1-tatyana.e.nikolova@intel.com/
> [4] https://lore.kernel.org/all/20250523170435.668-1-tatyana.e.nikolova@intel.com/
> 
> Joshua Hay (6):
>    idpf: use reserved RDMA vectors from control plane
>    idpf: implement core RDMA auxiliary dev create, init, and destroy
>    idpf: implement RDMA vport auxiliary dev create, init, and destroy
>    idpf: implement remaining IDC RDMA core callbacks and handlers
>    idpf: implement IDC vport aux driver MTU change handler
>    idpf: implement get LAN MMIO memory regions
> 
>   drivers/net/ethernet/intel/idpf/Makefile      |   1 +
>   drivers/net/ethernet/intel/idpf/idpf.h        | 117 ++++-
>   .../net/ethernet/intel/idpf/idpf_controlq.c   |  14 +-
>   .../net/ethernet/intel/idpf/idpf_controlq.h   |  19 +-
>   drivers/net/ethernet/intel/idpf/idpf_dev.c    |  49 +-
>   drivers/net/ethernet/intel/idpf/idpf_idc.c    | 497 ++++++++++++++++++
>   drivers/net/ethernet/intel/idpf/idpf_lib.c    | 102 +++-
>   drivers/net/ethernet/intel/idpf/idpf_main.c   |  32 +-
>   drivers/net/ethernet/intel/idpf/idpf_mem.h    |   8 +-
>   drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   1 +
>   drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  45 +-
>   .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 190 ++++++-
>   .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   3 +
>   drivers/net/ethernet/intel/idpf/virtchnl2.h   |  42 +-
>   include/linux/net/intel/iidc_rdma_idpf.h      |  55 ++
>   15 files changed, 1102 insertions(+), 73 deletions(-)
>   create mode 100644 drivers/net/ethernet/intel/idpf/idpf_idc.c
>   create mode 100644 include/linux/net/intel/iidc_rdma_idpf.h


Kind regards,

Paul
