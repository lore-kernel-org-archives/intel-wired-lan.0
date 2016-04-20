From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Apr 2016 21:11:39 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v2 1/3] i40e/i40evf: Add
 support for GSO partial with UDP_TUNNEL_CSUM and GRE_CSUM
In-Reply-To: <20160414211925.14141.43481.stgit@ahduyck-xeon-server>
References: <20160414210725.14141.25917.stgit@ahduyck-xeon-server>
 <20160414211925.14141.43481.stgit@ahduyck-xeon-server>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D2648@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Thursday, April 14, 2016 2:19 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; alexander.duyck at gmail.com
> Subject: [Intel-wired-lan] [next-queue PATCH v2 1/3] i40e/i40evf: Add
> support for GSO partial with UDP_TUNNEL_CSUM and GRE_CSUM
> 
> This patch makes it so that i40e and i40evf can use GSO_PARTIAL to support
> segmentation for frames with checksums enabled in outer headers.  As a
> result we can now send data over these types of tunnels at over 20Gb/s
> versus the 12Gb/s that was previously possible on my system.
> 
> The advantage with the i40e parts is that this offload is mostly transparent as
> the hardware still deals with the inner and/or outer IPv4 headers so the IP ID
> is still incrementing for both when this offload is performed.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c     |   10 ++++++++--
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c     |    7 ++++++-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c   |    7 ++++++-
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c |   10 ++++++++--
>  4 files changed, 28 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
GRE tunnel traffic works as expected with speed increase
