From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 4 Dec 2020 13:27:07 -0800
Subject: [Intel-wired-lan] [PATCH v3 0/7] Improve s0ix flows for systems
 i219LM
In-Reply-To: <20201204200920.133780-1-mario.limonciello@dell.com>
References: <20201204200920.133780-1-mario.limonciello@dell.com>
Message-ID: <CAKgT0Uc=OxcuHbZihY3zxsxzPprJ_8vGHr=reBJFMrf=V9A5kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Dec 4, 2020 at 12:09 PM Mario Limonciello
<mario.limonciello@dell.com> wrote:
>
> commit e086ba2fccda ("e1000e: disable s0ix entry and exit flows for ME systems")
> disabled s0ix flows for systems that have various incarnations of the
> i219-LM ethernet controller.  This was done because of some regressions
> caused by an earlier
> commit 632fbd5eb5b0e ("e1000e: fix S0ix flows for cable connected case")
> with i219-LM controller.
>
> Performing suspend to idle with these ethernet controllers requires a properly
> configured system.  To make enabling such systems easier, this patch
> series allows determining if enabled and turning on using ethtool.
>
> The flows have also been confirmed to be configured correctly on Dell's Latitude
> and Precision CML systems containing the i219-LM controller, when the kernel also
> contains the fix for s0i3.2 entry previously submitted here and now part of this
> series.
> https://marc.info/?l=linux-netdev&m=160677194809564&w=2
>
> Patches 4 through 7 will turn the behavior on by default for some of Dell's
> CML and TGL systems.

The patches look good to me. Just need to address the minor issue that
seems to have been present prior to the introduction of this patch
set.

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
