Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D381DC531C7
	for <intel-wired-lan@archiver.kernel.org>; Thu, 23 Jul 2026 07:02:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 817C560646;
	Thu, 23 Jul 2026 07:02:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nKCv4RIMQtLH; Thu, 23 Jul 2026 07:02:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 78D3D606CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784790172;
	bh=AOURQ+zBINwB3RQ/XOplI8aNDuWjLCRWLUDyous7DQo=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U0dkhzWmCSfOVlsDBl+BNw9WVo2kYwO4lZ/0hNhWFPCioV/eipsyGv587dFLqrg59
	 m/46m/p2fGsiLavfLVrbMNePixZrtEI6QSvXO8h6gFMCF12ybRowkWIDN+sIpOP97q
	 DQ3apqzAMG4ZaaE/DpwM436pqiqAzhN11AIlOl8R1bJoXkAXkT5rgp6ci1FqtwFn2T
	 Kopg5x+hOvKbgWScg1j1CAA1inElyYqZ0PIRHqD/wthtcoD7eCGgrzDgAD51qSzva/
	 aHHnpMU58afMAGb3KKlrrb6h2V+YeSKIOIu6K9Bcv14jyGFJOxKarZTWd2PFn5pn74
	 JZmhdUnLTPcwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78D3D606CC;
	Thu, 23 Jul 2026 07:02:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DB91239E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 07:02:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C11DC80E3D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 07:02:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xXCtfZxrSt0V for <intel-wired-lan@lists.osuosl.org>;
 Thu, 23 Jul 2026 07:02:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.180;
 helo=out-180.mta1.migadu.com; envelope-from=chenguang.zhao@linux.dev;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org AC72E80E2B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AC72E80E2B
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com
 [95.215.58.180])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AC72E80E2B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 07:02:47 +0000 (UTC)
Message-ID: <20f83ab8-d99f-4b10-bab1-cd5c6202937c@linux.dev>
Date: Thu, 23 Jul 2026 15:02:55 +0800
MIME-Version: 1.0
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260717012416.168107-1-chenguang.zhao@linux.dev>
 <CAL+tcoCdbjC4cHjm5C9mDTc05biiJfCRB=e0r0Ssp1qTwdxeJQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Chenguang Zhao <chenguang.zhao@linux.dev>
In-Reply-To: <CAL+tcoCdbjC4cHjm5C9mDTc05biiJfCRB=e0r0Ssp1qTwdxeJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1784790165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AOURQ+zBINwB3RQ/XOplI8aNDuWjLCRWLUDyous7DQo=;
 b=E4nj7eoaFNC5GMlR04WIlRj7hqZwFacoRfor5D5HPLiDPqP8OQHNT9iyTacOpdZBOzXRRq
 QJM50VEjxqlx/xboFNZPMRKZmk7lFUT2po4NbOJYE5hMWOC+PDHk3I4L7HIwNH7xFJMAF9
 5Q7KtANekeIK0uYXg1vCquiYroZX+tY=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=E4nj7eoa
Subject: Re: [Intel-wired-lan] [PATCH net v2] i40e: xsk: fix multi-buffer
 XDP_PASS skb construction
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

Thanks for the clarification.

I agree: the minimal bugfix belongs in -net for stable backportability, and the conversion to xdp_build_skb_from_zc() belongs in -next.

Please apply the existing v1 bugfix to -net:

     https://lore.kernel.org/all/20260714025112.284724-1-chenguang.zhao@linux.dev/

It already has :

    Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

I will drop v2 as a Fixes candidate.

In parallel, I will send a separate net-next series (as v1) that replaces

i40e_construct_skb_zc() with xdp_build_skb_from_zc(), based on 

net-next. That patch will not carry a Fixes tag.


Thanks,

Chenguang


在 2026/7/22 07:15, Jason Xing 写道:
> On Fri, Jul 17, 2026 at 9:24 AM Chenguang Zhao <chenguang.zhao@linux.dev> wrote:
>> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
>>
>> When AF_XDP ZC receives a multi-buffer frame and XDP returns XDP_PASS,
>> i40e_construct_skb_zc() copied frags incorrectly: memcpy used
>> skb_frag_page() (page metadata) and __skb_fill_page_desc_noacc() was
>> given a virtual address instead of a struct page *.
>>
>> Drop the custom helper and use xdp_build_skb_from_zc() instead. On
>> failure, free the xdp buff in the caller. Push the Ethernet header
>> back before eth_skb_pad()/i40e_process_skb_fields() because
>> xdp_build_skb_from_zc() already called eth_type_trans().
>>
>> Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
>> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
>> ---
>> Revised as suggested by Maciej:
>>  - Replace i40e_construct_skb_zc() with xdp_build_skb_from_zc()
> I might have a different opinion on this patch: yes, it actually
> belongs to -next material. The process should be like: 1) fix the
> issues by v1, 2) refactor it by v2. The reason behind that is the
> helper was introduced in 2024 while the home-grown part was in 2023,
> which means it doesn't help for stable steam to cherry-pick the patch
> in older kernels like 6.6[1].
>
> [1]: https://www.kernel.org/
>
> Thanks,
> Jason
>
>> v1:
>>  https://lore.kernel.org/all/20260714025112.284724-1-chenguang.zhao@linux.dev/
>>
>>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 73 +++-------------------
>>  1 file changed, 8 insertions(+), 65 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
>> index 9f47388eaba5..1319a5c22625 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
>> @@ -3,6 +3,7 @@
>>
>>  #include <linux/bpf_trace.h>
>>  #include <linux/unroll.h>
>> +#include <net/xdp.h>
>>  #include <net/xdp_sock_drv.h>
>>  #include "i40e_txrx_common.h"
>>  #include "i40e_xsk.h"
>> @@ -277,70 +278,6 @@ bool i40e_alloc_rx_buffers_zc(struct i40e_ring *rx_ring, u16 count)
>>         return count == nb_buffs;
>>  }
>>
>> -/**
>> - * i40e_construct_skb_zc - Create skbuff from zero-copy Rx buffer
>> - * @rx_ring: Rx ring
>> - * @xdp: xdp_buff
>> - *
>> - * This functions allocates a new skb from a zero-copy Rx buffer.
>> - *
>> - * Returns the skb, or NULL on failure.
>> - **/
>> -static struct sk_buff *i40e_construct_skb_zc(struct i40e_ring *rx_ring,
>> -                                            struct xdp_buff *xdp)
>> -{
>> -       unsigned int totalsize = xdp->data_end - xdp->data_meta;
>> -       unsigned int metasize = xdp->data - xdp->data_meta;
>> -       struct skb_shared_info *sinfo = NULL;
>> -       struct sk_buff *skb;
>> -       u32 nr_frags = 0;
>> -
>> -       if (unlikely(xdp_buff_has_frags(xdp))) {
>> -               sinfo = xdp_get_shared_info_from_buff(xdp);
>> -               nr_frags = sinfo->nr_frags;
>> -       }
>> -       net_prefetch(xdp->data_meta);
>> -
>> -       /* allocate a skb to store the frags */
>> -       skb = napi_alloc_skb(&rx_ring->q_vector->napi, totalsize);
>> -       if (unlikely(!skb))
>> -               goto out;
>> -
>> -       memcpy(__skb_put(skb, totalsize), xdp->data_meta,
>> -              ALIGN(totalsize, sizeof(long)));
>> -
>> -       if (metasize) {
>> -               skb_metadata_set(skb, metasize);
>> -               __skb_pull(skb, metasize);
>> -       }
>> -
>> -       if (likely(!xdp_buff_has_frags(xdp)))
>> -               goto out;
>> -
>> -       for (int i = 0; i < nr_frags; i++) {
>> -               struct skb_shared_info *skinfo = skb_shinfo(skb);
>> -               skb_frag_t *frag = &sinfo->frags[i];
>> -               struct page *page;
>> -               void *addr;
>> -
>> -               page = dev_alloc_page();
>> -               if (!page) {
>> -                       dev_kfree_skb(skb);
>> -                       return NULL;
>> -               }
>> -               addr = page_to_virt(page);
>> -
>> -               memcpy(addr, skb_frag_page(frag), skb_frag_size(frag));
>> -
>> -               __skb_fill_page_desc_noacc(skinfo, skinfo->nr_frags++,
>> -                                          addr, 0, skb_frag_size(frag));
>> -       }
>> -
>> -out:
>> -       xsk_buff_free(xdp);
>> -       return skb;
>> -}
>> -
>>  static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
>>                                       struct xdp_buff *xdp_buff,
>>                                       union i40e_rx_desc *rx_desc,
>> @@ -372,14 +309,20 @@ static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
>>                  * BIT(I40E_RXD_QW1_ERROR_SHIFT). This is due to that
>>                  * SBP is *not* set in PRT_SBPVSI (default not set).
>>                  */
>> -               skb = i40e_construct_skb_zc(rx_ring, xdp_buff);
>> +               skb = xdp_build_skb_from_zc(xdp_buff);
>>                 if (!skb) {
>> +                       xsk_buff_free(xdp_buff);
>>                         rx_ring->rx_stats.alloc_buff_failed++;
>>                         *rx_packets = 0;
>>                         *rx_bytes = 0;
>>                         return;
>>                 }
>>
>> +               /* xdp_build_skb_from_zc() already ran eth_type_trans();
>> +                * restore the header for eth_skb_pad()/process_skb_fields().
>> +                */
>> +               __skb_push(skb, skb->data - skb_mac_header(skb));
>> +
>>                 if (eth_skb_pad(skb)) {
>>                         *rx_packets = 0;
>>                         *rx_bytes = 0;
>> --
>> 2.25.1
>>
>>
