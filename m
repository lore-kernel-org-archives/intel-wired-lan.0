Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50849CD484C
	for <intel-wired-lan@archiver.kernel.org>; Mon, 11 May 2026 17:33:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14F8780C9F;
	Mon, 11 May 2026 17:33:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RvGVbkbiP3fg; Mon, 11 May 2026 17:33:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E432480D8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778520799;
	bh=Fx4jM/eCLSzhdCMRG0qXyGASn2dR9UyyBS199+OF+Og=;
	h=Date:From:To:CC:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YtEa+XByuR3O5VaieHDHF8HkXT5nRbh3zMTO5ghSUM5BVVzsyXGZRkGQnvSGO/u00
	 DVpfxS0gDgcba8vdWGNDm76QpzeSwo5CDdL8EupmCE88tWrAkRFYlyBAaXpwRCwZVa
	 twyXKR2Gxp12lvNGhsSXHEn+Bh1YbfuozQbtBJzJnRxPBm6HMe3onSYAn3lih/3FPz
	 WuhCa7xuC3ZEsaviYa0gIgUDdxzJH+7sBwBUjYN7wk3cGJK7P8DIWDIZOB3h8nMYS6
	 hjto4Ak2fUz1yRAOBxJE+aKSb/qQM5RrVi+WAg08ulC3g3YVxJ5oGn51gvor+j1PS7
	 e3T3K9tXt0zNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E432480D8B;
	Mon, 11 May 2026 17:33:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 96254272
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 May 2026 02:32:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 78910607C8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 May 2026 02:32:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nQkcTLWFoi1H for <intel-wired-lan@lists.osuosl.org>;
 Mon, 11 May 2026 02:32:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=67.231.156.173;
 helo=mx0b-0016f401.pphosted.com;
 envelope-from=prvs=6591f29198=rkannoth@marvell.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4FEE8607A0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4FEE8607A0
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4FEE8607A0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 May 2026 02:32:11 +0000 (UTC)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B0ikgR2133290; Sun, 10 May 2026 19:31:42 -0700
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e34kn85fk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 10 May 2026 19:31:42 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 10 May 2026 19:31:41 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 10 May 2026 19:31:41 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
 by maili.marvell.com (Postfix) with SMTP id 241DF3F7088;
 Sun, 10 May 2026 19:31:31 -0700 (PDT)
Date: Mon, 11 May 2026 08:01:30 +0530
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
Message-ID: <agE_gvJUphZOQ4vY@rkannoth-OptiPlex-7090>
References: <20260508034912.4082520-1-rkannoth@marvell.com>
 <20260508034912.4082520-5-rkannoth@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260508034912.4082520-5-rkannoth@marvell.com>
X-Proofpoint-ORIG-GUID: TfGtu6GAkrw2IK-s1tUzB-SiCHQPXzyE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDAyNiBTYWx0ZWRfX8FjbBl3JgtHy
 DPNeWbSICECBwrvNpirTC01k4ai0hlghDHrECh6PluVOPhbILWAkaNGXGBBvN//eMjkaDAzcIPQ
 GvUZcJ2HTu3TPmQVw2ei4BLz4xIH0FL6tIRdmIUzodeWKs6+z6UzqLRFQMZgamCgSt0QhWklNS1
 dhN/4pOPQna6nrvu9KhybQ0pPG+Ptm1rWYo9IW7aio7pPipQAhagNcjGSGVXoh9yqbsKIQ2ibhd
 +e4hh5yo74CO/W+Qrjqd7rf2Tve+M8057eCSmp0y9jfIUnMWmDW2Oiq/XmQyiC4bd0uUCq92gjM
 cuiCvm2l0r/r34RvAvfI8c1b0oopQ5qcDDBmdYN0xOP46npPHdfuQ2rwX3IHnHSebjTjAunor21
 uxku1fU/JptjfykJiOVZ6TjoGbxOCOmQbt7p/CALB7kdijb/UY0zQ08/dJw/UMHjTNiSe0BTFTh
 lwCxV12AdrxcsQwyzMQ==
X-Authority-Analysis: v=2.4 cv=cNfQdFeN c=1 sm=1 tr=0 ts=6a013f8e cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8
 a=M5GUcnROAAAA:8 a=Ikd4Dj_1AAAA:8 a=3myhGO0DrLiAD-WPr5oA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: TfGtu6GAkrw2IK-s1tUzB-SiCHQPXzyE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_01,2026-05-08_02,2025-10-01_01
X-Mailman-Approved-At: Mon, 11 May 2026 17:33:18 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pfpt0220; bh=Fx4jM/eCLSzhdCMRG0qXyGASn
 2dR9UyyBS199+OF+Og=; b=eNmJTldLKIHjwuVR6oM2wTAMns30Ug6V2RH0qnHsB
 QBN0U4u0avNWSPmhX3dfcRdUChOSrQg2mBLwa3bB7sR43OFqdxhShg8+RxVmL2A8
 WJ3+gDg9V9PpWQ4XhT+kqsddTco59Mn6cPoL1bYkVQIJ49NMj4Oko66/j/Jt8qCV
 9GPIfQ53ultM4H/JGiaYLLlAiHQfkdwMqB/MNI9vNDCfpAAoSTZZTL66zjRcbILn
 1XdnzzNq/aoOAgxZMwn+htzFhyiN6TKUHlWQ13TXnQb6Q8HWG5SiAefpxU3/4qKj
 2lc+YpMXPb4MSypna4vKI9pAqUfQA/5RYkaT5rs6kvQSw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=marvell.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256
 header.s=pfpt0220 header.b=eNmJTldL
Subject: Re: [Intel-wired-lan] [PATCH v12 net-next 4/9] devlink: Implement
 devlink param multi attribute nested data values
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

On 2026-05-08 at 09:19:07, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
>
>Separately, the commit message justifies this new UAPI type only with
>"without breaking any policies".  DEVLINK_VAR_ATTR_TYPE_BINARY already
>exists and can carry an arbitrary-length payload in a single
>attribute.  Could the commit message say why BINARY (with a small
>in-payload framing) was not sufficient, given that a new UAPI enum
>value is permanent?
This is for array of UINT32 or UINT64 types. And commit message clearly mention the same.

>Also, the 32-element cap and the fact that elements are encoded as
>repeated top-level DEVLINK_ATTR_PARAM_VALUE_DATA attributes (rather
>than nested) are not mentioned anywhere userspace-visible.  Would it
>make sense to add a short section to Documentation/networking/devlink/
>covering the encoding, the per-element width rules, and the maximum
>element count so that iproute2 devlink, ynl and third-party libraries
>can implement this without reading the kernel source?
DEVLINK_VAR_ATTR_TYPE_U64_ARRAY defined in include/uapi/linux/devlink.h, which is uapi.

>Does adding u64arr to this union bloat every instance of union
>devlink_param_value?
>Before this change the union was dominated by char vstr[32] so it was
>32 bytes.  With struct devlink_param_u64_array { u64 size; u64
>val[32]; } it becomes 264 bytes, and the size is paid by every union
>regardless of the param's actual type.  struct devlink_param_item
>embeds the union three times (driverinit_value, driverinit_value_new,
>driverinit_default), so every registered devlink param grows by
>roughly 700 bytes even if it is a bool or u8.
We did modify to alloc from heap to reduce size in stack frame.

>Would storing the array out-of-line (a pointer plus a length) keep the
>cost on the users of U64_ARRAY only?
I dont think it is a good design. We need to contain every thing from userspace to kernelspace
(and vice versa) in this structure itself.

>Since the in-kernel cap is 32, is there a reason for the size field to
>be u64?  A narrower type (for example u8, paired with a
>BUILD_BUG_ON(__DEVLINK_PARAM_MAX_ARRAY_SIZE > U8_MAX)) would
>structurally prevent the put path from trusting an out-of-range size.
but there is no saving as such by defining only size as u32, as each array element is
64 bit, due to alignment padding another 32bit is lost. So we made size as well 64bit.

>>  	__DEVLINK_VAR_ATTR_TYPE_CUSTOM_BASE = 0x80,
>>  	/* Any possible custom types, unrelated to NLA_* values go below */
>> +	DEVLINK_VAR_ATTR_TYPE_U64_ARRAY,
>>  };
>This is a permanent UAPI addition.  The name says U64_ARRAY but the
>kernel parser accepts either u32- or u64-encoded elements per-entry
>(nla_get_uint() in devlink_param_value_get_from_info() below).  Is
>there a reason to keep both widths accepted under a name that promises
>u64?  A single message can mix u32- and u64-encoded elements today,
>which is surprising given the type name.
This is a design suggested by maintainers, as it allows to pass both u32 and u64 size
arrays from userspace to kernel.

>Is __DEVLINK_PARAM_MAX_ARRAY_SIZE intended to be visible to userspace?
>It is defined only in include/net/devlink.h, not in this uapi header,
>not in the yaml spec, and not in Documentation/.  As a result the
>request above 32 elements is rejected without userspace having any
>way to discover the cap in advance.
I followed __DEVLINK_PARAM_MAX_STRING_VALUE, which is also defined in devlink.h.
So i dont think, we need to do it.

>> +	case DEVLINK_PARAM_TYPE_U64_ARRAY:
>> +		for (int i = 0; i < val->u64arr.size; i++)
>> +			if (nla_put_uint(msg, nla_type, val->u64arr.val[i]))
>> +				return -EMSGSIZE;
>> +		break;
>>  	}
>>  	return 0;
>>  }
>Can this loop read past val->u64arr.val[]?
>The ingress path in devlink_param_value_get_from_info() caps cnt at
>__DEVLINK_PARAM_MAX_ARRAY_SIZE (32), but this put path loops to
>val->u64arr.size with no equivalent clamp.  If a driver's ->get()
>callback returns 0 but leaves u64arr.size unset (see the kmalloc note
>on ctx below) or sets it above 32, this loop indexes past the 32-entry
>val[] and emits those bytes back to the requester over netlink.
This is okay, we can send as many u64, which can be fitted into msg (skb).
If this reads past u64arr.size, it is an issue with the driver.
Please see jiri comment- https://lore.kernel.org/netdev/3pk4hkzgwy3a55zveapgmk23bsevru55xv75vhkzbpmzkfofcx@rlnkrvynofig/
