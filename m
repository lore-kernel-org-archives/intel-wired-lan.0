Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CD1C46CD4
	for <intel-wired-lan@archiver.kernel.org>; Wed, 27 Dec 2023 21:46:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B9398377F;
	Wed, 27 Dec 2023 21:46:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1B9398377F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1703713568;
	bh=e69vD6PJDUFi1xsxUIZa/vqOEj/MbEGuFPUky/2oi9s=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=BB/APAacVg66kIiwSlfiKrmoKeHY+QchAnYMpMoRFa0rygwEPpNIO9+h6n3z12gA6
	 /FuDuKF4SaAuqNIJ8Q5jM6VMIvdA/jKvnYyy96ja5M3JMWLe5ixsyVFkHV8nqAbWJa
	 aWfLxmNPESB6UPQ50CFtG+eNHkUC7Iz9mhYBd5tRbsVfxaTmcBXe/UU1fjncN5f+Kc
	 /g9iGhFmhwYmRoM91yPRXnoxJOHNcAFDddR+keVoLmgf4CeE6L5sofKMGBPPWzgkgs
	 XaBuTLwbF5r6YB+0rW2+NKreSDagktDaTk7/GWbbCsfHwNoBQIMtRiwOmStoSBXk6K
	 B2rIty7qskAdA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3xWuVySiE8uZ; Wed, 27 Dec 2023 21:46:07 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25A97837A4;
	Wed, 27 Dec 2023 21:46:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 25A97837A4
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id C74D01BF2E4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 Dec 2023 21:46:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9D07A419C8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 Dec 2023 21:46:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9D07A419C8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jB4S82JdT0kT for <intel-wired-lan@lists.osuosl.org>;
 Wed, 27 Dec 2023 21:46:02 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B445C41741
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 Dec 2023 21:46:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B445C41741
Received: from [172.29.66.158] (93-34-6-18.ip47.fastwebnet.it [93.34.6.18])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4BB7861E5FE03;
 Wed, 27 Dec 2023 22:45:13 +0100 (CET)
Message-ID: <5ae1537b-73dc-45a1-94a7-669e63dc74db@molgen.mpg.de>
Date: Wed, 27 Dec 2023 22:45:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
References: <20231227173757.1743001-1-pavan.kumar.linga@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20231227173757.1743001-1-pavan.kumar.linga@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: avoid compiler padding
 in virtchnl2_ptype struct
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 przemyslaw.kitszel@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Dear Pavan,


Thank you for yoru patch.

Am 27.12.23 um 18:37 schrieb Pavan Kumar Linga:
> Config option in arm random config file

Sorry, I do not understand this part of the sentence. What Kconfig 
option was selected exactly causing this behavior.

> is causing the compiler
> to add padding. Avoid it by using "__packed" structure attribute
> for virtchnl2_ptype struct.

Did the compiler emit a warning? If so, please paste it.

> Fixes: 0d7502a9b4a7 ("virtchnl: add virtchnl version 2 ops")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312220250.ufEm8doQ-lkp@intel.com
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> ---
>   drivers/net/ethernet/intel/idpf/virtchnl2.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
> index 8dc83788972..dd750e6dcd0 100644
> --- a/drivers/net/ethernet/intel/idpf/virtchnl2.h
> +++ b/drivers/net/ethernet/intel/idpf/virtchnl2.h
> @@ -978,7 +978,7 @@ struct virtchnl2_ptype {
>   	u8 proto_id_count;
>   	__le16 pad;
>   	__le16 proto_id[];
> -};
> +} __packed;
>   VIRTCHNL2_CHECK_STRUCT_LEN(6, virtchnl2_ptype);
>   
>   /**

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>



Kind regards,

Paul
