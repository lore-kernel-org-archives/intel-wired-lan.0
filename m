Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB26CA9ED0
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 05:17:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DBD378096F;
	Tue, 13 Oct 2026 05:17:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EkrpLal1YjsR; Tue, 13 Oct 2026 05:17:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9FD8080BEC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791868629;
	b=K1u8U6Y8fzQINFKbIha/iEcvu78tv9UVgGvIMXfom1JZIJE7Ccru64D1wrft089lQMnn
	 D2pod7lJRZgt/SCDSx9FNCAau/SAFBLbyxaxQe0Unky7w8xvOaM5KgjA+oYI7HoV/CFMJ
	 HU7NlV9SSDtEZWiL8aLwp45HIqR26ALWGN8wA534zy7d8ZFEcJWzL+CiU/ofSdRddGUOi
	 aRjwWZ6/Urq61/tuIYted6YZWh1kKlGXp5h64yzWLnrqUmhiTBf9Ot5xxffg0EkLKLCdT
	 ikjIC1dqQ3NWEMFDyS2f2LS//W6oGR7+Zw8rn/CaIqLHfUxxJcjlmVEcHvFKAaPwNDg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791868629;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:DKIM-Signature:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Qy9kjtCa0zo2FpQBTNahs+5lkxvy9j8DxA9ORMQnlvg=;
	b=jqTfQLfHlI609U5k0Bd+nmgXo6gnT+xTY4wSPyp9zLKdcl226+Bxx+VznmXo8GzbS9ZQ
	 3neIcagr97NmaQEmEaBGPca9GMransV7201Xt7oMy9EF8jUtuw7VWRXfwk3cVm6VwZiG1
	 vT3b2xFs4Hww5NJ7L5RDx79shhANW0Tdhf1I6ahdw3H6Dq1PQN2rXr/7wvi2myU9xz/wT
	 Jr31SP+EPk3zC/UOymEwNOAjEkW7ks6Y3k7MbazxRVlY1CZBV+SN1DpfTlKEJVD4eHHkD
	 2YPZjtsY2SR2i+24TbwW8Ki4+oQBjyU11jRXbXGeVL0qTE6kWPtDEX48aBZ6X6OADFw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791868629;
	bh=Qy9kjtCa0zo2FpQBTNahs+5lkxvy9j8DxA9ORMQnlvg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k/0FJiauoioIpSSkPShTyhSDpzwYdQQS5qRizmjftGKreCo9Ku6x8iH3yMa0s8nAp
	 Av2bxzZKMY5mXOJ91viK+fLb3KJvctv9YeKK4VGBBAgH70bsK+zeWVQBDRg4sob1R9
	 0788qZas4nvCSEruHW4QdtWUebkmC7FzgTgIBNfAej1uB89hMw9kqKL6r65pjvYI5i
	 a5jSVxf4wZzeh2H0bO/+xD4b3FKT/axY80SCOCqHpZPoInSQyndeooRvg+etY3wk/I
	 /LFKXP2RRA8eOXOR81jmxpdmiqGfwyDLaP/M3Q3/pzb51cFUbMWoJH2hi+WXVkg0v1
	 Bv5PTbV1bBSUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9FD8080BEC;
	Tue, 13 Oct 2026 05:17:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D76FB4DD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 05:17:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D52CF606EB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 05:17:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9XhRXU84QjWf for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 05:17:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 090CA6066F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791868627;
 b=okEHT9oJ9mYBo25IO5unDZUQ/JFr3AyNxHn0u0yn5cLB18Soh27pc6lNynimsW+9ykYT
 c67I8hcv4ZDPECdyeDHqP6fEFUa/GzshjkTaT8qzJt5r9E89E6zWin9hozFtVqKA7gS2P
 kCXYVO8UMjVBJOT16eIVcdD+grSXZCMEN0mBG63A31KLIhurqQ2m3F4arHc3cbdY551cb
 YqzJ9T/PjMkbtlY+O7gBRo7qGEGszGKMcUy328Qu1LW4YDQjtCadcShL1BoA+iUDtuG0C
 kJKRvpo+XazgC83F1jdqdUkmeYSnmIwlZQE6UOtWlpfROGXiASvDujmdZe3KjBBohuw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791868627;
 h=Received-SPF:Received:Message-ID:Date:MIME-Version:User-Agent:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:DKIM-Signature;
 bh=Qy9kjtCa0zo2FpQBTNahs+5lkxvy9j8DxA9ORMQnlvg=;
 b=lmgm/KBC6YDiHip0g5H8L59VzQt7S7IoRlWgVDogtTRlqvoZrq+Hw0XYSMH7x/18Y0yP
 2uq7szQ2UNagSVaJ2tn5JgNGW49vSCWyjNWWROsnfmiaz3F5tKkt/ja5YbcxzM9KJXQAG
 kS72iL0jA+ZNWehgIoYVZpyZ20OXB/yexiimKg8MDeyMTydMdex4uUSrJnlDjjBmo5a+h
 w4skeYkFIucf1uFDS1JV9DmByU+7AYveQCqQtPbv+yp9bDbyIF0+VUQrDM7esxaURj4/y
 rEpjB0CP894alm9yy/UKMNMknbM3RLc5yLWFh2IVw4eqjNNhxeocSRjwNrBQC5/Ox/Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=molgen.mpg.de;
 dkim=pass header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256
 header.s=20260906 header.b=PmvytI5Q; 
 arc=none smtp.remote-ip=141.14.17.11
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=molgen.mpg.de header.i=@molgen.mpg.de
 header.a=rsa-sha256 header.s=20260906 header.b=PmvytI5Q
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 090CA6066F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 05:17:04 +0000 (UTC)
Received: from [192.168.2.230] (p5dc5512e.dip0.t-ipconnect.de [93.197.81.46])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id B38574C442F906;
 Tue, 13 Oct 2026 07:16:33 +0200 (CEST)
Message-ID: <eea9e99d-ef6f-4bd6-abb2-54fb9c53a7de@molgen.mpg.de>
Date: Tue, 13 Oct 2026 07:16:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] e1000e: Add additional systems to disable K1 list
To: Dima Ruinskiy <dima.ruinskiy@intel.com>
Cc: anthony.l.nguyen@intel.com, Christoph Groth <christoph@grothesque.org>,
 ghrafn@proton.me, intel-wired-lan@lists.osuosl.org,
 Mark Pearson <mpearson@squebb.ca>
References: <20261012214113.69770-1-dima.ruinskiy@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20261012214113.69770-1-dima.ruinskiy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de;
 s=20260906; t=1791868595; 
 h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding;
 bh=Qy9kjtCa0zo2FpQBTNahs+5lkxvy9j8DxA9ORMQnlvg=; 
 b=PmvytI5Qvju/Bc361dbj01fpVV+yGcpJltdoiRyTVGmVyEcnnonlssc3iZS6fK52axqSzrX7P3BZ
 ntLDaQpBW/8q+sdQEZbfirCMLoAsPsIFzjGuvRvMsVn4FNSnm9nhfvnrhqZom7ZsZEUNiRrBxb1NsV
 hUWQTuj3pwuehO6x9szwkpws2wkoZ8c3kLy+L1Yyj2TIEXDY3+96MaKel7AEdDBHQThzcZkuv11Pcn
 1VIr4S5TwrIHf7jYwWeu+lQ/gwLHrgzCIDwXpefb2cV/l3ez458CmGAR+xHO2qdcrcqdgw7q7uP7fZ
 muGtNhNBmAcSEHdhAQG1rukC4xCJ7hVg==
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

[Cc: +Mark Pearson for Lenovo to maybe fix firmware to support K1]

Dear Dima,


Thank you for your patch.

Am 12.10.26 um 23:41 schrieb Dima Ruinskiy:
> On some Lenovo laptops performance issues were reported with K1 enabled.

I’d make one commit per device, so the device can be mentioned in the 
summary/title, and it can be reverted more easily. It also helps 
reverting commits in case of problems for just one device. Should you 
stay with one commit, please at least mention the devices in the commit 
message.

Commit messages should also be self-contained, so describing the 
performance issue would be great. Having the firmware versions directly 
in the commit message would also help me.

> Add them to the list of systems where K1 is disabled by default.
> 
> Cc: stable@vger.kernel.org
> Fixes: 578294b8b60d ("e1000e: Reconfigure PLL clock gate timeout and re-enable K1 on Meteor Lake")
> Reported-by: Christoph Groth <christoph@grothesque.org>
> Link: https://lore.kernel.org/intel-wired-lan/87v77ial45.fsf@grothesque.org/
> Reported-by: ghrafn <ghrafn@proton.me>
> Link: https://lore.kernel.org/intel-wired-lan/_kB6DUeC6oOmJnK0FobVVJHADewewO3wzeFw_GrempgMu6s5CUwHpkT16Bwn8tXRq0k_CN4b2NY6API37M6mVciEpH6DKbTqK7f13KMpmgI=@proton.me/
> Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
> ---
>   drivers/net/ethernet/intel/e1000e/netdev.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 834a5b8883df..35c729368684 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -74,6 +74,20 @@ static const struct dmi_system_id disable_k1_list[] = {
>   			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad P14s Gen 5"),
>   		},
>   	},
> +	{
> +		.ident = "Lenovo ThinkPad P14s Gen 6",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad P14s Gen 6"),
> +		},
> +	},
> +	{
> +		.ident = "Lenovo ThinkPad T14 Gen 6",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T14 Gen 6"),
> +		},
> +	},
>   	{}
>   };

The diff looks good. With my comments addressed, please feel free to add:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul


PS: As far as I can see, it’s not logged, when K1 is disabled by the 
quirk list.

