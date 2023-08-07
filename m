Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A9FC001DB
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Aug 2023 21:42:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 173C8408BC;
	Mon,  7 Aug 2023 21:42:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 173C8408BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1691444571;
	bh=R7UkXMiI9GHNuttuiEm6QuXgzcNGQ0Niq4NlCwi+X88=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=QRQ5qGeLLtTFdacdRbGKbvwIyY7yicZSi5nv3mJuEB4Gsc3QDsUBTcw/WNBIhHtKm
	 30lT69gz06gimnPkv7XL0bV/A3g7/TnWTM5qm860Sr2MS6njmtE0KlbHTmKKhH5eXN
	 c0kmr7Cm90LUU6ZOzhGx+8dcSYx/R6u+0NuZtCwAbL5UGtiqyVWbTk/h+8B1oKhcz6
	 VVbngWheUUD+btHb++5sEovEkFstNt1/uKB92ZV/nY9GtKfUZEDBrDQiCjfu85mnvw
	 l8siv9cTxRdvDrfqaXsprQ7fLvk7FznaRvpN2GHHAMchV6HlGBLAnQozc1sCfMvZnW
	 S/K60qQwDoKvA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sSm6aMERC4NB; Mon,  7 Aug 2023 21:42:50 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE398408C1;
	Mon,  7 Aug 2023 21:42:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BE398408C1
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 9321C1BF5F8
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Aug 2023 21:42:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 541CB40491
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Aug 2023 21:42:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 541CB40491
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eINofGN09hMO for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Aug 2023 21:42:46 +0000 (UTC)
Received: from out-109.mta0.migadu.com (out-109.mta0.migadu.com
 [91.218.175.109])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 31E5240150
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Aug 2023 21:42:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 31E5240150
Message-ID: <2b7e0024-2a92-58c8-fbeb-d42beebedb03@linux.dev>
Date: Mon, 7 Aug 2023 22:42:41 +0100
MIME-Version: 1.0
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
References: <20230804190454.394062-1-vadim.fedorenko@linux.dev>
 <20230804190454.394062-9-vadim.fedorenko@linux.dev>
 <ZM/Uuhl4GwOWjku9@vergenet.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <ZM/Uuhl4GwOWjku9@vergenet.net>
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1691444564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bNf4Xj9sYgqaAAtVS1B7R4VnMt3ohxXfiI3lq5GWxMU=;
 b=XfTujzKb52/AWob/D5e3RdzPz1i4tPMB0Xrdkj2kGQ24wC/uw0y0tLM9MnqoCf+Ko+YfWl
 Qz6oJJyy77vNgvVk17zSQr8dZ3OwpVLckVveLzQ9+HW8tEX329VZ3XWRqh1ubYMJ1mKnz+
 QzdbDpSjLAJ81s/mKN5aaN2KMb9cdLU=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=XfTujzKb
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 8/9] ptp_ocp: implement
 DPLL ops
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
Cc: Jiri Pirko <jiri@resnulli.us>, Bart Van Assche <bvanassche@acm.org>,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-arm-kernel@lists.infradead.org, Jiri Pirko <jiri@nvidia.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-clk@vger.kernel.org,
 Milena Olech <milena.olech@intel.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 06.08.2023 18:13, Simon Horman wrote:
> On Fri, Aug 04, 2023 at 08:04:53PM +0100, Vadim Fedorenko wrote:
>> Implement basic DPLL operations in ptp_ocp driver as the
>> simplest example of using new subsystem.
>>
>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> 
> Hi Vadim,
> 
> ...
> 
>> diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
>> index 32dff1b4f891..e4da62ac9a9f 100644
>> --- a/drivers/ptp/Kconfig
>> +++ b/drivers/ptp/Kconfig
>> @@ -177,6 +177,7 @@ config PTP_1588_CLOCK_OCP
>>   	depends on COMMON_CLK
>>   	select NET_DEVLINK
>>   	select CRC16
>> +	select DPLL
>>   	help
>>   	  This driver adds support for an OpenCompute time card.
>>   
>> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> 
> ...
> 
>> +static int ptp_ocp_dpll_frequency_set(const struct dpll_pin *pin,
>> +				      void *pin_priv,
>> +				      const struct dpll_device *dpll,
>> +				      void *dpll_priv, u64 frequency,
>> +				      struct netlink_ext_ack *extack)
>> +{
>> +	struct ptp_ocp_sma_connector *sma = pin_priv;
>> +	struct ptp_ocp *bp = dpll_priv;
>> +	const struct ocp_selector *tbl;
>> +	int sma_nr = (sma - bp->sma);
>> +	int val, i;
>> +
>> +	if (sma->fixed_fcn)
>> +		return -EOPNOTSUPP;
>> +
>> +	tbl = bp->sma_op->tbl[sma->mode];
>> +	for (i = 0; tbl[i].name; i++)
>> +		if (tbl[i].frequency == frequency)
>> +			return ptp_ocp_sma_store_val(bp, val, sma->mode, sma_nr);
> 
> val appears to be used uninitialised here.
> 
> As flagged by clang-16 W=1, and Smatch.
> 

Ahh, looks like it's not needed at all, thanks!

>> +	return -EINVAL;
>> +}
> 
> ...
> 
>> @@ -4233,8 +4437,40 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   
>>   	ptp_ocp_info(bp);
>>   	devlink_register(devlink);
>> -	return 0;
>>   
>> +	clkid = pci_get_dsn(pdev);
>> +	bp->dpll = dpll_device_get(clkid, 0, THIS_MODULE);
>> +	if (IS_ERR(bp->dpll)) {
>> +		dev_err(&pdev->dev, "dpll_device_alloc failed\n");
>> +		goto out;
>> +	}
>> +
>> +	err = dpll_device_register(bp->dpll, DPLL_TYPE_PPS, &dpll_ops, bp);
>> +	if (err)
>> +		goto out;
>> +
>> +	for (i = 0; i < OCP_SMA_NUM; i++) {
>> +		bp->sma[i].dpll_pin = dpll_pin_get(clkid, i, THIS_MODULE, &bp->sma[i].dpll_prop);
>> +		if (IS_ERR(bp->sma[i].dpll_pin))
> 
> The function will return err.
> Should it be sett to an error value here?

Yeah, you are right. And I have spotted one more place where err is not properly
set, just above this one. Thanks for the review.


> As flagged by Smatch.
> 
>> +			goto out_dpll;
>> +
>> +		err = dpll_pin_register(bp->dpll, bp->sma[i].dpll_pin, &dpll_pins_ops,
>> +					&bp->sma[i]);
>> +		if (err) {
>> +			dpll_pin_put(bp->sma[i].dpll_pin);
>> +			goto out_dpll;
>> +		}
>> +	}
>> +	queue_delayed_work(system_power_efficient_wq, &bp->sync_work, HZ);
>> +
>> +	return 0;
>> +out_dpll:
>> +	while (i) {
>> +		--i;
>> +		dpll_pin_unregister(bp->dpll, bp->sma[i].dpll_pin, &dpll_pins_ops, &bp->sma[i]);
>> +		dpll_pin_put(bp->sma[i].dpll_pin);
>> +	}
>> +	dpll_device_put(bp->dpll);
>>   out:
>>   	ptp_ocp_detach(bp);
>>   out_disable:
> 
> ...

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
