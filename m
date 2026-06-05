Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED76FCD6E7D
	for <intel-wired-lan@archiver.kernel.org>; Fri,  5 Jun 2026 16:10:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 89544410A2;
	Fri,  5 Jun 2026 16:10:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NF8IUQ5PfnoM; Fri,  5 Jun 2026 16:10:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4FEC541071
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1780675843;
	bh=I4aMVvTXgPD2Qv7N5w00pE1b8tc/KXQuhqpkyMCtiFc=;
	h=From:To:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=BfMvXCpf14AaKYql85CiKefqo2QRUZ6Du1fJ+pyVyZsumoDaIJ/WJDdsSaf+3Wk3p
	 xHc7GRQWhgRG6uxEgTGKzHnUDyn/AU7Z8tT8rki9CZ4HKw+qTdsNFBn9InhanGKKTY
	 e4kE/qEa8KV3NDEDmQk9ERQyUd+yDVVsHmqGsui1II3PWEE3/w7x6RsRrogH69fI0z
	 zuaMHYr3iyWNcdinghfwDD3gAZBmRErdob7ZC1HAe6vliwZHzIIPbXbQf9Bwlh1D39
	 vDff1VtXfwWvcdd0IzW+VLjt3myfgOGEKdpyMBwQlWBaZH5TODhtmx4hU4Hhx+kOhU
	 ZqZ/xv6ZsxtkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4FEC541071;
	Fri,  5 Jun 2026 16:10:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0BB6D26A
 for <intel-wired-lan@lists.osuosl.org>; Fri,  5 Jun 2026 16:10:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E71EA404BC
 for <intel-wired-lan@lists.osuosl.org>; Fri,  5 Jun 2026 16:10:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0Cz5LpmWjY2d for <intel-wired-lan@lists.osuosl.org>;
 Fri,  5 Jun 2026 16:10:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2928B4033E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2928B4033E
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2928B4033E
 for <intel-wired-lan@lists.osuosl.org>; Fri,  5 Jun 2026 16:10:39 +0000 (UTC)
X-CSE-ConnectionGUID: eNhCyCg8SZ2XZBl805psIg==
X-CSE-MsgGUID: hviff16ARqO8RIhK73dMAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="106952838"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; d="scan'208";a="106952838"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 09:10:27 -0700
X-CSE-ConnectionGUID: CQPoD4eVR4mgzbD7Rzsz3g==
X-CSE-MsgGUID: 40O7DKJvQhqaEfg/Ud36Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; d="scan'208";a="241901145"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 09:10:27 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 09:10:26 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 5 Jun 2026 09:10:26 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.10) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 09:10:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3sTPbrkL8MJXPFZDsCQC6vDME7Rp8RVoStAeUtjd6JFBLwVSozolhRsYj64AaUS8JMGStw9UarO3+3K6taulCkWihwTTcbJWS8a4fkpi3kDM6ooiIYEr5eqndgpir2baJBbRsNOxhDgV/eKQvqN4cBZ40jLRwW1PIsvqrF+xDVXqYRURqvqFegThhW8aCWTmgI/0ghHoY4CdgOJ5YNzV7cErgz2dbukxlbF+7Ayzqb3p6PYTo55OzpHX0NivL6VjiAj/1xVZSo/xXJgN2FFyNGwaJcxi6NSPQ1jYEZ1i9V91GWmVph7V/eowHkatMYxyWCIEUstKpMZHEgwFVIisw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4aMVvTXgPD2Qv7N5w00pE1b8tc/KXQuhqpkyMCtiFc=;
 b=aYGoDjC8dGl8wIZwHZWFDLECcHO9LMX/xKfiiwaHIAlz4EswBqgcaBYwdyDTi5IySkFPzwB2k3qKY30HOLec25b4UPrwOC4viDzxlYBxlkjFQ9j3rlQwwCb6z2BbLmwJpR6GxS2MbDWSUMTqO8ORNZ/bDdtw552N1DRpcVD3ORHrPFJk9Te9y+fTwX9+Qtrs2OA9ge3dcVZfe8OgfPatN2dXX2vrlKCQGlAuUssHwLlOsXOxDaNCPqm0Rk093jeF1XlZ8jrTCxRep5ce3YDExiFMiDqdEI1n+9R5LblRxlbAmGOMrq0DIzu+mkcDjsFdXIW0NdJYiLn8j4mv+VRTsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6219.namprd11.prod.outlook.com (2603:10b6:208:3e9::15)
 by SJ0PR11MB6816.namprd11.prod.outlook.com (2603:10b6:a03:485::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 16:10:19 +0000
Received: from IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31]) by IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31%5]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 16:10:19 +0000
From: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Thread-Topic: [PATCH v12 net-next 0/8] dpll/ice: Add generic DPLL type and
 full TX reference clock control for E825
Thread-Index: AQHc73fbuuwofGiUWEqM+0MeGgr+dbYtpIwAgAEzHgCAADOQAIABGPFg
Date: Fri, 5 Jun 2026 16:10:19 +0000
Message-ID: <IA1PR11MB6219C1EF3BF8160226E5826992112@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20260529142628.1678955-1-grzegorz.nitka@intel.com>
 <20260603183036.7c4762d2@kernel.org>
 <IA1PR11MB62197FC8E64BE92FBC108E6992102@IA1PR11MB6219.namprd11.prod.outlook.com>
 <20260604155422.167314ff@kernel.org>
In-Reply-To: <20260604155422.167314ff@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6219:EE_|SJ0PR11MB6816:EE_
x-ms-office365-filtering-correlation-id: 67d96c8b-3300-4425-5786-08dec31cf05c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099006|5023799004|4143699003|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 1xSrmzfZjwrTPSt8WF946nGsvhQWaVewJ4U6RrHOioK1WsmgNaN1IHRVqXOiTatMZIUhdJPYUa5BJXqacCRfJDTUplqSvfq6BODqzbCv6EF4EB1KKr31V+iGWI4ErgFaceUxSWpePqa3anL5iuR2cHO5NF3391h3M7y99ZYdqNgYhd4d7spMvpHeYjq+RVRrxnoBEhLQvGPoI0Gi279e/g+5NaC9dapfJF4c/p6ULTaktqMlOBNOatUClXJNU58JxqUuO+7BHkVbRGl9mGHWo0P7rS1PY/TdcrrQC1CP9nLsyLuDL1FPSmNWVp09XI8NkBiLTAMObn+qY5ULkIAmjlEXoio1DbWmQT+CrBBBcfSPWfl7W/5zCbS6Lx0mSa73F098Pxl1VeEyipXKSowbul0Qbpkbb79bBstUNupq4FhXxoKvClzsfMYLr7CqQVnUByUW+jOqd1JuV5Zpe77KAICnQpjv5z4QlI+p2HttSdTCZTjPHCtmNx57cVI2BuCo9onxw4efRd1+Pk9N/EfPBD89e4i1blfQuXDNCfm4IZPW66PxdVvMVXWVv/VKJ/aG9lbZSOu0Z0kvmZu7l7x5qrXNTa79y/JEe1TZ3559U6gXSVkK+jZ8oY2zhPwLxZGmyAGgsbsGPTQ4ysdgBTB19Ew258k+2tVuYRZkaARka5WF0TcUQJPTCxppYj9wOfy3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6219.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099006)(5023799004)(4143699003)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y4diR2bGbVj5/+eXsrwYvt+XuqBSEfs7jUe18LCF8WbZBzmYhc8kHLKJ/tlc?=
 =?us-ascii?Q?kvQPjhV8j/SCELEIrAEdTifWh/hriprXc2ZadgNjvfMMCTjCr3TkA4XH3t6z?=
 =?us-ascii?Q?X1C98oG6ywShpRH3FCm5Uo2GCNHbZ+qr8U7QoolbleekoWfg/b5Kv9TZm9o8?=
 =?us-ascii?Q?nOfKyIqGwXu/aHk8blo+crltpwh3OlYS1cPsog8dHUuuLX+ibKsf9qHJgiqj?=
 =?us-ascii?Q?XYEYuxh37IzAGxYUw6BxCLCn5i6IVJeMAR6xWSpsl7ptN38j07Mwz+TLdICI?=
 =?us-ascii?Q?Yngs6LKqdD1osnJwbSoOkd+BhxW8iKPL2tmf8MyT8nFByh7ctyoHpqNCMu3n?=
 =?us-ascii?Q?NdRZcHjYgigk+rDOmmDSjocassUhSp3fxcQCmuogVGshI88o1qcQ1M3T6+Ta?=
 =?us-ascii?Q?KVq01983bkh4o86uhrEorKHKSfqlig1SDbq6e/jnJoPzq9z3bMZnd8KNpD6Y?=
 =?us-ascii?Q?qbrYySexobzpL0kJU33yyowMUXHDmv0WBhJdcrQ2IjP7Nqvx77CEr+J3Qg6k?=
 =?us-ascii?Q?vv3DlG8e/atiVD51Z/GPDPlABHanLg65fs1FNqx2BpXcnHlsg+49bRCY/RJA?=
 =?us-ascii?Q?XEPy2f8tBJXkHCwMYOAdh//btwLJRheLn/q4gwKVK/l4MO8kPskJrgnvJtZz?=
 =?us-ascii?Q?Ia+a04nwoMT1Ta6jJwXI74DuxHTkuSfmDKoHoK6pctsDOh0R69WDoHlOsQ/s?=
 =?us-ascii?Q?6js5n/iq1sg7A6W38l6y7yZ0EN/g8fzdrlivv2ckByjZOvsJv+5Df+mbeoxw?=
 =?us-ascii?Q?fFnSiY4VzHBYbOAjd51h8rzoaWNQXvSFfc/Qzd9f+BFPAo8Zb1GrGn6SsKXf?=
 =?us-ascii?Q?dy9MZ3eW0T5phiEN1e+yq/BYUh8gvRD0C/IqiPH5lbblICWEQ/PZvMTFxbZ7?=
 =?us-ascii?Q?kX5CEKRBAtKuEhQMAhs2DYVX2/40w/KdJZSojS0yUPWDNhAoNuLAvGu8AGZ7?=
 =?us-ascii?Q?841MkiDoQdu/dV+6KnZaKfmxh7U+SXTgZvldletqTCyYoV7tVK448cxKsZWx?=
 =?us-ascii?Q?OdlpQ1U1PKQNpHakF6FC0WTndJsHy8Xzv3PTnQeL8vm93rMinN5h8Jgbcr4s?=
 =?us-ascii?Q?ztpTcdIAi7iE9wbHGvHnFOE6Rxo77yY242n/4ZbllNuzSsIFi7pjGc1/iSGF?=
 =?us-ascii?Q?jAPcGjTjHQDa2AcbE0zN1ZncK0zla6JAcMjmPAI/pjVC32nrr84Khu4VmfAO?=
 =?us-ascii?Q?rW4M4dDM9gvRY378h7Tnq99VasqNu67O4s7RB6xqBwlU9iq84MdtdwXUQVAN?=
 =?us-ascii?Q?OPmvN9t8ydPgEKQxdu9ELZSiqZYgv2W2GfKqUz4tyoIrGI5SG0a3LdTRjpQI?=
 =?us-ascii?Q?g/NRf0rxcIuqiX6cQWwzKH41wQd7tuxKNv/WHSZq2O+lP+5e1LEegCEpT0Te?=
 =?us-ascii?Q?2lmDzE6BzxXGOvsxszOqX/I5kWtgfMCxOGsVCy7BQbozkxN72e7vPCiE0pZ1?=
 =?us-ascii?Q?Ymls/DGH5Qgupx2/Cv3yWEkBmVQyc5Wh8KRBERzEOfgUt9qtPLIv+h3s7hDW?=
 =?us-ascii?Q?2JaceR1SdJ08lxLPcm9xwvk/O7XQS87A/ny5FEMCGzMKOCobvn4f6HjY40Kv?=
 =?us-ascii?Q?eADl2Z/+6HXsByHzvI2QwixjjaEjSi3Z+DJBOMlBuvYWKQbN3HP7YKDhBKrh?=
 =?us-ascii?Q?vD94EKhCq4TN5xySHQ9/PB6nBMHSWvU8fEzdKkUALI6Gw5OiyfK+0/ILgqqV?=
 =?us-ascii?Q?ArDTKIyScyBkHDrWAM5e7uq2cZGYz7LnkZPSWOMUaf3b1uYS5cum3afwKhUl?=
 =?us-ascii?Q?SDNBZN4pHg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NkoGH8BlWyRFlLav+UQ6wnrz2kjUVak5EYXteEP1hKwmXJz1dcjq+K1pcG+xKdxxdwBcnZ8klECe9E7L7/vfpOI7jb+n+Lm+jGDC8WJe9B8F+AVryBG2LubniIp4QfYY14bIwn9KRjLEXjZ8dFfFzO+2d5RRpAg6VBicpasee4h4ZsI7VMWGAjkpx/Kvxvxp+hjlq9Vrs+TCQyQkDeZtcC6QHMs05VjL8RUgl/x2vWC4ddRbZr03SgebEbvxy9gH/xGreY05hWom4wurxggI0URrgn/m/70oRoNwYF/lmnjH6EJD+VshvGxy2rN2yqv3l7u5sirwD9+yes2PloYaUw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6219.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d96c8b-3300-4425-5786-08dec31cf05c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 16:10:19.0715 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VcyUKC0lB4/KKmXXuQlma8cFP9/Q9X61PZ7wVd7cXKtIr0KLkuD2rq+Iz3o0FK2xQfrvEybfaGUm4Yl2GKXzzuxdmhweG3ddphoSptZ0gso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6816
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780675840; x=1812211840;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VNrIPcXCfKpUijuYexDLmTqyZTsFyIJao/m3JdiwbAA=;
 b=Cx+KhmxfHXdXSfhwCAGVbqagl5plzqPzEfatS8Or/HoW+7NBHeFYObB0
 VA61fEzFgqY/rauPzZ+/cuUQlbjc9+f7H3BganbLzO8JPHEgN1qEl4qss
 tV77hOqN2FR0pZNX6bLf/JRbRzZw+Azkgqn1dAkJVYR03P7uVLoRxAiUm
 PDyGn2/e4qV4OmEDD769YhU0I4dbAsMNxcoq8QWKjWLoaP1HDct6G4e6r
 6nsR4HKGBHiH9qG4/aUD5jCokRSe/N5zvqUNiv+qx/+h/RXIfU12hN8re
 8eB3aYD52cRk4vbVV1rwzxONCkOHPi8x9Holy/8jSUoDs/mVqxSXNfUVt
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Cx+Khmxf
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH v12 net-next 0/8] dpll/ice: Add
 generic DPLL type and full TX reference clock control for E825
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
Cc: "Vecera, Ivan" <ivecera@redhat.com>,
 "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
 "jiri@resnulli.us" <jiri@resnulli.us>,
 "edumazet@google.com" <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>,
 "Prathosh.Satish@microchip.com" <Prathosh.Satish@microchip.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "horms@kernel.org" <horms@kernel.org>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>


> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Friday, June 5, 2026 12:54 AM
> To: Nitka, Grzegorz <grzegorz.nitka@intel.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; intel-wired-
> lan@lists.osuosl.org; Oros, Petr <poros@redhat.com>;
> richardcochran@gmail.com; andrew+netdev@lunn.ch; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Prathosh.Satish@microchip.com; Vecera,
> Ivan <ivecera@redhat.com>; jiri@resnulli.us; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>; vadim.fedorenko@linux.dev;
> donald.hunter@gmail.com; horms@kernel.org; pabeni@redhat.com;
> davem@davemloft.net; edumazet@google.com
> Subject: Re: [PATCH v12 net-next 0/8] dpll/ice: Add generic DPLL type and=
 full
> TX reference clock control for E825
>=20
> On Thu, 4 Jun 2026 20:05:54 +0000 Nitka, Grzegorz wrote:
> > > On Fri, 29 May 2026 16:26:20 +0200 Grzegorz Nitka wrote:
> > > > NOTE: This series is intentionally submitted on net-next (not
> > > > intel-wired-lan) as early feedback of DPLL subsystem changes is
> > > > welcomed. In the past possible approaches were discussed in [1].
> > >
> > > I dug into 3 of the issues reported by Claude here and I think all
> > > are really preexisting. But I don't see why we wouldn't fix those
> > > first, and have a clean AI scan. Please send the fixes ASAP if you
> > > have them, if they are trivial they may make it for tomorrow's PR.
> >
> > Thanks for your feedback.
> > I'm not sure if I can identify exact 3 issues you mentioned above.
> > I see couple pre-existing issues reported in
> > https://sashiko.dev/#/patchset/20260529142628.1678955-1-
> grzegorz.nitka%40intel.com
> >   - 3 issues reported in [PATCH v12 net-next 3/8] dpll: extend pin noti=
fier
> with notification source ID
> >   - 2 issues reported in [PATCH v12 net-next 5/8] ice: introduce TXC DP=
LL
> device and TX ref clock pin framework for E825
> >     The first one is false positive in my opinion.
> >
> > Did you mean those from patch 3/8?
> > It should be rather simple ones. Shall I submit it as a part of this se=
ries?
> > Or a new patch/patchset? (against next or net?)
>=20
> Ugh, I think I missed that the caller looks at the ICE_FLAG_DPLL flag.
> So most of the deinit bugs are not actually bugs.
>=20
> You can add the fixes to this series.

Hi Kuba. Just submitted v13.

It includes the following fixes for pre-existing issues:
  - dpll core fixes. Each AI review concern (3) is addressed in separate
    commit. If you think it's better to squash them, let me know (however
    it addresses issues from two different 'old' commits).
    Also, the hint form AI  to use different dpll xa_array (parent not pin)=
 to
    address one of the issues, it simply does not work (WARNING flood obser=
ved,
    more details in patch 3/11)
  - ice driver fix for potential hung on flush_workqueue in error path for =
FW node pins

As you noted, two other pre-existing issues are covered by ICE_FLAG_DPLL.
I left the code as it is for those concerns.
There is one more pre-existing one, related to ice_ptp_link_change. As the =
fix seems to be
rather simple one, I believe I need more time for more comprehensive testin=
g.
So my preference is to go with standard fix-path on 'net'.

Regards

Grzegorz
