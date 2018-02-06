From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 6 Feb 2018 22:35:02 +0000
Subject: [Intel-wired-lan] [next PATCH S86 V3 3/8] i40evf: Use an
 iterator of the same type as the list
In-Reply-To: <20180205111121.59468-3-alice.michael@intel.com>
References: <20180205111121.59468-1-alice.michael@intel.com>
 <20180205111121.59468-3-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A949931@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, February 5, 2018 3:11 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S86 V3 3/8] i40evf: Use an iterator of
> the same type as the list
> 
> From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> 
> When iterating through the linked list of vlan filters, make the iterator the
> same type as that of the linked list.
> 
> Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


