Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD236C61DB9
	for <intel-wired-lan@archiver.kernel.org>; Fri, 28 Aug 2026 09:11:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8397B60648;
	Fri, 28 Aug 2026 09:11:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pHwAmGnLfani; Fri, 28 Aug 2026 09:11:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787908285;
	bh=V55M+RJc+Hy+UUuMDQ3wVjs8GZ7ARB6XTOMZ+SGhwl8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dXkwA5RxCtHYyPm5I0njc4TovgG7DHLiOsbiQRAbxbbrTXgzW8vlPzBZqc3ruBc8/
	 JbsIw3FqebI86RcJeRoObKAqsdCNbDkafO062qVAB7vZeLmsQlb/4t4oN30yHyx+i3
	 jhgOvuvnPpAOSuUJNf1cPAlPR77R4Zn3NY2LCdRfaFzn0zUA1lOhVxFmGVYBxyxWWO
	 WooS92k1S524FbXuZbc4x+MkgWr/N4bDeg2rTOiGTTCI1XfF9Uw+07u4LE8W7/zZaH
	 UYFU7SGztcGHXGpGXSZXNXsyoWODUvDKQdO6lf9KK+ETzV6DashlefiRa5CX1MTYZ2
	 YboWVEBgeej7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B55B660705;
	Fri, 28 Aug 2026 09:11:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 120B3386
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Aug 2026 09:11:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 03A1B60705
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Aug 2026 09:11:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y9lu4rRQq32Z for <intel-wired-lan@lists.osuosl.org>;
 Fri, 28 Aug 2026 09:11:23 +0000 (UTC)
X-Greylist: delayed 64 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 28 Aug 2026 09:11:20 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=eFKZo7m5
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:41d0:1004:224b::2d; helo=mta0.migadu.com;
 envelope-from=vadim.fedorenko@linux.dev; receiver=<UNKNOWN> 
Received: from mta0.migadu.com (out-45.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::2d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C8C9860648
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Aug 2026 09:11:20 +0000 (UTC)
X-Envelope-To: intel-wired-lan@lists.osuosl.org
DKIM-Signature: a=rsa-sha256; bh=NQQjSsx7MDadVDc7TngFEjnUA3fUDa8WYM/oWjHn/5c=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787908277; v=1; x=1788513077;
 b=eFKZo7m5NkA+H/pmXmLwoUbIMGlOKLp8I28jaJ9GwE5pQnETYIDbxQg8Kb/uurc8SCDmQG6z
 QtaKI0S7yGku3q15CLOnkFgqSEhyAu6+Is+kl6P/ORu3lLdlkAApHm2zefJLozsgoH9KHsvTx9k
 ukATreH/QGzf+kx3YhRY3PEA=
X-Envelope-To: intel-wired-lan@lists.osuosl.org
Received: by smtp.migadu.com with ESMTPS id 17eb4ab48f81af9e;
 Fri, 28 Aug 2026 09:10:07 +0000
X-Mizu-Trace-ID: 17eb4ab48f81af9e
X-Migadu-Flow: FLOW_OUT
Message-ID: <ddc21a8e-b2dc-41a7-8390-5642664f08ea@linux.dev>
Date: Fri, 28 Aug 2026 10:10:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] iavf: add missing PTP adjustment callbacks
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>, netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, richardcochran@gmail.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 jacob.e.keller@intel.com, ahmed.zaki@intel.com,
 mateusz.polchlopek@intel.com, saikrishnag@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
 stable@vger.kernel.org
References: <20260828015837.2759-1-xuanqiang.luo@linux.dev>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260828015837.2759-1-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 28/08/2026 02:58, Xuanqiang Luo wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> The PTP hardware clock documentation requires drivers to implement all
> callbacks and return -EOPNOTSUPP for unsupported features.
> 
> The iavf driver registers a PHC without adjtime or adjfine callbacks.
> A userspace clock_adjtime(2) request reaches ptp_clock_adjtime(), where
> ADJ_SETOFFSET calls adjtime and ADJ_FREQUENCY calls adjfine. The missing
> callbacks can therefore cause a NULL dereference.
> 
> Provide both callbacks and return -EOPNOTSUPP for the unsupported
> operations.
> 
> Fixes: d734223b2f0d ("iavf: add initial framework for registering PTP clock")
> Link: https://docs.kernel.org/driver-api/ptp.html#writing-clock-drivers
> Link: https://lore.kernel.org/all/20260826101004.100979-1-xuanqiang.luo@linux.dev/
> Cc: stable@vger.kernel.org
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>   drivers/net/ethernet/intel/iavf/iavf_ptp.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.c b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
> index 87b97e09df14a..fcb273828bc1b 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_ptp.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
> @@ -252,6 +252,16 @@ static int iavf_ptp_gettimex64(struct ptp_clock_info *info,
>   	return iavf_read_phc_indirect(adapter, ts, sts);
>   }
>   
> +static int iavf_ptp_adjfine(struct ptp_clock_info *info, long scaled_ppm)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int iavf_ptp_adjtime(struct ptp_clock_info *info, s64 delta)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>   static int iavf_ptp_settime64(struct ptp_clock_info *info,
>   			      const struct timespec64 *ts)
>   {
> @@ -326,6 +336,8 @@ static int iavf_ptp_register_clock(struct iavf_adapter *adapter)
>   		 KBUILD_MODNAME, dev_name(dev));
>   	ptp_info->owner = THIS_MODULE;
>   	ptp_info->gettimex64 = iavf_ptp_gettimex64;
> +	ptp_info->adjfine = iavf_ptp_adjfine;
> +	ptp_info->adjtime = iavf_ptp_adjtime;
>   	ptp_info->settime64 = iavf_ptp_settime64;
>   	ptp_info->do_aux_work = iavf_ptp_do_aux_work;
>   
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
