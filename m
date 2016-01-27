From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 27 Jan 2016 18:49:59 +0000
Subject: [Intel-wired-lan] [next PATCH 1/3] i40e: Add support for ATR
	w/	IPv6 extension headers
In-Reply-To: <20160126033124.16387.6402.stgit@localhost.localdomain>
References: <20160126032616.16387.86351.stgit@localhost.localdomain>
 <20160126033124.16387.6402.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98C849@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Monday, January 25, 2016 7:33 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [next PATCH 1/3] i40e: Add support for ATR w/ IPv6
> extension headers
> 
> This patch updates the code for determining the L4 protocol and L3 header
> length so that when IPv6 extension headers are being used we can
> determine the offset and type of the L4 protocol.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
> 
> Testing Hints:
> Test with mix of tunnel and non-tunnel headers to verify that frames
> containing IPv6 extension headers are properly triggering ATR match events.
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c |   30 +++++++++++++------------
> --
>  1 file changed, 14 insertions(+), 16 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
ATR events properly triggered with IPv6 tunnel and non-tunnel traffic, counters increment as expected
