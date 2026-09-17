Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95ED1C982CF
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Sep 2026 11:13:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C76E280F66;
	Thu, 17 Sep 2026 11:13:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jQE183LDToC5; Thu, 17 Sep 2026 11:13:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A399B80F4F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789643629;
	b=FvGUmSDd9kUbjFFeJlEYp/fNTmX532opWNm3AtEV+vwTSzd395w/zFijS+phoEM+gYsk
	 Sp16x/D4oBCOZe8x1MD4chg9nxuPKBP9PWzPjI9ljoqhUM5xmDSizHZMDfZQCIJQDOuNy
	 /VzLp/Lvw6aBjcelVfPrx9wMwCP1h45NYOVbAcfdueJnzq/a93fmTw3AfNQdhial9EMSV
	 AVu+UTxei2syJEnyEUBU98swTFAK5BZYomGQba9asxRtPHyVxedMrF5AwjXmOYX/0prLv
	 TuunrWVc5te/uxQtcJ+2+v3OorB7QVsUf9GA4ImfMD6Akx0NPi/PdKcLVHq8p1zVzvw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789643629;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ugkZvHY8M4baNm0OaUOuPZx4bPzR30VWOKhrqoA5hX0=;
	b=DNsE02buicoB7fjig16nxwxr0yqp/huOIR/fo3UVE7x5Bf0tFqRaAl5VSAZTDZTPhq0J
	 PvIIiwrzCPPtgjltFKI6QZvzmW0TSrsC9J9oR9+ta/f2CTDJi2LUTu6QBRlE8CaSkzU9t
	 Oty1O6UK7Z4TgbofoLA2uOzIwTXEJtY+JuBSSfaHTxrHwo9p9Wj2zeu2BcAt00OovTKbi
	 XOrHakLEJD0IlFfHVeR5i11GNkQQ9A0/EynBra+74XjS0bTmsp0rVZ5I+ddw+MAFoeQju
	 kXC34H2BnMSX1nLJjSengVb+F2Rxh8nuYR+nm2GbjuoPUfMjFLT7jV796VWI17AcIrw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789643629;
	bh=ugkZvHY8M4baNm0OaUOuPZx4bPzR30VWOKhrqoA5hX0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DAJER7lihjwxmjyVbMk+mB0e1dEW0QA/Y9rdX6Fi2yrIi5dOVdtUmeFd+rUT2TXyf
	 7ijsKwChzT02NYkXrAUF7KM7/N83CfT/4+o9m3F37VtoEWPCjoI2iq1SiYR1IP7+Bs
	 NLgaHlX8YK/R4Jid0NBRZ/mT0Ctlm5QTLWPgr8SRG7HLsM6Yh42GL1J6ADY2lfmx4p
	 vZwkbne+M7GL8XjhF71ZjyCkQ9fBTYDrqBAtkA66GtRaiCppPo9Q4QjMRrh7w9DtYd
	 22WXkawIpGX5sMc519v285soaK/st86uSpal6SulShfy1LgA5nDSDeAHWhpXG5Micx
	 13WpC03+yvcZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A399B80F4F;
	Thu, 17 Sep 2026 11:13:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EC42523F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 11:13:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D19976085E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 11:13:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MJcPmiGpt3Mh for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Sep 2026 11:13:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B893660659
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=220.197.31.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789643626;
 b=DM4/KVjNPdFphNnCxraoAouFatqZNDzt5ujsTivq81XOIJYqm/+oq/a59WjaToQpclON
 dI6+dR28DtLwW3y8IE3COPrxuwhs8Tady0anyED9UJNhUZ/0eHJrWnyddFsSeoS58T3mI
 mzbjZQCbi32RsnE+njRpZQjb1eet/Yt1ifDsw82XgqtqN09kBdBlTrNjpq87JawXsH9p2
 1ORTPyCnROtUXnjlRmsP9TwZlyucFVmMpZsnEoyBsMHf8Mmf32TVVYCD3IjvZe1onYIBn
 CALX4jSR0zQTiwa0LFVyJEMdkIr/PA+Wgs0rC6D6H+5ja4qn2x9GtzxPgHUtCrLBeMw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789643626;
 h=Received-SPF:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
 X-Coremail-Antispam:X-CM-SenderInfo;
 bh=ugkZvHY8M4baNm0OaUOuPZx4bPzR30VWOKhrqoA5hX0=;
 b=FMDbryPFKTFaFFwdX1fOY2q1Z4TeEh8Xkp1wSKSNOwbk0gj0kmZp0/TehAnEwbJNFL3T
 9du3LQCBPO23OwRYBB3CcdOKdma4hcnADfgAhtRj4zGZSeJk4Po73VZ/xQCOKt08qJzLy
 HNIo2wRbIba1Nfy7mBMo7AhIURZVSCQDz81MKDfNcKLJoUyiVVV2UCgUzJda4Tpz4Gagm
 AgzDUU9mF34/3wzxsdGIT1PHhBxDSfAz8VKRIw5MJsp611TsQe1rOZk5p+ln/mc21I0yw
 FNVWha9w1WVjSlk2eWXvS1OtpJ8oMthLA/s4F//iMQVRAOMn4SMiGWAt7T6u9RVIhBw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=126.com; 
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=KgxfjJ+i; 
 arc=none smtp.remote-ip=220.197.31.7
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.7;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=KgxfjJ+i
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B893660659
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 11:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
 Content-Type; bh=ugkZvHY8M4baNm0OaUOuPZx4bPzR30VWOKhrqoA5hX0=;
 b=KgxfjJ+iEtCX4qom4lWLCyTIaSTYcPC9+BlixsqhbCdTu/CD6kmAkeXuFiPd7h
 MT8pi2rch9R1FnlLOrRhroD3sMYjHiaHTNDdam/WauIXrUCzroGVBckyHjp9x5cr
 NNuDJbrLFwf3/16EuLO3aQSlZ8Fm2Un4aCKUXAyFBBhtA=
Message-ID: <44959d96-2572-4dd7-a79b-493110cc002e@126.com>
Date: Thu, 17 Sep 2026 19:13:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net v2 1/2] ixgbe: do not busy wait in
 ixgbe_devlink_reload_empr_finish()
To: Paul Menzel <pmenzel@molgen.mpg.de>, Linkui Xiao <xiaolinkui@kylinos.cn>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jedrzej.jagielski@intel.com, kees@kernel.org, aleksandr.loktionov@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260917065436.1181073-1-xiaolinkui@126.com>
 <7107796a-a233-4ddf-9106-460de575f29b@molgen.mpg.de>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <7107796a-a233-4ddf-9106-460de575f29b@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PikvCgD3v5xBy6tqbW4wIA--.23370S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr4UtF43tr1rGw1kAw48Xrb_yoW5Ar4DpF
 WUWFn8Aws7Xr1Fg34Iva18ZasIva1Ig3yYgFyftrZ8Zas5Arn8tr1Utr4Sg348Zrs8Ww10
 vF4Y9rs3AF45AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZeOXUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqAKIX2qry0JfIgAA3I
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



On 2026/9/17 15:09, Paul Menzel wrote:
> Dear Linkui,
> 
> 
> Thank you for your patch.
> 
> Am 17.09.26 um 08:54 schrieb Linkui Xiao:
>> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>>
>> ixgbe_devlink_reload_empr_finish() is the .reload_up devlink operation,
>> so it always runs in process context with the devlink instance lock held.
>> Its polling loop delays with mdelay(500), i.e. it spins the CPU for half
>> a second per iteration and, because the loop bound is 20 iterations, for
>> up to ten seconds. That keeps a CPU fully occupied while the firmware
>> performs the EMP reset, and on CONFIG_PREEMPT_NONE it also makes the
>> loop non-preemptible for that whole window. The loop does not need to be
>> atomic and holds no spinlock.
>>
>> Use msleep() instead.
> 
> Should you resend, please document the commands how to test this, for 
> example, how to trigger .reload.
Hi Paul,

Thanks for the review and the Reviewed-by.

I don't have an E610 adapter available to actually exercise the devlink
reload path, so I can't provide a tested-by or a verified test log. The
change is a mechanical mdelay() -> msleep() conversion in a sleepable
process-context loop; the rationale stands on its own, but I understand
if you'd prefer to wait for someone with the hardware to run it.

If you'd still like the test commands documented for reference, I can
add them to the changelog, but I want to be clear that I have not run
them myself.

Thanks,
Linkui
> 
>> Fixes: c9e563cae19e ("ixgbe: add support for devlink reload")
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
>> ---
>> v1:https://lore.kernel.org/all/20260914092626.263886-1-xiaolinkui@126.com/
>>
>> v2:
>>    - Reworded the commit message: mdelay() does not mask interrupts or
>>      disable preemption, and the ~10 s window is below the soft lockup /
>>      RCU stall thresholds.  State the actual rationale instead.
>>    - Split the macro rename into a separate patch.
>>    - The mdelay() -> msleep() change itself is unchanged, so the
>>      Reviewed-by tag is kept.
>>
>>   drivers/net/ethernet/intel/ixgbe/devlink/devlink.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c 
>> b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
>> index cf8908b82f8a..781f13240a0d 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
>> @@ -460,7 +460,7 @@ static int ixgbe_devlink_reload_empr_finish(struct 
>> devlink *devlink,
>>            * may be not cleared yet, so begin the loop with the delay
>>            * in order to not check the not updated register.
>>            */
>> -        mdelay(500);
>> +        msleep(500);
>>           fwsm = IXGBE_READ_REG(hw, IXGBE_FWSM(hw));
> 
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> 
> Kind regards,
> 
> Paul

