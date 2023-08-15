Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE94C0015E
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Aug 2023 15:18:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2254B81F25;
	Tue, 15 Aug 2023 15:18:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2254B81F25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692112706;
	bh=ccvEwRBilKjRRM3+MLrQcH7Sc8wNC374muCsF6SyThU=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=t9c6ovCT8KQ+eCOo7rkyo7h6oHGxzlUzY8Qbj6hzdwqRIhtdOPujcBwr67M3PL8e1
	 r9LXQFbY8i1gokZ5yCOzgYgamhZ1QvsBtaEpwyHU6hqRW617w7+KCxFlB3PvstAytB
	 KP+FsMSsI+zqlBH69JTViqYA1ynSQBR57RIEX0HQ0fXs/DDJdGx0S84fcEHcsF8hEg
	 Si0yBinYna7qdnRUZJ/6QAJs9FnaST8wnCsBQbA75Zp8J5STv8XA2nMJqLNAJA/7CF
	 k5DRmJr4n25LHrPabWRjxhfsQ2fEmTT9kSoyrytzQ+h35tCrXcevH7v96NHZ7m3mTj
	 gX4SRTy0sUI9Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HwkaBgbKO3ti; Tue, 15 Aug 2023 15:18:25 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D51E81F2C;
	Tue, 15 Aug 2023 15:18:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3D51E81F2C
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 1E7EC1BF475
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 15:18:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C21EF402C5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 15:18:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C21EF402C5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w2y0nKUt0Hgy for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Aug 2023 15:18:22 +0000 (UTC)
Received: from out-25.mta1.migadu.com (out-25.mta1.migadu.com [95.215.58.25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6E123402B9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Aug 2023 15:18:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6E123402B9
Message-ID: <d5c30de7-df89-18dd-3ad8-a5d99c1e7108@linux.dev>
Date: Tue, 15 Aug 2023 16:18:16 +0100
MIME-Version: 1.0
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
References: <20230811200340.577359-1-vadim.fedorenko@linux.dev>
 <20230811200340.577359-5-vadim.fedorenko@linux.dev>
 <20230814202441.349586b4@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230814202441.349586b4@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1692112700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5jkRrsW9ZohDgZxdapSfROnd5WC/t+pIz3Z7RYOCEpk=;
 b=c5FEo+pNIRIQR7Ia0XE3msfztl33UetjSbeMLnJyhUSRhDUCP2kxoRpHGyDdwiMOcjW43J
 qoHzwqxkoMhZFA8/CC1eUtKOuhQ/885vlEtdkrFqcVDLMYBer7/m3NNBBM1aFld7cbsGE7
 w8ziAMKjx3NN87XuwGAI6Vrfj8zshdw=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=c5FEo+pN
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 4/9] dpll: netlink: Add
 DPLL framework base functions
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Jiri Pirko <jiri@resnulli.us>, Bart Van Assche <bvanassche@acm.org>,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-arm-kernel@lists.infradead.org, Jiri Pirko <jiri@nvidia.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-clk@vger.kernel.org, Milena Olech <milena.olech@intel.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 15/08/2023 04:24, Jakub Kicinski wrote:
> On Fri, 11 Aug 2023 21:03:35 +0100 Vadim Fedorenko wrote:
>> +	xa_for_each(&pin->dpll_refs, i, ref) {
>> +		const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
>> +		struct dpll_device *dpll = ref->dpll;
>> +
>> +		if (!ops->frequency_set)
>> +			return -EOPNOTSUPP;
>> +		ret = ops->frequency_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
>> +					 dpll, dpll_priv(dpll), freq, extack);
>> +		if (ret)
>> +			return ret;
>> +		__dpll_pin_change_ntf(pin);
>> +	}
> 
> only one freq is reported in get, AFAICT, so why send a notification
> after each ref is updated?

The pin can be technically connected to several DPLLs and app may watch
for the specific DPLL messages only. We would like to inform all users 
on any DPLL which has this pin connected to.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
