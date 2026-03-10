Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC28FD2D63
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Mar 2026 12:04:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 346DA41F66;
	Tue, 10 Mar 2026 12:04:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g4TaG6kLhmkK; Tue, 10 Mar 2026 12:04:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B5EE141EAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773144252;
	bh=rBKVXGZqDYvJn1EnAkiKaw4lvIbq8dg+FutTLkx5xPU=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WaDEL2ihKURk7uIc/jBBmp45Q/CfLYCUtuqbS8OkF00iuTOaBO9qf/lj+RGYPpUP4
	 lt/EHKdi+fCRGU492yjmKsl1q6BzfTFfK9bhdIkY7UsrMIsUmMiD3wsq3BuFj7FOr0
	 H5tUVvS7CGOMZB8OhJLBMR/jcXH0MpbybXzZWq4uNCEhdl10TRtnYNEzG0WepLxJ1o
	 gAIvlJ1j1hTIqmXWJu+2VXoLGbAS6QCLr74oaIBAA+iq339zdVRlaUYfpOCnVaaU2S
	 sAfy40x9Yq1laIUHdFIPPZQwHLhN7nPv0zoGDIwkkQ/qxNlXAAGAFZ3I0uv38ni9Wd
	 ysl1FoOiA3Nhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5EE141EAF;
	Tue, 10 Mar 2026 12:04:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F122201
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:04:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 04E9E60B11
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:04:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uyGaN9zEmsmT for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Mar 2026 12:04:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DDC3560B1C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DDC3560B1C
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DDC3560B1C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:04:03 +0000 (UTC)
X-CSE-ConnectionGUID: bgnFpNAkR266jPcorKTkSg==
X-CSE-MsgGUID: rWnMtmQnTUiZjofXRSaCXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="74088508"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="74088508"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 05:04:00 -0700
X-CSE-ConnectionGUID: NE6H15KRQLi38ntCuG4a4Q==
X-CSE-MsgGUID: wRka/PCMSXKJGBYwQtLmQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="218066907"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 05:04:01 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 05:03:59 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 10 Mar 2026 05:03:59 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.2) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 05:03:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oStZZxEWDZkrBnt4QCNJgtmTLmju9ubrx2q+W3+ubMNoBF0jqEXDBUuSeSJL68uqoObe1VXkanMD3HfziLSjkAnp8TUyAJ3/j14B0+cV8YgmRQLdeaNZOohkzgR1kBs/8fEE7LtFcKVIYEcBreF6cO6pQZ8TjDbBfD6hjOY7m3OS+0l5B2QcM3t/l0K6CZyEBB1sHspygdPNyPkfE4DCrLzegVPa8bgFFdkQP+dRKrbv3w9aBODkxFV7wimYEkZimgfIAtFx4Vjih7EFhz9HJ/GkA8KF/kBYFZl/QnjbNTU45jqDYqVrK240TPq5m6q5OgpI8toAxNEmZpDWQkvCTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBKVXGZqDYvJn1EnAkiKaw4lvIbq8dg+FutTLkx5xPU=;
 b=cbjBookFrW6/e8MdSp3Rh+WGqXIUNtKEPXVirhHFAPDI69kmILCyQwobHaXrANGXZqHzpwBknLMkdkz5xD0DQ/bSl21iGKvtbZkz91CDBE1KT0DRh9P+NmfmU9Vnw5yA0CV46KUVRMQt7LDcbodF/pWrIuom8oEdE+7aj5dRi0ytuMDjPigWOMbBpNR0smAU7cOcpMEyC4XtW3ofjJvGqSfLW4DIStttwZkAbDfY2D/+eOoO0OE7UcgRpgECaM3EzRK1dD0iMOw9THFTsED0AAfLtehtEKSgTt4e3NeXcO0KYO6WCgIIKXFee/BMl//TF9kPmjlUXrErr4do2VxXyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CH8PR11MB9508.namprd11.prod.outlook.com (2603:10b6:610:2bc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Tue, 10 Mar
 2026 12:03:58 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 12:03:57 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jakub Ramaseuski <jramaseu@redhat.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Korba, Przemyslaw"
 <przemyslaw.korba@intel.com>
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] ice: enable NETIF_F_HW_CSUM
 for GSO packets
Thread-Index: AQHcsIT2gM7EVVmiTkiuaHPXzBxhQbWnqrMg
Date: Tue, 10 Mar 2026 12:03:57 +0000
Message-ID: <IA3PR11MB8986B891354A9AEBB0289BEEE546A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310115556.1004263-1-jramaseu@redhat.com>
In-Reply-To: <20260310115556.1004263-1-jramaseu@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CH8PR11MB9508:EE_
x-ms-office365-filtering-correlation-id: 4fc4b991-c5ec-4b61-1db2-08de7e9d1c0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: LQungt6DWtv+dzSRci3+tCAXYu78Jv59xqZxTyN343dcJvMNYd9FjNXdkZkdDbxDUJ2j2iMO3Lnj+TQu6Q8I2+padhw4OqFuMXHxtQHumyD2QOPmoBneZWgeidLsbWqeu55XEqI+nhwX9I65oBqzfcKTKSzCp4sngzFXTyqjL7ywYlF/dTwTVQ0UwKxhSeHYQ165zHDxIafJzMoF8POHd+5BXvzpU9DjsPU9prET3NkAc/aSA0hsT9ult+QaT0X/YTCgFkYefJPfrgamRaMcIj4sjaMOkTsZmt58guYNDDRjx3gi4lgmUdKmNbC+5pU2Ej9IAEcfXEZV2hok/b8F6hFpQPqGg3nlXAw0IhA0Z/GIFe6peLPNAK+2/6I3C3WYyNc/ormYj/MkZtTQj+Av8Huo617d4XD7pDUXDvWGnvzBZknRCyxU1riaVcUd0ekS06wL2jU60k7DjJYOduQRNM54yD4FIj8ZMcSoUr6IZTc4Ad+U/nJA4TA4ooE252+Tssbeox/IkP7OuoEHoyGzvjA3VWVBlSuCJMK+cl6EqoGvWI9BC1vCXAKau4OyEk0u6LpMmxPXuI43BdnbXxezaKIM7HSvBs0OhU+Ux8bxomSDFjFGdt/Gx1hDNUh2uMMAQYILmIq3wJioG7fBsU9nKeXKf8EivwU7xuo+9/2okoYw94vdWClAl8UyRtHmcLpVFTOyaNZ/ezQ4rkNyR2mv0LAbrqr9G8J+vWJ1zczaql/wOiqBDjq+dkmbDoYriiHokkpSWGVOa+iHp6Uv2kYGoDHi2fvp9/BgqJY/gXhGKo4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lE9jTkUMxjUFGFejGWT/reiBws4AHxxQX7AHR3HdfdcvUauvV0gEew0OtPqw?=
 =?us-ascii?Q?NdCz2Ryf9JyEqNOpVVnY/pDBzeuiLynjleTROz041KB94cqcfjIfwb/RLv3z?=
 =?us-ascii?Q?aD3Nv5yagiBk0C5cpUSX7znYU/t05V4okaYNJiDPkTMQeYnI68mwl8jw8pug?=
 =?us-ascii?Q?eTxmrUbn2u5FgnfesitnYmC8hfqtSm8E3MDxWYUT+7awVdkAbPx1/ipTrqoj?=
 =?us-ascii?Q?p4upgOZWFFT1Es3lcq96Qr67OkPD2Fo3odIoqk2Ms+tQiX20X7nA36xrVl+V?=
 =?us-ascii?Q?UAAf1lrmpzZ/yR6DmOUluGwYSxLvGsYEu0MrlZHH1eYGvJ3v/lvHuHuYbna4?=
 =?us-ascii?Q?O49ZOE5JD+zGPYwroR7heMyziNw4lXz3T2RL2zKa3k7TqloV7mDUkCUFlgH9?=
 =?us-ascii?Q?9PIRLWD7fguAxZvpsiwqLm9uD83Mt52fj8KybuMO/1+5pqVkaxR2aAPDh8V3?=
 =?us-ascii?Q?oXU7pVhqsvvSRrDKl9vpp5DrTauwltpjRmBy293psX8JdvNEjAMcb2sYSpze?=
 =?us-ascii?Q?lMEo1JY/OlFh5JttkxGE4h02q9Ii2/lkARtYkCRHaJIhLCva90tMyUNCzGaW?=
 =?us-ascii?Q?GcE96Qb8TtYmych4KFyn1xEJLss/N/PUBoPgVS3WbWmWUBAHzGwYlXfphQMW?=
 =?us-ascii?Q?SitX4nqEaJOSLBOv35K9AhdyaX6irLJRx4J5ZjwqR3n0S2N25aOjPgLGQxRw?=
 =?us-ascii?Q?vAcZilP3LGAGF8zWgrOviX5A1KS2TGLrCsFzcbohYraVFJuUT2o1dFmJYbEq?=
 =?us-ascii?Q?TV3lfJ4svHXwpEQPtmuFyWT6SP/O2tKBWiLpr1oxk2Ip9IyPiGiXgsxMSAPW?=
 =?us-ascii?Q?wXzVkE0Ttqr9zNmZauaPlkzYNDMLw/Krv8vOvZgdc6VXUM/tqeKQQ7qchH0v?=
 =?us-ascii?Q?1yqba6Y3Cfp8tZLOJWOGtITTwr9PvIitdpLJP2ywXBMKce1SAJeVPcpsCnc+?=
 =?us-ascii?Q?XftkKIoqUGVJWYG7vApMg7CX1C46lcN3hgVBoQU1AjU5EihhVLB9drx9d4AN?=
 =?us-ascii?Q?br+4Il195DeSGhN9f7i3BSTIeUFAbUK+IIwYH0EHBYAc7h+U6DUhNQ1Z6W6i?=
 =?us-ascii?Q?Cs6VGUeosnlZTT25NXTIkZPjniElCIYfLIvC2dC3rgQxaf4jBOTW0Dv9f+zR?=
 =?us-ascii?Q?dRMHnRYeNlvcetj3akCxQ7/B00zHFth0UbzRGRtMOEg3PizgGraMWXM/DCSz?=
 =?us-ascii?Q?VP6tCfh93Bu4lYicy2ucd9wg23o5TNHtY6J5E/rSLwAy7apkjrwM/kucJSS/?=
 =?us-ascii?Q?xB2M3k1/VLYJYzyNdIZ4G+B6L80IaguBbwJp2oD2YqaubHDnMV94itjCj30y?=
 =?us-ascii?Q?pF78UYFILuSh44ZjVLeFtAOdxNs3CJArmkWYx3T+k9RJRmKzVaIOG7x+KsEj?=
 =?us-ascii?Q?gJ6lkZhP1tU2KL9jbaSP0PKSO6AGPZLUzJIPoYAggCEjPIVLaa1LAvyb+wBQ?=
 =?us-ascii?Q?8fPf60A+DsucQFhfl8Qvz+6uwO6fLSWJ0XfkXIuDA3QEjBnrz4PUh21GWF9s?=
 =?us-ascii?Q?WPfFRN/nlof1ohBOW8bHSRCpC+BcpKX/KkVVgUOXKE/C+U4SAn+GvYSQtS1N?=
 =?us-ascii?Q?wJ5PjKbq4/ghfnLkFWVkh7OrjsFRMzHB36GqmH+J8pi3w+Qwik047PSwScgF?=
 =?us-ascii?Q?CxZuyGidMi0B1VNQ4CkQg9BfY8Op9KENCuIDWC1rG+SQOo8aLVikmPfHxhGr?=
 =?us-ascii?Q?sJyGpn2IzSmWzOTzRktgPKRFkPhJfd1jPj/rwugZgc6iVJLdnXsb0zsroo5R?=
 =?us-ascii?Q?bKzVlSkbQua0MW7EtiWD64ScOpumNSA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vxyrUAVlxHE+1tp8W2MYOs2/XiGX9dGrBJs2pzt7IKiQ8NTmKiS0RNKv+tKlfVIxYBWWf0jUAiS4HfO7K8gzFdPnQnWuKuPOj4ED1ecsdVQdRI3+Y9fVZp7LVouMr49YYjAtDuEmKhn63pExNYl+vopPtHKZck1XNLE/x8v8oB+w7NPGLoTUQ0DeSDGi1bh3UKqJwwkB4U8+/pK4+xJreApodp5s62AxOQO+LIgwcW3v1KzPfyZRniSG9iH9yxIOIGjgSUM/gJLXPWY6NTizQxRV+Jg1/p9cVjhX3s6NhgWbuhkVXYs9m/R5MGkJ3FKDkQs1HMiblcazQePa/GZjUw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc4b991-c5ec-4b61-1db2-08de7e9d1c0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 12:03:57.8207 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KQvFXmSCHHJFQJHzjaVA0yXSjLzNLQFKWhEQq1HaiCNE3vyJhcCHPKVn9llYZvTUK69mV4dd7IKwAHD7MKkw5HObTQeNNaplajx0L7DG4Ls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9508
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773144246; x=1804680246;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Aaaa4BDZ/itikS08r6hRT5IIcnwEcLU9O6zjYy4PPAE=;
 b=Cq3lYklSyGs1S4TfL6MRlB7ehf8fX9nHcIJgRlnUVnizaJjSUoR0b8vy
 pmg+UpR+oQAUfZD4UOo4mHDILLEFbFKyTtf5J+ekMNzskyTnVzxEPN5xO
 IoaYb+2sR2Fpbb2ML0EHFoQasNdCK9Ao5uJBSIuu9JzthbCXz5XwMNu7n
 gOH7EI1HU/tjrncqva8aUChDlIWXpBdCQcw3o0kzW19ZOgRPIR8z3tH80
 j+HDPMxyQEkc/HHC9xIhiE/us9eqGgHPnJL/JRzomkiSNKmBx7sSrXCMa
 0AsV3+mB/pUdY+ef5iA3Evu6WAXaZqyK+XJ2Wq3ijytgLhA1fJi5eDDQY
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Cq3lYklS
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: enable NETIF_F_HW_CSUM
 for GSO packets
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
> Of Jakub Ramaseuski
> Sent: Tuesday, March 10, 2026 12:56 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Korba, Przemyslaw
> <przemyslaw.korba@intel.com>; Jakub Ramaseuski <jramaseu@redhat.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net] ice: enable NETIF_F_HW_CSUM
> for GSO packets
>=20
> IPv4 over IPv6 GRE currently fails on E810 with skb_warn_bad_offload,
> while IPv6 over IPv6 GRE falls back to software segmentation.
> This happens because the kernel's GSO engine requires the generic
> HW_CSUM flag to trust the hardware with complex encapsulation
> offloads.
>=20
> Add NETIF_F_HW_CSUM to the device's csumo_features to satisfy the
> network stack and unlock full hardware segmentation for GRE tunnels.
> To prevent checksum corruption on standard traffic, evaluate the
> packet in ice_features_check() and dynamically clear the
> NETIF_F_HW_CSUM bit if it is not a GSO frame. This forces the driver
> to fall back to safe, protocol-specific checksum features for non-GSO
> packets while preserving the generic offload for tunnels.
>=20
Please update commit message with exact commands for reproduction if possib=
le.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

> Signed-off-by: Jakub Ramaseuski <jramaseu@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index e7308e381e2f..9b4ad03e1a32 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -3565,6 +3565,7 @@ void ice_set_netdev_features(struct net_device
> *netdev)
>=20
>  	csumo_features =3D NETIF_F_RXCSUM	  |
>  			 NETIF_F_IP_CSUM  |
> +			 NETIF_F_HW_CSUM  |
>  			 NETIF_F_SCTP_CRC |
>  			 NETIF_F_IPV6_CSUM;
>=20
> @@ -9789,6 +9790,14 @@ ice_features_check(struct sk_buff *skb,
>  	if (skb->ip_summed !=3D CHECKSUM_PARTIAL)
>  		return features;
>=20
> +	/* Hardware requires strictly-typed Tx descriptors for non-GSO
> frames.
> +	 * Leaving generic NETIF_F_HW_CSUM enabled corrupts checksums,
> +	 * causing TCP drops. We strip it here to force safe,
> +	 * protocol-specific IPv4/IPv6 offloads instead.
> +	 */
> +	if (!gso)
> +		features &=3D ~NETIF_F_HW_CSUM;
> +
>  	/* We cannot support GSO if the MSS is going to be less than
>  	 * 64 bytes. If it is then we need to drop support for GSO.
>  	 */
> --
> 2.52.0

