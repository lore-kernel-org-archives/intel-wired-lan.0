From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 21 Mar 2017 23:27:49 +0000
Subject: [Intel-wired-lan] [next PATCH S62 4/6] i40e: Check for new
	arq	elements before leaving the adminq subtask loop
In-Reply-To: <1489177325-13156-5-git-send-email-bimmy.pujari@intel.com>
References: <1489177325-13156-1-git-send-email-bimmy.pujari@intel.com>
 <1489177325-13156-5-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A104068B0@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Friday, March 10, 2017 12:22 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Bednarz, Christopher N <christopher.n.bednarz@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S62 4/6] i40e: Check for new arq
> elements before leaving the adminq subtask loop
> 
> From: "Christopher Bednarz" <christopher.n.bednarz@intel.com>
> 
> Fix a case where we miss an arq element if a new one is added before we
> enable interrupts and exit the arq subtask loop. This occurs frequently with
> Rdma running on Windows VF and causes long delays that prevent SMB from
> establishing connections.
> 
> Signed-off-by: Christopher N Bednarz <christopher.n.bednarz@intel.com>
> Change-ID: I3e1c8b2b960c12857d9b8275bea2c1563674392e
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


