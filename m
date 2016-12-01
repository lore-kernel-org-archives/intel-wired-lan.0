From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 1 Dec 2016 21:49:04 +0000
Subject: [Intel-wired-lan] [next PATCH S55 12/14] i40e/i40evf:
	elimitate	i40e_pull_tail()
In-Reply-To: <1480377971-23412-13-git-send-email-bimmy.pujari@intel.com>
References: <1480377971-23412-1-git-send-email-bimmy.pujari@intel.com>
 <1480377971-23412-13-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA38FF2@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S55 12/14] i40e/i40evf: elimitate
> i40e_pull_tail()
> 
> From: "Scott Peterson" <scott.d.peterson@intel.com>
> 
> Reorganize the i40e_pull_tail() logic, doing it in i40e_add_rx_frag() where it's
> cheaper.  The igb driver does this the same way.
> 
> Also renames i40e_page_is_reserved() to reflect what it actually tests.
> 
> Signed-off-by: Scott Peterson <scott.d.peterson@intel.com>
> Change-ID: Icd9cc507aae1fcdc02308b3a09034111b4c24071
> ---
> Testing Hints:
> Needs data integrity verification (e.g. rsync with checksums twice)
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 169 ++++++++++++++---------
> ---
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 169 ++++++++++++++-------
> -----
>  2 files changed, 186 insertions(+), 152 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


