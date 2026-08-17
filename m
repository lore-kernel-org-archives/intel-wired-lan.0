Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28929C5DF66
	for <intel-wired-lan@archiver.kernel.org>; Mon, 17 Aug 2026 16:25:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DAE4940781;
	Mon, 17 Aug 2026 16:25:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3x7kaHhWK7Ac; Mon, 17 Aug 2026 16:25:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5ED80406A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786983949;
	bh=FApOrnEVvcioa48H6dMG7JOV3vaWnMN74W+AdsAAJ1g=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LrtNNWeZWfI0pVdrAkPO3s9BqmpwEQWWU/hFOJ5M++nHI1yfSVBuuu/7XLN5tAIE3
	 IKc7W3aM4yGAMcZxVThruJLZ72V6gJTTS9OYZwaSA44/m21HqPp0GEWaw4cWc5N8Qg
	 WGQJLf9csYY1FrsBrf2HzZcyrRUO4Ss+krUrQW0wiH4/hr+byVFp6eM5Mq+xrpkgq/
	 6G6O5NLz6ozxBZdgFFH8ouXrzZ5ftRryFqT4goSWHdQlI1z0qahxBznPSycA98J1s2
	 KRp190bVf3H+ayKk2pjqbY0Z261BO7j/sS9Bbc4z/EsNNl1enAFNpbDa/kffPQcgT/
	 rK7lbsCmgUqsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5ED80406A1;
	Mon, 17 Aug 2026 16:25:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F1C50282
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Aug 2026 16:25:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E373840203
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Aug 2026 16:25:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bNnimKXNWIpv for <intel-wired-lan@lists.osuosl.org>;
 Mon, 17 Aug 2026 16:25:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.149.102;
 helo=fr4p281cu032.outbound.protection.outlook.com;
 envelope-from=fabrice.hoffmann@ipetronik.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E3B9F40130
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=ipetronik.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E3B9F40130
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ipetronik.com header.i=@ipetronik.com
 header.a=rsa-sha256 header.s=selector2 header.b=JGPiQG6F
Received: from FR4P281CU032.outbound.protection.outlook.com
 (mail-germanywestcentralazon11022102.outbound.protection.outlook.com
 [40.107.149.102])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E3B9F40130
 for <intel-wired-lan@osuosl.org>; Mon, 17 Aug 2026 16:25:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2MgE0wKvO+at3DR1xyHV8zEiwdpWQGfnMmxUxHz4CBEv1rc9O/e6sgj7LfTr/IKmUXOAgEoSdJz6tBlY/PHqLsDvKXotMqA2mHMIkMkTIbVGETXrdMCQQMBmnC1yRuq9dgcQFcN+sxaofCoK0FHgY2HTGIWuOQ/cMcCColEhi/Q4HwHz9wlCdTD5IUnEYPeLwltdsKzK7Aj65aeR3sJ3j5wejiwS+uWOMEGYXNGT5FiQhEyR5XWEsE8+ChFgxpd/65wkF/a3/7s8DI5yHXWaEc5JXVIvnvkL/XLglC9/sdWJ2oHKa4mI6xa4nyUMYhFiTavRHu6rpJmEl3+6f6EzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FApOrnEVvcioa48H6dMG7JOV3vaWnMN74W+AdsAAJ1g=;
 b=fAOyXkar80pt66pS8BrN3DgW5pUJNoko79p6dnc8ywdNLZhJbHLIEvGCn/5kt2DBewkxAXxZY6//zrr7TA+PSJFh5Snta6HRvm2qglym8wwBzzYl/ZE8CdaKvaRMgl1FJ24hFO9KvN9JJt8t9ER8veGoN3+X7QLp5Wx+C1bgVHzBINFZPjKzlu1t1zKACv3gbvquExztM4Zq5vQbiYIHQ2myC8ex6kgLEz/SJdYKKdtXqnhvBJn6KnZ105KaeN6bDc2tLxbQIxEvforPr6wnxOG06Q2iV0zTwwoCdHYbm3eR+DBEZOzgQA00zPXWpgZpaO46tOpHzOInCtLQarF57w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ipetronik.com; dmarc=pass action=none
 header.from=ipetronik.com; dkim=pass header.d=ipetronik.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ipetronik.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FApOrnEVvcioa48H6dMG7JOV3vaWnMN74W+AdsAAJ1g=;
 b=JGPiQG6FqaCXA25Cf/orkn1/ML9p84wEZNtSm14WueNU04aLFj5qVUTWdcxdCTRKhP53twaPwmC1/WR6PSbVDAii5GZcz0mS0em0tSkbY1/jugIlRe4fEVZtXZLyDxIabWYnBEJmrwShbHa7gkw8fBz5+q8RuKeYjRcVZDHDnaa04OgupJ1ilxez0rFWQ+n5MPBbGMnKTpnvj/E3qaj3GYabFaRVnLY592Kb11X193YYbwfaiUD/UAhAQtqhXZzUSUsSYgpENor16XhtC1u4tTBPhRI2AY4VN+1h78LWvcC4tlv5macNwodXz+4p4Z1RdXpOl0viFDjKN/aaWQgNNw==
Received: from FRYP281MB3387.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:73::10)
 by BE2P281MB4573.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:bf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 16:25:40 +0000
Received: from FRYP281MB3387.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ceb9:6bd5:f877:fa2]) by FRYP281MB3387.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ceb9:6bd5:f877:fa2%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 16:25:40 +0000
From: "Hoffmann, Fabrice" <Fabrice.Hoffmann@ipetronik.com>
To: "intel-wired-lan@osuosl.org" <intel-wired-lan@osuosl.org>
Thread-Topic: [BUG] ice: E810-CAM1 custom board - topology/netlist resolution
 fails (EINVAL on all AQ topology commands),
 no I2C activity on GPIO expander bus
Thread-Index: AQHdLmTh4U3ixgbzm0i1idtkA3CMoQ==
Date: Mon, 17 Aug 2026 16:25:40 +0000
Message-ID: <FRYP281MB3387C2011F156C1D4F36C05291A72@FRYP281MB3387.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ipetronik.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FRYP281MB3387:EE_|BE2P281MB4573:EE_
x-ms-office365-filtering-correlation-id: b365cf62-0924-472b-6efe-08defc7c2d83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|18002099003|3023799007|8096899003|56012099006|13003099007|38070700021|6133799003|5023799004|10067099003;
x-microsoft-antispam-message-info: +Q2ifTJPjZRgfrLF5h64vFL6QXG7LBhcof90IX1ncOMalh2AvIMxIObCZQutMG+jnCH/2iy01m9fA04rqi1V5wO7+3wJj0s5sLDb5L3IKG4IDAq6+KXIFh5EqrzszVqZ+RdvmoR4KbtBEGG+RiRYBIBCKekXsgHdKoHaMP+OUdShDFZNO93VPs8CmqnNzP/KR1hRx871+oj1E1zUE6T0klk0fvKNAvWoEr269vj44ytdCmeBt7W+08YuxL+2oRfi3vgE6/2s3tIv4TBucbTa/eLi9kO/LOtXNZxmZqwx3TPCbIxe7PKbKLauc0g//FZghQFYww+2wcN5IuCFkheAdoQ10HamOdFXOY6BicN5OENuuaDZ3I7w4xLrwJEGiCsDcyUQ8mBMF5k4Ow/B6/u3dWpH8yJpd0tg37O0S/VZvklawnGVU1Fh+ETmCyaW28zoRkoRkt+celJ7TRnasUI/uh/twdanl/nAq6WN2ESqMOi/xlEH0hhKxvpJ2VMYBoj84NfZG9RSAsp96qRiMEYRqSDUcUC/Qg7nhtQ3MeazMtTZ6mYrn5Umv4gEyvG5uXpmtuaXgFDRX2G1QcksBfpMrpzBhnP14CzZdsEdRRyQXZ53ai3ZxU7Oiftx3vTlR2wg4c2EOFRx8HeMdqMll5kvXQVtQFlIsCUOnF2NykCARZk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:FRYP281MB3387.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(3023799007)(8096899003)(56012099006)(13003099007)(38070700021)(6133799003)(5023799004)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HTt6RkW2Ho80/ceuXcPzjWEXLv4q0uAMAGIl/BO/WL2lSOFhB0OCe3OywX?=
 =?iso-8859-1?Q?8umpQjabGLeqh8ui5eKJnX6+PdGnzod03kL9gHN1/Ib6PsfSmMgVs+MmqB?=
 =?iso-8859-1?Q?e4C9m6BPFFHsRXfjWBOPcn3tJGbVAlHWxver0UC4eEesMGMXfi9W5iMv7+?=
 =?iso-8859-1?Q?TQphqkduBibIsONf5LlO95Q8znb08zlA7OnP30CbXMbYJe/7Y3ZSvRt9dZ?=
 =?iso-8859-1?Q?yZkST0h6lvoO6u7R40mNcsBZJfMagxX+0h3NI9jSSYSOsTTpegcyJamptZ?=
 =?iso-8859-1?Q?3CPaPplv3+XWxp6oN0ZgMRjDfBjWRshgNVVDrCuUfEL0S660Eudt9KyLvC?=
 =?iso-8859-1?Q?hxNtMDoI/sHoW4Ov/MmeSOo7+FXDAzgwmYflhR0a1T37tvc2il5RwxD2RA?=
 =?iso-8859-1?Q?ZBdXV8ZEqZKixw3jkdaT0rlUkiCETpbb/33oQeHDN8DGX32I2OC5+/ydvZ?=
 =?iso-8859-1?Q?QqvchZLUFwcQOEU9CRwgOYQgXckxWlaZbJBkFF4fDUusfdZwV50EgACWg/?=
 =?iso-8859-1?Q?7DFmzLqbhKlCt9kgvJoOAb5kLSzqDbm+tsTPSUvmAt1pUtgTfAf3Uy1vlY?=
 =?iso-8859-1?Q?0NW/kLOZIqZTv9ev05bbOIoizo595OPrQzsS26YBHeXbuD7GMGW6Inn7hn?=
 =?iso-8859-1?Q?zm8V1Dx+kPHoYyFtnil/AtB56jVZN7QHeZSECws+2rWvQfj4RSm7IjmcB5?=
 =?iso-8859-1?Q?KikQjdEpweuxD3QzNNZIyirtpwYRg6HwRo361TakEnIHYJGeYHfLa8Gdvv?=
 =?iso-8859-1?Q?yx39Y8g/NmJoOmRFkrmy6pU/eZV0VH0sa32TiNM8O6n7/bURI8+pl0S33s?=
 =?iso-8859-1?Q?ir8TPpVDQSNP8IVz/UpmYvj2ev7vEBdbz/27noFK5LtScZU/NS+WQ+bA2l?=
 =?iso-8859-1?Q?rBlYHoh7Vjbdpikcx/hWJu077/ohMVtuchUFVqdtXKCwQQXbLuDCsscp8K?=
 =?iso-8859-1?Q?kHrng8bJUlt/511Mf45ijKsf4ctHyNVtd+GNXYvoN8rQkHgzWXU4/JYifz?=
 =?iso-8859-1?Q?h9BqOtTaYfbZcke3re6lptNaPPQoXbXUaKqpZ1kjxJJCIyVJh00v160kqU?=
 =?iso-8859-1?Q?Ly1uQyE7svcmSpg8cV4ZrGi0vDLDYgu1VsLrOyHDF9Fv8FuptYaOS17D/v?=
 =?iso-8859-1?Q?tZ7tQEszGWZDeXnzLvN/L4s8+b34t6dAJ91pjQEuIudULMndPo2NAdSROi?=
 =?iso-8859-1?Q?AgDQQIfDl1nuGmdFIBnQsHIecithx/y692t0/+0K2jiy+N+HDI8WsVvdyh?=
 =?iso-8859-1?Q?1BXsGOQ0zJXoXAq9Fn/QrqQtnHb3GCPVMJyX7NEU6ukE3YKW2xPKGsvFaf?=
 =?iso-8859-1?Q?hlJmb4s+5CvHTEFnVAP8R2zFGrDDKWaLAjfx42pEObgHJ51wXgvH9MoA7A?=
 =?iso-8859-1?Q?bxETRFC1gX7PPlrB08UzJI5o4KrhX5JoQUb3wN7gBg+8TokgAN96ZcSWqz?=
 =?iso-8859-1?Q?KiapWJzdJSs8WKguTRrYn1WOAtDN4dbvBj/T1xZkEfiIYfLuGuVwpzsP2a?=
 =?iso-8859-1?Q?dZOxQpqramOWa3GvDgjbqhmAP7Gb2W2vgjnWfBlIMMkysXq4MPwadfBvsm?=
 =?iso-8859-1?Q?v6Oy0dHYyuRNVCDj847YRclo2vakrlhoXrKPXP98yrbvp966qvh/duPcaI?=
 =?iso-8859-1?Q?YTpufFkUH6J+jHOxd75k/FC6Jj5qEV/K2BnDfY9IGs0o3brBlhqjcbzzAf?=
 =?iso-8859-1?Q?jQjnOK5L1QwNtCNk/Vcqft8pPVTblRT1+7dcdBgUQqbRau6cRzb+qs9FUF?=
 =?iso-8859-1?Q?QUSC5bycgXanf3o4dCy/0qHFmY21Y7GaDUMKbslZ+2dum4GpnO2p0Ca4Vj?=
 =?iso-8859-1?Q?qhjFtAb8k+KjA+ot42DhaPKy6LndgRM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_FRYP281MB3387C2011F156C1D4F36C05291A72FRYP281MB3387DEUP_"
MIME-Version: 1.0
X-OriginatorOrg: ipetronik.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRYP281MB3387.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b365cf62-0924-472b-6efe-08defc7c2d83
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 16:25:40.2514 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 982fe058-7d80-4936-bdfa-9bed4f9ae127
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ySatOumSX7o4OqKU24cSRuPTBjaxHNjrjauRgAD7D7nPUxshBZUN5hYFx4M2J/YdfIqpkfmfB6YtKcYGWLywRpnb1Li7+4crNoAnsWOGMGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE2P281MB4573
Subject: [Intel-wired-lan] [BUG] ice: E810-CAM1 custom board -
 topology/netlist resolution fails (EINVAL on all AQ topology commands),
 no I2C activity on GPIO expander bus
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

--_000_FRYP281MB3387C2011F156C1D4F36C05291A72FRYP281MB3387DEUP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

We're bringing up a custom 4x SFP+ 10G NIC (2x Intel E810-CAM1, following
Intel's documented "4x SFP Native" reference topology from the E810
datasheet, Section 17.2.2.1, including the PCA9575 I2C GPIO expander on
Bus 4 / MDC4_SCL4 / MDIO4_SDA4). We've hit a reproducible issue where
topology-dependent Admin Queue commands consistently fail with EINVAL,
and no I2C activity is ever observed on Bus 4, even though the NVM
netlist content has been verified byte-for-byte identical to Intel's
own reference image. We'd appreciate any input, since we've run out of
public documentation to check against.

System: kernel 6.12.42, ice driver, 4 PFs enumerate correctly
(8086:1593, functions .0/.1/.4/.5). NVM: E810_SFP_10G_NRB_SEC_FW,
currently 1p8p0p2 / NVM 5p01 (EETRACK 80021FBF), successfully flashed
and verified. An earlier, unrelated boot issue (NVM/QSPI access
occasionally skipped at POR, thermal sensitivity) has already been
root-caused and resolved separately.

WHAT WE'VE VERIFIED:

1. Netlist content is correct
   We reverse-engineered the Link Topology Netlist (TLV TypeID 0x11B)
   from our NVM image and confirmed the PCA9575 (I2C addr 0x20, Handle
   29) is present with RESET_N/INT_N on native GPIO (SDP5/SDP6) and I2C
   on Bus 4 (Driving IO#4 of the SoC I/O Widget node, Handle 0) - byte
   for byte identical to Intel's E810_XXVDA4 reference NVM image. We
   re-verified this against the actual flashed chip content (via
   `ethtool -e`) after a fresh NVM update, with identical results.

2. Admin Queue commands consistently fail with EINVAL, not EBUSY
   `ethtool -m <iface>` (Read/Write SFF EEPROM, opcode 0x06EE) returns
   "Input/output error" every time. Raw AQ trace via dynamic debug shows
   the command is correctly formed (logical port 0, I2C addr 0x50,
   offset 0, read op), but firmware responds with retval 0x000E
   (EINVAL) - not 0x0C (EBUSY), which is the documented code for a real
   I2C bus timeout/busy condition. Response time across 50 consecutive
   calls: 40-68us, essentially constant with no jitter - too fast and
   too regular for an actual I2C bus attempt (100kHz would need >90us
   just for address+ACK).

   Same failure class shows up independently via `ethtool -d`: the
   "Extended Regs" (SerDes equalization) section, which
   ice_get_extended_regs() only populates after a successful
   ice_get_port_topology() -> "Get Netlist Node" AQ call (Cage context),
   is entirely zero-filled.

   At boot, dmesg shows the same thing on all 4 ports identically:
     ice 0000:01:00.0: Get PHY capabilities failed status =3D -5, continuin=
g anyway
     ice 0000:01:00.0: ice_init_nvm_phy_type failed: -5
   (via ICE_AQC_REPORT_TOPO_CAP)

3. No I2C activity observed, ever
   Oscilloscope on Bus 4 (I2C_CLK/I2C_DAT) shows the line pulled high at
   power-up (pull-up confirmed functional), and going low briefly very
   early in boot - but never toggling again, confirmed over a 10s
   capture window. Same result on Bus 0 (native SFP0 module bus) when
   triggered explicitly at runtime via ethtool -m. A known-good Intel
   reference card (E810-XXVDA4, tested standalone on a motherboard with
   no CPU installed at all) reliably shows a clean, well-formed 100kHz
   I2C burst on Bus 4 around 860-920ms post power-on. Our board shows
   nothing there.

4. QSPI timing shows a reproducible 1.7s stall + oversized retry
   Comparing raw QSPI_CLK captures (CSV, edge timestamps) between our
   board and the reference: both match closely up through ~860ms
   (including an ~334ms linear read phase we believe is FW SHA
   authentication). At that point the reference proceeds into small,
   regular ~90-100ms housekeeping bursts continuing indefinitely. Our
   board instead goes completely silent for ~1.72s, then produces a
   single burst ~3x larger (by edge count) than the reference's
   equivalent config-read burst, then goes silent again. This
   stall-then-oversized-retry pattern repeats up to 3 times within a
   10s window, never resolving into the reference's steady-state
   pattern, and never followed by any I2C activity.

5. Chip-level status registers show a clean boot, no recovery mode
   Read directly via UEFI Shell (BAR0 memory-mapped, before any OS/
   driver loads):
     GL_MNG_SHA_EXTEND_STATUS (0x00083148): STAGE=3D100b, FW_HALTED=3D0,
       DONE=3D1 -> main FW authenticated and running cleanly
     GL_MNG_FWSM (0x000B6134): 0x00000000 -> no POR_AL_FAILURE, no
       PCIR_AL_FAILURE, no EXT_ERR_IND. Per datasheet Section 15.4.3,
       FW_MODES bit 1 (Recovery Mode indication) =3D 0, so Recovery Mode
       is explicitly ruled out.
     GL_FWSTS (0x00083048): FWROWD (bit 8, Firmware Reset on Watchdog) =3D
       0 -> no watchdog-triggered reset flagged.

QUESTIONS:

- What internal criteria does firmware use to decide a netlist
  configuration is invalid/incompatible for a given port (this exact
  phrase - "Incompatible Netlist configuration" - appears in datasheet
  Section 15.4.1.1 as a named recovery-triggering failure scenario, but
  the detection logic itself isn't documented anywhere we can find)?

- Is there a way to enable FW logging (i2c / link_topology modules)
  early enough to catch whatever happens in the ~860ms-2.6s window,
  given the host driver isn't loaded yet at that point on a normal
  boot?

- Given verified-identical netlist content, clean POR/auth status, and
  no recovery mode - but consistent EINVAL on every topology-dependent
  AQ command on all 4 ports - what would cause exactly this
  combination?

Happy to share the full netlist dump, raw AQ traces, and oscilloscope
CSVs if useful. Thanks for reading this far.

Best regards,

Fabrice Hoffmann

Development



IPETRONIK GmbH & Co.KG

Im Rollfeld 28

D-76532 Baden-Baden



Phone: +49 7221 9922-486

Fax: +49 7221 9922-59486

mailto: <mailto:%0dmailto:%20Fabrice.Hoffmann@ipetronik.com> Fabrice.Hoffma=
nn@ipetronik.com<mailto:%0dmailto:%20Fabrice.Hoffmann@ipetronik.com>

web: http://www.ipetronik.com



Impressum/Imprint: https://www.ipetronik.com/impressum

--_000_FRYP281MB3387C2011F156C1D4F36C05291A72FRYP281MB3387DEUP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hi all,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
We're bringing up a custom 4x SFP+ 10G NIC (2x Intel E810-CAM1, following</=
div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Intel's documented &quot;4x SFP Native&quot; reference topology from the E8=
10</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
datasheet, Section 17.2.2.1, including the PCA9575 I2C GPIO expander on</di=
v>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Bus 4 / MDC4_SCL4 / MDIO4_SDA4). We've hit a reproducible issue where</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
topology-dependent Admin Queue commands consistently fail with EINVAL,</div=
>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
and no I2C activity is ever observed on Bus 4, even though the NVM</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
netlist content has been verified byte-for-byte identical to Intel's</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
own reference image. We'd appreciate any input, since we've run out of</div=
>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
public documentation to check against.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
System: kernel 6.12.42, ice driver, 4 PFs enumerate correctly</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
(8086:1593, functions .0/.1/.4/.5). NVM: E810_SFP_10G_NRB_SEC_FW,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
currently 1p8p0p2 / NVM 5p01 (EETRACK 80021FBF), successfully flashed</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
and verified. An earlier, unrelated boot issue (NVM/QSPI access</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
occasionally skipped at POR, thermal sensitivity) has already been</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
root-caused and resolved separately.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
WHAT WE'VE VERIFIED:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
1. Netlist content is correct</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;We reverse-engineered the Link Topology Netlist (TLV TypeID 0x=
11B)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;from our NVM image and confirmed the PCA9575 (I2C addr 0x20, H=
andle</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;29) is present with RESET_N/INT_N on native GPIO (SDP5/SDP6) a=
nd I2C</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;on Bus 4 (Driving IO#4 of the SoC I/O Widget node, Handle 0) -=
 byte</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;for byte identical to Intel's E810_XXVDA4 reference NVM image.=
 We</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;re-verified this against the actual flashed chip content (via<=
/div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;`ethtool -e`) after a fresh NVM update, with identical results=
.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
2. Admin Queue commands consistently fail with EINVAL, not EBUSY</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;`ethtool -m &lt;iface&gt;` (Read/Write SFF EEPROM, opcode 0x06=
EE) returns</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;&quot;Input/output error&quot; every time. Raw AQ trace via dy=
namic debug shows</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;the command is correctly formed (logical port 0, I2C addr 0x50=
,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;offset 0, read op), but firmware responds with retval 0x000E</=
div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;(EINVAL) - not 0x0C (EBUSY), which is the documented code for =
a real</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;I2C bus timeout/busy condition. Response time across 50 consec=
utive</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;calls: 40-68us, essentially constant with no jitter - too fast=
 and</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;too regular for an actual I2C bus attempt (100kHz would need &=
gt;90us</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;just for address+ACK).</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;Same failure class shows up independently via `ethtool -d`: th=
e</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;&quot;Extended Regs&quot; (SerDes equalization) section, which=
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;ice_get_extended_regs() only populates after a successful</div=
>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;ice_get_port_topology() -&gt; &quot;Get Netlist Node&quot; AQ =
call (Cage context),</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;is entirely zero-filled.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;At boot, dmesg shows the same thing on all 4 ports identically=
:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;ice 0000:01:00.0: Get PHY capabilities failed status =
=3D -5, continuing anyway</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;ice 0000:01:00.0: ice_init_nvm_phy_type failed: -5</div=
>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;(via ICE_AQC_REPORT_TOPO_CAP)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
3. No I2C activity observed, ever</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;Oscilloscope on Bus 4 (I2C_CLK/I2C_DAT) shows the line pulled =
high at</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;power-up (pull-up confirmed functional), and going low briefly=
 very</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;early in boot - but never toggling again, confirmed over a 10s=
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;capture window. Same result on Bus 0 (native SFP0 module bus) =
when</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;triggered explicitly at runtime via ethtool -m. A known-good I=
ntel</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;reference card (E810-XXVDA4, tested standalone on a motherboar=
d with</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;no CPU installed at all) reliably shows a clean, well-formed 1=
00kHz</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;I2C burst on Bus 4 around 860-920ms post power-on. Our board s=
hows</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;nothing there.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
4. QSPI timing shows a reproducible 1.7s stall + oversized retry</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;Comparing raw QSPI_CLK captures (CSV, edge timestamps) between=
 our</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;board and the reference: both match closely up through ~860ms<=
/div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;(including an ~334ms linear read phase we believe is FW SHA</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;authentication). At that point the reference proceeds into sma=
ll,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;regular ~90-100ms housekeeping bursts continuing indefinitely.=
 Our</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;board instead goes completely silent for ~1.72s, then produces=
 a</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;single burst ~3x larger (by edge count) than the reference's</=
div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;equivalent config-read burst, then goes silent again. This</di=
v>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;stall-then-oversized-retry pattern repeats up to 3 times withi=
n a</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;10s window, never resolving into the reference's steady-state<=
/div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;pattern, and never followed by any I2C activity.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
5. Chip-level status registers show a clean boot, no recovery mode</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;Read directly via UEFI Shell (BAR0 memory-mapped, before any O=
S/</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;driver loads):</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;GL_MNG_SHA_EXTEND_STATUS (0x00083148): STAGE=3D100b, FW=
_HALTED=3D0,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp;DONE=3D1 -&gt; main FW authenticated and running=
 cleanly</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;GL_MNG_FWSM (0x000B6134): 0x00000000 -&gt; no POR_AL_FA=
ILURE, no</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp;PCIR_AL_FAILURE, no EXT_ERR_IND. Per datasheet S=
ection 15.4.3,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp;FW_MODES bit 1 (Recovery Mode indication) =3D 0,=
 so Recovery Mode</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp;is explicitly ruled out.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;GL_FWSTS (0x00083048): FWROWD (bit 8, Firmware Reset on=
 Watchdog) =3D</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp;0 -&gt; no watchdog-triggered reset flagged.</di=
v>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
QUESTIONS:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
- What internal criteria does firmware use to decide a netlist</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; configuration is invalid/incompatible for a given port (this exact</=
div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; phrase - &quot;Incompatible Netlist configuration&quot; - appears in=
 datasheet</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; Section 15.4.1.1 as a named recovery-triggering failure scenario, bu=
t</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; the detection logic itself isn't documented anywhere we can find)?</=
div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
- Is there a way to enable FW logging (i2c / link_topology modules)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; early enough to catch whatever happens in the ~860ms-2.6s window,</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; given the host driver isn't loaded yet at that point on a normal</di=
v>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; boot?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
- Given verified-identical netlist content, clean POR/auth status, and</div=
>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; no recovery mode - but consistent EINVAL on every topology-dependent=
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; AQ command on all 4 ports - what would cause exactly this</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; combination?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Happy to share the full netlist dump, raw AQ traces, and oscilloscope</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
CSVs if useful. Thanks for reading this far.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Best regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
; font-size: 10.5pt; color: rgb(53, 56, 56);">
<span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"></s=
pan>Fabrice Hoffmann</div>
<div id=3D"Signature" class=3D"elementToProof">
<p class=3D"elementToProof" style=3D"background-color: white; margin: 0cm 0=
cm 0.0001pt; font-family: Calibri, sans-serif; font-size: 11pt;">
<span style=3D"font-family: &quot;Courier New&quot;; font-size: 10.5pt; col=
or: rgb(53, 56, 56);">Development</span></p>
<p class=3D"elementToProof" style=3D"background-color: white; margin: 0cm 0=
cm 0.0001pt; font-family: Calibri, sans-serif; font-size: 11pt;">
<span style=3D"font-family: &quot;Courier New&quot;; font-size: 10.5pt; col=
or: rgb(53, 56, 56);">&nbsp;</span></p>
<p class=3D"elementToProof" style=3D"background-color: white; margin: 0cm 0=
cm 0.0001pt; font-family: Calibri, sans-serif; font-size: 11pt;">
<span style=3D"font-family: &quot;Courier New&quot;; font-size: 10.5pt; col=
or: rgb(53, 56, 56);">IPETRONIK GmbH &amp; Co.KG</span></p>
<p class=3D"elementToProof" style=3D"background-color: white; margin: 0cm 0=
cm 0.0001pt; font-family: Calibri, sans-serif; font-size: 11pt;">
<span style=3D"font-family: &quot;Courier New&quot;; font-size: 10.5pt; col=
or: rgb(53, 56, 56);">Im Rollfeld 28</span></p>
<p class=3D"elementToProof" style=3D"background-color: white; margin: 0cm 0=
cm 0.0001pt; font-family: Calibri, sans-serif; font-size: 11pt;">
<span style=3D"font-family: &quot;Courier New&quot;; font-size: 10.5pt; col=
or: rgb(53, 56, 56);">D-76532 Baden-Baden&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</sp=
an></p>
<p class=3D"elementToProof" style=3D"background-color: white; margin: 0cm 0=
cm 0.0001pt; font-family: Calibri, sans-serif; font-size: 11pt;">
<span style=3D"font-family: &quot;Courier New&quot;; font-size: 10.5pt; col=
or: rgb(53, 56, 56);">&nbsp;</span></p>
<p class=3D"elementToProof" style=3D"background-color: white; margin: 0cm 0=
cm 0.0001pt; font-family: Calibri, sans-serif; font-size: 11pt;">
<span style=3D"font-family: &quot;Courier New&quot;; font-size: 10.5pt; col=
or: rgb(53, 56, 56);">Phone: +49 7221 9922-486</span></p>
<p class=3D"elementToProof" style=3D"background-color: white; margin: 0cm 0=
cm 0.0001pt; font-family: Calibri, sans-serif; font-size: 11pt;">
<span style=3D"font-family: &quot;Courier New&quot;; font-size: 10.5pt; col=
or: rgb(53, 56, 56);">Fax: +49 7221 9922-59486</span></p>
<p class=3D"elementToProof" style=3D"background-color: white; margin: 0cm 0=
cm 0.0001pt; font-family: Calibri, sans-serif; font-size: 11pt;">
<span style=3D"font-family: &quot;Courier New&quot;; font-size: 10.5pt; col=
or: rgb(0, 0, 0);"><a href=3D"mailto:%0dmailto:%20Fabrice.Hoffmann@ipetroni=
k.com" id=3D"OWAd86dc4c1-4012-8323-f62f-c4386f8bc65a" class=3D"OWAAutoLink"=
 style=3D"color: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px;"><u>mai=
lto:
</u></a></span><span style=3D"font-family: &quot;Courier New&quot;; font-si=
ze: 10.5pt; color: blue;"><a href=3D"mailto:%0dmailto:%20Fabrice.Hoffmann@i=
petronik.com" id=3D"OWA9a09c0f6-420f-233e-a044-899eb2b60486" class=3D"OWAAu=
toLink" style=3D"color: blue; margin-top: 0px; margin-bottom: 0px;"><u>Fabr=
ice.Hoffmann@ipetronik.com</u></a></span></p>
<p class=3D"elementToProof" style=3D"background-color: white; margin: 0cm 0=
cm 0.0001pt; font-family: Calibri, sans-serif; font-size: 11pt;">
<span style=3D"font-family: &quot;Courier New&quot;; font-size: 10.5pt; col=
or: rgb(53, 56, 56);">web:
</span><span style=3D"font-family: &quot;Courier New&quot;; font-size: 10.5=
pt; color: blue;"><a href=3D"http://www.ipetronik.com" id=3D"OWAe3c3b2f1-34=
ee-1ce7-f195-7a1d1a63575f" class=3D"OWAAutoLink" style=3D"color: blue; marg=
in-top: 0px; margin-bottom: 0px;"><u>http://www.ipetronik.com</u></a></span=
></p>
<p class=3D"elementToProof" style=3D"margin: 0cm 0cm 0.0001pt; font-family:=
 Calibri, sans-serif; font-size: 11pt;">
&nbsp;</p>
</div>
<br>
<p class=3D"MsoNormal">Impressum/Imprint: https://www.ipetronik.com/impress=
um<o:p></o:p></p>
</body>
</html>

--_000_FRYP281MB3387C2011F156C1D4F36C05291A72FRYP281MB3387DEUP_--
