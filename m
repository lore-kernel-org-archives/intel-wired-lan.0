Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9944AC982DA
	for <intel-wired-lan@archiver.kernel.org>; Mon, 21 Sep 2026 03:28:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5086660629;
	Mon, 21 Sep 2026 03:28:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M8k792qrHIz0; Mon, 21 Sep 2026 03:28:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A54FF6064C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789961323;
	b=dlpn145YUxA/wAl233/zKN3qJpEUyT/qyrtZmRr9D6Lvj5zchUsXNhfIXSgbCXwye4bh
	 ngtxQUjBXeERnxwIwulmV0WUGAIFL/JRUfupctGNfqmB21JXPh612PkHL9eOURBl+/D29
	 n5ipE45MfertqqHuMgug0mDVJJwvSDBfqdiK1kAYL73l8+37UQ7J9g+eEafzDHkTnk3dv
	 dx0AvubX81HYFM9s9GimKrjojGFm2igb9YjjvFeEYtAPGProXEUWFfCdZ7gCwBx4PJEeg
	 mHCsC36Y9IZJ5R7QlYlmMu9Tgl+4k5Esj4Qi6ASnYaX46KP345kZalP/vRLm11iX+QQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789961323;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XPHufAaWv96oqPXlYKIZPXt1hwnXdBDNCJI2CHfFxHk=;
	b=dgceDSCquQ39ZnL7rW+siaGaSGJ5IUnM/nDEx3H+IYE/RhlkpwRt9Eda90G5sAAFeWDO
	 9yWHiGe0pQmnnkk9P70QHr1rAtc3CSD8U+UFbP25Zkw6Yhr1isIaJlMh1xhSzNpM1u2FH
	 tSYqNzHe4YrX578g7DbDa1GJ98Vv260rVLAWOKv8pRGVu66tvHwxJkICGwQzMICACDAUF
	 bTE+mOLNYo8M1j6MRgNfprm/kfXdCs7Qas/M6zeo5+ZRZlGVzPF/3kfJu7lRgHR27beBu
	 Bn4/EiYDTqoIL6lNap15yOiaTVf3rrXCq49lGESurFaPjyiE+w7wyBFQ2kPQJIT7hKA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789961323;
	bh=XPHufAaWv96oqPXlYKIZPXt1hwnXdBDNCJI2CHfFxHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bLJn5cdaffaBl86Dp3MotFZiumWa50VvEpuPqVxefIp5Zhi/TL53/P0QcA7ff2UDq
	 XfHmWJCXbSfM/uTiWH9cmXrHI3p1cGPHf8oKA4bMSWbYGbXTUL9+o4HMIJXuYmN3I9
	 E12+yOBsglF8VYob54MxjJMeqEU2hhqsNBHY4vHb2/zswofIFtFCaQdmPC0f1+oqR4
	 k2nQG3vikhYMwXxcNDbL8xsN9oPTH4QBRrHlcshgXqy0uFfUIHtZd/XN0Dfwn663Lm
	 LeGeuA7OHYk8W2hWUcfcCIUofTapWK9lBYuJ04kr49BtqnSkHApuss7LR1090cE86m
	 mTnt5uyPphBdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A54FF6064C;
	Mon, 21 Sep 2026 03:28:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 66EE0380
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 03:28:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4D15C4008C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 03:28:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YSfF5lCsGoIw for <intel-wired-lan@lists.osuosl.org>;
 Mon, 21 Sep 2026 03:28:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org AAF9640080
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789961321;
 b=JHhmxIJskJ1mj87MmezNWgm2D0B1zXGS5np7ukXeEh2dW76mqefhKxufx7tJjGSndbqC
 g8ccaE8V+uhe0y26l/A4JZZnoTa4d+Ujgfj0Mv85Omwb4SzdtqeLVYaiztWWHuy3as33X
 6/DR/slwU/B11pdAoMSTUItZyacfJ3dNfiF1hfNSvO0sn5skURf7ddyOg2HXRydxkFG6G
 dSwaD8RH/0y/G945H5Kk9AhdWg/eOXXyHyF2ZcUhcVsbhDCkfBZ05AEFqb++4649/B5Vv
 mhgntxOJbZo6mLMI4kMHDztqw/4GP70oUIFqS7zHm0WhXVNgJiqM9CcHoiL2UPViZ3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789961321;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=XPHufAaWv96oqPXlYKIZPXt1hwnXdBDNCJI2CHfFxHk=;
 b=rbkqs9qgBBo77aQhCNjxCmwfAfKW5UNAunHDzC67DOecz69ba957oow4L83a11AUWMKj
 XuDo0yCJwImF0SyUZGv21g+9E5ItrDuW+tmkZ2duUHE8znbkC5nw650tSql5ORkZtGAFQ
 pat46mKThfn2L7nSLivzTIdYojGD3K0zzX7HlJViFoRNK49aWfVStf4w5iPJkObSQgAIe
 LTezybZoN5Jidox3gQCA69hL7OQTIK6XZs6F0lxFBnoK9RmOFC8uO7WVt/by20XHiddTJ
 lUT7aKF48n5L640YHJrerukzLa1sEX+y7o2cEPozNF6udWO4IzaDVO/VsdxaI1/ILVw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=F9xiC5G3; 
 arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com;
 envelope-from=luckilystar08@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=F9xiC5G3
Received: from mail-pz2-x10.google.com (mail-pz2-x10.google.com
 [IPv6:2607:f8b0:4864:3b::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AAF9640080
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 03:28:40 +0000 (UTC)
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea34ef3so2079906a12.0
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 20:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789961320; x=1790566120; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XPHufAaWv96oqPXlYKIZPXt1hwnXdBDNCJI2CHfFxHk=;
 b=F9xiC5G3EQL0p6oFAy4MRaGFvCFhkEYuroq4FO+w8+kIqaCn21UMsjrwws6jUWVS6T
 zIRse5RjKgMi7gwCLD0mQ4Yl9I3r4v0scnA7+5PmqS1kLN8zaWaaR9cSXtmFosfZ3rTv
 uZNG3BmuWTenZo6ZDiXXilRiRtWo+0KVsmArLLsIKuBLfUSIhgYtjaego14kNGUF+rtW
 X2uEK3L0dhepUjguyzQmqI7fty6I2Dj4MIhaY6HKJixz04llb30H4FD8PsHfeMdEWciA
 o7XTQ3vgGYm+MPzsGntx4R8iIjdUjUlyNBP1G54uBhNnK+6VuEhwGn8ar8tiL3vWKxqR
 pnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789961320; x=1790566120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XPHufAaWv96oqPXlYKIZPXt1hwnXdBDNCJI2CHfFxHk=;
 b=khh3+NdauVPxbQ6SrFtL1xDRfX1nkqz1jIDL5Egj5lTJ27P965qaKvbAHuV23ztBs/
 XDrP+cEF/5D+evgOslWUb47Dfu9QyE4YuVomKWPuhAXnDCFileUdWiMPStf4TLODD25j
 1jE9NBU2G3oNbNOm2mmZIL7Dlles87A+xT44VgO5YIuvThtcyzPRPzpJSmwG+egANkzZ
 cbXmX+5h8ThriSiHMp6TcwSH29iZuEckZmYkmuetBXvM+0H5oBCa/6KtHW61CBK2knAa
 SDyaJbvSv6VKpcIhYJ/CIKkKJoMEfq9YhZ35OFO6IucTnvFP+mJoZseI/GWH7HueM5En
 7GVA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxwSCffTwLj2N6vyIgnuh1ued3PR5IP15A8UKSFFwX5YZvynj8861sbVCsBptjK7e34gjgYgCHsgtgt2889arg=@lists.osuosl.org
X-Gm-Message-State: AFuF++nObpMb5/ItQtdw8zJYmxX5yAAyxCk1du+yo+SDvegj49COWG5c
 /k8OKm+fUOsxOURgspvl6l/d3XCaC4DiIKLG6vIdxap7x4qrVWl4yIyi
X-Gm-Gg: AYBFou0LHfjLWdVhLwT63H5GdemTvPp/fUGvienCHfbIv/kH2F52lNGI0LUKhvgL/IA
 OgB+7jbQOh0q0DTsXLPXvTMMbr3miqQPH+c7B21nM2mvViQwtlJZQbm3AcFxF9pYjHkZKNHFJ5u
 wLWYj97OJKHOxtzG3HhDSceFXpW7kgrnlSzI6cil0iNTMDZWiYHT6q62eWcGaW0FissZuiw0EVJ
 wT0kmpmbEAGRuV5IgGqVj3DEp6I1LhFIWKfzwzlJpR45jm4b6cpkygHQzMKbP+7FpAUeyNABXeR
 ub5zG7t0/2ADLec1gpe18cnTq+/4R5nkfYcoINagoAv924gZ4WpnVi42dTINKBkWr+CqiBZ0QMG
 rgZQE6PNv5800q6P5SswqszByBFIEFIPPsTe73JnBBFvQFegc+4f40pNVjxCnsUx3+4CrL5W0tQ
 NxFK/LM2KWqqOtOU0DuQkV59lARk1paGfVqaA7Qj4o3kMArufYf+Q1ztbp/YpPQzyowbCse7hcy
 M068YWo2JhIdF22kLHubbV5yr48uIPnmb27JFcWMjXdNP6RSOmiuLJESw/kqk/rIlX+cyqshc5P
 Iq0K
X-Received: by 2002:a17:90b:5705:b0:39e:2faa:2e83 with SMTP id
 98e67ed59e1d1-39e54d1e044mr15045770a91.10.1789961319791; 
 Sun, 20 Sep 2026 20:28:39 -0700 (PDT)
Received: from C9P9279WY4.bytedance.net
 (21.186.101.34.bc.googleusercontent.com. [34.101.186.21])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37c8e7sm11448715a91.9.2026.09.20.20.28.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 20 Sep 2026 20:28:39 -0700 (PDT)
From: Tian Xun Ng <luckilystar08@gmail.com>
To: emil.s.tantilov@intel.com
Cc: Tian Xun Ng <luckilystar08@gmail.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, aleksander.lobakin@intel.com,
 aleksandr.loktionov@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: Re: [PATCH iwl-net 1/2] idpf: keep the mailbox up while tearing down
 vports on shutdown
Date: Mon, 21 Sep 2026 11:27:32 +0800
Message-ID: <20260921032827.32485-2-luckilystar08@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <45ffbd03-653c-46fc-b500-07e9b99f295f@intel.com>
References: <20260917105205.37561-1-luckilystar08@gmail.com>
 <20260917105205.37561-2-luckilystar08@gmail.com>
 <45ffbd03-653c-46fc-b500-07e9b99f295f@intel.com>
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

On 9/18/2026, Tantilov, Emil S wrote:
> Actually we can't wait on shutdown. If the MBX is defunct, like CP is
> down or unresponsive, the shutdown will hang for a very long time. This
> is the reason why we wanted to avoid communication on shutdown. Have you
> tested the shutdown after stopping the control plane?

No, I have not, and I cannot on this platform: the control plane sits
behind the device and I have no way to stop it from the host. So I have
to take your point as given, and as written the patch is not acceptable:
each teardown transaction uses IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC (60 s),
and the teardown per vport is disable_vport, disable_queues (which also
waits for the SW marker) and destroy_vport. With a dead CP and two vports
that is minutes of hang on every reboot, to remove a fault that only
shows up on warm reboots. That trade is wrong.

What I would like to propose for v2 is to keep the teardown but bound it:
a shutdown-specific timeout, on the order of a second or two, used for
those three transactions when the driver is shutting down. If the CP
answers, the device is told to stop its queues and the stray writes go
away; if it does not, shutdown loses a bounded couple of seconds instead
of minutes. Does that direction look acceptable to you, and is there a
timeout value you would consider safe? If you would rather not have any
mailbox traffic on shutdown at all, then I think the fix has to come from
the device side instead, and I would rather know that before sending v2.

> This logic already exists in the reset handling, there should be no need
> to replicate it here. Do you have a trace and/or exact scenario that
> leads to remove being called while in a reset, but MBX is still alive?

No, I do not have such a trace. I added idpf_is_reset_detected() defensively
rather than from an observed case, and I will drop it in v2.

For the record, what we do see without any of this, on arm64 with two idpf
functions: after a warm reboot the device still has its queues enabled with
the previous kernel's ring addresses, and the first queue reconfiguration in
the next boot makes it write SW_MARKER completions into memory that kernel
has already reused. 20 of 20 warm reboots on an unpatched control node, none
in 151 with the teardown messages delivered.

Thanks for the review.
