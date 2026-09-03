Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A5CC624D7
	for <intel-wired-lan@archiver.kernel.org>; Thu,  3 Sep 2026 10:28:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37A6840A6F;
	Thu,  3 Sep 2026 10:28:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gHnGQ80GiwrH; Thu,  3 Sep 2026 10:27:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 49FB940A70
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788431279;
	b=q+1FYKYs3XuNJQAY/OtGf5fCmoiNxzrfNEmGKAbv+p2JDYXXVptGTGCTeH9FHTnrpEiE
	 t5F3IKEPKrrwdF0v+gw7byyu4OHdSi3OAgsebFM0nlK+8C2Cms4fh7pnzTx0enIWNhCnH
	 0GhDTlERf2AYwdJWcKLNZqg6/H+sFlvK/qYsW/46IE/D9whU921tYVZngxWDMi040V1iS
	 7BJ8oW7ES0PnLdgQ3xOwtb7DHDQkC6SRDgKOELok0R0ijldYmVrj8wGhD2TlRGFK0AvQ3
	 uDmv4xAFbZtgjG0+i/qOMmFrHIqwidYX73gNqs+m3+CWnCmTb+a1Bctn/hHUT6LZJhw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788431279;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=a4c1woQ9AJvItpYFTfW7Q9gNf4I+aOW6flvKS8gj4h4=;
	b=aPZmXTKNX7+0MgnzVQTpQGLf3KNAiWO/BFEICsheEAqtj/5L/TxwT4XGHxFd32cbhm3E
	 xnYX6PEm4AH3wV3wYGCnThyPpyC7tE2kETUPpbh480IS+7bfCtS31cHrOgoKBAMFOqG4+
	 9hBDXCPd1EkFLwj6/6CMh5iU2uIRkx7ECt3jugx/rf243RVBXFyS8dPopoFMfj/7OG0bk
	 ASv+V+XxvBebvjfqkxtEcxuf8Stgu9erOVMi5NmJnODKm3JoYkKJNzl9GCy52OmAL5KA/
	 ezcf9qOk+4VTaTbI0jIRArLrxvD/A2Sh7F5OlWrdTZbMEhtmVt2cltf6C3QMj/5IoBQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788431279;
	bh=a4c1woQ9AJvItpYFTfW7Q9gNf4I+aOW6flvKS8gj4h4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=seRs3M5j3j52CNmc+iB79RAVhSR6wwnl+moLfWBXvQyUa6cCTt2Uqkh1lmKE9QROP
	 99PbBhTGP3kc/Yxnq8FYGUkRQaqyI/cP4o81zgapiCqeWPuHPQqWe/aNOJlt0xVcfb
	 Q7iJai82g6soCtQLRtuj/2csCwz9JvxAmYcZWIXCqLr/W8bADMESuIVYpRKpZCLwOu
	 XO1it1GJwhNxCmR3c46HkHlDSl66bLM913803FJaNOrB7zJ3Gh4mFskCjDIwdP7Iki
	 U7F5wjdIt7JbQXo/qavl9EUjnPVcjq4EcU7vT/V26V9jfPqgO+eJx2KfvS5wrr6lIX
	 tKea5dlAgUNcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49FB940A70;
	Thu,  3 Sep 2026 10:27:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 466BD230
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 10:27:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2BA6A80DFD
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 10:27:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IuuqV2OFJ0fD for <intel-wired-lan@lists.osuosl.org>;
 Thu,  3 Sep 2026 10:27:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 223C380C68
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788431277;
 b=CUcKGZqTkVfm2zlOK09XRj9lcUoR8S9oRb8ZO6iuMZExIgTOX/JsAdFifUGcKTMZPhtq
 M1KjPK07eI8vpzKy0/psjgHnztuQQ3IHkUdgSLal58rl8T2UWyzTchuqaXBq3D2FW8lZz
 RSfCYkieHEb8JnkeVa2Ei/FEugvZ8j+jWDXDRI5HMq0Gz441IxPfgB9O14GVzJ9v0CzUD
 VPkRy2XEQKE9y3hBIHw0NhFTDpGXbJkyjwlNDWSeKo/AtVP0UcAnSBdLoNgkW4Zgcz0SD
 k/vAYyhpuw9ERIAJ66+ymYqKlFK8Tt1JX3F76OuXYrFHmAPyaB8R3Jw+O91ZHayv++g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788431277;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=a4c1woQ9AJvItpYFTfW7Q9gNf4I+aOW6flvKS8gj4h4=;
 b=HtiVoBzZx0I37YqsGkRvrASmhAm2LurFBhU47Mon1EjgtrhHBlC8djadGnvpbSgCtoxh
 I3Xw9PsFWNvtwh1N7QoPxJGqwQrosw4u/K4J7QDNduEXy4Ic5429kk2RKIpp8D+bQTDur
 LwGYdxd3PsvSjlGMuzHxu/GNvxJxnJnLG/v9keSsaimlV3lMWuSAHb1eja00j1Fu+U630
 3cfVAEptByviMtZieqm4ZCArWZUJ4/2Y0aLm6KBv9Hpz67XW6OjfMPr74s7W3/xO9CH8U
 zIqH0t3tgDqHlDNvwtQz9Q6AJ6yQru0DoAk6aEyFGhHzUC8nG7Fi/5aeOPQpS/d+GcA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bA4aYCyo; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bA4aYCyo
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 223C380C68
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 10:27:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A47BC600D4;
 Thu,  3 Sep 2026 10:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4EF1F00A3A;
 Thu,  3 Sep 2026 10:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788431275;
 bh=a4c1woQ9AJvItpYFTfW7Q9gNf4I+aOW6flvKS8gj4h4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bA4aYCyoK/Cz+nUGXSM/J1Go45ueDIO4MMNRXB0xoe7VZawXneuMArnLQJQlXLvvv
 om36d1x3MniUO8APyU1J9ditp6Xp+tks96x41cqHw3OnZgixwfcI0uMqtQM6R6oi1O
 gwrxHNVFVe516yL0hLRUNDcrIx/bRDgf2Imel2odx1VtUduDkZyhhTM9dxc8vlvIit
 GYaeGoERz9Cs7B7k11Fxo8l8w0n+oFn2iBa5NhZ6enAtqeB2Ap75woAkrhX4AM+xht
 EQa2xhuym2q3KIR9fZLVcHhNP/2JPeqMLvg47ZurSJt9+SuYgCwOatMErZDb7l298o
 J2cPU8Vl8S/VA==
From: Simon Horman <horms@kernel.org>
To: tactii@gmail.com
Cc: Simon Horman <horms@kernel.org>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, aleksander.lobakin@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-next 6/8] e1000e: disable NAPI while interface is down
Date: Thu,  3 Sep 2026 11:27:48 +0100
Message-ID: <20260903102748.578986-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260830232146.36948-7-tactii@gmail.com>
References: <20260830232146.36948-7-tactii@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260830232146.36948-2-tactii@gmail.com?part=6
---
e1000e: disable NAPI while interface is down

This commit moves napi_disable into e1000e_down and adds napi_enable to
e1000e_up to ensure NAPI is disabled during reconfiguration windows.

> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 194166531bc84..6d846cacb026e 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
[ ... ]
> @@ -3601,7 +3603,7 @@ void e1000e_down(struct e1000_adapter *adapter, bool reset)
>  
>  	e1000_irq_disable(adapter);
>  
> -	napi_synchronize(&adapter->napi);
> +	napi_disable(&adapter->napi);

[Severity: High]
Does this change introduce an infinite hang in napi_disable() due to
concurrent or duplicate e1000e_down() calls?

A runtime PM suspend callback (e1000e_pm_runtime_suspend) can execute
concurrently with an ethtool operation like e1000_set_ringparam. The ethtool
operation sets the __E1000_RESETTING bit and holds it while allocating
resources.

The PM suspend callback waits on this bit but uses a bounded timeout (300ms).
If the ethtool operation takes longer than 300ms, the PM callback times out,
prints a WARN_ON, and unconditionally calls e1000e_down():

e1000e_pm_runtime_suspend() {
        while (test_bit(__E1000_RESETTING, &adapter->state) && count--)
                usleep_range(10000, 11000);

        WARN_ON(test_bit(__E1000_RESETTING, &adapter->state));

        /* Down the device without resetting the hardware */
        e1000e_down(adapter, false);
}

Because the ethtool operation also called (or is calling) e1000e_down(),
napi_disable() is executed either concurrently or sequentially on an
already-disabled NAPI struct, leading to an infinite hang waiting for
NAPI_STATE_SCHED.

[Severity: High]
Could this also lead to a sequential double napi_disable() hang due to state
mismatches where e1000e_down() is called but netif_running() remains true?

The e1000e_pm_thaw() function attempts to bring the device back up after a
freeze/suspend. If e1000_request_irq() fails, it exits via the err_irq label
without calling e1000e_up(), leaving NAPI disabled:

e1000e_pm_thaw() {
        rc = e1000_request_irq(adapter);
        if (rc)
                goto err_irq;

        e1000e_up(adapter);
}

However, the device's IFF_UP flag is untouched, so netif_running() remains
true. Subsequently, if an administrator changes the MTU via
e1000_change_mtu(), the driver checks netif_running() and blindly calls
e1000e_down():

e1000_change_mtu() {
        if (netif_running(netdev))
                e1000e_down(adapter, true);
}

This invokes napi_disable() a second time sequentially, which hangs
indefinitely because the NAPI instance was never re-enabled.

>  
>  	timer_delete_sync(&adapter->watchdog_timer);
>  	timer_delete_sync(&adapter->phy_info_timer);
