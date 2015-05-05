From: Young, James M <james.m.young@intel.com>
Date: Tue, 5 May 2015 16:12:48 +0000
Subject: [Intel-wired-lan] [net-next S4 13/15] i40e/i40evf: force
	inline	transmit functions
In-Reply-To: <1429229172-143692-14-git-send-email-catherine.sullivan@intel.com>
References: <1429229172-143692-1-git-send-email-catherine.sullivan@intel.com>
 <1429229172-143692-14-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783E9F8F21@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, April 16, 2015 5:06 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net-next S4 13/15] i40e/i40evf: force inline
> transmit functions
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Inlining these functions gives us about 15% more 64 byte packets per second
> when using pktgen. 13.3 million to 15 million with a single queue.
> 
> Also fix the function names in i40evf to i40evf not i40e while we are touching
> the function header.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> Change-ID: I3294ae9b085cf438672b6db5f9af122490ead9d0
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 32 ++++++++++++------------
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 36 ++++++++++++------------
> ---
>  2 files changed, 32 insertions(+), 36 deletions(-)

Tested-by: Jim Young <james.m.young@intel.com>

