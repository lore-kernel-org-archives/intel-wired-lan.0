Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6455C624DA
	for <intel-wired-lan@archiver.kernel.org>; Thu,  3 Sep 2026 15:43:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9EF3E60642;
	Thu,  3 Sep 2026 15:43:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ndCcUHTnA-T6; Thu,  3 Sep 2026 15:43:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B67BC607F5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788450231;
	b=Px4zy6EnwIGwGPT4RvWp8aaCVe2GlPTR6kRuIjtalXlHWTAHNFY+T6c3bvyFqf6xT9Iz
	 XQswjOinTWvyPZxh9uS92CYW4r/PWFaqlh+uTQ9SIDbUwu0cWpDQWY74KfOkvqXpqzi7o
	 oJNUzvg2Pp/zCOYAWQ1TOIDPVcVl9d/d3ocYXEl3DOlrROhfchESvLCaJZ2ZVKCF8EK0B
	 5a+eTb5bvSIU+nF2w/OOlENBMlfXeGEq6i7LRU9s+wAZNebMOHkq8xacLnyD2PXhZjv8W
	 dQXXYyI6PRDiOn1soRiwLUyT3LLvEnyCqhZ9O2EDe7S7+NKKGuzS9p6c2XQwsyUIKmQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788450231;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bI1BhV68G1oPj0x4CKbgOGcd6eU2wirBl/zG9TZ5s3A=;
	b=nSAfOtXcFpl4dqWMzxkzcLLuupwAleSy0+Nxzp55O2TVaIAN+/j23Nn4bXuv/7ghWO6h
	 mnDaJ97RqGhXCRJSsqclqL4uQ9j4vFtHhwknMBf7A8vFFVJ1xTlu+SQB2CK6fMqZ6wwrL
	 7ssO+ogBPl5edc3cv64rJ62/sLXCm4GD7Os/3Gf0CCmhJceKMSWCVrdq8C6VYvv4hlhN/
	 sqUFBYxN5a/tWHnzNjLFh9lcx8S/S5yzkhYnPUajxzeT7KOHM+w8s05Liqqaz5iXVd8Tj
	 ma/0R/TsX69KRkGwTtt/yxX2tvYSHwOoguqfQZlQXOs2Fp+da1XNkoO1rxXySsNdOfw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h0EqnNrP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788450231;
	bh=bI1BhV68G1oPj0x4CKbgOGcd6eU2wirBl/zG9TZ5s3A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j6VYeR/j6GI3bOcKfcV+MjAh98Uv9qcH+UkaN2HWX2/xNDGLI0rQdHMnQmOkHT2eY
	 wi8Sy8rUQ7NuZiDPOLjtwypWd0OeuZv9rKCVxszFefMwZfqZADY43kMDvRgX6hL70G
	 M6JfJ6cazs54uA0XScLttzfkmqV2KEM4VLT8zFyxiHIO+KQrMFNNcjRAcL6u+xQCOx
	 gOf2OqBzDkBRcKOMxL1SVSLoT2oDzTMrhTIW2OX5i0a8io4ECauL63G/XZ6onzZjqe
	 pjUep594gfSoZnAFs/qFTNBvsJvMKueZUHSpeDIjMNnIu6jMrvU1gvz2ZyjG/rQfJ6
	 uQitig71Wla/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B67BC607F5;
	Thu,  3 Sep 2026 15:43:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8FA752FD
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 15:43:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 724C2607F5
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 15:43:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ehRgiCjfwaZ9 for <intel-wired-lan@lists.osuosl.org>;
 Thu,  3 Sep 2026 15:43:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6E83060642
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b12a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788450229;
 b=U8UJkXKbgF5PAKxlI4YDEGk4qan/vilBiGYAcyeNYNHtJr8I6lxBIAl0eg0Xd/FaUpxZ
 KyRl6v1L8PtdLQeeytl+9mTvjqFG4RkWkjbJfiCd5PFQovazk7SDi/ynhvSUuVPlsI/v9
 T0gxP7q9Nki/WlXaaMHstfQmaciVlLhmzr5wqiI6iPB4CONSDQICprI67gyS69bPBPfLX
 McaiaE7TTluY45X9cAD1PYVTG8Jud+aTs3RkanjItTUlDZ1dSu6SoK5YHj8MekTg1tmA5
 3emGipUtqqitzjDyIsFUvNxq2K5eCD1vs2IJLwUgZKJHsFLxc7CALC5MdXz7FR+eu4A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788450229;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=bI1BhV68G1oPj0x4CKbgOGcd6eU2wirBl/zG9TZ5s3A=;
 b=RfAIIXAWmy7j8wDPCe68ZFWP3xk2uSQUsQ7XDHlsPYt470DTqCuPjw0daVox9K9eTVF5
 UAUGSok0QAsNhpM5vsDj3rId3LGOPRvrMjOyMiKRb29XhesD9L+UzGsCuzH0T/MCutQGK
 0uKqgDAojQn75kyCJ47xm0uVxGJCjZLDXwGJCSsfSuM9iAT1bM5FtgQnzU37t6xFh4Fmf
 tOOWAKPS6snrVGKjBXYc3ittEcRrj4L5wAKmtsFVc/acmZ49RIeXz7bJMViDDGlvyayVV
 upkEykTo//KTq2FKUBPkLAPXkHQxEbTtABA4y92OZAVs+yKpMGYme27rXrVsJA9RqQA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=h0EqnNrP; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b12a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12a; helo=mail-yx1-xb12a.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=h0EqnNrP
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com
 [IPv6:2607:f8b0:4864:20::b12a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6E83060642
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 15:43:48 +0000 (UTC)
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-66f96a9d30eso980166d50.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 03 Sep 2026 08:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788450227; x=1789055027; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bI1BhV68G1oPj0x4CKbgOGcd6eU2wirBl/zG9TZ5s3A=;
 b=h0EqnNrPJkU456SQMyYTYu0VYkrvUq6TQJ4PQTb/Tn9SfJcfihAIrYL9botLBrG5gR
 DIoK+w94cGjtJRfR1X5EbX4/FulN6zuQ09bUx9iRfZBTuQ7WcLXvNkwF+W6NFy8rOwIG
 H9CL0l3O7cK4LmLfS0QQlWYAxQQpuAwuPV+SFr7+o1mp/vwv1ingZPyC++PAW/N8xX2W
 xlqFG4/pZFpgQPi2e/RLEnWXZUEXfHwFvPiM4t/hhZMNAGTEOnSNrYapEobkRgKA+JY6
 XKgSZha8Fi3hbirmT84aos6P1B4lMH9eL+bTjbU2gliabHgB8nUjDvJHqcTBiS+NpKmb
 9xNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788450227; x=1789055027;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bI1BhV68G1oPj0x4CKbgOGcd6eU2wirBl/zG9TZ5s3A=;
 b=ioZpOwCIeyvSNzEJCGL0lNEelXledD7o0mIuyANHb66YUo/gMyT+ZnIet+/JG9X1Bx
 0gNt7zvrw2bot7hbuf9hME8EveVq7Lnw+VNoAPJ4JNp9/fDPz/d3CR23BEdefpaohCx9
 wbA27nxt3dec3c8EdwOouqnY9OphiLG90i5AVZHv1sBkhsXfMUjcJ1pGK6TBbBP2qu67
 p+bcQh3Lkryl4LUm4fish05KvMMpSRxoJH0qsfY0dhTLVG0R4QAtwz9XgYgEdF75Ap60
 4j6hfa3NeV+/X3Vm4QkWKJ4X+Otnn4IKXB7ig8ZAY6YsTZdPY0jJTdA8hJzClmOcid5d
 pAHQ==
X-Gm-Message-State: AFuF++nU0JZYwwzh3lHwP1NBe/4cKwLiu5+jXaVQQhpg6cJLEr/9icdP
 I6ScV3IVFmXOJ8/lz9NE9O0CryFfiX7Ugjq/oMEC7I4BPSGbAlIB6kda
X-Gm-Gg: AYBFou0uaiswz/Wahon8/sc2xxnweZ6FYwkZ5uO2VM7H+0WwlXxVQGVY2elNQlnf3ki
 gCYLdyj0BPrfOeTd23lm5JdMMNW9tm093VdHSfgWel1D2iTrn/NCoz237rFCIzglU5hT/cgTB9J
 55BqXcc43/EBdWO/rIQIUbp2epv80HHUqwzS8L5kMzL3LTRhEOj5THU634efqrk/4YAYjzNQWj4
 7KVnChcnlOFDwv7MlM9udotJqriT8uTdbhfkzYivokP+ER4tmI+bmL0uPeEhe8K5LWEJfPUg3VO
 yiOdWeYEkrCJCq1Q/6I0T2SlhvzPbGtaZTCxHtPWplSTBNQksODPmjmaLhyOhZ+zQm85JJ7NYA0
 kqq750gEJXduA6qKAhfdT7xPhwdN2zaDmTEjWml7Zu7JfyV0VYm44HtDSCQcv1HzJe6UyTqvi/R
 q/64YotVsNvEod7dSwJpFbZKfLY3SZ1DpYcqrLJTgJByPgJsAh3CMfl6GsdZ6s2/WOoCHy91yI
X-Received: by 2002:a05:690e:11ce:b0:66e:61bc:142b with SMTP id
 956f58d0204a3-66fb3f17e38mr338606d50.6.1788450227467; 
 Thu, 03 Sep 2026 08:43:47 -0700 (PDT)
Received: from ?IPV6:2600:6c5c:6b00:316::23? ([2600:6c5c:6b00:316::23])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66fb48b374bsm157898d50.3.2026.09.03.08.43.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 08:43:46 -0700 (PDT)
Message-ID: <f233039c-e23e-40bf-b3ec-061f322d26af@gmail.com>
Date: Thu, 3 Sep 2026 11:43:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 6/8] e1000e: disable NAPI while interface is down
To: Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 aleksander.lobakin@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260830232146.36948-7-tactii@gmail.com>
 <20260903102748.578986-1-horms@kernel.org>
Content-Language: en-US
From: Matt Vollrath <tactii@gmail.com>
In-Reply-To: <20260903102748.578986-1-horms@kernel.org>
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

On 9/3/26 06:27, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev/#/patchset/20260830232146.36948-2-tactii@gmail.com?part=6
> ---
> e1000e: disable NAPI while interface is down
> 
> This commit moves napi_disable into e1000e_down and adds napi_enable to
> e1000e_up to ensure NAPI is disabled during reconfiguration windows.
> 
>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
>> index 194166531bc84..6d846cacb026e 100644
>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> [ ... ]
>> @@ -3601,7 +3603,7 @@ void e1000e_down(struct e1000_adapter *adapter, bool reset)
>>   
>>   	e1000_irq_disable(adapter);
>>   
>> -	napi_synchronize(&adapter->napi);
>> +	napi_disable(&adapter->napi);
> 
> [Severity: High]
> Does this change introduce an infinite hang in napi_disable() due to
> concurrent or duplicate e1000e_down() calls?
> 
> A runtime PM suspend callback (e1000e_pm_runtime_suspend) can execute
> concurrently with an ethtool operation like e1000_set_ringparam. The ethtool
> operation sets the __E1000_RESETTING bit and holds it while allocating
> resources.

No, ethtool and runtime PM suspend are synchronized:
* ethtool core calls pm_runtime_get_sync() before any operation. This
   increments dev->power.usage_count and waits for any ongoing suspend to
   finish.
* PM core rpm_suspend exits without retry (rpm_check_suspend_allowed()).

> 
> The PM suspend callback waits on this bit but uses a bounded timeout (300ms).
> If the ethtool operation takes longer than 300ms, the PM callback times out,
> prints a WARN_ON, and unconditionally calls e1000e_down():
> 
> e1000e_pm_runtime_suspend() {
>          while (test_bit(__E1000_RESETTING, &adapter->state) && count--)
>                  usleep_range(10000, 11000);
> 
>          WARN_ON(test_bit(__E1000_RESETTING, &adapter->state));
> 
>          /* Down the device without resetting the hardware */
>          e1000e_down(adapter, false);
> }
> 
> Because the ethtool operation also called (or is calling) e1000e_down(),
> napi_disable() is executed either concurrently or sequentially on an
> already-disabled NAPI struct, leading to an infinite hang waiting for
> NAPI_STATE_SCHED.
> 
> [Severity: High]
> Could this also lead to a sequential double napi_disable() hang due to state
> mismatches where e1000e_down() is called but netif_running() remains true?
> 
> The e1000e_pm_thaw() function attempts to bring the device back up after a
> freeze/suspend. If e1000_request_irq() fails, it exits via the err_irq label
> without calling e1000e_up(), leaving NAPI disabled:
> 
> e1000e_pm_thaw() {
>          rc = e1000_request_irq(adapter);
>          if (rc)
>                  goto err_irq;
> 
>          e1000e_up(adapter);
> }
> 
> However, the device's IFF_UP flag is untouched, so netif_running() remains
> true. Subsequently, if an administrator changes the MTU via
> e1000_change_mtu(), the driver checks netif_running() and blindly calls
> e1000e_down():
> 
> e1000_change_mtu() {
>          if (netif_running(netdev))
>                  e1000e_down(adapter, true);
> }

Core does not call ndo_change_mtu on detached devices, it checks
netif_device_present() in the typical path. Bonding and team paths will
close the device before changing MTU.

Same netif_device_present() check in ethtool core and e1000e_pm_freeze().

However, the PM runtime suspend and resume ops only check IFF_UP and not
netif_device_present(). PM core does not check this or gate it on a known
thaw failure (by design). That is a real pre-existing bug made more
consequential by this change.

> 
> This invokes napi_disable() a second time sequentially, which hangs
> indefinitely because the NAPI instance was never re-enabled.
> 
>>   
>>   	timer_delete_sync(&adapter->watchdog_timer);
>>   	timer_delete_sync(&adapter->phy_info_timer);

