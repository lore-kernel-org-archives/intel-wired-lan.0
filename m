Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1701CEC01A2
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Mar 2026 08:48:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B644E6071D;
	Mon, 23 Mar 2026 08:48:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZFv-CiNddzOs; Mon, 23 Mar 2026 08:48:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 38920606FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774255711;
	bh=NwfiIYFUihiMhcRpqOdmKn0QgACuzEq8VQM7DgtPGGU=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G8TuQCSKzOppWZfJ/0EkebUIurcxV22/Heuj9e+qvIsk9K0qk3qBir43EgEczI7Rg
	 4dSC1KDuNGBii3YCyHiGWvRQnMvrkXYCAm/J17NEL375sMNLUu3FYfqKC1I8DLwvnH
	 7yNYVlzjLRUedAGJLm2Eo1/Vna1C5YPbDY3tfc2ZW+ERZnY8NGdzE5Bq/ZaiAAgD+/
	 jRBru2Nd92hOj7TOhKY/mXY5EwsGRdkNVqAkEg5/Nuj3e8tP6hPpb09CHrDQpBiJx3
	 b8tX3lgWFJNS7uG5+wVpkI3UILEKqSBt27GX/8x0f06Md0eJ7OghcLsVskk/oyTLDi
	 5PLlIdofuI3iQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 38920606FD;
	Mon, 23 Mar 2026 08:48:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 864A7F4
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Mar 2026 08:48:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 77A6340CDC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Mar 2026 08:48:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z1g3qmiOBHei for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Mar 2026 08:48:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9A88A40CDA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9A88A40CDA
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9A88A40CDA
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Mar 2026 08:48:26 +0000 (UTC)
Received: from [192.168.2.229] (p57bd9b5e.dip0.t-ipconnect.de [87.189.155.94])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id E40664C442FFED;
 Mon, 23 Mar 2026 09:47:49 +0100 (CET)
Message-ID: <cdcedd24-0f26-4366-a6d8-73025d05ce1e@molgen.mpg.de>
Date: Mon, 23 Mar 2026 09:47:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Oros <poros@redhat.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen
 <anthony.l.nguyen@intel.com>,
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20260320135326.1171433-1-poros@redhat.com>
 <310379eb-9b99-444d-bf02-2bde3bd79374@molgen.mpg.de>
 <c2fa7a08-b75d-49a9-8725-fc98217c2dbe@redhat.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <c2fa7a08-b75d-49a9-8725-fc98217c2dbe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] iavf: fix wrong VLAN mask for
 legacy Rx descriptors L2TAG2
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

Dear Petr,


Thank you for your quick and detailed reply.


Am 23.03.26 um 09:37 schrieb Petr Oros:
> 
> On 3/20/26 15:29, Paul Menzel wrote:

>> Am 20.03.26 um 14:53 schrieb Petr Oros:
>>> The IAVF_RXD_LEGACY_L2TAG2_M mask was incorrectly defined as
>>> GENMASK_ULL(63, 32), extracting 32 bits from qw2 instead of the
>>> 16-bit VLAN tag. In the legacy Rx descriptor layout, the 2nd L2TAG2
>>> (VLAN tag) occupies bits 63:48 of qw2, not 63:32.
>>>
>>> The oversized mask causes FIELD_GET to return a 32-bit value where the
>>> actual VLAN tag sits in bits 31:16. When this value is passed to
>>> iavf_receive_skb() as a u16 parameter, it gets truncated to the lower
>>> 16 bits (which contain the 1st L2TAG2, typically zero). As a result,
>>> __vlan_hwaccel_put_tag() is never called and software VLAN interfaces
>>> on VFs receive no traffic.
>>>
>>> This affects VFs behind ice PF (VIRTCHNL VLAN v2) when the PF
>>> advertises VLAN stripping into L2TAG2_2 and legacy descriptors are
>>> used.
>>>
>>> The flex descriptor path already uses the correct mask
>>> (IAVF_RXD_FLEX_L2TAG2_2_M = GENMASK_ULL(63, 48)).
>>
>> Do you have a reproducer to verify the fix?
> 
> Yes, i have
> 
>   1. Create 2 VFs on ice PF (echo 2 > sriov_numvfs)
>   2. Disable spoofchk on both VFs
>   3. Move each VF into a separate network namespace
>   4. On each VF: create VLAN interface (e.g. vlan 198), assign IP, bring up
>   5. Set rx-vlan-offload OFF on both VFs
>   6. Ping between VLAN interfaces → expect PASS
>       (VLAN tag stays in packet data, kernel matches in-band)
>   7. Set rx-vlan-offload ON on both VFs
>   8. Ping between VLAN interfaces → expect FAIL if bug present
>       (HW strips VLAN tag into descriptor L2TAG2 field,
>        wrong mask extracts bits 47:32 instead of 63:48,
>        truncated to u16 → zero, __vlan_hwaccel_put_tag() never called,
>        packet delivered to parent interface, not VLAN interface)
> 
>>> Fixes: 2dc8e7c36d80 ("iavf: refactor iavf_clean_rx_irq to support 
>>> legacy and flex descriptors")
>>
>> (That first entered Linux v6.15-rc1, and Linux 6.12 and 6.18 are LTS 
>> series.)
>
> The reproducer works but requires legacy Rx descriptors to be in use.
> On modern ice + iavf with full PTP support, flex descriptors are always
> negotiated and the buggy legacy path is never reached.
> 
> Flex descriptors require all of the following:
>    - CONFIG_PTP_1588_CLOCK enabled in kernel config
>    - VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC granted by PF
>    - PTP capabilities negotiated (VIRTCHNL_VF_CAP_PTP)
>    - VIRTCHNL_1588_PTP_CAP_RX_TSTAMP supported
>    - VIRTCHNL_RXDID_2_FLEX_SQ_NIC present in DDP profile
> 
> If any of these conditions is not met, iavf_select_rx_desc_format()
> falls back to legacy descriptors (RXDID=1) and the wrong L2TAG2 mask is 
> hit.
> 
> In our kernel we ended up in a state where the iavf Rx path refactor was
> backported but the full PTP support chain was not. Without PTP,
> iavf_ptp_cap_supported() returns false and flex descriptors
> are never selected, exposing the bug.

Personally, I’d like to have this helpful information (reproducer and 
requisites) in the commit message, and it’d be great if you resend with 
the extended commit message.


Kind regards,

Paul


>>> Signed-off-by: Petr Oros <poros@redhat.com>
>>> ---
>>>   drivers/net/ethernet/intel/iavf/iavf_type.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/iavf/iavf_type.h b/drivers/net/ethernet/intel/iavf/iavf_type.h
>>> index 1d8cf29cb65ac5..5bb1de1cfd33b1 100644
>>> --- a/drivers/net/ethernet/intel/iavf/iavf_type.h
>>> +++ b/drivers/net/ethernet/intel/iavf/iavf_type.h
>>> @@ -277,7 +277,7 @@ struct iavf_rx_desc {
>>>   /* L2 Tag 2 Presence */
>>>   #define IAVF_RXD_LEGACY_L2TAG2P_M        BIT(0)
>>>   /* Stripped S-TAG VLAN from the receive packet */
>>> -#define IAVF_RXD_LEGACY_L2TAG2_M        GENMASK_ULL(63, 32)
>>> +#define IAVF_RXD_LEGACY_L2TAG2_M        GENMASK_ULL(63, 48)
>>>   /* Stripped S-TAG VLAN from the receive packet */
>>>   #define IAVF_RXD_FLEX_L2TAG2_2_M        GENMASK_ULL(63, 48)
>>>   /* The packet is a UDP tunneled packet */
>>
>> Nice find.
>>
>> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>>
>>
>> Kind regards,
>>
>> Paul
>>
> 

