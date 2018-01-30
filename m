From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 30 Jan 2018 11:46:12 -0800
Subject: [Intel-wired-lan] [RFC PATCH] e1000e: Remove Other from EIAC.
In-Reply-To: <20180118065054.29844-1-bpoirier@suse.com>
References: <20180118065054.29844-1-bpoirier@suse.com>
Message-ID: <CAKgT0Uc+sSREnAvF=TTDp2FFxGcro6JmDpE2KdnEYk5rDE3Tpw@mail.gmail.com>
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
>
> Some experimentation showed that this flaw in vmware e1000e emulation can
> be worked around by not setting Other in EIAC. This is how it was before
> 16ecba59bc33 ("e1000e: Do not read ICR in Other interrupt", v4.5-rc1).
>
> Fixes: 4aea7a5c5e94 ("e1000e: Avoid receiver overrun interrupt bursts")
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---

Hi Benjamin,

How would you feel about resubmitting this patch for net?

We have some issues that have come up and it would be useful to have
this fixed in the kernel sooner rather than later. I would be okay
with us applying it for now while we work on coming up with a more
complete solution.

Thanks.

- Alex
