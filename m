Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F264C531D2
	for <intel-wired-lan@archiver.kernel.org>; Thu, 23 Jul 2026 14:00:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 05E13409B2;
	Thu, 23 Jul 2026 14:00:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nH1rVaKxUtsP; Thu, 23 Jul 2026 14:00:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2CDC940939
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784815218;
	bh=2pSC0u+ux3tSNdiwwvu2/I3pdkh33L7MefpYnVnKz8A=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=pdBJzl2H9f4EfFPECKeu8ecsjwWQ8/ysnWKHnTQk5/78dKBmDM0SaVNs1t98JqR49
	 B0daF1OT/B/gGBl2ZO/WMFGP90YkgzHQKOewPp6Tvjm8h8JFAkl1lypB8JWWWi02T7
	 1BI81ejeM+X2rF6Yyaa88FLHsHj+HMT8tKINOSjJdX4dWJ84gyEZ+ivv1luPc9Ta1Z
	 7S1ubUjcJwLxh76ubrgjzsgY4KAnXfAD+Z8lzZzpOZ++3Am9qHke65KkRY6HREvwb7
	 4WtHlb9j/Tmts7fS+aCFpNw2YOs2f+MDWEWISmEQVswVlON4Qjag6gC/TO6GhwzPMg
	 r/8MwJ5tREI1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2CDC940939;
	Thu, 23 Jul 2026 14:00:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 004BF490
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 07:53:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA3A04007C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 07:53:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jkdSZ7eIzIqf for <intel-wired-lan@lists.osuosl.org>;
 Thu, 23 Jul 2026 07:53:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=52.101.66.9;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=janne.huttunen@nokia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9C10B40026
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9C10B40026
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012009.outbound.protection.outlook.com [52.101.66.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9C10B40026
 for <intel-wired-lan@osuosl.org>; Thu, 23 Jul 2026 07:53:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGepZhfd3tRRFnJVmZ9LzBTy6Y6jXjHJbfZkcqHerYHPpoHLNfnWX1/rxnfpLzNKYdeDZ67gRsUGdRwmGTV1JjpHvst12ZtlbUXNxPT+a+IBuxChWEnf0w1AnvdkrACWCT/LkWCNxbeE16NM880J8LkML/pR36WwPZkrzKzUN32DNAMSd3QG5yvGsEGqmH6Vx4yobDDYpIiS0ger8A2gSfIg+tFWYT6uqeL9Zl/zbnPb9iaEqNYJJqdhFAsD5RmwfJBmkbmryXPqxa+7FB9KuPzw6doZkfcZ5yjvoNWy9zR2ZRslywawQ7s3Wg98io62nANQ8rl1YawTeuEviTRngw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pSC0u+ux3tSNdiwwvu2/I3pdkh33L7MefpYnVnKz8A=;
 b=laE5cOsG9POu48iMI50BfHooM7NYcD5LjwsRUgXUAC0eDUX7o3VAl9gYCUwEhlyTiGzgQCpEoPJmaT2KlCIHGIEC5qfBxyJPGlwfywroXh/j+YQuM/JXP93QqJU5WJ8a8x2fqxktwnt2HGq6uG/gIIthJAREkAT0fqaiX3B7rw32aJHt5qQhNrDS6cSc5qU5pS9cGUYkfmpmjCw+WlhIoOgv0CZLIfNKbY5V516DGCVVTIuodvXgtf2CnwQ0zolygwUzo1Jpl9wB1sjDNfoGvgVUekv+jplqOr6NRf3KvTFcbvO4O66DRLvA7helEvZHMgn9VbKsnYrXURqXR6IZdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
Received: from PAWPR07MB10071.eurprd07.prod.outlook.com
 (2603:10a6:102:382::17) by OSKPR07MB10302.eurprd07.prod.outlook.com
 (2603:10a6:e10:9b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.6; Thu, 23 Jul
 2026 07:53:09 +0000
Received: from PAWPR07MB10071.eurprd07.prod.outlook.com
 ([fe80::1dcd:8631:dd7c:f813]) by PAWPR07MB10071.eurprd07.prod.outlook.com
 ([fe80::1dcd:8631:dd7c:f813%6]) with mapi id 15.21.0270.004; Thu, 23 Jul 2026
 07:53:09 +0000
To: "intel-wired-lan@osuosl.org" <intel-wired-lan@osuosl.org>
Thread-Topic: Reproducible TCP stream corruption with E810 & Linux 6.18.y
Thread-Index: AQHdGnYaH/p5vxMg4kWVbGYcLY+W5A==
Date: Thu, 23 Jul 2026 07:53:09 +0000
Message-ID: <PAWPR07MB10071C01952C1B518326A960C9AC02@PAWPR07MB10071.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR07MB10071:EE_|OSKPR07MB10302:EE_
x-ms-office365-filtering-correlation-id: 938a8784-03f3-45d4-b367-08dee88f7086
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|38070700021|56012099006|10067099003|18002099003|6133799003|11063799006;
x-microsoft-antispam-message-info: l0uclWJonqhHjaWdz5K7XAAMBtT4eCazQqsUb0g48JSRTM1pyIK1gXzMCPuXijhtqGi8ymHvCyZKlZBBHrJPqYp3sqK4VxsSrsw2L5+cisyMIqZfNiiKBAqUOD9EoIk9aK5BFs8/hr6oWTncZpxlsp7Bx4Og4gQ/ja8Y/8acYZIGlA9tXkV+3SmhnPakicIoNGPWo6/xYE74BjoH7O5Z6JKT6lSXWd5Zji5msCv8sz2XBmYoyRrFkrJ8VrCHdW78GJm+i19n8v1KANa+khiDDyDaywLHNBtuLXVRz1Kzur3cScfoo96vY3H903rb8+sFVVJfYS9wLCxiqZJDRZKDBnWOWyEfCLjAtWtUH5xN3e2uh9xSHm74MRZF+XWzODMKnkPx4SoZE6nZO3nzUmPfLtEr280DX/hlat323oTq/h+vuDg/wLeIBLlX144+GPTTiBtfrRYFciU8a082Ct4gSSTgtbSl08WLQV8L66LDWmKkdgNJb6lL3xYjCgkddgVzIYVFb/g53RWnzicl2znyY8S+eZJrCI6CudS1Kc5DWeFQyq1dIOFSdhUJkhNve4/R9POFMLsrm/QLNSOGAloxkP44Kr4IFm/M3YEOoMyNmivNtsAamm3mBj8x5qve0bYEynz1Atk4/d6YaVsQCstVzmBFyZH6NDU/7IB/HO/bLuD0La/Ky6Yev4LPMyVqD+V72N3EWk3UPuMa/zJquaeofG1zRP3/jRUqSJoKUSB54nE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAWPR07MB10071.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(56012099006)(10067099003)(18002099003)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LF7BNQe0CFY3L3WCAl3YViHNxWseTLZKjdn2QEeaBgC5PHh53TgPQWvUvJ?=
 =?iso-8859-1?Q?eKBCcXgmZnan7enPKapfYu5+iHT8sGikPQ4EyZmWQwFioEGMVBbYle3UWt?=
 =?iso-8859-1?Q?kDNkTt67TwBrnW9iNgm0dXHP4xHYnISzoAibr+4imJWKOkIIdXi+/kcMkU?=
 =?iso-8859-1?Q?hmuaSz1cb4DVJIe42ITMThOsyTAHvmySLKYLQw7vdKETpbRxFEmE+FnLPX?=
 =?iso-8859-1?Q?vOX1/ABjv30mOuPeYtrxz9JugTGHzHwMjHqwyDFPZSq4D61AmwUOma0zpP?=
 =?iso-8859-1?Q?JgAjf/A7ecQJfmDogngIaHWYwNyJANo+NsXXxX6wJVIOwiOIWtHYaftnHz?=
 =?iso-8859-1?Q?KlKrt4C/8LAUAZDSEl3tow+31EoN05D2qZ/xQayV0wdwDSbPSyZcIGSoa+?=
 =?iso-8859-1?Q?Tdeo5NL0eBOP9TsP3VU8LNTLSW2DJkufkuuJhMXzeJ4GOAwuZyfxDBpbFC?=
 =?iso-8859-1?Q?1b49BrKgXiPcrrJhLyYkX13y5zuul4HEc5EMQUsHkjYwoTFwjvN1t+NaCg?=
 =?iso-8859-1?Q?oikJG8QRA7rwY3j8iJPN1eX16iqoi6J6waAd/prYsmCy33jPsdL5QDQ5cA?=
 =?iso-8859-1?Q?77zciB0g52r0jVMWbrX7DuLe7hqzVKOtddoKzi0hywxAOcTzYLyt8GhrqS?=
 =?iso-8859-1?Q?AkhCD0pYvK//0nH2UXnpt3jmhvlrCZytuPLkobKJEqXoY7aWZNIc5QTBIy?=
 =?iso-8859-1?Q?nfvRaJKsK8ivwsc1vFbB1FzChN73hl7SiVVerpyU6M6RCpkxjsq2v9fDVN?=
 =?iso-8859-1?Q?bnYkZhWsggJ7f6pHS1tJ8iAxv+G49m7MaYLQBgEoF6oHyUQDjZYUdbD1/J?=
 =?iso-8859-1?Q?EA14bZkYcE68owW+HEOu7Mpi6C3PN8Ni5FC2vI7uLB6fy4m8J2A8Lmq+FC?=
 =?iso-8859-1?Q?6CdxaWUJ9MzVBSv9Tjws/+Oui3hf9EZ/I4QtfobLNZkpJKJGddHakw1tKB?=
 =?iso-8859-1?Q?kRg8vjh3E+Rn2b31v2bzq9G4W7l+xxP/N+2BW8vtNttr4cq8+jggIm1Scn?=
 =?iso-8859-1?Q?WMOBortp2y9Q2FGiYOf8NFN2S+3P4Wlsc6jv+bA2XJKsnEB2+K+t3Zlldv?=
 =?iso-8859-1?Q?iyE//RB6T8FooTdARiBVIOj3q0MbuYZ8y7WHUKV3utFee9rJ2/KDV3fd+N?=
 =?iso-8859-1?Q?Tssz5wrIJ0+LUzA6SDx+InUi9E0+S0mRKYjulTkzYypNmz6Ls98v+8yQPf?=
 =?iso-8859-1?Q?wqDSwfY9ygtFUbbia2/ExZR09wSaTfviU+606ABQWyGIQkNZtGWI7+SLjG?=
 =?iso-8859-1?Q?oEJFuqbQ2CxHtW5jLm2noFKeNaBkO3XQSS6ri2vkppaPQYoPMee5RrXJtc?=
 =?iso-8859-1?Q?mMiTn4Mp5Cl5NtnlLkFZaHQHXBkvvRBPdeLiT94tydfr5xd+5Ea/IgFmkT?=
 =?iso-8859-1?Q?T44C8CVV+NB9PDIgowfSpLXZ4vHopXjtAhqKuh7N8WXIaAJkui2SX8j+/b?=
 =?iso-8859-1?Q?lGKla7HBh8QjGHNToAAjsYIDAYX+Dm5neShPcZOOSk335gVeP/0J6TCWaU?=
 =?iso-8859-1?Q?87lG4PCJ/qk4lhWwz39GYhUEKurdGPtHpCueZZMTgjDnqlG2Qf0q0KlL0Y?=
 =?iso-8859-1?Q?3iLFJHvw4RxQfHvMr7Li9s239+5FZgZMrXYmtbdN3IGd0nXiFdcrCT0VJD?=
 =?iso-8859-1?Q?iUMyPiG/EhPQ2wuLd3/Jr03a619ldZtDyTVOTNp3zfxYCg1BiNLaaYDhQB?=
 =?iso-8859-1?Q?wTPa4kMqC9CoRu535+3C9nUEF1xxUNkqBk2hny05dfB3gXsAM2jMJsTdf5?=
 =?iso-8859-1?Q?ij0DlvsTUsroZEGz98BG23/xcuH/058ABwiM5Ku1IRN8on8xjwiSDBdc4C?=
 =?iso-8859-1?Q?h6fmRUscwQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB10071.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 938a8784-03f3-45d4-b367-08dee88f7086
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 07:53:09.8774 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 541FSlSktbnr72O29kdw9H8w9GErCVJU1uvdRG4PNB1Na+l9P3K/sh425jz1RwdxJ/Rw+YOxLDAZRcJ5LLJ3wqu2lwzPjjnqu7pdxnQqb1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR07MB10302
X-Mailman-Approved-At: Thu, 23 Jul 2026 14:00:16 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pSC0u+ux3tSNdiwwvu2/I3pdkh33L7MefpYnVnKz8A=;
 b=d+8lB+stSG5Dzi7onq9JAHqyuF6n/P2m596ZvZdxCxlvTSNXlDMh9mIQYn47qT4THwJyOK5owWGbLNgpPF8ENP+RoFFQJ4G4kuCNTwyChEG6lr5fKXo0oR0x/0AVHjoE3h2fm/Dw3xJUiij8EiVn4sAM0t/qTloaCyx6aqONDwwdQ7XYfRPFCOMEc0U0lyTyL93ZlcgyjIixtX7QjBapZ52RrL9a4jRtpcZY+T7TwSTt3i1JaLQEXKD7LUQcCGHAv+rXEMEOj+UcmDiQl0a8zbuEzlSKV8avBrATIWnXgbIX5hG29wWzSEKpHUupDjzGgfTaB0HwkMCwiY8rkCG3dA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=nokia.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=d+8lB+st
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Subject: [Intel-wired-lan] Reproducible TCP stream corruption with E810 &
 Linux 6.18.y
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
From: "Janne Huttunen \(Nokia\) via Intel-wired-lan"
 <intel-wired-lan@osuosl.org>
Reply-To: "Janne Huttunen \(Nokia\)" <janne.huttunen@nokia.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

With heavy traffic, we have observed received TCP streams randomly=0A=
containing incorrect data in the middle. Generally the length of the=0A=
data does not change, a block of correct data just gets replaced with=0A=
incorrect data. In many instances the incorrect data has been=0A=
identified to belong to the same TCP stream but at much later offset.=0A=
It is unknown whether the data would have appeared also in the correct=0A=
position because the corruption was detected by the application and=0A=
the transfer terminated before it received that part of the stream.=0A=
The problem is not difficult to reproduce, takes usually a few minutes=0A=
of heavy traffic, and some real world traffic patterns seem to=0A=
reproduce the corruption with very high probability.=0A=
=0A=
=0A=
Hardware:=0A=
=0A=
Intel Xeon x86-64 server=0A=
Dual port E810-XXV for SFP (rev 02)   8086:159b (Subsystem: 8086:0005)=0A=
firmware-version: 4.90 0x80020f00 1.3863.0=0A=
ICE OS Default Package version 1.3.41.0=0A=
=0A=
=0A=
Software:=0A=
=0A=
Linux kernel 6.18.y with the in-tree 'ice' driver.=0A=
(testing described below done with patched 6.18.36)=0A=
=0A=
=0A=
Configuration:=0A=
=0A=
Two ports of E810 in 802.3ad bond, a tagged VLAN on top=0A=
MTU 9000=0A=
IPv4=0A=
=0A=
=0A=
Potential root causes, from simplest to most likely:=0A=
=0A=
=0A=
1. ice_clean_rx_irq() may call ice_put_rx_mbuf() without calling=0A=
   ice_get_pgcnts()=0A=
=0A=
This is very unlikely to happen in real use and probably won't cause=0A=
any bad effects even then, but feels unintended and maybe it still=0A=
should be something like this:=0A=
=0A=
 			xdp_prepare_buff(xdp, hard_start, offset, size, !!offset);=0A=
 			xdp_buff_clear_frags_flag(xdp);=0A=
 		} else if (ice_add_xdp_frag(rx_ring, xdp, rx_buf, size)) {=0A=
+			ice_get_pgcnts(rx_ring, ntc);=0A=
 			ice_put_rx_mbuf(rx_ring, xdp, ntc, ICE_XDP_CONSUMED);=0A=
 			break;=0A=
 		}=0A=
=0A=
=0A=
2. ice_get_rx_buf() does not adjust the pagecnt_bias for size 0 buffers=0A=
   but ice_clean_rx_irq() may still enqueue them=0A=
=0A=
Interestingly such buffers are skipped in ice_add_xdp_frag(), but not=0A=
if the descriptor is the first fragment of the frame. I haven't actually=0A=
traced whether this really causes the reference count to get corrupted,=0A=
but at least it feels suspicious to me. If zero length descriptors can=0A=
happen in the start of a frame, maybe something like this would be=0A=
appropriate:=0A=
=0A=
 		if (!xdp->data) {=0A=
 			void *hard_start;=0A=
 =0A=
+			if (unlikely(!size)) {=0A=
+				if (!ice_is_non_eop(rx_ring, rx_desc)) {=0A=
+					ice_get_pgcnts(rx_ring, ntc);=0A=
+					ice_put_rx_mbuf(rx_ring, xdp, ntc, ICE_XDP_CONSUMED);=0A=
+				}=0A=
+				continue;=0A=
+			}=0A=
+=0A=
 			hard_start =3D page_address(rx_buf->page) + rx_buf->page_offset -=0A=
 				     offset;=0A=
 			xdp_prepare_buff(xdp, hard_start, offset, size, !!offset);=0A=
=0A=
Since I don't even know if there can be zero length descriptors in here,=0A=
I'm not sure if the "unlikely" is really warranted or not. Also, I'm not=0A=
sure if doing the ice_put_rx_mbuf() here is appropriate or not, but I=0A=
just assumed that this might be the last round of the loop in which case=0A=
it might be nice to have the buffer properly dropped. This change also=0A=
means that such zero byte frames are not given to the XDP program either.=
=0A=
I have no idea if that is good or not (we don't currently have such=0A=
a thing).=0A=
=0A=
=0A=
3. zero size descriptors break the page flip logic=0A=
=0A=
The condition in ice_can_reuse_rx_page() is this:=0A=
=0A=
	/* if we are only owner of page we can reuse it */=0A=
	if (unlikely(rx_buf->pgcnt - pagecnt_bias > 1))=0A=
		return false;=0A=
=0A=
My understanding of this is that normally the difference of 0 means=0A=
there is a reference counting bug, difference of 1 means the other half=0A=
of the page is free and any higher difference means the other half is=0A=
still in use, so looks correct.=0A=
=0A=
However, since ice_get_rx_buf() does NOT adjust the bias for zero=0A=
size buffers, the differences now have alternate meaning. Now=0A=
a difference of 0 means that both halves are free and any difference =0A=
of 1 or higher means that the CURRENT half is free (assuming it wasn't=0A=
enqueued anywhere) while the other half is still in use.=0A=
=0A=
This means that flipping the page on zero size descriptors with the=0A=
current logic is very wrong and highly likely the root cause for the=0A=
observed corruption. Fixing this probably requires tracking somehow=0A=
if the bias was adjusted or not (or first decremented and later=0A=
incremented back) and NOT switching the half if it wasn't. One=0A=
possibility below, but obviously there are lots of ways of thinking=0A=
about this and I don't claim this is necessarily the best idea, just=0A=
to illustrate what I am talking about:=0A=
=0A=
 	unsigned int page_offset;=0A=
 	unsigned int pgcnt;=0A=
 	unsigned int pagecnt_bias;=0A=
+#define ICE_RX_BUF_IN_USE	BIT(0)=0A=
+	u8 flags;=0A=
 };=0A=
 =0A=
 struct ice_q_stats {=0A=
=0A=
=0A=
=0A=
 	struct ice_rx_buf *rx_buf;=0A=
 =0A=
 	rx_buf =3D &rx_ring->rx_buf[ntc];=0A=
+	rx_buf->flags =3D 0;=0A=
 	prefetchw(rx_buf->page);=0A=
 =0A=
 	if (!size)=0A=
=0A=
=0A=
=0A=
 =0A=
 	/* We have pulled a buffer for use, so decrement pagecnt_bias */=0A=
 	rx_buf->pagecnt_bias--;=0A=
+	rx_buf->flags |=3D ICE_RX_BUF_IN_USE;=0A=
 =0A=
 	return rx_buf;=0A=
 }=0A=
=0A=
=0A=
=0A=
 		 * as-is=0A=
 		 */=0A=
 		rx_buf->pagecnt_bias++;=0A=
+		rx_buf->flags &=3D ~ICE_RX_BUF_IN_USE;=0A=
 	}=0A=
 =0A=
 	if (unlikely(xdp_buff_has_frags(xdp))) {=0A=
=0A=
=0A=
=0A=
 		 * To do this, only adjust pagecnt_bias for fragments up to=0A=
 		 * the total remaining after the XDP program has run.=0A=
 		 */=0A=
-		if (verdict !=3D ICE_XDP_CONSUMED)=0A=
-			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);=0A=
-		else if (i++ <=3D xdp_frags)=0A=
-			buf->pagecnt_bias++;=0A=
+		if (buf->flags & ICE_RX_BUF_IN_USE) {=0A=
+			if (verdict !=3D ICE_XDP_CONSUMED)=0A=
+				ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);=0A=
+			else if (i++ <=3D xdp_frags)=0A=
+				buf->pagecnt_bias++;=0A=
+		}=0A=
 =0A=
 		ice_put_rx_buf(rx_ring, buf);=0A=
 	}=0A=
=0A=
=0A=
I guess this would also open a chance of small optimization in=0A=
ice_can_reuse_rx_page(), where the (unflipped) page should always=0A=
be reusable if the descriptor size was zero. That change was not=0A=
included in my testing because I didn't think of it until only=0A=
after I had already started the test.=0A=
=0A=
One other question I got while looking at this is that in=0A=
ice_reuse_rx_page(), is it ever possible that old_buf and new_buf=0A=
are actually the same (probably not)? It was not trivial to see it,=0A=
but if it somehow is possible, then doing this afterwards feels=0A=
wrong:=0A=
=0A=
	/* clear contents of buffer_info */=0A=
	rx_buf->page =3D NULL;=0A=
=0A=
=0A=
Anyways, I have now run almost two days of heavy TCP traffic (with=0A=
over 450 TB of data) with the changes shown above in the driver and=0A=
no corruption has been detected. Like mentioned, without the driver=0A=
changes it takes less then 10 minutes to break. While I'm not a Linux=0A=
Ethernet driver expert, far from it, this suggests that while I may=0A=
have missed some detail or implemented something incorrectly, the=0A=
theory itself about the root cause of the TCP corruption may have=0A=
some merit.=0A=
=0A=
While there are some differences in the driver, at least some of this=0A=
looks like it may be applicable also to older Linux LTS branches.=0A=
At least a quick test with 6.12.y shows very similar corruption=0A=
appearing there too. In the latest 7.x mainline 'ice' driver the=0A=
whole bias and page flip logic seems to be gone, so none of this=0A=
directly applies there.=0A=
