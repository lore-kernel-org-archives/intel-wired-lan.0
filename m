From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 27 Jan 2016 16:27:28 +0000
Subject: [Intel-wired-lan] [next PATCH v3 05/15] i40e/i40evf: Replace
 header pointers with unions of pointers in Tx checksum path
In-Reply-To: <20160125051642.12004.46612.stgit@localhost.localdomain>
References: <20160125050602.12004.38884.stgit@localhost.localdomain>
 <20160125051642.12004.46612.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98C777@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH v3 05/15] i40e/i40evf: Replace header
> pointers with unions of pointers in Tx checksum path
> 
> The Tx checksum path was maintaining a set of 3 pointers and two lengths in
> order to prepare the packet for being checksummed.  The thing is we only
> really needed 2 pointers, and the lengths that were being maintained can
> easily be computed.
> 
> As such we can replace the IPv4 and IPv6 header pointers with one single
> union that represents both, or a generic pointer to the start of the network
> header.  For the L4 headers we can do the same with TCP and a generic
> pointer to the start of the transport header.  The length of the TCP header is
> obtained by simply multiplying doff by 4, and the network header length can
> be obtained by subtracting the network header pointer from the transport
> header pointer.
> 
> While I was at it I renamed l4_hdr to l4_proto to make it a bit more clear and
> less likely to be confused with l4.hdr which is the transport header pointer.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   51 +++++++++++++----------
> --
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |   52 +++++++++++++---------
> ---
>  2 files changed, 52 insertions(+), 51 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
checksum offload works as expected
