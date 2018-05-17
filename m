From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 17 May 2018 22:12:23 +0000
Subject: [Intel-wired-lan] [next PATCH S92 3/9] i40e: always return all
 queue stat strings
In-Reply-To: <20180517080840.30192-3-alice.michael@intel.com>
References: <20180517080840.30192-1-alice.michael@intel.com>
 <20180517080840.30192-3-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1B771850@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, May 17, 2018 1:09 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S92 3/9] i40e: always return all queue
> stat strings
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The ethtool API for obtaining device statistics is not intended to allow
> runtime changes in the number of statistics reported. It may *appear* this
> way, as there is an ability to request the number of stats using
> ethtool_get_set_count(). However, it is expected that this must always
> return the same value for invocations of the same device.
> 
> If we don't satisfy this contract, and allow the number of stats to change
> during run time, we could cause invalid memory accesses or report the stat
> strings incorrectly. This is because the API for obtaining stats is to (1) get the
> size, (2) get the strings and finally (3) get the stats. Since these are each
> separate ethtool op commands, it is not possible to maintain consistency by
> holding the RTNL lock over the whole operation. This results in the potential
> for a race condition to occur where the size changed between any of the 3
> calls.
> 
> Avoid this issue by requiring that we always return the same value for a given
> device. We can check any values which remain constant for the life of the
> device, but must not report different sizes depending on runtime attributes.
> 
> This patch specifically fixes the queue statistics to always return every queue
> even if it's not currently in use.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 22 +++++++++++++++++--
> ---
>  1 file changed, 17 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


