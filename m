Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A134C88E75
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Sep 2026 00:28:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C20080D16;
	Wed, 16 Sep 2026 00:28:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SES2wOdoeLcJ; Wed, 16 Sep 2026 00:28:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 131B380D1C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789518496;
	b=AxPQ18N5FH23p9L00pDHuVm3BS+Gv//XIIN15dyCqZyhlsPgVZWarrj8+wq0vuquOSA8
	 H3dcM+xyRWgQSrAvvT0iZZIlgrvB3DNeGyHIJZ2bqFJENvu1N6fjv+xBaP3YJVCex6322
	 iqlN2BABLgfm5MqR9RRSZwgZqkDlKSm5TCe3d61bK332n0gZJ0izqgUYFRor5G5tbWFEF
	 tdyCL86QrO0EukTAjNl81I8X+yeaspdE0rY2Wrv7hC38ghUtAVNZjfc8EIJhTsILwtVh7
	 IlXVZMJ6mUa10HFvwGlznNXoF+rVZcP9eVLKcfL5dK0gALwQeU6F27P96QA6nvpVogQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789518496;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2zmHRFdTlNJTWZ2YTgH3+XapaGG7xJUHGS4YejvCz70=;
	b=ep+J+JNIQokhrCAorDbksVmKDD/T0xhUIxR23Jy4zl2EGg3sOAttey2m8plmnXD1lJy3
	 W1R5JJ/oHkcCWPeC3gVvEUAmEtq4hO+Ma/xfVlB3Dd0TEQH9Zl5nv15ykecCN/ZKj/Yqw
	 +0n33fxo+np30HHeuobXyQ924uAJ4rZHtG3ZNl2kQwFSMxtZMwHhV1JR/lANa4TJTTYsf
	 1VdVIoCn5Nk8VjLV5eCrQZuULNvcL++kIjy/3P5j72lqNBOkHyQCgeIkffaSJLie+zoJ/
	 IkQHd5aqQDUSE4uaCq1QbN/jJSlc6EU1Gn40E3WkIlVaXUBVcuTwQfvbNobFzOX10+Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789518496;
	bh=2zmHRFdTlNJTWZ2YTgH3+XapaGG7xJUHGS4YejvCz70=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CpcKFiuS2zGFnaORQrwFPIf1cIq3lsUsdeGs+RwnQoCuwVP3rjo1T0f+mn/0nf0HJ
	 6rj62IZpJPSWaMGBfTS3bXg8h7M+l4bXk1al+j02ouOs/mEtsBdiR6/aPB3ykrPEqA
	 fgCTD+iuwFYRFhmICS6P2K6Td7Q8/lvRRXehg+VEj2dBLnGkas8HQNK6IF2YID3017
	 XhKcOZGL3agdogkT4bXSr5wJG0s3RAy++JqVyCXIo+eoE+SDRHLth6foSvtBqzp39I
	 tvgAijs8DeU86jlatR9ULF8TuFwT/cLRWLLigAQ1yUyNybZspHZUVMyVFXEirXHkQ2
	 L5NVdTJfrMJlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 131B380D1C;
	Wed, 16 Sep 2026 00:28:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 263B92E3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 00:28:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 239B3607B5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 00:28:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YBxEvCYAaOeL for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Sep 2026 00:28:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E899E60792
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789518494;
 b=VffwoZM+gdEO4GTSYAE2FRzkkh/B71RvBf+nNOCLFwUhvrmcRlPrLjz2q2bwNGXdwOsR
 LKv5dZNuUG5BmvNM1pdzpPUwaS4GO4uSSyXZhYzA6iNv+lTueaLcx8tXIWaf6hOek2h/e
 EizW7EdfEGzO3Puh6OOq2+L6d/SLXPQWnU+yj1mmEoZuKQQHCyW7Xtnuypm59Kdmnh4mp
 XINUFA3xd0BsgwmbqMda1wG0XtgnK6YHtAknLu1JdZfOEXpjcW7Vvp5/cQZfd8zCgog+9
 9KfWiNm4o21bmwBYuPMr9ppUa2fcKaSIo1al5N7x9NWHKg7M1EGwbuE+5qBCETPq2Bw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789518494;
 h=Received-SPF:Received:Received:DKIM-Signature:Subject:From:To:Cc:
 Date:Message-ID:In-Reply-To:References:X-sashiko-severity:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=2zmHRFdTlNJTWZ2YTgH3+XapaGG7xJUHGS4YejvCz70=;
 b=SlquO5gSUFtBmxBsWC9FPAq0fJGycaoBAPhXuw4EZ239nKMN/u7GD9AQJ7R7LsDVmkJ6
 KJNqPR8VzcSpGq0ZfoAD61FBrsaq4XAfafMsTKhO/O5cgWNjpzbpYooJg9DcNfbWE7YmW
 eVerr/44vhj9A/urbFU6zekt0GIfSNCJzBbDJdyGrNy6KVSnm2o88fHBZvR8gJQbcTPMd
 GUM/LbaAX5nHXXFdlz2buAk7IZMm/YsfM/Zp2PCkIIlwYD6a7GPY/EoITIFFgVj13gZST
 ka5mrnlNAMOsLTyU1WAte4HExGekIhdUg/Ktqx2GOzMIysFDIy23lRDgNPwDW/qzLyA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=h2anxolS; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=h2anxolS
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E899E60792
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 00:28:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B8F9060008;
 Wed, 16 Sep 2026 00:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6EE21F000FF;
 Wed, 16 Sep 2026 00:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789518491;
 bh=2zmHRFdTlNJTWZ2YTgH3+XapaGG7xJUHGS4YejvCz70=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=h2anxolSckCnGkH4gp4TqdRdlaE9ERFilKHeERzT/qziDzzVSoBZJsbxIy+nmEtyJ
 6BRMgdZwHio6LGUI/96N6b0bpJeurLOTWnvG7LZt24uQVwB1iNEPWqK9ptibABAZwd
 uOl0vgZPmR1kzwLiQdjF0RWqIp4mXnIl7B21dhS0IHKK1sl54si+jYoKWp0NV1jCJv
 itha2tr2Gp82MEHtIjxroD+XiSUB3I/Un+YXhtirXf/BBxTIM9Uxw1i5YOtNHsY5iV
 0JMqHopdIBs2KYjNaHIGg8ZZnKLPw2q5hsjKDkeuhwJ4vmNFykJxfjWS3ROMeOlRm8
 PgWYbvh22aJqQ==
Subject: Re: [PATCH] ixgbe: do not busy wait in
 ixgbe_devlink_reload_empr_finish()
From: netdev-bot+sashiko@kernel.org
To: xiaolinkui@126.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, xiaolinkui@kylinos.cn
Date: Wed, 16 Sep 2026 00:28:10 +0000
Message-ID: <178951849042.22033.2945172314296253214@kernel.org>
In-Reply-To: <20260914092626.263886-1-xiaolinkui@126.com>
References: <20260914092626.263886-1-xiaolinkui@126.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 (2) · Low: 1

- [Medium] The commit message justifies the mdelay()->msleep() conversion
  with technically false claims about mdelay().
- [Low] The patch bundles a purely cosmetic macro rename
  (IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC ->…

Pre-existing issues:
- [Medium] In ixgbe_devlink_reload_empr_finish()
  (drivers/net/ethernet/intel/ixgbe/devlink/devlink.c:455-470) the…
- [Medium] The EMPR completion poll in ixgbe_devlink_reload_empr_finish()
  treats an all-ones FWSM read as 'firmware valid'.

--

ixgbe: do not busy wait in ixgbe_devlink_reload_empr_finish()

This converts the EMP reset completion poll in
ixgbe_devlink_reload_empr_finish() from mdelay(500) to msleep(500), and
renames IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC to
IXGBE_DEVLINK_RELOAD_TIMEOUT_TICS.  The commit carries a Fixes: tag
pointing at c9e563cae19e ("ixgbe: add support for devlink reload").

A few questions on the changelog and on the polling loop below.

> ixgbe_devlink_reload_empr_finish() is the .reload_up devlink operation,
> so it always runs in process context with the devlink instance lock held.
> Its polling loop delays with mdelay(500), i.e. it busy waits for half a
> second per iteration and, because the loop bound is 20 iterations, for up
> to ten seconds with preemption and interrupts to the timer subsystem
> effectively blocked on that CPU. That is long enough to trip the soft
> lockup detector and to stall RCU grace periods, and it keeps a CPU fully
> occupied while the firmware performs the EMP reset.

[Severity: Medium]
Is this description of mdelay() accurate?  mdelay() is a plain udelay()
loop:

include/linux/delay.h:
    #define mdelay(n) (\
    	(__builtin_constant_p(n) && (n)<=MAX_UDELAY_MS) ? udelay((n)*1000) : \
    	({unsigned long __ms=(n); while (__ms--) udelay(1000);}))

There is no local_irq_disable() or preempt_disable() anywhere in that
path, so timer interrupts (including the watchdog hrtimer) keep firing
and the loop stays preemptible on CONFIG_PREEMPT kernels.  In what sense
are "preemption and interrupts to the timer subsystem effectively
blocked on that CPU"?

Are the two detectors named here actually reachable at the stated bound?
get_softlockup_thresh() in kernel/watchdog.c returns watchdog_thresh * 2,
which is 20 s by default, and RCU_CPU_STALL_TIMEOUT defaults to 21 s, both
above the ~10 s worst case described.

Since the changelog is paired with a Fixes: tag, could it be reworded to
state the rationale that does hold, namely that spinning a CPU for ~10 s
in sleepable process context is wasteful and needlessly non-preemptible
on CONFIG_PREEMPT_NONE, rather than citing soft lockup splats and RCU
stalls?

> diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
> index cf8908b82f8a3..7ce0a0cbf9d2a 100644
> --- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
> +++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
> @@ -430,7 +430,7 @@ static int ixgbe_devlink_reload_empr_start(struct devlink *devlink,
>  }
>  
>  /*Wait for 10 sec with 0.5 sec tic. EMPR takes no less than half of a sec */
> -#define IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC	20
> +#define IXGBE_DEVLINK_RELOAD_TIMEOUT_TICS	20

[Severity: Low]
This isn't a bug, but would it be better to keep this rename out of a
Fixes-tagged commit that also carries the behavioural mdelay() to
msleep() change?

Also, "TICS" reads as a misspelling of "TICKS", and "tick" in kernel
parlance means a jiffy/timer tick rather than an arbitrary 500 ms poll
iteration.  What the constant expresses is a maximum iteration count, so
something like IXGBE_DEVLINK_RELOAD_MAX_ITER, or a bound stated in ms
next to the 500 ms step, would say what the value is.

>  
>  /**
>   * ixgbe_devlink_reload_empr_finish - finishes EMP reset
> @@ -460,11 +460,11 @@ static int ixgbe_devlink_reload_empr_finish(struct devlink *devlink,
>  		 * may be not cleared yet, so begin the loop with the delay
>  		 * in order to not check the not updated register.
>  		 */
> -		mdelay(500);
> +		msleep(500);
>  
>  		fwsm = IXGBE_READ_REG(hw, IXGBE_FWSM(hw));
>  
> -		if (i++ >= IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC)
> +		if (i++ >= IXGBE_DEVLINK_RELOAD_TIMEOUT_TICS)
>  			return -ETIME;

[Severity: Medium]
This isn't a bug introduced by this patch, but since the patch renames the
macro to declare its unit as tics and touches the delay right above it:
does this loop really perform the 20 tics that the macro name and the
comment advertise?

With i starting at 0, the test is false for the pre-increment values 0
through 19, so the check first fires on the 21st pass:

    do {
    	msleep(500);

    	fwsm = IXGBE_READ_REG(hw, IXGBE_FWSM(hw));

    	if (i++ >= IXGBE_DEVLINK_RELOAD_TIMEOUT_TICS)
    		return -ETIME;

    } while (!(fwsm & IXGBE_FWSM_FW_VAL_BIT));

That is 21 sleeps, i.e. at least 10.5 s, and more once msleep() rounds up
to whole jiffies, against the "/*Wait for 10 sec with 0.5 sec tic." above.

Separately, is the fwsm value read on that last pass being thrown away?
The return -ETIME happens before the while() condition is evaluated, so if
firmware sets IXGBE_FWSM_FW_VAL_BIT exactly in the final 500 ms window,
devlink reload reports -ETIME even though the read already showed the bit
set.  In that case *actions_performed is left unset, the
IXGBE_FLAG2_API_MISMATCH and IXGBE_FLAG2_FW_ROLLBACK bits stay stale and
ixgbe_refresh_fw_version() is skipped.  Would moving the bound check
before the sleep, or testing fwsm before returning -ETIME, be preferable?

>  
>  	} while (!(fwsm & IXGBE_FWSM_FW_VAL_BIT));

[Severity: Medium]
This is also a pre-existing issue rather than something this patch
introduces, but can a failed register read end this wait early and be
reported as a successful firmware activation?

IXGBE_READ_REG() goes to ixgbe_read_reg() in ixgbe_main.c, which returns
IXGBE_FAILED_READ_REG (0xFFFFFFFF) when the adapter is marked removed, and
otherwise funnels an all-ones readl() through ixgbe_check_remove():

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:ixgbe_read_reg() {
	if (ixgbe_removed(reg_addr))
		return IXGBE_FAILED_READ_REG;
	...
	value = readl(reg_addr + reg);
	if (unlikely(value == IXGBE_FAILED_READ_REG))
		value = ixgbe_check_remove(hw, reg);
}

ixgbe_check_remove() only tolerates about 15 ms of unresponsiveness before
declaring the adapter gone:

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:ixgbe_check_remove() {
	for (i = 0; i < IXGBE_FAILED_READ_RETRIES; i++) {
		value = readl(reg_addr + IXGBE_STATUS);
		if (value != IXGBE_FAILED_READ_REG)
			break;
		mdelay(3);
	}

	if (value == IXGBE_FAILED_READ_REG)
		ixgbe_remove_adapter(hw);
}

0xFFFFFFFF has IXGBE_FWSM_FW_VAL_BIT (BIT(15)) set, so the while()
condition above is satisfied by a failed read.  The function then sets
*actions_performed to BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE), clears the
API_MISMATCH and FW_ROLLBACK flags and calls ixgbe_refresh_fw_version(),
which issues ACI commands to a device the driver has just flagged as
surprise-removed.

Should the poll reject fwsm == IXGBE_FAILED_READ_REG, or check
ixgbe_removed(hw->hw_addr), and keep polling until the timeout instead?
This depends on whether the E610 memory BAR actually returns all-ones
during the EMP reset window, which I could not confirm from the tree.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914092626.263886-1-xiaolinkui%40126.com
