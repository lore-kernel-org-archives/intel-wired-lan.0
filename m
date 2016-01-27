From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 27 Jan 2016 18:18:22 +0000
Subject: [Intel-wired-lan] [next PATCH v3 12/15] i40e: Fix ATR in
 relation	to tunnels
In-Reply-To: <20160125051736.12004.13420.stgit@localhost.localdomain>
References: <20160125050602.12004.38884.stgit@localhost.localdomain>
 <20160125051736.12004.13420.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98C7FE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Sunday, January 24, 2016 9:18 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [next PATCH v3 12/15] i40e: Fix ATR in relation to
> tunnels
> 
> This patch contains a number of fixes to make certain that we are using the
> correct protocols when parsing both the inner and outer headers of a frame
> that is mixed between IPv4 and IPv6 for inner and outer.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c |   28 +++++++++++---------------
> -
>  1 file changed, 11 insertions(+), 17 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Tunnel protocols applied correctly to packet headers, ATR counters show ATR activity as expected
