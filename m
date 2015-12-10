From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Thu, 10 Dec 2015 22:53:10 +0000
Subject: [Intel-wired-lan] [next PATCH 07/11] ixgbe: Reorder search to
 work from the top down instead of bottom up
In-Reply-To: <20151103011007.28233.6659.stgit@localhost.localdomain>
References: <20151103005850.28233.63113.stgit@localhost.localdomain>
 <20151103011007.28233.6659.stgit@localhost.localdomain>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180CF61B0@ORSMSX108.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH 07/11] ixgbe: Reorder search to work
> from the top down instead of bottom up
> 
> This patch is meant to reduce the complexity of the search function used for
> finding a VLVF entry associated with a given VLAN ID.  The previous code was
> searching from bottom to top.  I reordered it to search from top to bottom.  In
> addition I pulled an AND statement out of the loop and instead replaced it with
> an OR statement outside the loop.  This should help to reduce the overall size
> and complexity of the function.
> 
> There was also some formatting I cleaned up in regards to whitespace and such.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
