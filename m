Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE2C3CEACEF
	for <intel-wired-lan@archiver.kernel.org>; Mon, 17 Nov 2025 08:34:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6388F409C2;
	Mon, 17 Nov 2025 08:34:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xGUgfqFnoH87; Mon, 17 Nov 2025 08:34:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E35654092E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1763368471;
	bh=wVphD/cmNHf00MDeK91l/D3e0GlVxBG1SOHreyErtGY=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=W89470sPQ2BvGVZ26yZhP6Uuq+LK5RyDVXsef0g7k8xpUtGDq2rwADCWNEGBHbnI6
	 I/x4N8brwUW6D8+HYl5zX4HdQ3lHUdSTYYPR3vfARo63eBxPTX2ZI6N0nR8RP1RmWO
	 ScLXW+IZ7O9OlMZtedoP7qPbPyEVGgiz8o/Su+wPsZab9c/bwBXJO8jnzxj3XH9pHJ
	 yudhS5eE8QV7TGarul9Hzn5QfmoLkTvzuEouNjNjY0ctnaKVt9lFS4iu+90Wi1BnFO
	 7u80/O4YB7PxYjBZA6busXneI0WLIySLTG9G4L521Whbvnad+KhXoXaimDtj9x3M2z
	 yazt5Ga4yysuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E35654092E;
	Mon, 17 Nov 2025 08:34:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A373158
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Nov 2025 08:34:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 20E9140424
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Nov 2025 08:34:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nNR-n7kGStdu for <intel-wired-lan@lists.osuosl.org>;
 Mon, 17 Nov 2025 08:34:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32;
 helo=mx0b-00069f02.pphosted.com; envelope-from=gregory.herrero@oracle.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E6BBE401F3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E6BBE401F3
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E6BBE401F3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Nov 2025 08:34:27 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AH1ukml001111;
 Mon, 17 Nov 2025 08:34:18 GMT
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbbt05v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Nov 2025 08:34:18 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5AH6YxOA009433; Mon, 17 Nov 2025 08:34:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4aefybd1ft-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Nov 2025 08:34:18 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AH8YHL6013986;
 Mon, 17 Nov 2025 08:34:17 GMT
Received: from oracle.home (dhcp-10-154-174-115.vpn.oracle.com
 [10.154.174.115])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4aefybd10b-1; Mon, 17 Nov 2025 08:34:16 +0000
From: gregory.herrero@oracle.com
To: aleksandr.loktionov@intel.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gregory Herrero <gregory.herrero@oracle.com>
Date: Mon, 17 Nov 2025 09:33:25 +0100
Message-ID: <20251117083326.2784380-1-gregory.herrero@oracle.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511170071
X-Proofpoint-GUID: sODMXa1mfjdF2HpJ-j8hOjT0zaywTDha
X-Authority-Analysis: v=2.4 cv=JZyxbEKV c=1 sm=1 tr=0 ts=691ade0a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=nkxlBBN6Bl8rD0aY9rEA:9 cc=ntf awl=host:13643
X-Proofpoint-ORIG-GUID: sODMXa1mfjdF2HpJ-j8hOjT0zaywTDha
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX0ceAsaqYVjsR
 5Bdh4e2hacXn685B6h/mHvmQpwdCIzM60mohjgjP/rICa/2oeaGYQwTG+Syv748uF/lOMIeweg1
 R95ft2LnxUGwoS87bnUd7yw02IFPRc7IGmRXYi55hpLxefWbIfQX1ikvv+aCHojynpxKjF8wiHG
 pJyI29xWjnyp1SnfW7HctLRXvxUlLez/S0ofNXDpvOBLbnY07qA6sbui7+ovYc4Ga098KClM/z7
 Pj8FL0N7WDHArTVHxeLBRSYFEfuUmc1D4lwg1b14i+VEd1MK8x7o3R9ktqQpUTvnGb1BOfPLBN0
 XvPV5GeBTuGx4djvY9Qbu5PMpUwMeL8mPOi77XCWkn3hFNY7SW83fFBAqgECcvR5OjV1OTpI+5w
 muuTHtX1JKPVhTwZ/gRcm00wIWDyBf6zplWO3gqIbBNVHpgFqqM=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=wVphD/cmNHf00MDeK91l/D3e0GlVx
 BG1SOHreyErtGY=; b=NvNviUbYNtRdTkFeWhyWQ2b/aLO3cSA2j4kDjrVmkHocQ
 G0NCzdzsBFB76riqu9PnTDUxfEKKOfMeF810frm8yZmFIGS18Aped7r2zaxZjIAZ
 +ZDSzFgBRKAwMtSujLmx/jat1XEbfnZ8nzppbaIZRBZTjeER9x8tloqa4idU2taD
 c1aAR7EspL+Fh4dhVPGFf9/yrTnNFVlZVXncJRyI+6myLlreAAvCF4/M84VtLYGH
 EPcKiUDUzS+YOMkPwqGoQuYZBXPlraGZLuQh2Liaqkwgtny6L37XidYTS/CPW9JK
 0UQovz+PBTIZwvK6wTPrZQvI/zxQ9z8whHd4mXd5A==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=oracle.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256
 header.s=corp-2025-04-25 header.b=NvNviUbY
Subject: [Intel-wired-lan] [PATCH v4 0/1] i40e: additional safety check
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Gregory Herrero <gregory.herrero@oracle.com>

On code inspection, I realized we may want to check ring_len parameter
against hardware specific values in i40e_config_vsi_tx_queue() and
i40e_config_vsi_rx_queue().

v4:
- remove u32 cast in i40e_config_vsi_tx_queue() too and don't mention it
  anymore in commit description.
- wrap i40e_get_max_num_descriptors() description
v3:
- drop trailing period from the subject
- reword commit description
- remove u32 cast in i40e_config_vsi_rx_queue()
v2:
- make i40e_get_max_num_descriptors() 'pf' argument const.
- reword i40e_get_max_num_descriptors() description.
- modify commit description to explain potential behavior change.

Gregory Herrero (1):
  i40e: validate ring_len parameter against hardware-specific values

 drivers/net/ethernet/intel/i40e/i40e.h         | 18 ++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 12 ------------
 .../net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  4 ++--
 3 files changed, 20 insertions(+), 14 deletions(-)

-- 
2.51.0

