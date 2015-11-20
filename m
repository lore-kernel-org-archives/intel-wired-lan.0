From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Fri, 20 Nov 2015 19:35:06 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Always turn phy power on
	when	requested
In-Reply-To: <20151105190214.4418.67222.stgit@mdrustad-wks.jf.intel.com>
References: <20151105190214.4418.67222.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180C1CA4D@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Thursday, November 05, 2015 11:02 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Always turn phy power on when
> requested
> 
> Instead of inhibiting phy power control when manageability is present, only
> inhibit turning phy power off when manageability is present. Consequently, phy
> power will always be turned on when requested. Without this patch, some
> systems with X540 or X550 devices in some conditions will never get link.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
