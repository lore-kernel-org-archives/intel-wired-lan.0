Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42DDC98321
	for <intel-wired-lan@archiver.kernel.org>; Thu, 24 Sep 2026 18:07:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6715080C98;
	Thu, 24 Sep 2026 18:07:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BS-7WKiT7Dbe; Thu, 24 Sep 2026 18:07:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 821DC80EF5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790273237;
	b=tF8V9LOrcsfU1F+0tjNztGWyeChX2xS7O6bpwSNwQonwhXKUbOikPu48trjPrOKry3NG
	 roTQv+KuZ8KGSIDlpkDFTZq1Or0xoBeN2+pxGUGJXhk1ptkDpM2P7QTA0DCagpruQ5cEo
	 dEXSaYjtPPhLcniY38geeqj9vXIybLMSeRfxphx8z4rF0jNPKrUo1j0xiABJJAQ05QKCw
	 Sa0RPSt3nq+VfvP/E8KkvjFzBEaDRyRtKMTR0t+RDNz72hDyNnu5pc8N9XN/fhYVQf92Z
	 RquT/59pJRU5b0iacQ84HzmaJ4DdzqNNj4Zg4Kat4LYe3QUZrhjTn80DtxVSnqU3Hfw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790273237;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IyXPJ6ar109HpW1pFcFHtHGaxU+O3cC1UHabunMwZ/0=;
	b=K8EjIyUvT0ce/nlwrYNx5dVfWrkisKUkta2b0lEZ+/sie8w64f/ejIsN4dOy2FeFKL7U
	 h7sk7yDX7I7EDZHO+svU6OdAVkvorpZMZN+wgehQ3/AfSCt9h8gLi7pOa88tEucu5SmOV
	 W0pufJIzoaqgHV6tW512XAig14k1LwyTyPI054JP6CQZFPOMAPaaOgl/MVI78wL/8+t6v
	 DqvXaIP/Pm0aeauoSct/vFkbh5AQ2a234iyblzPUpPsUOvRhsSrUlWhEqlgkfFpcDJZGW
	 cK/aZs3OjdW53bf6n0XTknmRdaN7br1w7Hp/9JZbLfwU21lC7knYNyLebJ+34wb2sqg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790273237;
	bh=IyXPJ6ar109HpW1pFcFHtHGaxU+O3cC1UHabunMwZ/0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=4TSAcO7Agw3VRsmeMliihcQIo5x3XgVsD994Ccr/RyiL5Z+Q5PEX30WILx5KE4T19
	 4I74uVJ4pw0xfBkZHpkh/A0L8+aAJwMnIScEu6BwKKsedwCokvEmdT3thHn0Wce0Yl
	 h7ZXhLa1+4qfU7j1zOmTm5LuxcbRSeHyuy5IWuQ8kQNd5Lvww7y45d9Mz06ijrQctU
	 vc7FGDnQ3p/GsPaKWh81iRf7Rr/xTA2pfb1/3zZLx2B1NyqDwrBLhMVkUFfwN35R6V
	 hqkROW1rAgEZ+eymDjFQYLv0zyO6H957y/A0bqPNrAjac/uzP0i00mLQVJmyaD+GLM
	 C7NEn2PJRImaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 821DC80EF5;
	Thu, 24 Sep 2026 18:07:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E5670355
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 18:07:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CAC6B404B2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 18:07:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w4etkb4xEv6u for <intel-wired-lan@lists.osuosl.org>;
 Thu, 24 Sep 2026 18:07:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B5F1E40042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:41::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790273234;
 b=gHk4Q/Gme1vbr0imeYdyM69ID8AMjFnfCr6GExtCcRjJb6b9R7WLhELRNgkazY9ENnRN
 aoSBIqnOVTIYYX83bo2Qif1nyJIHTxjt8IpCR4lMPb+pYYZn4jorz7Kify3iimXPTLjTB
 cLt9gXyQjTX+/7RjTcpIJuISKby5OdgRP5FeMvBm08ve9ZMeKfdSlaUKcCjMSD8zt6o3g
 6+HVAki/jif0QZhZ+xG7McFGmRgT4JYZ86hlPySee5fmK23cnOE4J0/OEx6Ni6JCj6US/
 Oc9AZnaWWc0Da85jRLbHvxVEuEtTm98fpIUWfn1MTUs6VdOPRxLgoQy8QfP4av4W1Hg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790273234;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=IyXPJ6ar109HpW1pFcFHtHGaxU+O3cC1UHabunMwZ/0=;
 b=KaP5JvZLOaTQoE4ArxEozqNpwOnlD4ALabnxqYQ4jX81d3vkH9VZ659BhzO6tdT7ERy9
 GKjmfwm4ngO85fB3MlkezEC/+8SEF/+hJGjIMLcq9sxZC0qfS/qP9VwrOKNFRFBNNI1MD
 1CfoL/VWUB9Z5Du8DHkPg4JACJwMMqbaxwEK5x17DqycEtI110MZhC/Nh7MRl9BPYLNXd
 xrnbVfFWP6zT718YglbOfCVkE7cvnPOMLcxRtiHLxgYbv06izqGE/uImQhQZ/P4OftEKB
 805wMvFzbQx50wzDp1FIKFsCM+2Sn3bB4+VOYnGGxcNypnd1oNGJZO2gni+FvGv5tWQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ifFfGeQo; 
 arc=none smtp.remote-ip="2607:f8b0:4864:41::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::11; helo=mail-yx2-x11.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ifFfGeQo
Received: from mail-yx2-x11.google.com (mail-yx2-x11.google.com
 [IPv6:2607:f8b0:4864:41::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B5F1E40042
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 18:07:13 +0000 (UTC)
Received: by mail-yx2-x11.google.com with SMTP id
 00721157ae682-85d4ddd179eso1240517b3.3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 11:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790273232; x=1790878032; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IyXPJ6ar109HpW1pFcFHtHGaxU+O3cC1UHabunMwZ/0=;
 b=ifFfGeQoQ+vLyg2u9UrY2fsT7ePnbWci5JKC7fB8FcBqt18u/4x9irf3ojxxctkL3b
 kLGV6hyeMUbdKPfPdwKYmgx86Og0rTwktiziGa3oMswkEjaPCRRvVUFI+LHacMfnAt+u
 SL56/OU9S6kcsvj+JJqGFBaaNYfr0vWNafJMDZcqYLGDDqnnszrVAYdnevfZSDUNDlao
 pYWRUrpur3A+uALq5P7suq4d23bwwjadiuz7lEqeZMdxbYpt6GNXJGKQND6G4RytQgxM
 VPl/wVZUucLlRUqIxI1bvu0Uz1kl4hAQFLDHKRndToZHhuVHBGpDLuTw91olF60bRMiT
 lh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790273232; x=1790878032;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IyXPJ6ar109HpW1pFcFHtHGaxU+O3cC1UHabunMwZ/0=;
 b=XiySdTwHwYVViN1ntzZURcILfE9efezeSIUTIqxMoCgc7xdTbfwM+dljkds7QQUGsf
 WhENmV+tnG7Wvb0TPepEj3RMCY7qCRApvKJ1INqdOhzytNlVGyUew3BLZHOHY+isiKrX
 VeDC7lE7Syfdu7Ar6VFkpQ0FHPmYTwQEnrwGmMC9O4Vnq4Edo0B8tXiHfleuLUlIIn62
 HkwrdqDv+/6jIpKkQ9IxACg55dQoUz402sGNoMIIPUSfzgP4vo2ckTY0SMGthgFitCRv
 THHAQvd5kWZtQWZNKHWPz0e//QsvTvb925GtyfKEWFy+9OT+f69vR9xibP+sjqcHAKUV
 MCMA==
X-Gm-Message-State: AFuF++mTK9GUZjgAX53Nofy9xxHxu8IcCqMAkQJeBFt+fXk4plnhkrSL
 MwhA9vlOsi8WEDMFH3Vdg8/S+3hUJEg1AFv3mFo19SHFbuJIkDR2OCUN
X-Gm-Gg: AYBFou1KO2ow4ST6MMDhD2VOp1THcp0DrWkpMp8ltw6s+Y0sdj1tw56DQJaS6GENUZS
 ROFMkRVQDE/TAUSTyt+MAn+c0XdxYTd1I0PKEe2P80X4QQgYy/ViVnl0PkJZyL8ypHhiCUb0LVf
 yokhGIhygoItTztKPghVUp8WHZVD07X/oI/p82kyfy5859SuyzHJ1PoY2sJuokF5NFm7fky7ytt
 ORed11heC0CFFAwl9TxiciYw4khOQ5vMR1GnSIvfpiMaDB0RLhfrN4rWnlJLX7rCzvXBpqreBMG
 bbLT+7oAh1FtpP2xgxeRYxfYWS+36ftGJ3aseDHAEUvHJud1a1BTYHAYJ4mH1nKF0En0wYx3su7
 MQ/t1yuIK4dBQstjZQ4OMJSqansoRecUwHxsYG8QcOteAebG/uE766rv8bOurgyUGtQZZ/SY/sC
 iioGTN8hxJYzbOg0knnNEkuiMTbUcjbwtkJDnq308FyYdOyboIJ8OqNnpM5sQ7iqnWlYfH66A3P
 XXrksGtZ8Q=
X-Received: by 2002:a05:690c:e149:20b0:81e:f5ac:e40 with SMTP id
 00721157ae682-8a64707b472mr18946227b3.20.1790273231962; 
 Thu, 24 Sep 2026 11:07:11 -0700 (PDT)
Received: from ?IPV6:2600:6c5c:6b00:316::23? ([2600:6c5c:6b00:316::23])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8a86102bbafsm308787b3.39.2026.09.24.11.07.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 11:07:11 -0700 (PDT)
Message-ID: <42cccecf-ff14-41e1-811d-e5a44f3d1aab@gmail.com>
Date: Thu, 24 Sep 2026 14:07:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] e1000e: fix flow control stuck off after link
 partner reset
To: "Craig I. Hagan" <hagan@amazon.com>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org
References: <20260923235832.473-1-hagan@amazon.com>
Content-Language: en-US
From: Matt Vollrath <tactii@gmail.com>
In-Reply-To: <20260923235832.473-1-hagan@amazon.com>
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

On 9/23/26 19:58, Craig I. Hagan wrote:
> On an I219 (pch_spt+) copper with jumbo MTU enabled, a link partner
> reset (e.g. a switch reboot) can leave the PHY's pause advertisement
> bits dropped. Nothing re-asserts them on link-up, so every renegotiation
> resolves flow control to none. rx_crc_errors climb and traffic stalls until
> the interface is manually reset. Observed on I219-LM (8086:15b7) at
> MTU 9000 behind a switch that was power-cycled.
> 
> In the watchdog, detect a completed autonegotiation that resolved
> to no flow control despite pause being requested and the pause bits
> missing from the advertisement, and schedule reset_task to rebuild
> the advertisement (as ethtool -r does). Remediation is limited to three
> attempts, 30s apart, until the next link down.
> 
> Remediate via the existing reset path rather than re-asserting the
> advertisement on link-up; a root-cause rework can follow in net-next.
> 
> Fixes: 79849ebc0e06 ("e1000e: initial support for i219")
> Cc: stable@vger.kernel.org
> Link: https://github.com/systemd/systemd/issues/25925
> Assisted-by: LLM
> Signed-off-by: Craig I. Hagan <hagan@amazon.com>
> ---
I was able to repro this on an I219-LM laptop by link cycling with MEI
runtime PM enabled while the NIC runtime PM was disabled.

At 1500 MTU flow control still doesn't end up in the right state, but
traffic otherwise flows normally. I don't think traffic is stalling
because flow control is off, I think it's stalling because
e1000_lv_jumbo_workaround_ich8lan didn't run after the PHY reset.

I didn't try your patch, but there's a four line fix. Where the watchdog
resets just the PHY when the MAC exits DMoff state, set FLAG_RESTART_NOW
instead of resetting the PHY, then goto link_up. This works for me at
both 1500 and 9000 MTU.

If runtime PM were enabled on your NIC it would reset anyway and avoid
this error.

See:

https://lore.kernel.org/netdev/20190628224932.3389-16-jeffrey.t.kirsher@intel.com/

