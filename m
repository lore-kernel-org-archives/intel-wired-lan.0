Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65429606A31B
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=W7XD2zSd;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kot6DPCF
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47E6640721;
	Tue, 27 Oct 2026 12:56:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TnaOD0k4KKyo; Tue, 27 Oct 2026 12:56:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A013A40707
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793105783;
	b=UBrIqRRenhUOdcbXEwZ++FC6ZH0a4RwmrdO5haZuOyqf+OuIV+Gzpn565cX8D/sZojS6
	 4Cas6td97u8JFp6kCEnD3yQi/H2ZWpyhhe4WT06q2nOic3sY7mdpKvXIJa97AshUz0g8R
	 FlUuDf9CsPS2XR1hi1lQTWfBSwlMZFWOQBTp843DPnoH1w0XhVYXR5U06mT9eim1BJCbD
	 gjp5xg0sfIqsg+asymJseDbrDSSXUSpllT+dQ7PtE7TEamWKXHAMnVcoghLnIysoBbom/
	 WvIWs4QQMM5NQe1/c2nwPpSIhed5Oj8MjdDKHuwcZXLJhf7PZ1Ue/A0CYkMnmIyKSag==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793105783;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XuQpmzropspxYQ7G/nvj2ub5kVt2OGKRyfdfIfRlXXc=;
	b=CjMyPHMNTzRd6V6E4sqhrCUecOzKAamGKwEB0e8hr6vQL6lAccfKVP8qNXTLRBQIA/W7
	 ktkzjneDV3ewyBAGyG3I72UaJuurXU9xGXCFBZfUH4jV54oc8yp7jsiMn2KOhMsV8dd1a
	 pGHKyXxozJ1XTkQnIsmcvp4XDLJ7y0Xtw3zveCHUPTY1fEbs5acJr9hFVXmi1amJ7BowH
	 32zp37duD5/Me05wifUlzioeVqSFkd04YQZoV6IQqQDZGiqN7Qnhd9aQzHE2fdTFcFYAP
	 jDnUQuqK8T5O5k9WQ9mBSpbIzlLN85tqdyFsmIco8wA4ryX8X78XDmk19yV8MDJ6KCw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793105783;
	bh=XuQpmzropspxYQ7G/nvj2ub5kVt2OGKRyfdfIfRlXXc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W7XD2zSdHFhvu5bGjB7EUqHFw9nGi74KNNDBzwYOrj0Q+n9FJ+J86QZfUTj5ijwwS
	 UEQU/8t5h7MuJxHpf4RVjLcvkmQUE/bN7egGAMLIOjaNp2/wDVPpUEP4NLiv85S7FV
	 qqXhJimsQzm2ao35ebHMmWKV0zQQzMwnsAbNoG75OsGV3dxey4xzEtZT9jwP4P4lKQ
	 CtpFhdzm2ONiiFrZttQa3oxzDNnChySnqNmYVxYMH4HcOqjN4Q7jlTKrVwEEeUua2l
	 nnWkSFv+WRq5r5tuLuuOd0ozUixP7i1NljN9+HOrZIKU/5YOajlJ91cFk7JUn+o9PN
	 jmk57DL1DqwUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A013A40707;
	Tue, 27 Oct 2026 12:56:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E91903D9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:56:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DAF554028C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:56:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id do6JJC8vF9QP for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Oct 2026 12:56:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 140CD4007E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::42a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793105781;
 b=haiezaZhZiNsbe4bFKHtGUUKELSbGTv4UwmvOO9iTL33xeFF1u2qMAqZ+1b+xKdgy5+K
 Ayw3hQPBK5+2y/xKKnfPZKxWy5ElENzef4vCQym7gwwybZLhoZq0DZrgjtqKK9iNfdz8W
 LozJlPknJEl50loAbP/rZSXJeLB4G8cIzrpgqXXh4UkbuwNk268lPs050snkAbMmq6Svl
 mqpKNSRblztbyEQvlylAprmHln1+xL88AtvCslGA+KeipjK//4x7pc4RSRoLmL3GQlFpV
 qJq5uDVcOLANvAa8ckxMyoLWc7dy180X0l6spUKway5ACO/Ke+tYg453ImOKwcsYRrw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793105781;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=XuQpmzropspxYQ7G/nvj2ub5kVt2OGKRyfdfIfRlXXc=;
 b=WtANw5HabS8RZW9KTRwv0MphODJ87E76iY+O/RiBpXDW+PB764z4gIjLxHgkjeTqukzG
 oAhPPskl0fg5n+OsQVf47BtCoOGz06deEB3G0n7H9nWitFbUXqK39ObCzDnFbJzN/XYrn
 gFjkZrLJ6x2AYYYsVIrltdMtqF/c25JWZ2QINDvg8wSBAm/DopWvjjVmRYQRltu2MLkbj
 pTzlO4w1HPlt1v/Qyiwrozdyzu/uP9UTUMGCicfdU8KBS8xS5YN0jYzRc/iMsQAg0kWwx
 61t5Qq+vu6lYt1WG5b7U81uOzSvb0xCLnBKq6xw3KSdF3yShtdczwHYOH+Rv44ueMQg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=kot6DPCF; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::42a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com;
 envelope-from=magnus.karlsson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=kot6DPCF
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 140CD4007E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:56:20 +0000 (UTC)
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-8a07078200fso1432907b3a.2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 05:56:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793105780; cv=none;
 d=google.com; s=arc-20260327;
 b=VUdNon1/mTYJgkcyIsPrsJHmaLJqJFun0G7wEhpg1F9fMhoSZ5QJQdZk2HQo9s204/
 4ndAcBPwWE/ILiqqkcWWLD1q8/rj7ic6bSv4sGBhCbpHEKHs/+N4ilqAjCL2XGTYrjHt
 OhzkDPTSH4uPGTaO9CdcyakfpvxcbmQPZkKVgHxAwJ8hTTrJA1Y76tx4cuqG1bdQjnh0
 gfsvD0NXudZ0DcYDgkZt0WfZ8LDFzk/jcJ2LOqnPK5kjIYrF4b+LSV01zmySmhRIYEVj
 9dnKY3TFlYpMHxOJM5/ceCzXyg9BkY3YtEsPFSaQOZXgwuV5VroTQNzWhGvX/oUTdnF9
 bXvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XuQpmzropspxYQ7G/nvj2ub5kVt2OGKRyfdfIfRlXXc=;
 fh=Z1Ch8YFlPi1tUFMxBUk+EzD4d3uS1JL/pAqtCvrCWII=;
 b=QQEN+IDQlpcias109HCE0Hr5WucP0qRCh0h8tLCktEkpsMCIFC2R0Gz8IJ3Hxi8kKM
 iHEbzRdOCbGwiDDQT3XQX8HPctGVmPrcmugbpq+GTaH87/pP+AniaB4Jw3XcJ2QXDG2C
 SM3rxRAVjRNoj0KnyKAV/vr8e3yGd4uodt7Vzq0FoPQwqbysybNxvELWXkVKUu70lwQJ
 WFXIH3B3yI8IycA8OjMeLw3tJTFJ9O01hQC3r3B5c+dMWTIk9VofIocuRUDgz1KF3dxO
 pvlRMdX9wxftFV24IU+E2J/bSviqxoD5mPACuKZKU/TSDC5IyCUeFkrpcKI8DDeeUzLu
 itQQ==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793105780; x=1793710580; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XuQpmzropspxYQ7G/nvj2ub5kVt2OGKRyfdfIfRlXXc=;
 b=kot6DPCFkvjd1MecwAdph4WtbS8+Cj5Rqjonpe9WxkjXuClsPBk3TuXnuzIV/NO26Z
 W+htNRNO7KBgxmwPCJ4w2kvnIu9IGDlaG3mKcnEFB/FukmrPbBjxL2DlSdWfeW2P0xSX
 rH+mXlhW8gLUV9+mj9vb7JoGplRJBQQBvHO2XYIS7fUhXP4bCgFqU8bVp/NcAeCGWDOf
 52pUUNlMjZ3ljq9N2AXI2BkHhVVbsMovvJNpSQBUdpMDd+FQ9Q/ly2qnrRqYIOqt3cZd
 WJAL8AQCkVxOLlAcyiqO3YMcCiFoAEfmkB2EZCGg95LdRfEDttmD/v/CjGWVDJyedF5g
 mAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793105780; x=1793710580;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XuQpmzropspxYQ7G/nvj2ub5kVt2OGKRyfdfIfRlXXc=;
 b=gDSSLc0Dee5rXIRAShj+PAFe4GJeglUaJ4UOA/9fuM/HsNqUsLyN2JpIMNLjTNcHTE
 2PsRfFPgOwesIU/dbdSuGuqEafLBUSQr6lkF/ix6/bqCxeG5INbcwy5UtGjcRWwnEqIB
 koohMi/dEk+mhZ6EnQUDW65MBAPUSWMsimO85t2NF1Yoqv+8XNs9fwT3xAmzn5kC2XPH
 x5aZzgLwAkQShDu/g5WQJdhyV2NLuoyvUpg1Hi87Cb1yJXIlDxOa/Ig2QsHQa3knoIQC
 FBTVnMOsS7xryQFB+hYFgjY10vk13CefUOlu7A1limfWUM65ZNpSAeLCeH/XfVuvUdsP
 S2dw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxlNm5WBHlCHnIhiXPXx4K3hDMJr/gN3Wm+kXwtEkFRmq9aQHxpQwBJFszrrqFiAffKHb4+KJoo3xOC5I8OHDI=@lists.osuosl.org
X-Gm-Message-State: AFq9FYIItBd8AtjGGGuhGlW8Mplk0/ih1uSjTABYn2GEOURG7nWGnoUl
 b5PCLYsRN0OsL25j1pY7h/D2x8OV9K6RMAM9QDjnNBiNStl519pnz0Nuv2OM1hSL7vzBwQMR3F6
 7qaeZVR4W2vBmKHygGaLNmHwnWbiiOCU=
X-Gm-Gg: AYBFou3GgNDwfPM7k6XbLIckVlczAikrmQDCTUabVENsyTE722rB6g2ErwkHtP4c4tp
 hUkD7HRGFNiZbcLr/jEcPFShWLG74Jj0MFP4E2tKPjQ92Qt8e7hPU3wtbx5LPPMh+9C/bo/Xrml
 GXBxb/0UkJ2qs+s1FGewN7RtcDUuERN5a1HXZxmMM//vHzBu1LZqrNA5klyrg5db1j4H/H0x4ON
 FvmLMo4RSc1dfRKWlRW7PURAomdu84h54b0rHGwHdOkIB/e6+XWLra1aJ1cLJpvNfDL57eGlAR3
 C7Vquas429fHFqL6rMdoJSnRIIAy635t/WdjZiC/1vaOJi9lFYtOs8OTFFXHFJgL+VNRgHCBaI6
 Vp4CwBF/UL6xX3aHhX866sdeRvt17iyfShFolAi0=
X-Received: by 2002:a05:6a00:c586:10b0:899:74d0:8a72 with SMTP id
 d2e1a72fcca58-8a5ee5e7dfdmr797297b3a.59.1793105779946; Tue, 27 Oct 2026
 05:56:19 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027121442.907414-1-magnus.karlsson@intel.com>
 <20261027121442.907414-3-magnus.karlsson@intel.com>
 <CAL4WiiqJ8K5wXutDRk_XR8KfpWMxhYF_K1eNUVqq7HuyahO87A@mail.gmail.com>
In-Reply-To: <CAL4WiiqJ8K5wXutDRk_XR8KfpWMxhYF_K1eNUVqq7HuyahO87A@mail.gmail.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 27 Oct 2026 14:56:07 +0200
X-Gm-Features: AclHuK-qdlbwRBbu8GAMevQCutYCTJJj0bkkgl1I5CnGCwuZZue1FqLEunkqSgo
Message-ID: <CAJ8uoz2J5EbN++dts69BVJoAW8+T3bEtgHC-t3EtVtURQH-QWg@mail.gmail.com>
Subject: Re: [PATCH iwl-net 2/2] iavf: fix USO for 32-bit systems
To: Eric Dumazet <edumazet@kernel.org>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>,
 intel-wired-lan@lists.osuosl.org, 
 anthony.l.nguyen@intel.com, netdev@vger.kernel.org, 
 maciej.fijalkowski@intel.com, przemyslaw.kitszel@intel.com, 
 andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
 pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 27 Oct 2026 at 14:43, Eric Dumazet <edumazet@kernel.org> wrote:
>
> Le mar. 27 oct. 2026 =C3=A0 13:15, Magnus Karlsson
> <magnus.karlsson@intel.com> a =C3=A9crit :
> >
> > That USO works for 64-bit systems is just pure luck. Currently, the
> > computation of the UDP segmentation header is performed using sizeof()
> > a pointer instead of the sizeof() the UDP header that the pointer
> > points to. Since the UDP header happens to be 8 bytes long and a
> > pointer is 8 bytes long on a 64-bit system, this works on all those
> > systems. But no such luck for anyone using a 32-bit system as 8 bytes
> > !=3D 4 bytes. So fix this by using sizeof() the UDP header that the
> > pointer points to instead.
> >
> > This was found by an LLM while implementing something else that used US=
O.
> >
> > Fixes: c91a4f9feb67a199c2 ("add support for UDP Segmentation Offload")
>
> Missing prefix? This was really:
>
> Fixes: c91a4f9feb67 ("iavf: add support for UDP Segmentation Offload")

You are correct on both accounts/patches. Do not know why I missed this, so=
rry.

Do you want a v2 with this added?

> Other than this,
> Reviewed-by: Eric Dumazet <edumazet@kernel.org>
>
> > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > ---
> >  drivers/net/ethernet/intel/iavf/iavf_txrx.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/=
ethernet/intel/iavf/iavf_txrx.c
> > index 8982cf75466f..2c290d7788d2 100644
> > --- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> > +++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> > @@ -1807,7 +1807,7 @@ static int iavf_tso(struct iavf_tx_buffer *first,=
 u8 *hdr_len,
> >                 csum_replace_by_diff(&l4.udp->check,
> >                                      (__force __wsum)htonl(paylen));
> >                 /* compute length of UDP segmentation header */
> > -               *hdr_len =3D (u8)sizeof(l4.udp) + l4_offset;
> > +               *hdr_len =3D sizeof(*l4.udp) + l4_offset;
> >         } else {
> >                 csum_replace_by_diff(&l4.tcp->check,
> >                                      (__force __wsum)htonl(paylen));
> > --
> > 2.38.1
> >
