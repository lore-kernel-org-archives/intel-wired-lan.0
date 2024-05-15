Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB39CC25B75
	for <intel-wired-lan@archiver.kernel.org>; Wed, 15 May 2024 13:41:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80D6D81E9F;
	Wed, 15 May 2024 13:41:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mu1bKtkVSSk8; Wed, 15 May 2024 13:41:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 876A481E8C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1715780491;
	bh=dipip3cYoYCcSDrB3HQOGvfpZwDon85avyUbuqW95UE=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=JNlL6Et4euqAWquOYZ7u0nEtE4hiROXsEGvVtl6PtmvMuSpFQWVJh+ZMJ8vcWto2A
	 7pwx2vwGro6ORKF1qdjaZ1si+O+lIx76/hcsQF9Gc8ELqHP0dJSnoQrHmRExgWyiYB
	 juLCvOS+AS9IUIEW7CA7Esb8U2rdUcBq0ic8wX6EC6iBqXv0O9VulSpEihlHRFZdlU
	 cUgwTPe8e5XB8o4SJRYnYJQ0TjBuFWYYeKIFq/VRlIiFZZLkZW+mh4T+kJ0rww/vzb
	 UbU/YRW986rAp9WoqkgZcWBJWmFVPleNkw4AS5dJxWEZ/FNLPSEnkDN1+UeAE5/DPD
	 bLU1ulKIp5oKA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 876A481E8C;
	Wed, 15 May 2024 13:41:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id DA6FA1BF2C2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 May 2024 13:41:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C5D5A40B66
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 May 2024 13:41:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XNlbJZ6vP8dB for <intel-wired-lan@lists.osuosl.org>;
 Wed, 15 May 2024 13:41:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=thinhtr@linux.ibm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CC92B4052C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CC92B4052C
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CC92B4052C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 May 2024 13:41:28 +0000 (UTC)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44FBQGn0009700; Wed, 15 May 2024 13:41:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4uyg8br2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 May 2024 13:41:20 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44FDfJXW024910;
 Wed, 15 May 2024 13:41:19 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4uyg8bqy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 May 2024 13:41:19 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44FCHjP1006769; Wed, 15 May 2024 13:41:18 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2mgmksrq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 May 2024 13:41:18 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44FDfGPM24904366
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 May 2024 13:41:18 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0548658067;
 Wed, 15 May 2024 13:41:16 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B74CE58066;
 Wed, 15 May 2024 13:41:15 +0000 (GMT)
Received: from [9.41.99.196] (unknown [9.41.99.196])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 May 2024 13:41:15 +0000 (GMT)
Message-ID: <1f1a6485-a27a-46fc-bb57-d2600e93c95b@linux.ibm.com>
Date: Wed, 15 May 2024 08:41:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Paul Menzel <pmenzel@molgen.mpg.de>
References: <20240514202141.408-1-thinhtr@linux.ibm.com>
 <20240514202141.408-2-thinhtr@linux.ibm.com>
 <275f19df-f0c2-405c-9a99-7776a8565532@molgen.mpg.de>
From: Thinh Tran <thinhtr@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <275f19df-f0c2-405c-9a99-7776a8565532@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MQPm361PKxTKUgJaQDn1IXwAyPc-XHwl
X-Proofpoint-GUID: jVQmbZUjkwzz7UrEREEbd3jRRrFCPV7u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxlogscore=864 priorityscore=1501 mlxscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405150096
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=dipip3cYoYCcSDrB3HQOGvfpZwDon85avyUbuqW95UE=;
 b=E40GfiaITM3tnID64pWELCfwUfIV5efWnMEdOYV097cOn7w8xrfgFSlMb8ZOz4FLPPrN
 j7DgKeDFbsRT45KT/TnFgy86GNaJTnMtYtlZoDNnQ+tn3Ur2GtGaoKXCJkSKRugYEaxZ
 FXCKw8lztZeyeVZGiOAtMIdo0QdoO/QMevWUve7VQS6ngHMNrkTK+nnQz2msY44KcbbC
 r35cTWW2QjQu88mH2VDHxc+gtNP7rqLqjCN3YE+9WzOvUR1JPIuCoNw1HAjSyRUt2jHV
 MsIodVFNuXIN41b2KAC+H1iDHA/jXylsIleP+Em8nyO28OZGZuxAVACsrl1mLHihM/sP 6g== 
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.ibm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=E40GfiaI
Subject: Re: [Intel-wired-lan] [PATCH iwl-net V3,
 1/2] i40e: fractoring out i40e_suspend/i40e_resume
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
Cc: pabeni@redhat.com, netdev@vger.kernel.org, rob.thomas@ibm.com,
 aleksandr.loktionov@intel.com, edumazet@google.com, anthony.l.nguyen@intel.com,
 horms@kernel.org, przemyslaw.kitszel@intel.com, kuba@kernel.org,
 intel-wired-lan@lists.osuosl.org, davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>



On 5/15/2024 12:08 AM, Paul Menzel wrote:
> Please use imperative mood and fix a typo
I apologize for the oversight. Thank you for your feedback. I'll correct 
that.

Thinh Tran
