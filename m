Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA29FC54F51
	for <intel-wired-lan@archiver.kernel.org>; Wed, 29 Jul 2026 14:16:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 645C980F81;
	Wed, 29 Jul 2026 14:16:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f2HDgZaTzYUM; Wed, 29 Jul 2026 14:16:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D1EE880EBD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785334561;
	bh=py2LSh+0NCrOAoF7d/0eqNh1Rcnj8tTaMeNUqjAKqVU=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kjrSE7GNuBc7RFRbNa2s0jT5aW7o4qssugOyueyWEv6EbyjutUMpcAFiTP6tR7CCd
	 BpFdYk+DXftkaUW2CJd00RaRvULxUcEXgn+HikgyMrZ8Z6/Kl3Oy0Sc+GGaw2AwNky
	 YCKkPPtJE/vLexDhV8DyITRZwJW87o78FDyVAMKNVxD7/MktxWiV9o7gdmaUJYuxiv
	 fBzsA7f2qwyQ06+G0hE7EgEDsakXVdmSKwpdT+5+L5cZJaRwylVIirNbcFKGhdThf8
	 3bkGwkJnZC6WnLQEuZ3ucsKNslC9QKGSmzIXvwCEN1xZy4UqQob3exXNd6l3OmYoza
	 p71G3VorHRpYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D1EE880EBD;
	Wed, 29 Jul 2026 14:16:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D53D0490
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jul 2026 14:16:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C680A80EBD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jul 2026 14:16:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gZzXgepNvBfZ for <intel-wired-lan@lists.osuosl.org>;
 Wed, 29 Jul 2026 14:15:58 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7FAC880E90
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7FAC880E90
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7FAC880E90
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jul 2026 14:15:58 +0000 (UTC)
X-CSE-ConnectionGUID: QmaZX7efTEC6+3Or6CtBwA==
X-CSE-MsgGUID: Yx2uT147S4SK1FarUEyGZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="84917736"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="84917736"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 07:15:46 -0700
X-CSE-ConnectionGUID: s3BdFXAmS66wMdo/kqB3uQ==
X-CSE-MsgGUID: eM3DgVlnS1yrGFfHPMxh3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="265051808"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 07:15:46 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 07:15:45 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 07:15:45 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.21) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 07:15:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1hpT/WzDjYzX3QoTwUnwqMOOSmuQP/tFkBwbCm71XqITJdylo/hocxQc1CnN8phE5MPDdXAwRXz29LVBdI8wHJTgqAdLk3nVkhprG1Fo7TRDiuqdIRjyeDfRvN7xVNj92zuNnFYksPj60GTSVb6b0eBdKThSO8q2ZtVIqGFW2vVJXWQeKjS5VN/VmoPufPPizVnabCeAlqx+tIJmiz7RP6OqzMCBxBkQascDb7/uhuJQQEpllWT6305cipAOGvLVO/o9hXrLB6loBUBCeJYl0YTW24YCA/wDxG5je/oENYiPrVeDZ+3lb5i0AmvyzwgWCuR5AihDVJ72EtnYrtdwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=py2LSh+0NCrOAoF7d/0eqNh1Rcnj8tTaMeNUqjAKqVU=;
 b=YhaBXMJtkD8gLbB1D2EZFW7y4sv04vhqJbjXZA1TMSFE3GjwEzf+FRZj/U6c81SFRZIo3WlcaCQe2m2Xbctvk2kvayESvwDRTm4ImZbO2nEknwJH6PIjSPTOAaEYgUrELUUUAIaAFKGGsOCcX4+g96IXv4U7zSBLVvFnZQMt65b6rBtaVEpaimdIMweElvCp4K4gV6YwIyJu+RqLUj1hqrwq9D/hF6upElUw2bTbDaZlTEj29zEhq+23pmvVKRF+kndanB7nOpTSlCoSFKoEIp3C3xHsZxWImMsnxAaTr5poV6p64hyGGPUYT2DL7MKFTk8e7Oc7xWx1ikihTdb15g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA1PR11MB8280.namprd11.prod.outlook.com (2603:10b6:806:25d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 14:15:42 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 14:15:42 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Nowlin, Alexander"
 <alexander.nowlin@intel.com>
Thread-Topic: [PATCH iwl-next v2] ice: detect duplicates in ACL
Thread-Index: AQHdH2N1l8f76mBBdUuowMHGv4eNx7aEio6w
Date: Wed, 29 Jul 2026 14:15:42 +0000
Message-ID: <IA3PR11MB898622CD73C9F2318A41402AE5CA2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260729130510.220222-1-marcin.szycik@linux.intel.com>
In-Reply-To: <20260729130510.220222-1-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA1PR11MB8280:EE_
x-ms-office365-filtering-correlation-id: 36d96445-61cd-4ee1-5a5d-08deed7bdfae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|38070700021|11063799006|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 3hY19QPhtv1Mu/VHwK7Nfy409PPtREhqTrDg1xlHi7D+uW0tu39KmPSbUhQtQ7yjEqCTKLV8OnTfdfDIfKoqW2ptlM/uwVPG+X7xrOnFqe3u3vc0/i29VRzjbkGjQh9J+EIvVDJhrWK2My/GKXFu1IHd0Gfr5ap/ifc1UU8LVzu6fUNpPtNUXMh3V5XwgHKJ8QtKjpx4CBlcDzqiY7+v3azoJh+D1BZ3Klc3H5TxVwCk8by2GKHBBGEmRZ2CiXv9/j675xWNDXnLXZDVVlzDvaMmJxwI0za2jrvXRQeI7kTqFv1m1MM02mYMUD/jAIB+3cmkUGoQAB5JmZsmv9Cvn0ZfoMibGHshCF74wTYCsJ2W3vVGR2TlR6ooksgBUUf/y+v6N1AJcgfxFHpvdJK8zJ7GvGLIS9qHey5ZtdyxArWbRPLZtmbV5XmSD9mrW/e6+guw2MXumtAbSTXZqwqB7uo5u68sKFZUQrmdZkzRdnEWIhls3E4EaDWc8WnmAgt+R06n8vVIkEG1HluU3AnbPAZFG5ToF4R+ZXLuxxThPlYT0MnaI+7+ESG46Aic1JRu4KPTIS3SNeqU+I8l9MW1hb10sT0/CeiPteDPWwg0fP+ROD0BUZHlrbsAHcbqkviRq/smO6WzNyyUtjAaxI2cJ4yDMaW81wQha5AH2e3NjThjw2qiJKkBTCuC0PWSWb0vMr8RmMHUtr2TitKDJgIX1NCzEu/gY8u/oDcvisT69dE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pUiWgx5atTTpDRazmL2G5hphzLcq0DHwIjF7ngltSAo3KVNyrRttr57mehpY?=
 =?us-ascii?Q?VTMvvxKQtk8KfwYGHsXIRtywhfiyEKgQbyslKgRxCpQXzvaSqxxcjE9HFct9?=
 =?us-ascii?Q?RXZA/LuA0Ys3pV1KBplMLJfebbC5Z+h3AJl73PZrUO5SIvEF6bIVbsNoRS4X?=
 =?us-ascii?Q?DGIiUZ6VN8sI7IxR4tQ8QmnukX3ODmgnhy6b25Uf6myKcE0EKgMFybtkB+4B?=
 =?us-ascii?Q?69GPE6EIZy6v91YsvJWD2ydpFgUXf4OQqKPVeXtSxUJm3UHULpPB47mR6lKM?=
 =?us-ascii?Q?b2RLiufx/tBhFUfrtb8w1wz21ACFyV96AjjaMFQi25MfxYYu0pXCuOPRm4TM?=
 =?us-ascii?Q?A1RSe5DFXIvFcSqyPSF2xD0BzzIG0To58s+V1TjIA/RfnDnUIHtV9aYD7RNu?=
 =?us-ascii?Q?fvXvdgCoCimaV33vD2tZZ8nVNuyP2H4rsaOV8HIbcZYB08bOxWf313oBhcPh?=
 =?us-ascii?Q?rzQHt5TLufWXMdDjghnj8Gtw5EOm6SQDEq6iV9Y4CavI8IMYY0ODWALUPeUQ?=
 =?us-ascii?Q?fvzONG310xvo9YlRv1T0S9uUr8l7dzSXuHaCVvheGjF27juqQNEg8+1uyYTW?=
 =?us-ascii?Q?PKsBCBbp/M99CckoKlxeDjnSY8HguEGjlnBJpbbQUykhQq5E22gHC8+07xu1?=
 =?us-ascii?Q?uRc5/v+IXezpqBLjyHfeG2uifxBEHIctS1krlhnxPC8iyuONwvEbEA9o6yEr?=
 =?us-ascii?Q?Zb0uyi9wb6l31SxwNYjIEBgExydTuNA/nN3UL9ZxHBeP18si2Y6/NyqVRNIA?=
 =?us-ascii?Q?SNspyYeGQK8ZXR58Bbbu2IENzy0XHzEE7mTnWjaONPcYgUfzDKSQZVwwzzWw?=
 =?us-ascii?Q?bxDwI04IZtusdEItHBse8f9EuBbd0PTAV24uMUWopfQ2U32m4A/6LQPl2R2O?=
 =?us-ascii?Q?7IA69SG9qLOO0UZS/3pDZBU180zSvTIww9+aki0s8F3haxCz64ZIJBDN3rWp?=
 =?us-ascii?Q?9jswSiciUSjuBAV07fweIpp87vkQg5rH0MkHWXFGIOmH6UHFgad6OKmCKoZ+?=
 =?us-ascii?Q?9Ht93q5Ph3BM99JNvr7K0oN50vt6IX3RHD0bvLjlLQL/q0zHGsxW9D+VG4PC?=
 =?us-ascii?Q?VuZsmwarmwCa1dtTiOoEpZYZlPyJX6jS7eBp0HCfyialtvDNbK4BL3KD/Vya?=
 =?us-ascii?Q?5Uvy9Pw4u2Nb107XEk/U0slsqvzaRNWmdA+tc3pathLaPsTyfKhm/Sq6U67Y?=
 =?us-ascii?Q?AoUjG32uPo6Jk3mzzz7rzBOARanKSwqYgQjnPY+LYQ7LibmtOEks/kIF7jrV?=
 =?us-ascii?Q?2MozjJp3/w+6isOImFmiRCKO0+l9iBrmQWaHDifXtMn79GffK2CMbphmW56G?=
 =?us-ascii?Q?E1KHjkx9QTwhyDHE7B9LwVLy4pb6coxDyHAj6pDHtYwkBS5PR5Mqd5roKWf0?=
 =?us-ascii?Q?PDg/7/wWqAnaiyNbNoaIgWpHoWy+lpACsGtYAleCBTVFBQY6mocVz9OVlREP?=
 =?us-ascii?Q?WstaQebfFrleQpCMeBBrJZCK1JDeFo0ox6936IuKIfzvh6qqWcMjKRdf8mXH?=
 =?us-ascii?Q?aqDKtdFqKVIUqPeSNocCWACoF5kAHhF4rbXIOBkYFbSgDk2PRzkyxCyZizZC?=
 =?us-ascii?Q?zyvgvTCbkbsuwpJXqCakJYGujzRx7Y/dmGl943pcEkIWYP38IXwOy94Sr267?=
 =?us-ascii?Q?7LVB9bVMW/54GBCW7m332jGhYH5xGnMy6DOwzgjtKmUl40K8byA56oMOm0pb?=
 =?us-ascii?Q?B2faljuZczzTwqrsaeSWXf68kQ88Gl+lKq9kYYXSJQm/uuXFKu2oXK3CKrPq?=
 =?us-ascii?Q?LYXLKHjJF86Rh3Qgk7YuC88du/GekQI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: r61M2eN75K47wEYVw3jC9j1sSI/JPjem93j3yjOZ8W5geIYH2SYWOfl7vXSAsavBfn9Aiemp5pPlc+WLGsrzya7OWGGACvpe0rbsrPiIKgM+kAuQfYNnaG5fFeLTXPpI+m7/CmN/MwvHi6LpSqszXKQigeglD0UBdZKRTFP6BRl8PByyKlHPb0ZmyqpLZnHZxVHCb+GhkTKVxRfKeWz1ODaDjbN1HzRbU4Gxzx1EoHfLlAPuAmb3D08S9ihoWzlKx7WiyPq3ztdjGcEh7gqaTNHNw0FN8b5qQzquQP0b0t9k6SoaYUahAG6K72islVsE7Vz3vqk6jxwHqA+mvAusHQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d96445-61cd-4ee1-5a5d-08deed7bdfae
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 14:15:42.1617 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AT+zWhV/CgGXl02XMUjuWuvWv7yjhZIRbCDEKjWd++olae3GL+gIn/OLOnKZVNby5nWzUfTKHkRKt7sLIPPX+U5syMOrlWaho2wnXYGhO4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8280
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785334559; x=1816870559;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=JIE3rhHppcFfVeKGI748ksL9FTU+mhQJ/RqFUJAKfYE=;
 b=MmJdZhSkKjwBJstYcfh9/QCdJBp2rJshcrO49f3Cd8WSAbC+jU9HePs9
 ZlDMRiUvHzuI0drVpkp8L5RMfEgEUpolYscIgrxCONaLE2sFEhEh0tshx
 j5DvcTKNofibSNiODuZflajPidBFijBV0wkl1rYFl3lSMSPGraguTFbvY
 XGrscU+ev6+gyTX+9SptnYFbN8wqX5mlxKjkj4bMxXMAefN3gjBYM8Dso
 j15Gl3OmJFruNoMmwJXTmIG4qaaCoN+d6Di8TIBoFEj4wMXD8vqV6MI8L
 iQ1wkHsz3q9DiWts5jutBG1LthNwC5iZaFLi5X4OEQXL7V1hV4tQezjr2
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=MmJdZhSk
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] ice: detect duplicates in
 ACL
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
> From: Marcin Szycik <marcin.szycik@linux.intel.com>
> Sent: Wednesday, July 29, 2026 3:05 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Marcin Szycik
> <marcin.szycik@linux.intel.com>; Nowlin, Alexander
> <alexander.nowlin@intel.com>
> Subject: [PATCH iwl-next v2] ice: detect duplicates in ACL
>=20
> ntuple filters without masks (fdir) disallow duplicate entries. Extend
> this behaviour to rules with masks (ACL).
> Also skip checking ACL rules in ice_fdir_is_dup_fltr(), as it's only
> used for fdir.
>=20
> Keep the naming convention consistent with ice_fdir_is_dup_fltr() and
> ice_fdir_comp_rules(). ice_fdir_is_dup_fltr() cannot be reused
> directly, as it ignores masks.
>=20
> Before fix: duplicate rules with masks are allowed to be created and
> the duplicate rule cannot be removed:
>   sudo ethtool -N eth0 flow-type udp4 src-port 9000 m 0xff00 action 18
>     Added rule with ID 31231
>   sudo ethtool -N eth0 flow-type udp4 src-port 9000 m 0xff00 action 18
>     Added rule with ID 31230
>   sudo ethtool -N eth0 delete 31230
>   sudo ethtool -N eth0 delete 31231
>     rmgr: Cannot delete RX class rule: Invalid argument
>     Cannot delete classification rule
>=20
> After fix: duplicate rule is correctly detected:
>   sudo ethtool -N eth0 flow-type udp4 src-port 9000 m 0xff00 action 18
>     Added rule with ID 31231
>   sudo ethtool -N eth0 flow-type udp4 src-port 9000 m 0xff00 action 18
>     rmgr: Cannot insert RX class rule: Invalid argument
>     Cannot insert classification rule
>=20
> Fixes: 3272c00a1247 ("ice: create ACL entry")
> Reported-by: Alexander Nowlin <alexander.nowlin@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
> v2:
> * Tweak ice_acl_is_dup_fltr() function doc and comments to accurately
>   reflect what is actually happening in the function
> * Add repro steps and expected behaviour to commit msg
> * ice_acl_comp_rules(): rename ipv4_equal -> base_equal in expectation
>   of future changes that might introduce more fields
> ---
> Not sending to net because the fixed code is on dev-queue.
> Tony, please squash this with the offending commit.
> ---
>  drivers/net/ethernet/intel/ice/ice_acl_main.c | 87
> +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_fdir.c     |  3 +
>  2 files changed, 90 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_acl_main.c
> b/drivers/net/ethernet/intel/ice/ice_acl_main.c
> index 7c566077d55a..d13e8bc1b701 100644
> --- a/drivers/net/ethernet/intel/ice/ice_acl_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_acl_main.c
> @@ -283,6 +283,85 @@ void ice_acl_replay_fltrs(struct ice_pf *pf)
>  	}
>  }
>=20
> +/**
> + * ice_acl_comp_rules - compare two ACL filters
> + * @a: first ACL filter
> + * @b: second ACL filter
> + *
> + * Return: true if a and b values and masks are identical, false
> +otherwise  */ static bool ice_acl_comp_rules(struct ice_ntuple_fltr
> *a,
> +struct ice_ntuple_fltr *b) {
> +	bool base_equal;
> +
> +	if (a->flow_type !=3D b->flow_type)
> +		return false;
> +
> +	base_equal =3D a->ip.v4.dst_ip =3D=3D b->ip.v4.dst_ip &&
> +		     a->ip.v4.src_ip =3D=3D b->ip.v4.src_ip &&
> +		     a->mask.v4.dst_ip =3D=3D b->mask.v4.dst_ip &&
> +		     a->mask.v4.src_ip =3D=3D b->mask.v4.src_ip;
> +
> +	switch (a->flow_type) {
> +	case ICE_FLTR_PTYPE_NONF_IPV4_TCP:
> +	case ICE_FLTR_PTYPE_NONF_IPV4_UDP:
> +	case ICE_FLTR_PTYPE_NONF_IPV4_SCTP:
> +		return base_equal &&
> +		       a->ip.v4.dst_port =3D=3D b->ip.v4.dst_port &&
> +		       a->ip.v4.src_port =3D=3D b->ip.v4.src_port &&
> +		       a->mask.v4.dst_port =3D=3D b->mask.v4.dst_port &&
> +		       a->mask.v4.src_port =3D=3D b->mask.v4.src_port;
> +	case ICE_FLTR_PTYPE_NONF_IPV4_OTHER:
> +		return base_equal &&
> +		       a->ip.v4.l4_header =3D=3D b->ip.v4.l4_header &&
> +		       a->ip.v4.proto =3D=3D b->ip.v4.proto &&
> +		       a->ip.v4.ip_ver =3D=3D b->ip.v4.ip_ver &&
> +		       a->ip.v4.tos =3D=3D b->ip.v4.tos &&
> +		       a->mask.v4.l4_header =3D=3D b->mask.v4.l4_header &&
> +		       a->mask.v4.proto =3D=3D b->mask.v4.proto &&
> +		       a->mask.v4.ip_ver =3D=3D b->mask.v4.ip_ver &&
> +		       a->mask.v4.tos =3D=3D b->mask.v4.tos;
> +	default:
> +		return false;
> +	}
> +}
> +
> +/**
> + * ice_acl_is_dup_fltr - test if an ACL filter is already in the list
> + * @hw: hardware data structure
> + * @input: ACL filter to check
> + *
> + * Return: true if a filter with identical match criteria (same flow
> +type,
> + * values, and masks) already exists, unless it is at the same
> location
> +with a
> + * different queue (an update)
> + */
> +static bool
> +ice_acl_is_dup_fltr(struct ice_hw *hw, struct ice_ntuple_fltr *input)
> {
> +	struct ice_ntuple_fltr *rule;
> +
> +	list_for_each_entry(rule, &hw->fdir_list_head, fltr_node) {
> +		if (!rule->acl_fltr)
> +			continue;
> +
> +		if (!ice_acl_comp_rules(rule, input))
> +			continue;
> +
> +		/* At this point rule and input have same match
> criteria.
> +		 * Same location with a different queue is an update,
> not a
> +		 * duplicate - skip it. Everything else is a duplicate.
> +		 */
> +		if (rule->fltr_id =3D=3D input->fltr_id &&
> +		    rule->q_index !=3D input->q_index)
> +			continue;
> +
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  /**
>   * ice_acl_add_rule_ethtool - add an ACL rule
>   * @vsi: pointer to target VSI
> @@ -322,6 +401,14 @@ int ice_acl_add_rule_ethtool(struct ice_vsi *vsi,
> struct ethtool_rxnfc *cmd)
>  	if (err)
>  		goto free_input;
>=20
> +	mutex_lock(&hw->fdir_fltr_lock);
> +	if (ice_acl_is_dup_fltr(hw, input)) {
> +		mutex_unlock(&hw->fdir_fltr_lock);
> +		err =3D -EINVAL;
> +		goto free_input;
> +	}
> +	mutex_unlock(&hw->fdir_fltr_lock);
> +
>  	memset(&acts, 0, sizeof(acts));
>  	if (fsp->ring_cookie =3D=3D RX_CLS_FLOW_DISC)
>  		ice_acl_set_act_drop(&acts[0]);
> diff --git a/drivers/net/ethernet/intel/ice/ice_fdir.c
> b/drivers/net/ethernet/intel/ice/ice_fdir.c
> index 1bc91cb41769..1d79138683b0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_fdir.c
> +++ b/drivers/net/ethernet/intel/ice/ice_fdir.c
> @@ -1261,6 +1261,9 @@ bool ice_fdir_is_dup_fltr(struct ice_hw *hw,
> struct ice_ntuple_fltr *input)
>  	bool ret =3D false;
>=20
>  	list_for_each_entry(rule, &hw->fdir_list_head, fltr_node) {
> +		if (rule->acl_fltr)
> +			continue;
> +
>  		if (rule->flow_type !=3D input->flow_type)
>  			continue;
>=20
> --
> 2.49.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

