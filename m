Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE58C5AC7A
	for <intel-wired-lan@archiver.kernel.org>; Fri,  7 Aug 2026 14:11:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80FF460A71;
	Fri,  7 Aug 2026 14:11:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 21mozyeJ8DGQ; Fri,  7 Aug 2026 14:11:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 46CCC60A47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786111901;
	bh=jY/yOsvpc9aWjuEvUxwTi0KWtinXasaO3wK8pTemGEY=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=B83znlMaolY/iBsoahnhDmiB21GUGptXaXLWHY9ZRzKZrv4VgzTY/lrN6BQ7TNgmR
	 8vGT3hla2W0MAR2XEiyukm+6ZWblFd85dkYExMsLDiX3lKSwUPPOV0nxSx5UVcOr5z
	 kwnUo8aArd3Zb1gvF57zIFcEBA7FVhJVjQrGZZVrZ7MkzhXu57iCjedLS0fFNX6zPq
	 c3zOiw9Ma9kmTCiCvhWW60MSUyEBFHFgqYDl80BRbR9MjTVglfF9IJnB2Ju/6fzKGi
	 7R/7DULF+z9dN0/cmE3KOfK9bZnbkVr7IacSUwlx7mGdExFTf4ICA+eLoq588BgCtd
	 c8yqaMtRO0O7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46CCC60A47;
	Fri,  7 Aug 2026 14:11:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 932C3259
 for <intel-wired-lan@lists.osuosl.org>; Fri,  7 Aug 2026 14:11:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 798E940207
 for <intel-wired-lan@lists.osuosl.org>; Fri,  7 Aug 2026 14:11:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ociJKxhLjmNX for <intel-wired-lan@lists.osuosl.org>;
 Fri,  7 Aug 2026 14:11:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=jeff.johnson@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 825B740246
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 825B740246
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 825B740246
 for <intel-wired-lan@lists.osuosl.org>; Fri,  7 Aug 2026 14:11:38 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677CgWiV1295464
 for <intel-wired-lan@lists.osuosl.org>; Fri, 7 Aug 2026 14:11:38 GMT
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6gvbf3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <intel-wired-lan@lists.osuosl.org>; Fri, 07 Aug 2026 14:11:37 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cc73f47bdcso57817655ad.3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 07 Aug 2026 07:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786111897; x=1786716697;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jY/yOsvpc9aWjuEvUxwTi0KWtinXasaO3wK8pTemGEY=;
 b=UM8um1KbJ8pmuLGPpd2jgq4w67TEDQw7OFHPjcBR/cha5rGyqg9yUwKnNMGAFdtDhb
 uORZN+dTYcEAlnOZsR2bKJ1VCSfBgLMUxSDldvwxTULyB+Ongp37cKPbSCf1Eh1hCKvC
 eSyfsjDNuGULQhOcXpF/s1XvBdYSX9e8wv5gNh+4Z0ViqxUvqk5kjzwVeMvWVm6ScdB1
 5XYW3gnnkIzZinc1wpfVywaWvsk21IDOFhA60o8foJKlaSWcqzqdXNyMOWRY17gbdNGi
 Ia9SZdDu9bBPZN8Qa7QSV8F7eSgTLK+mjaR0NaLyUa6aHRazHF5Nl2u0lF/Scd9oMB98
 1lqA==
X-Gm-Message-State: AOJu0YypnzHk37k0kV6vaY4gU4a+TVGPJtr/wpM0JmJMYScfbo4/toFE
 qUxarzt7gSECJ5nErDz7vId6Y3ZihrxQCcPBPWKneGK2pTMB4fHJbSoFEZKqztr5jz3C//a7fPP
 TJK7PXjcTRmT2uUS/RrCgwQUhBr2t1C5BP+iuDfTeH07tnKcEfGnhHLCjRFKhgLQr6S3BV5fz
X-Gm-Gg: AR+sD13gEFdJi+oU6UmWiHtqQCtBEgCxjSxsOgcFrEOTqm4DG55mCwjEqDdaCnvGy/a
 ryFECuuk7Cg4PAI/3w+T31ExJ40ynZYj7evBVqNPfxtOShVIKAbKrnGARy/pZNrqydelRBbAG2S
 +UG/CxkAwDLTSB8X03x3eGVF1pgQidrPuNubAKnRI6b+U/J4fEJbn8ohH1enJFw1nkHRgBlRFkf
 WCtdNGuIrefrl8Q5rOl2fjYqRVLL/vmKusodlOzOS/bcAky+TWUSRtRqvu05prTz9iEtTEr3u09
 D6RideAVlmqDFms2ZtuPWIKY5mTxj+m154U7JfOviynyG/g1vIeF/Wt3SHgd6D2EMYxf+AhIPiU
 4WMv0mI783qqRtm7e0EYt92QaqIqFwm3rmAdCkDjIKbscQ6iqC5qZmS6+ZUpk
X-Received: by 2002:a17:903:46c6:b0:2cc:864b:539 with SMTP id
 d9443c01a7336-2d0ca713b0dmr274945745ad.6.1786111896718; 
 Fri, 07 Aug 2026 07:11:36 -0700 (PDT)
X-Received: by 2002:a17:903:46c6:b0:2cc:864b:539 with SMTP id
 d9443c01a7336-2d0ca713b0dmr274945125ad.6.1786111896262; 
 Fri, 07 Aug 2026 07:11:36 -0700 (PDT)
Received: from [192.168.1.20] (103.sub-97-215-187.myvzw.com. [97.215.187.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d14d57f8b7sm10026305ad.30.2026.08.07.07.11.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2026 07:11:35 -0700 (PDT)
Message-ID: <2480a569-de5f-4d91-9b9f-60a46613e5ef@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 07:11:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Ally Heev <allyheev@gmail.com>, linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
References: <20251116-aheev-fix-free-uninitialized-ptrs-ethernet-intel-v1-0-0ddc81be6a4c@gmail.com>
 <20251116-aheev-fix-free-uninitialized-ptrs-ethernet-intel-v1-2-0ddc81be6a4c@gmail.com>
 <72754805-575c-4568-9dab-514e1b758847@oss.qualcomm.com>
 <ae840989-03df-4e84-a9cc-46c51f6dd44e@oss.qualcomm.com>
 <8f35edd6-6b37-4575-8a30-558ae0dee0bd@intel.com>
Content-Language: en-US
In-Reply-To: <8f35edd6-6b37-4575-8a30-558ae0dee0bd@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EYH4hvmC c=1 sm=1 tr=0 ts=6a75e799 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=UaEkX0D7FlC0tWE/LoNF7Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=XQPYAtKPP1igbtPNMl0A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: nCqI2euVeQLfZoDZWRytHtTtRJxuzkZf
X-Proofpoint-GUID: nCqI2euVeQLfZoDZWRytHtTtRJxuzkZf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExMSBTYWx0ZWRfX+sAgAtukfWYK
 F+q/42jrpQMNguI9fLfaTOrX2fLM/nadldFgWzc9kbT9K0puqicET339pfP/bEJfbFS6JUOV7bt
 Yx/WvfEnYN89P7ZoM2xmQ0bvMZh7tzA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExMSBTYWx0ZWRfX9Q3BhMLDVcgW
 RIUX2zwrHANTUfitANt2zWwXXDl/1+Gzo+H1ZP5YaxcFzcc6OJmuDJcvG1F/eYWVF6KsmQjZkJ6
 aKC0z9KgI6CFEYC7CQcTiJtCkuQ+aiTezAMTUGOrFKoI+qkGNJLqNLBy/piW8eM95+u3OdKqx97
 sU8XttDiXoDmIYpTZf6FL+TQC3qDRcZ5oOzZaeTIdsKL4vOB/F3A4mwJKrbxWzP5VhooXQVacqq
 ywmsBuNegWmrX02bVAbY/0K9r5qKfvkXWs5EWsAScS+d8t1bSdk0DsRr+pVSabhe9xgj4c/pEK1
 nztxG8V4oGtrtQR3eMX0QTguTeigitRFhOqVb4fkxfor3SHU9ASfyaGvXfejFe3ZefdZ+PICYlx
 2QeT+4lHB4yRg/MtoMkMbEY9OsQXIYnOEWaTlgCaTfyA1OhMXkIS83J4qZFvQdfJ7hNc8n3TKNV
 0fz0XG9wWn4JA9oT4oQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070111
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jY/yOsvpc9aWjuEvUxwTi0KWtinXasaO3wK8pTemGEY=; b=XdR4O5xb7tobtL3Z
 w38JXbrqD/s5ZITebXeCQBNbWDhlxZFelzyFSR+mmHn+JQNctTe6yt7gmtIjH4ch
 wBYsPymzjHh1P+lw4UyxcfAv0lJWGI7r+7IRDsrJTbF8X2rz3dgly0+a4J/GlsZo
 V9cgcG7QwGzooIDmngRCgxEyD2ZkqHVwCD5De4/O4lsfrAxJa7q+ZreHCAHvEU2/
 LQNocv9NrrJB/+uKWW+hKB1ARfUULSi05u6d77XFGBk3rAcgCvURgPBOVR+CdyOk
 1UWcuP8GP/mNWQ2nKvEMIH37b8qTtivfD+ue0Ig9saO7rOQREGC+KdCjebYex3hN
 lNgjcQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786111897; x=1786716697; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jY/yOsvpc9aWjuEvUxwTi0KWtinXasaO3wK8pTemGEY=;
 b=WGdBWvpCh5s++7ZPTSd8ZB9tLJPNlpVsyhZTe5zqdicQAB5OOv8hakPvuSyQ9aC2tK
 nqr3WncvE480+m+qbJDClPngQsXBoYSTXs4g5eQL1PXs41uVVjix/Re6Eki535vUV2A3
 0uRUZ3Tlr3ojetLw2AzCzIQQ9q0CN/IWcg74edgA+gBgkbp/Bc4GHgbok3sHJ2aIYR8h
 DJXGbMgs/vl1wqjHvTlI2FOFSvmG23mPV+5QidrGTTKK2jq8HmKmo1uicp+RHQhNV3rN
 I3w0CeLl0cmfwYoo2ttVNF17caa1GjKcp45fOwsSZt8GOSgR0GV6EcPjzgi9olkshMZI
 nAwA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=XdR4O5xb; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WGdBWvpC
Subject: Re: [Intel-wired-lan] __free usage
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
From: Jeff Johnson via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 8/5/2026 4:56 AM, Przemek Kitszel wrote:
> On 8/5/26 00:56, Jeff Johnson via Intel-wired-lan wrote:
>> On 8/4/2026 3:54 PM, Jeff Johnson wrote:
>>> On 11/16/2025 7:56 AM, Ally Heev wrote:
>>>> usage of cleanup attributes is discouraged in net [1], achieve cleanup
>>>> using goto. In this patch though, only uninitialized pointers with __free
>>>> attribute are cleaned as they can cause undefined behavior when they
>>>> go out of scope
>>>>
>>>> Suggested-by: Simon Horman <horms@kernel.org>
>>>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>>>> Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
>>>> Signed-off-by: Ally Heev <allyheev@gmail.com>
>>>>
>>>> [1] https://docs.kernel.org/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs
>>>
>>> <SMH>
>>>
>>> If using __free() *correctly* gives more readable code, why wouldn't we do it?
>>>
>>> The only problem with this function is that it doesn't follow the guidance
>>> from cleanup.h:
>>>
>>>   * the recommendation is to always define and assign variables in one
>>>   * statement and not group variable definitions at the top of the
>>>   * function when __free() is used.
>> OMG, not sure why Thunderbird showed this as a recent unread e-mail.
>> Please ignore this noise!
> 
> always happy to see some __free() advocates :)
> 
> perhaps with our new meticulous friend Sashiko __free() would not be
> misused anymore, especially if we let them know the following quote:
> 
>  > So just make the rule be that __free() without an assignment is 
> simply > a bug.
>  >               Linus
> 
> and the resulting "less code" is always better (if only to fit more
> data into the AI context window)

There are unfortunately some uses of __free() that require a NULL assignment,
namely when the allocation is passed back via  a ** argument -- see
__free(firmware). But for all the rest it would be good to have the
consistency. Anything to help reduce often buggy cleanup gotos.

/jeff
