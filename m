From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 24 Jun 2016 16:25:06 +0000
Subject: [Intel-wired-lan] [net PATCH] i40e/i40evf: Fix i40e_rx_checksum
In-Reply-To: <20160614224542.9471.71002.stgit@localhost.localdomain>
References: <20160614224542.9471.71002.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9E9074@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Tuesday, June 14, 2016 3:46 PM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net PATCH] i40e/i40evf: Fix i40e_rx_checksum
> 
> There are a couple of issues I found in i40e_rx_checksum while doing some
> recent testing.  As a result I have found the Rx checksum logic is pretty much
> broken and returning that the checksum is valid for tunnels in cases where it
> is not.
> 
> First the inner types are not the correct values to use to test for if a tunnel is
> present or not.  In addition the inner protocol types are not a bitmask as such
> performing an OR of the values doesn't make sense.  I have instead changed
> the code so that the inner protocol types are used to determine if we report
> CHECKSUM_UNNECESSARY or not.  For anything that does not end in UDP,
> TCP, or SCTP it doesn't make much sense to report a checksum offload since
> it won't contain a checksum anyway.
> 
> This leaves us with the need to set the csum_level based on some value.
> For that purpose I am using the tunnel_type field.  If the tunnel type is
> GRENAT or greater then this means we have a GRE or UDP tunnel with an
> inner header.  In the case of GRE or UDP we will have a possible checksum
> present so for this reason it should be safe to set the csum_level to 1 to
> indicate that we are reporting the state of the inner header.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   30 ++++++++++++++---------
> --
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |   30 ++++++++++++++--------
> ---
>  2 files changed, 34 insertions(+), 26 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Works as expected
