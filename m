Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34317FD45FE
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Feb 2026 01:08:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C636342074;
	Thu, 26 Feb 2026 01:08:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WAcqWsezTrZO; Thu, 26 Feb 2026 01:08:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C3E014206E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772068104;
	bh=8/kegD7kgbnYGEQ3QcsbSYEwWfVDoZfXI6rpbeY+UWk=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=46u0duT0AOzOx6oHXqoBh/+teSssfD8ysfqRse4wp9pVECJDTHeL2s1IbwrThcmcn
	 MLEaGUGFv+ioU9fYwkD5X3NzMOGIMldIgTgdDtcwUbJVge1MCvd7ra52lglaabzVxf
	 xWVj+mrMXfIX/jOPHXonVhBLQLPrEwQ+aNLjprKSPIfQv5GBIT6QwYPkW5iM/LbqHi
	 5Rd3yUu9or8PJUGZkVzxKpycjxIxCKVsLQUcMKYr5kigoSAYFD/KX1g3NSO7xKP3qB
	 SbPUEyqS3UoTVbv+lIcTIz6RuvHOOAaLeo3EsEiPvd0YGtxFZ6agbfX2rzRwPdK6mb
	 HXxvj60Wex9aw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3E014206E;
	Thu, 26 Feb 2026 01:08:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E7DE204
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Feb 2026 01:08:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 00444615CA
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Feb 2026 01:08:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 21AptjiIo6nx for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Feb 2026 01:08:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=166.125.252.92;
 helo=invmail4.hynix.com; envelope-from=byungchul@sk.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8FE1F615C9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8FE1F615C9
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8FE1F615C9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Feb 2026 01:08:18 +0000 (UTC)
X-AuditID: a67dfc5b-c2dff70000001609-e5-699f9d01b8b5
Date: Thu, 26 Feb 2026 10:08:11 +0900
From: Byungchul Park <byungchul@sk.com>
To: netdev@vger.kernel.org, kuba@kernel.org
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 harry.yoo@oracle.com, david@redhat.com, willy@infradead.org,
 toke@redhat.com, asml.silence@gmail.com, almasrymina@google.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, intel-wired-lan@lists.osuosl.org
Message-ID: <20260226010811.GA16777@system.software.com>
References: <20260224053546.62757-1-byungchul@sk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224053546.62757-1-byungchul@sk.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsXC9ZZnoS7j3PmZBk8/cFis/lFhsfzBDlaL
 3Rd+MFnMWbWN0WLO+RYWi6/rfzFbPD32iN3i/rJnLBb/b/1mtbiwrY/V4vKuOWwWxxaIWXw7
 /YbR4vbSq0wWlw4/YrH4/WMOm4OAx5aVN5k8ds66y+6xYFOpx+YVWh6L97xk8ti0qpPN42Rz
 qcfOHZ+ZPD4+vcXi8X7fVTaPz5vkArijuGxSUnMyy1KL9O0SuDIunFrHXvCSs2L51k9MDYzt
 HF2MnBwSAiYSVy6+Z4Ox5x85ywRiswioSty4f5URxGYTUJe4ceMnM4gtIqAtsfJ8BwuIzSzw
 kUlixg0uEFtYIFDi3IUjYHN4BSwkem98BasREjCV+HF5PSNEXFDi5MwnUL1aEjf+vQTaxQFk
 S0ss/wd2DqeAmcTen5PASkQFlCUObDvOBHFaN7vE6nuaELakxMEVN1gmMArMQjJ1FpKpsxCm
 LmBkXsUolJlXlpuYmWOil1GZl1mhl5yfu4kRGGXLav9E72D8dCH4EKMAB6MSD2/Ez3mZQqyJ
 ZcWVuYcYJTiYlUR473wACvGmJFZWpRblxxeV5qQWH2KU5mBREuc1+laeIiSQnliSmp2aWpBa
 BJNl4uCUamDUvHfn3fll2vsbVj+rvqTcNvul0/TbnybVaW3/+CPnlLqZ4YPNnPt94y1u2Xgc
 z5v/7t+qwLZLDaXqiY+PKqWVTz9rluL/MWWh2+EZVlfahI2sLVMM323Inrl26eRTSe766j8M
 zpeL/RNXLs22Tc+2fvRYo7Zy7+ZE1jM3L6ZnLdidOqvmtJiKEktxRqKhFnNRcSIAruq4f64C
 AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42Lh8rNu1mWYOz/T4NhOG4vVPyoslj/YwWqx
 +8IPJos5q7YxWsw538Ji8XX9L2aLp8cesVvcX/aMxeL/rd+sFofnnmS1uLCtj9Xi8q45bBbH
 FohZfDv9htHi9tKrTBaXDj9isfj9Yw6bg6DHlpU3mTx2zrrL7rFgU6nH5hVaHov3vGTy2LSq
 k83jZHOpx84dn5k8Pj69xeLxft9VNo/FLz4weXzeJBfAE8Vlk5Kak1mWWqRvl8CVceHUOvaC
 l5wVy7d+YmpgbOfoYuTkkBAwkZh/5CwTiM0ioCpx4/5VRhCbTUBd4saNn8wgtoiAtsTK8x0s
 IDazwEcmiRk3uEBsYYFAiXMXjrCB2LwCFhK9N76C1QgJmEr8uLyeESIuKHFy5hOoXi2JG/9e
 Au3iALKlJZb/AzuBU8BMYu/PSWAlogLKEge2HWeawMg7C0n3LCTdsxC6FzAyr2IUycwry03M
 zDHVK87OqMzLrNBLzs/dxAiMmmW1fybuYPxy2f0QowAHoxIPb8TPeZlCrIllxZW5hxglOJiV
 RHjvfAAK8aYkVlalFuXHF5XmpBYfYpTmYFES5/UKT00QEkhPLEnNTk0tSC2CyTJxcEo1MKbq
 60++8WyZpCyvx3WVogdhLNn+t2xKf/qvizC6+yKfbV5qm/+HMKMH/xxi5vxLlsu56tJ/VOuw
 s+XMqa/PPtOv2/E7nq+H45q8p7yASJrYrZicxVaGeve/ymz659tdfMnqae3lPR9iF3dvj83b
 0fDmd5bPmxCfGKM1iVuf32Sa/o3V0+jGfSWW4oxEQy3mouJEAJV/J7GWAgAA
X-CFilter-Loop: Reflected
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=sk.com
Subject: Re: [Intel-wired-lan] [RESEND PATCH] ice: access @pp through
 netmem_desc instead of page
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

On Tue, Feb 24, 2026 at 02:35:46PM +0900, Byungchul Park wrote:
> To eliminate the use of struct page in page pool, the page pool users
> should use netmem descriptor and APIs instead.
> 
> Make ice driver access @pp through netmem_desc instead of page.

Hi Tony and Przemek,

Is there something that I'm missing or something wrong with this?  Your
feedback would be appreciated.  Thanks!

	Byungchul

> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index c6bc29cfb8e6..c16e54dbe75b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -1251,7 +1251,7 @@ static int ice_lbtest_receive_frames(struct ice_rx_ring *rx_ring)
>  		rx_buf = &rx_ring->rx_fqes[i];
>  		page = __netmem_to_page(rx_buf->netmem);
>  		received_buf = page_address(page) + rx_buf->offset +
> -			       page->pp->p.offset;
> +			       pp_page_to_nmdesc(page)->pp->p.offset;
>  
>  		if (ice_lbtest_check_frame(received_buf))
>  			valid_frames++;
> -- 
> 2.17.1
