Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B270C55822
	for <intel-wired-lan@archiver.kernel.org>; Tue,  4 Aug 2026 22:57:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A5E5605EC;
	Tue,  4 Aug 2026 22:57:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EE_pHY_H4cl9; Tue,  4 Aug 2026 22:57:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BFF43605DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785884224;
	bh=Ze+t3K72EfpnZ5n3KGC63Upnzdy1PBzuoQci45pXTyg=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=EK+KauuHd3e1+OafpZ3QO311ravgAUMWSGdQG3cK9GCZopKzCUeeJb/1Sfjo5IKws
	 w8KGJ6EZRvE6+G4JqLNl5jwGP2Tzk3Mm7+w79e4WFv6FsTHq+ArxYr2UM+U7E+Duhg
	 GIwqTS+p9ceMoMCfK7Bo1zmSi+RO6NGcG3vTZgjSn88lSXIfWGJg0gTlGc2+cEfrya
	 aWQr34GluqwIj+uleKSxg3LTgfEGHMJdeYx8Ye2PkNiWQsLn/S4Ncrl4vdPPtWdV4G
	 tZKwHJtKZyPd7ILJN1/UmU4eY4CAWI3C6bgB9X907KpSroumneII4DjZ+9pCREHGOP
	 FGMBrNrVDRvRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BFF43605DA;
	Tue,  4 Aug 2026 22:57:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E8239144
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 22:57:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CDC1340086
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 22:57:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vz7kgca9_p2g for <intel-wired-lan@lists.osuosl.org>;
 Tue,  4 Aug 2026 22:57:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=jeff.johnson@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CCCD340056
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CCCD340056
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CCCD340056
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 22:57:02 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 674JlkUC428892
 for <intel-wired-lan@lists.osuosl.org>; Tue, 4 Aug 2026 22:57:02 GMT
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fugmgjpp7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <intel-wired-lan@lists.osuosl.org>; Tue, 04 Aug 2026 22:57:01 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38827cee19eso420461a91.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 04 Aug 2026 15:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785884221; x=1786489021;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ze+t3K72EfpnZ5n3KGC63Upnzdy1PBzuoQci45pXTyg=;
 b=BJLcagWX8c+epvRkIGlGOk2kA6Fmr0tRf9W8PvqQlh1nsBBd+TvuQxdW7zHfCGrAbI
 uPp8qExjQBkHnR/2uFEeVZKs/PnfeYPGNt1HIimDTtOxGppq/MKmBVW2fHe3+01naLUU
 qdioZLAePBf3V6hb9T4zjbcDnz2zzd4cHZZZ5nOEwTSROJiKRngHCQIjr5lm2dz+Bhhy
 qa6l9tsA9xlDYeuFnvduu6o3aCZAPcO98CF5aEN/6f9GhtUFVjLF7wj1thRkHLdQoxek
 gxAcc4zD5GI0mfsKdTxhlWUspVbgGpE+B86IDyu+I8x5x+gMt3kkna+eEheg/5SceVa0
 5eiw==
X-Gm-Message-State: AOJu0YymPCQaMswl9YkFS+/2lZRsE12kk9uRoEBnxtLi+bs/LaVfsgYQ
 37LphOKSL2m96EFLnt54hYqiziSkiPEbTSLlnU8NA/4oysPYGWQI1ivqkpeSt4Ifpe8mi/ZW7RN
 qKhfa7+8mEuE0oMZyoKFco4t46y7hlMrf6LEZGZ8WqmizVZfH2fpp2VSbU5/ku/JeHu9RC46H
X-Gm-Gg: AR+sD10qrteddWql9ywzvR/F4jxHjeIDfhTxaP0n0f+PRxMnhsXUj89uDLPIi46y2Xw
 KsfIlCo+k4a0hzDC8G9QaEs3v/crPFdEqkUygB6/S2cx230PuhqcOk0G6zj+lRJLZISphuu/sFv
 5VyMT4H8IA6/viLUJOzc3YWONCDw/D9LjfJ3K0+Db82rk4ukOyP9AXlU4eLZZkCZrulf3G1KJi5
 IHbA6sbaM5W8RabSarfHj4VwhdORsM/BSpLqAoqAPA+olJxN+Uv745qCAlsjxZKErcOikP34Ec2
 FWgI9xHRphx+FK7jfaV1EVnqzj6YwgTs4Iib5MafIwN1alNP20nQwtuV8vHeYi5X6qjMEsr9Sno
 YOIFFfpkSi0AwEvLTU4m71bTeKH8agnwrs5IBDHx6Mati9com6wdNPsJwlKt6
X-Received: by 2002:a17:90b:5683:b0:38e:6aa7:68ad with SMTP id
 98e67ed59e1d1-3903c54fbc4mr2149348a91.5.1785884221147; 
 Tue, 04 Aug 2026 15:57:01 -0700 (PDT)
X-Received: by 2002:a17:90b:5683:b0:38e:6aa7:68ad with SMTP id
 98e67ed59e1d1-3903c54fbc4mr2149303a91.5.1785884220637; 
 Tue, 04 Aug 2026 15:57:00 -0700 (PDT)
Received: from [192.168.1.20] (103.sub-97-215-187.myvzw.com. [97.215.187.103])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31586447d52sm8118099eec.12.2026.08.04.15.56.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2026 15:56:59 -0700 (PDT)
Message-ID: <ae840989-03df-4e84-a9cc-46c51f6dd44e@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 15:56:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ally Heev <allyheev@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20251116-aheev-fix-free-uninitialized-ptrs-ethernet-intel-v1-0-0ddc81be6a4c@gmail.com>
 <20251116-aheev-fix-free-uninitialized-ptrs-ethernet-intel-v1-2-0ddc81be6a4c@gmail.com>
 <72754805-575c-4568-9dab-514e1b758847@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <72754805-575c-4568-9dab-514e1b758847@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE4NyBTYWx0ZWRfXwW71y5KDaYgn
 MXLL4mAKM6OcHBSb3RQV8tlAFnG8Wyt1dxJY1CHIy2vj18l/mN0T7flmMhz/p4ddcO1VG5Y5d7h
 3MVOJ96ERsXsvT7g5e6w0ATYwaspaHEhEs4xEHFNLy5LYN2kXBUuJKSa7QGMt3qaHR2tH2B4f6b
 NuIaxkri7kOX/UzAyEhXVNO4/OpALPV6EcU1j48exrJXL6gjUuCWFlb06TlBdUtggE5v7UQBU3h
 DD+AZn85p+V4gG4Nft4vIgGwsY1c0UEdUXEuDjtotbMDfjsX33r0gHA94HUDr0iK5VyPqdNz9O1
 oXJZ/23JNrAOFJFCwOg7Vx+w8tQwMwJmFujtObg1zvN8rPI2Mnox0AxTwur86xgWX2G4u31CRJz
 /RG9Ldi7JpeeDLSsY6goTEp0OP8a38NiWZR1r5ODaovfJpdRmxbbFSucFtn/HL8jM89gI8/MVwp
 4BgvfEmskq3YW5YuCCQ==
X-Proofpoint-GUID: lP1tBhvxOR_5dN5tO1SiJfGBbgddER4r
X-Proofpoint-ORIG-GUID: lP1tBhvxOR_5dN5tO1SiJfGBbgddER4r
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE4NyBTYWx0ZWRfXyUcw4PFmwfXE
 cUmFC9JWiO6GN/YqapvQ+ShabtV8g7TVgjy44ARi9S1Hv0q3VSDV9HrpObdJxceoZinFp0t28j9
 8hSzC6ToPg4yriLZvG9sbo+G9EdiY+M=
X-Authority-Analysis: v=2.4 cv=XYC5Co55 c=1 sm=1 tr=0 ts=6a726e3d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=UaEkX0D7FlC0tWE/LoNF7Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=sb2gSEF-3ozDpBDae7EA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040187
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ze+t3K72EfpnZ5n3KGC63Upnzdy1PBzuoQci45pXTyg=; b=XwMaLr3fU6uwVKYY
 bkJcQUcNI0/QzsFDSOk9Z5aac5JiEOt2YP5ultnN+dmbKRez5r0GKzC4dMz04LRv
 cZsnKb+ghYEPiAkx3+KB3yuWMeIBxySK1kdCLmeJ5ahpERknKHCtL/MmwcYYVzfw
 1r6aOnUEtlg2iPdlvgrJ7RptbXg97JBEI0nqr3eH2tkYpPGe1VhifTnXjsEY1eXH
 v2tq6o9+s8gBQt+7UISsbzKh0Fqj0HsJDppG7s9lo8iwcJsLMk3J/0/t/W0ZAFhs
 T4flNGIO5LsqswYJwmx46pD53bPwFR/7VoPNOH8OPtTbn1d5s7dvAV9Jmb+DOtnH
 V9yEQQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785884221; x=1786489021; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ze+t3K72EfpnZ5n3KGC63Upnzdy1PBzuoQci45pXTyg=;
 b=PbFTZAKBFA7jepZYzKRnklpHxljlfoXeBbmFrJzoVFUfZlHIXMz8zcO5FoWZCjWqzf
 Tr36dkM9aLQ4KlNVf7mVbulSxWfofYqf6ZR999MUdjzTtuB1ivZ3nHWZiaoX2/81jGfe
 RDve0hzAljOkuBKec1NDWTjHCd6xpAtzd0EdNXi2XiP1WOh8XwmjG78vnKPyFB4jLBMH
 VPwwHuMHyUvjpXXzswXuB9skv2R84GnMWtmU4GhMS8G5buOHQSoWyitKQmvNVOFlH1nY
 0j5iFWIpcKf5ixqsp0J4Rf+xnAcfKMyEFd0S2JUje1byU47foiQNjiSv/BsYMiUykwMd
 obog==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=XwMaLr3f; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PbFTZAKB
Subject: Re: [Intel-wired-lan] [PATCH RFT net-next 2/2] idpf: remove __free
 usage in idpf_virtchnl
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

On 8/4/2026 3:54 PM, Jeff Johnson wrote:
> On 11/16/2025 7:56 AM, Ally Heev wrote:
>> usage of cleanup attributes is discouraged in net [1], achieve cleanup
>> using goto. In this patch though, only uninitialized pointers with __free
>> attribute are cleaned as they can cause undefined behavior when they
>> go out of scope
>>
>> Suggested-by: Simon Horman <horms@kernel.org>
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
>> Signed-off-by: Ally Heev <allyheev@gmail.com>
>>
>> [1] https://docs.kernel.org/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs
> 
> <SMH>
> 
> If using __free() *correctly* gives more readable code, why wouldn't we do it?
> 
> The only problem with this function is that it doesn't follow the guidance
> from cleanup.h:
> 
>  * the recommendation is to always define and assign variables in one
>  * statement and not group variable definitions at the top of the
>  * function when __free() is used.
OMG, not sure why Thunderbird showed this as a recent unread e-mail.
Please ignore this noise!
