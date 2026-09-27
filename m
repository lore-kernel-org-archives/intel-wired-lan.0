Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE45C9832F
	for <intel-wired-lan@archiver.kernel.org>; Sun, 27 Sep 2026 16:26:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5481380EB0;
	Sun, 27 Sep 2026 16:26:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ttOrIZ2Sdk_O; Sun, 27 Sep 2026 16:26:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A4F4380EAA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790526406;
	b=PXk9/rhxqQ/FAO2IGZcoOnPn1RsklBfpewDixeG65YiDYZAEPcOEul5rGmyOnbjTq9S2
	 zja2WEpe7E2RjNrEgfPRcrIKHP4BBrq7iRa6gSEppMQorAOimgLqyS/OIfL8UebWv89Y0
	 P3j6Nhm303A6JGfm3P0vPg/3NRc/HQZfofkpDoWHjtg0cuvRj2X1YOFoucFUU3yb0PfTi
	 nNIQZ54BvileSfmVCN8WiDEbZm3oSkn2/aHfuN1xZnWeBS0YDfoqKXcDAgeBbd9OG0B8B
	 6+K/8RUYtvU7EvVqjkH0DUEdZrTmSBdYrUpIXuh3y3GXTQopu8rhOQPHESXXi/nHzyQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790526406;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xVSJl+C8yyYXuCquufuoFeFnXFMEAMuxSB/TRy2Nuto=;
	b=KfHusLCEwrSIO8AAnZOHf0VbSHYC15zmR7HhQO8I56/gvr8I7qM5I8KLKdAtUI7yaX5Z
	 p6QGHsXnvSjHsCbThKTRdF0QjPL6FJJLBazcW8WcGiu7ywrut5SrVg2GMQEyvKgYE4kEi
	 fXtefrvmKszMSNET/r91SxG7+oYHGxbM0d1uNCExIbPoElm1qSqNVzF8Ija8/Lh1VNbaM
	 2ipepHX0bf1s3xL9UtYZVrT82yVl9g+M8k84mF47CHShs0vfT7o0y8QT58Da/e5xn2vwk
	 nMVNDnw4cx7KM25MHKbFXFxqFh9vy7V/TYpB9Ww4HDGNOpwmW4aXXGNIO/j7W+9RkYA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790526406;
	bh=xVSJl+C8yyYXuCquufuoFeFnXFMEAMuxSB/TRy2Nuto=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qIzY31Ltpg/uCefiKkOPqna094tTwo7PxpvAAixIhYhl6Wmq8vYXJblFN22wTuZJK
	 j3rEeF8ntzMkXl0qotkVFrBu1TrZ7Xd4Tr/mu95xJSex5TsokXUW4fzzKheW9xsVFA
	 G98AwEkUTBhvxeu1bL7rolsPZjvyIYLRt5IO4WvaUv4abHJzUlkctDwy0Knbxghi/2
	 0bhsQcgtuKi3raISQJQUEtcPdlOVd+2Ya9KDDDRzlhqdLnDgtP7Dhil0zo8uwPJ3/h
	 iHpWPrZhuWts8MhD4opIGZhOGwsVD9RqXxCJY3ygxOG7JQDVL+RI3vB2fj1966IKlr
	 F+69b9tT+7s+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A4F4380EAA;
	Sun, 27 Sep 2026 16:26:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 254B2422
 for <intel-wired-lan@lists.osuosl.org>; Sun, 27 Sep 2026 16:26:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0AD5F605E4
 for <intel-wired-lan@lists.osuosl.org>; Sun, 27 Sep 2026 16:26:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vVYUg6l5RKkR for <intel-wired-lan@lists.osuosl.org>;
 Sun, 27 Sep 2026 16:26:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 356D360603
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:36::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790526404;
 b=FS1ZwvV+2ej/3pB1U+6tGJDzUwPjDFlRq+qC4ZHif2SJs+GtcAVXkp9fIUwD5MC6415j
 +HR0u4ANPMHfXwvHchz1k/jlqHC2AFu7shf45gUs2cjqjSTNTdsCqD0oYeg5h7rRpRoTM
 LLFOu1qU0rv8Xg9M0O8g+vS0DaLIHVSKGobysr6HnHO1EppxoBDFSy4V2qusD1i/iu+d0
 MRQc+8rmxkFplwii/1gs6v+IqkdfYSJYpozRn3hEoVGg3FXiBijjt+IotE0J88OCkdGxC
 8WAJc1y2NSg+LmlZvwNfv5dQhFvyn01zKyJbx3fh/ad6nabNWiVxfUm53uI3dMAMPsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790526404;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=xVSJl+C8yyYXuCquufuoFeFnXFMEAMuxSB/TRy2Nuto=;
 b=h0JQSuQhcFp8ZcbiqZ7IVIz63lpRpzkSkLJwXvF1h4CX1TEOFcs8LqpTvIKN6jF4Pr//
 XdouSF7ByEyoKHSZzJWrA8ymLnSIy1fEbceLaoNZ6mcF1+fHukpQYT4d3OKX85kF/ECfX
 T8UMl+mPk8qWI1TfnK8Xz9qXWBMWN4u96K9cbk/X91/rYmfFmVMxKT4vdyVtZ/iXYe81Z
 AHXb2ZEfHyrq1z6QqcHpzvjRb0xFYRskc2h/gzGzNjc+vc3ZPXrVE1gB67Upk2IR6+WDK
 mZ7V3CrgFdaXmEl0I9WzjTR97pCtM2AQYvbnj+NbwLpZf7guRNy3n2b4iEGCtCWScLQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=rc1DC6aB; 
 arc=none smtp.remote-ip="2607:f8b0:4864:36::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:36::e;
 helo=mail-dy2-x0e.google.com; envelope-from=tactii@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=rc1DC6aB
Received: from mail-dy2-x0e.google.com (mail-dy2-x0e.google.com
 [IPv6:2607:f8b0:4864:36::e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 356D360603
 for <intel-wired-lan@lists.osuosl.org>; Sun, 27 Sep 2026 16:26:43 +0000 (UTC)
Received: by mail-dy2-x0e.google.com with SMTP id
 5a478bee46e88-341d5303884so1460917eec.3
 for <intel-wired-lan@lists.osuosl.org>; Sun, 27 Sep 2026 09:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790526403; x=1791131203; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xVSJl+C8yyYXuCquufuoFeFnXFMEAMuxSB/TRy2Nuto=;
 b=rc1DC6aBg8HmKZzQRIptS+LIkBKxSh71cPOQg11BlC8+AGi8DNtBMQaG7NVxN390OP
 sRmkv0+rX7Aw6YSuj/pXn4eEyOgUerbiL8EDxRvdQdivl/qSzb4dkQEr0phEI0ybCPCZ
 kaXzMhekLKj0AJaWJrAT7ty+DMqBaDgf+EiYgTHpUXHfsI2Bku1bvnNAWl+bZT4rTYc7
 z39l6LbgSdXG/qvuJKzxuuxJ0fhMwx4JceynhSq+q7wrZKDQ3l0GsYdcUh4OCbrvLimy
 Z8GF+ewRjgKxbBZo49gE4iOEtqIp4UWpjlPLLIIcAakJtjw+NxQ6Ew5GeONOf9mOfl+1
 C63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790526403; x=1791131203;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xVSJl+C8yyYXuCquufuoFeFnXFMEAMuxSB/TRy2Nuto=;
 b=jKJz7XUy86gVb4e5NcVWcpp17ie3lnjmTaogXaWRLwfHOvNAkQ0EZCNbOZPdyv7Bl+
 EZuLj+JpwBJV1FvWMGB8UCrYdF2KmoVBnJkoVVY9tz1MMy5N2Fe9n9NgQMhukkhMq4c2
 XCyRyGPzw7sC4xAUqxVSzD3GajsyGplNQeQGDISc40XQgnm6EK7O9mFaBa2JR2OTb4uW
 rg95lDMcjDm33SBX8J5lrXK4rAz2W0u/ig5D3wUdElncMt50Zvi7L62GGzbFPMd1mPzU
 goAAPQueDp4yMufcGfBRSsz2eQiWvKdpRgGtgDNYEMX8NgWOyjMa+8UnlMO5WNFUcjx8
 LLBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwupLAc/CoN6XkztifVTjSSketggpp3o6x9lF0D33q4LeEGNFChJtv+SlMEG9fUPwDR8Gx++dP7O7UJ7tiOHUU=@lists.osuosl.org
X-Gm-Message-State: AFq9FYJoSacgNCHSEwux0Z10ZUKNioOIKfq2yQxUdjYcBRwPbF0fSYcH
 dJyf/QpSCzNXJnJQ7s7ZnGIV71OOGkqbnR8AH++n6iAy1Je6JTttNT8J
X-Gm-Gg: AYBFou3pX/EuhdyCtPkC5kylkXVUfJsEDaYWnPnLUsLgyx06cxcsrCAD6ydmJFu9ATX
 MmRoJu/1RMbrWRF+AhMb6Xk+65/bQMxEoiAvB8oo3zTksIDampAI537LUOSYFlLIQkbuGpTR1tj
 cG7QcQWB57/yUEv2mLDYjdFQzKA4AtnQ70W16cBvPYa16JyKbV4UyW3BcEI7O64ucr2FRkbpW2p
 t6wBAQO9QXbzSIrkF3B0cszmryAoQKX1W4OovEveG2njVAFfzWhMmRpnkHMsBD3U7GTrUGIayXL
 UiJaOgdt8pEYhB44/OrzUA9cl7o6DymAaez3JsB1ZcPrIsTxwYno6XJu0Qsa4F0CF56t5lAxw7Y
 b4gxnOdAYXl5P1KX9Ajz4FnmZTLXyYJTEBdRo0Od+S7i41kXInl3RXkRsLfKETYFpJzMJJ9OQtS
 qz7EYOpWlM56+Q/5ihbB3GlHfUMqFkI0ci3gxk7AMSmuIO5Z7g2torHhUwP3hk/uux06GHhj6Xu
 iFUqCjlxDJmEDjy/TIYoA==
X-Received: by 2002:a05:7300:16a8:b0:342:4a2f:49eb with SMTP id
 5a478bee46e88-34272b4bc8cmr6850956eec.38.1790526402504; 
 Sun, 27 Sep 2026 09:26:42 -0700 (PDT)
Received: from ?IPV6:2600:6c5c:6b00:316::23? ([2600:6c5c:6b00:316::23])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3475546b1aesm864022eec.4.2026.09.27.09.26.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 09:26:41 -0700 (PDT)
Message-ID: <274e9217-834f-43f1-8d71-e64b12052fff@gmail.com>
Date: Sun, 27 Sep 2026 12:26:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] e1000e: fix flow control stuck off after link
 partner reset
To: "Craig I. Hagan" <hagan@amazon.com>
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net,
 edumazet@google.com, intel-wired-lan@lists.osuosl.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 przemyslaw.kitszel@intel.com
References: <42cccecf-ff14-41e1-811d-e5a44f3d1aab@gmail.com>
 <20260926132744.24777-1-hagan@amazon.com>
Content-Language: en-US
From: Matt Vollrath <tactii@gmail.com>
In-Reply-To: <20260926132744.24777-1-hagan@amazon.com>
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

On 9/26/26 09:27, Craig I. Hagan wrote:
> On 2026-09-24, Matt Vollrath wrote:
>> I didn't try your patch, but there's a four line fix. Where the watchdog
>> resets just the PHY when the MAC exits DMoff state, set FLAG_RESTART_NOW
>> instead of resetting the PHY, then goto link_up. This works for me at
>> both 1500 and 9000 MTU.
> 
> Thanks Matt,
> I've tested this approach on two I219-LM boxes, each attached to a different switch:
> one a TP-Link TL-SG108PE V3, and the other a Cisco Catalyst 9200.
> 
> On the Cisco with jumbo frames, I'm seeing, via a diagnostic message, that
> the fix appears to fire and work. I have also noticed that I no longer see
> it on every boot, but this may be correct as I've not seen traffic stalls.
> 
> With 1500 mtu, I'm seeing it engage fairly regularly with the TP-Link but
> not the Cisco. I'm guessing it is related to how the Cisco negotiates. In both cases
> traffic doesn't seem to stall.
> 
> I think you are correct about flow control being a red herring since
> both switches advertise no pause (Flow Control: None) before and after
> recovery.
> 
> I'd like to drop my patch in favour of your fix.
> 
> How should I proceed, should I propose a patch with suggested-by you, or with your authorship and
> tested by me?

Feel free to add:

Suggested-by: Matt Vollrath <tactii@gmail.com>

> 
> For completeness, here is the diff I tested (I added an e_info so I could see it fire on the
> test rig; happy to drop that line - it isn't needed for the fix):

I would drop the e_info.

> 
> 
> 
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -5254,9 +5254,16 @@
>   					usleep_range(10000, 20000);
>   					pcim_state = er32(STATUS);
>   
> -					/* Checking if MAC exited DMoff state */
> -					if (!(pcim_state & E1000_STATUS_PCIM_STATE))
> -						e1000_phy_hw_reset(&adapter->hw);
> +					/* Checking if MAC exited DMoff state.  A bare
> +					 * PHY reset here does not re-run the jumbo
> +					 * workaround (e1000_lv_jumbo_workaround_ich8lan),
> +					 * so request a full reset instead, which does.
> +					 */

My two cents is that this comment is over-specific. In most places a bare PHY reset
is not used, so the transition is toward less exceptional.

> +					if (!(pcim_state & E1000_STATUS_PCIM_STATE)) {
> +						e_info("full reset on DMoff exit to restore jumbo-frame configuration\n");
> +						adapter->flags |= FLAG_RESTART_NOW;
> +						goto link_up;
> +					}
>   				}
>   			}
>   

