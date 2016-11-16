From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 16 Nov 2016 19:24:10 +0000
Subject: [Intel-wired-lan] [next PATCH S52-V2 04/15] i40evf: protect
 against	NULL msix_entries and q_vectors pointers
In-Reply-To: <1478639119-14656-5-git-send-email-bimmy.pujari@intel.com>
References: <1478639119-14656-1-git-send-email-bimmy.pujari@intel.com>
 <1478639119-14656-5-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA36D2E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, November 08, 2016 1:05 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S52-V2 04/15] i40evf: protect against
> NULL msix_entries and q_vectors pointers
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Update the functions which free msix_entries and q_vectors so that they are
> safe against NULL values. This allows calling code to not care whether these
> have already been freed when disabling and freeing them.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I31bfd1c0da18023d971b618edc6fb049721f3298
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 20 ++++++++++++++-----
> -
>  1 file changed, 14 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


