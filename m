Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2927DC5DF6D
	for <intel-wired-lan@archiver.kernel.org>; Wed, 19 Aug 2026 06:47:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2FCC40687;
	Wed, 19 Aug 2026 06:47:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t6X8bKLsnjd7; Wed, 19 Aug 2026 06:47:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787122039;
	bh=q2x55ELYADkRSjUv1hbal+DtJxsWt0OPffXFd5/WSLU=;
	h=From:To:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cpRouY28aWJ8NBUTe3lGZYBf7cfHN4eiJ166uoR+Oqljpfe2YOwTYJWY0BroJ+3X0
	 /04v1ADaOwsB47FweWrfluNml74Cl/BpMMXi6IhHXm5kPwM5YTTqAdxuEwdkFtQQhd
	 WekFdwXi+qog4LRFtrHR/YcNDCJTwdtTP9d/entO/zQXgI+DQmquBpoeCB4lRi4wzr
	 lPGCYrJIpEoCu7KQc0yQDOKUCl94hyXL8lznhex9gpqOTPT+Ykb61CeTWwViG6CYJq
	 fC6B6fTzRTELK61Qrnb/hlDUGXk6Dq1gkSRVzv4bFCvS3SI4M4qo9ve9LG7cYX3tjE
	 YxKCU/M84auUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2265540688;
	Wed, 19 Aug 2026 06:47:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B9A133AC
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 06:47:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A6FF380E5C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 06:47:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fyd8jPP_ZCwH for <intel-wired-lan@lists.osuosl.org>;
 Wed, 19 Aug 2026 06:47:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=52.101.171.73;
 helo=fr6p281cu001.outbound.protection.outlook.com;
 envelope-from=fabrice.hoffmann@ipetronik.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=ipetronik.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ipetronik.com header.i=@ipetronik.com
 header.a=rsa-sha256 header.s=selector2 header.b=xplIUb5d
Received: from FR6P281CU001.outbound.protection.outlook.com
 (mail-germanywestcentralazon11020073.outbound.protection.outlook.com
 [52.101.171.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 55ED180D93
 for <intel-wired-lan@osuosl.org>; Wed, 19 Aug 2026 06:47:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHMDUDxd8nUHA6O/qsvDjeEnE6CdKy0KLlihOPAEE1uzcH5Ow8iYe3r8ILaFYrPsWi1kiraMpX2Qkdl3H8YzwrkAyqMTUqS92lky+/3kK5/m/1QVd3mQayYf9J/pW9X7NtpASUSiqW3qC+4cojUyOwE6UDxLwFv6Fk+1UmNVQFDQ5HAJwc5dpzjqgZXmJPJwsTBlrT5Kol5DCdalVle0pB+KAh8jPbF9yiC1yylMvCTid2Sw0nynTOMOYZ85zBpctWYxKFVJD52GJU5BBiTGOm8uElWM2tkwoX7hJlHAaTMMkOAzZ30ZD+63bO1j+XZTTXNt+PB59TnTQjUR46QaDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2x55ELYADkRSjUv1hbal+DtJxsWt0OPffXFd5/WSLU=;
 b=MEl2X8qMYhYVF8vIO/qohV6PiVySBeClmGxLT9efik34863rlXSnGLz8Rq6y6NO2RkXEnx/9CClJj0NZmAER+Iltsmlv3DwI1mH0BT2cXr/xRU1wRuemC4tc+xQ4mah9KhHA2RNMfCo4AvSMf4EraLHOvBdmspsAh4KNG7Su5TpMR+mV9NJX/5VxfQZ2LsRxBwQ27vsLEi914sL1UmvL1bEFwNhWmw+EWbJVwjQD8ptWMPC4jDy8Yd5GZdNQYnOsUg8VNTaAsZqr8sauRmhI2xwGjll2qFLF9fLkIVhe9adiW5TfbwL9gGQcOw3FRUIFqYit6w2rky4dr9ZwmUKStA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ipetronik.com; dmarc=pass action=none
 header.from=ipetronik.com; dkim=pass header.d=ipetronik.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ipetronik.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2x55ELYADkRSjUv1hbal+DtJxsWt0OPffXFd5/WSLU=;
 b=xplIUb5dl7ykhzTwcSPukI8Ot2UaNHH118lYoxARFggYeymi0TCOUUoAIKHB0+pUOy6Et6B+YxeZ9LA2uziDump43fU90XwMm0DfJqaTCGMS86r473TYuTqWa4U6d+TfycIskjZW9RswYQt5Mmrb8HVEwOScGVCttt45QLEek+FzUj2y+v0lduI/VLqUyveciPIHqaRSkDSGVXXA7FRe7amQaRUBNLKo5AF5rx6A363QlJ2AVXVTshHfQODc8gWyyh2+XjoDBKZipQln/jwqB81s0utali6cfv3C7fvzNDCKjTrJzcqwTlCuRCgMiKBBOAhBx89TW/6UqtrvKx5S6w==
Received: from FRYP281MB3387.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:73::10)
 by FR3P281MB3053.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:58::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 06:47:10 +0000
Received: from FRYP281MB3387.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ceb9:6bd5:f877:fa2]) by FRYP281MB3387.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ceb9:6bd5:f877:fa2%5]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 06:47:09 +0000
From: "Hoffmann, Fabrice" <Fabrice.Hoffmann@ipetronik.com>
To: "intel-wired-lan@osuosl.org" <intel-wired-lan@osuosl.org>
Subject: AW: [BUG] ice: E810-CAM1 custom board - topology/netlist resolution
 fails (EINVAL on all AQ topology commands), no I2C activity on GPIO expander
 bus
Thread-Topic: [BUG] ice: E810-CAM1 custom board - topology/netlist resolution
 fails (EINVAL on all AQ topology commands),
 no I2C activity on GPIO expander bus
Thread-Index: AQHdLmTh4U3ixgbzm0i1idtkA3CMobak8CrK
Date: Wed, 19 Aug 2026 06:47:09 +0000
Message-ID: <FRYP281MB3387040C3F87F8D9F0A99C4291A52@FRYP281MB3387.DEUP281.PROD.OUTLOOK.COM>
References: <FRYP281MB3387C2011F156C1D4F36C05291A72@FRYP281MB3387.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FRYP281MB3387C2011F156C1D4F36C05291A72@FRYP281MB3387.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ipetronik.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FRYP281MB3387:EE_|FR3P281MB3053:EE_
x-ms-office365-filtering-correlation-id: c0a1adfe-9f67-4f51-19a3-08defdbdb11f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|6133799003|3023799007|5023799004|22082099003|18002099003|8096899003|13003099007|38070700021;
x-microsoft-antispam-message-info: zbdGoPj57eHKkFpXKlP5dp8XfjxRu23BpmoFTCbsUHUOhmfWprParfzp9Z8Yv7gQWhxETZBsk62SKf45vQbxvpH4qa1CtM24xNJDjVGh04SspRW0VZR+K1QVxVEVJtHcNvJ/+yw/u8rJWzB1cfJZR7ja/XcrOJvCaIAdxsIpwhkkwv3H8hEIuEisYQNixn7BzWQMujxNCssk2LpbBuvQd5eKml8HQOG4b9h2RQAIGIfjQzz4ANPCJ0cXk/lNjdCtvaJwJ0lgFVKiRYazvSmqRRlmpiOJCbLeXfN/Zk7HS3QozrL+5et5sZ4TiKZwRe/IAAIPVVhl3rrgEQgALfXESBQtZgBMMdb/doCibWlOE8SQ/iUFk1QDHXu8ZXhOSSRplbrTGYs9Zn7JtSV5hHFgO0iexQRS/u7gAz7a1F51tC+LjZ0cRfMkrHQZQNLYg6WYud6TwYpn0Klt/d8OQ99vOCLaOZA0g3d8/HXRwFHDP6co+sbi4S1leCItYdKYiOkwdjhzH/IVTOHKERFckljM9VzUIX64X530pZ8EzNjBQwEGAENB6tD6BSTsMonlmNHJg618KR9P650DJ9goHukhDVMyah/wqPoj+nwik2ocbYkSTpCtN8bCx2lskNF6OhiNU0+VMIEBEc/xsUKqC7nDO64iWHmK2zwMX/+J5KLc9EA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:FRYP281MB3387.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(6133799003)(3023799007)(5023799004)(22082099003)(18002099003)(8096899003)(13003099007)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mEzf3V+bgmvM9+9TMe3XP2EZ8vQChL07xRlq1c2LrnisAvESsoRbgytjeb?=
 =?iso-8859-1?Q?LylqqxhpNB39dKAwnGewupM8gj1AqK3377AH1yaYrpNy/xvS2D9Ecb43iC?=
 =?iso-8859-1?Q?Zle5otL1J9Dvqia70gTQyzOKl3MA4tBIl+SRkh3wZgA7fNXytJ0imWGSGl?=
 =?iso-8859-1?Q?t06YGJe5YlDGkitE+tjcrkRYhTBHRH1NueetPBwP6Qn8778Q8uvozxyO5n?=
 =?iso-8859-1?Q?8EOH8CiNQyHmhUqid6FZOlxeL0IKnBL+8A1Cjs6xjXB2NUDrkAyuS1jsbi?=
 =?iso-8859-1?Q?S+o/ac60ZBvCgYVp4bOoMCOlvNB20p5N8Ozyx7V6tOMew/C97NV8PHA7lQ?=
 =?iso-8859-1?Q?xvyLXzrv2mZMKSawNwHZLXANJmtDwkDxkBR+QuGNnxorTyqvlnGozdmJ4z?=
 =?iso-8859-1?Q?3xuGwtU5h2p0/qAQ8PhqZxUkTxTW9vbO3ZFwEThz4rljQ3Etm3g6AhSWjb?=
 =?iso-8859-1?Q?UG/7Yo6E7djj2UAmgEfpyjL63fwQCXq+/+jk6Siw3JC3vX/vOJfiRWDI/3?=
 =?iso-8859-1?Q?nK/aMqxPO0E+E5rsmQjaNtnmpyMBdfDJEH1PSioyTcB6D8G1TnQDlEnlg/?=
 =?iso-8859-1?Q?Gx8CLjWIXq7qMaM0SHj2lnXweey2/aSHdU7w3WaO7LPaOZU7ytkkY+oBEE?=
 =?iso-8859-1?Q?nro/hbfyZrhaUZINS7zyeUUyFHaSnfv+gbBRnjH1BfX1gSI8Q6x2fgWrKB?=
 =?iso-8859-1?Q?jgd2aY1KQTQeF8BCvkE5bwY7jaqCYP2MMup047rKw3HNIC5f8JwDnom0Ek?=
 =?iso-8859-1?Q?pjU5yE2f2Y7iZWqh1U5gwu+At9+EXaF8h+7cZdzYGUomsoItCNuFxmc7Xx?=
 =?iso-8859-1?Q?wr3iYA9whnX9Zze11MIEjjRd7O5dwAz46wL3TObPnX3mVV/rRPghI0iEZr?=
 =?iso-8859-1?Q?B6Mg/g1W/6iwtsJsCvvwUhHTbk8+g2+Kb07zG+14nON3u9v56gD7NHnUcj?=
 =?iso-8859-1?Q?UyvNAVGogI75nYBfzWQULU9SJhtrysvNWWVZyUNDlkQb2H/nMwM+6Mkj2+?=
 =?iso-8859-1?Q?3/w2h4bUGY9iFNnrQUjEp3+6FdhiR6fA2FZm1apT3NzFYy6jx7v8r5tUh2?=
 =?iso-8859-1?Q?KPDrLKYa8iuEvXwvQCwbH4QFYrdRhAUV7Wqg5lG1cYAaO0Cdz2veEpBk9P?=
 =?iso-8859-1?Q?L96lbXvzApQ/XgQ4xX+DksuzIb+WVUjlibz3r2xpV/Ym5SUCgumCmJKSYF?=
 =?iso-8859-1?Q?8ijmHqV0rtFREpZBBr8oZtj1xIhxCiUJptZEf6l+681hUQ0ETtdUkw25Xx?=
 =?iso-8859-1?Q?qy2mrjhiw4F7DRX1e8kZF3jlOrU+T/9fTRCjqiRjvOwm33145ucsjSdrlJ?=
 =?iso-8859-1?Q?s8TgfDAUH8TuTSyy6Vp4dyHbjNd1lxNl2cDzbHiGtHwDJegFoNO7N13up7?=
 =?iso-8859-1?Q?On4JQqsqep9kFcT8CwMmKjvLNaUyYftLZK1eHmQLRAR3s8TT+Ul7gbhvje?=
 =?iso-8859-1?Q?0920QcQmM8pKjKNBLCoYMMAui8HuJdwsti1i6w+rrVlYSCuDiPV29EadV1?=
 =?iso-8859-1?Q?qwgEiSMZwZF0IShs0gYx2OOUMl2LjqUWbafebj7Qmlcu1xbITQMuNsOgRo?=
 =?iso-8859-1?Q?BpSlwk1KAAXUXs8IkbkjQqs0Yv8gqW6po0Pz/GBTHXw4/pKvs0M17hpZSK?=
 =?iso-8859-1?Q?gzHTeY5qqvlZEUxPEq9nF3T4lZ8X2iDZtUhRYMAR7jH8t8VP5RbrlUangL?=
 =?iso-8859-1?Q?b5smPXR0El37YXrAMMKgUkZJy1htkMJj+LFZaz4GY8OALXN3rx4b5x+re9?=
 =?iso-8859-1?Q?3fuTHprhV9QpUcXCDNDxt1xsh/zGm0xWHmmVPcMh6MvtSBJvHiu5ZVLQaO?=
 =?iso-8859-1?Q?ErQQQnGjaMFfBz/JOJpQI7oKP5OSRvQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_FRYP281MB3387040C3F87F8D9F0A99C4291A52FRYP281MB3387DEUP_"
MIME-Version: 1.0
X-OriginatorOrg: ipetronik.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRYP281MB3387.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a1adfe-9f67-4f51-19a3-08defdbdb11f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2026 06:47:09.4743 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 982fe058-7d80-4936-bdfa-9bed4f9ae127
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5BLZYcjv8/LN7ToB/CXun5EKzs/bdPzC8cJrVL+V65wABDjRNFR3htmzxWBgNm+BrHXqblLLv4Y/565nAmb+30onngcW9OSAc71TaYn/GPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB3053
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

--_000_FRYP281MB3387040C3F87F8D9F0A99C4291A52FRYP281MB3387DEUP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

Follow-up to my earlier report (no replies yet, but we made concrete
progress on our end that narrows this down significantly).

We built the ice driver from a 6.14-based kernel (our original test
system was on 6.12, which lacks the devlink health reporters) and
tested the same board on different host hardware. The original EINVAL/
EIO behavior on every topology-dependent AQ command reproduces
identically on this new setup - so that part is confirmed independent
of host platform, CPU, and kernel version.

With devlink health now available, we finally got a direct,
plain-text firmware diagnosis instead of raw AQ error codes:

  $ devlink health diagnose pci/0000:05:00.0 reporter fw
  Syndrome: 274  Description: LOM topology netlist is corrupted.
  Possible Solution: Update to the latest NVM image.

  $ devlink health diagnose pci/0000:05:00.0 reporter port
  Syndrome: 275  Description: Unrecoverable netlist error.
  Possible Solution: Update to the latest NVM image.
  Port Number: 0

  $ devlink health diagnose pci/0000:05:00.1 reporter port
  Syndrome: 0
  (ports .4 and .5 likewise report Syndrome: 0 on the port reporter)

So: the "fw" reporter (global) reports netlist corruption on all 4
PFs identically, but the "port" reporter only flags an actual
unrecoverable error on port 0 - ports 1-3 come back clean. Combined
with the dmesg output being identical on all 4 ports ("Get PHY
capabilities failed status =3D -5" / "ice_init_nvm_phy_type failed: -5"),
our working theory is that netlist/topology processing walks the
node table in order, hits an unrecoverable condition at the first
cage node (port 0), and aborts the entire walk - which would explain
why ports 1-3 are simply never reached/checked (hence "healthy" by
omission) while the overall topology init still fails for all 4 PFs.

We're fairly confident this isn't a NVM data-integrity problem in the
usual sense:
- The board is already on the latest available NVM/FW (5.01,
  EETRACK 80021FBF; nvmupdate reports "Update Not Available")
- We reverse-engineered the Link Topology Netlist (TLV 0x11B) from
  our image and confirmed it's byte-for-byte identical to Intel's own
  E810_XXVDA4 reference image at the node/IO table level (PCA9575 I2C
  GPIO expander correctly present at Bus 4, RESET_N/INT_N on native
  SDP5/SDP6, matching the datasheet's "4x SFP Native" reference
  schematic, Section 17.2.2.1)
- Re-verified this against the actual flashed chip content (ethtool -e
  readback) after a fresh NVM update - identical result
- NVM Update Checksum (AQ 0x0706) reports valid
- GL_MNG_FWSM and GL_MNG_SHA_EXTEND_STATUS (read via UEFI Shell/BAR0,
  pre-OS) show a completely clean boot: main FW authenticated (STAGE=3D
  100b), no POR_AL_FAILURE/PCIR_AL_FAILURE, no EXT_ERR_IND, FW_MODES
  bit1 (Recovery Mode) =3D 0

Given all of that checks out, "corrupted" seems to mean something
more like a structural/semantic validation failure specific to the
port-0 cage node (or something processed immediately before it),
rather than actual bit-level data corruption - but we don't have
visibility into what that validation actually checks.

Questions, now with concrete syndrome data attached:

- What does the firmware's netlist walk actually validate at/around
  the first cage node that could produce "Unrecoverable netlist error"
  (syndrome 275) specifically for port 0, while leaving ports 1-3
  unflagged?
- Is there a way to get more granular logging out of this
  specifically (we tried fwlog modules i2c/link_topo/health/adminq via
  debugfs, and can correlate some opaque message IDs with specific
  AQ calls, but can't decode their actual content without an internal
  format-string table)?
- The suggested remediation ("update to latest NVM image") doesn't
  apply since we're already on the latest - is there a separate
  netlist/board-config bundle that could be out of sync independent
  of the FW/NVM version number?

Happy to share the full netlist dump, oscilloscope captures, and raw
AQ traces if that's useful to anyone looking into this.

Thanks,
Fabrice


________________________________
Von: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> im Auftrag von Ho=
ffmann, Fabrice <Fabrice.Hoffmann@ipetronik.com>
Gesendet: Montag, 17. August 2026 18:25
An: intel-wired-lan@osuosl.org <intel-wired-lan@osuosl.org>
Betreff: [Intel-wired-lan] [BUG] ice: E810-CAM1 custom board - topology/net=
list resolution fails (EINVAL on all AQ topology commands), no I2C activity=
 on GPIO expander bus

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

Impressum/Imprint: https://www.ipetronik.com/impressum

--_000_FRYP281MB3387040C3F87F8D9F0A99C4291A52FRYP281MB3387DEUP_
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
Hi all,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Follow-up to my earlier report (no replies yet, but we made concrete</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
progress on our end that narrows this down significantly).</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
We built the ice driver from a 6.14-based kernel (our original test</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
system was on 6.12, which lacks the devlink health reporters) and</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
tested the same board on different host hardware. The original EINVAL/</div=
>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
EIO behavior on every topology-dependent AQ command reproduces</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
identically on this new setup - so that part is confirmed independent</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
of host platform, CPU, and kernel version.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
With devlink health now available, we finally got a direct,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
plain-text firmware diagnosis instead of raw AQ error codes:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; $ devlink health diagnose pci/0000:05:00.0 reporter fw</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; Syndrome: 274 &nbsp;Description: LOM topology netlist is corrupted.<=
/div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; Possible Solution: Update to the latest NVM image.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; $ devlink health diagnose pci/0000:05:00.0 reporter port</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; Syndrome: 275 &nbsp;Description: Unrecoverable netlist error.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; Possible Solution: Update to the latest NVM image.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; Port Number: 0</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; $ devlink health diagnose pci/0000:05:00.1 reporter port</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; Syndrome: 0</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; (ports .4 and .5 likewise report Syndrome: 0 on the port reporter)</=
div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
So: the &quot;fw&quot; reporter (global) reports netlist corruption on all =
4</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
PFs identically, but the &quot;port&quot; reporter only flags an actual</di=
v>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
unrecoverable error on port 0 - ports 1-3 come back clean. Combined</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
with the dmesg output being identical on all 4 ports (&quot;Get PHY</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
capabilities failed status =3D -5&quot; / &quot;ice_init_nvm_phy_type faile=
d: -5&quot;),</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
our working theory is that netlist/topology processing walks the</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
node table in order, hits an unrecoverable condition at the first</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
cage node (port 0), and aborts the entire walk - which would explain</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
why ports 1-3 are simply never reached/checked (hence &quot;healthy&quot; b=
y</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
omission) while the overall topology init still fails for all 4 PFs.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
We're fairly confident this isn't a NVM data-integrity problem in the</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
usual sense:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
- The board is already on the latest available NVM/FW (5.01,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; EETRACK 80021FBF; nvmupdate reports &quot;Update Not Available&quot;=
)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
- We reverse-engineered the Link Topology Netlist (TLV 0x11B) from</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; our image and confirmed it's byte-for-byte identical to Intel's own<=
/div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; E810_XXVDA4 reference image at the node/IO table level (PCA9575 I2C<=
/div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; GPIO expander correctly present at Bus 4, RESET_N/INT_N on native</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; SDP5/SDP6, matching the datasheet's &quot;4x SFP Native&quot; refere=
nce</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; schematic, Section 17.2.2.1)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
- Re-verified this against the actual flashed chip content (ethtool -e</div=
>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; readback) after a fresh NVM update - identical result</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
- NVM Update Checksum (AQ 0x0706) reports valid</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
- GL_MNG_FWSM and GL_MNG_SHA_EXTEND_STATUS (read via UEFI Shell/BAR0,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; pre-OS) show a completely clean boot: main FW authenticated (STAGE=
=3D</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; 100b), no POR_AL_FAILURE/PCIR_AL_FAILURE, no EXT_ERR_IND, FW_MODES</=
div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; bit1 (Recovery Mode) =3D 0</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Given all of that checks out, &quot;corrupted&quot; seems to mean something=
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
more like a structural/semantic validation failure specific to the</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
port-0 cage node (or something processed immediately before it),</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
rather than actual bit-level data corruption - but we don't have</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
visibility into what that validation actually checks.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Questions, now with concrete syndrome data attached:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
- What does the firmware's netlist walk actually validate at/around</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; the first cage node that could produce &quot;Unrecoverable netlist e=
rror&quot;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; (syndrome 275) specifically for port 0, while leaving ports 1-3</div=
>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; unflagged?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
- Is there a way to get more granular logging out of this</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; specifically (we tried fwlog modules i2c/link_topo/health/adminq via=
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; debugfs, and can correlate some opaque message IDs with specific</di=
v>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; AQ calls, but can't decode their actual content without an internal<=
/div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; format-string table)?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
- The suggested remediation (&quot;update to latest NVM image&quot;) doesn'=
t</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; apply since we're already on the latest - is there a separate</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; netlist/board-config bundle that could be out of sync independent</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp; of the FW/NVM version number?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Happy to share the full netlist dump, oscilloscope captures, and raw</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
AQ traces if that's useful to anyone looking into this.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Thanks,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Fabrice</div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>Von:</b> Intel-wired-lan &lt;intel-wired-lan-bounces@osuosl.org&gt; im A=
uftrag von Hoffmann, Fabrice &lt;Fabrice.Hoffmann@ipetronik.com&gt;<br>
<b>Gesendet:</b> Montag, 17. August 2026 18:25<br>
<b>An:</b> intel-wired-lan@osuosl.org &lt;intel-wired-lan@osuosl.org&gt;<br=
>
<b>Betreff:</b> [Intel-wired-lan] [BUG] ice: E810-CAM1 custom board - topol=
ogy/netlist resolution fails (EINVAL on all AQ topology commands), no I2C a=
ctivity on GPIO expander bus
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
Hi all,</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
We're bringing up a custom 4x SFP+ 10G NIC (2x Intel E810-CAM1, following</=
div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
Intel's documented &quot;4x SFP Native&quot; reference topology from the E8=
10</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
datasheet, Section 17.2.2.1, including the PCA9575 I2C GPIO expander on</di=
v>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
Bus 4 / MDC4_SCL4 / MDIO4_SDA4). We've hit a reproducible issue where</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
topology-dependent Admin Queue commands consistently fail with EINVAL,</div=
>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
and no I2C activity is ever observed on Bus 4, even though the NVM</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
netlist content has been verified byte-for-byte identical to Intel's</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
own reference image. We'd appreciate any input, since we've run out of</div=
>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
public documentation to check against.</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
System: kernel 6.12.42, ice driver, 4 PFs enumerate correctly</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
(8086:1593, functions .0/.1/.4/.5). NVM: E810_SFP_10G_NRB_SEC_FW,</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
currently 1p8p0p2 / NVM 5p01 (EETRACK 80021FBF), successfully flashed</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
and verified. An earlier, unrelated boot issue (NVM/QSPI access</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
occasionally skipped at POR, thermal sensitivity) has already been</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
root-caused and resolved separately.</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
WHAT WE'VE VERIFIED:</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
1. Netlist content is correct</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;We reverse-engineered the Link Topology Netlist (TLV TypeID 0x=
11B)</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;from our NVM image and confirmed the PCA9575 (I2C addr 0x20, H=
andle</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;29) is present with RESET_N/INT_N on native GPIO (SDP5/SDP6) a=
nd I2C</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;on Bus 4 (Driving IO#4 of the SoC I/O Widget node, Handle 0) -=
 byte</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;for byte identical to Intel's E810_XXVDA4 reference NVM image.=
 We</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;re-verified this against the actual flashed chip content (via<=
/div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;`ethtool -e`) after a fresh NVM update, with identical results=
.</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
2. Admin Queue commands consistently fail with EINVAL, not EBUSY</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;`ethtool -m &lt;iface&gt;` (Read/Write SFF EEPROM, opcode 0x06=
EE) returns</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;&quot;Input/output error&quot; every time. Raw AQ trace via dy=
namic debug shows</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;the command is correctly formed (logical port 0, I2C addr 0x50=
,</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;offset 0, read op), but firmware responds with retval 0x000E</=
div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;(EINVAL) - not 0x0C (EBUSY), which is the documented code for =
a real</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;I2C bus timeout/busy condition. Response time across 50 consec=
utive</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;calls: 40-68us, essentially constant with no jitter - too fast=
 and</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;too regular for an actual I2C bus attempt (100kHz would need &=
gt;90us</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;just for address+ACK).</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;Same failure class shows up independently via `ethtool -d`: th=
e</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;&quot;Extended Regs&quot; (SerDes equalization) section, which=
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;ice_get_extended_regs() only populates after a successful</div=
>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;ice_get_port_topology() -&gt; &quot;Get Netlist Node&quot; AQ =
call (Cage context),</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;is entirely zero-filled.</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;At boot, dmesg shows the same thing on all 4 ports identically=
:</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp; &nbsp;ice 0000:01:00.0: Get PHY capabilities failed status =
=3D -5, continuing anyway</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp; &nbsp;ice 0000:01:00.0: ice_init_nvm_phy_type failed: -5</div=
>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;(via ICE_AQC_REPORT_TOPO_CAP)</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
3. No I2C activity observed, ever</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;Oscilloscope on Bus 4 (I2C_CLK/I2C_DAT) shows the line pulled =
high at</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;power-up (pull-up confirmed functional), and going low briefly=
 very</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;early in boot - but never toggling again, confirmed over a 10s=
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;capture window. Same result on Bus 0 (native SFP0 module bus) =
when</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;triggered explicitly at runtime via ethtool -m. A known-good I=
ntel</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;reference card (E810-XXVDA4, tested standalone on a motherboar=
d with</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;no CPU installed at all) reliably shows a clean, well-formed 1=
00kHz</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;I2C burst on Bus 4 around 860-920ms post power-on. Our board s=
hows</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;nothing there.</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
4. QSPI timing shows a reproducible 1.7s stall + oversized retry</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;Comparing raw QSPI_CLK captures (CSV, edge timestamps) between=
 our</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;board and the reference: both match closely up through ~860ms<=
/div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;(including an ~334ms linear read phase we believe is FW SHA</d=
iv>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;authentication). At that point the reference proceeds into sma=
ll,</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;regular ~90-100ms housekeeping bursts continuing indefinitely.=
 Our</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;board instead goes completely silent for ~1.72s, then produces=
 a</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;single burst ~3x larger (by edge count) than the reference's</=
div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;equivalent config-read burst, then goes silent again. This</di=
v>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;stall-then-oversized-retry pattern repeats up to 3 times withi=
n a</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;10s window, never resolving into the reference's steady-state<=
/div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;pattern, and never followed by any I2C activity.</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
5. Chip-level status registers show a clean boot, no recovery mode</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;Read directly via UEFI Shell (BAR0 memory-mapped, before any O=
S/</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp;driver loads):</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp; &nbsp;GL_MNG_SHA_EXTEND_STATUS (0x00083148): STAGE=3D100b, FW=
_HALTED=3D0,</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp;DONE=3D1 -&gt; main FW authenticated and running=
 cleanly</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp; &nbsp;GL_MNG_FWSM (0x000B6134): 0x00000000 -&gt; no POR_AL_FA=
ILURE, no</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp;PCIR_AL_FAILURE, no EXT_ERR_IND. Per datasheet S=
ection 15.4.3,</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp;FW_MODES bit 1 (Recovery Mode indication) =3D 0,=
 so Recovery Mode</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp;is explicitly ruled out.</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp; &nbsp;GL_FWSTS (0x00083048): FWROWD (bit 8, Firmware Reset on=
 Watchdog) =3D</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp;0 -&gt; no watchdog-triggered reset flagged.</di=
v>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
QUESTIONS:</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
- What internal criteria does firmware use to decide a netlist</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; configuration is invalid/incompatible for a given port (this exact</=
div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; phrase - &quot;Incompatible Netlist configuration&quot; - appears in=
 datasheet</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; Section 15.4.1.1 as a named recovery-triggering failure scenario, bu=
t</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; the detection logic itself isn't documented anywhere we can find)?</=
div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
- Is there a way to enable FW logging (i2c / link_topology modules)</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; early enough to catch whatever happens in the ~860ms-2.6s window,</d=
iv>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; given the host driver isn't loaded yet at that point on a normal</di=
v>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; boot?</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
- Given verified-identical netlist content, clean POR/auth status, and</div=
>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; no recovery mode - but consistent EINVAL on every topology-dependent=
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; AQ command on all 4 ports - what would cause exactly this</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&nbsp; combination?</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
Happy to share the full netlist dump, raw AQ traces, and oscilloscope</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
CSVs if useful. Thanks for reading this far.</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
Best regards,</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: &quot;Courier New&quot;; font-si=
ze: 10.5pt; color: rgb(53, 56, 56);">
Fabrice Hoffmann</div>
<div id=3D"x_Signature">
<p style=3D"direction: ltr; background-color: white; margin: 0cm 0cm 0.0001=
pt; font-family: Calibri, sans-serif; font-size: 11pt;">
<span style=3D"font-family: &quot;Courier New&quot;; font-size: 10.5pt; col=
or: rgb(53, 56, 56);">Development</span></p>
<p style=3D"direction: ltr; background-color: white; margin: 0cm 0cm 0.0001=
pt; font-family: Calibri, sans-serif; font-size: 11pt;">
<span style=3D"font-family: &quot;Courier New&quot;; font-size: 10.5pt; col=
or: rgb(53, 56, 56);">&nbsp;</span></p>
<p style=3D"direction: ltr; background-color: white; margin: 0cm 0cm 0.0001=
pt; font-family: Calibri, sans-serif; font-size: 11pt;">
<span style=3D"font-family: &quot;Courier New&quot;; font-size: 10.5pt; col=
or: rgb(53, 56, 56);">IPETRONIK GmbH &amp; Co.KG</span></p>
<p style=3D"direction: ltr; background-color: white; margin: 0cm 0cm 0.0001=
pt; font-family: Calibri, sans-serif; font-size: 11pt;">
<span style=3D"font-family: &quot;Courier New&quot;; font-size: 10.5pt; col=
or: rgb(53, 56, 56);">Im Rollfeld 28</span></p>
<p style=3D"direction: ltr; background-color: white; margin: 0cm 0cm 0.0001=
pt; font-family: Calibri, sans-serif; font-size: 11pt;">
<span style=3D"font-family: &quot;Courier New&quot;; font-size: 10.5pt; col=
or: rgb(53, 56, 56);">D-76532 Baden-Baden&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</sp=
an></p>
<p style=3D"direction: ltr; background-color: white; margin: 0cm 0cm 0.0001=
pt; font-family: Calibri, sans-serif; font-size: 11pt;">
<span style=3D"font-family: &quot;Courier New&quot;; font-size: 10.5pt; col=
or: rgb(53, 56, 56);">&nbsp;</span></p>
<p style=3D"direction: ltr; background-color: white; margin: 0cm 0cm 0.0001=
pt; font-family: Calibri, sans-serif; font-size: 11pt;">
<span style=3D"font-family: &quot;Courier New&quot;; font-size: 10.5pt; col=
or: rgb(53, 56, 56);">Phone: +49 7221 9922-486</span></p>
<p style=3D"direction: ltr; background-color: white; margin: 0cm 0cm 0.0001=
pt; font-family: Calibri, sans-serif; font-size: 11pt;">
<span style=3D"font-family: &quot;Courier New&quot;; font-size: 10.5pt; col=
or: rgb(53, 56, 56);">Fax: +49 7221 9922-59486</span></p>
<p style=3D"direction: ltr; background-color: white; margin: 0cm 0cm 0.0001=
pt; font-family: Calibri, sans-serif; font-size: 11pt;">
<span style=3D"font-family: &quot;Courier New&quot;; font-size: 10.5pt; col=
or: rgb(0, 0, 0);"><a href=3D"mailto:%0dmailto:%20Fabrice.Hoffmann@ipetroni=
k.com" id=3D"OWAf546384d-c606-9b1d-d778-5dd0a41e511f" class=3D"x_OWAAutoLin=
k" style=3D"color: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px;"><u>m=
ailto:
</u></a></span><span style=3D"font-family: &quot;Courier New&quot;; font-si=
ze: 10.5pt; color: blue;"><a href=3D"mailto:%0dmailto:%20Fabrice.Hoffmann@i=
petronik.com" id=3D"OWA88cfe3e9-e613-0a68-cbf4-a2e551a3fd51" class=3D"x_OWA=
AutoLink" style=3D"color: blue; margin-top: 0px; margin-bottom: 0px;"><u>Fa=
brice.Hoffmann@ipetronik.com</u></a></span></p>
<p style=3D"direction: ltr; background-color: white; margin: 0cm 0cm 0.0001=
pt; font-family: Calibri, sans-serif; font-size: 11pt;">
<span style=3D"font-family: &quot;Courier New&quot;; font-size: 10.5pt; col=
or: rgb(53, 56, 56);">web:
</span><span style=3D"font-family: &quot;Courier New&quot;; font-size: 10.5=
pt; color: blue;"><a href=3D"http://www.ipetronik.com" id=3D"OWA6a1205a8-27=
45-d2a1-a217-c0a127772af3" class=3D"x_OWAAutoLink" data-auth=3D"NotApplicab=
le" style=3D"color: blue; margin-top: 0px; margin-bottom: 0px;"><u>http://w=
ww.ipetronik.com</u></a></span></p>
<p style=3D"direction: ltr; margin: 0cm 0cm 0.0001pt; font-family: Calibri,=
 sans-serif; font-size: 11pt;">
&nbsp;</p>
</div>
<div style=3D"direction: ltr;"><br>
</div>
<p style=3D"direction: ltr; margin-top: 0px; margin-bottom: 0px;">Impressum=
/Imprint: https://www.ipetronik.com/impressum</p>
<br>
<p class=3D"MsoNormal">Impressum/Imprint: https://www.ipetronik.com/impress=
um<o:p></o:p></p>
</body>
</html>

--_000_FRYP281MB3387040C3F87F8D9F0A99C4291A52FRYP281MB3387DEUP_--
