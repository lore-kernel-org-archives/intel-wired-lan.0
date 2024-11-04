Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80270D132DF
	for <intel-wired-lan@archiver.kernel.org>; Mon,  4 Nov 2024 15:51:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 24B5A4063B;
	Mon,  4 Nov 2024 15:51:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9pSVpnF7pmCP; Mon,  4 Nov 2024 15:51:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6082E4063C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1730735478;
	bh=f573NGxGwwEcpEI02aRs9Mv6MPzHTm8n3DIYo90WOAg=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sFiUs7PJK5Fgd+7XnPyZ/S8dEqxq+nyD46CpWsS5A2xBUdstIRisXeF6OnWp5M8WU
	 LR9XWzS0js+eFfbQDgCcM2S5nvyTGxefal+kYr8wD566S+pMTo65ayqZ/8OcBwrr4T
	 mFgaiCnp7Mf1NzZxXv4iTdl1QlN0PNQ9QY47NI7/nfn2Gw50geiHqlec/QQPNwcRC7
	 v2kV1apHyPSzqL/nt3d6UmvzqLdd5W2lTc4EbzaqKV4AnwhElqaQU8AqsxU1fP0WeT
	 6fHoMKIP4aC95FpAbY9n2DIPWqPsYRE7J9QLgps7+xIP/rolMdaw2mdnjVuqpk4pBx
	 upjq4c6eu/FqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6082E4063C;
	Mon,  4 Nov 2024 15:51:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 01911962
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 Nov 2024 15:51:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E33B74063C
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 Nov 2024 15:51:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vZNhAURk_Ms5 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  4 Nov 2024 15:51:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=mschmidt@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 032A34063B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 032A34063B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 032A34063B
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 Nov 2024 15:51:15 +0000 (UTC)
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-OSNAofkSOsqb2KqIQ4rQvQ-1; Mon, 04 Nov 2024 10:51:11 -0500
X-MC-Unique: OSNAofkSOsqb2KqIQ4rQvQ-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5eb85207c7dso345706eaf.3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 04 Nov 2024 07:51:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730735470; x=1731340270;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f573NGxGwwEcpEI02aRs9Mv6MPzHTm8n3DIYo90WOAg=;
 b=BDgDOO1bckOCNUepLiKlBgKmnpjzssETaclM+fDo4bh3ZOmA6Iq49E7sTjX6wxXELw
 eKRDS5xSdtE14GlgjIS3tNXHb5jffq4YnsrbPVpY1w57N51H3l0ZKfiWsghK9UM/DpZG
 hyVVqgubgHnt8VgUKLu+GQ233DbWGXyDAG4JbzkqwTcQ9zk5HBYXEmZzZ1GHPwNuxRKH
 mIVzKjdrqpqq95zc4BJxlRQ3hv//1vdEi5FXE/dRCHUaSSaYOJ06GIajajWt+bjaKC7d
 AjH9XxMPDJY4lz5eLef0vyltrvv348LtSjKftSA3Fd1YfyC5UPkD628umbkfHFVBiVMQ
 4M6A==
X-Gm-Message-State: AOJu0Yyb6JbscJmCev+9rA0mDyWt0ayE7gUMYALU0S5350PCcnZc73gv
 P6jKvwin1pttFJhlH5GfosVqgVUnaZOC/KnrXiZH2PMg3+/sAb3ek6/DesePBo79oyOcwpw/XEL
 X5LMSe9r2BujN+k7t3jlfpb5IrwvLq0GEIEWuG+wB1Rnah+toRMK+40We9ytluD8/RUJytXVOou
 nFwxbkNR1sQvsA3v6HfWvCVAnWjuFdph43PLSOwQhaEQ==
X-Received: by 2002:a05:6871:3a28:b0:27b:9f8b:7e49 with SMTP id
 586e51a60fabf-29051ed2e07mr8128946fac.11.1730735470673; 
 Mon, 04 Nov 2024 07:51:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPHhMtv9li+aLKBXugLstxd80vMrdlAgTUr2ut5C9X79h0VKy4FqWxhiv+7Ma6OH4h81v54eHfUtX8m+iMlO4=
X-Received: by 2002:a05:6871:3a28:b0:27b:9f8b:7e49 with SMTP id
 586e51a60fabf-29051ed2e07mr8128940fac.11.1730735470357; Mon, 04 Nov 2024
 07:51:10 -0800 (PST)
MIME-Version: 1.0
References: <20241029123637.1974604-1-aleksandr.loktionov@intel.com>
 <CADEbmW1rJdFZ0ccpo-YLv0W8zQsr9-2eMnncDgR-tE+On0TX5g@mail.gmail.com>
In-Reply-To: <CADEbmW1rJdFZ0ccpo-YLv0W8zQsr9-2eMnncDgR-tE+On0TX5g@mail.gmail.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Mon, 4 Nov 2024 16:50:59 +0100
Message-ID: <CADEbmW0r4BCU_qWHRrvAPQ-kwA-xMDj2YD_OdiGotRnfEMtpoQ@mail.gmail.com>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com, 
 netdev@vger.kernel.org, Jan Sokolowski <jan.sokolowski@intel.com>, 
 Padraig J Connolly <padraig.j.connolly@intel.com>, maciej.fijalkowski@intel.com,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1730735474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f573NGxGwwEcpEI02aRs9Mv6MPzHTm8n3DIYo90WOAg=;
 b=QEd41YoqE0vxHUNgYuU26EEGVPRNDkh5Cgatnswxxj8kEo1zugEBrBD26wKbNDI/yKUHlh
 DMMvSTiJNzS8PpyjLYczY+l8R9F4oq+XH4zpNG249ZNEz7g797oxmnYybIXRF6CaWxvSSI
 Pf7wli7k1f8j5SwKt7Em2q+vc3Q8H8w=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QEd41Yoq
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4444] i40e: add ability to
 reset VF for Tx and Rx MDD events
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

On Mon, Nov 4, 2024 at 4:40=E2=80=AFPM Michal Schmidt <mschmidt@redhat.com>=
 wrote:
>
> On Tue, Oct 29, 2024 at 1:36=E2=80=AFPM Aleksandr Loktionov
> <aleksandr.loktionov@intel.com> wrote:
[...]
> > +
> > +                       i40e_vc_reset_vf(vf, true);
> >                 }
> >         }
> >
> >         /* re-enable mdd interrupt cause */
> >         clear_bit(__I40E_MDD_EVENT_PENDING, pf->state);
>
> Can you remove this 2nd clearing of the __I40E_MDD_EVENT_PENDING bit?
> If the interrupt handler detects a MDD event while we're still
> printing the message about the previous one, we don't want to forget
> it by clearing it here.
>
> Michal

Well, I suppose the race I described cannot happen because the
unmasking of ..._MAL_DETECT_MASK happens after this.
But it's still redundant to clear the bit twice.

Michal

> >         reg =3D rd32(hw, I40E_PFINT_ICR0_ENA);
> >         reg |=3D  I40E_PFINT_ICR0_ENA_MAL_DETECT_MASK;
> >         wr32(hw, I40E_PFINT_ICR0_ENA, reg);
> >         i40e_flush(hw);
> > +
> > +       i40e_print_vfs_mdd_events(pf);
> >  }
> >
> >  /**

