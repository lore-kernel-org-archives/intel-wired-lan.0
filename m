Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B34C624D3
	for <intel-wired-lan@archiver.kernel.org>; Wed,  2 Sep 2026 15:10:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C0A760708;
	Wed,  2 Sep 2026 15:10:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nskHgH1mwH4g; Wed,  2 Sep 2026 15:10:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788361838;
	bh=i5IZJR/zF7a72yRa7VV0m72IUVNY7IPdc4YpiVpMYzY=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Cez+VKDRqZfFv6TcVvgjE7FZTvvdAvT+2coulOgUND8/8WY0HrELPiwk2ECJG9bvU
	 rcBSnsoDJvrZbXm5WH8vUMIeLD8Zcaq8EcDfg9JwQ9WaQDf5n3gBFsH4mC1sHzVgpL
	 dwiTSiFDP7HUIMgL4uuNYZ/0DLR2+Ri0pUNl1cmKIsq9JQrXQqyfVTdzmeIiGt0mxm
	 +YtejdWY2dk33Da4ntzFpjoZtIpNM/cpHIkeyIhBBzvIAsdDHoqCrm7hpxTBWZsbeY
	 FlupvvXDS177q2Mg1Czwxt3NPkz8LHf/aCIFz0hNuWfoTssGsmo19YZW36WXvFd6gd
	 xKABm9mMNB7hA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99C11606C4;
	Wed,  2 Sep 2026 15:10:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 47DCA2FE
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 00:52:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 258CB4013D
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 00:52:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4FPsgnN0evGP for <intel-wired-lan@lists.osuosl.org>;
 Wed,  2 Sep 2026 00:52:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=23.103.208.65;
 helo=usg02-bn3-obe.outbound.protection.office365.us;
 envelope-from=jervin@relativityspace.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=relativityspace.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=relativityspace.com header.i=@relativityspace.com
 header.a=rsa-sha256 header.s=selector1 header.b=lQxPjxCx
Received: from USG02-BN3-obe.outbound.protection.office365.us
 (mail-bn3usg02on0065.outbound.protection.office365.us [23.103.208.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 161F040076
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 00:52:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=vUk3t3QlbS7LcO2k0tB0nSypqF+EeYuW+zq5jeGPr7QUnxMz5skrIMJCELwDC86+P9GpDR5Vqw2DQYp/aX7DQmZzDo/FQBhsCKicP3FJKJJUZ53Me3K2GUdVscguO5r5iQuFrdW95kLOKqpWgSs5BQpuCNLCTv16Q1OBprAtAZivRPVfFDxKbhILwUuNYj7S+IivmskD+5V1n70BIOs5olh5xA8p5VnmrRHpH/KFPzV3m/3El4kBRydaNNlt+uuNceIBAir6BcYM1N4m1Gsp4yV4Ujqi++xywt3VLCjpdv1if6PUAvEal9X72o8a1WXtcxlL5BVcpYAWLNLEvZC+Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5IZJR/zF7a72yRa7VV0m72IUVNY7IPdc4YpiVpMYzY=;
 b=iq7g4cEgyjTUZaC1zxOcT8rW+S5uQ6BbccPcRWzmA4VibU4yePDfmhN/19B9MNeTX2wdxNuQb6PwfC/xpt/nBJmU/MWLz1AxmlV9IASDUndhS1STrD3DMeWyps8BBusjZuNIbsHZqHFQ611A42hEfnuFwmOjWhVCk+7ZHmowOSmc1suHRRUa4VxUCHddMEYo0ssTpH77NoR4ZJKI9N58wIFqoWrXoBZ+4hMTL1uYSgeY/QbpzJkb0w1Ql9633EB2VX/NRLMM9M/lM0+TUvHH0VfX1Pld3kRCKk5TxxGavkNCV3FaHoP8zx8xcnd/f87c19XU9mQgAKeB5pNa59pygg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=relativityspace.com; dmarc=pass action=none
 header.from=relativityspace.com; dkim=pass header.d=relativityspace.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=relativityspace.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5IZJR/zF7a72yRa7VV0m72IUVNY7IPdc4YpiVpMYzY=;
 b=lQxPjxCxcjhIfPfFlDJEDi+ay44g5mkhbc0lSXcRT+pCt4CvLN8K9rGM/el7Z6sqrC59bN7C6u+tZAu7RhKGD8Tt+HmEwnC0Y5/0bHgQbx3dOpnO3b/pHZxr1HK1htIl0m+Jm/wiOcFDdGlbBGzn+VXUj0Z3Z7UXMPgiWk4Vryg=
Received: from BN2P110MB1042.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:16a::9)
 by BN0P110MB2090.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:1a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 00:52:20 +0000
Received: from BN2P110MB1042.NAMP110.PROD.OUTLOOK.COM
 ([fe80::e1d2:23d4:c7b0:5734]) by BN2P110MB1042.NAMP110.PROD.OUTLOOK.COM
 ([fe80::e1d2:23d4:c7b0:5734%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 00:52:20 +0000
From: Josh Ervin <jervin@relativityspace.com>
To: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "nthony.l.nguyen@intel.com" <nthony.l.nguyen@intel.com>,
 "przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
 "sasha.neftin@intel.com" <sasha.neftin@intel.com>, "kbowling@FreeBSD.org"
 <kbowling@FreeBSD.org>
Subject: [RFC] igc: clarify RXERRC and RERC counter semantics
Thread-Topic: [RFC] igc: clarify RXERRC and RERC counter semantics
Thread-Index: AQHdOnTcaBRJv1IBUkO5pAYApxzT0g==
Date: Wed, 2 Sep 2026 00:52:19 +0000
Message-ID: <BN2P110MB1042F2B45F5008DDC9F36C50C8B7A@BN2P110MB1042.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_3c71600a-6d1e-47ee-96a5-33d44f8880ef_Enabled=True;
 MSIP_Label_3c71600a-6d1e-47ee-96a5-33d44f8880ef_SiteId=95efb839-1b37-48d6-a201-7187831a1c9c;
 MSIP_Label_3c71600a-6d1e-47ee-96a5-33d44f8880ef_SetDate=2026-09-02T00:52:19.585Z;
 MSIP_Label_3c71600a-6d1e-47ee-96a5-33d44f8880ef_Name=No
 Label; MSIP_Label_3c71600a-6d1e-47ee-96a5-33d44f8880ef_ContentBits=1;
 MSIP_Label_3c71600a-6d1e-47ee-96a5-33d44f8880ef_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=relativityspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN2P110MB1042:EE_|BN0P110MB2090:EE_
x-ms-office365-filtering-correlation-id: 62a7066a-2490-49eb-8260-08df088c7163
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|41320700013|38070700021|10067099003|18002099003|56012099006;
x-microsoft-antispam-message-info: EMXmXyQO9GU/Z7WN+ffSUTlTC8IPl0cyTu5kg/rrneBVrq7X2plq04A5f0/HjsNS3cg9P35hel/9MqnEmSIpieLzULaGKQ7jJa3AxWogRmkRtazE5CuE/QJef/1taiJheSacC7AtXP3Ijas7mRbxGDRSypc/9zDC5vyRLy+O2U2NdUJYUADQkRjU9P5EX4P1lj18fmq03uQ9M3/7g/n/x9ytbxUnspUfKd6Z14V24jDmSt9BEIC4P0pJNW+k8NEdGl0clPtnl1F0ko+5tyB+4V55MLsgglVJmbOz1EMmUFXM1kkx59xskxEHh3ZhDavHEvVcevxiy5JYOubjwFSYPiJ1H4CfIJZjjnu7sTw7CXZziF4KUjfwqZcFpBFKO+EBproEkRTJuSBn7OVfByZTgfZDTOjTUzhPFn+qghQ6oDxTIxWc8FPjtj2L4U2AFqfiw4q8kBh/7wO7h1ELBQ2+eDVLssezZa0bsX1fzegCeAv12ZcPmij0ETJ59aHacAxIUyVmBdeWw+BKP0bfkTt1gnu6+0Zs58Ctd4DHJoCHCB8/pOWiWm68lNqB1g4zgx0OVZn+EK/6LBSzVTmxR7kG2MzwEdu9YbsGbKpajPJ9WxwKb9UrW+xvrRSra4S4j85NZTZhnEMiTlSkVxttBKotHRUTHGC+gW5dCe09iZa6De8WDIvhSq2JRdORYJj5qUMPy442qiMp608aUH92o0T2SJ/pv0KHChsfRD2/qMeCnNc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN2P110MB1042.NAMP110.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(41320700013)(38070700021)(10067099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?J+k0VNyeUtKIEu9smqL5xbPgTn2M+/JnlpbzYC90Ft6N/aZ2CISaGa3XXT?=
 =?iso-8859-1?Q?mQB9kRWqoKSnY+qwXNpAScuKGn9PJ0rtNzfODaZWvt8CrK5mU1nSrQuvIz?=
 =?iso-8859-1?Q?sUuDu/q4XboC32UHuqdlyyjh7HY1D5/AnXjCrVcPb/D56sKm1TXGE802/I?=
 =?iso-8859-1?Q?v8aP1MvI1Mgt3XGikF5kleHjWHvZJ5gqGLuypeJi+B9kPYLEgpQysCanHl?=
 =?iso-8859-1?Q?T98Cg4CkoQ4+wGFPO4WBENGAHefSXsJAA5rNKA2orkEbh86YKv42XG0Sfc?=
 =?iso-8859-1?Q?bLuyyLkW3Pzi5An2Ct8C5YqwcGKy54V2w4XcwOP2Pffu0TzdvUaCFrSbQY?=
 =?iso-8859-1?Q?zFHZJ22CaxthvIMz+qRV0j4PRL+7+UwsRKC/REMVxjb/Reu6uiN3nskufI?=
 =?iso-8859-1?Q?Xw3QSc3fbI3yrACm9mPwdz8M5SeIfEYFVODy8+s/qBoThh3SNOc35fMUne?=
 =?iso-8859-1?Q?scQ3vVqs6Aem66T/QuFqzjSIw9xwZ0DPk9dGJC+/k8t5l+db+0pdVzvi3+?=
 =?iso-8859-1?Q?TvQHBGrO877+2A3IactgVFY/KOePFref+z6mKYJ9K983yfXBlkwi6xX9Pn?=
 =?iso-8859-1?Q?HOB4kHZITRQ51b7cTLycqmBI5DPNqvcW49N6iEOXqkO2mrSS/87r2me7dT?=
 =?iso-8859-1?Q?w0GV8kbgPs8MfGjwf1tiK77m3pciShajFoFT99YV17Lga5c7XMDSVJcko6?=
 =?iso-8859-1?Q?iXEx5G7pxB84kY3zIZ/9v4SlkiszbZ9bW2UZK4gp0HZoZbXv6dHeOLEhHh?=
 =?iso-8859-1?Q?dDuHVp+Bb/x9vLL0+0ro5driCnjMYHqe47vh90A3IwKfVamqklYfmwD7sx?=
 =?iso-8859-1?Q?xr324MH1ZRJ06REEu+nmNxmF1Rs81btTJj+8nMoh/fc2fs3PQ4EhK3Q1HO?=
 =?iso-8859-1?Q?hRghgi0EyG8fuVEkHLArtn2V05KY82baZWTEuNAM5EdhOKV71ixCTCugsn?=
 =?iso-8859-1?Q?9wbvrHXJQOWIyZXZNlSliBoWyHlpfABKJ8kT1JrH8J0x5GPRTnPl/JO0uw?=
 =?iso-8859-1?Q?LILfZIOcax6GxSbyezoRFsQmc7p5vcFJKB5SDeC71rnl1wiZOKnWh/6cbi?=
 =?iso-8859-1?Q?xkhDf8exJYXcP+aoGJDGybqxmLVf+tyWnLPsZ/14+IqWSvY1QejgZ56TnR?=
 =?iso-8859-1?Q?ofIYDn0HmOdxSLhFWqQuV64xpZ6spcsizzHgJr7zCrAikaoESj2LTGMDXy?=
 =?iso-8859-1?Q?ZAWAhovmb5gQMDZh9SIso/7pdChdXBprjTAbq7Pj5Kc9FrYNsOd6Q5I7MP?=
 =?iso-8859-1?Q?2L6PtYqxDO5NfZV+ukRzlBQOwOth+VYSS2EHF6tRUp3I4LvAmbV56ZQJlG?=
 =?iso-8859-1?Q?Rbh+SDP4V/cTqh9NKTZ2ZP3xRPhzbeYXnFLgoI4NotEvagziWJkG/0CBFO?=
 =?iso-8859-1?Q?4x757A1vPDa0eJlMM/qKs5z3exkwhXgLkB2bgIUTmAYFgU7AjiU2PE8kWQ?=
 =?iso-8859-1?Q?gSPoDwuLOJFUCjl/8rj72Sc4JEk35nqJRglPmW3/uFpAAw6YwikdrTux2/?=
 =?iso-8859-1?Q?PDZGCArrNIwo8X5It0mzfblUXepOY3MLAJn8GlM7oitao0P7Y0bkheOCPU?=
 =?iso-8859-1?Q?Wcza680ONyDW8TQn4xB3LChFQ2BC65YOo+7ScWZyj/lHQVd8f19DVUOfwf?=
 =?iso-8859-1?Q?DKUYJIV3/tryb+6qlNtz96C9B9udaXrM/OkUFvuGBSU6K6YA6LIWzMBEKN?=
 =?iso-8859-1?Q?UX8Nk8IyjK5/AmfLgNRUJf3BzPvqIMxjsZT+7PKQQ3whkI0Yw1huvlXcIx?=
 =?iso-8859-1?Q?BWSQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: relativityspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN2P110MB1042.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a7066a-2490-49eb-8260-08df088c7163
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 00:52:20.0407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 95efb839-1b37-48d6-a201-7187831a1c9c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0P110MB2090
X-Mailman-Approved-At: Wed, 02 Sep 2026 15:10:37 +0000
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

Hello!=0A=
=0A=
The current igc driver implementation reports stats.colc as the sum=0A=
of IGC_COLC and IGC_RERC (introduced in 51c657b42f58fcf061dfd6d01df26ff1701=
ae72c).=0A=
=0A=
  adapter->stats.colc +=3D rd32(IGC_COLC);=0A=
  adapter->stats.colc +=3D rd32(IGC_RERC);=0A=
=0A=
This accumulation intutively appears incorrect, as I would not expect=0A=
a receive error counter to be counted as a collision.=0A=
=0A=
Grouping of these registers seems to have been commonplace in other OS's.=
=0A=
Prior to https://cgit.freebsd.org/src/commit/?id=3Da108ee9138a698f212d6d683=
2d54e88ce6786617,=0A=
for example, FreeBSD had grouped colc and rerc under different counters.=0A=
=0A=
However, I am unsure of an exact path forward since the device has multiple=
=0A=
RX error counters. Namely, IGC_RXERRC (0x0400C) and IGC_RERC (0x0402C), bot=
h=0A=
of which contain the description "Receive Error Count - R/clr".=0A=
=0A=
Could someone clarify the hardware semantics of these registers on I225 and=
 I226 devices?=0A=
  - What is the distinction between RXERRC and RERC?=0A=
  - Which receive-error conditions does each register count?=0A=
  - Which other counters, such as CRCERRS, ALGNERRC, RUC, RFC, and ROC,=0A=
    overlap with RXERRC or RERC?=0A=
=0A=
Would we be open to adoption of the accounting recently adopted by FreeBSD?=
=0A=
Namely:=0A=
  - Accumulate RXERRC into stats.rxerrc=0A=
  - Maintain RERC as a separate diagnostic counter=0A=
  - Report collisions from COLC alone.=0A=
  - Keep RERC out of rx_errors because it appears to overlap RXERRC=0A=
=0A=
Cheers,=0A=
Josh Ervin=
