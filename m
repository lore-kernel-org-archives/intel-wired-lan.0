Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5493AC531CB
	for <intel-wired-lan@archiver.kernel.org>; Thu, 23 Jul 2026 09:20:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 104D46077B;
	Thu, 23 Jul 2026 09:20:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i1JnoQVrx_Tb; Thu, 23 Jul 2026 09:20:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 81B666075B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784798436;
	bh=1G3AKrUTegqTEnb9c9m7RjTrQ3/oqu0mUCd0oT0K7eM=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TNzg9wRLcpIQpVAWtjsaYQqmjON/bZW3CIIy152daeW9QiY6qHE/EAflVzzZOSe6o
	 7RX+8ovUFfZNS4/xPAlyy4ewvZufPF7o5sdird4IHjimwQ+gPJBeFoXSeSC7rPi4+9
	 VW9w4X/DC2oVgouK9fV6lHsyduIO3kRxeWo2yhEBeZl4Lu2MNf/tye0HhQrVhdu6GX
	 qHHgPzsTtuUoTsVou82NdKOZQ0WyKqQ7lpzustAbX51vNlT8BsNlWDyLCMXdMFpZW2
	 VFU2FKTN/sstFwfM8D9OFeK8j2mcIkq48IKSL9IB3h9e+r6h2qJEIHWfrmEDnkj8eV
	 O6Sa8nx4r00SA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81B666075B;
	Thu, 23 Jul 2026 09:20:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D039347
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 09:20:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 89A896075B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 09:20:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KMKUcPAmm5i5 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 23 Jul 2026 09:20:34 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 850E26071E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 850E26071E
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 850E26071E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 09:20:34 +0000 (UTC)
X-CSE-ConnectionGUID: Fbt8lBJhQV+jnFmklPn4Ig==
X-CSE-MsgGUID: 5GDz6I4fTHmhkrE/u10vUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="84575715"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="84575715"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 02:20:33 -0700
X-CSE-ConnectionGUID: eDrcndPcSduxE70loD1mKg==
X-CSE-MsgGUID: mgDocBV+QlmAoTfiKUWrJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="256558455"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 02:20:33 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 02:20:32 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 02:20:32 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.36)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 02:20:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WaVofk9lEX7yTYo4kWNHypQhX7/PuikhdC1FqLbMD1JLqVTs6oeRplSJiFJyXRAsnfd4rUKdV90nn3flWN8K3BtHgunBAo50z1LYo7CrlXGpAvktTOhzGHUdplAA7iXnv/z22bmTqj4isnmNPpk0F9WBgvY6BA8LyaA2jsEmTDyZbbhC8woc3MpA4FR83woB+jJ4jZPlJd81WHVz+7cwt/L5t56W+pgPD3Ux0Ki3FJZWEhj+LrkgQLhJ0y5wWToA3dcKcSJKh9hBVuEhkwpWWT/JtcPK5mFOF+MNyz3bWz4cSRD5CLYUPtpDhCWuN8UkEbB/FySGccucMRT8OfAfbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1G3AKrUTegqTEnb9c9m7RjTrQ3/oqu0mUCd0oT0K7eM=;
 b=RPa9/t21HeFYYkKrYu9Dh+GpFgq2Dj2TLlfkOWmDOAeIG2ilq1Kd1+Z8q0zKRi7h1z7DkKhi/+KBceFxwGIkUQ8CYQLF05x4238thtjWI9+84lSt4bM8IHGMeH2et/yI+xmrrnBH1jIBkka56ov3MKRl8l6w+Tq7w9CqnrtJECzszkKuENrHl+mzf7vTAID1+g4dEQf+MTk2vLo+ZLrilYB3nBR+9KnLgPqwRvZu1HZD3GoQfcTx8RXRPbmdZbMcAKwhxm23XnJYrBcSHKWyWq8VAtzgqX83Wz3covWbbAeBh8HhN96seQTLOMqjqAX12eZJI+46Oo9naNmI9vSIag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA1PR11MB9633.namprd11.prod.outlook.com (2603:10b6:806:4dc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 09:20:25 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0223.017; Thu, 23 Jul 2026
 09:20:25 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Robert Malz <robert.malz@canonical.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, Jesse Brandeburg <jbrandeb@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [Intel-wired-lan] [PATCH iwl v2] ice: acquire NVM lock around
 each flash read
Thread-Index: AQHdFeWeJuCZbMVMeUaU+LgND7OJ7rZ63Q3A
Date: Thu, 23 Jul 2026 09:20:25 +0000
Message-ID: <IA3PR11MB89865C8823A200F8250116C0E5C02@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260717121224.3908963-1-robert.malz@canonical.com>
In-Reply-To: <20260717121224.3908963-1-robert.malz@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA1PR11MB9633:EE_
x-ms-office365-filtering-correlation-id: 936d4582-4472-4591-e648-08dee89ba144
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|10067099003|11063799006|56012099006|3023799007|18002099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info: mtbSyCN0w+Ij3cb2gpNXkySaXF6Dkr6vyM5eCQfJTemSVhWdLL+1ALIRoSTOEcBEeSyL1YfIORmJ5gzRXBBQZidUPLv94jwe5YMZCjpJOHGsNr2mwlClsyi7NGdXIGByE6tbgxq4S59RgpqZwqJ8+PRmRrfYIGlp/KYwo7oDXlMs8pBEu2sG50jZy0QYrIWt8ewrrbHzgptwKZX9CHBOYXU4mesKBapNUmCPEHaq3+wjuAjDKiV7xX5w67e1M7LSYZrVqwopOVYdEdlfY98celH7jw5G8zcHhQ/9QEL/oWqUeqsfxnjv0vkIWVOWEgo+QCeKBGkFXXLWSZU3Sue8aGvHtD7saQAVY/zdim9WRuiooHNbPBG/QZIef80NOzXH36Bln8eL1ZfywWyjyCJ574etR7qoeBynugVFV0ASCyV13ybf3xMhOB/nyEBpQsDrG8a7owOf3ErvjamlZzTLtKdFaVrAkMGwxWrx6AJ6OGsBXiOKva8mVZiEYIZHfkaaq5GxZ8vqjw8/Kvy3UL9LL5QHw/XjNVwjnWUKunDJWxp3WYzXpfqrirMOj9tmDWI0ws9h3zyjkAZpNeZUs/Os2dq9iCrJ7VKmgGc5OACllvT3vxUAVYl4fyx4iqIUCvIj/I209SPUHCPtW1rtlESU5VpAV9SDWHE63E7cfUfBUq/icGS8oSysbWpR4dntpazdyW0R0ea4BTLv46nB8y8pNRILCffcWLvR3/QmhP6q02/U4ThMaVyclTO+HIn+1Sa4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(10067099003)(11063799006)(56012099006)(3023799007)(18002099003)(22082099003)(38070700021)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZOVIZeJHd9Jzm7QORxRgt121Ntk07dA49zXw2f9ql1sG5bMmtafQVt71ZoQ2?=
 =?us-ascii?Q?5e+BJAIGrfJgOisJUC9PEiqjer7RcEYPyRZNQtd51VOLSlyhf1hYfpJ0reke?=
 =?us-ascii?Q?5ybl+3r53DJkNSqD+sWjBAUz8vkewG/RRdr8AgT75XUPmwYYoi0bRTZSHrzi?=
 =?us-ascii?Q?Bz4FrvZ0opzEo4z6+Mw7TMkBICQlIgReCCHlCFpwpEstVR2Vg2u9EOSqQHYM?=
 =?us-ascii?Q?O5zMNSYZQKsDt9+QG2DlaaixYnKRODBF6Tjjo2c9xZPGv60fGUHN5k4QoeGr?=
 =?us-ascii?Q?5xoKjCufWCKGeuc74KvJ1GKOQWp//LbFsC7Avv2KSOO+LrcWOYDQLhddksbX?=
 =?us-ascii?Q?q8coTmEEmJ1Xy8o1R2QDxKQLNF5WOwMQq9U1vARXGnPWlGshjYaDXIT2ImjH?=
 =?us-ascii?Q?oteJuI7ORVDA8AGQdaFz9fJ6tqjtWbvxITCBtF29oj+vtrUBIH0S2gZTOVkI?=
 =?us-ascii?Q?9T+Yd83DIWfsvCRv09JHyPCv/UpMMye6JkAJW3aa7KD+ZwioOplrVRJ7cdC7?=
 =?us-ascii?Q?Kwx+wGZc1F4ElE8iKMC4ZKpEs37ZWpllqrppYhYO2TR1TKAFK1LdNrfOK7qi?=
 =?us-ascii?Q?OSt8p+EZ1gIYmALMiucACUqGUtfdmszk0BlLu3xd43g31Ki+0TmIp4IatzjV?=
 =?us-ascii?Q?WSaFAS0bAmHmuhOZur6YyXvLLbkzaskh9Y8DN4MIlbHMGR81Fh9UUT7sUYpy?=
 =?us-ascii?Q?nazBQ6d7Zo2RwUXv+O+yUwSSNixAsAl7h2JqUzWGgn5sPkyil1rQhJoB+zdb?=
 =?us-ascii?Q?nwJgosGNvmmX9NCkSIM2s/V9IMMRiMwF0E/7CkOXAuDaILQrHF7NBFUPvQyt?=
 =?us-ascii?Q?/x3+PvPWRg8xCpx3goTnKDbj0OIGFqocBuCb/Vv5CrrUhJZRmTcqyEJ+gAxn?=
 =?us-ascii?Q?uiBUvTEpEBPk5QoTkGdQyGuxFSIVxYmNeKs9rvEjlwIh0IPgdxhdEmMF75p+?=
 =?us-ascii?Q?9WobH+qFaIHm6ys5EF1P5/4s6BYn08AbywkcyHsJTNCXEdswwiP2FkIWF+KP?=
 =?us-ascii?Q?x4w2+Y+C0FPQbFJJLtRKmkcs0cZhJxDeTOjG22mibliIyLmwk7Cp60ZC1mXe?=
 =?us-ascii?Q?0PxFrRHiQDEaCx6tYQawVNGhdNNLcLJp6SENfJxdgtTk93eNql0Z/OObKyiI?=
 =?us-ascii?Q?l3FD+PlmocEgFzzWZb/0GoqeKkDj0aXYL7hGmEUizPFnrsudwYXyQcDmuOlY?=
 =?us-ascii?Q?EsK/UwPGhvptnslKAMuxEfm7J23kQ6oQwiHPASPNrbGpn1IaReQlfIRI9kxL?=
 =?us-ascii?Q?86eK08ysxdK7rjEBCWp0gnE7F9Eh1F3P6+8OWNtZe/+8EtU/tMviDq90IlIO?=
 =?us-ascii?Q?vBFHisFwiVc4ggFgXxApfWfqVdF4GM1MFm0nxucqexMMu1VON21fxEMZtueo?=
 =?us-ascii?Q?bs5tnbHktJwzi3TbLGTuPa2CItH1aLUlReUpCJBj3ylqavw8M7AD2KsIBjHm?=
 =?us-ascii?Q?ev04kJNwcKFtJ8M3fIhNrfo6xmVXUZG14G7VquW7cLvpG51KB82d0AGMdDYM?=
 =?us-ascii?Q?6Oj+k31pB6wunibyBGBd7Xo5ihF77qGiDqTR7AtPZg3DAAFtlXwd2dBmWRlq?=
 =?us-ascii?Q?+mzAXio8iEj90tujw709LWNyvW6+sjHS5dt5ipRYn8T5+WuCBJiuYJFQNjbb?=
 =?us-ascii?Q?PUQKyNZAM9dotmqDrSXJGBm4FgcehNVcpEFLWqGzciA8pQ1m490RTyxOHr5O?=
 =?us-ascii?Q?K3MrTUWNnb3vp39WH0LymSgCoOLv0NEe8Q/FfZ6NP+qV7Z31JOryZH9eFYti?=
 =?us-ascii?Q?jIDCxCj4dmr9DK258XeKDkuA+o0KiCs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GVyvTjCE5NEVyhPvVmq2O7h0w1TkApfWc4x72HkMZ9vmM2ix9nH80FPnbTJxwMPbrGmyJEqCcpNI7L6fnS0z80KeNfC7uetvlSksualASliZPxQak2kbme4+zbxx4R+lSlkMsSX28KSrdcVkMSBNV/AJC/jqavbGBS/M3wEh26dwoHs3djiY7mhsLiS5bRs77Y6Gh86aAJoei2QEUnltN2b3i5a63dmjMltTw2XBSrP+3Ur4HlFDp5MCRqSf7es4B8VyWh5fyi2lnOB6vnOe/G9i62qS4RvreCrHUbGwOrpJTFkOD6fooieNmp8pBStuo4EWd2M/O6MRbhJlDcDbJQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 936d4582-4472-4591-e648-08dee89ba144
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 09:20:25.5073 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zGATK2+aMIqOlyUoa6mNaP9NkoDpQVmJKSXrc1YEupKewfZXc7ZR2YOywl2oUhwnZo55cQqqJBQnIGElxbfhGL+y5hBXKqrpjiV6w7wBZSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9633
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784798434; x=1816334434;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Ggs8jor7AVo0P10GFwooWSYQ0rjpYyekOORdRt5Tf/I=;
 b=NQlqJepn8SZY4ibxS0SaRr0waeGxjv20zh4VF6PPnedBhDmCxnktJVZ5
 Mvbke3jIjDNb4hI75RN15uhGjOjQGmBM5nhZ7HcugtxY+QMmx4ufLlcyJ
 EUD4FWSS9pKKbhDPWrdevQOvd3tJybO+Gp6yCFUxXuHtEphrmCac7ZNnS
 wmJMUfB0yiGHGVDmTMqHbTNbZZYO1q0i8PN0FBh+TkJwLKf0/4Dio3gRF
 bBpdS/N6bV9M8TWxOpqN0V7j/Iqo4N7P5AoV4ovHVeskikcOWGJMyYE3V
 78mt8tuJ+oSCRx4MoriwkERI3RItk4gR/amy4XGKeuUKUZbZBVrSL2hon
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=NQlqJepn
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl v2] ice: acquire NVM lock around
 each flash read
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
> Of Robert Malz via Intel-wired-lan
> Sent: Friday, July 17, 2026 2:12 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Jesse Brandeburg <jbrandeb@kernel.org>
> Cc: Robert Malz <robert.malz@canonical.com>; intel-wired-
> lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl v2] ice: acquire NVM lock around
> each flash read
>=20
> FW caps the NVM read lock at a maximum of 3000ms regardless of the
> timeout requested via ice_acquire_nvm(). ice_read_flat_nvm() splits a
> read into multiple ice_aq_read_nvm() commands, one per 4KB sector, all
> issued under a single lock taken by the caller. Reading a large region
> can exceed 3000ms, so FW reclaims the lock mid-read and the remaining
> commands might fail.
>=20
> Move the lock acquire/release into ice_read_flat_nvm() so it brackets
> each individual ice_aq_read_nvm() command, ensuring the lock is never
> held across more than one FW read.
>=20
> ice_release_nvm() issues its own AQ command and overwrites
> hw->adminq.sq_last_status, which some callers inspect after a failed
> read.
> Add an optional read_aq_err output parameter to ice_read_flat_nvm() to
> capture the failing read's AQ error before the release; callers that
> need it (ice_discover_flash_size() and the ethtool/devlink log paths)
> use it instead of sq_last_status, others pass NULL.
>=20
> Callers that previously took the lock around ice_read_flat_nvm(),
> ice_read_sr_word() or ice_read_flash_module() now call them without
> it.
> The now-redundant per-block locking in ice_devlink_nvm_snapshot() is
> dropped.
>=20
> Fixes: e94509906d6b ("ice: create function to read a section of the
> NVM and Shadow RAM")
> Signed-off-by: Robert Malz <robert.malz@canonical.com>
> ---
> v2:
> - Replace the save/restore of sq_last_status across ice_release_nvm(),
>   which could race with a concurrent AdminQ command, with a new
> optional
>   read_aq_err output parameter.
> - Add missing "Return:" kdoc to ice_read_sr_word().
> ---
>  .../net/ethernet/intel/ice/devlink/devlink.c  | 32 ++------
> drivers/net/ethernet/intel/ice/ice_ethtool.c  | 16 +---
>  drivers/net/ethernet/intel/ice/ice_nvm.c      | 76 +++++++++++-------
> -
>  drivers/net/ethernet/intel/ice/ice_nvm.h      |  2 +-
>  4 files changed, 56 insertions(+), 70 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> index 22b7d8e6bd9e..5a1ab9654fb8 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> @@ -1856,6 +1856,7 @@ static int ice_devlink_nvm_snapshot(struct
> devlink *devlink,  {
>  	struct ice_pf *pf =3D devlink_priv(devlink);
>  	struct device *dev =3D ice_pf_to_dev(pf);
> +	enum libie_aq_err read_aq_err =3D LIBIE_AQ_RC_OK;
>  	struct ice_hw *hw =3D &pf->hw;
>  	bool read_shadow_ram;
>  	u8 *nvm_data, *tmp, i;
> @@ -1891,26 +1892,16 @@ static int ice_devlink_nvm_snapshot(struct
> devlink *devlink,
>  	for (i =3D 0; i < num_blks; i++) {
>  		u32 read_sz =3D min_t(u32, ICE_DEVLINK_READ_BLK_SIZE,
> left);
>=20

...

>  int
>  ice_get_pfa_module_tlv(struct ice_hw *hw, u16 *module_tlv, u16
> *module_tlv_len,
>  		       u16 module_type);
> --
> 2.34.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
