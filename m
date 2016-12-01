From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 1 Dec 2016 18:50:42 +0000
Subject: [Intel-wired-lan] [next PATCH S55 02/14] i40e: Quick refactor
 to	start moving data off stack and into Tx buffer info
In-Reply-To: <1480377971-23412-3-git-send-email-bimmy.pujari@intel.com>
References: <1480377971-23412-1-git-send-email-bimmy.pujari@intel.com>
 <1480377971-23412-3-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA38EE4@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, November 28, 2016 4:06 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S55 02/14] i40e: Quick refactor to start
> moving data off stack and into Tx buffer info
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch does some quick work to pull some of the data off of the stack and
> hopefully start storing it in the Tx buffer info section of the Tx ring.  Ideally
> we should be moving away from having to store much of anything on the
> stack and can just maintain it all in the descriptor rings.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Change-ID: I4b4715ea1920e122502482b3f9e56a9a6cb1e9fe
> ---
> Testing Hints:
>         This should not break the transmit path and should have no
>         signficant impact on Tx performance.  It brings us closer to what
>         is already in ixgbe and enables us to add support for a workaround
>         needed to deal with gso_size less than 64.
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 47 +++++++++++++++--------
> ----
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 47 +++++++++++++++-------
> -----
>  2 files changed, 54 insertions(+), 40 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


