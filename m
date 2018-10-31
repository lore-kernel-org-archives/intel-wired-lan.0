From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Oct 2018 21:36:53 +0000
Subject: [Intel-wired-lan] [net 1/2] i40e: restore NETIF_F_GSO_IPXIP[46]
 to netdev features
In-Reply-To: <20181029175243.13453-1-jacob.e.keller@intel.com>
References: <20181029175243.13453-1-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3291A6@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Monday, October 29, 2018 10:53 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [net 1/2] i40e: restore NETIF_F_GSO_IPXIP[46] to
> netdev features
> 
> Since commit bacd75cfac8a ("i40e/i40evf: Add capability exchange for outer
> checksum", 2017-04-06) the i40e driver has not reported support for IP-in-IP
> offloads. This likely occurred due to a bad rebase, as the commit extracts
> hw_enc_features into its own variable. As part of this change, it dropped the
> NETIF_F_FSO_IPXIP flags from the
> netdev->hw_enc_features. This was unfortunately not caught during code
> review.
> 
> Fix this by adding back the missing feature flags.
> 
> For reference, NETIF_F_GSO_IPXIP4 was added in commit 7e13318daa4a
> ("net: define gso types for IPx over IPv4 and IPv6", 2016-05-20), replacing
> NETIF_F_GSO_IPIP and NETIF_F_GSO_SIT.
> 
> NETIF_F_GSO_IPXIP6 was added in commit bf2d1df39502 ("intel: Add
> support for IPv6 IP-in-IP offload", 2016-05-20).
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


