From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Wed, 13 Jan 2016 19:00:10 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: Extend trust to
	allow	guest to set unicast address
In-Reply-To: <1451669660-3628-1-git-send-email-3chas3@gmail.com>
References: <1451669660-3628-1-git-send-email-3chas3@gmail.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180D16368@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Chas Williams
> Sent: Friday, January 01, 2016 9:34 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: Extend trust to allow guest to
> set unicast address
> 
> When running certain routing protocols like VRRP, VF guests need the ability to
> set the unicast address of the interface.  Extend the new ndo trust feature to let
> the hypervisor trust a guest to set/update its own unicast address.
> 
> Signed-off-by: Chas Williams <3chas3@gmail.com>
> ---

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
