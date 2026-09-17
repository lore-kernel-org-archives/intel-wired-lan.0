Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1C4C982C1
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Sep 2026 07:11:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD2C780E25;
	Thu, 17 Sep 2026 07:11:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id glmd5yU1yuVl; Thu, 17 Sep 2026 07:10:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E201980E19
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789629059;
	b=Kr/Wjs0TchKgpuvBOi6Gg3AI103HpNVX9XPi9G+k4LCWa7XiIH1naTqb++dvEfx23C8Q
	 G+RGfbQi3Z++ZTEOPVLxUwcBGRnLF0ZXUGwQ17qlkmzoqerHtFaCwCzGoYgdspBXiVJjD
	 B5xA44RJyGUSzixKya/FHjDjpwe+k+tGYOGQuAoun4sKmlJvbrrPuwgYWfqmTwIet1AUN
	 b0bOOB0ppUD4SMt0Lpny5asV0AUKTJYs/1Lq+7dXJYOV1PJr832AJuNe2HWvqmwznGiri
	 tDnyq0RBDHPG1l//pd0aR20A50w/VeBEhxAb5DooYg024gzsUS59EPKVNp/2KtrUFDA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789629059;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:DKIM-Signature:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hS+daQcmSuh57lLpq5vbnK6PgZknYEP3Fmnjb15/5kI=;
	b=CisKpoWaPcycAOaCaXPOlXGCa+43pTB5ttRxvw2jmzx36eP5XW8M5WfbcTqiTVBysu3u
	 sUoNY2Leac/VgXHrgmvc2CxEzyAN58sxmtPYiHXBicqj95y05usLCrS13fUQJFe2iRQ+k
	 o7/j7T9PUH5sRTXwcQLwHvAP09IaNWMT2ww+VOyRJApQsu4C7pSNXu/ac3wVyBi/UsrR4
	 zeApB/K3stZ6IA5ID6ZbTW4TXJ2y9p+qQ4xvarR8yZubGedTHQyrN3QgnNZf1sPDUb3QF
	 7Qfw7bKe2ASHwwi3CR5HRim/zvJXn/qcIV4S6x4YvnrLTse54vDQOiUcj0Uij+O18Ug==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789629058;
	bh=hS+daQcmSuh57lLpq5vbnK6PgZknYEP3Fmnjb15/5kI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BcwJ0Xsz52EC03NCb6MrmfkEW9Qx31UF0a261x2JVGW9Myaaa1evWyK0v5biecnuF
	 sXPSWfxWMw/GFqzI8mfS2CLX/cPaZyM55SK8hOdtJ89S3V8JYSOKUaUZ1P6EK+hWnD
	 9/57xzZP7G5Dj6mhnK9aBpU0SLM2bWBjpN/pkvnk9hLv63BvkHL0nPmc9XTnyFuy1P
	 mDIbw2fW91acw8fags4qCMwRbHfG+nnZepjbJygRB6z/QtXewoE+6YHOJhqHVLmGIM
	 0N3S4ZA3Q5xxQwYu2kdjlzAKsEenSX22Bo1Tt9l0r+Nkncj2IPX/w/n5ERponYSW06
	 A1f4sNVu3Hy0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E201980E19;
	Thu, 17 Sep 2026 07:10:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5644C43A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 07:10:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5083B400F3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 07:10:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7mDxRe101emZ for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Sep 2026 07:10:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1E5534005F
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789629056;
 b=S6Wia3OiDE9XHWQ59mXoBjAvDMZNRBw10ZD4BkyHO4qMPbw4nZLwKtfLWehTHk7aRuvL
 e+FMF0uzCTvuYmHTvU3Q805yQLbHtP6/4vwt+415Z532iTH+wF5U/0r9jBj5bPUMgZ7/A
 Mt38utWZEJtiBkNUskaYmQOKg1K4PMnByhhxqR+gVghH3YIu+3i/dk/U+rjRCqTDogkpg
 2HbqenkGqolKZtYLvKvffpaqTO+1mLFYoCziKA/uhiCNqHTQbUDoi5Mh7s+s6im1cV6VX
 v5WCIPZtMxg2m7e7PADPNCwxgF4/s87wyZ4h+lIgtCyh03ipTt4z+s5oUrUXBsWMv4A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789629056;
 h=Received-SPF:Received:Message-ID:Date:MIME-Version:User-Agent:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:DKIM-Signature;
 bh=hS+daQcmSuh57lLpq5vbnK6PgZknYEP3Fmnjb15/5kI=;
 b=fVv+HnAmtHfGkG3KUxOPriIjd+kUQIonPaBvk7YuyVf3NlZp+zZTJbGin/YDGxppd3UX
 /bKn+1hlvUn+2cnLn3Smvx62Iqh+q5vN5n38IyeyeFKebkbWBbZiMuJIot8Uzy5y3AInL
 S4P7XP4oJxkj5NIx0BvTwmgIg1WR72N5M6RpZhHsQF6/Aiwf1Pkq7HQEz1Bi10l6I2hWY
 Lqupe8MZfxm373Wo+JhMzajXrY1YJ4uSXLOz9hU7mtP+9/yuTdx+sN67pgfKL+jMPHUVQ
 7Ta64QoAeZtvqlhL4/kdx7g7WTwNdqaFqNvSF2s1JsJkQu94bxIFIldydGe63Q82XBw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=molgen.mpg.de; 
 dkim=pass header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256
 header.s=20260906 header.b=Pt9a8Tz2; 
 arc=none smtp.remote-ip=141.14.17.11
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=molgen.mpg.de header.i=@molgen.mpg.de
 header.a=rsa-sha256 header.s=20260906 header.b=Pt9a8Tz2
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1E5534005F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 07:10:53 +0000 (UTC)
Received: from [192.168.2.217] (p5dc55dbb.dip0.t-ipconnect.de [93.197.93.187])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8E2E24C442F868;
 Thu, 17 Sep 2026 09:10:01 +0200 (CEST)
Message-ID: <7107796a-a233-4ddf-9106-460de575f29b@molgen.mpg.de>
Date: Thu, 17 Sep 2026 09:09:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net v2 1/2] ixgbe: do not busy wait in
 ixgbe_devlink_reload_empr_finish()
To: Linkui Xiao <xiaolinkui@126.com>, Linkui Xiao <xiaolinkui@kylinos.cn>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jedrzej.jagielski@intel.com, kees@kernel.org, aleksandr.loktionov@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260917065436.1181073-1-xiaolinkui@126.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260917065436.1181073-1-xiaolinkui@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de;
 s=20260906; t=1789629003; 
 h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding;
 bh=hS+daQcmSuh57lLpq5vbnK6PgZknYEP3Fmnjb15/5kI=; 
 b=Pt9a8Tz2IF3GKh0P1Pq85zeCW6wCNSiaDvzR+1JrOinqC65iPGgmXZOI46eoxoIt0qmZLfD3KSkv
 /YB23ECsoufSGGvwEXOHn78OjfKpST/Nym61pwSOYCbL3Dd0TB+le0iSCZyVNTcFGAXMBrEAcZQtqn
 F1xlGfmr28897Zr2C5DSFicekSAFYf19fOpHjqNqx2g1/XCyqkPll1XpZpuf3C0SB+6bbXm/7kaFFv
 eGPeM5BOx4viNkfi1NbgH8vDYPRRh/3iWWsfwd7ZsL61K4MNNwKID2Pm71jcZ8+KzO2dSI8eQbB2jz
 eYxgvlENNX+CsSIxZ61pGYiRbPyI4mKQ==
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

Dear Linkui,


Thank you for your patch.

Am 17.09.26 um 08:54 schrieb Linkui Xiao:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> ixgbe_devlink_reload_empr_finish() is the .reload_up devlink operation,
> so it always runs in process context with the devlink instance lock held.
> Its polling loop delays with mdelay(500), i.e. it spins the CPU for half
> a second per iteration and, because the loop bound is 20 iterations, for
> up to ten seconds. That keeps a CPU fully occupied while the firmware
> performs the EMP reset, and on CONFIG_PREEMPT_NONE it also makes the
> loop non-preemptible for that whole window. The loop does not need to be
> atomic and holds no spinlock.
> 
> Use msleep() instead.

Should you resend, please document the commands how to test this, for 
example, how to trigger .reload.

> Fixes: c9e563cae19e ("ixgbe: add support for devlink reload")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
> v1:https://lore.kernel.org/all/20260914092626.263886-1-xiaolinkui@126.com/
> 
> v2:
>    - Reworded the commit message: mdelay() does not mask interrupts or
>      disable preemption, and the ~10 s window is below the soft lockup /
>      RCU stall thresholds.  State the actual rationale instead.
>    - Split the macro rename into a separate patch.
>    - The mdelay() -> msleep() change itself is unchanged, so the
>      Reviewed-by tag is kept.
> 
>   drivers/net/ethernet/intel/ixgbe/devlink/devlink.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
> index cf8908b82f8a..781f13240a0d 100644
> --- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
> +++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
> @@ -460,7 +460,7 @@ static int ixgbe_devlink_reload_empr_finish(struct devlink *devlink,
>   		 * may be not cleared yet, so begin the loop with the delay
>   		 * in order to not check the not updated register.
>   		 */
> -		mdelay(500);
> +		msleep(500);
>   
>   		fwsm = IXGBE_READ_REG(hw, IXGBE_FWSM(hw));


Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
