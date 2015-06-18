From: Young, James M <james.m.young@intel.com>
Date: Thu, 18 Jun 2015 00:18:57 +0000
Subject: [Intel-wired-lan] [net-next S5 01/15] i40e/i40evf: improve
	tx	performance with a small tweak
In-Reply-To: <1430161042-28494-2-git-send-email-catherine.sullivan@intel.com>
References: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
 <1430161042-28494-2-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783EA19AFC@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, April 27, 2015 11:57 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net-next S5 01/15] i40e/i40evf: improve tx
> performance with a small tweak
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Add a prefetch for the next tx descriptor to be used when we know there
> are more coming.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: Ibb9acab11d508eec2db7da795df74debc16eeacb
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 2 ++
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
Tested-by: Jim Young <james.m.young@intel.com>
 
