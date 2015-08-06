From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Thu, 6 Aug 2015 17:39:33 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Resolve "initialized
	field	overwritten" warnings
In-Reply-To: <20150729230038.55713.326.stgit@mdrustad-wks.jf.intel.com>
References: <20150729230038.55713.326.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180B9DDD5@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Wednesday, July 29, 2015 4:01 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Resolve "initialized field overwritten"
> warnings
> 
> Resolve warnings resulting from redundant initialization of the get_bus_info
> field in the mac_ops_X550* structures.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>

