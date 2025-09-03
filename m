Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7D2CA0FF2
	for <intel-wired-lan@archiver.kernel.org>; Wed,  3 Sep 2025 12:51:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7487941111;
	Wed,  3 Sep 2025 12:51:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nShEbkuUOa48; Wed,  3 Sep 2025 12:51:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B0F904106F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1756903882;
	bh=JiaGyqFzj3bxaU2p5B7ztzMPIr+FHeNsXo757DqgCdQ=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AX1pvW97LLw3WS7NtIXgqErM/qTVVo4pU2tDfh3Qk709L1wOJZ4saQwgfIIgvVdYq
	 mDHYQss29X5wwC3fZ6GFNK5BOESpNNXy5XY9j9Q3H51CMf0iGgXHPnzB5Y7WWy0x2F
	 FLMJk/zyLoahUvwUNwzohpJhpJiakCoqPrDcR0iGJkMUuCnHonX3dfc9KZE8Nj5y+t
	 UUpB4wvLd4xyuIM0lQ3QYoTfVnmQXLI6AZODUUuxrZKWHU6EVSGyz+7uGxUzl4+EPE
	 e1Noa+yOLThH3mvV4EI3qTAwt4vpUt30bq+cnb3QuUqSyAFwIKP/iyopFheydS7yIF
	 fWpBvBKTcPVRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B0F904106F;
	Wed,  3 Sep 2025 12:51:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 95218439
 for <intel-wired-lan@lists.osuosl.org>; Wed,  3 Sep 2025 12:51:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7B64341543
 for <intel-wired-lan@lists.osuosl.org>; Wed,  3 Sep 2025 12:51:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gSgx_99CliVq for <intel-wired-lan@lists.osuosl.org>;
 Wed,  3 Sep 2025 12:51:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B39A1405D6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B39A1405D6
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B39A1405D6
 for <intel-wired-lan@lists.osuosl.org>; Wed,  3 Sep 2025 12:51:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B7D6143248;
 Wed,  3 Sep 2025 12:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786CCC4CEF0;
 Wed,  3 Sep 2025 12:51:18 +0000 (UTC)
Date: Wed, 3 Sep 2025 13:51:16 +0100
From: Simon Horman <horms@kernel.org>
To: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, madhu.chittim@intel.com,
 netdev@vger.kernel.org, Sridhar Samudrala <sridhar.samudrala@intel.com>
Message-ID: <20250903125116.GC361157@horms.kernel.org>
References: <20250903035853.23095-1-pavan.kumar.linga@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903035853.23095-1-pavan.kumar.linga@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1756903879;
 bh=N0Bcbv50hPYmO0pEUw7i4h6uGwwARCZteWWx5lzuoA4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XUBDokaF6DcRW6QH3ytrPJc5Q3LTxaGR/svJowJby3x46AlPy6/W2GNLnU99o8CPY
 pOZtlgu2L/P1Dh7xaDM30wX+ibdRjQc7fMNqZuvV9FN6Y146cv9Qo/3iD/fSU34h+z
 hHRr0kFfuTTLlWifjj1amhusdu7OSItEdR/VfbbtwO3D3WdlaTZGtB2/8znjLDJ/12
 tf0LrIrJBupxpgPdezyypVbZQMEbOBrcdSPQxAnvdTeFWnfdIk86j2/QdOMk6K2uSm
 DHQrdgdM87VYCAlhuNoGkwUc68xVnFDF9CarupugnMgLZVxIQLz1JKeZKGfnERety8
 4g6OmGJG9JrEA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=XUBDokaF
Subject: Re: [Intel-wired-lan] [PATCH net-next v4] idpf: add support for
 IDPF PCI programming interface
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

On Tue, Sep 02, 2025 at 08:58:52PM -0700, Pavan Kumar Linga wrote:
> At present IDPF supports only 0x1452 and 0x145C as PF and VF device IDs
> on our current generation hardware. Future hardware exposes a new set of
> device IDs for each generation. To avoid adding a new device ID for each
> generation and to make the driver forward and backward compatible,
> make use of the IDPF PCI programming interface to load the driver.
> 
> Write and read the VF_ARQBAL mailbox register to find if the current
> device is a PF or a VF.
> 
> PCI SIG allocated a new programming interface for the IDPF compliant
> ethernet network controller devices. It can be found at:
> https://members.pcisig.com/wg/PCI-SIG/document/20113
> with the document titled as 'PCI Code and ID Assignment Revision 1.16'
> or any latest revisions.
> 
> Tested this patch by doing a simple driver load/unload on Intel IPU E2000
> hardware which supports 0x1452 and 0x145C device IDs and new hardware
> which supports the IDPF PCI programming interface.
> 
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Madhu Chittim <madhu.chittim@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

Hi Pavan,

Should this be targeted at iwl, where it applies cleanly,
rather than net-next, where it does not.

If the later, I think that a rebase and repost is appropriate.

...
