From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 27 Jan 2016 18:04:42 +0000
Subject: [Intel-wired-lan] [next PATCH v3 06/15] i40e/i40evf: Add
 support for IPv4 encapsulated in IPv6
In-Reply-To: <20160125051648.12004.64219.stgit@localhost.localdomain>
References: <20160125050602.12004.38884.stgit@localhost.localdomain>
 <20160125051648.12004.64219.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98C79B@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH v3 06/15] i40e/i40evf: Add support for
> IPv4 encapsulated in IPv6
> 
> This patch fixes two issues.  First was the fact that iphdr(skb)->protocl was
> being used to test for the outer transport protocol.  This completely breaks
> IPv6 support.  Second was the fact that we cleared the flag for v4 going to v6,
> but we didn't take care of txflags going the other way.  As such we would
> have the v6 flag still set even if the inner header was v4.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   38 ++++++++++++++---------
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |   42 ++++++++++++++++----
> -----
>  2 files changed, 50 insertions(+), 30 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
IPv4 encapsulated in IPv6 works properly
