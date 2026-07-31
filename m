Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A343C55167
	for <intel-wired-lan@archiver.kernel.org>; Fri, 31 Jul 2026 05:46:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2452280F0B;
	Fri, 31 Jul 2026 05:46:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D-G0Sl6A4CdT; Fri, 31 Jul 2026 05:46:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2B34080EBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785476779;
	bh=QnECJGkC8JWuMD93Im4nQortUd4uqVSWCrnVFhfnTTE=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q8Y6NefAX5TzKP65ihqwPMHfC2BAAZLJcs2QNFNWDfmtNtqesqTzoHqWjTvDwdM6i
	 lTmZH6OCIpg4Lg6ZBeasedTCMp32QVG6upfuo5tWnuc8jLGfbyK8283PVpiVFRN1YF
	 k2sJaJP5kW0VbhD46VcaWHX/Ne5sDOt69fWlHTKqFzteVbvR3BvP3C4dwW0bqXIVqa
	 w9p0jhbU14aZXfBUcrRN2aKUuZbyUl0UfsvriQfUP/mCbv6KIx10APlwUraL+C0srH
	 kEr9mHZpLZM93WYuur/ToTR9c/oB0K2mTdYG258TS0p3v18EcIXytklYLF4poXQaKj
	 EQM8xSQsp8c9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B34080EBE;
	Fri, 31 Jul 2026 05:46:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F079927C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 05:46:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E20A460789
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 05:46:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LC3K0H9ToZSR for <intel-wired-lan@lists.osuosl.org>;
 Fri, 31 Jul 2026 05:46:16 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DEEEB606EC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DEEEB606EC
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DEEEB606EC
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 05:46:15 +0000 (UTC)
X-CSE-ConnectionGUID: hKrPqqWHTmyFwJCLuszI4Q==
X-CSE-MsgGUID: Nz86qMJjTa2IE+GUJTINSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="86116331"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; d="scan'208";a="86116331"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 22:46:14 -0700
X-CSE-ConnectionGUID: aesEPnGhRBey13MKe4uQMA==
X-CSE-MsgGUID: K7zZx/bfRmu9jYq27in4kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; d="scan'208";a="256588730"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 22:46:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 22:46:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 22:46:13 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.18) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 22:46:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2pow8/YJPNEYJwsvmeiqqnwTZwRHz6niR8MMInWjYj8Dp6JGgs9hiOd7opILAm9KL7vG2c6IA1mZ+zBMZ+OPMBYznS2efIWaZqpoHlwhdAR2+wDSYt3t41uM2b0GNl88mN+GfakCGyuFX1KoFyR37L9wB4F0jvHl1IWZZMRErLcPuklv9VhIK1lCXE+M24czTIeY9U5wO1iHAi6IgKqWvN1Jfrt0ScHaP7L6Z+WnDqpBWzHCboBnXG1Py7GGmapJEjNLlZHsa1y9H9oe1c2NAFtQlsx+ZlQ39mfFwUbBkYSCb4+soeOGYKJBlvpijyE/rIrzwzBdKrWTocSkt1w7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnECJGkC8JWuMD93Im4nQortUd4uqVSWCrnVFhfnTTE=;
 b=sqbwGcyha27isVWlJXjdsEdMmT1YWWCqn2yKdzQQovqUZmSceMxPwov1D2A1oKKAs5RnKA2Fw/fkTz/V8ptwjJ+pXiG68+1nAfv7sMoomjFUPBfjWjxDcb4GMFEiOB3veTNNFFFNWiYSyuaKOpBIerynnUHQA25GAayj8JDq7WCOyIu9v4M4qXBYoChoj3XfuXaDr0NESLqi8GwjF1WDzNRWHIvIRE1+VRk7FiQoTwen9Jw1OLLzne6V5ONSwRGtExocXb5BaLABZwdTT+HkasvZGB95vmwdWswMgPrbqQudXphh1gy+7fd4Ii7CFmCSh4EAZT5l6SAKx9/sgZQ4DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA1PR11MB8224.namprd11.prod.outlook.com (2603:10b6:208:44f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 05:46:05 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 05:46:05 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Chenguang Zhao <chenguang.zhao@linux.dev>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "kerneljasonxing@gmail.com" <kerneljasonxing@gmail.com>, Chenguang Zhao
 <zhaochenguang@kylinos.cn>
Thread-Topic: [Intel-wired-lan] [PATCH net-next v3] i40e: xsk: use
 xdp_build_skb_from_zc() for XDP_PASS
Thread-Index: AQHdIJGRE9++QqnwFkuf3kOFazGvtraHHnnw
Date: Fri, 31 Jul 2026 05:46:05 +0000
Message-ID: <IA3PR11MB8986E45BA1B67EBA5DB67EAEE5C82@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260731020736.170485-1-chenguang.zhao@linux.dev>
In-Reply-To: <20260731020736.170485-1-chenguang.zhao@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA1PR11MB8224:EE_
x-ms-office365-filtering-correlation-id: 5c0e72b2-34fe-48a1-6746-08deeec7035e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|10067099003|11063799006|56012099006|18002099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info: WTLQDWIRoeOnXuqaEW/gB83KtAptHzgmR4Y+oGPlpBJ10m297frgbQOLxRHsTLbOTDYLoWmuIz+FufnaFOrCz6BiKsQle2/z+lZwurWPkxpriNDuZeSEMiqvDYez7iF5xtHPepXpRcY2f1owgXZQqv7/bRfzoDIJ6lfPur+5mTsqcntKBtHuiJItRs3XvNBUN59mEdE4AMMxfLfosT7J95/4BEQnf+QQCYZhu7jVXurl9PQLdKVcxIwrb4j35z58LYu+k9wxxlvYlfRDnfLrqXMOY+bOZEOAF41+/7KnsZUwvjy2gVXx9Jc6zV6nFpReqW06Fyc+NRt596gVYK3/JFIaSTSrVRsUIEhbXP1HVlMKcvF9jeIV92S2Odi8xnpfEZBlW87cFlsFqt1y9AyQOupkOjx+wfstVTFYPjZCyUFYs8Dt3D449lp7KFDCzPYAu8lwXkaetY105LHwUA63t15bhKRNhOejCqNEskrWRWGGpfk8Cdf3VHRBuwS4XOCOiLnvIVGQ0QcTzTv0pu7j8K0unxZafNvVLaX8CFTeJh/E/m5KihdidSsgu5XNiP75VZ1qQPx0cOfhj/EGMLkTkukwNu5wVrGtUcJeacnUkWkCHIKF6WXVZ9eaVbsBJFuk3rtO7VIOllxPgR3xclyP6uSjIuA3JfSPEOHV53McXyLhTfxl2AS6QciWYRqa6SBhFpk6f1oEgnBfRYhuhHvclbMbrA9/AulXUaK+G9zhZsOIA/7O1sY27qDcerGMOegO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eTuzveUSfxEudS0qsMkDrWNVRkJIn2VlkI6Tc61kmNtIzAzWmpr4yibHV35c?=
 =?us-ascii?Q?yhIr7SspWmmq5TZLga0ByMYTPVyv1e7Z8pDGYsV9E4h9ka2ZJkMVES8HocBd?=
 =?us-ascii?Q?oqY7iTav2JOjH2XmAuBrUQfn1ND/zFzJP1yz0es7qLbmwf6sgtebqf2i6eQu?=
 =?us-ascii?Q?4PGleFDI71qGCdChFYi3vyig1EofrbFnG4Nm/8/EBIKbIq7qdRpN9HPS08qw?=
 =?us-ascii?Q?QKvS3rOipOj+3wfz/+fvUukj2eN+XJijnCKXrz8eeEQTkWyd4b+CewpjFoTw?=
 =?us-ascii?Q?kp75HKlbVJqMzPAbNsawMvLwXOQy5fGrrORNiRmAemommXH1joXafgn02PS7?=
 =?us-ascii?Q?fvwXNFDrFDBF4znbqIHYlEOcZjh1fOcN4ut4qka2nUG0PxYsZks5NagKhnCQ?=
 =?us-ascii?Q?qfmf1geqhX0Jyyb4Q1GiOBsAqJd81VhiyT0jG0vnJh4puTYwVvuGvOjj3DEi?=
 =?us-ascii?Q?eeZEj4S5CuBFD1+pxAc5TQTyG34JPHQ+AunT94mA5e/c+lPcTujyNHqv2PLk?=
 =?us-ascii?Q?G0NQC7OMbD6JBMu3k2xclqiLtAghWACT6q3bCFtKWnpecy6ABdImkInoCAsH?=
 =?us-ascii?Q?jaQ1Rolf+y/LCCdjnADvmIxHYSWJE2gpLtytNfgkfixCxVAdD4cmFqlh5yav?=
 =?us-ascii?Q?S6sYbFqNGW6+sgqhK736vdY7QtfXmrEgRO4kw4FUw/invMMKAk5Nhmr09agl?=
 =?us-ascii?Q?fBVVEhDMH5jSN9I6lXYpHvkEzRyFCfL9VUlFIWPzJzz4UwVdKLj1JE1UgU40?=
 =?us-ascii?Q?PtSrxuixwc9sxfOt6W0b4XzUY1ikzr6ynEAtx+aWvR5hGRxZ0vdoHGoTPNj4?=
 =?us-ascii?Q?OOYp7N7Or+n/nfDMR2wvw2LX36AXUq9vbZo2Ut9IyajxCsQ4uSdRBks40Htf?=
 =?us-ascii?Q?+9CNsxqNzIf9q0X7CQOSCZEfpAfr+1hQAxvOJx4aseWr41dFM6FO0L0UJvfV?=
 =?us-ascii?Q?4goZz+dVVDuIMOqvd1UItgdW8mvo2vXm+d+c4V0LbkkSfRBIL+DwTzT3xT2i?=
 =?us-ascii?Q?NdIjAlT2JvEk6LXV1xyoc18ngVFQtAhUbblrFDyfL8WhF6p6+mxTWRKchKMO?=
 =?us-ascii?Q?2h4WwDCgsUD/wyWEzyS5oEIVC9jl0MNmigduZq4s/crt+k+0lL47s4JWf3vT?=
 =?us-ascii?Q?P33E3bCgFe7LwJ4iAm2GMLiTiVXc2XzdT2cc2n1tWqOCmUZtJS08BfsMD8Xf?=
 =?us-ascii?Q?vu8OFhuQqkN2Kn2/LT/TPED+t34S6g3i5IhqvQ7KttsGkSeSNbKEGG5bEo3q?=
 =?us-ascii?Q?1goscZIDMhZvrwVoHmEghwAOBpGOn7lnbw/Z1DXTIXckzV3Fk7s5gnEk2Uv2?=
 =?us-ascii?Q?vl4hSCZFJ3uKjO/6r2YdtdJARf8h6rTFJNuwpVMdQbZXFprz/N8TnXa6U1Qh?=
 =?us-ascii?Q?MX4mc7OOTPW81Zgi5kaiRj0eKqENpGdGhtvr7d7SjEV/autBlT8eOh1temLr?=
 =?us-ascii?Q?R/y0WLgb2/QVQyCCUA2QmQL9qJqZZ5PQJ6EMpUdvf3up+tGcY5+8WnrKBYSn?=
 =?us-ascii?Q?Sdm5niMq71IFH19LKss9pRvGanLXkSZHN862ynvokcwxLAPcWni6ICpGgRnX?=
 =?us-ascii?Q?DcRFH3+Nr3AAEmqS66P8GSJfoNJf3+oXIW8eVS9S6UkYKLTbBvBDAzGmK4tY?=
 =?us-ascii?Q?f6dMNG1lAE3sP3XoONDkqof7eSXHSo2CMzs4sHKptbTLYzVEDsGhhCZIETsE?=
 =?us-ascii?Q?3aTHuakWDD6ej5UK43mzesKydZZb9flfzYjyRk3egtaW70pxOWyxTbb8UWfa?=
 =?us-ascii?Q?70sEGIqwbDIo3jJD9fHtDRucCOmShyU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oa1KZ0+JjY+mtBHnAJXDVHUZbgpckit1gJhJhsaFRnh2TvGRDD8nDONsmTedt0bXwj/cHqWQNPjyvR8dm1L/NO/q9UGyuZJAo5GQXiNpyn08pP12AIoRx1luegkW4KBGFNSBZyGpLNoJvbSFM5I/nYKCuPWYui2MXA8H2KyRkYe7opmeFNeGM47plTDwSjr/KppvP0vW69mOoalUqNl5+bGOq1BWJwKj9qx7Q3h7XR+uld6+P58am3tD6UN2vGkfWX71Kwf3l4Dj4YEpG/F1quKuQttMgiCMn8REBqIGRMNPFsijZ3XWVF1dn4sYsV/5hkUITSsnGnZ8/5QjrKSBCA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0e72b2-34fe-48a1-6746-08deeec7035e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 05:46:05.5004 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c/8zqNL4uRyNCUIJvnmH5rBB9a8Yk8/6h4JIvv0On/RPpd8v32hrKyQGsWCnVKlGUsvW3GSoaPVeFujWl9A7oRdStBw/pNKG/I3LiGVAfu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8224
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785476776; x=1817012776;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sLq1CnbCDI4twFDFABvYkRMlPDDg3F8uoGz0PsZJytk=;
 b=j3j9dO07n0ccpHz8ImVKaxSEytuXsS0exEvAA7udaaRekSvHrWXG4v9v
 XVTDsaEGP3zzytdJX8GQH/PHBjSzmEKZv91V13NyfN5sCFPWwQAOyyyTY
 j32cTb/RbJLV1+NFy0GRvZne5XV1ids9QiexUm0DFCmy56FIGXFhIRtdv
 MkZ7Yz1WGdxGm53lX1tDtpNGkJbnftg+qsbwT2n8YPi+SoKSnxYOYi417
 zkS6EFAdcxgvpv1bXalnwoFitv5nDwbIsNc3CZG4CxlktWjKacTob8GEk
 vjdSuH0xAK2ZhWaDf4hVgqyZIbaLZBgvOdsh5l7Ujos+oEvVHmTapaRlG
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=j3j9dO07
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH net-next v3] i40e: xsk: use
 xdp_build_skb_from_zc() for XDP_PASS
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



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Chenguang Zhao
> Sent: Friday, July 31, 2026 4:08 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org;
> chenguang.zhao@linux.dev; kerneljasonxing@gmail.com; Chenguang Zhao
> <zhaochenguang@kylinos.cn>
> Subject: [Intel-wired-lan] [PATCH net-next v3] i40e: xsk: use
> xdp_build_skb_from_zc() for XDP_PASS
>=20
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
>=20
> Replace the driver-local i40e_construct_skb_zc() with the common
> helper xdp_build_skb_from_zc(). On failure, free the xdp buff in the
> caller.
>=20
> xdp_build_skb_from_zc() already calls skb_record_rx_queue() and
> eth_type_trans(), so pull the remaining descriptor field setup into
> __i40e_process_skb_fields() and use that on the XDP_PASS path.
>=20
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
> v3:
>  As suggested by Larysa:
>  - Drop eth_skb_pad() on the XDP_PASS path, along with the
>    temporary __skb_push()/__skb_pull() around it. The stack
>    handles short skbs and other vendors do not pad on Rx.
>=20
> v2:
>  - https://lore.kernel.org/all/20260729054916.720750-1-
> chenguang.zhao@linux.dev/
>=20
> v1:
>  - https://lore.kernel.org/all/20260724020125.246333-1-
> chenguang.zhao@linux.dev/
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 32 ++++++--
>  .../ethernet/intel/i40e/i40e_txrx_common.h    |  2 +
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 79 ++----------------
> -
>  3 files changed, 33 insertions(+), 80 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index ef5e657816f0..87553b14d34a 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -1833,17 +1833,17 @@ static inline void i40e_rx_hash(struct
> i40e_ring *ring,  }
>=20
>  /**

...

>  		napi_gro_receive(&rx_ring->q_vector->napi, skb);
>  		return;
>  	}
> --
> 2.25.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
