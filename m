Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB06AC48BF6
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Feb 2024 00:07:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13D744055A;
	Tue, 27 Feb 2024 00:07:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3zL26GKW3oHL; Tue, 27 Feb 2024 00:07:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6C3AC40524
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1708992460;
	bh=7EiwRdm/V3a7kLEUdExazAqNGWLSc4lYEtu/GG4qUJ0=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=M6FVF5aaSPYaHOQLI7kCAO3FSxJ4wQmn8q8vo9gVRVYCvM3s6MBSBo87BK34agniM
	 cMcw9nL/47J7M6MPG3xfCx4PRGo/8anHqqYtsR/bjQ5DS86t/CJLlwBTHJgyABQEcN
	 tTLz6mR1JIcR1sFbKRF4R8pmds347KxKxvmLdWHE2qLOGSJ6iRQ6Cmk2OdlG6FQDXv
	 DepmOCSiDCTb1e4PrgeBz9un7nOEuy93GFu+zstIlnPXhZvT9a4Z+UPkHeP/DHio33
	 wn+ImqimRDcFgUnj4/B8+CEreh43OUyPClmM2ucD+b6mwjTLGxHLEbTHsRIE0EDr7V
	 1vx0mGJFkqvNg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C3AC40524;
	Tue, 27 Feb 2024 00:07:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 1851B1BF3E9
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Feb 2024 17:14:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 03FEC81F34
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Feb 2024 17:14:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vw9PlwZVhYlH for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Feb 2024 17:14:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=oberpar@linux.ibm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D8D1681F32
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D8D1681F32
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D8D1681F32
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Feb 2024 17:14:28 +0000 (UTC)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41QGwR0e032270; Mon, 26 Feb 2024 17:14:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wgxmm8fmc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Feb 2024 17:14:19 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41QGx2Rw001319;
 Mon, 26 Feb 2024 17:14:18 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wgxmm8fkh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Feb 2024 17:14:18 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41QGTLLA021808; Mon, 26 Feb 2024 17:14:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfu5ytquv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Feb 2024 17:14:17 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41QHEDNQ9372320
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Feb 2024 17:14:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2CBAF2004D;
 Mon, 26 Feb 2024 17:14:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E8E6520049;
 Mon, 26 Feb 2024 17:14:11 +0000 (GMT)
Received: from [9.171.4.124] (unknown [9.171.4.124])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 26 Feb 2024 17:14:11 +0000 (GMT)
Message-ID: <3aae1410-e30f-4cd5-8c6c-3f1c6362ffee@linux.ibm.com>
Date: Mon, 26 Feb 2024 18:13:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
 <20240201122216.2634007-9-aleksander.lobakin@intel.com>
From: Peter Oberparleiter <oberpar@linux.ibm.com>
In-Reply-To: <20240201122216.2634007-9-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kJ2xFVSXDENYmSmRhicxbmrwDujXC5lV
X-Proofpoint-GUID: yP0KC4JJEtYmY4bzsPQdnvQdAB2lXb3v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011
 suspectscore=0 lowpriorityscore=0 mlxlogscore=961 adultscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402260131
X-Mailman-Approved-At: Tue, 27 Feb 2024 00:07:38 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7EiwRdm/V3a7kLEUdExazAqNGWLSc4lYEtu/GG4qUJ0=;
 b=MbvrA4liD26UBVHzakTuYr0t60g3p3lFTN8BkLwRvT6ziymLUJgzI6fpxn7PD76+wLYs
 42zVAplEkClN8YKbxIWO9I2ImjJjU4TN7EXFs0W8o9bFwHYEjAsXqrRnK56xb2nTGaOA
 KN3ipTfcuAl3/MK4gfpgW5P2zURHSb7LIcZTsQ7kHewvZt3jUZIh+vONFX0QylQg+Sal
 kcJrpGJPFncGuJ9dvdCzwds4jJzgBqbVCbgHsGcZ5M/rWOJ3S+GLU4SKAk+bJbLuiYrd
 AzmfWdwoYduR6JzUZNwRCfPZE9ijUt5hd4bPVU5Q3QrWcl3TazbX+OlvqHPIuAmdpgZH aQ== 
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.ibm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com
 header.a=rsa-sha256 header.s=pp1 header.b=MbvrA4li
Subject: Re: [Intel-wired-lan] [PATCH net-next v5 08/21] s390/cio: rename
 bitmap_size() -> idset_bitmap_size()
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
Cc: Andy Shevchenko <andy@kernel.org>, linux-s390@vger.kernel.org,
 Wojciech Drewek <wojciech.drewek@intel.com>, Yury Norov <yury.norov@gmail.com>,
 Ido Schimmel <idosch@nvidia.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 linux-kernel@vger.kernel.org, dm-devel@redhat.com,
 Marcin Szycik <marcin.szycik@linux.intel.com>,
 Alexander Potapenko <glider@google.com>, Simon Horman <horms@kernel.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 netdev@vger.kernel.org, ntfs3@lists.linux.dev, Jiri Pirko <jiri@resnulli.us>,
 linux-btrfs@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 01.02.2024 13:22, Alexander Lobakin wrote:
> bitmap_size() is a pretty generic name and one may want to use it for
> a generic bitmap API function. At the same time, its logic is not
> "generic", i.e. it's not just `nbits -> size of bitmap in bytes`
> converter as it would be expected from its name.
> Add the prefix 'idset_' used throughout the file where the function
> resides.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Apologies for the delay.

Acked-by: Peter Oberparleiter <oberpar@linux.ibm.com>


-- 
Peter Oberparleiter
Linux on IBM Z Development - IBM Germany R&D

