From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Date: Tue, 02 Jun 2020 18:34:25 +0900
Subject: [Intel-wired-lan] Intel-wired-lan Digest, Vol 268, Issue 43,
 Replay to message number 6,
 Test hints request for e1000e: Relax condition to trigger reset for ME
 workaround patch
In-Reply-To: <7cdf1300-973e-6950-8146-d0481661b98b@intel.com> (Amir Avivi's
 message of "Tue, 2 Jun 2020 10:13:00 +0300")
References: <mailman.9577.1590117676.59095.intel-wired-lan@osuosl.org>
 <7cdf1300-973e-6950-8146-d0481661b98b@intel.com>
Message-ID: <87367d7qvy.fsf@kokedama.swc.toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Amir,

"Avivi, Amir" <amir.avivi@intel.com> writes:

[...]

> Subject: [PATCH] e1000e: Relax condition to trigger reset for ME workaround
>
> It's an error if the value of the RX/TX tail descriptor does not match
> what was written. The error condition is true regardless the duration
> of the interference from ME. But the driver only performs the reset if
> E1000_ICH_FWSM_PCIM2PCI_COUNT (2000) iterations of 50us delay have
> transpired. The extra condition can lead to inconsistency between the
> state of hardware as expected by the driver.
>
> Fix this by dropping the check for number of delay iterations.
>
> While at it, also make __ew32_prepare() static as it's not used
> anywhere else.
>
> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> ---
> Hi Jeff,
>
> If there are no further comments please consider merging the patch.
>
> Also, should it be marked for backport to stable?
>
> Thanks,
> Punit
>
> RFC[0] -> v1:
> * Dropped return value for __ew32_prepare() as it's not used
> * Made __ew32_prepare() static
> * Added tags
>
> [0] https://lkml.org/lkml/2020/5/12/02
>
>  drivers/net/ethernet/intel/e1000e/e1000.h  |  1 -
>  drivers/net/ethernet/intel/e1000e/netdev.c | 12 +++++-------
>  2 files changed, 5 insertions(+), 8 deletions(-)
>
> Tested-by: Aaron Brown <aaron.f.brown@intel.com>
>
> Thanks for taking the patch for a spin.
>
> Jeff, let me know if you're okay to apply the tag or want me to send a
> new version.
>
> Hi Punit,
> This patch appears to be effecting some legacy code effecting old
> hardware.

Indeed. The problem under investigation was reported on a machine
released ~2012 I think.

> We tried applying it but we could not get the driver to run the
> changed code lines.
> Please provide some test hints(What platforms did
> you check it on?  What tests did you run?) regarding this patch.

As mentioned in the original posting[0], the patch was based on code
investigation.

A backported version of the patch is running on a really old kernel
(2.6.x) and we haven't found any way to speed up reproduction - it takes
O(weeks) to hit the issue in the test environment.

[0] https://lkml.org/lkml/2020/5/12/20

[...]

