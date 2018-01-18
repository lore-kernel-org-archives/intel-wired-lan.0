From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 18 Jan 2018 07:51:18 -0800
Subject: [Intel-wired-lan] [RFC PATCH] e1000e: Remove Other from EIAC.
In-Reply-To: <20180118065054.29844-1-bpoirier@suse.com>
References: <20180118065054.29844-1-bpoirier@suse.com>
Message-ID: <CAKgT0UemPMN-30ubbKDR8za4w6f6T2R4GZt5atFzOkCpoSFhsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jan 17, 2018 at 10:50 PM, Benjamin Poirier <bpoirier@suse.com> wrote:
> It was reported that emulated e1000e devices in vmware esxi 6.5 Build
> 7526125 do not link up after commit 4aea7a5c5e94 ("e1000e: Avoid receiver
> overrun interrupt bursts", v4.15-rc1). Some tracing shows that after
> e1000e_trigger_lsc() is called, ICR reads out as 0x0 in e1000_msix_other()
> on emulated e1000e devices. In comparison, on real e1000e 82574 hardware,
> icr=0x80000004 (_INT_ASSERTED | _OTHER) in the same situation.

Isn't 0x80000004 (_INT_ASSERTED | _LSC)? The assumption I based my
patch on was that the VMware code was sending _OTHER instead of _LSC
to trigger LSC events. As such in my version of the workaround I just
went through and did the testing if the _RXO bit was set, otherwise I
assumed that whatever event was received must have been meant to
trigger an _LSC type event since that worked in the past.

> Some experimentation showed that this flaw in vmware e1000e emulation can
> be worked around by not setting Other in EIAC. This is how it was before
> 16ecba59bc33 ("e1000e: Do not read ICR in Other interrupt", v4.5-rc1).

Did this actually set the _LSC bit or was it just giving you the
_OTHER bit? The ICR for that combination would come out 0x81000000.

> Fixes: 4aea7a5c5e94 ("e1000e: Avoid receiver overrun interrupt bursts")
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>
> Jeff, I'm sending as RFC since it looks like a problem that should be fixed
> in vmware. If you'd like to have the workaround in e1000e, I'll submit.

I would appreciate it if you could review/test the patch I submitted
for the same issue. Specifically I would want to make certain that it
still addresses the original RXO interrupt burst issue your reported.

Thanks.

- Alex
