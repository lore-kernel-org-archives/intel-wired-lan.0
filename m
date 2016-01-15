From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Fri, 15 Jan 2016 16:20:36 +0000
Subject: [Intel-wired-lan] [next PATCH 2/2] ixgbe: Avoid adding VLAN 0
 twice	to VLVF and VFTA
In-Reply-To: <20160107064850.12239.83914.stgit@localhost.localdomain>
References: <20160107064516.12239.98349.stgit@localhost.localdomain>
 <20160107064850.12239.83914.stgit@localhost.localdomain>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180D17554@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Wednesday, January 06, 2016 10:49 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH 2/2] ixgbe: Avoid adding VLAN 0 twice to
> VLVF and VFTA
> 
> We were adding VLAN 0 twice each time we restored the VLAN configuration.
> Instead of doing it twice we can just start working through the active VLANs
> from ID 1 on and skip the double write.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
