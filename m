Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645ACCA6004
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 11:43:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3233B40506;
	Tue,  6 Oct 2026 11:43:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hT8r-WRTV0d8; Tue,  6 Oct 2026 11:43:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5D3CC4050D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791286991;
	b=ohv/N1gVcBP7TsfmOtAIvGXIpMQKPNybe0rhWc9Idss2Rbr7QwthMA1T7l+NI9V8VhWJ
	 KJUqVaX2ejuu9SGm6eYKIbRzwgTxSpfm6HKc4GHvW81plWSqql6Ou/OJ5lpWbgm9d1BDG
	 zbh3R20R3iGO6CbFaa2vF3QFxkwUKkRpRcSPTDjOM/lVMf9ySKR4ucpS6k5tvxpJWEKk9
	 M/Bd11te7xnrSSpxH/lWAZ9RpidF8HT+VN/1MZmsHZArI6JQlwpibfyyoVMNhsD6O7smt
	 jizkI0r22VR4Jb5DUxNjJfNwurVyWB0niFFUjMheDB8beRaJ2vcLhU8B1T5o7sGM36w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791286991;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:From:In-Reply-To:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3R29e74OCsihxaScB7A5LszBTHN9x/Z//RuBavLbJ3M=;
	b=UO4oeJM6F6hxx69uw4nI+qBRorqgu/EoJAimnIbPtrbcCSfsuB6hZvY2oXQbBwwWzOEk
	 kd5mZHptHHp7bpdNeSWpr79WeeEsdaOTypjOZCNE1AelACLQ6bjTqmxisRunaBQcv1Gyx
	 UM9C4OBbF4N3ZYp+4D2/NPDJka4FOtBHtaZO3KNI0AKa5DogyUzhid4s6olBA+LJdzGE9
	 42coSYk7tT9PdSIEPd9s+Ryq/P7ya8NQo6zEcK/MyDQhP1g5KR1ByvwhkLY0RIfTWLgxa
	 ZgAub9dK7OpL0C2yUmtPCGjIFjfAV0pUNjN5rx5VhuRduicnHYMFRgN1ai5v+nNjjrA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791286991;
	bh=3R29e74OCsihxaScB7A5LszBTHN9x/Z//RuBavLbJ3M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZkElijPAjh688FVV1BEmg/e7KhvMRTA7cqvY2we6G0TnisPqup3T1NnxEI98Vja9W
	 md2J739C4tJizQ5XLjKsv8MxHStT8xpt9caAn2RZCSALz+h6UCWPu/Gd9lF/D77Nno
	 iJzEyRSBeQKDiAJ34tUT25HBjfbf4o2Lk2/D5GuNO/rJM21vZJZzNC7E+KGq0IcMsx
	 6AfP9r1JoEvw53AQ9v40lj6x9CAELofQYXkARwcRJsoVHb6akirBwRMPYi0bbfFSKN
	 k0y6H4raKkaThBTwL4oL+vfQQln47RShFhyFu1rQNvAFrSn5hCvPVUhhxkhC82b1Sf
	 vAvmhGU5VRmiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D3CC4050D;
	Tue,  6 Oct 2026 11:43:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 706C732F
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 11:31:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 61F70401EC
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 11:31:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B3GgblzQXNS1 for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 11:31:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 85743400B5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791286266;
 b=IBOuh5o6QE/zJD4PFbuMOIpov5WunrNLWQbY2jCPnGESNkPLfww57lrr9cXATSMDvdDe
 AmmFNEiurVkyYjAh9Q0TcuWJSwyKCk41+yNbe9bTKZWtg5W++mk6t/xisjk/YDIKFStup
 XSJKlkB7yCFcPfbqxnqoNghnXA7/GnlPJPjUdqm1s+icgMb66M+U01Fq6y88vXo9VH5E+
 XQuWiGR5mt9/W29eDSdp55l761GCyTdUOHJrW1H1a4Z9LzTs9uD+Rps2ejxlyoG2smVC7
 yTciH1Yma4ff4BQ8fWJIu3PKr0TgbY52S4wfFZM0fMaK9ps9A6AZ6148ZW3g3Tf6lfw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791286266;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
 In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
 X-Mimecast-Originator:Content-Language:Content-Type:
 Content-Transfer-Encoding;
 bh=3R29e74OCsihxaScB7A5LszBTHN9x/Z//RuBavLbJ3M=;
 b=cbmQpmEVlddVolSqNo/2JRRlHazHFs/qfB0UdQVhthWOAVYKFSFVljhxzvtlG2BEwyiA
 J008StpJZzcIujZN8NNH4zAWi5nzuMMVzdQw0TC/+4TjUxOKXjRj6d1A70HlA5vzcUNJE
 fYw2RMccfVXl9Ragm70UTo2O6wNqOYATty55smlG2h4NJdzWZaRKSUANLyqIiD6Er5NgW
 7MiLTwNe8ht6Hc7/bU4rWcOXLUC/4S/3PlQTqniXttAYBNFyNDJ988utzAWZ6ALkdPpJ8
 9kME9DfkmAZO0lULWFfPda//7DySFWvLddK6Lk82dPzh6WfuslVQWqhMLhmJsS4GV4Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=aqzYdSuj; 
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aqzYdSuj
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTP id 85743400B5
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 11:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791286260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3R29e74OCsihxaScB7A5LszBTHN9x/Z//RuBavLbJ3M=;
 b=aqzYdSujWY/LGU6FYAhQTZqH3Oogm2c7kybuE0+E0BQGJ2ZALA7lgTanz11bpyJAYiyNAy
 nE3h8+seEMigxDvYydabFi3Ui38aTzJeTd+DrMGLS1noJ7Hux+3tpZAvD5tbwe5A2Qdai3
 9noOzcnaCze6a35ELwxs0Sy8LtIXjyY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-7k4XM370PWmDgnLZyn2a-g-1; Tue, 06 Oct 2026 07:30:57 -0400
X-MC-Unique: 7k4XM370PWmDgnLZyn2a-g-1
X-Mimecast-MFC-AGG-ID: 7k4XM370PWmDgnLZyn2a-g_1791286256
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a0284121c6so20524985e9.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 06 Oct 2026 04:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791286256; x=1791891056;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3R29e74OCsihxaScB7A5LszBTHN9x/Z//RuBavLbJ3M=;
 b=RVK+8VEmFvGUTdzNkt5nH8VExBJmEWxE5j8f+ABqJnH/LQdKuPDDZCJBSjdWeN/zm8
 co1w5chnELtlsaNdzgvLtFfnKeJ0nglWV1qzsAJsyjxqALqE6yvV6k3fSK/8jgnwjtbk
 Q7YuD3k7VO1O+RaEPvnOr1rRGCTHeXkd/F9Za2+E6JqrHiNn3/+pueFDsWY+j0W/qrnl
 KFtDlrqsspFl91T90TXCxw730ZKPwHnJu+6FRB8EVdezHrOpHokBAdcWuLPCxDoYQCoV
 o4cZYfVhPa1fsQ9MX5QI80ImBiB2Q+d6K1fuL+iU0ehHcVTGSvBt0rZnXyWXhCiDUsfS
 O2Fw==
X-Gm-Message-State: AFuF++mCY/GhyElWoTNNDPa+rP0S7dkqvERBncSw+aczhPNclbgfe+4M
 OVDd3M9JjsUPvrAO2NcydHAD9Q8UIKqgPvEB8ZYzohmcEe93oDYzsZmwYMCILSENZeD5r+/f5+d
 76HbyPqa70iwNrKP/fSNNiXi9jtXRkgGcB3b7gompZARQdJJIUrNEymdxHjhmgDI/ghMzXUo=
X-Gm-Gg: AYBFou06/T0Vp4L1/Rgr97pcsyRVRyhfzfRpEMJ3JnEU+qE2GLsv71dLE5rejMI81q/
 Ar37rdmCzthYLOEWWPGW9F3v0y+ArhtHfQJyzbkKyKiUr9e5XkeFvvrEBNU5p4WBBc0j44a972D
 +7fJcYoBI0fXffAG4/hJazSFPPdyuvmQ+aV36fRDYds3iCNH1zPoUkOj1SJvWsaUSRf8Jnr6O84
 D1IXrP2VCL4N/L1wxFyV2xc5xgdCvV9WlI/E52/2+pUbwyTLMZkD6dKKkxgwFdKu/CJMEVnQwTA
 1FQO/+flatQWNFvt5in6/gBUVkriHbBg5bmhh/B69qJ/V0U6DeDGyYJ0fWZckw==
X-Received: by 2002:a05:600c:3115:b0:49f:cac3:c68a with SMTP id
 5b1f17b1804b1-4a168105ddfmr171529395e9.31.1791286255716; 
 Tue, 06 Oct 2026 04:30:55 -0700 (PDT)
X-Received: by 2002:a05:600c:3115:b0:49f:cac3:c68a with SMTP id
 5b1f17b1804b1-4a168105ddfmr171528815e9.31.1791286254840; 
 Tue, 06 Oct 2026 04:30:54 -0700 (PDT)
Received: from [10.43.3.161] ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03fef174bsm257722415e9.2.2026.10.06.04.30.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2026 04:30:54 -0700 (PDT)
Message-ID: <ba8144c2-10f5-4448-80f5-d10d786bd8bb@redhat.com>
Date: Tue, 6 Oct 2026 13:30:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 07/10] ice: take the switch rule AQ error from the
 response descriptor
To: sashiko-reviews@lists.linux.dev
Cc: intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-8-poros@redhat.com>
 <20261002132739.B6C0F1F000FF@smtp.kernel.org>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20261002132739.B6C0F1F000FF@smtp.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: h_cg672KOZoMr-V01qRhUeSRkj8Bje6z27ssnoSBGQY_1791286256
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 10/2/26 15:27, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] ice: conflated -ENOSPC causes silent MAC filter drop on queue full
> --
>
> commit 5b00f3f5a2fd8517b295e1041c4e6854bbdcfd81
> Author: Petr Oros <poros@redhat.com>
>
> ice: take the switch rule AQ error from the response descriptor
>
> This commit modifies how the driver extracts switch rule AQ errors by directly
> reading the return code from the descriptor that ice_aq_send_cmd() copies back,
> rather than from hw->adminq.sq_last_status. This avoids races when other
> commands complete and overwrite the shared last status variable.
>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> [ ... ]
>> @@ -450,7 +448,7 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
>>   		 * should go into promiscuous mode. There should be some
>>   		 * space reserved for promiscuous filters.
>>   		 */
>> -		if (hw->adminq.sq_last_status == LIBIE_AQ_RC_ENOSPC &&
>> +		if (err == -ENOSPC &&
>>   		    !test_and_set_bit(ICE_FLTR_OVERFLOW_PROMISC,
>>   				      vsi->state)) {
>>   			promisc_forced_on = true;
> [Severity: High]
> Does this change unintentionally catch transient software queue exhaustion
> errors?
>
> If ice_sq_send_cmd() returns a native software -ENOSPC because the control
> send queue is temporarily full (e.g., under heavy administrative queue load),
> this fallback block will now catch it.
>
> Previously, this block was gated behind the hardware-specific
> hw->adminq.sq_last_status == LIBIE_AQ_RC_ENOSPC check. By changing it to
> check err == -ENOSPC, a temporary queue-full condition could be misidentified
> as a permanent hardware MAC filter limit.
>
> This would cause the driver to erroneously set the overflow state bit and
> return success, dropping MAC filters and leaving the hardware permanently out
> of sync with the OS.
The send queue can not be temporarily full. Commands are sent one at a
time under sq_lock and each one waits for its completion, and the queue
is reclaimed from the FW head pointer. It only fills up once the FW has
stopped processing the AQ for 191 commands in a row, and at that point
no filter can be programmed either way.
>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
>> --- a/drivers/net/ethernet/intel/ice/ice_switch.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_switch.c
> [ ... ]
>> +	if (status) {
>> +		enum libie_aq_err aq_err = le16_to_cpu(desc.retval) & 0xff;
>> +
>> +		if (opc != ice_aqc_opc_add_sw_rules &&
>> +		    aq_err == LIBIE_AQ_RC_ENOENT)
>> +			status = -ENOENT;
>> +		else if (opc == ice_aqc_opc_add_sw_rules &&
>> +			 aq_err == LIBIE_AQ_RC_ENOSPC)
>> +			status = -ENOSPC;
>> +	}
> [Severity: High]
> Will this translation ignore hardware MAC filter exhaustion during rule
> updates?
>
> Because the error translation is strictly gated behind
> opc == ice_aqc_opc_add_sw_rules, if a rule update command (e.g., expanding
> a VSI list) triggers hardware exhaustion, it appears it will return a generic
> -EIO rather than -ENOSPC.
An update modifies an existing rule and the FW does not allocate
anything for it. The VSI list allocation in that path goes through
ice_aq_alloc_free_res(), not through ice_aq_sw_rules(), so the
translation is limited to add on purpose, the same way ca1fdb885e5f
limited ENOENT to the non-add commands.

>
> Additionally, native software -ENOSPC errors returned directly by
> ice_sq_send_cmd() will pass through unchanged, leading to the conflation
> issue mentioned above in ice_vsi_sync_fltr().
  See above, that needs a send queue the FW stopped draining.

