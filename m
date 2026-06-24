Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A46CDB47C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 24 Jun 2026 11:15:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB37D60BDC;
	Wed, 24 Jun 2026 11:15:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VhKRDrfBgrS2; Wed, 24 Jun 2026 11:15:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BD45960BDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1782299753;
	bh=v2wRzTtwTw8E7bv4kplv+lYY13gFv6IXu2a/9u/VPY8=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=IpbaEkLV1XQmC3EPEXb/0ufvc0+b5knghNbUQyqxAEz/NZYN2Q8CD5UDcl+2/BApF
	 ww6boa8A2/vhPlBjuZyRe2K40o6XhG1NTsx6f8mZm2jMx4GXwW02z92hc9MtVd7RC4
	 DN9amUx71GTCgiOp5GLdfWyGErpkjO1KsPOEQfNU3KQJZGxaQX+vXqBYQTj46paYR0
	 1puZ9xCn1oaPBCE6Iv1xVoqvGq+XvenpnCMJQNPux6mbtX7ztf9JY/c45E+geo50KQ
	 NcdX0rigVD0ErqHSKOtqKqlxdjzllRBLrYhUdYiCXiPjMV6Fk6xf2pWkOhkO346ooF
	 faAcMCAQdgoxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD45960BDF;
	Wed, 24 Jun 2026 11:15:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D1AD8367
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 Jun 2026 11:15:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BB3B060BDC
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 Jun 2026 11:15:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VCrb6aJDTJpS for <intel-wired-lan@lists.osuosl.org>;
 Wed, 24 Jun 2026 11:15:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=robert.malz@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org ED55E60BDA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ED55E60BDA
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ED55E60BDA
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 Jun 2026 11:15:49 +0000 (UTC)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5A1F53F633
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 Jun 2026 11:15:46 +0000 (UTC)
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c0deb2b9dceso66694366b.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 Jun 2026 04:15:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782299746; cv=none;
 d=google.com; s=arc-20240605;
 b=FHfyiCvOivGPpVOVXEd871mCK4iQr5HaSQzcjXK/bEqRmEO+FGVGfP18hAZ7l17jmM
 GtXJ88oa6l3lhRisCgJQW02Y0P4OCpHYmvBymcu5r69qEkECC65+fCM8AuWukQTOpoRr
 PRJz1MP20/djOFNq4TAtB/kcnph0ui43J3Z0kwVqE+hR8VOfPIC/Dp+CVwBGS73zNbtz
 lf1w4gWeI7l2jfnqk9SbbbhpI98j9G+AdldnBnF71Y1YsUx46Q7BINSe7W5QVfF2vxg8
 RAjG5TCfR3/lAyB1cpBM2tgzk0FaEFmnxfP/oBkGZ3Ib5GiuZdyH+Pguz1RUVYjp1D0V
 ndZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=v2wRzTtwTw8E7bv4kplv+lYY13gFv6IXu2a/9u/VPY8=;
 fh=ldx/QrFlxoYVI2zbI0ixhXGa/BLY9sJjAxrOVFPa6ww=;
 b=Iz3mRh0N9OcEKefCukBRKKZ5g7HsvtRRF3aSNAMZvGBdMw/zK+QN4MOvqi3MVh9fQo
 MRgPVh3WjmmUXsAaVFCGknjKS2HH4/elj/ACTlHCRuKryeYqqgXHZhJJtPT1zokmSfHc
 YfHM1FgyciYq2swYFPYFxZacG2Z3YYFl71KaOlqrvib4q5O1GtfMAXiNHoQSgriLD4E8
 JX0GT/INwzf5CSeXxlaZw7PjXtyJWW1c8sN+d5jrDBn1whUIFhsT1Rwtq2yPlhnscuz4
 /XHUTEV/cDSc/2jiX71L5U0Je0S08wILG/OUoF2SkG//Gl5eCNWJNot2R+xlduKqzcZL
 NmQA==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782299746; x=1782904546;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v2wRzTtwTw8E7bv4kplv+lYY13gFv6IXu2a/9u/VPY8=;
 b=m9iiA/QH0OAjIyhONgbayutf8BeTyS6LRBoosaNPOfKm6xLhcOb3uatCcwVj39NC1+
 dVXHqmYOMaEF1i4djvW241fY1VOJ/zk1zyh1OPfGEsrGoD17bt6Fu6J/Umg+Xh73ijlL
 BhPeKUvJI67/nxnBzyWVGDDTPIoAxJLRiMFgxVdhjPDS1CtOy3ZJOMVVZTZPo2+hQ+mE
 XQiA2Icj4/KS8YVuIJKt5n3fkcS59lOscXDElrH5Y3gIhp1UCNEArCHvGxV6f2Fg1n8H
 CBuQD/kpiH/9zGFtrNBj6Ar/QfABluyAgArclq43HKUPMYsmSKBMOMnATyO+ZC3dLb5f
 hzZw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/4KkMv7OunVBTromV+qHxsgrK3e0rHSrHWvSHDiml0guMfs/yQ2VIN/syoS+qKYl/oVAmr0IHb/P3ecVV29w0=@lists.osuosl.org
X-Gm-Message-State: AOJu0YzFR7vBEl51xEvaQoNRyIZKXe69NrxdBPGOPowG4XPTC6S5R3Pl
 Dxf4FWButxgChrz52nFJV4qAyZ5QikqNDK6vRc4ASnu54b4qkxK2UAhmWRAzbwI9b/o4toY8p0x
 unz/Wgqph/euXvq2LfXRDiiHx/67ScI4iqfUzh5UFV0E+q3CVKuuc3mTbyEqt+SulfQLAlAKj3N
 g9FbbB4LUkzI7MTqGL5ZCHeRk/6VJu46Wz37SWCwJUWbNJ0775TxVbuHPWELEvKQ==
X-Gm-Gg: AfdE7cm+/zbJBVlgLU83gbMbqFX7L1IP8qQ3aIbDLIF9dW0Nrg1RqRDyCqmCCxdIoB5
 cvX6+TN2xhy1pmXlBKNt9sHkdb2DQhNgUyVD8J1XZQyHty2uqnfQzZHKy4L8G0fwK9R1tFnu5Pr
 JVyjN+kbypeIb62XFZ6i6AKEhZL/kvYL6WOFEV/KK6/vkYOV3UEg6Ddw03zV1rNlARpw==
X-Received: by 2002:a17:907:a2c8:b0:c06:58a5:c003 with SMTP id
 a640c23a62f3a-c119dd59ec0mr148197666b.17.1782299745731; 
 Wed, 24 Jun 2026 04:15:45 -0700 (PDT)
X-Received: by 2002:a17:907:a2c8:b0:c06:58a5:c003 with SMTP id
 a640c23a62f3a-c119dd59ec0mr148193866b.17.1782299745248; Wed, 24 Jun 2026
 04:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260617120753.1785565-1-robert.malz@canonical.com>
 <20260618152003.909400-1-horms@kernel.org>
In-Reply-To: <20260618152003.909400-1-horms@kernel.org>
Date: Wed, 24 Jun 2026 13:15:33 +0200
X-Gm-Features: AVVi8Ceodfn4RQrfhCjGJl6E_BGItBwT_10N9QBv-jSfXtjZY1nLtVQxYDxjOXw
Message-ID: <CADcc-bydFL4KNDQEznStE41NFXuCey9S+kyXg0usbonwyWpiAQ@mail.gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1782299746;
 bh=v2wRzTtwTw8E7bv4kplv+lYY13gFv6IXu2a/9u/VPY8=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=HggYnSNbyT/ALIR/DbxiXgDnYCSgMg7ASSu+fAg8VjDQInSne4HTwyVqHQMx4hEe5
 XeejBQdM5bgVR/4IXC0h4FXG9o9I5T5C15yU8fwjCTzZjtrdWbKDKamguCydd10fn4
 +20D7sK6KC/g91XhUgjrm10aNH88iS/Ac3hBXdF63SiZXHSC2N2C6WNrL5ji5ZI0ut
 /W/xyRdfFldeMQpaGC5Hh0Qojs5VnsKx8f1LKJmo7abnQcTgyGnAlVWhg2TBCKbYuo
 M7j3VhbkuLfKXR8f0L0XKn2ePihDVRv9Tb6eYjStLBlsRhnugsSVZ5Vq+49tEfEP40
 H9tXE9D0C6NlwMpUp0oJH0H0p+AtACeZYnkplxGInDOcxtnM0O9Bd1CtAJlJ84icM5
 8cM36KSX8SvVDKHcDav7aQAfEz11smOuX8nOggMKAwRQyvL+K+pPa1sudgVZMV9ZSk
 1dlbQq0aNp3aDOEdf53z9v4r31ArjwNcuohejM1Asog7EphN65Me8jFpw1OBw7QKBs
 gruunSwunzcKdQ8qsbedaqo7qE2Ot1jyXobsbR8BbvTWEhCx0NXdt46Efsgi4vXUEz
 jMrmdv2tuGYa1uF84kb0dTrP+o3HuFFqQtrOWu3KCmvCE3a1WFIOcK3cvkNnGNTGZZ
 TOitr83zDTChKb5kASx8tcIU=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=HggYnSNb
Subject: Re: [Intel-wired-lan] [PATCH iwl v3] ice: retry reading NVM if
 admin queue returns EBUSY
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
From: Robert Malz via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Robert Malz <robert.malz@canonical.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hey Simon,
Thanks for the review. I'll try to address these comments one by one.

On Thu, Jun 18, 2026 at 5:20=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> ice: retry reading NVM if admin queue returns EBUSY
>
> When the admin queue command to read NVM returns EBUSY, the driver
> currently treats it as a fatal error and aborts the entire read operation=
.
> This patch adds retry logic to handle this condition.
>
> > diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/eth=
ernet/intel/ice/ice_nvm.c
> > --- a/drivers/net/ethernet/intel/ice/ice_nvm.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
>
> [ ... ]
>
> > @@ -96,11 +97,25 @@ ice_read_flat_nvm(struct ice_hw *hw, u32 offset, u3=
2 *length, u8 *data,
> >                                        offset, read_size,
> >                                        data + bytes_read, last_cmd,
> >                                        read_shadow_ram, NULL);
> > -             if (status)
> > -                     break;
> > -
> > -             bytes_read +=3D read_size;
> > -             offset +=3D read_size;
> > +             if (status) {
> > +                     if (hw->adminq.sq_last_status !=3D LIBIE_AQ_RC_EB=
USY ||
> > +                         retry_cnt > ICE_SQ_SEND_MAX_EXECUTE)
>
> [Severity: Low]
> Does this check allow an extra retry execution? Since retry_cnt starts at=
 0,
> using a strictly greater-than check allows the loop to retry 4 times
> (5 total executions) instead of the 3 executions intended by
> ICE_SQ_SEND_MAX_EXECUTE.
>
> > +                             break;
> > +                     ice_debug(hw, ICE_DBG_NVM,
> > +                               "NVM read EBUSY error, retry %d\n",
> > +                               retry_cnt + 1);
> > +                     last_cmd =3D false;
> > +                     ice_release_nvm(hw);
> > +                     msleep(ICE_SQ_SEND_DELAY_TIME_MS);
>
The review is correct that this allows one extra execution. However, I
intentionally kept this verbatim from the OOT driver (1.15.4) to
retain the significant test exposure it has there. The absolute worst
case is one harmless extra retry before giving up. If you strongly
prefer strict adherence to ICE_SQ_SEND_MAX_EXECUTE, I can update the
condition in a v4.

> [Severity: High]
> Does dropping the NVM lock here violate the caller's assumption of mutual
> exclusion?
>
> Callers of ice_read_flat_nvm() typically acquire the NVM lock beforehand =
to
> ensure an atomic read of multiple sectors without interleaved writes. By
> explicitly dropping the lock during the msleep() window, another thread, =
VF,
> or PF could acquire the NVM lock and modify the NVM before the read resum=
es,
> potentially resulting in reading torn or inconsistent NVM data.
>
> > +                     status =3D ice_acquire_nvm(hw, ICE_RES_READ);
> > +                     if (status)
> > +                             break;
>

I don't think this is an issue. The NVM resource (req_res 0x0008) is
an ownership lease, not a content snapshot. The FW grants it with a
hold timeout (see the timeout field handling in ice_aq_req_res). It
never guaranteed a point-in-time view of the flash.
Very similar behavior already exists in ice_devlink_nvm_snapshot(),
which reads the NVM in chunks via ice_read_flat_nvm() and deliberately
acquires/releases the lock between chunks (with a comment explaining
the FW reclaim).
Additionally, the lock is only dropped on the failure path, where
neither bytes_read nor offset have been advanced. The driver simply
re-reads the failed chunk after re-acquiring. So no data that is
returned to the caller is committed across the drop window.
Overall the lock drop does not weaken any guarantee callers actually
have. If we wanted to introduce a true snapshot guarantee, that would
probably require different approach and separate patch.


> [Severity: High]
> Can this lead to an unbalanced NVM resource lock release and potential da=
ta
> corruption?
>
> If ice_acquire_nvm() fails here, the loop breaks and returns an error wit=
h the
> lock currently unheld. However, callers like ice_read_flash_module() are
> unaware of this internal lock state change and will unconditionally call
> ice_release_nvm() upon failure:
>
> drivers/net/ethernet/intel/ice/ice_nvm.c:ice_read_flash_module() {
>         status =3D ice_acquire_nvm(hw, ICE_RES_READ);
>         if (status)
>                 return status;
>
>         status =3D ice_read_flat_nvm(hw, start + offset, &length, data, f=
alse);
>
>         ice_release_nvm(hw);
>     ...
>
> Because firmware tracks resource locks per-PF rather than per-OS-thread, =
this
> errant second release could forcefully strip the lock from another thread=
 on
> the same PF that successfully acquired it, exposing the NVM to concurrent
> modification.
>

Agreed, this might be a real bug, and the one of the three I think is
worth investigating.
If ice_acquire_nvm() fails after the drop, ice_read_flat_nvm() returns
with the lock unheld while callers unconditionally call
ice_release_nvm(), so a stray release is issued.

On probability, though, the window is very small. Reaching it requires
sustained EBUSY across the retry budget plus a failed re-acquire
(which itself polls up to ICE_NVM_TIMEOUT), and concurrently another
requester taking the lock. Most reads happen during init (ice_probe,
and reset/rebuild via ice_init_nvm), and NVM writes only happen on an
already initialized driver. The devlink/ethtool nvm_read paths are
also exposed, but hitting this race would require precise timing
against a concurrent NVM owner on the device.

I'd prefer to keep the scope of this patch limited to the EBUSY retry
path and not take on the unbalanced-release fix here. A proper fix
should change the lock-ownership contract of ice_read_flat_nvm() (on
error, the lock must be released by ice_read_flat_nvm(), callers
release only on success) and update all callers. Code change sould be
simple for all callers but ice_discover_flash_size(), it intentionally
holds one lease across a read loop and would need to re-acquire after
each expected boundary failure.

Given how small the original window is, I'd rather not trade tested
OOT behavior for the risk of a complex unbalanced NVM lock fix. I
actually have a patch mostly ready that fixes the lock-ownership
contract, but I really don't like it. It changes the design of
ice_read_flat_nvm(), making it less intuitive for callers. More
importantly, I just don't have the resources or test coverage right
now to properly verify such change.

However, I can modify the failure path for ice_acquire_nvm inside
ice_read_flat_nvm. Instead of bailing out immediately, we can just
retry it within the existing retry budget. In this case, the
probability of leaving ice_read_flat_nvm without holding the lock is
reduced even further without needing a refactor.

Please let me know what you think about my thought process on this.



> > +                     retry_cnt++;
> > +             } else {
> > +                     bytes_read +=3D read_size;
> > +                     offset +=3D read_size;
> > +                     retry_cnt =3D 0;
> > +             }
> >       } while (!last_cmd);
> >
> >       *length =3D bytes_read;

Thanks,
Robert
