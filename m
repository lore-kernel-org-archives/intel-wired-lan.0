From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 14 Dec 2020 19:24:48 +0100
Subject: [Intel-wired-lan] [PATCH v4 0/4] Improve s0ix flows for systems
 i219LM
In-Reply-To: <20201214153450.874339-1-mario.limonciello@dell.com>
References: <20201214153450.874339-1-mario.limonciello@dell.com>
Message-ID: <80862f70-18a4-4f96-1b96-e2fad7cc2b35@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi All,

Sasha (and the other intel-wired-lan folks), thank you for investigating this
further and for coming up with a better solution.

Mario, thank you for implementing the new scheme.

I've tested this patch set on a Lenovo X1C8 with vPRO and AMT enabled in the BIOS
(the previous issues were soon on a X1C7).

I have good and bad news:

The good news is that after reverting the
"e1000e: disable s0ix entry and exit flows for ME systems"
I can reproduce the original issue on the X1C8 (I no longer have
a X1C7 to test on).

The bad news is that increasing the timeout to 1 second does
not fix the issue. Suspend/resume is still broken after one
suspend/resume cycle, as described in the original bug-report:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1865570

More good news though, bumping the timeout to 250 poll iterations
(approx 2.5 seconds) as done in Aaron Ma's original patch for
this fixes this on the X1C8 just as it did on the X1C7
(it takes 2 seconds for ULP_CONFIG_DONE to clear).

I've ran some extra tests and the poll loop succeeds on its
first iteration when an ethernet-cable is connected. It seems
that Lenovo's variant of the ME firmware waits up to 2 seconds
for a link, causing the long wait for ULP_CONFIG_DONE to clear.

I think that for now the best fix would be to increase the timeout
to 2.5 seconds as done in  Aaron Ma's original patch. Combined
with a broken-firmware warning when we waited longer then 1 second,
to make it clear that there is a firmware issue here and that
the long wait / slow resume is not the fault of the driver.

###

I've added Mark Pearson from Lenovo to the Cc so that Lenovo
can investigate this issue further.

Mark, this thread is about an issue with enabling S0ix support for
e1000e (i219lm) controllers. This was enabled in the kernel a
while ago, but then got disabled again on vPro / AMT enabled
systems because on some systems (Lenovo X1C7 and now also X1C8)
this lead to suspend/resume issues.

When AMT is active then there is a handover handshake for the
OS to get access to the ethernet controller from the ME. The
Intel folks have checked and the Windows driver is using a timeout
of 1 second for this handshake, yet on Lenovo systems this is
taking 2 seconds. This likely has something to do with the
ME firmware on these Lenovo models, can you get the firmware
team at Lenovo to investigate this further ?

Regards,

Hans

p.s.

I also have a small review remark on patch 4/4 I will
reply to that patch separately.








On 12/14/20 4:34 PM, Mario Limonciello wrote:
> commit e086ba2fccda ("e1000e: disable s0ix entry and exit flows for ME systems")
> disabled s0ix flows for systems that have various incarnations of the
> i219-LM ethernet controller.  This was done because of some regressions
> caused by an earlier
> commit 632fbd5eb5b0e ("e1000e: fix S0ix flows for cable connected case")
> with i219-LM controller.
> 
> Per discussion with Intel architecture team this direction should be changed and
> allow S0ix flows to be used by default.  This patch series includes directional
> changes for their conclusions in https://lkml.org/lkml/2020/12/13/15.
> 
> Changes from v3 to v4:
>  - Drop patch 1 for proper s0i3.2 entry, it was separated and is now merged in kernel
>  - Add patch to only run S0ix flows if shutdown succeeded which was suggested in
>    thread
>  - Adjust series for guidance from https://lkml.org/lkml/2020/12/13/15
>    * Revert i219-LM disallow-list.
>    * Drop all patches for systems tested by Dell in an allow list
>    * Increase ULP timeout to 1000ms
> Changes from v2 to v3:
>  - Correct some grammar and spelling issues caught by Bjorn H.
>    * s/s0ix/S0ix/ in all commit messages
>    * Fix a typo in commit message
>    * Fix capitalization of proper nouns
>  - Add more pre-release systems that pass
>  - Re-order the series to add systems only at the end of the series
>  - Add Fixes tag to a patch in series.
> 
> Changes from v1 to v2:
>  - Directly incorporate Vitaly's dependency patch in the series
>  - Split out s0ix code into it's own file
>  - Adjust from DMI matching to PCI subsystem vendor ID/device matching
>  - Remove module parameter and sysfs, use ethtool flag instead.
>  - Export s0ix flag to ethtool private flags
>  - Include more people and lists directly in this submission chain.
> 
> Mario Limonciello (4):
>   e1000e: Only run S0ix flows if shutdown succeeded
>   e1000e: bump up timeout to wait when ME un-configure ULP mode
>   Revert "e1000e: disable s0ix entry and exit flows for ME systems"
>   e1000e: Export S0ix flags to ethtool
> 
>  drivers/net/ethernet/intel/e1000e/e1000.h   |  1 +
>  drivers/net/ethernet/intel/e1000e/ethtool.c | 40 ++++++++++++++
>  drivers/net/ethernet/intel/e1000e/ich8lan.c |  4 +-
>  drivers/net/ethernet/intel/e1000e/netdev.c  | 59 ++++-----------------
>  4 files changed, 53 insertions(+), 51 deletions(-)
> 
> --
> 2.25.1
> 

