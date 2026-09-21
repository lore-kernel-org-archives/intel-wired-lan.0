Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129B4C982DE
	for <intel-wired-lan@archiver.kernel.org>; Mon, 21 Sep 2026 06:34:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3EC160608;
	Mon, 21 Sep 2026 06:34:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lfkDI2nUjhFu; Mon, 21 Sep 2026 06:34:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C664860628
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789972490;
	b=gg0iPDIND98169lyDJ7r8rgBG6CtvQIX7+tQbHvqNtU+0U35fxN6TJNAwGR7jREI8afL
	 KBoEd8W77CzyDVrEcJ37/0FI4LwmmfMMHkApJJG9OJaMrAEh6s5ghGdzvDHaZo46fwFCW
	 pUO6KqnZ21zURvN+ms/HZrTOwwAlQbMrvEVITCAIM6vUQ6/dtm6EygnPpCLLu4WL3ZmkO
	 1zAfi2KakCRxILIKo0s96yXnfpGja1s99lkLhAkolGaF1mUBKZ2U0VYlh0Q4t4IW+WY+U
	 40w7ZTtOwTuhrY6nB3YX09WMLPyGhPEHqLtrnJu/SHKLDy6DncLDvHFfS5GQcOkVkZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789972490;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=H4cMmy0ekBDJfQRFfeZWaWIlR0+1gBW66rPbCmzLgEo=;
	b=KwuOs0FMpwvfJalaoexxAZG16eLUsioEtx/JAiseFi/j47juLBaMCHiVfFXDp+Mu2nui
	 jO6TH06KhQwMjqYEQr75bRqQihaG5rMkzJRsaycZw1j5KCD9HiWjPQoYoHSHDtmw0S7+F
	 vmkjEnRbEOh6GUuApGmTww9m84kgvNop4Jl8WXc2tpq8NaZjpmZ3MC+CG4cC2/q3qgR4J
	 Rt9Z+fUHmeCZDCoTawvqJasFy2/d6KHCYI1Dyj/KWRVgmHcBMF0EtozgPOy1KIlTqd89W
	 l2CH5HXHdRKOgRrWsJrmR79/gd8n3CCopx6IftpSgCT0ESEhoX50rlhAs0/vjxyZj2A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789972490;
	bh=H4cMmy0ekBDJfQRFfeZWaWIlR0+1gBW66rPbCmzLgEo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1vCkLky2rbBXzhoMZIstc7tBwyHVLKvIGao7ZStR5wiQZ6n/HrWtgCy6roqV5VYR2
	 XFffkXirlw5eUy2qfWPzMkN2xwkuCWnkVvETwalmur6vEDkXtBJgkKaTZR2nJFvHIO
	 tPasAuvQnuN9EA7JrrTGTkHIQLr9BCvV85082twJAxqzrhYdwMDlPyb6RrtjdgIRrJ
	 2CULO3/8ipatssNSXshrIhIoAKAPmJbg3hIUidcsToPoOcPTAkRee/Ncw1Tt77itBa
	 JdJKiLSr8ShAAHfMz8d37tRHlmGP99Xu7TxyXZ2awaHRx3avl4VHNeS9GBW6YM9Fmx
	 dzliCaXUQ4RdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C664860628;
	Mon, 21 Sep 2026 06:34:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E0902392
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 06:34:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C67AC40BA1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 06:34:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1YznMrqB11aT for <intel-wired-lan@lists.osuosl.org>;
 Mon, 21 Sep 2026 06:34:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9785C40BD5
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789972488;
 b=oxGfznyJu5eGnxetaZAA3ne8WXFC77kNxQl6JT1Z2e+YunNaZboQKi9GbfJKQH+x4JHM
 +pWNknZa10CusEfsn67Lv6sRe+osMN//QOiYSfKvumMGJZTxA/gFjhqfGb57fueFnIJ65
 0Q+HCdNaZ1bLyhRgO8id1jpAWuYed3E8hKAGfB3of9JXe1eYo6Z+zjsCQAFk4WusGOxZ4
 OLgLrXzPDhBKB1Pfb4ajdXSYIqPmm18s46qWLsLb9vMfGhRuxsvozsi7Mq8zhVj0ir7vG
 QUd85scgNQVfa6eCQQXnPNLTjV2OckxIO+UIcpVCWxzI5QNQ6/A8wKzSSpLcSYN09TA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789972488;
 h=Received-SPF:Received:Received:DKIM-Signature:Subject:From:To:Cc:
 Date:Message-ID:In-Reply-To:References:X-sashiko-severity:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=H4cMmy0ekBDJfQRFfeZWaWIlR0+1gBW66rPbCmzLgEo=;
 b=HXytzsfYNuddfhQICHsD0NCDqpRLr0Cyi3POxnob9SQwYGfXlT4wmQEfit2h8nGjy+4c
 JfTj/gWjr7jXVisqhPLmbLxy3vHfUzBdKPDNc9HYZXeGA6B12k4VzX14mn8EN+yvG19FF
 Gd3pv07VdqQd4mP/5cktMdNfyn/LZ6+iBtOblsCys/j8sMNz/o0Tc9ZxJHZylxHMLIiWe
 dq0QzJIGw5MNvZwj5X/XycYizDiKcHTXYn4ir/BvhJl5pyLiDVdXcKJ/k11BUq+w9E3DN
 W3V7TtyrNBavQtOUAMataYTlstVvG8IN1eddlbPh7AGVzTzoXCcsz658N1b1NECVGiA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=kTdkoPpn; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=kTdkoPpn
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9785C40BD5
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 06:34:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 35C39600D1;
 Mon, 21 Sep 2026 06:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486D51F000FF;
 Mon, 21 Sep 2026 06:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789972485;
 bh=H4cMmy0ekBDJfQRFfeZWaWIlR0+1gBW66rPbCmzLgEo=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=kTdkoPpn4tSPaKK8y+Nmci2AOojndCzKA+QP+L1Qo/osDK6ug1sBOsfF5INz6lV7O
 dgCeLnh8t96fwhr2MzyRi4HXVF/T/NbE5kg1HsVgNBhsizJekRoq7cL1NNdGLGDnyn
 C5R+1DtyQLJvfpYgQwMDRt7iFrEuhVEj1xrjMgcVoBV7y/6n6cf4ZBfLgnIchleRsp
 QAk34EwGYbfDWgFb8b83i7nRKKJdpRl2lhv0/FsqOR0pXNQJsFTNIiUHL4EL9kiygY
 CLTftr3hAYhSgP5RwFCgNeTG+nSEoioEtnHAo7/Z7oRPHss7n++n+1dyTaUv5ptoAP
 snRTyRwwKxJXw==
Subject: Re: [Intel-wired-lan] [PATCH net v2] i40e: limit the DDP profile
 count returned by the firmware
From: netdev-bot+sashiko@kernel.org
To: xiaolinkui@126.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, xiaolinkui@kylinos.cn,
 aleksandr.loktionov@intel.com
Date: Mon, 21 Sep 2026 06:34:44 +0000
Message-ID: <178997248483.2160803.11710552261264563604@kernel.org>
In-Reply-To: <20260920063244.1927792-1-xiaolinkui@126.com>
References: <20260920063244.1927792-1-xiaolinkui@126.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Incomplete fix in i40e_ddp_does_profile_exist() and
  i40e_ddp_does_profile_overlap()…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but it is the
  direct enabler of the residual garbage-compare above and would be…

--

i40e: limit the DDP profile count returned by the firmware

The patch clamps the firmware reported profile count in
i40e_ddp_does_profile_exist() and i40e_ddp_does_profile_overlap() to
I40E_MAX_PROFILE_NUM so the loops cannot index past the on-stack
buff[] array, and switches the loop counter to unsigned.  The clamp
value is the compile time capacity of buff[].

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ddp.c b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
> index daa9f2c42f70..26dccd4236c1 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
> @@ -54,8 +54,8 @@ static int i40e_ddp_does_profile_exist(struct i40e_hw *hw,
>  {
>  	struct i40e_ddp_profile_list *profile_list;
>  	u8 buff[I40E_PROFILE_LIST_SIZE];
                                        ^^^^

[Severity: Medium]
This isn't something introduced by this patch, but since both hunks touch
these declarations it may be worth handling here: buff[] is 772 bytes of
uninitialized stack in both i40e_ddp_does_profile_exist() and
i40e_ddp_does_profile_overlap(), and it is handed to
i40e_aq_get_ddp_list() as an indirect admin queue buffer.

i40e_asq_send_command_atomic_exec() does not distinguish input from output
buffers:

	/* if buff is not NULL assume indirect command */
	if (buff != NULL) {
		dma_buff = &(hw->aq.asq.r.asq_bi[hw->aq.asq.next_to_use]);
		/* copy the user buff into the respective DMA buff */
		memcpy(dma_buff->va, buff, buff_size);

Does this publish 772 bytes of raw kernel stack into DMA memory that the
NIC firmware can read?  On completion the same full buff_size is copied
back:

		if (buff != NULL)
			memcpy(buff, dma_buff->va, buff_size);

so any byte the firmware did not overwrite still holds the old stack
image that the clamped loops then compare against.  Would declaring the
buffer as

	u8 buff[I40E_PROFILE_LIST_SIZE] = {};

in both helpers remove both the device visible stack content and the
comparisons against never written bytes?

>  	int status;
> -	int i;
>  
>  	status = i40e_aq_get_ddp_list(hw, buff, I40E_PROFILE_LIST_SIZE, 0,
>  				      NULL);
> @@ -63,7 +63,12 @@ static int i40e_ddp_does_profile_exist(struct i40e_hw *hw,
>  		return -1;
>  
>  	profile_list = (struct i40e_ddp_profile_list *)buff;
> -	for (i = 0; i < profile_list->p_count; i++) {
> +	/* Never walk past the end of buff[], the profile count reported by
> +	 * the firmware is not guaranteed to fit into the buffer we gave it.
> +	 */
> +	p_count = min_t(u32, profile_list->p_count, I40E_MAX_PROFILE_NUM);
> +
> +	for (i = 0; i < p_count; i++) {
>  		if (i40e_ddp_profiles_eq(pinfo, &profile_list->p_info[i]))
>  			return 1;
>  	}

[Severity: Medium]
The arithmetic behind the clamp checks out: sizeof(struct
i40e_profile_info) is 48 and I40E_PROFILE_LIST_SIZE is 48 * 16 + 4, so
p_info[15] ends exactly at the last byte of buff[] and the out of bounds
walk described in the commit message is closed.

The remaining question is that the new bound is the static capacity of
buff[] rather than the extent of data the firmware actually returned.

i40e_aq_get_ddp_list() sets desc.datalen on input but never reports the
response length back to the caller, and
i40e_asq_send_command_atomic_exec() copies the full requested buff_size
back from the reused DMA bounce buffer without consulting the response
descriptor.

So if the firmware reports a p_count larger than the number of records it
actually wrote, but still no larger than 16, do these loops compare
against p_info[] slots that were never filled?  In
i40e_ddp_does_profile_overlap() below, i40e_ddp_profiles_overlap() treats
a zeroed or stale entry as a conflict:

	unsigned int group_id_old = FIELD_GET(0x00FF0000, old->track_id);
	unsigned int group_id_new = FIELD_GET(0x00FF0000, new->track_id);

	/* 0x00 group must be only the first */
	if (group_id_new == 0)
		return true;

which i40e_ddp_load() turns into a hard rejection of a legitimate load:

	if (istatus > 0) {
		netdev_err(netdev, "DDP profile overlaps with existing one.");
		return -EINVAL;
	}

The equality helper can similarly produce a "DDP profile already loaded."
verdict from stale bytes.

The other direction is the p_count > 16 case that the commit message
targets.  Both helpers now silently truncate the scan and return 0, and
i40e_ddp_load() consumes that as a definitive answer: an add proceeds to
i40e_write_profile()/i40e_add_pinfo() without having examined every
reported profile, and the is_add == false path rejects a profile that may
in fact be loaded:

	} else {
		if (istatus == 0) {
			netdev_err(netdev,
				   "DDP profile for deletion does not exist.");
			return -EINVAL;
		}
	}

Would it be better to derive the iteration bound from the length the
firmware actually returned, by plumbing the response datalen out of
i40e_aq_get_ddp_list(), and to return an error instead of silently
clamping when p_count exceeds I40E_MAX_PROFILE_NUM?

The reachable path here is ethtool -f, so it needs CAP_NET_ADMIN plus
firmware reporting a count that does not match what it wrote, which is
the same untrusted firmware assumption the patch already adopts.

> @@ -109,8 +114,8 @@ static int i40e_ddp_does_profile_overlap(struct i40e_hw *hw,
>  {
>  	struct i40e_ddp_profile_list *profile_list;
>  	u8 buff[I40E_PROFILE_LIST_SIZE];
> +	u32 i, p_count;
>  	int status;
> -	int i;
>  
>  	status = i40e_aq_get_ddp_list(hw, buff, I40E_PROFILE_LIST_SIZE, 0,
>  				      NULL);
> @@ -118,7 +123,12 @@ static int i40e_ddp_does_profile_overlap(struct i40e_hw *hw,
>  		return -EIO;
>  
>  	profile_list = (struct i40e_ddp_profile_list *)buff;
> -	for (i = 0; i < profile_list->p_count; i++) {
> +	/* Never walk past the end of buff[], the profile count reported by
> +	 * the firmware is not guaranteed to fit into the buffer we gave it.
> +	 */
> +	p_count = min_t(u32, profile_list->p_count, I40E_MAX_PROFILE_NUM);
> +
> +	for (i = 0; i < p_count; i++) {
>  		if (i40e_ddp_profiles_overlap(pinfo,
>  					      &profile_list->p_info[i]))
>  			return 1;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260920063244.1927792-1-xiaolinkui%40126.com
