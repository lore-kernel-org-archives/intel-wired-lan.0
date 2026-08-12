Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188BBC5AD5A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 12 Aug 2026 10:32:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B49E240467;
	Wed, 12 Aug 2026 10:32:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1gu7LptM7NsW; Wed, 12 Aug 2026 10:32:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 210E5404C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786530729;
	bh=2IkDjcoCsuLZPHZKEXVv850dLVYnFzvEuNlHrtU8MUg=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H+AHOjcpgOfpDsrb30QOLLwT5RXIKv6jHJ//Mpzm7cCxsAPpuFO4LTenQnCcMjF8t
	 Fr7IQ9FWG/aSDB7iBWCSNYB5QtM0nxlPTydRtjH3wl6ytpt/xYjd9jZ94EXIZuicI8
	 AX+9kUIUhvE+YM7DHJ+w9kGgbKLxi/W0e98vs/1nLer1aI2c41HhilGvGX+nLZmoTG
	 WA/JUATRUVshKe9aOQN1lXUKr4w84PnGkGvIvdv36cSeuxbugAu9PkjxHpzpVUrOf8
	 6j7W5PZ0KSy9sM+7p42hVY+5mn1SZirbXSYlDPhC9Xr0uz8fsMRoeYtYpOU0kynHnu
	 SI8CARXzapYRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 210E5404C0;
	Wed, 12 Aug 2026 10:32:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 23A3B361
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 10:32:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 08E38810E4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 10:32:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mHjgw23oTEG8 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 12 Aug 2026 10:32:06 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=sx.rinitha@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0B50380DF5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0B50380DF5
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0B50380DF5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 10:32:05 +0000 (UTC)
X-CSE-ConnectionGUID: RUxZe9ITT0Grw4ZOE8KDcA==
X-CSE-MsgGUID: jbi3G6ITRriIvADKsKOf/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="104613881"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="104613881"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 03:32:04 -0700
X-CSE-ConnectionGUID: Q3bplMKJT+SqsTjoihXScQ==
X-CSE-MsgGUID: 2VLnMjXaREaSn9X1AObTfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="267101717"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 03:32:05 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 03:32:04 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 03:32:04 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 03:32:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqv1LBM+7YZ0XzJeK5N1VbTHZYPP884LQNyFCAoPCEPgX9aA4nnV3n2kBVyMWSqeMEfdD1J06somNWvwkU5gAcG+byhYH3Xpmfpa2z7B+QQcU2ZSfy0INWBdb9v4MiA9MWVBRMUWuwYnlDTrwAgRZm1ZwdW0dB8YS7VEF891hKNZoU/YuVYwBxBRmM5Si5M5vjwLme1eKG3gGjolYt+9rYECdH2gjPBjaokc+7Q5MgAUtlnDnBIKUSNA1MM0s53sRpuamfnBu5pmPzPh3hkGCHR90aBZrWDDb8UDE2BC4Byjp9MCjI+XDiqmimzKZwYJpWxoU1BmiLDmkOMG6cWmGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IkDjcoCsuLZPHZKEXVv850dLVYnFzvEuNlHrtU8MUg=;
 b=bXJPerBPqkW/KDixSrAPC/IVm2EnQ8+bDWUNb7X0XMDn6og1h1epYrPeiG0+i77CCBxO2JJxJ2toQHlE8nCKJUfe9LAIzBvWJtQPi5sUHtIAcq2Gg5lnlnEqDomQrhlJrDpUeby8M+/gmpz5FcbsvEVHdflrUz4wlyLLSZczxe20RTWWlITks4Med4sQohLsFEcn+hn21UXPOfQfY0DONj/uj1POJSLRy0xwBCb9DhFuI0+uQ5Gze+vWdvNgHTnCkGGxPjfu4omYFn8rPXuOeMQ++phz+X4YmtSjpT1zFFsApAPZARkbQ3H7NOpgJ3uZg8JbhRcu3BHgX5eI0rtDGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by DS7PR11MB6247.namprd11.prod.outlook.com (2603:10b6:8:98::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 10:31:54 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 10:31:52 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "Jagielski,
 Jedrzej" <jedrzej.jagielski@intel.com>, 
 "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1 1/6] ixgbe: E610: init Link
 Status Events mask just once
Thread-Index: AQHdCgYicOq1EY1Yv0GSe/NzJ+l/gLaactlA
Date: Wed, 12 Aug 2026 10:31:52 +0000
Message-ID: <IA1PR11MB6241776F3CDF64452D2EF1818BDC2@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260702091553.57112-1-jedrzej.jagielski@intel.com>
 <20260702091553.57112-2-jedrzej.jagielski@intel.com>
In-Reply-To: <20260702091553.57112-2-jedrzej.jagielski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|DS7PR11MB6247:EE_
x-ms-office365-filtering-correlation-id: 54ff8831-c12f-48e9-a8ad-08def85cecb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|4143699003|11063799006|38070700021|56012099006|10067099003|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info: xJI93UPXXtA+34wt8cCwXdS+YDnYyEDPNle2cnE2XSkUcM4t2meNUDcl1/ZHImgYekNA0TQwMgTXyc0seRTYIVr+O6c/eaVJIiOvZAhBufQU2ASwRy6dRIkcqCnTuU9lO7UgeJloq7x2Sv3/gNn7O4JXUv6vFTGsNdZLUmHZInQ3a41OtDHlqEc5Ex/vEoNmTHfACf5KDNHvPwpjgsTvb5JWkjZuCeHma8aPg2vPBBB9NCTcwz9GruCKmDk1Ag8ENTWpg66Xpz7X50YYhz2iBZlKdwEqnHAMtyq46y08pwWvUcZN+fgguMth5/Q4fj8CN9WZ58OEkW4Am6hJoqkpLljRDpfz1zru7fF88EDvSDRnuQvu8GsgW5yTspEkNcyC/gNPoqdh6B69SFJHVIYk0fDXc0GCSezH2RnmBfDLtL10n1aXn37HVYJx2PHJocw9ob3YZpBxPLM2idTrFxDCLute7HNdooD6cFcYXrLiqRQBLascbXYTzFrliRxXNmTchi8cPwKCU2unLzU6U9UhRvn5QdkDVHoR9CAQwpZ7Qe96oh2XGyAKn4wBSs8WQQ8BOlYSfCUSVjOWBEaSWmvJMCuHUbWmlhnvCdZKhk0MSX3BIHqbP/PlAJ8jTV4ZML5WNVDH1Bo/CGJDSc8g1/NIT95yXA2TehSsaAYvXsxo03ap9UNbXw3VdCbp83jPL01OcaHxWdajNjIqKiEa7lFR6MIB3em1tnzbVkliMSgdLME=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6241.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(4143699003)(11063799006)(38070700021)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7BqDlc2xapnUti/uOIty0nTxD3J+ManCFsNLKGFQoLPzBQRla2lKLMIyySPD?=
 =?us-ascii?Q?tgWVO5W8g09/w+2j1d9C9In1eD3Us449thdd4iURICL2/BHxpAXO8BPIL+HS?=
 =?us-ascii?Q?wl56GdbvQ9Q005A1kfSkzqNYKbyX4/NSiE2fUGR2u0XlZtC2vbzSeOEPWfEO?=
 =?us-ascii?Q?c2LQX2TwqT6SSNaQRqH2fp+ujVtkOEv1Qv/EqF5UUQ9kBjFq8yfyS/c4YXha?=
 =?us-ascii?Q?9PQddOtJJSmZtmh9WDN8cMuX4ysVVQppAPHQiz8PQN/bMAH33TuunqABLx1W?=
 =?us-ascii?Q?QhTHVGwguXil5e1zJ6AO0ymsvWNvIiqtTu6xTAzy4kXWwUKQk4TAYYDAFPf2?=
 =?us-ascii?Q?24VX+VZ4oKIXzsERAiiDJf19Sl4+dYVFqjscuv9QmIc5cvlXVtl5SDvKZ/ur?=
 =?us-ascii?Q?28i0Xg0oT1weVlniF0X0Ssl50Q1c3KlxyUjgvVCQUv1wKhe+G1nalJuT3Xmm?=
 =?us-ascii?Q?dkKtzRD4ge/sL/ehq8Adwe7XxpZ6ZFso5KZKi0xKHqEGrUqPsLzZ4UZYoR1f?=
 =?us-ascii?Q?Ntjbq/mZ32Kj7lT3fLaj+Bc7g5P0AtJWKgh/IWyP0wbEdWDYKEFmvmSC6iJN?=
 =?us-ascii?Q?55FLQeglhDKgG2Dsy3HWcODc7gE90k7xJPRXk3Eym6lr37rvI1alPNWXev3K?=
 =?us-ascii?Q?nDcAYXzfmgSl3zc5nw9SN2yGi/qzoPSBczyKLROXPxXamPnMkJ0/41lL+KId?=
 =?us-ascii?Q?JPg4CQSK7Mi5EhwmzxuGgEKOZ5gJdfJHJqNahmY+906s6DfcWDVrXio5L772?=
 =?us-ascii?Q?2IIGiDTrTheHQCB3lpQ96VM2RgZk9ZWcYMxOWkLinv44+BRR4TiAL0SLVBe4?=
 =?us-ascii?Q?DT3QNC2EdTBIRDlQHvzHg7RIayXZkyUlkpZrE0g6iiQuNqnQlXdiTinLrszq?=
 =?us-ascii?Q?Fz/hUVYW23L4Mi1TugP4y/fDFUPRDs0o7TcaZzzNqUZTK8nHquchsejMSCLc?=
 =?us-ascii?Q?5Gqh2TB7fBVEqaOfJW9U8fgHtdDT9vmbghf5XfRtU1dP7rwxqSM4p3wCnBaj?=
 =?us-ascii?Q?C3wQqcQQGu9gX6kJL+ZOEHp1KqeLuduIDUf5M9/GF2DcZ/UyH9JkGczpScHP?=
 =?us-ascii?Q?j78gMLWQvxyl4yQEi6SroD5CvXk/lHYLb1gTOJ2ulJ+5qBHKbdhiNOUEDGG6?=
 =?us-ascii?Q?w2So2nmV2YjeT52Am8VQxrz/fnDPu7/MYjjg9Jp6K9VyohWqGfxagF6MGowO?=
 =?us-ascii?Q?UtVYay4PT6JnzWpw7WBtdFNo67NQve494EAsHc+YE4iwM+8jz60Pvwdr3CVI?=
 =?us-ascii?Q?/0BGrQZkh6CACUes4SSRE7iLZIfE4DWBqeY5k5tkkfHdxB8NmUtIuV5NhpCL?=
 =?us-ascii?Q?8AmusDQ1owEDxjUDdEXPYRJOaOV8aO3QVoUs7Ge/wbsmv6lSoX4AeZWRz25r?=
 =?us-ascii?Q?4OjEhNj//Z2HojjPz9bezb7K5Q069nTNRGC8zZmH+FHOlbR58n/fI4HxzLgo?=
 =?us-ascii?Q?9V+VBHQutqV4SILRBUxXo17B9Bl0JRCtFM6Ej37D2qRYkW+Hx25yCSJVIVRI?=
 =?us-ascii?Q?Xhl6S1u3AQRMEJhgaSKZDys7ApQciMgRi6NUfuoCw7aUtTTZ0GWGExUDhlmd?=
 =?us-ascii?Q?sh+DiYhB1e+9ii7uSJLgaxMP7fwejiTZgqrcEpcRDj1ZiIpCYJJndL8NDw3g?=
 =?us-ascii?Q?UbnsCSmROIlLgrg37yiB8TqscX9ZGWGnzmMRKvPv9+RlHc/jPd5KioU0CnNH?=
 =?us-ascii?Q?dmCZajC5wcjTI/rT9sxqw2hQdEktayDHAJPKczqKGxtXUEuM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GulaGA0zGq1XTOvaVy65Zup9a8tmE31e8IoNeKPMg47N3PbcXbNbfv8f5qQZ0Zgb3j1Xoc/0OcJKDp9Cprlnp/RL04hYgIgjqOPnRb/khJ6D1HkPcnVvIxxq1EBiv40lmpRBVyymkz9Bx8iCnwjquY1Rdf65UB95DFtQKovhu/E3YkiEXrdaf/2JxxYjihPvxiDBW6zcA8M/CcJZl7eu/pnYFUo4MskXSDovJGXsHOgyJkbnSvu1Ed1nGrLU7WQMTIKr5VPW0/d+C66SdsBthD/tCqx1mM8cw+AUtFkg8vWc40NsAAXZPussoh9W1Eep9JHpNZyz5n7y/X4r0pzxJg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ff8831-c12f-48e9-a8ad-08def85cecb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 10:31:52.4692 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dvi/dEM0uDSPmdhLMgXS+8RsaK4oMzqQuvLTk/cQMcP/kKJEcy4BY7ShDxd1/Sv6luBVCVK9/z6Y0kaXqdfIxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6247
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786530725; x=1818066725;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ngosbAb4RYVGRhwovd8xfFsHmh8rygd+K6cBwHA+6BY=;
 b=UG2aoPBMd2k1Mjko/Y2wYXHiYXvJiVcrj1gKjsOsSCMFKN7Jt779dkyw
 oY2B37CjqvsZ5KaxynfQ7xN4GzW2c2Ecor1yDD2Fay7trNO6wn9ejy7yK
 BPv+CPWYe/PZGRbovk99S1hHNpLf0hzUOG+3xW7D2nz9+aTPEY45jTywp
 3SAm87QjPUnLMk2rAc0uytmycI6AcznhY7uCuVWyXJQ2V7fk2IAxHcduh
 UkUwV/xpy5qvuaow3uCNwcPDjyO5xJdwtgnaXhjflYbKoyfqN9YHAZ+7P
 wXRfdsRvj+lIp0rh8h5+Fc8dM8+9R3yY86XpS/sIa7d568c0L0Bzs7BYG
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=UG2aoPBM
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 1/6] ixgbe: E610: init
 Link Status Events mask just once
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
edrzej Jagielski
> Sent: 02 July 2026 14:46
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; netdev@vger.kernel.or=
g; Jagielski, Jedrzej <jedrzej.jagielski@intel.com>; Loktionov, Aleksandr <=
aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v1 1/6] ixgbe: E610: init Link=
 Status Events mask just once
>
> Current approach is that LSE mask is configured each time the LSE feature=
 itself is toggled. The set of bits corresponding to LSE trigger causes rem=
ain the same for the whole ixgbe lifecycle. There's no support for enabling=
 or disabling specific bits within LSE mask.
>
> This is redundant; there's no need to configure LSE mask over and over.
> The mask persists in hardware and only needs to be set once so should be =
separated from the LSE toggling logic.
>
> Do it just once at the init phase.
>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  1 -
>  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 34 ++++++++++++-------  =
drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |  3 +-  drivers/net/ethernet=
/intel/ixgbe/ixgbe_main.c | 28 +++------------
> 4 files changed, 27 insertions(+), 39 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
