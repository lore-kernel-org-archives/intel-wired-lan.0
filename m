From: Switzer, David <david.switzer@intel.com>
Date: Thu, 22 Apr 2021 20:59:40 +0000
Subject: [Intel-wired-lan] [PATCH v1 2/3] i40e: use minimal rx and tx
 ring buffers for kdump
In-Reply-To: <20210304025543.334912-3-coxu@redhat.com>
References: <20210304025543.334912-1-coxu@redhat.com>
 <20210304025543.334912-3-coxu@redhat.com>
Message-ID: <MW3PR11MB474851ACCF8ADCC33EA928C6EB469@MW3PR11MB4748.namprd11.prod.outlook.com>
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
>Subject: [PATCH v1 2/3] i40e: use minimal rx and tx ring buffers for kdump
>
>Use the minimum of the number of descriptors thus we will allocate the minimal
>ring buffers for kdump.
>
>Signed-off-by: Coiby Xu <coxu@redhat.com>
>---
> drivers/net/ethernet/intel/i40e/i40e_main.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
Tested-by: Dave Switzer <david.switzer@intel.com>

