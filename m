From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Aug 2018 20:54:16 +0000
Subject: [Intel-wired-lan] [next PATCH S95 08/12] i40evf: Validate the
 number of queues a PF sends
In-Reply-To: <20180820151233.14629-8-alice.michael@intel.com>
References: <20180820151233.14629-1-alice.michael@intel.com>
 <20180820151233.14629-8-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2EB318@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, August 20, 2018 8:12 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Stillwell Jr, Paul M <paul.m.stillwell.jr@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S95 08/12] i40evf: Validate the
> number of queues a PF sends
> 
> From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> 
> A PF can send any number of queues to the VF and the VF may not be able
> to support that many. Check to see that the number of queues is less than or
> equal to the max number of queues the VF can have.
> 
> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> ---
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 32
> ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
