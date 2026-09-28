Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33059CA5FA3
	for <intel-wired-lan@archiver.kernel.org>; Mon, 28 Sep 2026 19:23:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D634E80760;
	Mon, 28 Sep 2026 19:23:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id thIO0g3gnb-1; Mon, 28 Sep 2026 19:23:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0AB5F8087C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790623422;
	b=lVnlwb5XVgxFSrRXfmt1aw51eRVuhEbOQ9G8V12A8Kzpu7qRo3TSbyEbP9yBU/PP4qQr
	 RzjHPUtSZ+d3JiFdtTT1QQwk2qjko3gssc8kyOLwSirqsew3mW/Idbq0PTzM+6dGEyuIA
	 BxLqsckSxxNMAyrJghqEtHJ4IqJwbnUd+PkGuqPyCz8P8KbNwqWgMbGQ5q8yRGzBbyt0i
	 uueNF8RhSFLIpP2jVg4ITjpWDPJAALGrojf3MtWbXUboIKL3Gxh7QGCZYrP8zSWULgADb
	 Wj/pHENrYiVOZ5ZMcrkFeI1a2c6J401NdkgsAxR7dCxQmvMt7rxvoIT2XHodolxojTg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790623422;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AnZCrTRfpItZ1v/U0Z7dCGTDmXTsYFgEREK5NIBSxBA=;
	b=K53hejtdHZmZVF8CPwx4S8klTx5LsI0SrqyD7nYGubmGmrYx3R2Qnivqkwb8DAD5nL0k
	 MMSmLOc3UHVCdET1MtDxpwXndFIwkmfA4bynFAAEh8yYZfE3qwU9CgL5mhWsql314YDZ0
	 tx2XJWMFpho85tTBjqPPuCVx1epFWj1jg4iJodgqcbghGPmcVvxp7uNCwcOuUHQvusolq
	 tvnuMlDtP82vs9lFX41k9w+RUREKXHFBmnC7rcGcMAR6sRcB4rI73mncxiusaoLdaCdpm
	 vP3cBbiCTk1Lks2LNh+DzikfTjfW5sAocDWExuBBq6hcZZJagitKz2x8RS3TO21kyig==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790623422;
	bh=AnZCrTRfpItZ1v/U0Z7dCGTDmXTsYFgEREK5NIBSxBA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B4TMAGHOCji8g1Zp75HVqnapFf0gUIGyYlS0lK/Pi3JIPsqVnhqSVxqRdeWCCJAFB
	 PxHdDpceYbTLjhtMix1bCTIIjlWJejbLrFTlJmjHhM+aHwyXlAdodEiCYs79vxzWgi
	 KJTMn5nKeG10O6ovOYLcoNDnMem/3u5N2u95mSjTsPntn3unfKHwOLomIRTJFZtgNb
	 Bf6+MYw0vI9O14U1y7SxlHk32oP09Dawc8Algh8ZUNHfhCRUe4qV0Z7Kr1xl64zxzL
	 V87krxlkeWR6rzGpZZGd1cbrbM6VkbFoS9kBOmyUVZXA5tUaUcGorpjh0xzrSpSMDH
	 6AFQ6fVjgz7BA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0AB5F8087C;
	Mon, 28 Sep 2026 19:23:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 811FF147
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 19:23:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7AF0060615
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 19:23:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LaiSDTBgFA2j for <intel-wired-lan@lists.osuosl.org>;
 Mon, 28 Sep 2026 19:23:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8E96E605F3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:36::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790623419;
 b=hPfayF/oZfiUTbUIogD40bYG2CGJpYdDs+w9q6krKW3KnQwejXt1d20BdxbUxIuJL4sL
 D0hGqItjEzEoDsQ4Ggy5OfvufTV7kMGk6VA6Nrbc0WAO44n2yLcBfIC1dP1/wdCgEFLOr
 LtRuZvRf8qKPWCEeOlpjGKOWrJNkOQcKgsHZjdMKQD6GRugduCP240AkDkanEl1bbRex+
 a2bNdEUnPRMn1FgdclQzvkCn4b9Wm6/gbDCKTIFrOLpfAVYF+XoA0dgOQMAkerHWkeZNp
 lkgCGlvh05kzmNWqHyW1NX0qVRSXlzUGJyHCUGj4hnPHzfKHchP8A0Ucc2yIqDlwlvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790623419;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=AnZCrTRfpItZ1v/U0Z7dCGTDmXTsYFgEREK5NIBSxBA=;
 b=S6iQOj2mhn5W+5syiN8Jl/0UivS7U4D5Kfj/C0r5b0k15rgFpUxrmWNzwO/fd0gBmwib
 MIffbdcmUuUI02UG0UwjbZLMwZgwLxSdFqc9YDGIfbkcXLyFWpUZQzdvhmIS7mwskZxWv
 qRfGGXQwMg1jnOaOxt2v8oiTOBspExwKsIo80fSdYkh6M2AqBRfQa1oKb8bpDbXy1FhEv
 P3C81Y4zWOjYl21oWOm4JUEalz3MkMjU/pkt5NH5tiwOLSXaXNLOFTTojzTFz73QEvOh4
 MJ6QNDhaLvo4D6qcEWJsjz6v2lRdRoR+y1sPvC4n0Tvx4SQiDpAvh9F9ruampudEBkw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QlO7sAyP; 
 arc=none smtp.remote-ip="2607:f8b0:4864:36::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:36::f;
 helo=mail-dy2-x0f.google.com; envelope-from=tactii@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=QlO7sAyP
Received: from mail-dy2-x0f.google.com (mail-dy2-x0f.google.com
 [IPv6:2607:f8b0:4864:36::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8E96E605F3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 19:23:39 +0000 (UTC)
Received: by mail-dy2-x0f.google.com with SMTP id
 5a478bee46e88-34b1743e9c7so5783eec.3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 12:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790623418; x=1791228218; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AnZCrTRfpItZ1v/U0Z7dCGTDmXTsYFgEREK5NIBSxBA=;
 b=QlO7sAyPv/kOkAqjusLlGQLKPu9mr1UM9oSNXidDJvV+hxQf7SbML6ahXDUbQo9NRt
 H+gAWvirelaetUPD909gntWc0x2Dd/4uYUExEkvUvm9YZhjdCX1/bniAzNTO2qtpoJss
 n8/OkgUk/yjHz2Yi9nZN3XztBehIF/e6UXJt12MXjrtLPjnQiyeRZ632zH4/7EiwVeA5
 v1LKKBsmNihzO9EgPgV/9BvgPq8+EPWbIkGA6rBwDVnRuG/JzOkpMo7F1/YORFVGwW7R
 vwCVxf21xgDoh+3AFouKVOOMKvpWtak4bPVeko4HnQySJYqsjacdVYSXDBLaMwIbpPVd
 dvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790623418; x=1791228218;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AnZCrTRfpItZ1v/U0Z7dCGTDmXTsYFgEREK5NIBSxBA=;
 b=LapyIhTij4HgW1QWTeCmNZue+pZUuUHXJWlUjPGKdjIHmPH5uYSJJSKwJf6gG719mc
 UFUv94cMlN28FKalxR/ChoRZ1PLYCMy8/AtdFvNbMflwnp1GiHc5iYgHehICrMsNteLT
 tE3HUuYOBtAwhOwJNvguLc80vQprWlEhNvbKtQoD41J64DBQh13RpjaxTKEUp/8DLupv
 nF94WxYu7/eu2oj5XqIQZank8ttodSa4Mv7Khg9ZQdTZmhoOhHaaxcpVorhEMW/BWDii
 QZ9aVY+J1JpdZ8tlsK8oFS5KD4+L4j7idb3PKGGy/Sd85rRpoUA6O0zyDZa9tJ2SwGm5
 H/pA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz04Ypi4vb+7cbbqodX7VwwVXOW4flykHMQ/0ZmdGdtfbRehIStj7tdIqghAc7xxIu3XTVZ4SBW4tYs7WQ/iwg=@lists.osuosl.org
X-Gm-Message-State: AFq9FYLwD1ngIkgEQWTyGo1lNzZi0UT/eXAGulGHYPf5eXFkpZXgFD9N
 fP1Kvc9tqRMThmRla0578KOSVkop1Q5wOyOohMosRI0G1GTIq7GGSaRY
X-Gm-Gg: AYBFou0NFCm2EqRfR3O/bjuAMjADVIs+lws0jKzoCKubK+JX3WgLztMF5QvX2RQLMIE
 sTGDNt2jfQC40pOePIdN/apiqcQuF30h4l2cNxjepNH53oKaziVebX6oFoGOYmVlfHwjOT8J0r2
 0P/la4lJ9fHVDhKQ4EtRpotsM6+phVb3TSxRCMB6OyFc8iB8iCK+m0MCGT0RjKqqfc+dmFNCgI5
 AddQO01NuAyVFAnoVr3Ujl6bwNBc/vLDnHSGXyUqNCQAOjacHrAJGr8vSyhRnw5ZBcZ8l4c2Hfx
 wcvtOfmFziZJyJyHswHI3I28QVSjHpgjBXiicN7a1dCY1HL8oxP3UVEV971UTY+Ka2fjnlDN4q0
 z5RaXjg+aMq+KK6UONhub4vbfHXOIPaU50tA0OWQGMVTVn4gOvL/E+3Mv/oZSow/eqMhuuZAJSU
 qyoxire+X47gfcC2NrHy02bw0woW/BY2U0iAP+mudL3bQDvLppK9w4ADF+fE3lJe6XDCquReqiA
 kQG2jIPR/4=
X-Received: by 2002:a05:7301:1f15:b0:33b:5b1b:134c with SMTP id
 5a478bee46e88-3427344e560mr15142029eec.38.1790623416429; 
 Mon, 28 Sep 2026 12:23:36 -0700 (PDT)
Received: from ?IPV6:2600:6c5c:6b00:316::23? ([2600:6c5c:6b00:316::23])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144172de6sm48477679eec.9.2026.09.28.12.23.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 12:23:35 -0700 (PDT)
Message-ID: <b6db5335-cb5c-4a91-b823-1a114fce75a1@gmail.com>
Date: Mon, 28 Sep 2026 15:23:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2] e1000e: restore jumbo config after DMoff exit
To: "Craig I. Hagan" <hagan@amazon.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Fabio Sabai <sabfabio@amazon.com>
References: <20260923235832.473-1-hagan@amazon.com>
 <20260928170234.21877-1-hagan@amazon.com>
Content-Language: en-US
From: Matt Vollrath <tactii@gmail.com>
In-Reply-To: <20260928170234.21877-1-hagan@amazon.com>
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

On 9/28/26 13:02, Craig I. Hagan wrote:
> On an I219 (pch_spt+) at jumbo MTU, after a link partner reset (e.g. a
> switch reboot) the interface can come back up unable to pass traffic until
> it is manually reset. Observed on I219-LM (8086:15b7) at MTU 9000.
> 
> When the MAC exits the DMoff state on link-up, the watchdog resets only
> the PHY. A bare PHY reset does not re-run the jumbo-frame workaround
> (e1000_lv_jumbo_workaround_ich8lan), so the jumbo configuration is left
> unapplied and traffic stalls. This was seen with NIC runtime PM disabled;
> if runtime PM were enabled, the device should go through a full reset on
> resume, avoiding this issue.
> 
> Request a full reset (FLAG_RESTART_NOW) instead of the bare PHY reset when
> the MAC exits DMoff, so the normal reset path re-applies the jumbo-frame
> configuration.
> 
> Fixes: 2e7256f12cdb ("e1000e: Check the PCIm state")

Wasn't this bug introduced in def4ec6dce39 ? The more recent commit seems
like it just adds a pre-condition for the DMoff workaround. Tagging that
commit could cause stable to miss backport to 5.10.

Otherwise:

Reviewed-by: Matt Vollrath <tactii@gmail.com>
Tested-by: Matt Vollrath <tactii@gmail.com>

> Cc: stable@vger.kernel.org
> Reported-by: Fabio Sabai <sabfabio@amazon.com>
> Closes: https://github.com/systemd/systemd/issues/25925
> Suggested-by: Matt Vollrath <tactii@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Craig I. Hagan <hagan@amazon.com>
> ---
> v2: Rework per review. Instead of the fc-latch autoneg-restart
>      approach, request a full reset on DMoff exit so the jumbo-frame
>      workaround is re-applied (root cause identified by Matt Vollrath).
>      Drop the diagnostic e_info. v1:
>      https://lore.kernel.org/netdev/20260923235832.473-1-hagan@amazon.com/
> 
>   drivers/net/ethernet/intel/e1000e/netdev.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 844f31ab3..df7da86a8 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -5264,9 +5264,11 @@ static void e1000_watchdog_task(struct work_struct *work)
>   					usleep_range(10000, 20000);
>   					pcim_state = er32(STATUS);
>   
> -					/* Checking if MAC exited DMoff state */
> -					if (!(pcim_state & E1000_STATUS_PCIM_STATE))
> -						e1000_phy_hw_reset(&adapter->hw);
> +					/* MAC exited DMoff; do a full reset. */
> +					if (!(pcim_state & E1000_STATUS_PCIM_STATE)) {
> +						adapter->flags |= FLAG_RESTART_NOW;
> +						goto link_up;
> +					}
>   				}
>   			}
>   

