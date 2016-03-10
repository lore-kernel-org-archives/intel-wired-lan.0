From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 10 Mar 2016 18:37:15 +0000
Subject: [Intel-wired-lan] [PATCH 1/5] i40e/i40evf: Fix handling of
 boolean logic in polling routines
In-Reply-To: <20160307172957.5682.16383.stgit@localhost.localdomain>
References: <20160307172722.5682.38580.stgit@localhost.localdomain>
 <20160307172957.5682.16383.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99CCCD@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Monday, March 07, 2016 9:30 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 1/5] i40e/i40evf: Fix handling of boolean
> logic in polling routines
> 
> In the polling routines for i40e and i40evf we were using bitwise operators to
> avoid the side effects of the logical operators, specifically the fact that if the
> first case is true with "||" we skip the second case, or if it is false with "&&"
> we skip the second case.  This fixes an earlier patch that converted the
> bitwise operators over to the logical operators and instead replaces the
> entire thing with just an if statement since it should be more readable what
> we are trying to do this way.
> 
> Fixes: 1a36d7fadd14 ("i40e/i40evf: use logical operators, not bitwise")
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   13 ++++++++-----
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |   13 ++++++++-----
>  2 files changed, 16 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Driver correctly builds and passes traffic normally.
