From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Thu, 10 Dec 2015 22:52:13 +0000
Subject: [Intel-wired-lan] [next PATCH 03/11] ixgbe: Simplify
 definitions for regidx and bit in set_vfta
In-Reply-To: <20151103010941.28233.36303.stgit@localhost.localdomain>
References: <20151103005850.28233.63113.stgit@localhost.localdomain>
 <20151103010941.28233.36303.stgit@localhost.localdomain>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180CF6153@ORSMSX108.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH 03/11] ixgbe: Simplify definitions for
> regidx and bit in set_vfta
> 
> This patch simplifies the logic for setting the VFTA register by removing the
> number of conditional checks needed.  Instead we just use some boolean logic
> to generate vfta_delta, and if that is set then we xor the vfta by that value and
> write it back.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
