Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66579E9A047
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Feb 2026 15:00:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 04D3860851;
	Wed, 18 Feb 2026 15:00:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TlNxSxv1w8GM; Wed, 18 Feb 2026 15:00:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E9D6760855
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771426857;
	bh=+YWw+BtKPGOwvwpaJi/1Rl+06NtGlMhZlG+7LH62l7Q=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r1LcNMCsqpU/N5FRLPVlcwDdyXUyCME420BPUjzhHj97zjP4dKTjaYLrHz49fqVMn
	 loQXixAjpxGqA2whj1zoT7aywFTJ97+wBgPohtoLOP57ese38vK9yFaLSC94f8u3XQ
	 BwuaN5GX6tDAhCnYCyK2PTELCexkxy5Mx1xKtpyPwQVa/H8SMXDRx46KqdmXdW/2NY
	 2FG2SGIdnpaST1SBgIEq0bvhsyCUH0kPQNh/Tysb/+rWiVSyn8gWd7dg1PF75aB3sZ
	 ROA+ut3EADN2g+70lgSRPQiCtoQa9H+bF4Uv+VeSk1HHHBmUQV2sJ8ZmewGltds55+
	 Xqp9u2wap47Qg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E9D6760855;
	Wed, 18 Feb 2026 15:00:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 67CA2206
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 15:00:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4CBAC407C0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 15:00:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c7MIy38gM1y1 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Feb 2026 15:00:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5010A407AF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5010A407AF
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5010A407AF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 15:00:52 +0000 (UTC)
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6FC0E4C44303CF;
 Wed, 18 Feb 2026 16:00:37 +0100 (CET)
Message-ID: <73aab9d3-996f-4df6-8f04-9f216cf51e92@molgen.mpg.de>
Date: Wed, 18 Feb 2026 16:00:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, it+intel-wired-lan@molgen.mpg.de
References: <d30060f0-e7aa-4d3e-8e7d-98e7ca176f9c@molgen.mpg.de>
 <b235e4e1-3a1c-4b09-bf4f-bd23d308e3e7@molgen.mpg.de>
 <3f6918da-0fcd-4a87-bca2-adbd1d88100b@intel.com>
 <1cbf468e-45f5-4fe8-9ab7-06925ff1ccaf@molgen.mpg.de>
Content-Language: en-US
In-Reply-To: <1cbf468e-45f5-4fe8-9ab7-06925ff1ccaf@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] ice: E810-XXV: Dell GBIC S28-10G-25G-SR-85C
 does not work
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

Dear Tony,


One more follow-up:

Am 18.02.26 um 13:09 schrieb Paul Menzel:

> Am 17.02.26 um 19:16 schrieb Tony Nguyen:
> 
>> On 2/17/2026 9:15 AM, Paul Menzel wrote:
> 
>> I spoke to one of our link people about this.
>>
>>> It works with Broadcom network controller BCM57414:
>>>
>>>      $ lspci -nn -s c4:00
>>>      c4:00.0 Ethernet controller [0200]: Broadcom Inc. and subsidiaries BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller [14e4:16d7] (rev 01)
>>>      c4:00.1 Ethernet controller [0200]: Broadcom Inc. and subsidiaries BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller [14e4:16d7] (rev 01)
>>>
>>> The difference seems to be that the Broadcom device supports auto- 
>>> negotiation, and the Intel device does not:
>>
>> Strictly speaking, optical links do not provide auto-negotiation.
>>
>>> Intel E810-XXV:
>>>
>>>      Supported ports: [ FIBRE ]
>>>      Supported link modes:   1000baseT/Full
>>>                              10000baseT/Full
>>>                              25000baseCR/Full
>>>                              25000baseSR/Full
>>>                              1000baseX/Full
>>>                              10000baseCR/Full
>>>                              10000baseSR/Full
>>>                              10000baseLR/Full
>>>      Supported pause frame use: Symmetric
>>>      Supports auto-negotiation: No
>>>      Supported FEC modes: None
>>>      Advertised link modes:  25000baseSR/Full
>>
>> The important part is here 10G is not an advertised link mode...
>>
>>>      Advertised pause frame use: No
>>>      Advertised auto-negotiation: No
>>>      Advertised FEC modes: None
>>>      Speed: Unknown!
>>>      Duplex: Unknown! (255)
>>>      Auto-negotiation: off
>>>      Port: FIBRE
>>>      PHYAD: 0
>>>      Transceiver: internal
>>>      Supports Wake-on: d
>>>      Wake-on: d
>>>          Current message level: 0x00000007 (7)
>>>                                 drv probe link
>>>      Link detected: no
>>>
>>> Broadcom BCM57414 NetXtreme-E:
>>>
>>>      Supported ports: [ FIBRE ]
>>>      Supported link modes:   25000baseSR/Full
>>>                              10000baseSR/Full
>>>      Supported pause frame use: Symmetric Receive-only
>>>      Supports auto-negotiation: Yes
>>>      Supported FEC modes: RS     BASER
>>>      Advertised link modes:  25000baseSR/Full
>>>                              10000baseSR/Full
>>
>> ... where it is here.
>>
>>>      Advertised pause frame use: No
>>>      Advertised auto-negotiation: Yes
>>>      Advertised FEC modes: Not reported
>>>      Speed: Unknown!
>>>      Duplex: Unknown! (255)
>>>      Auto-negotiation: on
>>>      Port: FIBRE
>>>      PHYAD: 1
>>>      Transceiver: internal
>>>      Supports Wake-on: g
>>>      Wake-on: d
>>>          Current message level: 0x00002081 (8321)
>>>                                 drv tx_err hw
>>>      Link detected: no
> 
>>>> PS:
>>>>
>>>> ```
>>>> $ ip link show net04
>>>> 7: net04: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq switchid b48351ffff278d44 state DOWN mode DEFAULT group default qlen 1000
>>>>      link/ether b4:83:51:27:8d:44 brd ff:ff:ff:ff:ff:ff
>>>>      alias eth4
>>>> $ sudo ethtool -m net04
>>>>      Identifier                                : 0x03 (SFP)
>>>>      Extended identifier                       : 0x04 (GBIC/SFP defined by 2-wire interface ID)
>>>>      Connector                                 : 0x07 (LC)
>>>>      Transceiver codes                         : 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x02
>>
>> 0x10 would be here for advertised 10G support. It is not, which is
>> why it's not being advertised. He mentioned it's very common for
>> dual rates to claim it on paper but not advertise it properly.
> 
> Thank you for looking into this. It should work in this case, as it 
> works with the Broadcom device.
> 
>> Could you provide the output for 'ethool -m <INT> hex on'?
> 
> Sure. Please find it attached for the Intel and Broadcom device. It’s 
> the same GBIC model and only the serial number should differ.

The Dell support pointed to the section *Known Issues* in the release 
notes of the Intel network controller firmware version 24.0.5 [1]:

>    - When using the dual rate 10G/25G SR optics module (DN# M14MK), linking at 10G may not be
>      possible if auto negotiation is enabled. To workaround this issue, disable Auto Negotiation
>      on the switch interface. On the adapter side:
>       - To obtain 10Gps link on pre-OS environment, set Media Detection to Disabled in Main
>         Configuration Page and in NIC Configuration, uncheck the box labeled 25G and make sure
>         the box for 10G is checked, this will force the link speed to 10Gps. 
>       - To obtain 10Gps link on OS, you will need to manually set the speed to 10Gps. For example,
>         use "ethtool -s INTERFACE advertise 0x80000000000" on Linux.

(I am unclear to what component “if auto negotiation is enabled” refers to.)

Anyway, without changing anything on the switch, running the suggested 
command

     sudo ethtool -s p3p2 advertise 0x80000000000

get the link up:

     ice 0000:81:00.1 p3p2: NIC Link is up 10 Gbps Full Duplex, 
Requested FEC: RS-FEC, Negotiated FEC: NONE, Autoneg Advertised: Off, 
Autoneg Negotiated: False, Flow Control: None

Does the Linux kernel need a quirk to work around the broken firmware. 
(Which hopefully will still be fixed in future releases.)


Kind regards,

Paul


> PS: For completeness:
> 
>      $ ethtool -i net04
>      driver: ice
>      version: 6.12.0-160000.5-default
>      firmware-version: 4.80 0x800206a0 24.0.5
>      expansion-rom-version:
>      bus-info: 0000:81:00.1
>      supports-statistics: yes
>      supports-test: yes
>      supports-eeprom-access: yes
>      supports-register-dump: yes
>      supports-priv-flags: yes


[1]: 
https://dl.dell.com/FOLDER13423820M/2/fw_release_e810_e823-20250910.txt?uid=68fa5efd-5f60-4811-eb0a-05c0b9fee2e5&fn=fw_release_e810_e823-20250910.txt
      "Intel(R) E810 Adapter and E823 LOM Firmware Release Notes for 
Version 24.0.5"
