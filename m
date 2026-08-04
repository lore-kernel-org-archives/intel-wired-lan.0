Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF9BC55822
	for <intel-wired-lan@archiver.kernel.org>; Tue,  4 Aug 2026 22:55:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E84240533;
	Tue,  4 Aug 2026 22:55:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 87jhPsPaY4fe; Tue,  4 Aug 2026 22:55:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4193A40545
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785884102;
	bh=BiBfYk+ikLNkmDTePEHZK/NFlqks+onn7zyzt1bvM/M=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=YTdXpsSiEq/cGAUxduw8np/NsiylUQ/hVB0G5Win6ZPKnVTlENldbRoE/hWp0VJGt
	 ESz5p0UucZBIavA4mz8yVVSY6fJrtU2NduTr31UeB0LWo0cArJ3QkEwH3aupvwlOK2
	 f7Djlr5NR1kd2O7N0o9K9zYsNNhmHIw7IrWJFZJahe5rOB3A5yuEcHLxD/VLEEClu8
	 rUsmDM5LK2Fqbl4IGH5q49iK1RlIrgK5K3K4lin+L8giP5Asdhpn2aeFQ+fZ63C7HA
	 gAiTTGcrzDM9JUgh8Pptc0PiaBu8ne2T3GvwndsXnODu51BjD0tNSIstnGKxwbgcra
	 QsODE48o2K7GQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4193A40545;
	Tue,  4 Aug 2026 22:55:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8874B2BF
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 22:55:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7A6D5605DA
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 22:55:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CB0mP6Rh68ng for <intel-wired-lan@lists.osuosl.org>;
 Tue,  4 Aug 2026 22:55:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=jeff.johnson@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 82986605AF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 82986605AF
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 82986605AF
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 22:55:00 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 674Jlktk428808
 for <intel-wired-lan@lists.osuosl.org>; Tue, 4 Aug 2026 22:54:59 GMT
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fugmgjpb9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <intel-wired-lan@lists.osuosl.org>; Tue, 04 Aug 2026 22:54:59 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb733fc5024so357378a12.2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 04 Aug 2026 15:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785884099; x=1786488899;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BiBfYk+ikLNkmDTePEHZK/NFlqks+onn7zyzt1bvM/M=;
 b=tPxxeUfWXPN0KBfRbqMctiM7EzmjeJYRv/BpiSef9u/PpRkEmVCPyYNylVF7ooYLjC
 jKa6yDuCTM9b/ltIiJCqr21jWAZXSdh7M+sioNouR6owx5Rc3FLKFPfiWClbh9giLLyF
 YwLoqoqou3/J98D7BmuMVqIi7X/0zgVxeS9xDyZEEtcK9ZSRNh1sWgAYgA9Alfz0vM9Z
 Bs+649Sgxzwri9KKw8qpWSh17Cs5Ws/bV8dU5FlM21xijU/cjpNQ6YiQ1ULRmEX8c3ZE
 sPMtJEGaesvev8hQGiSob3YrFeg2ms3AN4nScxLEawpwOEmdn7ljkJRihsa15Tn7x7is
 eu/Q==
X-Gm-Message-State: AOJu0YwgiJhlgBdaFaHuSojrtOXwiS7G6wD3VLcHGdgul1p/V/+1rSVu
 yYsJgPFQbe7oGTILP5vC2liVJ4500OzBGkpyFdO1lOSNDFVLbkOpkmMcZfb8VtYubEeBAipg740
 wpISgtwwhEUAJCYbWUz/odfnpny/BEmBy9NRfQJxN29bPdYex62y1b2XCtwe0kWoNJbXjoKJo
X-Gm-Gg: AR+sD12N2THwBJznTTVMSPE/DtDDwOLgSR/3vTWThtdd8YhFg9VQBjO9u35BPwy/hjM
 upABoIUhoXIEsPd4YDDnOH5A/Ewtv4Zw8132pkdAQCRoLH5UsuGUa9dns+Qxua/nA0KLJlTc0A2
 p1suEsg9v1Xb/DcnGHztc7FNFal8lam0s+N050lDI6tqWY8uY95RYn9nmOHWV0fzz/z4U7z9l77
 58vPz3pF//h/bugYFVpOEwZr3/c/ZNSP5RRVKordNlldcfXmnHM7x/783cZj8v2opyxkOskRsyp
 OM8xZ8L7phrMYRMIjtiLMhnGRVMBgAkV0JDrlu3XHsgUnNCg2l9NDnBWEE8FY5Y8OKT1THMpwmR
 Ib0SG7NbCCdVbh9EzVkuM1ocfr7VdCBhYNjnePZFszm0/HuMkEyUeX554riwl
X-Received: by 2002:a05:6a20:4321:b0:3c3:b57b:6291 with SMTP id
 adf61e73a8af0-3cb85e6689fmr2180334637.18.1785884098711; 
 Tue, 04 Aug 2026 15:54:58 -0700 (PDT)
X-Received: by 2002:a05:6a20:4321:b0:3c3:b57b:6291 with SMTP id
 adf61e73a8af0-3cb85e6689fmr2180295637.18.1785884098318; 
 Tue, 04 Aug 2026 15:54:58 -0700 (PDT)
Received: from [192.168.1.20] (103.sub-97-215-187.myvzw.com. [97.215.187.103])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158673a9e4sm10073999eec.18.2026.08.04.15.54.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2026 15:54:57 -0700 (PDT)
Message-ID: <72754805-575c-4568-9dab-514e1b758847@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 15:54:55 -0700
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
Content-Language: en-US
In-Reply-To: <20251116-aheev-fix-free-uninitialized-ptrs-ethernet-intel-v1-2-0ddc81be6a4c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE4NiBTYWx0ZWRfX72EhQzj6XFpk
 KLeUnmKgd9uhzJR009F+O/Uklq+ahLRLCSByP///LJDYk5bd6fYcoqjiuY8CR98fplkdIW/EFVc
 WSireanUjZEXMf8Loc42BHe3eA4wmolYGDV/Tsa47oEgcemK4A4FH4mL4N1fKUqsCaORybKLmf+
 GcLAe1w5FbL/wCt9DEeTV+yo8skk+pK7xfJIQ+Fx+QYoDIEJx4s5i4T7pQf9a5GVxn/msxWqzd1
 /ByOLDUfdqF3f944T0JtarVQu34Ze/GOvqD+Xd3y40rY3SdwrqeuxWJDB6KvqeU9r0rahMjxDCT
 gP0EHVxAPVYUQ1qwZqIvVTSI6Dkm0Taie6dNN0pa0WpVEP/ZPUvbE+A1khJsINKK6IYeXOBrsSD
 9ubSMHrSxyu0VRq97FxPQ09qA0ad1a6ixbWGh/yF27qR1gOArwbl4tYJycjKpeTk5jS1+WgtClc
 zq/uqJAHX9L8ii3KHSQ==
X-Proofpoint-GUID: gEq8KEHZoUaP2eou_HaDJSKtm0sPNQ5q
X-Proofpoint-ORIG-GUID: gEq8KEHZoUaP2eou_HaDJSKtm0sPNQ5q
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE4NiBTYWx0ZWRfXyS8LYpi5FxZp
 KQLQ5awJdrEqQfquW05H46HsS3tt6AOqpl1jeymQtAeI+iXBJgmeRK40wwX7MmoULftA9Ang1ym
 4ZlZRJVxuOvC9QWZoYzFhuhlby3EITc=
X-Authority-Analysis: v=2.4 cv=XYC5Co55 c=1 sm=1 tr=0 ts=6a726dc3 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=UaEkX0D7FlC0tWE/LoNF7Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=SN6AwQ4lagRrp0K9xQIA:9
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1011 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040186
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BiBfYk+ikLNkmDTePEHZK/NFlqks+onn7zyzt1bvM/M=; b=J6pCMjA/9UJDNJRo
 VZQTZztpJ6ly5GLfzHWJxCBb2QiXV14QgaZyienmOvFWr3RmOlaLgTzVrtLXsuu+
 zUvdKwTlu/o2Dhgcr4m0xvb9xevP0yqMOxiNs8wo9EFPmgrLDsOcXBUp5fMUb0lC
 2+0LxVsJOf/tMc1H1ztMiXW+I1uAvjrhz7KnYTFDc+jcPQoZoh/dldD6E7bod7Lx
 guG1dghAELXaWSnBpNcX6vNLp859XRoAC8anGPfbj46Yq7XnLAkvtax6NS8EUUYa
 iiBRqbbMaX08jHqmI5JWxGgUiGzUT5KlIKFSTRsZp+uycJqzIGBpIZLYAMoLwJIs
 fKdxgA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785884099; x=1786488899; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BiBfYk+ikLNkmDTePEHZK/NFlqks+onn7zyzt1bvM/M=;
 b=dlBqGCDljGckPcOWjgwa8CQTfCyXypquHSuqHz9yEBvnEIH41pU8K/3Fm/P4zi6Y9Y
 Cjo2FNf0H5qkBxel1Hdr15i7pZ2RYY2gj5Pd99N8MR+sHkNdx6VeFkPqthnqUo4jQey5
 p5HAaft0UPLO0ePphNUzLd84/SX8gvovOAewKP1QG7Fbql2f5UbygyF54DJ02dj2c/vP
 91+sF0mfF+FlznFmHwwXGmwplwqoofTRKP9aV5utXrXsJk8NJQrD7xddlGaaEMV+w2gz
 3lJhi3BhfbO6Ah4itgjYqNDT7vwvbVnZ+NtLgqVF2vYJTJ7dFsGimeoqrq3Tk4+UX+Yu
 y0GA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=J6pCMjA/; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dlBqGCDl
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

On 11/16/2025 7:56 AM, Ally Heev wrote:
> usage of cleanup attributes is discouraged in net [1], achieve cleanup
> using goto. In this patch though, only uninitialized pointers with __free
> attribute are cleaned as they can cause undefined behavior when they
> go out of scope
> 
> Suggested-by: Simon Horman <horms@kernel.org>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
> Signed-off-by: Ally Heev <allyheev@gmail.com>
> 
> [1] https://docs.kernel.org/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

<SMH>

If using __free() *correctly* gives more readable code, why wouldn't we do it?

The only problem with this function is that it doesn't follow the guidance
from cleanup.h:

 * the recommendation is to always define and assign variables in one
 * statement and not group variable definitions at the top of the
 * function when __free() is used.


> 
> Signed-off-by: Ally Heev <allyheev@gmail.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 28 +++++++++++++++++--------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index cbb5fa30f5a0ec778c1ee30470da3ca21cc1af24..5b2bf8c3205bc1ea0746f78afa2a24f3f8ad2a8c 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -1012,7 +1012,7 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
>   */
>  static int idpf_send_get_lan_memory_regions(struct idpf_adapter *adapter)
>  {
> -	struct virtchnl2_get_lan_memory_regions *rcvd_regions __free(kfree);
> +	struct virtchnl2_get_lan_memory_regions *rcvd_regions = NULL;
>  	struct idpf_vc_xn_params xn_params = {
>  		.vc_op = VIRTCHNL2_OP_GET_LAN_MEMORY_REGIONS,
>  		.recv_buf.iov_len = IDPF_CTLQ_MAX_BUF_LEN,
> @@ -1029,21 +1029,29 @@ static int idpf_send_get_lan_memory_regions(struct idpf_adapter *adapter)
>  
>  	xn_params.recv_buf.iov_base = rcvd_regions;
>  	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
> -	if (reply_sz < 0)
> -		return reply_sz;
> +	if (reply_sz < 0) {
> +		err = reply_sz;
> +		goto out;
> +	}
>  
>  	num_regions = le16_to_cpu(rcvd_regions->num_memory_regions);
>  	size = struct_size(rcvd_regions, mem_reg, num_regions);
> -	if (reply_sz < size)
> -		return -EIO;
> +	if (reply_sz < size) {
> +		err = -EIO;
> +		goto out;
> +	}
>  
> -	if (size > IDPF_CTLQ_MAX_BUF_LEN)
> -		return -EINVAL;
> +	if (size > IDPF_CTLQ_MAX_BUF_LEN) {
> +		err = -EINVAL;
> +		goto out;
> +	}
>  
>  	hw = &adapter->hw;
>  	hw->lan_regs = kcalloc(num_regions, sizeof(*hw->lan_regs), GFP_KERNEL);
> -	if (!hw->lan_regs)
> -		return -ENOMEM;
> +	if (!hw->lan_regs) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
>  
>  	for (int i = 0; i < num_regions; i++) {
>  		hw->lan_regs[i].addr_len =
> @@ -1053,6 +1061,8 @@ static int idpf_send_get_lan_memory_regions(struct idpf_adapter *adapter)
>  	}
>  	hw->num_lan_regs = num_regions;
>  
> +out:
> +	kfree(rcvd_regions);
>  	return err;
>  }
>  
> 

