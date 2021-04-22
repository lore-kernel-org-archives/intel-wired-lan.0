From: Switzer, David <david.switzer@intel.com>
Date: Thu, 22 Apr 2021 21:00:53 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/3] i40e: use minimal tx and rx
 pairs for kdump
In-Reply-To: <20210304025543.334912-2-coxu@redhat.com>
References: <20210304025543.334912-1-coxu@redhat.com>
 <20210304025543.334912-2-coxu@redhat.com>
Message-ID: <MW3PR11MB4748DAD8745E21A92A7CD38FEB469@MW3PR11MB4748.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


>-----Original Message-----
>From: Coiby Xu <coxu@redhat.com>
>Sent: Wednesday, March 3, 2021 6:56 PM
To: netdev@vger.kernel.org
>Cc: kexec at lists.infradead.org; intel-wired-lan at lists.osuosl.org; Jakub Kicinski
><kuba@kernel.org>; Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen,
>Anthony L <anthony.l.nguyen@intel.com>; David S. Miller
><davem@davemloft.net>; open list <linux-kernel@vger.kernel.org>
>Subject: [PATCH v1 1/3] i40e: use minimal tx and rx pairs for kdump
>
>Set the number of the MSI-X vectors to 1. When MSI-X is enabled, it's not allowed
>to use more TC queue pairs than MSI-X vectors
>(pf->num_lan_msix) exist. Thus the number of tx and rx pairs
>(vsi->num_queue_pairs) will be equal to the number of MSI-X vectors, i.e., 1.
>
>Signed-off-by: Coiby Xu <coxu@redhat.com>
>---
> drivers/net/ethernet/intel/i40e/i40e_main.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
Tested-by: Dave Switzer <david.switzer@intel.com
