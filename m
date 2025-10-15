Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47A4CCD195
	for <intel-wired-lan@archiver.kernel.org>; Wed, 15 Oct 2025 09:16:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B3256144C;
	Wed, 15 Oct 2025 09:16:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BwwIpKPJ2v9m; Wed, 15 Oct 2025 09:16:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D66D46158D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1760519782;
	bh=/74irLiD/rz2pyWn35+SEEqisKF8OFHcvPmn2Po0YD8=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vrHk8y1s3bw//Q2cWGa4Zd3jnZBivrWXbdkQIcxWj15MxGdzEP5S/iuxLNMM45Nyb
	 unFQVKQxEOZqHYxIXVwHsDNMDXsTdnKLyBjLiA2jix4sZZ8UN6G+T5JnA5R1OX94u2
	 euAfb4YLfk1WpnDSoAITr18RlHaS1kkwHQtjQ2FFMJCiIJD/3svfzkODkXF8vEieH4
	 xcNTaW/TQ/CS2ulBVNH3SFYLoArYslZ/KWtcbHZFOQhj82VOOYPF83gTQg95Qs1yG0
	 Jw3+TC4E/5UJf007RT//NXWEbkNx9ydL9362CCfMbf8UW4C3L0mD1HU+iG+Rb4Mlmv
	 vJz/WSDRkdGHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D66D46158D;
	Wed, 15 Oct 2025 09:16:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 337D94C4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Oct 2025 09:16:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2FA3A6152D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Oct 2025 09:16:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T_8Bk7xABCU8 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 15 Oct 2025 09:16:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:4f8:1c1b:7813::1; helo=bkemail.birger-koblitz.de;
 envelope-from=mail@birger-koblitz.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B57636158E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B57636158E
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de
 [IPv6:2a01:4f8:1c1b:7813::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B57636158E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Oct 2025 09:16:19 +0000 (UTC)
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
 id 8F0724854F; Wed, 15 Oct 2025 09:16:15 +0000 (UTC)
Received: from [IPV6:2a00:6020:47a3:e800:94d3:d213:724a:4e07] (unknown
 [IPv6:2a00:6020:47a3:e800:94d3:d213:724a:4e07])
 by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 78FB6484E4;
 Wed, 15 Oct 2025 09:16:05 +0000 (UTC)
Message-ID: <0d2b88ac-d23d-43a5-813d-2a8c4edaa3eb@birger-koblitz.de>
Date: Wed, 15 Oct 2025 11:16:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251014-10gbx-v2-1-980c524111e7@birger-koblitz.de>
 <21a53fe4-7cad-4717-87db-2f433659e174@molgen.mpg.de>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <21a53fe4-7cad-4717-87db-2f433659e174@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=birger-koblitz.de; 
 s=default; t=1760519775;
 bh=T0AYQjcYUXwKwFItR8IpyQ2sLUmEmwaqS1bby4hv2K4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fgd2Wpx1MLC43z585qDyMq+W8KnJKWZD/uWr8nHDcHR7r/ManA4HSZQzuv0ATPev7
 3f4QLs9prlWBRp469rMqBQ7jZ61UskiV/0L6F/6tgUBgcQkmIvPS5nq6+WKNaw+Gyp
 Qv1a18SsTYsjHStuTp/aMGF3ww0PdBZr1oRGideydJKMXAlCTPvsKoDeoUNXxpZqBG
 qy1Tdu9+zFSMWQUXsMDr/pLfWuEMa2ZQtRRN/cf4LN4naRAqEpzmuB4VPbTsh9ZrW7
 CK1jusDP765hr6tKMclgExPnxkmnQYRujJdXrO29oSJeuSDQOD4Uqf8677LYM/jzHN
 9TMGdOgCF+21Q==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=birger-koblitz.de; 
 s=default; t=1760519765;
 bh=T0AYQjcYUXwKwFItR8IpyQ2sLUmEmwaqS1bby4hv2K4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fxXL+UWl2tLv1eu/uap1tqyzE7ORIVf35shixhwoTKsYAUbBN+72K3cPRx+l6CMGG
 erTDtb8dAajLKMdoHB8neU+9L25ukvFO3z3sxWFHuhqpXPG5f45POoQe7GOvaAdp+B
 ZS3xlxbXEpAnFfJw7L5qb5mHp2zPozS5mo83hVd6Qz/i+LEvvYtZaAyF5XszYi2QTa
 Rj6t4GfXwjUQkdIwNHWqiiy+el+K3u5ssoGYgh4VJGDuzv+u5odccTDbYsoF324kgz
 xJQfSjqoCPokJWr5SmthRZ1NfOfPf2haFuVLpoEQYX+LcxlEOTmc6Z9KT07TlJPg6N
 ZZ9HyasYcXxmg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=birger-koblitz.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=birger-koblitz.de
 header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default
 header.b=fgd2Wpx1; 
 dkim=pass (2048-bit key) header.d=birger-koblitz.de
 header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default
 header.b=fxXL+UWl
Subject: Re: [Intel-wired-lan] [PATCH net-next v2] ixgbe: Add 10G-BX support
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

Dear Paul,

thank you for your feedback!

On 15/10/2025 9:59 am, Paul Menzel wrote:
> Am 14.10.25 um 06:18 schrieb Birger Koblitz:
>> Adds support for 10G-BX modules, i.e. 10GBit Ethernet over a single 
>> strand
>> Single-Mode fiber
> 
> I’d use imperative mood, and add a dot/period at the end.
I will put this into the next patch-version.

>> @@ -1678,6 +1680,31 @@ int ixgbe_identify_sfp_module_generic(struct 
>> ixgbe_hw *hw)
>>               else
>>                   hw->phy.sfp_type =
>>                       ixgbe_sfp_type_1g_bx_core1;
>> +        /* Support Ethernet 10G-BX, checking the Bit Rate
>> +         * Nominal Value as per SFF-8472 to be 12.5 Gb/s (67h) and
>> +         * Single Mode fibre with at least 1km link length
>> +         */
>> +        } else if ((!comp_codes_10g) && (bitrate_nominal == 0x67) &&
>> +               (!(cable_tech & IXGBE_SFF_DA_PASSIVE_CABLE)) &&
>> +               (!(cable_tech & IXGBE_SFF_DA_ACTIVE_CABLE))) {
>> +            status = hw->phy.ops.read_i2c_eeprom(hw,
>> +                        IXGBE_SFF_SM_LENGTH_KM,
>> +                        &sm_length_km);
>> +            if (status != 0)
>> +                goto err_read_i2c_eeprom;
> 
> Should an error be logged?
> 
This needs to be read in the context of the rest of the SFP 
identification function. Several bytes of the EEPROM have already been 
read for module identification by the existing code before reaching this 
point, and failure is handled everywhere by the same goto. What will 
happen if EEPROM reading fails is that an error message will be logged 
that the Module is not supported. This is because the type is not filled 
in and the module therefore considered unsupported. The actual error 
(ret_val = -ENOENT) is ignored e.g. in 
ixgbe_52599/ixgbe_init_phy_ops_82599(). The error logged is probably 
good enough: the module cannot be positively identified and is not 
enabled. I say good enough, because this is actually what is the case: 
the EEPROM is broken and ther

>> +            status = hw->phy.ops.read_i2c_eeprom(hw,
>> +                        IXGBE_SFF_SM_LENGTH_100M,
>> +                        &sm_length_100m);
>> +            if (status != 0)
>> +                goto err_read_i2c_eeprom;
> 
> Should an error be logged?
Same here.

> 
>> +            if (sm_length_km > 0 || sm_length_100m >= 10) {
>> +                if (hw->bus.lan_id == 0)
>> +                    hw->phy.sfp_type =
>> +                        ixgbe_sfp_type_10g_bx_core0;
>> +                else
>> +                    hw->phy.sfp_type =
>> +                        ixgbe_sfp_type_10g_bx_core1;
> 
> I’d prefer the ternary operator, if only the same variable is assigned 
> in both branches.
Me, too. But this is merely code that can be found verbosely the same in 
several places before in this identification function, for each type of 
module identified basically once. If the same code would be written 
differently in this place, it would probably confuse readers who would 
wonder what is different.

Cheers,
   Birger

