From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 23 Aug 2017 20:53:59 +0000
Subject: [Intel-wired-lan] [next PATCH S78-V8 11/12] i40e: fix client
 notify	of VF reset
In-Reply-To: <20170822105754.29486-12-alice.michael@intel.com>
References: <20170822105754.29486-1-alice.michael@intel.com>
 <20170822105754.29486-12-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10E9F388@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, August 22, 2017 3:58 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S78-V8 11/12] i40e: fix client notify of
> VF reset
> 
> From: Alan Brady <alan.brady@intel.com>
> 
> Currently there is a bug in which the PF driver fails to inform clients of a VF
> reset which then causes clients to leak resources.  The bug exists because we
> were incorrectly checking the I40E_VF_STATE_PRE_ENABLE bit.
> 
> When a VF is first init we go through a reset to initialize variables and allocate
> resources but we don't want to inform clients of this first reset since the
> client isn't fully enabled yet so we set a state bit signifying we're in a "pre-
> enabled" client state.  During the first reset we should be clearing the bit,
> allowing all following resets to notify the client of the reset when the bit is
> not set.  This patch fixes the issue by negating the 'test_and_clear_bit' check
> to accurately reflect the behavior we want.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


