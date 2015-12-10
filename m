From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Thu, 10 Dec 2015 22:51:49 +0000
Subject: [Intel-wired-lan] [next PATCH 01/11] ixgbe: Return error on
 failure to allocate mac_table
In-Reply-To: <20151103010929.28233.47017.stgit@localhost.localdomain>
References: <20151103005850.28233.63113.stgit@localhost.localdomain>
 <20151103010929.28233.47017.stgit@localhost.localdomain>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180CF612A@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Monday, November 02, 2015 5:09 PM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH 01/11] ixgbe: Return error on failure to
> allocate mac_table
> 
> Add a check to make certain mac_table was actually allocated and is not NULL.
> If it is NULL return -ENOMEM and allow the probe routine to fail rather then
> causing a NULL pointer dereference further down the line.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>

