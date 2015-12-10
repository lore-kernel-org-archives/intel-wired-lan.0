From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Thu, 10 Dec 2015 22:53:54 +0000
Subject: [Intel-wired-lan] [next PATCH 10/11] ixgbe: Clear stale
	pool	mappings
In-Reply-To: <20151103011026.28233.59751.stgit@localhost.localdomain>
References: <20151103005850.28233.63113.stgit@localhost.localdomain>
 <20151103011026.28233.59751.stgit@localhost.localdomain>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180CF61FD@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Monday, November 02, 2015 5:10 PM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH 10/11] ixgbe: Clear stale pool mappings
> 
> From: Alexander Duyck <alexander.h.duyck@redhat.com>
> 
> This patch makes certain that we clear the pool mappings added when we
> configure default MAC addresses for the interface.  Without this we run the risk
> of leaking an address into pool 0 which really belongs to VF 0 when SR-IOV is
> enabled.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
