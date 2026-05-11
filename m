Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 662DECD484D
	for <intel-wired-lan@archiver.kernel.org>; Mon, 11 May 2026 17:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36FED80D99;
	Mon, 11 May 2026 17:33:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZLchxP19hnFm; Mon, 11 May 2026 17:33:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9EAB280D9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778520801;
	bh=l6gfg54IftcEb6QLIMve9bgrhXIY6NVvWV2lujfC7xo=;
	h=Date:From:To:CC:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kq6zK1eEgnHZp9OBpUDs/TWeOotGx58mr2mjaH8XOnZnekneasX0t91uwGF33MPxd
	 iMdPnIDTszPGjx9b/nFPVaGK2urvQn5klBu9q78CLKUj7+ayb1xgjN5MAu2rurxjHO
	 JjMTFsIpbmCeGLZNL0zeZXuaMrV3oTb5Ew4v3YEA2AqKUvyN71H1TSgHvfQ2VM/dqO
	 RzQAys5wWe7diU2h5nJplZBDP8uVMEO0UjsmJC5fD8+hFSQsuHFs3ULynBxAfDxaoF
	 kYit5xsxfZ5tOaX+YzZ43m3ORoik77izQGZ1OX0YAP1xwRTvLeNYl7DHb8AHkMDHVd
	 6sA1PzLYDcpQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9EAB280D9C;
	Mon, 11 May 2026 17:33:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 86DFC272
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 May 2026 03:23:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 842B9402D1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 May 2026 03:23:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 20Js17mtukum for <intel-wired-lan@lists.osuosl.org>;
 Mon, 11 May 2026 03:23:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=67.231.156.173;
 helo=mx0b-0016f401.pphosted.com;
 envelope-from=prvs=6591f29198=rkannoth@marvell.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org AF47B40087
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AF47B40087
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AF47B40087
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 May 2026 03:23:53 +0000 (UTC)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B0uvZ02153582; Sun, 10 May 2026 20:23:33 -0700
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e34kn87rb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 10 May 2026 20:23:33 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 10 May 2026 20:23:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 10 May 2026 20:23:32 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
 by maili.marvell.com (Postfix) with SMTP id DF55A3F708D;
 Sun, 10 May 2026 20:23:23 -0700 (PDT)
Date: Mon, 11 May 2026 08:53:22 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
 <oss-drivers@corigine.com>
CC: <akiyano@amazon.com>, <andrew+netdev@lunn.ch>,
 <anthony.l.nguyen@intel.com>, <arkadiusz.kubalewski@intel.com>,
 <brett.creeley@amd.com>, <darinzon@amazon.com>, <davem@davemloft.net>,
 <donald.hunter@gmail.com>, <edumazet@google.com>, <horms@kernel.org>,
 <idosch@nvidia.com>, <ivecera@redhat.com>, <jiri@resnulli.us>,
 <kuba@kernel.org>, <leon@kernel.org>, <mbloch@nvidia.com>,
 <michael.chan@broadcom.com>, <pabeni@redhat.com>,
 <pavan.chebbi@broadcom.com>, <petrm@nvidia.com>,
 <Prathosh.Satish@microchip.com>, <przemyslaw.kitszel@intel.com>,
 <saeedm@nvidia.com>, <sgoutham@marvell.com>, <tariqt@nvidia.com>,
 <vadim.fedorenko@linux.dev>
Message-ID: <agFLqlZCNOjhb2mW@rkannoth-OptiPlex-7090>
References: <20260508034912.4082520-1-rkannoth@marvell.com>
 <20260508034912.4082520-8-rkannoth@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260508034912.4082520-8-rkannoth@marvell.com>
X-Proofpoint-ORIG-GUID: _57bHlIqKkCet3bb_N40MVmAu_AE1zby
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDAzNCBTYWx0ZWRfXwJmaH3Vy2nIQ
 Gc88x7OtcYVwqLUffFwEhtqMS/u//4p5/UX5DY2kGtzhgFn8L4bA50dVKAIe1ccnLyn+pI8cNyl
 H0gPMuKYLD62Z7/M2dlohYbLR+WtVvXa/ZUppOj0lz6uh1HnDNb0cv1uUAvR4lLRMrhHUSylzry
 7KHHZeIBhI+KXgJWR5Rl4aCNvLVfA6+kNyntvvESGoZNYNfYMWxJUNVDgmJkWJ1o7Wci7x181ii
 aF2sRsRjPTI30kvU2dkg/UIx8MVmN8crKz2dYrrJzs6eq828JsTvtufIS9jVcmcHegAeoLtl3kq
 LYIpsPCy/+5FxR8jMEKcR07e6pK4P57wu8t2Q07kSBNbe1H7ROQcWa/9kOkfSpNu2AT72SyrD8W
 mT01VAxnDueEa9KImWHeZRabFp6YbeYxndIW5yOvnvM91Lyc5G6CB16QOIzLk1r05hg9zf4HTtO
 DUiuAYqaGOJMSY9SUdQ==
X-Authority-Analysis: v=2.4 cv=cNfQdFeN c=1 sm=1 tr=0 ts=6a014bb5 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8
 a=6Uc7TgH-81yiOY1GMCsA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-GUID: _57bHlIqKkCet3bb_N40MVmAu_AE1zby
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_01,2026-05-08_02,2025-10-01_01
X-Mailman-Approved-At: Mon, 11 May 2026 17:33:18 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pfpt0220; bh=l6gfg54IftcEb6QLIMve9bgrh
 XIY6NVvWV2lujfC7xo=; b=bGieu43TqXXuAc4WLceNG1yoDZDQ1Wc6cHVbiZR/R
 3pMI75N0df24gXovAEYMKW398HMQkiPAEGLkDzdYqu7ZhOgbO5qAKCaXldtapQlR
 Or6Zp7xx0m4ZsNGr/3FDHiqulmRl/qPMop1PRtoFAq127vKLMDJW7tI7iLhNbTmR
 Ma/wgZCxX+O1mH8UC0eHv0njP5DIW0SYl00VvBP5a5CwKrjcycz2gE+4MnEFs6ye
 nc4gPybiuB0PG3gSszwhBsLxWU6j/VcngApbVfPj7fWFryTJ6Jb5x5OBsVl8GBYF
 Si7NXiXbzdJuo45iwL1XuwjEggMdrgtxZ4ZSsrJZFRnTw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=marvell.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256
 header.s=pfpt0220 header.b=bGieu43T
Subject: Re: [Intel-wired-lan] [PATCH v12 net-next 7/9] octeontx2-af: npc:
 Support for custom KPU profile from filesystem
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

On 2026-05-08 at 09:19:10, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Flashing updated firmware on deployed devices is cumbersome. Provide a
> mechanism to load a custom KPU (Key Parse Unit) profile directly from
> the filesystem at module load time.
>
> When the rvu_af module is loaded with the kpu_profile parameter, the
> specified profile is read from /lib/firmware/kpu and programmed into
> the KPU registers. Add npc_kpu_profile_cam2 for the extended cam format
> used by filesystem-loaded profiles and support ptype/ptype_mask in
> npc_config_kpucam when profile->from_fs is set.
pw-bot: changes-requested

>> -static int otx2_mcam_pfl_info_get(struct otx2_nic *pfvf, bool *is_x2,
>> -				  u16 *x4_slots)
>> +static int otx2_mcam_pfl_info_get(struct otx2_nic *pfvf, u16 *x4_slots, u8 *kw_type)
>>  {
>>  	struct npc_get_pfl_info_rsp *rsp;
>>  	struct msg_req *req;
>>  	static struct {
>>  		bool is_set;
>> -		bool is_x2;
>> +		u8 kw_type;
>>  		u16 x4_slots;
>>  	} pfl_info;
>Does caching this profile information in a static structure cause a data
>race across concurrent device instances?
>The accesses to this shared cache are protected by mutex_lock(&pfvf->mbox.lock).
>Since this is a per-device instance lock, multiple network devices could
>concurrently acquire their own independent locks and read or write the shared
>pfl_info structure.
>Could this lack of synchronization lead to torn reads, such as reading x4_slots
>as 0 if the compiler reorders the write to is_set before x4_slots?

PF request as thru mbox, and mbox message handling is serialized in AF. So there is
no scope for race.
