From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 27 Jan 2016 16:09:19 +0000
Subject: [Intel-wired-lan] [next PATCH v3 03/15] i40e/i40evf: Factor out
 L4 header and checksum from L3 bits in TSO path
In-Reply-To: <20160125051628.12004.51971.stgit@localhost.localdomain>
References: <20160125050602.12004.38884.stgit@localhost.localdomain>
 <20160125051628.12004.51971.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98C751@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Sunday, January 24, 2016 9:16 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [next PATCH v3 03/15] i40e/i40evf: Factor out L4
> header and checksum from L3 bits in TSO path
> 
> This patch makes it so that the L4 header offsets and such can be ignored
> when dealing with the L3 checksum and length update.  This is done making
> use of two things.
> 
> First we can just use the offset from the L4 header to the start of the packet
> to determine the L4 offset, and from that we can then make use of the data
> offset to determine the full length of the headers.
> 
> As far as adjusting the checksum to remove the length we can simply add the
> inverse of the length instead of having to recompute the entire pseudo-
> header without the length.  In the case of an IPv6 header this should be
> significantly cheaper since we can make use of a value we already needed
> instead of having to read the source and destination address out of the
> packet.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   31 +++++++++++++++-------
> ---
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |   31 +++++++++++++++------
> ----
>  2 files changed, 36 insertions(+), 26 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
TSO works as expected, code changes properly applied
