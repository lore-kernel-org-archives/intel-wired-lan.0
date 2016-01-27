From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 27 Jan 2016 18:07:49 +0000
Subject: [Intel-wired-lan] [next PATCH v3 08/15] i40e/i40evf: Do not
 write to descriptor unless we complete
In-Reply-To: <20160125051701.12004.23605.stgit@localhost.localdomain>
References: <20160125050602.12004.38884.stgit@localhost.localdomain>
 <20160125051701.12004.23605.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98C7B7@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Sunday, January 24, 2016 9:17 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [next PATCH v3 08/15] i40e/i40evf: Do not write to
> descriptor unless we complete
> 
> This patch defers writing to the Tx descriptor bits until we know we have
> successuflly completed a given operation.  So for example we defer updating
> the tunnelling portion of the context descriptor until we have fully identified
> the type.
> 
> The advantage to this approach is that we can assemble values as we go
> instead of having to try and cludge everything together all at once.  As a
> result we can significantly clean up the tunneling configuration for instance as
> we can just do a pointer walk and do the math for the distance between
> each set of points.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   81 +++++++++++++----------
> --
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |   81 +++++++++++++---------
> ---
>  2 files changed, 84 insertions(+), 78 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Tunnelling, offloads work correctly
