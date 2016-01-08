From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Fri, 8 Jan 2016 01:31:27 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: do not call check_link for
 ethtool in ixgbe_get_settings()
In-Reply-To: <20151203232006.23658.24160.stgit@localhost6.localdomain6>
References: <20151203232006.23658.24160.stgit@localhost6.localdomain6>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180D13FFB@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Thursday, December 03, 2015 3:20 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: do not call check_link for ethtool in
> ixgbe_get_settings()
> 
> In ixgbe_get_settings() the link status and speed of the interface are determined
> based on a read from the LINKS register via the call to mac.ops.check.link(). This
> can cause issues where external drivers may end up with unknown speed when
> calling ethtool_get_setings().
> 
> Instead of calling the mac.ops.check_link() we can report the speed from the
> adapter structure which is populated by the driver.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
