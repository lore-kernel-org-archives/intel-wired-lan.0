Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7C5C32771
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Sep 2022 20:40:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C17E540154;
	Wed, 28 Sep 2022 20:40:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C17E540154
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1664397640;
	bh=nNFfwfAV3sl4s6gNlvUT0VqrKu1/cSKDNyZoBWMaRc0=;
	h=References:In-Reply-To:From:Date:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=bK5D2Jv05zRqtLscanlTLLhovcgFWzcsNqstbPR0sd1gJvKHsTwHdciXzYfafCi57
	 +AaT7u1E3vihRQo/+Sg/9OYVQa4U1ZrsTn3fSKYf2w8hAIvjsiyZHecYGyO+aplCGf
	 2pnwaxJ0dbSJUl4d+sTMN/f62OSeCMz+3+fulOk0kYJrCi4OE1vxqD/PaJLt1gzrq0
	 MtQdY7BZacCPR9NcadLYVWPEcI7o6pdc4gVtTt8Y0nnt3rrUOwytNqNiVUBcIqTDWW
	 /NeJYNcmAGchMO2uItu1hjllnk9qpwwSEFp6Ys4bqA8VJnHE+0jBwI2Y3kWbpQnCMJ
	 qwB0BlxHw4ucA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RE7gc8yUhZwD; Wed, 28 Sep 2022 20:40:40 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id ABE1040C6C;
	Wed, 28 Sep 2022 20:40:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ABE1040C6C
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 1102D1BF2F8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Sep 2022 20:40:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E9DF141928
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Sep 2022 20:40:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E9DF141928
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OqpPMYv0mKbn for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Sep 2022 20:40:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F167A41926
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F167A41926
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Sep 2022 20:40:36 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 e11-20020a17090a77cb00b00205edbfd646so3881171pjs.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Sep 2022 13:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=KuhAmICfXJATUOiNP3pnp/fG0fuwEYVn8+cwsmb6Qnk=;
 b=W6Qv5FC5axAT8Av3WuuF+qJmaYKKtP883pkbj0lKqcePPEp42zJ20M+9vvcwfftVSR
 wr1nMoNvr1a+ZroOjqzX2LVCMDynuDM8ZJN6w2RME1dt/8RgEBOhoj8VyfncBxjRfIjy
 aXbVa0GuaxyfhRaMslHhzrl4s3BReDaWYuzpbHoVIQZ/aInRZbG5AweMZ0ncp8X8e+l+
 uXcNC31TnNnhiqkXjQV86eiNMcyadusHc+wHxr0d64/vDN+aiCuXnc+7kEVFKJXPnGy2
 2tc3lEJxKXXTfhv4hsA1uM+F0O5zBFPdtlnxpus+NDJsAWI3SIFR7LW71/vaEcygUvQA
 xXmw==
X-Gm-Message-State: ACrzQf2cIcqwwaquB1ahtvyXWFrBRLOGQEakOQ/3Z9yJAkabv6yP50Cd
 OH3hx55e4n+qtHNowQzlacYf4nGduS1WKgOxiDA=
X-Google-Smtp-Source: AMsMyM5jBEOAj5nkkF14gjAvvnao2+1FhWHkepr2frn24e3ibK86ZJtvNyQOpEbZgF6XJXf9GpLdlcfu8dfr9HwLX3U=
X-Received: by 2002:a17:902:dad1:b0:17a:940:9c81 with SMTP id
 q17-20020a170902dad100b0017a09409c81mr1506916plx.93.1664397636255; Wed, 28
 Sep 2022 13:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220928192730.809441-1-anirudh.venkataramanan@intel.com>
In-Reply-To: <20220928192730.809441-1-anirudh.venkataramanan@intel.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 28 Sep 2022 13:40:24 -0700
Message-ID: <CAKgT0UdptMUmZhTg04BgiMaAPnfHCuKJYRPSG9Zr6oAykFZwMw@mail.gmail.com>
To: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=KuhAmICfXJATUOiNP3pnp/fG0fuwEYVn8+cwsmb6Qnk=;
 b=abOxsTCXOSBAlEAq6KVZezHWQDv9AhTi/BuoXSjjrJE++Xir2gy6xZCnna5p3Q5kSu
 jHLC98P5Khs3H1IIzYaUo7MKgnnnb8z6LGE57sO1hC7ZCgDvu9icv3WGyC6zFvShuIw+
 S/wlyzYeoCo+fL+eP2/tbYuyPwej81uq/CYw/rkm22D+N3fN0JfVjJ5//5d9Lqdcez6V
 ZJZO38IRkqWmEPA+Za4e/DiNN5jSFlbr2u4u2noEEXPIaryTWfJlMBFAKXgOWVaMJ8SG
 KDKRnpmS5PpayCX7AmylTZk6QkfqkimW4gM2BFUPEo/zHQflf3OZouBF5jN+AbCTZh/u
 cl/w==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=abOxsTCX
Subject: Re: [Intel-wired-lan] [PATCH net-next] ixgbe: Remove unnecessary
 use of kmap()
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
Cc: Ira Weiny <ira.weiny@intel.com>,
 "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
 intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Sep 28, 2022 at 12:26 PM Anirudh Venkataramanan
<anirudh.venkataramanan@intel.com> wrote:
>
> Pages for Rx are allocated in ixgbe_alloc_mapped_page() using
> dev_alloc_pages(), which does the allocation using flags GFP_ATOMIC |
> __GFP_NOWARN. Pages allocated thus can't come from highmem, so remove
> calls to kmap() and kunmap().
>
> While here, also remove the local variable "match", and just return
> true/false.
>
> I wasn't able to get a hold of a system with an ixgbe NIC to test this
> change. This is a pretty trivial change and I don't expect anything to
> break, but a "Tested-by" from someone who has the hardware would be nice.
>
> Cc: Alexander Duyck <alexander.duyck@gmail.com>
> Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> index 04f453e..90c0e0b 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> @@ -1960,20 +1960,17 @@ static bool ixgbe_check_lbtest_frame(struct ixgbe_rx_buffer *rx_buffer,
>                                      unsigned int frame_size)
>  {
>         unsigned char *data;
> -       bool match = true;
>
>         frame_size >>= 1;
>
> -       data = kmap(rx_buffer->page) + rx_buffer->page_offset;
> +       data = page_address(rx_buffer->page) + rx_buffer->page_offset;
>
>         if (data[3] != 0xFF ||
>             data[frame_size + 10] != 0xBE ||
>             data[frame_size + 12] != 0xAF)
> -               match = false;
> -
> -       kunmap(rx_buffer->page);
> +               return false;
>
> -       return match;
> +       return true;
>  }
>
>  static u16 ixgbe_clean_test_rings(struct ixgbe_ring *rx_ring,

Rather than bothering with the return true/false why not just return
the compare value? So it would be:
        return data[3] == 0xFF && data[frame_size + 10] == 0xBE &&
data[frame_size + 12] == 0xAF;
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
