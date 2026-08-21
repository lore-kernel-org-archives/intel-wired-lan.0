Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B3DC5DF7D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 21 Aug 2026 05:01:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 426E68112D;
	Fri, 21 Aug 2026 05:01:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rJV-8raCb34w; Fri, 21 Aug 2026 05:01:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787288499;
	bh=OiWAq3eByuG3SDXY8oLoriXuH7iC363jTyNPc0kCIUI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WvU6Tw3sfvAMj8r1xgbK49E7bF0lJP1IqBEjZ5mZyNwIuldQXbYVoE1zHWmbUfOVN
	 zOgwBoYcUI0b1Wd3pXow7Q7buatZPg4lpgauB2d24zEEkTHLxqyqJfIRSZaej5ircp
	 XtEMLcwPUawJ2G8BiCYsIQhD/Lgc1GoPf1Y2Bmi6xDxMToX1owvAO0MXufZmglS8Gm
	 uPe59xu/B1np4wHHtw2M/sPzeO39qYjxa0SGnbjii93GXMvqqDErD222WisI/9GZV6
	 fItXsnLffPurayWZlzZa2y2QP4k5qKDvBowcdOixOEXXfpbap9wn2Db/rlczy5Cj27
	 A1p6EL3NM5G0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0708B81136;
	Fri, 21 Aug 2026 05:01:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E7543EA3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 05:01:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E4CD94096F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 05:01:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4IhA9--FHm_P for <intel-wired-lan@lists.osuosl.org>;
 Fri, 21 Aug 2026 05:01:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=52.101.169.83;
 helo=beup281cu002.outbound.protection.outlook.com;
 envelope-from=fabrice.hoffmann@ipetronik.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=ipetronik.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ipetronik.com header.i=@ipetronik.com
 header.a=rsa-sha256 header.s=selector2 header.b=Yn6PHzMu
Received: from BEUP281CU002.outbound.protection.outlook.com
 (mail-germanynorthazon11020083.outbound.protection.outlook.com
 [52.101.169.83])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C88754090E
 for <intel-wired-lan@osuosl.org>; Fri, 21 Aug 2026 05:01:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7/m7OULaze2RWqdfT4fG7cwqTYPS9FSAYFhX7gnUu3JYdh7yZeXuyUK/Vqn7XuNcmY4ZGbHsMei/lXzxAgEPyoGiM8qqzw1UC0ik2Wu8cSeN1w4Wh0YnV8ct/brxTkw37S1KszocNXegdxYCm2TxkTVlwRMzz58lszrJd4qUfvOchwoDvjQi7ifEkOKGMx+ypzU5cu4fSlUr/fzEjxLGTTcBqElGVjKIvyyQJx4pwHq9rayR5/REW4Q9qzxDd9VcQDSjgbAaDyMrSmkCYbumyng5EDjdIpjr9RnT0LQxTWcJKWyZP73mfcefbp3DAHkY7WDMobj9cIzQBIcVz6UXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiWAq3eByuG3SDXY8oLoriXuH7iC363jTyNPc0kCIUI=;
 b=HhBHpXZR7ytSdQH0F9PsFxa7+KU+Nm4r0H6CTWry12YXpUpIafT/h9OH/evPLuPAdnVqVozCoc9OchqnzIL2k6Mb2ip00w5z5FgQ+R3OgfY26ACG/jrQ8llhzKL99r4xvAkw3+cyTcw5QpDRLc9xv25qTWP/TrQD3umvOBlZ0E7lKqZoGxMvxmFw6CnwR+LM4j3i+V2P3TPzS8MfIM6vA0bk1Y3ra+8R/2WkcEFtkKVLK6eFH3XPegIdM+e/ANKhweq4V7P9NsnAXLO5cISeEhoWHV3iqn0l/O+6iRzhtznkea5DBdKHQxFn0iYA+3ByLUTxtUqzlLy8K2prihPbPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ipetronik.com; dmarc=pass action=none
 header.from=ipetronik.com; dkim=pass header.d=ipetronik.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ipetronik.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiWAq3eByuG3SDXY8oLoriXuH7iC363jTyNPc0kCIUI=;
 b=Yn6PHzMuFgg+47UdpwuVoVtuqookB3P8d/5YCV+A8A8PBLhnb1+T/PKYUiOjdIBsJRmn2B+u6AZQ2+jvwbIe1a2T+/s9rJdJlemkWGnyN8HRLL9zFFYPcM8pn51WeiHIuCHCs68JP3lAu9uisz4YahGu0uMhskJulkG7hecbhNsiPmlNdyPQRg7v0yeGZbj1xCPNI4zvTsNV1zxPW96MaLyvBPgXA9ZFK5zNRv9Wp2HGBnzJcD5ChAhn5m3h5/lbtliUNlhC7LcicjE45QNQIYmfTjhVM/QO0yHFaY4j6LVL9SUgDAZ1YfqkGvp626kM4gGJIafSw8jAZWCJbuRzbA==
Received: from FRYP281MB3387.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:73::10)
 by FR2P281MB2764.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:3a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 05:01:28 +0000
Received: from FRYP281MB3387.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ceb9:6bd5:f877:fa2]) by FRYP281MB3387.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ceb9:6bd5:f877:fa2%5]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 05:01:27 +0000
From: "Hoffmann, Fabrice" <Fabrice.Hoffmann@ipetronik.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: "intel-wired-lan@osuosl.org" <intel-wired-lan@osuosl.org>
Subject: AW: AW: [BUG] ice: E810-CAM1 custom board - topology/netlist
 resolution fails (EINVAL on all AQ topology commands), no I2C activity on
 GPIO expander bus
Thread-Topic: AW: [BUG] ice: E810-CAM1 custom board - topology/netlist
 resolution fails (EINVAL on all AQ topology commands), no I2C activity on
 GPIO expander bus
Thread-Index: AQHdLmTh4U3ixgbzm0i1idtkA3CMobak8CrKgAEhbgCAAeVx3g==
Date: Fri, 21 Aug 2026 05:01:27 +0000
Message-ID: <FRYP281MB3387893A2A751782987D0CED91A32@FRYP281MB3387.DEUP281.PROD.OUTLOOK.COM>
References: <FRYP281MB3387C2011F156C1D4F36C05291A72@FRYP281MB3387.DEUP281.PROD.OUTLOOK.COM>
 <FRYP281MB3387040C3F87F8D9F0A99C4291A52@FRYP281MB3387.DEUP281.PROD.OUTLOOK.COM>
 <e72bd1d5-9b67-46c6-8ccc-81edd0bb6f8e@intel.com>
In-Reply-To: <e72bd1d5-9b67-46c6-8ccc-81edd0bb6f8e@intel.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ipetronik.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FRYP281MB3387:EE_|FR2P281MB2764:EE_
x-ms-office365-filtering-correlation-id: dff32da1-dc0d-487f-d948-08deff4141e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|4143699003|6133799003|56012099006|3023799007|22082099003|18002099003|8096899003|38070700021;
x-microsoft-antispam-message-info: mze+dUum3oZA5BoW04doNqOs2B4cEp+jJBTYHpYGBtQrJE39vjHFvKGiekJE7xNimRY+4h7Af6pV3kNjBhYVRht8Q4BfObksfDp/Nluacny7wEMU6xt0rcm+jY1mvpO82o73ORoD01y3ZR5mjjsBf2FftcPs24m4S8HJ/zMcB5bAZ0Jnmp0v39dZ3YkEMXoJ7R6W+Z8TT2+sA+JN1ETEbTpASNgXVrZsVJ+riCekWiFWAz0tIKKOkDwiv3QnjAhu6yRBpPYXpQjFXzbcPQ8twnSNJyamiLvF3v9AK60T2EflHVPGRbAZGJcxx4S9NimcLvv45BubL6b4KpkYB2BN2e8wVnf+qs7ja/nMiSYLridrkYEOoMdNd7bnA+6NEBzbWOyrd4OX/qY42fBUNN+42u/1qcl4CEnrZBNjMtT7LAkHp+sEmvWNJjDFPIMb6ZCpvOGmZn49JmlfMBTFvbHYViqP7NiXxR1yaYewIoLPkgI6CQT4dghoWy7KEYWt/jqczIXBRmUls3EE+F2g4A8e36ZtgPC1WBoTYv9LWQTfdq36YTNGL0BAsgdBpjAetIORTOqTrlQJ0WCLY+azYYmaf1poHBXhG9rvWNJOj2Y+tjttcrITmTzzCWLg6sxGOIU0eiFaDnSya/jCHVmtvaq5DkXbW4Yqx/fja6iGAu0CTweCTbeCyPCTqKRtSbKeK4aiZzOXTO4w9shnHcAhlwLKwM9RJ9tAY9GUdw8D2Z9zvSs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:FRYP281MB3387.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(4143699003)(6133799003)(56012099006)(3023799007)(22082099003)(18002099003)(8096899003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?uMx3nkx4fe1aXzPDI2DOI4Q53HMwtBYAOE8qe1pn2+61ZIyMtJSHVSUY?=
 =?Windows-1252?Q?srl+5NpjiJbJOZRx6us6gyVYMsxTpj1sjlS0/YV1r9AvqZC/2R3Hcdom?=
 =?Windows-1252?Q?oPL1a/mGwUodOFGvmtk0bgzQt38ijOtsSM+/cSow1b3glgQ/Rp/x+2Ro?=
 =?Windows-1252?Q?ZxDv8mtj/cUAn1AH5ktGrVK9AJWAIKyvuRT0AU1wOVmky6omHZ9LouPM?=
 =?Windows-1252?Q?C3j6EMQazsBCaBvzUEJeZnVyKZH4kAkRTihWH4IJciily9zTLWDV/qR+?=
 =?Windows-1252?Q?yTY+8SGN/g2k2FJ7VNOKQ2z+H2Pygp7nOy3bB7MG3oPV9zRkNsUyjy6K?=
 =?Windows-1252?Q?Q/XMjkV7oZmATL67wBfeMJLZ/wY6QIe+/JuvthRU+5nFqQL4yUK8UHU/?=
 =?Windows-1252?Q?Zeg2KbTGNSe42s3lAkhs4Y88NOHo+5G10o1S9tzfhAeDS/v9q9OfEVll?=
 =?Windows-1252?Q?+nJr/GbJKajgiqTk4QmKxAMt0Co2JcXHud4eixXAac6tDqn2E/8aTssl?=
 =?Windows-1252?Q?mwHcLcb1viXzz9PO7lmhav09fWvw4vqrLrtcJ7xJ2oCgFh5KuNWF/W7J?=
 =?Windows-1252?Q?1HIFDo5KO7ToMUtrXW8+zVmtrWQxmPCr3kRSeb/xZsWze/NDfDxnw/I2?=
 =?Windows-1252?Q?Tmp4UsW1P2H/NBo9Y3DFcisVLj/bZzB5s2lJUlHkMn+95YtUJoaEiywd?=
 =?Windows-1252?Q?gIYuoUtfrw48DqslHVRkhtHejaadyrUkrIbn7jLXuDe6iKLx0DPqFv38?=
 =?Windows-1252?Q?Cg3ANbFtqR68IgioPJ7GJpNoBIjpOT0HPGnQWE5oEkmUVdP+VrxhPKSf?=
 =?Windows-1252?Q?5mwFWudnY//+EmMN+LMw2oSQA9Xpt6mS61GmScwMQfU9ksxcKPINuPoA?=
 =?Windows-1252?Q?CZGjygxUWSNKUjAmAwc0xK3EFaz7btUYLSFoKfbjs5mTiZMciXB5VXaW?=
 =?Windows-1252?Q?ew+MHhqCXq/oDNDy+vIzvLK7IpQ7TVKv9vfCSBDJM5oxCkGEPJpxb6We?=
 =?Windows-1252?Q?bEAK8yv8N+ojv9ZpN4p+/YRZVYVU3aOBcLMGT48JcRgnnisi67ulzPSK?=
 =?Windows-1252?Q?bLwiYAZbIJ6bVMKoP3QW7kq0qNWvR7VoNblU1J5Rncpy6frqR20Gb7tP?=
 =?Windows-1252?Q?rJ+9phDnzB9aeMPD07yT3XWvXgHqCgWQxx9pSdCsQ+oZ1NYmmn2XasHO?=
 =?Windows-1252?Q?zrfmH3I2FHm8HZAJPsnwKItjYmt6gmABqDF5chnGPi9bLrhl+HRRKjHf?=
 =?Windows-1252?Q?FlGq+6YM1eqt8xXjaIyZWNcUoq0Y2y0/3fGHrygbgoVoCMTYrkNB4EQf?=
 =?Windows-1252?Q?siW2qtYDrlr/Ka3SXodegN6tVwQXPCIcGXhXe+gc8C0SUDrAfHiGZ+Wx?=
 =?Windows-1252?Q?oiZdhIPlzHZ86yWfIkriEglxtWHxJuZeCnBnY5aDcQOfXTKs7y19yYqC?=
 =?Windows-1252?Q?5OtPt77JuS2pDENZYX7hI3KvvDIuyJymicBAjWi5C6ZRiS492Nif/E1F?=
 =?Windows-1252?Q?dKqQgxIBMEFW1TWg4eVTqHsgpF0nFxIHcjrsB/9dugXRtDyb0UvZM18F?=
 =?Windows-1252?Q?fajAwGqVVBijfLcwh30eGs7JBMKXvRW2MBteL8R9q1vccJ2qrUi5j3sa?=
 =?Windows-1252?Q?z2VqHROq/bd80D0h5F8jGzS4TL53ubE15kZo1msB9WNmUgMz28yaHGvD?=
 =?Windows-1252?Q?UGHV2SZviiC46Uk67791wpXbsjaXGBKl6I2F+8aISAOm9YsswoP0jUwj?=
 =?Windows-1252?Q?n7OIo1+n33Y1hd13kN+rLukTgn4DuhcvwwYzGTkxI3M6MBHbhQjPSK5m?=
 =?Windows-1252?Q?FmtolD7lPHxDLYxssFQwUi0uDzo1e0dv6he9cpJ41tortsp0XERTTayG?=
 =?Windows-1252?Q?qdg6/26V8vXxxurMsRCeN+x9Lt9EcVWKEgI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_FRYP281MB3387893A2A751782987D0CED91A32FRYP281MB3387DEUP_"
MIME-Version: 1.0
X-OriginatorOrg: ipetronik.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRYP281MB3387.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dff32da1-dc0d-487f-d948-08deff4141e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 05:01:27.6425 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 982fe058-7d80-4936-bdfa-9bed4f9ae127
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2SrvMAipomXBn44r2DcxwCA7Dt/nISqSETEtrkjOtV2GJ/FyqF209DumQPbXlnZ251efwBoPgoZYgBwDU8etJRJ7V1K3pYwGeqditoFCg40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB2764
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

--_000_FRYP281MB3387893A2A751782987D0CED91A32FRYP281MB3387DEUP_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi Tony,

Thank you for the promised assistance.
We have actually made some further progress since then. We now know that th=
e netlist for the image `E810_SFP_10G_NRB_SEC_FW_1p8p0p2_NVM_5p01_NCSIwPLDM=
oMCTP_0.01_80021FBF` is designed for 8 ports=97a detail that isn't apparent=
 or mentioned in the datasheet. In any case, the error disappears when we f=
lash the netlist from the image `E810_SFP_25G_NRB_SD_SEC_FW_1p8p0p2_NVM_5p0=
1_NCSIwPLDMoMCTP_0.01_80021FA1`, and everything works fine. However, that c=
onfigures the card for 25G, which isn't what we need. Consequently, we stil=
l require a suitable image=97one that isn't available "off the shelf." We n=
eed a 4x10G SFP configuration without NCSI. How can we obtain such an image=
? Does anyone already have one? Or how can we access the tools needed to cr=
eate a suitable image?

Thank sin advance

Best regards

Fabrice


________________________________
Von: Tony Nguyen <anthony.l.nguyen@intel.com>
Gesendet: Donnerstag, 20. August 2026 02:02
An: Hoffmann, Fabrice <Fabrice.Hoffmann@ipetronik.com>; intel-wired-lan@osu=
osl.org <intel-wired-lan@osuosl.org>
Betreff: Re: AW: [BUG] ice: E810-CAM1 custom board - topology/netlist resol=
ution fails (EINVAL on all AQ topology commands), no I2C activity on GPIO e=
xpander bus



On 8/18/2026 11:47 PM, Hoffmann, Fabrice wrote:
> Hi all,
>
> Follow-up to my earlier report (no replies yet, but we made concrete
> progress on our end that narrows this down significantly).

Hi Fabrice,

I'm working on finding the right person to assist you with these
issues/questions.

Thanks,
Tony

> We built the ice driver from a 6.14-based kernel (our original test
> system was on 6.12, which lacks the devlink health reporters) and
> tested the same board on different host hardware. The original EINVAL/
> EIO behavior on every topology-dependent AQ command reproduces
> identically on this new setup - so that part is confirmed independent
> of host platform, CPU, and kernel version.
>
> With devlink health now available, we finally got a direct,
> plain-text firmware diagnosis instead of raw AQ error codes:
>
>    $ devlink health diagnose pci/0000:05:00.0 reporter fw
>    Syndrome: 274  Description: LOM topology netlist is corrupted.
>    Possible Solution: Update to the latest NVM image.
>
>    $ devlink health diagnose pci/0000:05:00.0 reporter port
>    Syndrome: 275  Description: Unrecoverable netlist error.
>    Possible Solution: Update to the latest NVM image.
>    Port Number: 0
>
>    $ devlink health diagnose pci/0000:05:00.1 reporter port
>    Syndrome: 0
>    (ports .4 and .5 likewise report Syndrome: 0 on the port reporter)
>
> So: the "fw" reporter (global) reports netlist corruption on all 4
> PFs identically, but the "port" reporter only flags an actual
> unrecoverable error on port 0 - ports 1-3 come back clean. Combined
> with the dmesg output being identical on all 4 ports ("Get PHY
> capabilities failed status =3D -5" / "ice_init_nvm_phy_type failed: -5"),
> our working theory is that netlist/topology processing walks the
> node table in order, hits an unrecoverable condition at the first
> cage node (port 0), and aborts the entire walk - which would explain
> why ports 1-3 are simply never reached/checked (hence "healthy" by
> omission) while the overall topology init still fails for all 4 PFs.
>
> We're fairly confident this isn't a NVM data-integrity problem in the
> usual sense:
> - The board is already on the latest available NVM/FW (5.01,
>    EETRACK 80021FBF; nvmupdate reports "Update Not Available")
> - We reverse-engineered the Link Topology Netlist (TLV 0x11B) from
>    our image and confirmed it's byte-for-byte identical to Intel's own
>    E810_XXVDA4 reference image at the node/IO table level (PCA9575 I2C
>    GPIO expander correctly present at Bus 4, RESET_N/INT_N on native
>    SDP5/SDP6, matching the datasheet's "4x SFP Native" reference
>    schematic, Section 17.2.2.1)
> - Re-verified this against the actual flashed chip content (ethtool -e
>    readback) after a fresh NVM update - identical result
> - NVM Update Checksum (AQ 0x0706) reports valid
> - GL_MNG_FWSM and GL_MNG_SHA_EXTEND_STATUS (read via UEFI Shell/BAR0,
>    pre-OS) show a completely clean boot: main FW authenticated (STAGE=3D
>    100b), no POR_AL_FAILURE/PCIR_AL_FAILURE, no EXT_ERR_IND, FW_MODES
>    bit1 (Recovery Mode) =3D 0
>
> Given all of that checks out, "corrupted" seems to mean something
> more like a structural/semantic validation failure specific to the
> port-0 cage node (or something processed immediately before it),
> rather than actual bit-level data corruption - but we don't have
> visibility into what that validation actually checks.
>
> Questions, now with concrete syndrome data attached:
>
> - What does the firmware's netlist walk actually validate at/around
>    the first cage node that could produce "Unrecoverable netlist error"
>    (syndrome 275) specifically for port 0, while leaving ports 1-3
>    unflagged?
> - Is there a way to get more granular logging out of this
>    specifically (we tried fwlog modules i2c/link_topo/health/adminq via
>    debugfs, and can correlate some opaque message IDs with specific
>    AQ calls, but can't decode their actual content without an internal
>    format-string table)?
> - The suggested remediation ("update to latest NVM image") doesn't
>    apply since we're already on the latest - is there a separate
>    netlist/board-config bundle that could be out of sync independent
>    of the FW/NVM version number?
>
> Happy to share the full netlist dump, oscilloscope captures, and raw
> AQ traces if that's useful to anyone looking into this.
>
> Thanks,
> Fabrice



Impressum/Imprint: https://www.ipetronik.com/impressum

--_000_FRYP281MB3387893A2A751782987D0CED91A32FRYP281MB3387DEUP_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hi Tony,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Thank you for the promised assistance.<br>
We have actually made some further progress since then. We now know that th=
e netlist for the image `E810_SFP_10G_NRB_SEC_FW_1p8p0p2_NVM_5p01_NCSIwPLDM=
oMCTP_0.01_80021FBF` is designed for 8 ports=97a detail that isn't apparent=
 or mentioned in the datasheet. In
 any case, the error disappears when we flash the netlist from the image `E=
810_SFP_25G_NRB_SD_SEC_FW_1p8p0p2_NVM_5p01_NCSIwPLDMoMCTP_0.01_80021FA1`, a=
nd everything works fine. However, that configures the card for 25G, which =
isn't what we need. Consequently,
 we still require a suitable image=97one that isn't available &quot;off the=
 shelf.&quot; We need a 4x10G SFP configuration without NCSI. How can we ob=
tain such an image? Does anyone already have one? Or how can we access the =
tools needed to create a suitable image?</div>
<div id=3D"appendonsend"></div>
<div><br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Thank sin advance</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Best regards</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Fabrice</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>Von:</b> Tony Nguyen &lt;anthony.l.nguyen@intel.com&gt;<br>
<b>Gesendet:</b> Donnerstag, 20. August 2026 02:02<br>
<b>An:</b> Hoffmann, Fabrice &lt;Fabrice.Hoffmann@ipetronik.com&gt;; intel-=
wired-lan@osuosl.org &lt;intel-wired-lan@osuosl.org&gt;<br>
<b>Betreff:</b> Re: AW: [BUG] ice: E810-CAM1 custom board - topology/netlis=
t resolution fails (EINVAL on all AQ topology commands), no I2C activity on=
 GPIO expander bus
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;"><br>
<br>
On 8/18/2026 11:47 PM, Hoffmann, Fabrice wrote:<br>
&gt; Hi all,<br>
&gt;<br>
&gt; Follow-up to my earlier report (no replies yet, but we made concrete<b=
r>
&gt; progress on our end that narrows this down significantly).<br>
<br>
Hi Fabrice,<br>
<br>
I'm working on finding the right person to assist you with these<br>
issues/questions.<br>
<br>
Thanks,<br>
Tony<br>
<br>
&gt; We built the ice driver from a 6.14-based kernel (our original test<br=
>
&gt; system was on 6.12, which lacks the devlink health reporters) and<br>
&gt; tested the same board on different host hardware. The original EINVAL/=
<br>
&gt; EIO behavior on every topology-dependent AQ command reproduces<br>
&gt; identically on this new setup - so that part is confirmed independent<=
br>
&gt; of host platform, CPU, and kernel version.<br>
&gt;<br>
&gt; With devlink health now available, we finally got a direct,<br>
&gt; plain-text firmware diagnosis instead of raw AQ error codes:<br>
&gt;<br>
&gt;&nbsp; &nbsp; $ devlink health diagnose pci/0000:05:00.0 reporter fw<br=
>
&gt;&nbsp; &nbsp; Syndrome: 274 &nbsp;Description: LOM topology netlist is =
corrupted.<br>
&gt;&nbsp; &nbsp; Possible Solution: Update to the latest NVM image.<br>
&gt;<br>
&gt;&nbsp; &nbsp; $ devlink health diagnose pci/0000:05:00.0 reporter port<=
br>
&gt;&nbsp; &nbsp; Syndrome: 275 &nbsp;Description: Unrecoverable netlist er=
ror.<br>
&gt;&nbsp; &nbsp; Possible Solution: Update to the latest NVM image.<br>
&gt;&nbsp; &nbsp; Port Number: 0<br>
&gt;<br>
&gt;&nbsp; &nbsp; $ devlink health diagnose pci/0000:05:00.1 reporter port<=
br>
&gt;&nbsp; &nbsp; Syndrome: 0<br>
&gt;&nbsp; &nbsp; (ports .4 and .5 likewise report Syndrome: 0 on the port =
reporter)<br>
&gt;<br>
&gt; So: the &quot;fw&quot; reporter (global) reports netlist corruption on=
 all 4<br>
&gt; PFs identically, but the &quot;port&quot; reporter only flags an actua=
l<br>
&gt; unrecoverable error on port 0 - ports 1-3 come back clean. Combined<br=
>
&gt; with the dmesg output being identical on all 4 ports (&quot;Get PHY<br=
>
&gt; capabilities failed status =3D -5&quot; / &quot;ice_init_nvm_phy_type =
failed: -5&quot;),<br>
&gt; our working theory is that netlist/topology processing walks the<br>
&gt; node table in order, hits an unrecoverable condition at the first<br>
&gt; cage node (port 0), and aborts the entire walk - which would explain<b=
r>
&gt; why ports 1-3 are simply never reached/checked (hence &quot;healthy&qu=
ot; by<br>
&gt; omission) while the overall topology init still fails for all 4 PFs.<b=
r>
&gt;<br>
&gt; We're fairly confident this isn't a NVM data-integrity problem in the<=
br>
&gt; usual sense:<br>
&gt; - The board is already on the latest available NVM/FW (5.01,<br>
&gt;&nbsp; &nbsp; EETRACK 80021FBF; nvmupdate reports &quot;Update Not Avai=
lable&quot;)<br>
&gt; - We reverse-engineered the Link Topology Netlist (TLV 0x11B) from<br>
&gt;&nbsp; &nbsp; our image and confirmed it's byte-for-byte identical to I=
ntel's own<br>
&gt;&nbsp; &nbsp; E810_XXVDA4 reference image at the node/IO table level (P=
CA9575 I2C<br>
&gt;&nbsp; &nbsp; GPIO expander correctly present at Bus 4, RESET_N/INT_N o=
n native<br>
&gt;&nbsp; &nbsp; SDP5/SDP6, matching the datasheet's &quot;4x SFP Native&q=
uot; reference<br>
&gt;&nbsp; &nbsp; schematic, Section 17.2.2.1)<br>
&gt; - Re-verified this against the actual flashed chip content (ethtool -e=
<br>
&gt;&nbsp; &nbsp; readback) after a fresh NVM update - identical result<br>
&gt; - NVM Update Checksum (AQ 0x0706) reports valid<br>
&gt; - GL_MNG_FWSM and GL_MNG_SHA_EXTEND_STATUS (read via UEFI Shell/BAR0,<=
br>
&gt;&nbsp; &nbsp; pre-OS) show a completely clean boot: main FW authenticat=
ed (STAGE=3D<br>
&gt;&nbsp; &nbsp; 100b), no POR_AL_FAILURE/PCIR_AL_FAILURE, no EXT_ERR_IND,=
 FW_MODES<br>
&gt;&nbsp; &nbsp; bit1 (Recovery Mode) =3D 0<br>
&gt;<br>
&gt; Given all of that checks out, &quot;corrupted&quot; seems to mean some=
thing<br>
&gt; more like a structural/semantic validation failure specific to the<br>
&gt; port-0 cage node (or something processed immediately before it),<br>
&gt; rather than actual bit-level data corruption - but we don't have<br>
&gt; visibility into what that validation actually checks.<br>
&gt;<br>
&gt; Questions, now with concrete syndrome data attached:<br>
&gt;<br>
&gt; - What does the firmware's netlist walk actually validate at/around<br=
>
&gt;&nbsp; &nbsp; the first cage node that could produce &quot;Unrecoverabl=
e netlist error&quot;<br>
&gt;&nbsp; &nbsp; (syndrome 275) specifically for port 0, while leaving por=
ts 1-3<br>
&gt;&nbsp; &nbsp; unflagged?<br>
&gt; - Is there a way to get more granular logging out of this<br>
&gt;&nbsp; &nbsp; specifically (we tried fwlog modules i2c/link_topo/health=
/adminq via<br>
&gt;&nbsp; &nbsp; debugfs, and can correlate some opaque message IDs with s=
pecific<br>
&gt;&nbsp; &nbsp; AQ calls, but can't decode their actual content without a=
n internal<br>
&gt;&nbsp; &nbsp; format-string table)?<br>
&gt; - The suggested remediation (&quot;update to latest NVM image&quot;) d=
oesn't<br>
&gt;&nbsp; &nbsp; apply since we're already on the latest - is there a sepa=
rate<br>
&gt;&nbsp; &nbsp; netlist/board-config bundle that could be out of sync ind=
ependent<br>
&gt;&nbsp; &nbsp; of the FW/NVM version number?<br>
&gt;<br>
&gt; Happy to share the full netlist dump, oscilloscope captures, and raw<b=
r>
&gt; AQ traces if that's useful to anyone looking into this.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Fabrice<br>
<br>
<br>
</div>
<br>
<p class=3D"MsoNormal">Impressum/Imprint: https://www.ipetronik.com/impress=
um<o:p></o:p></p>
</body>
</html>

--_000_FRYP281MB3387893A2A751782987D0CED91A32FRYP281MB3387DEUP_--
