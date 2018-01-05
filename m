From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 5 Jan 2018 19:29:32 +0000
Subject: [Intel-wired-lan] [next PATCH S85-V1 09/14] i40e/i40evf:
 Clean-up of bits related to using q_vector->reg_idx
In-Reply-To: <20171229135044.14551-1-alice.michael@intel.com>
References: <20171229135044.14551-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D7247@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, December 29, 2017 5:51 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S85-V1 09/14] i40e/i40evf: Clean-up of
> bits related to using q_vector->reg_idx
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch is a further clean-up related to the change over to using q_vector-
> >reg_idx when accessing the ITR registers. Specifically the code appears to
> have several other spots where we were computing the register offset
> manually and this resulted in errors in a few spots.
> 
> Specifically in the i40evf functions for mapping queues to vectors it appears
> we may have had an off by 1 error since (v_idx - 1) for the first q_vector with
> an index of 0 would result in us returning -1 if I am not mistaken.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 12 ++++++------
>  drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 12 +++++-------
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  6 ++++--
>  3 files changed, 15 insertions(+), 15 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


